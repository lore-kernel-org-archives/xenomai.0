Message-Id: <200710260938.l9Q9cwPM018603@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Fri, 26 Oct 2007 11:38:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <18208.54980.748005.291295@domain.hid>
Subject: Re: [Xenomai-help] Event flag from ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

The 20us are just the ISR duration; the latency time is not included.

Thanks

Patrick

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: jeudi, 25. octobre 2007 19:48
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] Event flag from ISR

Patrick wrote:
 > Hi all,
 >=20
 > =20
 >=20
 > I am using a RT event flag structure to start a task from an ISR.
 >=20
 > The task waits on rt_event_wait and when the IRQ occurs the ISR =
executes
 > rt_event_signal (the ISR code only clears the flag and calls
 > rt_event_signal).
 >=20
 > I'm using an oscilloscope to measure the length of the ISR and the =
first
 > occurrence lasts about 20us and all the next occurrences last about =
4us.
 >=20
 > =20
 >=20
 > My question is why the first ISR is so long?
 >=20
 > =20
 >=20
 > For information I use xenomai 2.4 rc4 on ARM pxa270 machine with =
2.6.20
 > kernel.=20

Typical worst case interrupt latency on ARM is around 50 us, so 20 us is
not that long. What you are observing is probably a cache effect. In
this case, you should observe 20us after each user-space context switch
since on ARM, cache is flushed at each user-space context switch.


--=20


					    Gilles Chanteperdrix.


