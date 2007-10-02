Message-Id: <200710021123.l92BNDsQ005097@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Tue, 2 Oct 2007 13:23:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
Subject: Re: [Xenomai-help] rt_task crash kernel
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



-----Message d'origine-----
De=A0: Patrick [mailto:kpa_info@domain.hid
Envoy=E9=A0: mardi, 2. octobre 2007 12:46
=C0=A0: 'Gilles Chanteperdrix'
Objet=A0: RE: [Xenomai-help] rt_task crash kernel

Yes, I have tried with latency -p 1000 and the issues is the same.

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mardi, 2. octobre 2007 11:46
=C0=A0: Patrick
Cc=A0: xenomai-core
Objet=A0: Re: [Xenomai-help] rt_task crash kernel

On 10/2/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Yes, I have tried with bin/latency user space application and the =
system
> crashes.

latency appears to crash on ARM when launched with the default 100us
period, the system is just too busy. Do you observe the crash with a 1
ms period ?

--=20
                                               Gilles Chanteperdrix


