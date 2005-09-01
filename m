Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <20050901104750.c0mpu3q4pkc088wg@domain.hid>
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Thu, 01 Sep 2005 14:20:06 +0200
Message-Id: <1125577206.4641.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Le jeudi 01 septembre 2005 =C3=A0 10:47 +0200, Philippe Gerum a =C3=A9cri=
t :=20
> >> Ok. Looks like time has come to upgrade the combined Adeos/PREEMPT_R=
T patch
> >> to
> >> -rt1 in order to fix the issues brought since 0.7.44, I guess.
> >
> > How does this relate to the above ? I worked on the _plain_ adeos
> > patch, not the combo rt one. That being said, the plain adeos patch
> > does contain some PREEMPT_RT bits - and those are the ones causing th=
e
> > problems.
> >
>=20
> This is exactely how this relates to the above: The PREEMPT_RT-aware bi=
ts are
> out of date.

I was under the impression that the PREEMPT_RT bits were not supposed to
be at all in the plain (non rt combo) patch. But I suppose the current
plan is to fold those bits into the regular patch.

> >> >The ppc patch was a bit more tricky, but I think I got all of it ri=
ght.
> >> >It works ok most of the time (RTAI fusion testsuite passes for exam=
ple -
> >> >on a G4 Powerbook), but it hangs the machine hard sometimes. I am n=
ot
> >> >sure if the problem is due to the port or if it is present in the 2=
.6.10
> >> >version as well.
> >> >
> >>
> >> I had a report about issues involving insufficiently protected
> >> get_mmu_context/destroy_context calls on the RTAI mailing list with
> >> 2.6.10-r8c1; I'm currently checking the proposed fix that has been s=
ent to
> >> me
> >> on a mpc8541. If this works, then maybe this would solve the issue y=
ou
> >> mention
> >> too; hopefully.
> >
> > I suppose you're talking about:
> > https://mail.rtai.org/pipermail/rtai/2005-August/012841.html
> >
>=20
> Yes; Looking at the code a bit more, I think the issue was more=20
> generally lying
> in the unprotected use of activate_mm(), as called from the fs/exec stu=
ff.

I saw the patch you posted on the rtai list and tried it,
but unfortunately it does not solve my problems.

The bug (hard lockup without any message at all) is 100% reproductible
when running fusion's rtai-test application. It does not always hang at
the same point in execution, but it does often hang at the end of the
'latency' binary invocation.

I am also unable to reproduce this bug when running manually the 'latency=
'
test, even when simulating some load like 'rtai-test' does. I suppose
I could end up reproducing the bug if I tried hard enough...

I'll try testing the 2.6.10 patch, maybe this will tell if the problem
is in the adeos core or in the newer kernel changes...

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


