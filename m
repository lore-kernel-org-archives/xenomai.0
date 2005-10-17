Message-ID: <43535A06.9050207@domain.hid>
Date: Mon, 17 Oct 2005 10:00:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <43514FE1.80703@domain.hid> <435155D1.5090302@domain.hid>
	<435356FB.7080706@domain.hid>
In-Reply-To: <435356FB.7080706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> On 10/15/2005 09:17 PM Heikki Lindholm wrote:
> 
>>Wolfgang Grandegger kirjoitti:
>>
>>>Hello Philippe,
>>>
>>>I got Xenomai working on a Ocotea-Board (AMCC 440GX) and a low-end
>>>TQM855L-Module (MPC 855) under Linux 2.6.14-rc3 :-). The patch applied
>>>with a few hunks and one easy to fix reject and I had to correct two
>>>problems. One with FEW_CONTEXT (see attached patch) and the second with
>>>"#include <asm/offsets.h>" in "xenomai/arch/ppc/hal/switch.S". The
>>>include file does not exist (any more) in the kernel tree and therefore
>>>I commented out the line. I'm going to perform latency tests on various
>>>4xx and 8xx boards next week. Here are some preliminary figures of the
>>>TQM855L-Module (CPU 80 MHz, Bus 40 MHz, 4 kB I-Cache 4 kB D-Cache):
>>
>>If you happen to know some (semi-)comparable figures for the same boards 
>>using some commercial RTOS, it would be nice to know them also, for 
>>comparison.
> 
> 
> Well, we only deal with "free" software. But I can compare the result
> from the klatency test with the one from RTAI/RTHAL under Linux 2.4, of
> course.
> 

This would be a good starting point.

-- 

Philippe.

