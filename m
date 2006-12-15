From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Failure building Xenomai kernel for
	TQM860
Date: Fri, 15 Dec 2006 21:30:14 +0100
References: <200612081309.31003.niklaus.giger@domain.hid>
	<45795D28.8010606@domain.hid> <45795DE1.70000@domain.hid>
In-Reply-To: <45795DE1.70000@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612152130.14387.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: xenomai@xenomai.org

Am Freitag, 8. Dezember 2006 13:43 schrieb Jan Kiszka:
> Wolfgang Grandegger wrote:
> > Hi Niklaus,
> >
> > I just compiled my Linux 2.4 kernel for TQM860L with the latest revision
> > of Xenomai and I cannot reproduce your problem. In you linker path there
> > are no Xenomai objects. How does it come? Do you use --arch=ppc with
> > prepare_kernel (--arch=powerpc is not valid any more for the ppc tree).
>
> The problem pops up with CONFIG_XENO_OPT_SCALABLE_SCHED.
>
> The definition of xnlogerr is not visible to queue.h, namely to the
> inline function getmlq. Here is possible solution at XENO_ASSERT level.
>
> Jan
Why didn't you apply your patch? It solved my problem and I don't see any risk 
why you shouldn't apply it and didn't see any objections on this mailing 
list.

Best regards

-- 
Niklaus Giger

