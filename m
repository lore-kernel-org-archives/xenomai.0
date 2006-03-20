From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Mon, 20 Mar 2006 16:47:51 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603201647.51941.lbocseg@domain.hid>
Subject: [Xenomai-core] Interrupt priorities
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Philippe.

I was wondering if there are any plans to provide an option to Xenomai to=20
allow the use of interrupt priorities. I mean, by having the timer source a=
s=20
the most prioritary interrupt so that the scheduler could preempt the=20
interrupt.

Let me explain why such option would be good. When I was testing my=20
framegrabber driver, I had to reboot my PC about 10 times until I could=20
identificate what was causing total freeze of the system. The problem was o=
n=20
the interrupt handler. One of the problems was that I was not clearing the =

interrupt events correctly so that the handler was in loop. The other probl=
em=20
was a crash inside the interrupt due to something like:

uint64_t timestamp=3Drtdm_clock_read();
b.timestamp =3D *((struct timeval *) timestamp);

Where it should be
b.timestamp =3D *((struct timeval *) &timestamp);

I forgot the '&' char.

If it was possible to preempt the interrupt, by a task of greater priority,=
 I=20
could write a watchdog that would disable the interrupt in case the system =

stops responding.

Do you think it would worth providing such option to Xenomai, at least as a=
=20
debug feature?

Best Regards,

Rodrigo.

P.S: BTW, I think my driver is usable now, so that you (or someone else) co=
uld=20
cite it in some article or documentation. When I finish my master thesis (m=
y=20
deadline is the end of June ), I think I'll have time to comment it better =

and to remove the Data Translation specific code so that it can me made=20
available as a template for real-time video interfaces. Or maybe you could =

convince Data Translation to allow me to show all the code! ;)

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


