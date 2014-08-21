MIME-Version: 1.0
Date: Thu, 21 Aug 2014 10:07:47 +0200
Message-ID: <CA+gf3TLTW-ujOD3zdM5eOocV3YsBfjog1N9yHfWs354cfu0j1w@mail.gmail.com>
From: Valdo Gentile <valdo.gentile@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I'm trying to install Xenomai on a Raspberri Pi,
distribution Raspbian 2014-01-07,
linux kernel 3.10.29
Xenomai 2.6.3
ipipe patch 3.10 (from memory, if there is a way to check it out now
confirm).

Traduttore
The point is that I seem to have some problems,
first of all I have no way to enable the option CONFIG_IPIPE_ARM_KUSER_TSC,
which seems necessary to have defined the function
unsigned long long __ipipe_mach_get_tsc (void)

I wondered then what is it and what the CONFIG_IPIPE_ARM_KUSER_TSC
configuration will do.

Regardless, I tried to compile equally by introducing a function
__ipipe_mach_get_tsc placeholder, which returns 0.

I have done this, then I can compile the kernel but I seem to have problems
at
the initialization of Xenomai.
In particular in the file ./kernel/ipipe/timer.c,
in the function ipipe_select_timers, the first call to
__ipipe_hrclock_ok() returns failure, I've seen be hardwired to 0 if it is
not
defined the CONFIG_IPIPE_ARM_KUSER_TSC.
Forcing the return of the above function to 1 then the problem is
the next cycle "list_for_each_entry(t, &timers, link)": timers has no
enties,
and thus the function tells me not to be able to select a timer and then
unable to proceed with the initialization of Xenomai.

I finally tried to bypass the whole going to comment in
rthal_arch_init the first call to rthal_tickdev_select so that the execution
can continue: at the end, I get another error that tells me that the timer
frequencyis equal to 0.

I'm probably wrong in trying to fix the code in this way
and perhaps I'm missing some fundamental knowledge about how Xenomai
attaches to the timings in the case of Raspberry Pi.


I would be enormously grateful if you could give me some suggestions.

Thank you very much
Valdo
