Message-ID: <4EBB90C1.7050309@domain.hid>
Date: Thu, 10 Nov 2011 09:52:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>
In-Reply-To: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 11/10/2011 12:37 AM, Terry Fryar wrote:
> Using 2.6.38 omap kernel on beagleboard xm-c, with 2.5.6 Xenomai and 2.6.38
> adeos patch.  Adeos patches went through with no errors.  I do have a
> "tweaked" omap3 board file (gpio's and such), but this is a pretty
> straightforward kernel (PREEMPT, no power mgmt, no SMP).  Using Codesourcery
> 2010.09-50 as tool chain on host.
>  
> Looks like the kernel is ok on boot:
>  
> [    0.969854] I-pipe: Domain Xenomai registered.
> [    0.969900] Xenomai: hal/arm started.
> [    0.971906] Xenomai: scheduling class idle registered.
> [    0.971937] Xenomai: scheduling class rt registered.
> [    1.026001] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> [    1.026763] Xenomai: starting native API services.
> [    1.027046] Xenomai: starting RTDM services.
> 
>  
> If I try to run "latency", or some of the other test programs I get a
> segfault.  GDB says it's getting a signal SIGXCPU??
>  
> Been through the kernel .config many, many times!  Not sure where to go from
> here?   Any suggestions?

Please post your .config.

-- 
                                                                Gilles.

