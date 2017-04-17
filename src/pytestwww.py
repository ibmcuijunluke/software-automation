#!/usr/bin/python
# coding: UTF-8
import StringIO,pycurl,sys,os,time

class idctest:
    def __init__(self):
          self.contents = ''
    def body_callback(self,buf):
          self.contents = self.contents + buf

def test_gzip(input_url):
    t = idctest()
    #gzip_test = file("gzip_test.txt", 'w')
    c = pycurl.Curl()
    c.setopt(pycurl.WRITEFUNCTION,t.body_callback)
    c.setopt(pycurl.ENCODING, 'gzip')
    c.setopt(pycurl.URL,input_url)
    c.setopt(pycurl.MAXREDIRS, 5)
    c.perform()

    http_code = c.getinfo(pycurl.HTTP_CODE)
    dns_resolve = c.getinfo(pycurl.NAMELOOKUP_TIME)
    http_conn_time = c.getinfo(pycurl.CONNECT_TIME)
    http_pre_trans = c.getinfo(pycurl.PRETRANSFER_TIME)
    http_start_trans = c.getinfo(pycurl.STARTTRANSFER_TIME)
    http_total_time = c.getinfo(pycurl.TOTAL_TIME)
    http_size_download = c.getinfo(pycurl.SIZE_DOWNLOAD)
    http_header_size = c.getinfo(pycurl.HEADER_SIZE)
    http_speed_downlaod = c.getinfo(pycurl.SPEED_DOWNLOAD)

    print 'HTTP Response Status: %d' %http_code
    print 'DNS Anylize Time:%.2f ms' %(dns_resolve*1000)
    print 'Connect Time is %.2f ms' %(http_conn_time*1000)
    print 'Ready transfer Time is %.2f ms' %(http_pre_trans*1000)
    print "Starting Trander Time is  %.2f ms" %(http_start_trans*1000)
    print "Ending Trander Time is  %.2f ms" %(http_total_time*1000)
    print "Download package size %d bytes/s" %http_size_download
    print "HTTP Header Size is %d bytes/s" %http_header_size
    print "Average Download Time is  %d k/s" %(http_speed_downlaod/1024)

if __name__ == '__main__':
   input_url = sys.argv[1]
   test_gzip(input_url)
