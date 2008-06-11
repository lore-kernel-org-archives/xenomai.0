Message-ID: <2ff1a98a0806110518ob7cb5b5h7c0471e3c3ce8c09@domain.hid>
Date: Wed, 11 Jun 2008 14:18:52 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0806110516h46fa524br98b2b8409beedc7d@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14821321.1213179993177.JavaMail.ngmail@domain.hid>
	<2ff1a98a0806110516h46fa524br98b2b8409beedc7d@domain.hid>
Subject: Re: [Xenomai-help] Are xmm-registers saved with a (task) context
	switch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Jun 11, 2008 at 2:16 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, Jun 11, 2008 at 12:26 PM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
>> Hi!
>>
>> I want to use the xmm0 register (from the SSE2 extension of a Core2Duo CPU) to do atomic 64bit write/read accesses in
>> 32 bit x86 mode.
>> My question is: Will the xmm[0..7] registers be saved with a task context switch when running Xenomai real time tasks in user
>> space or do I have to take care to save them on the stack before using (and restoring them afterwards).
>> Is it save to use these registers or will they be used by Xenomai (or Linux)  internally?
>>
>> Thanks for any answer on that question.
>
> The xmm register are saved by the FPU switching routines. Note
> however, that depending on the x86 you are using the xmm registers are
> aliased to the FPU register or are separate registers. So, on machines
> where the xmm registers are aliased to normal FPU registers, you have
> to do the save restore on your own if you want to use MMX, SSE, or
> SSE2 and use FPU instructions in the same thread.

This probably applies to very old CPUs, xmm are separate registers now.

-- 
 Gilles

