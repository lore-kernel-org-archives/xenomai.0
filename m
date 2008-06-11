Date: Wed, 11 Jun 2008 16:38:15 +0200 (CEST)
From: Andreas Erler <a.erler@domain.hid>
Message-ID: <30475381.6441213195095254.JavaMail.root@domain.hid>
In-Reply-To: <3686298.6421213193405988.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Debugging realtime tasks
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
Cc: "." <xenomai@xenomai.org>

Hello Gilles,

thank you, you were right!
I've used gdbserver 6.6 on my target and gdb 6.8 on my host.
I now have on both machines the same versions and voil=C3=A0 it works :-)

Thank you very much,
Andy

----- Urspr=C3=BCngliche Mail -----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
An: "Andreas Erler" <a.erler@domain.hid>
CC: "." <xenomai@xenomai.org>
Gesendet: Mittwoch, 11. Juni 2008 14:35:39 GMT +01:00 Amsterdam/Berlin/Bern=
/Rom/Stockholm/Wien
Betreff: Re: [Xenomai-help] Debugging realtime tasks

On Wed, Jun 11, 2008 at 10:23 AM, Andreas Erler
<a.erler@domain.hid> wrote:
> Hi,
>
> I want to debug a userspace task created with: rt_task_create(&demo_task,=
 "trivial", 0, 99, 0);
> When I set a breakpoint somewhere in the demo_task function I get the fol=
lowing message and gdbserver exits:
>
> Child terminated with signal =3D 5
>
> Child terminated with signal =3D 0x5 (SIGTRAP)
> GDBserver exiting
>
> Is it generally possible to debug realtime tasks or not?
> If yes, what I'm doing wrong here?

Yes, it is supposed to work. A common problem with using gdbserver
with gdb is not using the same version, you should use absolutely the
same  version of gdb and gdbserver.

If you use the same version of gdb and gdbserver and still have the
problem, could you post an example, and tell us where to put the
breakpoint ?

You should also tell us which version of Xenomai you use, and on which plat=
form.

--=20
 Gilles

