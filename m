Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABDF9@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Fri, 23 Nov 2007 16:17:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Communications between Threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


<<No, the thread has the priority you chose and is scheduled by Linux
scheduler as any Linux task. But are you sure you are not using
Xenomai posix message queues ?>>

For the moment I don't use anything (I have no source code). I just =
plans to use xenomai and I try understand the communication features =
between heterogeneous threads. I still don't understand how the =
real-time thread properties (priority, scheduling policy) are used by =
the linux scheduler when switching from the primary mode to the =
secondary mode.

Regards.
L.Poyart.

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Envoy=E9 : vendredi 23 novembre 2007 15:53
=C0 : Laurent.POYART@fr.thalesgroup.com
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] Communications between Threads


On Nov 23, 2007 3:45 PM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> Hi,
>
>
> <<It is possible to use a standard posix message queue within a
> real-time thread, but your real-time thread will then switch to
> secondary mode, which means it would no longer be real-time.>>
>
> Does the thread keep a higher priority compared to a standard linux =
thread?
> I don't really feel the effect of the switch from the primary mode to =
the
> secondary mode.

No, the thread has the priority you chose and is scheduled by Linux
scheduler as any Linux task. But are you sure you are not using
Xenomai posix message queues ?

--=20
                                               Gilles Chanteperdrix

