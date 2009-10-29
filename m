From: Leopold Palomo-Avellaneda <leo@domain.hid>
Date: Thu, 29 Oct 2009 15:00:06 +0100
References: <200910281314.00378.leo@domain.hid>
	<200910291225.27382.leo@domain.hid> <4AE987D6.2030501@domain.hid>
In-Reply-To: <4AE987D6.2030501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910291500.07164.leo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

A Dijous 29 Octubre 2009, Stefan Kisdaroczi va escriure:
> Leopold Palomo-Avellaneda schrieb:
> > A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
> >> Leopold Palomo-Avellaneda wrote:
> >>> A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Leopold Palomo-Avellaneda wrote:
> >>>>>> OTOH, the debian package has a bug. I cannot compile xenomai, using
> >>>>>> the debian way on kernels 2.6.28, 2.6.29 and 2.6.30 because the
> >>>>>> package add something that fails with make menuconfig. I should
> >>>>>> write a bug. Just for information, it's not a xenomai upstream
> >>>>>> related question. ;-)
> >>>>>
> >>>>> Please check xenomai-2.4.9.1. It may happen that the bug has been
> >>>>> already solved.
> >>>>
> >>>> 2.4.10
> >>>
> >>> nops, sorry again my fingers were so fast ...
> >>>
> >>> we are talking about the same? I got:
> >>>
> >>> cripts/kconfig/conf -o arch/x86/Kconfig
> >>> arch/x86/Kconfig:74: unexpected option "select"
> >>> arch/x86/Kconfig:75: unexpected option "select"
> >>> make[3]: *** [oldconfig] Error 1
> >>> make[2]: *** [oldconfig] Error 2
> >>
> >> I am not talking about any specific bug. It was just a general advice.
> >> In any case, we are not responsible for the Xenomai packages made by the
> >> Debian team, but if you find bugs in the debian directory which is part
> >> of the Xenomai package, we are interested in fixing them, of course.
> >
> > well, I have found two things:
> >
> > 1) the debian directory is very similar in both (upstream and debian
> > official). The method to create the package is described in the xenomai
> > wiki
>
> I diffed the two debian directories 3 weeks ago. There are some changes in
> the debian version which are not in the xenomai repository. And there are
> some fixes in the xenomai debian directory which are not in the official
> debian package.

ok. Good point. I didn't realize about it. I only checked the changelog, 

> The official debian version in testing is targeted for Debian 6.0 Squeeze
> and as far as i remember there are small changes which will break the build
> for Debian 5.0 Lenny. 

Well, I'm working with backports. The only appreciate difference is the change 
applied in the scripts/prepare-kernel.sh, as you mentioned after. I don't 
know if this change could originate problems in Lenny. I will investigate.

> This changes shouldnt get merged IMHO to the xenomai 
> debian version. I will try to create patches to synchronize the two
> versions.

Why? what did you have seen to avoid it? :-)

> > and have been working so well till now (at least in my case). The script
> > or the patch applied in the versions of the kernel 2.6.28>= introduces
> > something that make fail the make menuconfig step. If you apply the patch
> > with the script (scripts/prepare-kernel.sh) the make menuconfig works
>
> The following commit fixed (at least for 2.6.28) the patching of
> init/Kconfig. This fix is not in the official debian package, only in the
> xenomai repository.

Ok, I see. Thanks. I will check it.

Regards,

Leo

