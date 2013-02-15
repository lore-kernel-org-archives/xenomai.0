Message-ID: <511E5594.2010809@siemens.com>
Date: Fri, 15 Feb 2013 16:34:44 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511E5112.9030006@control.lth.se> <511E53A5.1030406@siemens.com>
In-Reply-To: <511E53A5.1030406@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel BUG at arch/x86/kernel/ipipe.c:589! on
	motherboard DX79SI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-15 16:26, Jan Kiszka wrote:
> On 2013-02-15 16:15, Anders Blomdell wrote:
>> Hi,
>>
>> I have a DX79SI that dies with "kernel BUG at
>> arch/x86/kernel/ipipe.c:589!" when running Xenomai. This is not very
>> surprising since when running the system with an ordinary kernel thera
>> are a few 'do_IRQ: X.Y No irq handler for vector (irq -1)' each day.
>>
>> Question is if it would be possible to do something less fatal than
>> 'BUG_ON(irq < 0);' in the code below:
> 
> This remains a bug that has to be understood.

Oh, now I really read the paragraph above: So your system generates
spurious interrupts? OK, for which vector? Are there reports on the web
related to this issue and hardware reasons? I wouldn't want to run RT
load on such a wacky box - provided it is a hardware issue.

The reason why we BUG here is that so far all cases were real I-pipe
bugs. Until we know this is required for otherwise fine hardware, I'm a
bit reluctant to add special code that handles this differently.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

