Message-ID: <4A0BD882.5090803@domain.hid>
Date: Thu, 14 May 2009 10:38:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>
	<4A0AC8A6.1000701@domain.hid> <4A0AE2AC.7010302@domain.hid>
	<4A0AE9EF.1010107@domain.hid> <4A0B34BF.3020707@domain.hid>
	<4A0BD3EE.2@domain.hid> <4A0BD7EC.1020205@domain.hid>
In-Reply-To: <4A0BD7EC.1020205@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> I think the trick against /this/ is preempt_disable/enable in
>> kernel_fpu/begin/end. But that won't work for Xenomai, of course.
> 
> Well, that does not prevent an IRQ or a page fault from computing a RAID
> cheksum...

If this is allowed, then... My impression was that FPU access is not
legal from IRQ context.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

