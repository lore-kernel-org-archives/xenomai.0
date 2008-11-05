Message-ID: <4911EB52.2010104@domain.hid>
Date: Wed, 05 Nov 2008 19:52:02 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <490F0C59.9060506@domain.hid> <490F0D1E.3080509@domain.hid>
	<491004C8.8040406@domain.hid> <49101EBE.9090007@domain.hid>
	<49102216.9030207@domain.hid> <49103A9A.2080703@domain.hid>
	<49103EE8.6090000@domain.hid> <4910424C.1030302@domain.hid>
	<4910565A.8020503@domain.hid>
In-Reply-To: <4910565A.8020503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using Xenomai in early boot phase.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> Philippe Gerum wrote:
>>> Wolfgang Grandegger wrote:
>>>> Philippe Gerum wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> Wolfgang Grandegger wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> I want to use a Xenomai task overtaking the duties of a watchdog running
>>>>>>>>> under Linux as soon as the Xenomai layer is available during boot up. Is
>>>>>>>>>   there a function or variable I could inspect? With 2.3.x, I called
>>>>>>>>> rtdm_init_task() until it returned without error but with 2.4.x it
>>>>>>>>> results in a kernel crash :-(.
>>>>>>>>>
>>>>>>>> What is the value of CONFIG_XENO_OPT_SYS_STACKPOOLSZ?
>>>>>>>   #
>>>>>>>   # Nucleus options
>>>>>>>   #
>>>>>>>   CONFIG_XENO_OPT_PERVASIVE=y
>>>>>>>   CONFIG_XENO_OPT_SYS_STACKPOOLSZ=32
>>>>>>>   # CONFIG_XENO_OPT_PRIOCPL is not set
>>>>>>>   CONFIG_XENO_OPT_PIPE=y
>>>>>> Some more input on that issue. Here is the oops and the NIP location:
>>>>>>
>>>>>> XLB Arb cnf: 8000a006
>>>>>> mpc5xxx_ide: Setting up IDE interface ide0...
>>>>>> Probing IDE interface ide0...
>>>>>> Oops: kernel access of bad area, sig: 11
>>>>>> NIP: C0113364 XER: 20000000 LR: C0113320 SP: C047DB30 REGS: c047da80 TRAP: 0300    Not tainted
>>>>>> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>>>>>> DAR: 0000003C, DSISR: 20000000
>>>>>> TASK = c047c000[1] 'swapper' Last syscall: 120
>>>>>> last math 00000000 last altivec 00000000
>>>>>> GPR00: 00000003 C047DB30 C047C000 00000009 FFFFFFF7 C01CF395 C0220000 00000000
>>>>>> GPR08: 00000038 C01ECC00 C02445F4 00000000 00000000 100803B0 07FCF000 08099000
>>>>>> GPR16: C0220000 FFFFFF7F C0230000 FFF75F97 C022B3C0 00000000 C01ECC0C C0230000
>>>>>> GPR24: 00000000 00000000 00000010 C02446F4 3B9A0000 00000000 00000000 C0244590
>>>>>> Call backtrace:
>>>>>> C0113320 C0111F00 C010DD0C C013D810 C00DA48C C001EAB4 C001A70C
>>>>>> C001A598 C001A254 C00079C0 C000D63C C0024C50 C00243AC C000D298
>>>>>> C000D508 C0005CF4 0039FBC0 C00F0A4C C00F0EA0 C00F15C0 C00F210C
>>>>>> C02149C8 C0214A14 C020A64C C00039A0 C0008678
>>>>>> Kernel panic: Aiee, killing interrupt handler!
>>>>>> In interrupt handler - not syncing
>>>>>>  <0>Rebooting in 180 seconds..
>>>>>>
>>>>>> $ ppc_6xx-gdb vmlinux:
>>>>>> ...
>>>>>> (gdb) l *0xC0113364
>>>>>> 0xc0113364 is in __xntimer_init (queue.h:51).
>>>>>> 46              holder->last = holder;
>>>>>> 47              holder->next = holder;
>>>>>> 48      }
>>>>>> 49
>>>>>> 50      static inline void ath(xnholder_t *head, xnholder_t *holder)
>>>>>> 51      {
>>>>>> 52              /* Inserts the new element right after the heading one  */
>>>>>> 53              holder->last = head;
>>>>>> 54              holder->next = head->next;
>>>>>> 55              holder->next->last = holder;
>>>>>>
>>>>>> Wolfgang.
>>>>>>
>>>>> Thanks. Could you send me the full boot log until the oops occurs as well? TIA,
>>>> Ses below. As mentioned earlier, rtdm_task_init() is called early before the
>>>> Xenomai sub-system gets initialized.
>>>>
>>> The point is, how much earlier, and as a matter of fact, at least one skin
>>> should have initialized before any service creating a Xenomai task could be
>>> invoked, like rtdm_task_init(). As you mentioned and from your boot log, not
>>> even the nucleus was started, so I don't understand how this could have ever
>>> worked with any Xenomai version actually (the gist of the matter is that we
>> Maybe just pure luck ;-). At least rtdm_task_init() did not crash and
>> even return an error under Xenomai 2.3.5 and Linux 2.4.25.
>>
> 
> With v2.3.x, it would really depend on the random memory contents the main
> allocator would use as its internal descriptor for setting up the task stack.
> v2.4.x does not use the main allocator but a specific stack pool instead; this
> might be the reason why you can't be lucky anymore.
> 
>>> don't have the internal allocator set up for grabbing stack memory for the new
>>> task at that point). You may want to make your task creation routine a
>>> late_initcall to fix this.
>> It's actually called from the watchdog driver, which needs to be trigger
>> early. Is there a function or variable telling that the Xenomai layer is
>> initialized.
> 
> xnpod_active_p().

It does not work but testing the global variable "rtdm_initialzed" does:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/module.c#096

Here is a code snippet to make the intended usage in the Linux watchdog
driver clear:

	if (!hw_wdt_rt_active) {
		hw_wdt_restart();
		if (rtdm_initialised) {
			/* hw_wdt_rt_task() will overtake the duty of 
			   restarting the watchdog */
			err = rtdm_task_init(&hw_wdt_rt_task, "rt-watchdog",
					     hw_wdt_rt_func, NULL, prio,
					     timer_period);
			if (err) {
				printk("WDT: rtdm_task_init failed (err=%d)\n",
				       err);
			} else {
				hw_wdt_rt_active = 1;
				printk("WDT: rt-watchdog started\n");
			}
		}
	}

Hope I did not misuse "rtdm_initialzed"!?

Wolfgang.

