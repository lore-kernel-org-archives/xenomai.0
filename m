Message-ID: <512B9A86.4060900@siemens.com>
Date: Mon, 25 Feb 2013 18:08:22 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
	<51236088.1030402@gmail.com> <51236A75.5090400@siemens.com>
	<5123C910.7090107@siemens.com> <5123DDBE.8060105@web.de>
	<512778A0.6090300@gmail.com> <51277B66.60505@siemens.com>
In-Reply-To: <51277B66.60505@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-22 15:06, Jan Kiszka wrote:
> On 2013-02-22 14:54, Manuel Huber wrote:
>> Hey!
>>
>> Great work, it booted! I appended the log file, just in
>> case you want to check... Let me now if I should test
>> some more patches!
> 
> Err, that is just an instrumentation that shows if that target vector is
> initialized at all. Maybe the instrumentation changed the timing,
> "resolving" the issue this way. I will have to look at more details why
> IRQ7 is not wired up.

OK, after writing tons of instrumentations for your system and wondering
even more why we see this strange effect when the code says something
like "For legacy IRQ's, start with assigning irq0 to irq15 to
IRQ0_VECTOR to IRQ15_VECTOR for *all* cpu's.", I finally realized that I
was accidentally hacking against 3.8 and that there is apparently an
upstream bug in older kernels. It was fixed in 3.8 by "x86, apic:
Cleanup cfg->domain setup for legacy interrupts" ("cleanup" - well the
commit log rather talks about "issues"...).

As 3.5 is dead, this fix will never make it there unless we back-port.
While I'm doing this, could you try if

    git://git.xenomai.org/ipipe-jki.git for-upstream/master

works for you? Anders, this bug may explain your problems, too. Please
give my tree a try as well.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

