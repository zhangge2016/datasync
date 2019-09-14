#!/usr/bin/env python
# -*- coding: UTF-8 -*-

from sqlalchemy import create_engine

class QuerypkOperation(object):
    
    def __init__(self, schema, database, table, config):
        self.config = config
        self.schema=schema
        self.database=database
        self.table=table
       
    def operate(self):
        cols, pk = self.query_pg_msg()
        self.drop_snappydata_table()
        self.create_snappydata_database()
        ddl = self.create_snappydata_ddl(cols=cols, pk=pk)
        self.exec_snappydata_sql(ddl)

    def query_pg_msg(self):
        """
        select pg's columns and pk
        :param database:
        :param table:
        :return: cols, pk
        """
        try:
            # get pg connect
            engine = create_engine('%s/%s' % (self.config['pg_uri'], self.database))
            conn = engine.connect()

            # get all columns
            cols_sql = "SELECT column_name,data_type,is_nullable,character_maximum_length " \
                       "FROM information_schema.columns " \
                       "WHERE table_schema='%s' AND table_name='%s';" % (self.schema, self.table)
            cols = conn.execute(cols_sql).fetchall()

            # # get pg table's pk
            pk_sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE " \
                     "WHERE table_schema='%s' AND table_name='%s';" \
                     % (self.schema, self.table)
            pk = conn.execute(pk_sql).fetchall()
            
            if len(pk) == 0:
                print ("pg中表%s主键不存在，未能生成建表语句" % self.table)
                raise Exception
            pk = pk[0][0]

            return cols, pk
        except Exception as e:
            print (e)
        finally:
            conn.close()

    def drop_snappydata_table(self):
        """
        :param database:
        :param table:
        """
        # drop table if exist
        drop_sql = "DROP TABLE IF EXISTS %s.%s;" % (self.database, self.table)
        print (drop_sql)
        self.exec_snappydata_sql(drop_sql)

    def create_snappydata_database(self):
        """
        :param database:
        :param table:
        """
        # drop table if exist
        drop_sql = "CREATE DATABASE IF NOT EXISTS %s;" % (self.database)
        self.exec_snappydata_sql(drop_sql)

    def create_snappydata_ddl(self, cols, pk):
        """
        create ddl from info(cols, pk)
        :param database:
        :param table:
        :param cols:
        :param pk:
        :return: ddl
        """
        print (cols)
        # create snappydata ddl
        sd_cols_sql = "CREATE TABLE %s.%s( " % (self.database, self.table)
        for col in cols:
            col_name = col[0]
            # TODO 要考虑字段类型，如果为varchar（20）明确指出长度的，就使用现有的长度
            col_type = col[1] if col[1] not in ['character varying', 'character'] else self.get_map_col(col[1], col[3])
            col_null = "NOT NULL" if col[2] == 'NO' else ""
            sd_cols_sql += "%s %s %s %s," % (col_name, col_type, col_null, "PRIMARY KEY" if col_name == pk else '')
        sd_sql = sd_cols_sql[:-1] + ");"
        return sd_sql

    def get_map_col(self, col, length):
        """
        pg and snappydata mapping
        :param col:
        :param length:
        :return:
        """
        col_res = ""
        if col == 'character varying':
            col_res = 'varchar'
        elif col == 'character':
            col_res = 'char'
        return col_res + "(" + str(length) + ")"

    def exec_snappydata_sql(self, sql):
        """
        execute sql in snappydata
        :param sql:
        :return:
        """
        from pysnappydata import snappydata
        host=str(self.config['snappydata_host'])
        port=int(self.config['snappydata_port'])
        cursor = snappydata.connect(host,port).cursor()
        try:
            cursor.execute(sql)
        except Exception as e:
            print (e)
        finally:
            cursor.close()

