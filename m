From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D9F2804.5030205@domain.hid>
References: <4D9F2804.5030205@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Apr 2011 15:36:40 +0200
Message-ID: <1302529000.2054.344.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] ADEOS NIOS II port - definitions in
 include/asm-nios2/ipipe.h
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Martin Elshuber <martine@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2011-04-08 at 17:21 +0200, Martin Elshuber wrote:
> Hello,
> 
> I faced a problem with Xenomai xntimer when using the
> http://download.gna.org/adeos/patches/v2.6/nios2/adeos-ipipe-2.6.30-nios2-1.2-00.patch
> patch.
> 
> xntimer uses the ipipe abstractions for hrclock and hrtimer and relies 
> on the constants
> 
> #define __ipipe_hrtimer_freq    1000000 /* 1 us */
> #define __ipipe_hrclock_freq    nasys_clock_freq
> 
> defined in include/asm-nios2/ipipe.h to do a final adjustment.
> 
> The two definitions above will fail, if either the hrtimer is not 
> clocked with 1Mhz, or
> the hrclock is clocked with another frequency than nasys_clock_freq.
> I am quite new to ADEOS, but guess that
> 
> #define __ipipe_hrtimer_freq    na_hrtimer_clock_freq
> #define __ipipe_hrclock_freq    na_hrclock_clock_freq
> 
> is a better choice. At least for me this solves the problem.

Agreed, this was sloppy, only fitting the DE2 I used for porting Xenomai
over nios2 mmu-less, and I was just about to propagate this bug to the
next patch...

Yet another set of macro is involved (instead of na_*) with the new
design I've been using lately for the nio2mmu port over 2.6.35, but at
least they are consistent this time, wrt hrtimer/hrclock settings.
Thanks for the heads up.

> 
> Martin Elshuber
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



