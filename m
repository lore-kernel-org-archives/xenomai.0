Message-ID: <44F84C23.9070105@domain.hid>
Date: Fri, 01 Sep 2006 10:05:07 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
References: <44F6E774.2000701@domain.hid>	<44F72F35.4070109@domain.hid>	<44F75C54.90608@domain.hid>
	<17655.28122.163232.842311@domain.hid>
In-Reply-To: <17655.28122.163232.842311@domain.hid>
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

Gilles Chanteperdrix wrote:
> Jeff Webb wrote:
>  > Now, I am setting up a new machine to start the more serious work of
>  > porting our existing rtlinux simulation to xenomai.  The new machine
>  > is an Athlon64 X2 processor running Fedora Core 5.  I realize that
>  > the x86_64 architecture is not supported, so I installed the 32-bit
>  > version of FC5 on a second partition for use with xenomai.  I
>  > attempted to compile a xenomai-patched SMP kernel using my 32-bit OS,
>  > but got a kernel panic when I tried to boot it.  After much fiddling
>  > with config options, I discovered that if I disable SMP, the kernel
>  > will boot fine, and the xenomai latency test appears to give good
>  > results.  This is a good sign, but I would obviously prefer to use my
>  > second processor, if possible.  I am hoping someone on this list will
>  > be able to help me track down the problem. 
> 
> Do you have spinlock debugging enabled ? If yes, try turning it
> off. Could you also post your full .config ?

I compiled another kernel with the same .config, except with spinlock debugging turned off:

  $ grep -i spinloc /boot/config-2.6.17.7xenomai2.2.1
  # CONFIG_DEBUG_SPINLOCK is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set

I still get a very similar kernel panic with this build.  Do you see any other suspicious options in my .config that could cause problems with SMP on my processor?

Has anyone else tried running xenomai on an Athlon64 X2?

Thanks,

Jeff


