Message-ID: <53F5C7EF.7060807@xenomai.org>
Date: Thu, 21 Aug 2014 12:20:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+gf3TLTW-ujOD3zdM5eOocV3YsBfjog1N9yHfWs354cfu0j1w@mail.gmail.com>
In-Reply-To: <CA+gf3TLTW-ujOD3zdM5eOocV3YsBfjog1N9yHfWs354cfu0j1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Valdo Gentile <valdo.gentile@gmail.com>, xenomai@xenomai.org

On 08/21/2014 10:07 AM, Valdo Gentile wrote:
> Hello,
> I'm trying to install Xenomai on a Raspberri Pi,
> distribution Raspbian 2014-01-07,
> linux kernel 3.10.29
> Xenomai 2.6.3
> ipipe patch 3.10 (from memory, if there is a way to check it out now
> confirm).
> 
> Traduttore
> The point is that I seem to have some problems,
> first of all I have no way to enable the option CONFIG_IPIPE_ARM_KUSER_TSC,
> which seems necessary to have defined the function
> unsigned long long __ipipe_mach_get_tsc (void)
> 
> I wondered then what is it and what the CONFIG_IPIPE_ARM_KUSER_TSC
> configuration will do.
> 
> Regardless, I tried to compile equally by introducing a function
> __ipipe_mach_get_tsc placeholder, which returns 0.
> 
> I have done this, then I can compile the kernel but I seem to have problems
> at
> the initialization of Xenomai.
> In particular in the file ./kernel/ipipe/timer.c,
> in the function ipipe_select_timers, the first call to
> __ipipe_hrclock_ok() returns failure, I've seen be hardwired to 0 if it is
> not
> defined the CONFIG_IPIPE_ARM_KUSER_TSC.
> Forcing the return of the above function to 1 then the problem is
> the next cycle "list_for_each_entry(t, &timers, link)": timers has no
> enties,
> and thus the function tells me not to be able to select a timer and then
> unable to proceed with the initialization of Xenomai.
> 
> I finally tried to bypass the whole going to comment in
> rthal_arch_init the first call to rthal_tickdev_select so that the execution
> can continue: at the end, I get another error that tells me that the timer
> frequencyis equal to 0.
> 
> I'm probably wrong in trying to fix the code in this way
> and perhaps I'm missing some fundamental knowledge about how Xenomai
> attaches to the timings in the case of Raspberry Pi.

Yes, your problem is that no I-pipe patch supports Raspberry Pi
directly, in particular no high resolution counter and no hardware timer
are registered. If you want to run Xenomai on Raspberry Pi for Linux
3.8, you should use the pre- and post- patches in the
ksrc/arch/arm/patches/raspberry directory in Xenomai sources, see
ksrc/arch/arm/patches/README. If you want to run Xenomai on a different
kernel, you will have to generate pre- and post- patches for that kernel
yourself. Porting Xenomai to a new ARM SOC is described here:
http://xenomai.org/2014/06/porting-xenomai-to-a-new-arm-soc/


-- 
                                                                Gilles.

