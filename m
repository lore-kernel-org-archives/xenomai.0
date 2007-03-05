Message-ID: <6177643.1173082156861.JavaMail.ngmail@domain.hid>
Date: Mon, 5 Mar 2007 09:09:16 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Dual Core CPU - L2 Cache organization/reservation
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

Hi all,

I made excellent results with Xenomai and the dual core Pentium D CPU.
I use one of the cores for real time code, the other core is used for house=
keeping, communication...
Excellent means, that the runtime jitter of the real time application is ex=
tremely low.
For example, I have a physical model running that takes about 40 microsecon=
ds to run.
The runtime jitter on the dual core CPU is less than 3 microseconds. On the=
 uni processor machine,
the runtime jitter is about 40-60 (!) microseconds.
On the dual core CPU the model seems to run completely out of the cache whi=
ch is perfect for achieving
excellent computation times. On the UP system, the non-real time code seems=
 to "eat up" the cache occasionally used by the real time core, i.e. the re=
al time code has to re-load its cache from memory.

Now I read about the way the cache is organized in Intel's Core 2 Duo serie=
s. Here one common cache is=20
used that is shared between both cores.
I have now the fear, that the Core 2 Duo CPU does not show this excellent r=
esults as the Pentium D as the non-real time code might "eat up" the cache =
as it does on a UP system.

Or is there a way that allows me to "reserve" parts of the common cache for=
 one Core (or for the real time application, i.e. for certain physical addr=
esses)?
Of course a real Multi CPU system (Xeon based) might help (Server/Workstati=
on), however these systems=20
are fairly expensive compared to the Core 2 Duo desktop systems...

Thanks for all feedback on this issue!

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

