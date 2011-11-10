From: "Terry Fryar" <terry.fryar@domain.hid>
References: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>
	<4EBB9104.2040203@domain.hid>
In-Reply-To: <4EBB9104.2040203@domain.hid>
Date: Thu, 10 Nov 2011 14:09:50 -0600
Message-ID: <11B729797A9E4CD7AF3075EF6A450D57@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai test progs segfault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2.6.0 worked fine with 2.6.38, although I did get this:

[    4.900113] WARNING: at kernel/lockdep.c:2321 omap3_pm_idle+0x78/0x84()
[    4.907076] Modules linked in:
[    4.910532] [<c00572ac>] (unwind_backtrace+0x0/0xe0) from [<c0081164>]
(warn_slowpath_common+0x4c/0x64)
[    4.920564] [<c0081164>] (warn_slowpath_common+0x4c/0x64) from
[<c0081194>] (warn_slowpath_null+0x18/0x1c)
[    4.930865] [<c0081194>] (warn_slowpath_null+0x18/0x1c) from [<c0064268>]
(omap3_pm_idle+0x78/0x84)
[    4.940508] [<c0064268>] (omap3_pm_idle+0x78/0x84) from [<c005241c>]
(cpu_idle+0x6c/0xe4)
[    4.949116] [<c005241c>] (cpu_idle+0x6c/0xe4) from [<c00088bc>]
(start_kernel+0x2b0/0x30c)
[    4.957941] [<c00088bc>] (start_kernel+0x2b0/0x30c) from [<80008034>]
(0x80008034) 

Not sure what's up here, but the xenomai kernel stuff loaded and the xenomai
test programs work just fine now.  I'm partially wondering if there were
mis-matched floating point compiler flags involved as well (2.6.0 doesn't
force any flags now).

Thanks Gilles...your help is MUCH appreciated!


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Thursday, November 10, 2011 2:53 AM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai test progs segfault

On 11/10/2011 12:37 AM, Terry Fryar wrote:
> Using 2.6.38 omap kernel on beagleboard xm-c, with 2.5.6 Xenomai and 
> 2.6.38 adeos patch.  Adeos patches went through with no errors.  I do 
> have a "tweaked" omap3 board file (gpio's and such), but this is a 
> pretty straightforward kernel (PREEMPT, no power mgmt, no SMP).  Using 
> Codesourcery 2010.09-50 as tool chain on host.
>  
> Looks like the kernel is ok on boot:
>  
> [    0.969854] I-pipe: Domain Xenomai registered.
> [    0.969900] Xenomai: hal/arm started.
> [    0.971906] Xenomai: scheduling class idle registered.
> [    0.971937] Xenomai: scheduling class rt registered.
> [    1.026001] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards)
loaded.
> [    1.026763] Xenomai: starting native API services.
> [    1.027046] Xenomai: starting RTDM services.
> 
>  
> If I try to run "latency", or some of the other test programs I get a 
> segfault.  GDB says it's getting a signal SIGXCPU??
>  
> Been through the kernel .config many, many times!  Not sure where to go
from
> here?   Any suggestions?

Ah, sorry, xenomai 2.5.6 does not support linux 2.6.38 on arm. You need
xenomai 2.6.0. In case 2.5.6 was a typo and you were already using 2.6.0,
please post your .config.

>  
> Thanks!
>  
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
                                                                Gilles.


