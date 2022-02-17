Message-ID: <ceee650b-e14a-47f2-d3ee-eb1c69591ff7@siemens.com>
Date: Thu, 17 Feb 2022 21:11:41 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail/x86: Redundant oob_trap_notify in kernelmode_fixup_or_oops?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

oob_trap_notify() only notifies if running oob [1]. But at [2], we are
always in-band due to the check at [3], no? What was the idea behind
placing a hook here?

Jan

[1]
https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/include/linux/dovetail.h#L67
[2]
https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/arch/x86/mm/fault.c#L743
[3]
https://source.denx.de/Xenomai/linux-dovetail/-/blob/a1536285c0e15b7d49f772922477077794bfdcfd/arch/x86/mm/fault.c#L731
-- 
Siemens AG, Technology
Competence Center Embedded Linux

