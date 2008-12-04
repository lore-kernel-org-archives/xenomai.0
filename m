Message-ID: <4937A50F.6050502@domain.hid>
Date: Thu, 04 Dec 2008 10:38:23 +0100
From: =?ISO-8859-1?Q?Patrick_Gr=E4bel?= <graebel@domain.hid>
MIME-Version: 1.0
References: <4934EB57.9080305@domain.hid> <49356C83.8050909@domain.hid>
	<200812040055.02455.berlemont.hauw@domain.hid>
In-Reply-To: <200812040055.02455.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Calling comedi from a RT task
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

Hi!

At the moment I have not much time to look into the APIs, but we have
some cards to test with: NI 6220, Adv 1751 and Adv 1720 (and maybe
more). Of course I would test drivers for you, if there are any prototype=
s.

What's the effort on porting? Is there much to do or do I have to
programm a driver from scratch? How do I have to imagine the structure
of the whole project?

Xenomai ------------> Comedi API    -> driver (e. g. ni_pcimio)
        |
        ---> RTDM --> Comedi RT API (part of Xenomai) -> RT driver

Is the Comedi API that is part of the Xenomai hierachy a Real Time
substitute for the Comedi API of the original Comedi project? So porting
is only a litte more than a simple recompile?

Is this correct? I would welcome any comments on this.

Greetings
Patrick Graebel

--=20

Universit=E4t Kassel
Fachbereich Elektrotechnik/Informatik
Fachgebiet Fahrzeugsysteme und Grundlagen der Elektrotechnik
Wilhelmsh=F6her Allee 73
34121 Kassel

E-Mail: graebel@domain.hid, Telefon: 0561 804-6264
GnuPG Fingerprint: 65B0 6282 5934 E2DC ADEB 6C2C CCEE 55FA 2C63 4E5C

