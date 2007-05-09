Message-ID: <20669310.1178719111471.JavaMail.ngmail@domain.hid>
Date: Wed, 9 May 2007 15:58:31 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0705091531560.22958@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <Pine.LNX.4.64.0705091531560.22958@domain.hid> <4641B5CF.80303@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<13086080.1178713660670.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: herman.bruyninckx@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Herman and Jan,

thanks for your replies.
I agree that is the best to do an approach that avoids critical sections.
However, we have here the typical "historical heritage". Parts of this code=
 have
been ported from another system (where they worked with cli/sti).
Other parts are generated from a third party code generator.
This code generator (which is not in my hand) is designed primarily
for offline simulation within a single task.
Thus, the guys that programmed that, did not care about multi thread progra=
mming.
The programs write the results into output variables.
To avoid critical section I have now to do either
an additional copy (also quite expensive) of the output data to a location=
=20
where I can work without any risk of being interrupted or I lock the access
 to the data.
That means either I do lots of additional copy actions (also quite expensiv=
e) or I work
with the critical region.

Thus for me it is not an either - or - option.
I can not optimize the code to be 100% free of critical sections (however i=
t can be done in
some parts..). That means I still have to count on the IPC provided by the =
OS.

Regards

Mathias

> > The critical region in the simulation are at locations when a lower pri=
o
> > thread and a higher prio thread access the same data. This happens at a
> > couple of times within a simulation step (within that critical region
> > there are typically some copy operations).
>=20
> I agree with Jan Kiszka (in another reply in this thread) that it's
> probably better to improve the design of your application than to shift t=
he
> problem to asking for "yet another feature" of the RTOS!
>=20
> In our robot control framework (orocos.org) that works as a user space
> application on top of Xenomai we have implemented lock-free data exchange=
,
> which does'nt require involvement of the scheduler at all, and which
> improves the timing performance of the highest priority thread. It might =
be
> useful for you to discuss this implementation aspect on the orocos
> developers mailinglist...
>=20
> Herman Bruyninckx
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

