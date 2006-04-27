Message-ID: <44506B88.4080404@domain.hid>
Date: Thu, 27 Apr 2006 08:58:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running a UVM vxWorks application (missing
	mlockall?)
References: <200604262123.48618.niklaus.giger@domain.hid>
In-Reply-To: <200604262123.48618.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I get the following problem running my vxWorks based application
> Xenomai/uvm: real-time nucleus v2.2-dev (Engines Of Creation) loaded.
> Xenomai: process memory not locked (missing mlockall?)
> 
> Compiling and running koan_uvm under ksrc/skins/vxworks/demos is no problem, 
> e.g. I get 
> ng:/home/hcu/kernel/xenomai-head/ksrc/skins/vxworks/demos# ./koan_uvm
> Xenomai/uvm: real-time nucleus v2.2-dev (Engines Of Creation) loaded.
> starting VxWorks services.
> START ktest
> Entering TaskTest
> Time = 0 ms. (0 ns.)
> STOP ktest
> Time = 47 ms. (47121744 ns.)
> Time = 49 ms. (49999782 ns.)
> Time = 50 ms. (50001464 ns.)
> 
> If I start my application after running koan_uvm, it starts up without 
> problem. 
> 
> Has anybody an explanation for this problem here?
> 

Could you load your app over GDB, put a breakpoint in mlockall, and see 
whether the breakpoint is hit before the error is raised?

-- 

Philippe.

