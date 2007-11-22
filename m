Message-ID: <2ff1a98a0711220552o6db094b5y9feb90f5ade09a69@domain.hid>
Date: Thu, 22 Nov 2007 14:52:53 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1806365692@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1806365692@domain.hid>
Subject: Re: [Xenomai-help] boot hang up with lapic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

On Nov 22, 2007 2:45 PM, Andreas Vogt <A_C_V@web.de> wrote:
>
> Hello
> I hope somebody can help me.
> I have Xenomai 2.3.1 and Linux 2.6.20.13 and i tried it with other Versions and adeos-ipipe-2.6.20-i386-1.10-10.patch.
> Everytime I have in the boot options nolapic then the Linux works but the Error
>
> >Xenomai: Local APIC absent or disabled!
> >Disable APIC support or pass "lapic=1" as bootparam.
> >Xenomai: system init failed, code -19.
> >Xenomai: starting POSIX services.
> >Xenomai: POSIX skin init failed, code -19.
> >Xenomai: RTDM skin init failed, code -19.
>
> happen.
> And if i write lapic in the boot options the system doesn't boot.
> Andreas

Your last choice is to disable local apic in kernel configuration, then.

-- 
                                               Gilles Chanteperdrix

