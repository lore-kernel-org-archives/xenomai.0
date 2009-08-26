From: Christoph Permes <christoph.permes@domain.hid>
Date: Wed, 26 Aug 2009 10:01:41 +0200
Message-Id: <1251273701.4345.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Xenomai-help] Segmentation fault in rt_printf print thread
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

Hi, 

I'm using rt_printf for debug output. When running tests for 20 hours or
longer, sometimes I get a segmentation fault.

The backtrace shows:
#0  0xb7d008d8 in fputs () from /lib/libc.so.6
#1  0xb7f26f61 in print_buffers () from /usr/xenomai/lib/librtdk.so.0
#2  0xb7f26fb3 in printer_loop () from /usr/xenomai/lib/librtdk.so.0
#3  0xb7c92f3b in start_thread () from /lib/libpthread.so.0
#4  0xb7d6fb6e in clone () from /lib/libc.so.6

It seems to me that there is a bug in the print thread.

My program runs on x86 using the following software versions:
Kernel 2.6.29.5
Xenomai 2.4.9
I-Pipe patch: adeos-ipipe-2.6.29.5-x86-2.4-02.patch


Thanks, 
Christoph



