Message-ID: <44E955E0.40009@domain.hid>
Date: Mon, 21 Aug 2006 00:42:40 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44E91231.8070403@domain.hid>
In-Reply-To: <44E91231.8070403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: xeno-load: line 182: 2794 Floating point
 exception$suflag $* $cmdargs
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
>
>
> *
> == Sampling period: 10 us
> == Do not interrupt this program
> /usr/xenomai/bin/xeno-load: line 182:  2868 Floating point 
> exception$suflag $* $cmdargs
>


soekris:/usr/xenomai/bin# gdb ../testsuite/switchbench/switchbench
GNU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...(no debugging symbols found)
Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb)
(gdb) run -p 10 -n -l 1000
Starting program: /usr/xenomai/testsuite/switchbench/switchbench -p 10 
-n -l 1000
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread -1210206528 (LWP 2070)]
(no debugging symbols found)
(no debugging symbols found)
== Sampling period: 10 us
== Do not interrupt this program
[New Thread -1210209360 (LWP 2073)]

Program received signal SIGFPE, Arithmetic exception.
[Switching to Thread -1210209360 (LWP 2073)]
0x0804acc7 in __divdi3 ()
(gdb)


I tried stuffing -g into all *_CFLAGS in src/testsuite/Makefile,
but I couldnt get it to show up in the compilation.

Any hints ?

