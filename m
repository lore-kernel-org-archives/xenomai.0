References: <ceee650b-e14a-47f2-d3ee-eb1c69591ff7@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail/x86: Redundant oob_trap_notify in
 kernelmode_fixup_or_oops?
Date: Fri, 18 Feb 2022 09:51:52 +0100
In-reply-to: <ceee650b-e14a-47f2-d3ee-eb1c69591ff7@siemens.com>
Message-ID: <87fsogh7pf.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> oob_trap_notify() only notifies if running oob [1]. But at [2], we are
> always in-band due to the check at [3], no? What was the idea behind
> placing a hook here?
>

As you noticed, [2] and its counterpart notifying about the end-of-trap
condition are superfluous.

> Jan
>
> [1]
> https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/include/linux/dovetail.h#L67
> [2]
> https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/arch/x86/mm/fault.c#L743
> [3]
> https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/arch/x86/mm/fault.c#L731


-- 
Philippe.

