Message-ID: <29258254.1164204998593.JavaMail.ngmail@domain.hid>
Date: Wed, 22 Nov 2006 15:16:38 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] What returns rt_task_self in
In-Reply-To: <1164204035.5006.305.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1164204035.5006.305.camel@domain.hid>
	<20403318.1164195534169.JavaMail.ngmail@domain.hid>
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>
	<45644D39.10007@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> On Wed, 2006-11-22 at 14:14 +0100, Jan Kiszka wrote:
>=20
> [...]
>=20
>=20
> Well, it actually does in intra-kernel calls, where rt_task_self()
> returns the container object of the base nucleus thread present in the
> RT_TASK struct the user passed us, even if nobody should rely on this
> fact. I would try to clear any confusion like this:
> "The address returned points at a descriptor identifying the calling
> task, which might be different from the descriptor address passed to
> rt_task_create()."
>=20
> > Jan
> >=20
> >=20
> > PS: Who's supposed to free the descriptor allocated by rt_task_self?
> > Would some check for pthread_getspecific(__native_tskey) + free() on
> > task self-destruction make sense? Will not catch all cases, I know.
> >=20
>=20
> We could add that, and the same stuff upon return from the task body
> inside the trampoline call, but the only way to solve this with no leak
> would be to call the nucleus at each invocation, and not use any cached
> descriptor here. Since TLS requires to be operated by the owning task,
> there is no point in trying to have a deleted task clean those up
> thoroughly.
What about the idea that it is possible to retrieve the cookie that is used=
 with
rt_task_start() ?
E.g. this could be provided with rt_task_inquire()?
The rt_task_info struct has to be expanded for that.

The main use case for this is that some user specific, task related data
has to be stored. One pointer should be sufficient.
I think, an approach that uses the Xenomai API for that is better than
to rely on TLS or NPTL as it is unclear if related actions lead to an unwan=
ted syscall.

One (very ugly) approach could be to code an address into the name of the t=
ask.
This name could be retrieved via rt_task_inquire()...

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

