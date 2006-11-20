Message-ID: <5517606.1164028545775.JavaMail.ngmail@domain.hid>
Date: Mon, 20 Nov 2006 14:15:45 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] removing orphaned xenomai registry entries
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

Hi everybody,

especially in the development phase of a project, I have the situation to c=
reate some=20
entries like events that end up in the Xenomai's registry.
However, while developing I exit my application before processing the clean=
 up phase.
This means, that I have a couple of orphaned events in the registry
(e.g. in /proc/xenomai/registry/native/events).
How can I force Xenomai to remove this entries?
Is there something like a rmxeno  that works like rm or rmmod and removes s=
pecified
elements? (if not: Isn't this an idea for any of the next versions of Xenom=
ai....)
The only way I found out is to reboot the PC which is not nice as it takes =
a while.
Of course, in a final application I should never have this situation, howev=
er in the development
phase this might occur fairly often.

Thanks for any feedback on this.

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

