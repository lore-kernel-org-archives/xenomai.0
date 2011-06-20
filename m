Message-ID: <4DFFA4C0.70000@domain.hid>
Date: Mon, 20 Jun 2011 21:51:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>	<4DFBA305.9000303@domain.hid>	<4DFC7C0E.1090700@domain.hid>	<4DFC9575.1030904@domain.hid>	<4DFC95B7.8070703@domain.hid>	<4DFCA09B.20609@domain.hid>	<4DFCA323.6030704@domain.hid>
	<4DFCA432.3070203@domain.hid>	<4DFCAF07.8020607@domain.hid>
	<4DFE189D.5030908@domain.hid>	<4DFF78AA.9050904@domain.hid>
	<4DFF8476.2000306@domain.hid> <4DFFA19C.30000@domain.hid>
	<4DFFA24F.4050601@domain.hid> <4DFFA27F.3020808@domain.hid>
In-Reply-To: <4DFFA27F.3020808@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/20/2011 09:41 PM, Jan Kiszka wrote:
> On 2011-06-20 21:41, Gilles Chanteperdrix wrote:
>> On 06/20/2011 09:38 PM, Jan Kiszka wrote:
>>> On 2011-06-20 19:33, Gilles Chanteperdrix wrote:
>>>> On 06/20/2011 06:43 PM, Jan Kiszka wrote:
>>>>> On 2011-06-19 17:41, Gilles Chanteperdrix wrote:
>>>>>> Merged your whole branch, but took the liberty to change it a bit
>>>>>> (replacing the commit concerning unlocked context switches with comments
>>>>>> changes only, and changing the commit about xntbase_tick).
>>>>>
>>>>> What makes splmax() redundant for the unlocked context switch case? IMO
>>>>> that bug is still present.
>>>>
>>>> No, the bug is between my keyboard and chair. On architectures with
>>>> unlocked context switches, the Linux task switch still happens with irqs
>>>> off, only the mm switch happens with irqs on.
>>>
>>> Then why do we call xnlock_get_irqsave in
>>> xnsched_finish_unlocked_switch? Why not simply xnlock_get if irqs are
>>> off anyway?
>>
>> Because of the Xenomai task switch, not the Linux task switch.
> 
> --verbose please.

There are two kind of task switches, switches between Linux tasks,
handled by Linux kernel function/macro/inline asm switch_to(). And those
between Xenomai tasks, handled by function/macro/inline asm
xnarch_switch_to().

Since a Linux kernel context switch may still be interrupted by a
(primary mode) interrupt which could decide to switch context, it can
not happen with interrupts enabled, due to the way it works (spill the
registers in a place relative to the SP, then change SP not atomically).

The Xenomai context switches have no such risk, so, they may happen with
irqs on, completely.

In case of relax, the two halves of context switches are not of the same
kind. The first half of the context switch is a Xenomai switch, but the
second half is the epilogue of a Linux context switch (which, by the
way, is why we need skipping all the house keeping in __xnpod_schedule
in that case, and also why we go to all the pain for keeping the two
context switches compatible), hence, even on machines with unlocked
context switches, irqs are off at this point.

Hope this is more clear.

-- 
                                                                Gilles.

