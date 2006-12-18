Subject: Re: [Xenomai-core] Re: [Adeos-main] Latency trace on ARM
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200612182252.15490.Sebastian.Smolorz@domain.hid>
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1GwKz1-0008O4-Mn@domain.hid> <1166473710.17298.15.camel@domain.hid>
	<200612182252.15490.Sebastian.Smolorz@domain.hid>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 23:04:16 +0100
Message-Id: <1166479456.17298.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: adeos-main@gna.org, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2006-12-18 at 22:52 +0100, Sebastian Smolorz wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-12-18 at 17:04 +0100, Sebastian Smolorz wrote:
> > > Jan Kiszka wrote:
> > > > If you have anything more pending, please post soon, Gilles is
> > > > collecting the ARM stuff for Xenomai 2.3.
> > >
> > > Attached are all patches that I posted in the last two months but didn't
> > > get into Ipipe CVS or Xenomai svn. The first file pools all patches for
> > > Ipipe, here comes an overview what it comprises:
> > >
> > > - I-pipe for Samsung S3C24xx
> > > - I-pipe tracer for ARM
> > > - Introduce __ipipe_mach_release_timer()
> > > - Fix ipipe_tsc2ns()
> > > - Don't activate the tracer too early during the boot process
> > >
> > > Please consider these patches for Xenomai 2.3. Thanks!
> >
> > They will be included. The point is that we are not using the Adeos CVS
> > anymore, waiting to switch to git asap.
> 
> OK, didn't know that. These patches are the most current, please take them and 
> not the ones posted before. Thank you!

Gilles maintains the ARM support; he will push upstream the patch that I
will merge eventually. In any case, 2.3 final won't be rolled out
without the updated ARM patch in. Thanks.

-- 
Philippe.



