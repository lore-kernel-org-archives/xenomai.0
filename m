From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Thu, 11 Aug 2011 14:56:23 -0300
References: <201108101449.54243.carlosnov@domain.hid>
	<201108111131.11981.carlosnov@domain.hid>
	<4E43EE80.8050406@domain.hid>
In-Reply-To: <4E43EE80.8050406@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IfBRO4S2M2WwENV"
Message-Id: <201108111456.24208.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--Boundary-00=_IfBRO4S2M2WwENV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello again,

I did what you said, changed the open/close to non real time, removed every=
=20
portion of code that is not related with the fault (the read_rt is still th=
ere=20
since is where the problem arrises and also another ioctl to start timer si=
nce=20
the open/close are moved out of real time context). There is also the wait=
=20
ioctl to show that the code works when wait is done inside ioctl.
The problem persists, but no hangs perceived. Just the application returns =
too=20
fast and there is the kernel message on NULL pointer derreference, so I als=
o=20
tried to recompile with another kernel version, the vanilla 2.6.38-8 from=20
kernel.org and the adeos patch (on the previous tests I was using the same=
=20
with additional ubuntu patches). Even now the app returns imediately after=
=20
call read with rtdm_event_wait and there is the same kernel log.
I dont think there is any memory corruption due to the module code since th=
ere=20
is no dynamic allocations, little pointer operations mainly related to the=
=20
context hadler witch is allocated by xenomai on rtdm_dev_register.
I send you the new tarball.

Thanks for your support.

=2D-
Carlos Novaes.

Em qui 11 ago 2011, =C3=A0s 12:00:16, Gilles Chanteperdrix escreveu:
> On 08/11/2011 04:31 PM, Carlos Eduardo de Brito Novaes wrote:
> > Here it comes.
> > I found out that if wait is called inside an IOCTL, there is no hangs at
> > all, everything work as expected, except from te fact that it seens a
> > litle bit strange (to me) to use ioctl to read or write, I would expect
> > to use the correspondent rad and write functions and ioctl to setup
> > something. I tried to reduce the code, in the tarball there are one
> > Makefile, one c file for the module and one c file for the app. There is
> > one define line on the module file, comment it ou to get the hangs. The
> > app will simply open the device, issue an wait ioctl (dummy if the
> > module is compiled to wait in read_rt) and the do the actual reading (it
> > hangs on my system if i tell the module to wait on the read_rt
> > function).
> >=20
> > Here comes the kernel log from one run that does the error but
> > fortunately does not hang the entire system.
>=20
> Yes, you can use rtdm_event_wait in read or write. The fact that it
> hangs or results in bugs is probably due to the fact that you are
> corrupting some memory. Your testcase contains too much code. If you
> want to test rtdm_event_wait / rtdm_event_pulse, simply do one driver,
> with one ioctl which does the rtdm_event_wait, and the timer which does
> the rtdm_event_pulse.
>=20
> The copy_to_user in the read callback overflows the source area, but
> that is not your problem.
>=20
> Also, do not use open_rt and close_rt in new code as they are deprecated.

--Boundary-00=_IfBRO4S2M2WwENV
Content-Type: application/x-bzip-compressed-tar;
  name="testcase_wait_hang.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="testcase_wait_hang.tar.bz2"

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
inChIPDc2tI=

--Boundary-00=_IfBRO4S2M2WwENV--

