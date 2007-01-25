Message-ID: <4080619.1169710201822.JavaMail.ngmail@domain.hid>
Date: Thu, 25 Jan 2007 08:30:01 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] isolating unwanted mode switch
In-Reply-To: <cbe23c50701241055l5efa3f50p768f7d37d2d7cb8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <cbe23c50701241055l5efa3f50p768f7d37d2d7cb8@domain.hid>
	<200701231448.35285.jweber@domain.hid>
	<200701231627.51851.jweber@domain.hid>
	<b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
	<200701241152.21747.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: eric.noulard@domain.hid, jweber@domain.hid
Cc: xenomai@xenomai.org

Hi all,

one other issue that comes in my mind:
The usage of C++ in a real time application could be fairly difficult, as=
=20
C++ might create temporary objects (using new(), which will probably=20
be realized with a malloc()). It is hard to identify what's happening with
the memory without an excellent understanding of the compiler.
That's why I try to avoid C++ and real time application and use plain C...
I do not know Jeff's application, however I think it could be worth to
have a look on that.

Regards

Mathias
> > On Wednesday 24 January 2007 04:08, Dmitry Adamushko wrote:
> > > On 23/01/07, Jeff Weber <jweber@domain.hid> wrote:
> > > > Dimitry:
> > > > > ...
> > > > > exceptions (CPU exceptions, e.g. page faults). I presume, you hav=
e
> > > > > done mlockall(CURRENT | FUTURE), haven't you?
> > > >
> > > > Yes.  my Linux application follows this this model:
> > > >
> > > > main () {
> > > >          mlockall(MCL_CURRENT | MCL_FUTURE);
> > > >         rt_task_shadow( ... )  // become a realtime thread
> > > >
> > > >         // for N threads:
> > > >                 rt_task_spawn( ... ) // fork off child RT thread
> > > > }
> > > >
> > > > It is one of the child RT threads that encounters the SIGXCPU
> unwanted
> > > > mode switch.  It this the correct way to call mlockall() ?
> > >
> > > Looks ok. Just to avoid getting into the same trap twice. You don't
> > > use system(), fork() or alike beasts in your code, do you?
> > No.
> >
> > BTW, a primary mode thread in my application encountered the page fault
> > writing to the BSS segment.
>=20
> Are your variables all properly initialized, before mlockall ?
>=20
> >
> > How would my application encounter a page fault after calling
> > mlockall(CURRENT | FUTURE) ?
> >
> > Perhaps an answer is that mlockall() prevents pages from ever being pag=
ed
> out,
> > but the application may still encounter page faults upon referring to
> pages
> > that were never paged in when mlockall() was called.  If true, then my
> > application may continue to encounter page faults, and hence switches t=
o
> > seondary mode until all pages in the application are loaded.
>=20
> I am no Memory Handling expert nor Xenomai expert
> but I think you may get a page fault when you require more memory
> you used before you call mlockall(CURRENT | FUTURE),
> that is growing stack, mmap calls,  malloc etc...
>=20
> Does you application has some unbounded or not pre-computed memory
> requirement (recursive call, malloc/calloc/alloca call etc.., mmap call)?
>=20
> I may imagine the case where your system is short of memory
> then you app requires more memory then you get page fault.
>=20
> As a simple check, did you verify your mlockall syscall succeed?
> I remember an application of mine which did not verify the returned
> code and discover later that the call did not succeed :(((


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

