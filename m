Message-ID: <19747995.1166787148515.JavaMail.ngmail@domain.hid>
Date: Fri, 22 Dec 2006 12:32:28 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: Re: Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dmitry.adamushko@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Dmitry,=20

>=20
> > As this is hard to understand, I strongly recommend that there is Xenom=
ai
> support
> > for this! I.e. a Xenomai API that can be called with a (callback-)funct=
ion
> pointer and
> > a user data pointer.
> > When a (realtime) thread calls this function, the real time thread is
> blocked.
> > The callback function is then called from a safe context and
> > after exit of the callback function the real time thread is resumed.
>=20
> I haven't got your idea. Did you get the cause of the problem with fork()=
 ?
Yes, I think I got it (more or less).

However, as a typical user of a OS I do not want to take care of this
very specific things. I want to call an OS-API that is doing the job for me=
.
I.e. in my example, I want to call an API that allows me to execute whateve=
r
external application without any risk and side effects.
>From the functional point of view I want to use the "system()" call.
When it is not save to call system() directly (due to all the things that h=
ave been
discussed), I think it is important to document this (e.g. in the Wiki) _an=
d_ to
provide an easy usable replacement for it, i.e. something like a rt_task_sy=
stem()
that does all the required things internally for me and behaves on the func=
tional side exactly
like the standard system() does.
The Xenomai Native example is a very good example for a cleanly designed AP=
I that
can be easily (and nearly intuitively) used.=20
Any workarounds (I call it workaround as the intuitive, straightforward app=
roach is not possible)
that are required to get a problem solved, weakens the whole OS (Xenomai).

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

