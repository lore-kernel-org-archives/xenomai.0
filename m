From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: AW: [Xenomai-help] prepare kernel fails
Date: Wed, 20 Dec 2006 18:31:12 +0100
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<200612192202.58982.niklaus.giger@domain.hid>
	<4588F8D0.5060605@domain.hid>
In-Reply-To: <4588F8D0.5060605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201831.12472.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Am Mittwoch, 20. Dezember 2006 09:48 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
> > Am Dienstag, 19. Dezember 2006 21:38 schrieb Jan Kiszka:
> >>I rather think c) is desired: checkout from svn, make dist, untar that
> >>archive and continue to work with *those* sources.
> >
> > This solution is also easily integretable into the actual Buildbot. I
> > suppose do it would be sufficient to add it only to the daily "full"
> > builds. But I would need to know how the release is exactly generated.
> > E.g. after a checkout to clean directory there is no Makefile and
> > therefore "make dist" fails miserably. Could somebody please tell me the
> > exact steps?
>
> You need to create a build tree by running the configure script, then
> run make dist (or preferably "make distcheck") in this build tree.
What are the needed (minimal) options for configure? Because if I do not 
specify any option I get the following error when running make:
> make[2]: Entering directory `/home/hcu/kernel/tst_dist/src/testsuite'
> list='latency switchbench cyclic switchtest irqbench'; for subdir in $list;
> do \ if test "$subdir" = .; then :; else \
>             test -dbuild 
> "/home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite/$subdir" \
>
>             || mkdir -p --
>             || "/home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite/$sub
>             ||dir" \ exit 1; \
>
>             distdir=`CDPATH="${ZSH_VERSION+.}:" && cd
> /home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite && pwd`; \
> top_distdir=`CDPATH="${ZSH_VERSION+.}:" && cd
> /home/hcu/kernel/tst_dist/xenomai-2.2.92 && pwd`; \ (cd $subdir && \
>               make  \
>                 top_distdir="$top_distdir" \
>                 distdir="$distdir/$subdir" \
>                 distdir) \
>
>               || exit 1; \
>
>           fi; \
>         done
> make[3]: Entering directory
> `/home/hcu/kernel/tst_dist/src/testsuite/latency' make[3]: *** No rule to
> make target `runinfo', needed by `distdir'.  Stop. make[3]: Leaving
> directory `/home/hcu/kernel/tst_dist/src/testsuite/latency' make[2]: ***
> [distdir] Error 1
> make[2]: Leaving directory `/home/hcu/kernel/tst_dist/src/testsuite'
> make[1]: *** [distdir] Error 1
> make[1]: Leaving directory `/home/hcu/kernel/tst_dist/src'
> make: *** [distdir] Error 1

Do I need to run this on a system which is running a xenomai kernel?
(I never tried to run it on my Intel MacMini.) Can I build it on a PPC 
machine?

Niklaus

