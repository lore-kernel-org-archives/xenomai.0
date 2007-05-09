Message-ID: <17968891.1178734243902.JavaMail.ngmail@domain.hid>
Date: Wed, 9 May 2007 20:10:43 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized	for
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, rpm@xenomai.org

 user space only applications
Cc: xenomai@xenomai.org, mathias_koehrer@domain.hid
In-Reply-To: <4641F7A4.50105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4641F7A4.50105@domain.hid> <22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<1178727256.11688.35.camel@domain.hid>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 84.160.96.10

Hi Gilles,
=20
> We could have a "sync object area" where all atomic counters would live,
> that would be mapped into real-time processes address space, the sync
> object would then only contain an index in this area. This would mean
> that the number of sync objects is limited, but it is a restriction far
> more acceptable than to allocate and share a full page by sync object.
That sounds great. I think typically only a few (up to 20) sync objects are=
 required.
Thus, one memory page should be enough for most applications.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

