Message-ID: <21175505.1231747787507.JavaMail.ngmail@domain.hid>
Date: Mon, 12 Jan 2009 09:09:47 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai and Perfmon2?
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

I am using Xenomai for real time system that has to compute complex simulat=
ions.
For that, not only real time behaviour but also computation power is releva=
nt.
I am using Intel's Core 2 Duo/Quad CPUs.
The perfom2 package (http://perfmon2.sourceforge.net/) allows to access the=
 CPU's
perfomance monitoring registers fairly easily.
It contains a kernel patch and a user mode frontend.
I have now tried to apply the Xenomai patch (first) and the perfom2 patch (=
second) which seems to work
(some slight modifications on the perfom2 patch have been necessary) partia=
lly.
I can now use the system-wide mode of pfmon, however I can not attach from =
pfmon to a running
realtime task (the kernel freezes), but at least the system-wide mode is qu=
ite helpful.

My questions to this combination:
- Can the perfmon2 kernel patch somehow destroy the real time behaviour of =
the Xenomai executable?

- I am mostly interested in things like EIST mode (Intel speed Step) change=
s, bus access delays etc.
Is there more simple way to access this information but using the perfom2 p=
atch?

Thanks for any response on that questions!

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

