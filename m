Message-ID: <10623239.1168007940021.JavaMail.ngmail@domain.hid>
Date: Fri, 5 Jan 2007 15:39:00 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Dynamic load of shared object files in real time
	applications
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

I have a question that is similar to the one concerning the system() call o=
ut of
a real time context.
I want to create a flexible framework that allows dynamic loading of shared=
 objects
during runtime. (The loading itself can of course not work in real time).
The main application itself should run for a very long time (a couple of da=
ys)
and during that long run time I want to load and unload small pieces of cod=
e that
have to be executed.
After loading a .so file I want to hook loaded routines into the (already e=
xisting) real time context
of my main application.
Is it possible that this kind of operation can cause any memory issue simil=
ar to that
I detected in the 2.6.19 kernel (the system() call out of a real time conte=
xt)?
I ask as the dlopen() call probably extends the valid address range of the =
current
process.

Thanks for any feedback on that question.

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

