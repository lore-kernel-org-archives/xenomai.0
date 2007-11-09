Message-ID: <473474C1.6000300@domain.hid>
Date: Fri, 09 Nov 2007 15:54:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0711090616r6376a8a6t81e9bc94b4290dea@domain.hid>
	<2ff1a98a0711090645y37a5313cj8b870c36a49e5286@domain.hid>
In-Reply-To: <2ff1a98a0711090645y37a5313cj8b870c36a49e5286@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel oops while trying first boot w/ Xenomai
 2.4rc5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Nov 9, 2007 3:16 PM, Giammarco Zacheo <g.zacheo@domain.hid> wrote:
>> Processors: 4
>> SMP alternatives: switching to UP code
> 
> There is something wrong: why is the kernel switching to UP mode if
> there are four processors ?

No, that is normal (given X86-generic setup):

...
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 10390606
Detected 10.390 MHz APIC timer.
SMP alternatives: switching to SMP code
...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

