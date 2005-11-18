From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] 2.6 kernel module with math functions
In-Reply-To: <20051118090703.57135.qmail@domain.hid>
References: <20051118090703.57135.qmail@domain.hid>
Message-Id: <E1Ed69H-0002kJ-J2@domain.hid>
Date: Fri, 18 Nov 2005 14:19:27 +0100
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cedric Herreman <glocker50@domain.hid>
Cc: xenomai@xenomai.org

Cedric Herreman wrote:
 > Hello,
 >  
 >  I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6. I used some basic math functions in the original module. This is posing problems for me now.
 >  
 >  In the module source i include <math.h>. I add -I/usr/include to the compiler flags and also "-ffast-math -mhard-float".
 >  
 >  If i compile this, i get warnings about double definitions of "__attribute_pure__" and "__attribute_used__".
 >  
 >  If i insert the kernel module, i get an error message :
 >  "Xenomai: Invalid use of FPU in Xenomai context at " + probably the address of the instruction where the math function is called.
 >  
 >  Can anyone give me a hint ? Thanks.

You can only use floating point operations from real-time threads
contexts, not from module initialization and finalization routines, and
you have to signal Xenomai, when creating kernel space real-time
threads, that the thread will be allowed to use FPU. For the RTAI skin,
this is what the rt_task_init function 6th argument is for.

There is currently no math library module in Xenomai. So, the answer is
that you have to avoid math functions, or make a xeno_math module, the
way it is done in RTAI, i.e. using a math library such as the one made
by Sun and used by FreeBSD, or one among the various libcs available.
We once discussed this with Philippe, and a good candidate seemed to be
newlib at that time:

http://sourceware.org/newlib/

Looking at newlib sources, it seems that some of its contents come from
the Sun library too.

-- 


					    Gilles Chanteperdrix.

