Message-ID: <46010E01.7060407@domain.hid>
Date: Wed, 21 Mar 2007 11:50:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>	<17914.63535.18893.207257@domain.hid>	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>	<17920.13832.789072.876398@domain.hid>	<b647ffbd0703201721g1752e0falbe3fed8df405b3f8@domain.hid>	<17920.60301.400005.135175@domain.hid>	<4600F735.2030205@domain.hid>
	<4601059E.6040903@domain.hid> <46010B20.4050807@domain.hid>
In-Reply-To: <46010B20.4050807@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>>
>>>I think implementing coloured caches (with reservations for RT
>>>processes) could be an option as well. Once RT context switches no
>>>longer require full cache flushes, those for non-RT processes could be
>>>made interruptible. But all this would require heavy Linux hacking, I'm
>>>afraid.
>>
>>Using TCM removes any cache effect and does not require Linux hacking.
>>
> 
> 
> How is TCM managed? Can you push parts of I-pipe/Xenomai or even some
> applications into it? Or does this only help here if you have a few ops
> of an interrupt handler to be saved from the (RT-wise) lousy caching
> architecture of ARM?

TCM are 2 16K contiguous memory areas: one where data can be put, the
other where code can be put. They are mapped into the address space, and
once it is done, some data or code must be copied into them. Moving one
function to the TCM should be pretty straight-forward, allowing several
arbitrary functions to be in the TCM would probably require some more
work: a possible implementation would be to put the functions and data
in some specific sections that would be copied in the TCM at load time.

> 
> [I threw coloured caches into the ring also to trigger some discussion
> on a long-term solution for MMU-based Xenomai on ARM.]

Right, TCM do not exist on all ARM.

-- 
                                                 Gilles Chanteperdrix

