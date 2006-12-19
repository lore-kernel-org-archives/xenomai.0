From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] Latency trace on ARM
Date: Tue, 19 Dec 2006 14:58:57 +0100
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1GwKz1-0008O4-Mn@domain.hid>
	<1166473710.17298.15.camel@domain.hid>
In-Reply-To: <1166473710.17298.15.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GwfUa-0008Jh-4C@mailer.emlix.com>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

Philippe Gerum wrote:
> On Mon, 2006-12-18 at 17:04 +0100, Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> > > If you have anything more pending, please post soon, Gilles is
> > > collecting the ARM stuff for Xenomai 2.3.
> >
> > Attached are all patches that I posted in the last two months but didn't
> > get into Ipipe CVS or Xenomai svn. The first file pools all patches for
> > Ipipe, here comes an overview what it comprises:
> >
> > - I-pipe for Samsung S3C24xx
> > - I-pipe tracer for ARM
> > - Introduce __ipipe_mach_release_timer()
> > - Fix ipipe_tsc2ns()
> > - Don't activate the tracer too early during the boot process
> >
> > Please consider these patches for Xenomai 2.3. Thanks!
>
> They will be included. The point is that we are not using the Adeos CVS
> anymore, waiting to switch to git asap.

BTW, is there an up-to-date I-pipe repository available (git-based or not)?

--
Sebastian

