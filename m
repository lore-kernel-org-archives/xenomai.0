From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Mon, 20 Mar 2006 17:15:08 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603201715.08482.lbocseg@domain.hid>
Subject: [Xenomai-core] rt-video interface
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

Hi Jan and others interested.

I've finally got my driver in a usable condition. It lacks a lot of=20
functionalities yet, but it aplies to my needs.

I would like to propose a real-time video interface for using with RTDM.

For making it simple to port Linux applications to Xenomai, I tried to make=
 it=20
as close as possible to Video for Linux 2 API. I didn't see any serious=20
problem regarding its use on real-time environments in the specification. S=
o,=20
the changes I think that would be necessary are:

o Change open/fopen to rtdm_dev_open
o Implement MMAP/MUNMAP as an IOCTL (while it can not be done in a rt-conte=
xt=20
in the mean time, nor should be necessary)
o Implement also as IOCTLs: select and poll (I didn't implement them on my =

driver because I didn't need them, but it should be necessary accordling to=
=20
specs)
o Change all timeval structs to uint64_t or some typedef to it for making i=
t=20
easier to store the timestamps (we use rtdm_clock_read() instead of=20
gettimeofday())

I can't remember of another issue now. I think these changes would be enoug=
h.

Any ideas?

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


