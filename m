Message-ID: <45119E68.9050608@domain.hid>
Date: Wed, 20 Sep 2006 15:02:48 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai v2.2.3
References: <1158564530.5020.5.camel@domain.hid> <450F1686.3010304@domain.hid>	
	<451068AD.6080000@domain.hid> <1158744278.5544.42.camel@domain.hid>	
	<451153D5.2080200@domain.hid> <1158768864.5043.31.camel@domain.hid>	
	<45118754.3000001@domain.hid> <1158777216.5043.46.camel@domain.hid>
In-Reply-To: <1158777216.5043.46.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
> Ok, that helps thanks. Now, running the latency test over GDB instead of
> using the "run" script would likely give us a backtrace for the
> segfault. I'd be interested to know where the latency application is
> sent the fault signal. E.g.
> 
> modprobe xeno_nucleus
> modprobe xeno_native
> (if needed)
> 
> then,
> 
> cd /usr/xenomai/testsuite/latency
> gdb latency
> r
> ...(SIGSEGV)...
> bt

If I just run latency, I get the segfault:

[root@domain.hid webb-ja]# cd /usr/xenomai/testsuite/latency/
[root@domain.hid latency]# /sbin/modprobe xeno_native
[root@domain.hid latency]# ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
Segmentation fault


If I try to run gdb on it, it just hangs when I type the "r" command:

[root@domain.hid webb-ja]# cd /usr/xenomai/testsuite/latency/
[root@domain.hid latency]# /sbin/modprobe xeno_native
[root@domain.hid latency]# gdb latency
GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...
(no debugging symbols found)...Using host libthread_db library "/lib/tls/libthread_db.so.1".
(gdb) r
Starting program: /usr/xenomai-2.2.3/testsuite/latency/latency
(no debugging symbols found)...[Thread debugging using libthread_db enabled]
Error while reading shared library symbols:
Cannot find new threads: generic error
(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...


At this point, the terminal is locked, and I have to use kill -9 from another terminal.  I did some googling on the error message and found this thread:

http://sources.redhat.com/ml/gdb/2005-04/msg00201.html

Any hints on what I am doing wrong?  Sorry, if I am doing something silly and don't realize it.

Thanks,

Jeff

