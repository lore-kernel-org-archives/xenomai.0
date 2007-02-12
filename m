Message-ID: <45D068C0.8090208@domain.hid>
Date: Mon, 12 Feb 2007 14:16:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
References: <45CF951B.8080404@domain.hid>	<1171233732.5035.24.camel@domain.hid>	<17871.41373.425284.839228@domain.hid>	<1171237780.5035.30.camel@domain.hid>	<17871.45750.434103.944040@domain.hid>	<45CFB49F.1050000@domain.hid>
	<45CFBE7B.3050906@domain.hid> <45D05431.10409@domain.hid>
In-Reply-To: <45D05431.10409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>2.6.19 didn't magically start to work as well. Instead I have a back
>>trace now, see attachment.
>>
>>I included a full set of 16k points, but the thrilling things are around
>>-73 to -25: Some Linux process with IRQs on gets preempted by an RT-IRQ
>>(RTnet NIC). That triggers an RT kernel thread to run for a while (RTnet
>>stack manager, prio 98). But when returning to Linux again, its IRQs
>>remain masked now. The reason must be that weird exception at -62. Don't
>>know where it comes from and why is there no report about THAT issue in
>>the kernel logs.
> 
> 
> The cause of this page fault will get tracked down later today, but the
> way it is handled already causes some doubts to me. To make discussion
> easier, here is the relevant excerpt from the trace:

Maybe this fault is due to the No-cow patch ? Before the no-cow patch,
vmalloced areas were added to all processes page directories, now they
are added only to the page directories of processes with the VM_PINNED
flag. So, if ipipe_test_root tries to access some module memory area
over the context of a non-realtime thread, a fault will occur.

-- 
                                                 Gilles Chanteperdrix

