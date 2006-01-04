Subject: Re: [Xenomai-core] RTDM timerbench problems
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <43BBFCB6.9080601@domain.hid>
References: <1136391676.5443.57.camel@domain.hid>
	<43BBFCB6.9080601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 04 Jan 2006 18:10:47 +0100
Message-Id: <1136394647.5443.64.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai-core <xenomai@xenomai.org>

Le mercredi 04 janvier 2006 =E0 17:49 +0100, Jan Kiszka a =E9crit :
> Stelian Pop wrote:
> > Hi,
> >=20
> 88> I'm trying to use the xeno_timerbench as a replacement to the old 2=
.0
> > klatency module and I encounter some problems.
> >=20
> > This is on my in-progress ARM Xenomai port. User space latency and ol=
d
> > klatency work great (my board has some hardware latency problems thou=
gh
> > - latencies can be as high as 500 us..). This in on a 2.6.14.5 kernel
> > using the latest ipipe patch and the latest SVN trunk xenomai.
> >=20
> > Note that I never used the RTDM skin until now, so the problem could =
be
> > as well in the core RTDM code.
>=20
> Almost impossible - there are no bugs! ;)

there is no spoon either :)

=20
> Well, seriously, I don't believe it's a RTDM-related issue as the
> invocation of the timer-handler and the kernel-task tests are quite
> similar. The former works, the latter fails inside the scheduler, this
> rather indicates some issue in the arch-specific part of the scheduler
> (the timer test runs in IRQ-context).
>=20
> Did you test some RTDM or native kernel-only timed-task before? With
> RTDM this can be as trivial as this one:

As I said in the previous post, the old klatency works.

As for your rtdm example:

# insmod test-rtdm.ko
test_rtdm: module license 'unspecified' taints kernel.
# I'm alive.I'm alive.I'm alive.I'm alive.I'm alive.I'm alive.I'm
alive.I'm alive.I'm alive.I'm alive.I'm alive.I'm alive.I'm alive.I'm
alive.I'm alive.I'm alive.

seems to work fine too (and I'm even able to rmmod the module).

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


