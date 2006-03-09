From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Thu, 9 Mar 2006 14:43:25 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603091443.25714.lbocseg@domain.hid>
Subject: [Xenomai-core] RTDM and Timer functions
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

Hi Jan,

I'm still concerned about the future of RTDM and timer functions. I think=20
there should be some function for starting the timer manually, since the=20
automatic feature don't work great for RTDM drivers.

It is not nice to have to run the latency (or any other) program for starti=
ng=20
the timer before I can load my driver. And it is not suffice to run it once=
 I=20
booted. After I open/close my rtdm device and reload my driver the problem =

will occur again and I'll have to re-run the latency program.

Do you have any plans to correct this undesirable behaviour?

I don't even have an idea why the timer stops once it is started... Actuall=
y=20
I'm not sure why does rtdm_clock_read should depend on the xenomai timer. A=
t=20
least, I think there should be a note in the rtdm_clock_read documentation =

stating that it only works after the timer has been started.

Best Regards,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



