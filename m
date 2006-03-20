From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
Date: Mon, 20 Mar 2006 16:01:07 -0300
References: <44172B67.2000609@domain.hid>
	<200603201137.12548.rosenfeld@domain.hid>
	<441EC906.3050104@domain.hid>
In-Reply-To: <441EC906.3050104@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603201601.07420.lbocseg@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Em Segunda 20 Mar=3DE7o 2006 12:23, Philippe Gerum escreveu:

>...
>It's not a matter of dealing with users always doing The Right Thing,
>but preferably preventing people from doing the wrong one.

But we then have two problems and there are tradeoffs here. In one hand we=
=3D
=3D20
want to avoid users from making mistakes. In the other hand we want to=3D20
provide a way for solving the issue that generated this thread.

A solution for the last one would be to have a function that would return a=
=3D
=3D20
high-precision timestamp, not necessarily in sync with xenomai's timer, sin=
=3D
ce=3D20
it would be used for relative time calculations, but should be in sync=3D20
between multiple CPUs. But this solution would rise the possibility for a=
=3D20
user to do a wrong thing. Of course, the functions should be well documente=
=3D
d=3D20
and states the lack of sync if it is the case. So, we have to choose betwee=
=3D
n=3D20
turning it possible to have such design (as the example I have last message=
=3D
)=3D20
or avoid people from doing the wrong thing. I would choose the first case,=
=3D
=3D20
since I think all rt-programmers are smarter (or should be) then the averag=
=3D
e=3D20
programmer. They must have attention when dealing with rt-programming. So,=
=3D
=3D20
reading a documentation and understanding it should not be a hard task for=
=3D
=3D20
them... In the other hand, if the second approach was chosen, a user wantin=
=3D
g=3D20
to use a rt-video interface will be forced to use the aperiodic timer for=
=3D20
having reliable timestamps...

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


