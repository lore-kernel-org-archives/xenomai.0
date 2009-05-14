Message-ID: <4A0BD961.8010207@domain.hid>
Date: Thu, 14 May 2009 10:42:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>
	<4A0AC8A6.1000701@domain.hid> <4A0AE2AC.7010302@domain.hid>
	<4A0AE9EF.1010107@domain.hid> <4A0B34BF.3020707@domain.hid>
	<4A0BD3EE.2@domain.hid> <4A0BD7EC.1020205@domain.hid>
	<4A0BD882.5090803@domain.hid>
In-Reply-To: <4A0BD882.5090803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Troubles with switchtest
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> I think the trick against /this/ is preempt_disable/enable in
>>> kernel_fpu/begin/end. But that won't work for Xenomai, of course.
>> Well, that does not prevent an IRQ or a page fault from computing a RAID
>> cheksum...
> 
> If this is allowed, then... My impression was that FPU access is not
> legal from IRQ context.

If you have a mapped file on a raid disk and a page fault triggers a
write, I think the RAID routines will be used. But you are right, maybe
there is a test to use the plain integer RAID routines when called from
interrupt context.

-- 
                                                 Gilles.

