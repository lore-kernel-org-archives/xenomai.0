From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 25 Jan 2006 15:52:10 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601251552.10271.lbocseg@domain.hid>
Subject: [Xenomai-help] RTDM and udelay
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Is there any alternative to udelay on RTDM?

Or should I do something like:

void rt_udelay(unsigned int usec) {
  uint64_t timeout =3D rtdm_clock_read () + usec;
  while (rtdm_clock_read () < timeout);
}

Or maybe my design is wrong.

I have a function, say WriteI2C(...). Should I create it as a task and call=
=20
rtdm_task_sleep?

Thanks,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



