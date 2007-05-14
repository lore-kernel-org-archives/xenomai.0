Message-ID: <9958525.1179143870179.JavaMail.ngmail@domain.hid>
Date: Mon, 14 May 2007 13:57:50 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1179136852.5045.76.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1179136852.5045.76.camel@domain.hid>
	<19756477.1179132019857.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

HI all,

thanks for all the responses.
Using mutexes instead of semaphores actually solves the issue.
However, the API documentation of rt_sem_create() is a little bit confusing=
 here.
The "mode" parameter of rt_sem_create() may contain "S_PRIO" which=20
"makes tasks pend in priority order on the semaphore".
I interpret this that it works actually the very same as with mutexes. Howe=
ver, it
is implemented that sem_v directly triggers a waiting task (even if it is l=
ow prio).
As the semaphore has nothing to do with the scheduler, this makes sense.
However, this cannot be found within the API documentation.

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

