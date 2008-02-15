Message-ID: <47B593DE.2070305@domain.hid>
Date: Fri, 15 Feb 2008 14:30:06 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <43455a600802150455p41ea028excec13d73ff4f1114@domain.hid>
In-Reply-To: <43455a600802150455p41ea028excec13d73ff4f1114@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error while porting xenomai to power pc 750Cxe
 based	SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rakesh bk <rakeshbk402@domain.hid>
Cc: xenomai@xenomai.org

Hello,

rakesh bk wrote:
> Hello Everyone
> 
> I am new to Xenomai , I have ported linux-2.6.14 to our custom board based
>    on IBM750Cxe Iam unable to boot my kernel cross compiled with
> eldk-3.0 with
>    enabled xenomai support.If i remove xenomai and ipipe support     the
> kernel
>    boots correctly , but if i enable i get the following oops message .
>    The following patches are applied and arguements of scripts/prepare-
>    kernel.sh is mentioned as follows
>    adeos-ipipe-2.6.14-ppc-1.3-05.patch,
>    Target architecture [default i686]: ppc
>    Adeos patch[default linux-2.6.14/xenomai-2.2.0
>    /ksrc/arch/powerpc/patches
> /adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:
>    adeos-ipipe-2.6.14-ppc-1.3-05.patch,
> 
> Xenomai: ALTIVEC support enabled in kernel but no hardware found.
>          Disable CONFIG_ALTIVEC in the kernel configuration.

Please disable CONFIG_ALTIVEC in your kernel configuration as suggested
by the boot message above.

Any chance to switch to a more recent version of Linux and Xenomai?

Wolfgang.


