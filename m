Message-ID: <497EE381.3040005@domain.hid>
Date: Tue, 27 Jan 2009 10:35:45 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A017A39A7@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A017A39A7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue on PPC ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> As you certainly allready know, we are facing some FPU problems on
> PPC (2.4 Kernel) too (switchtest reports inconsistent FPU-register;
> our application crashs with FPU-exception or shows sometimes
> unreasonable FP-values). Is the solution you found for i386
> applicable for PPC too (does the issue, you described, apply to PPC
> too) ?

No. The FPU handling is very different on ppc and x86. I far as I know,
the PPC kernel only uses Altivec in kernel-space which is handled
separately from plain FPU registers and not touched at all by Xenomai.

I am investigating the ppc fpu issue, and the current situation is that
the FPU handling on ppc is indeed broken. I am working on a fix.

-- 
                                                 Gilles.

