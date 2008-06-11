Message-ID: <2ff1a98a0806110545u52fc2606s147fe01003a1e1cb@domain.hid>
Date: Wed, 11 Jun 2008 14:45:57 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <28245271.1213187856046.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14821321.1213179993177.JavaMail.ngmail@domain.hid>
	<2ff1a98a0806110516h46fa524br98b2b8409beedc7d@domain.hid>
	<2ff1a98a0806110518ob7cb5b5h7c0471e3c3ce8c09@domain.hid>
	<28245271.1213187856046.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Are xmm-registers saved with a (task) context
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

On Wed, Jun 11, 2008 at 2:37 PM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hi Gilles,
>
> thanks for your response.
> With the MMX registers, you are right. They are actually aliased with the FPU registers.
> However, the XMM registers (SSE, SSE2) are not aliased.
> The aliased MMX registers AND the not-aliased XMM registers are available with today's CPUs,
> i.e. you still have to take card when using MMX registers.
> (All information according to Intel's 64 and IA-32 Architectures
> Software Developer's Manual, Volume 1, Chapters 9,10,11)
>
> From your mail before I assume that the (not-aliased) XMM registers are saved with the switching routine
> and can be used without have to save/restore them.

Ok. My memories were a bit imprecise. The whole question boils down to
know whether the "fxsave" instruction saves the XMM registers. I think
it does, but you would probably better check in the documentation.


-- 
 Gilles

