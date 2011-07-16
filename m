Message-ID: <4E215694.8000506@domain.hid>
Date: Sat, 16 Jul 2011 11:15:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid> <4E1C302A.8050309@domain.hid>
	<4E1C3301.2030203@domain.hid> <4E1C3672.1030104@domain.hid>
	<4E1C36EE.70803@domain.hid> <4E1C38CE.7090202@domain.hid>
	<4E1C3A5D.3020700@domain.hid> <4E1C44B4.50106@domain.hid>
	<4E1C8508.5010400@domain.hid> <4E1C858A.7070403@domain.hid>
	<4E1C86A1.6030707@domain.hid> <4E1C87BB.7000307@domain.hid>
	<4E1DE646.1090900@domain.hid> <4E1DEC58.4000901@domain.hid>
	<4E1DEE27.7030900@domain.hid> <4E1F581C.4050809@domain.hid>
	<4E2032EF.5030700@domain.hid> <4E203C55.3080605@domain.hid .de>
	<4E21483B.7050503@domain.hid> <1310806379.2154.418.camel@domain.hid >
In-Reply-To: <1310806379.2154.418.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-07-16 10:52, Philippe Gerum wrote:
> On Sat, 2011-07-16 at 10:13 +0200, Jan Kiszka wrote:
>> On 2011-07-15 15:10, Jan Kiszka wrote:
>>> But... right now it looks like we found our primary regression:
>>> "nucleus/shadow: shorten the uninterruptible path to secondary mode".
>>> It opens a short windows during relax where the migrated task may be
>>> active under both schedulers. We are currently evaluating a revert
>>> (looks good so far), and I need to work out my theory in more
>>> details.
>>
>> Looks like this commit just made a long-standing flaw in Xenomai's
>> interrupt handling more visible: We reschedule over the interrupt stack
>> in the Xenomai interrupt handler tails, at least on x86-64. Not sure if
>> other archs have interrupt stacks, the point is Xenomai's design wrongly
>> assumes there are no such things.
>
> Fortunately, no, this is not a design issue, no such assumption was ever
> made, but the Xenomai core expects this to be handled on a per-arch
> basis with the interrupt pipeline.

And that's already the problem: If Linux uses interrupt stacks, relying 
on ipipe to disable this during Xenomai interrupt handler execution is 
at best a workaround. A fragile one unless you increase the pre-thread 
stack size by the size of the interrupt stack. Lacking support for a 
generic rescheduling hook became a problem by the time Linux introduced 
interrupt threads.

> As you pointed out, there is no way
> to handle this via some generic Xenomai-only support.
>
> ppc64 now has separate interrupt stacks, which is why I disabled
> IRQSTACKS which became the builtin default at some point. Blackfin goes
> through a Xenomai-defined irq tail handler as well, because it may not
> reschedule over nested interrupt stacks.

How does this arch prevent that xnpod_schedule in the generic interrupt 
handler tail does its normal work?

> Fact is that such pending
> problem with x86_64 was overlooked since day #1 by /me.
>
>>   We were lucky so far that the values
>> saved on this shared stack were apparently "compatible", means we were
>> overwriting them with identical or harmless values. But that's no longer
>> true when interrupts are hitting us in the xnpod_suspend_thread path of
>> a relaxing shadow.
>>
>
> Makes sense. It would be better to find a solution that does not make
> the relax path uninterruptible again for a significant amount of time.
> On low end platforms we support (i.e. non-x86* mainly), this causes
> obvious latency spots.

I agree. Conceptually, the interruptible relaxation should be safe now 
after recent fixes.

>
>> Likely the only possible fix is establishing a reschedule hook for
>> Xenomai in the interrupt exit path after the original stack is restored
>> - - just like Linux works. Requires changes to both ipipe and Xenomai
>> unfortunately.
>
> __ipipe_run_irqtail() is in the I-pipe core for such purpose. If
> instantiated properly for x86_64, and paired with xnarch_escalate() for
> that arch as well, it could be an option for running the rescheduling
> procedure when safe.

Nope, that doesn't work. The stack is switched later in the return path 
in entry_64.S. We need a hook there, ideally a conditional one, 
controlled by some per-cpu variable that is set by Xenomai on return 
from its interrupt handlers to signal the rescheduling need.

Jan

