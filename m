Message-Id: <200712031436.lB3EaAOR007838@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Mon, 3 Dec 2007 15:36:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <28409161.1196682960040.JavaMail.root@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I use Xenomai with linux 2.6.20 too on PXA270 machine.
The bug is about context switching with iWMMX coprocessor of PXA and is
corrected in Xenomai 2.4-rc7.

Good luck.

Patrick

-----Message d'origine-----
De=A0: xenomai-core-bounces@domain.hid =
[mailto:xenomai-core-bounces@domain.hid] De
la part de linux@domain.hid
Envoy=E9=A0: lundi, 3. d=E9cembre 2007 12:56
=C0=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)

I want to use Xenomai on openembedded (2.6.20 or higher) dist. for =
PXA270
board (compulab CM-X270). The kernel freezes during boottime after the
Xenomai nucleus etc is has started, is this bug the cause of this =
freezing?
Must I make the modifications by hand, i can't find them in the svn!

Henk Geraads=20

--
This message was sent on behalf of linux@domain.hid at
openSubscriber.com
http://www.opensubscriber.com/message/xenomai@xenomai.org

_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core


