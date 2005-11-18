Message-ID: <20051118090703.57135.qmail@domain.hid>
Date: Fri, 18 Nov 2005 01:07:03 -0800 (PST)
From: Cedric Herreman <glocker50@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1696470112-1132304823=:56929"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] 2.6 kernel module with math functions
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

--0-1696470112-1132304823=:56929
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,
 
 I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6. I used some basic math functions in the original module. This is posing problems for me now.
 
 In the module source i include <math.h>. I add -I/usr/include to the compiler flags and also "-ffast-math -mhard-float".
 
 If i compile this, i get warnings about double definitions of "__attribute_pure__" and "__attribute_used__".
 
 If i insert the kernel module, i get an error message :
 "Xenomai: Invalid use of FPU in Xenomai context at " + probably the address of the instruction where the math function is called.
 
 Can anyone give me a hint ? Thanks.
 
 This is the makefile  :
 
 obj-m    := rt_canio.o
 
 XENODIR = /usr/realtime
 
 KDIR    := /lib/modules/2.6.13.3/build
 PWD    := $(shell pwd)
 
 EXTRA_CFLAGS := -I$(XENODIR)/include -I/usr/include -ffast-math -mhard-float 
 
 all:
     $(MAKE) -C $(KDIR) M=$(PWD) modules
 
 clean:
     $(MAKE) -C $(KDIR) M=$(PWD) clean
 
 

		
---------------------------------
 Yahoo! FareChase - Search multiple travel sites in one click.  
--0-1696470112-1132304823=:56929
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">Hello,<br> <br> I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6. I used some basic math functions in the original module. This is posing problems for me now.<br> <br> In the module source i include &lt;math.h&gt;. I add -I/usr/include to the compiler flags and also "-ffast-math -mhard-float".<br> <br> If i compile this, i get warnings about double definitions of "__attribute_pure__" and "__attribute_used__".<br> <br> If i insert the kernel module, i get an error message :<br> "Xenomai: Invalid use of FPU in Xenomai context at " + probably the address of the instruction where the math function is called.<br> <br> Can anyone give me a hint ? Thanks.<br> <br> This is the makefile&nbsp; :<br> <br> obj-m&nbsp;&nbsp;&nbsp; := rt_canio.o<br> <br> XENODIR = /usr/realtime<br> <br> KDIR&nbsp;&nbsp;&nbsp; := /lib/modules/2.6.13.3/build<br> PWD&nbsp;&nbsp;&nbsp; := $(shell pwd)<br> <br> EXTRA_CFLAGS := -I$(XENODIR)/include -I/usr/include -ffast-math
 -mhard-float <br> <br> all:<br> &nbsp;&nbsp;&nbsp; $(MAKE) -C $(KDIR) M=$(PWD) modules<br> <br> clean:<br> &nbsp;&nbsp;&nbsp; $(MAKE) -C $(KDIR) M=$(PWD) clean<br> <br> </div><p>
		<hr size=1> <a href="http://us.lrd.yahoo.com/_ylc=X3oDMTFqODRtdXQ4BF9TAzMyOTc1MDIEX3MDOTY2ODgxNjkEcG9zAzEEc2VjA21haWwtZm9vdGVyBHNsawNmYw--/SIG=110oav78o/**http%3a//farechase.yahoo.com/">Yahoo! FareChase - Search multiple travel sites in one click.</a>

 

 
--0-1696470112-1132304823=:56929--

