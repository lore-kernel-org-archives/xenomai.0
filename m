Message-ID: <22908039.1178707932628.JavaMail.ngmail@domain.hid>
Date: Wed, 9 May 2007 12:52:12 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai and futexes - Native API optimized for user
 space only applications
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

I am using Xenomai for a high performance real time simulation system.=20
All of the simulation code is executed within user space. One application i=
s running that consists
of several Xenomai real time threads.
For performance reasons I am always using the latest PC technology availabl=
e (which is currently
Pentium D or Core2Duo PCs, we are thinking even of using quad-core CPUs).
There has to be a kind of thread synchronisation e.g. when accessing shared=
 data.
Hardware I/O is done via rtnet or via PCI I/O boards that work in user spac=
e aswell (PCI memory
mapped into the user space).
This is done e.g. by using semaphores, mutexes et.c
I like the Xenomai-native skin as it provides a very clear API that is easy=
 to use.
However, for a user space only application it is a performance killer, that=
 all API calls
lead to a mode switch from user to kernel space. Each API call takes about =
1-2 microseconds (us)
on my PC which is really expensive.
Especially when inter process communication is used to protect the access t=
o shared data
it is mostly the case that the calling thread does not have to wait. In thi=
s situation there is no
need for a context switch. The API call did not lead to a rescheduling of t=
he available tasks.
And for this the required 1-2 us do really hurt.

Thus my question/proposal is if there is a plan to use a "variant" of the n=
ative API that is optimized for
user space only applications. In this case e.g. futexes can be used. If the=
re is a need to
reschedule to another task it is fine to "invest" the 2us but it can be avo=
ided mostly which should
increase the overall performance dramatically.
This would lead to a library where a big part of the functionality is handl=
ed directly in the library=20
(in user space). Currently the skin passes the (user space) API call via a =
Xenomai System call=20
to the kernel space to execute there the actual functionality.

Thanks for any feedback on this proposal.

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

