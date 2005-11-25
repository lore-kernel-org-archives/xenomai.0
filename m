Message-ID: <4386DBD1.90605@domain.hid>
Date: Fri, 25 Nov 2005 10:39:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 2.6 kernel module with math functions
References: <20051125093348.40193.qmail@domain.hid>
In-Reply-To: <20051125093348.40193.qmail@domain.hid>
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
To: Cedric Herreman <glocker50@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Cedric Herreman wrote:
> OK,
> 
> I made an extra math module, copying some of the source code from newlib 
> for the functions i needed. It works.
> 
> Another question : if i create an application (in stead of kernel 
> module) that starts a real time thread. Can i then use math functions 
> inside the real time running part ?
> 
> In the latency example, the sqrt function is used for displaying the 
> results of the latency test.  This is outside the real time task. Is it 
> possible to use this call in the real time function ? Or any other 
> library function (that is not performing system calls) ?
>

Yes. RT threads in user-space have their own FPU context managed by Xenomai.

> Cedric.
> 
> */Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>/* wrote:
> 
>     Cedric Herreman wrote:
>      > Hello,
>      >
>      > I am porting a 2.4 RTAI kernel module to Xenomai 2.0 kernel 2.6.
>     I used some basic math functions in the original module. This is
>     posing problems for me now.
>      >
>      > In the module source i include . I add -I/usr/include to the
>     compiler flags and also "-ffast-math -mhard-float".
>      >
>      > If i compile this, i get warnings about double definitions of
>     "__attribute_pure__" and "__attribute_used__".
>      >
>      > If i insert the kernel module, i get an error message :
>      > "Xenomai: Invalid use of FPU in Xenomai context at " + probably
>     the address of the instruction where the math function is called.
>      >
>      > Can anyone give me a hint ? Thanks.
> 
>     You can only use floating point operations from real-time threads
>     contexts, not from module initialization and finalization routines, and
>     you have to signal Xenomai, when creating kernel space real-time
>     threads, that the thread will be allowed to use FPU. For the RTAI skin,
>     this is what the rt_task_init function 6th argument is for.
> 
>     There is currently no math library module in Xenomai. So, the answer is
>     that you have to avoid math functions, or make a xeno_math module, the
>     way it is done in RTAI, i.e. using a math library such as the one made
>     by Sun and used by FreeBSD, or one among the various libcs available.
>     We once discussed this with Philippe, and a good candidate seemed to be
>     newlib at that time:
> 
>     http://sourceware.org/newlib/
> 
>     Looking at newlib sources, it seems that some of its contents come from
>     the Sun library too.
> 
>     -- 
> 
> 
>     Gilles Chanteperdrix.
> 
> 
> ------------------------------------------------------------------------
> Yahoo! Music Unlimited - Access over 1 million songs. Try it free. 
> <http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=36035/*http://music.yahoo.com/unlimited/> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

