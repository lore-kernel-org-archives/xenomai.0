Message-ID: <4781F597.101@domain.hid>
Date: Mon, 07 Jan 2008 10:49:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>	<4779000C.9050403@domain.hid>	<b131c9f0712310754o309ada74t31415576266d6ac4@domain.hid>	<200712311654.51903.paul_c@domain.hid>
	<b131c9f0801010817l2f36aea3h7d521d7be8b7255@domain.hid>
In-Reply-To: <b131c9f0801010817l2f36aea3h7d521d7be8b7255@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Large (negative) latency test results and fast
 PC clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai@xenomai.org

vikesh rambaran wrote:
> ...
> How does xenomai select the timerdev and the clockdev from the following
> kernel config parameters ?
> 
> a) X86_LOCAL_APIC
> b) X86_IO_APIC
> c) X86_GOOD_APIC
> d) X86_UP_APIC
> e) M586TSC
> f) X86_TSC
> g) HPET

To answer this question (for x86-32 aka i386):

Timer = X86_LOCAL_APIC ? LAPIC : PIT
Clock = X86_TSC ? TSC : PIT-emulated TSC

X86_UP_APIC controls the availability of X86_LOCAL_APIC on UP, M586TSC
(or better) enables X86_TSC. X86_IO_APIC and X86_GOOD_APIC have no
relevance here (the latter just influence the way the APIC is accessed
on i386). HPET_TIMER has that well-known side-effect of blocking the PIT
in case there is actually HPET hardware available and used by Linux.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

