Message-ID: <47259DF9.7050201@domain.hid>
Date: Mon, 29 Oct 2007 09:46:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
	<4722F8BD.8010401@domain.hid> <47230D83.1030001@domain.hid>
	<4724CEFD.4010502@domain.hid> <4725928C.7060900@domain.hid>
In-Reply-To: <4725928C.7060900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
 come
Reply-To: rpm@xenomai.org
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
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>  On the other
>>> hand, there is still the broken blackfin arch...
>> And the x86_64 too - just enable AUDIT_SYSCALL. And we need the ARM
>> upgrade too.
> 
> Can't follow you regarding CONFIG_AUDIT_SYSCALL. What else is required
> beyond simply enabling this .config switch? And is this tracing then
> only a x86_64 issue?
> 

On at least two x86_64 boxes, arming this switch either causes a lockup
at boot, or generates random segmentation violations when running the
latency test. This is not a tracing issue -- the register set looks like
being randomly trashed on the return path enabled by this option.

-- 
Philippe.

