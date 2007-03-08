Date: Thu, 8 Mar 2007 16:50:57 +0100
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20070308155057.GA30862@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
Subject: [Xenomai-core] [ANNOUNCE] most4linux 1.0
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org, rtai@domain.hid
Cc: Gernot Hillier <gernot.hillier@domain.hid>, Steve Kreyer <steve.kreyer@domain.hid>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello @all,

a few days ago, most4linux 1.0 was released. This is a Linux driver
and a RTDM driver for a MOST (Media Oriented Systems Transport) [1]
PCI interface from SMSC [2]. The software can be downloaded at

    http://most4linux.sourceforge.net/

This is free software, the modules running in kernel space (both Linux
and RTDM) are licensed in terms of GPL v2, the userspace part is
licensed in terms of MPL (Mozilla Public License).


What does that software?
------------------------

The driver with the userspace sample programs is able to transfer
synchronous data in real-time over the MOST bus. There's also an ALSA
adaption layer to use the device as simple sound driver from Linux
(only non real-time).

This driver doesn't contain a complete NetService implementation for
MOST but only an adaption layer to use the commercial NetServices or
a free demonstration included with this software which is able to
initialise the routing table to transfer synchronous data properly.


On which systems runs the software?
-----------------------------------

The software was tested with:

  - Linux 2.6.17
  - RTAI 3.3
  - Xenomai 2.1

The software was compiled with Linux 2.6.21-rc1 and Xenomai 2.3 to
test. However, since I don't have hardware any more, I could not test
with the new versions. It was also only tested on i686 with a
single-CPU (no HT).


Why was this software developed?
--------------------------------

The software was developed as part of a Diploma Thesis at Siemens AG,
CT SE 2 in Munich. It should show how to port a Linux driver to
real-time Linux extensions, providing the same functionality and how
to separate parts which still can be run from Linux from the parts
that must be run in real-time.

So the main focus was not the MOST driver but the porting process,
and as part of the driver a small adaption layer was developed to
abstract from RTDM and Linux interfaces. That's the file rtnrt.h in
the driver. The scope was not to provide an adaption layer for all
drivers in the world but only to show the conecept and to avoid code
duplication inside the driver.

If you are more interested, the Diploma Thesis is available for free
at http://www.bwalle.de/docs/Diploma_Thesis.pdf (but this is not
public-domain or something like this).


What's the state and the future of the software?
------------------------------------------------

This software is in ALPHA state. So if you try it out and it doesn't
work, don't be very surprised.

About the future, to quote Gernot Hillier <gernot.hillier@domain.hid>
who supervised my thesis at Siemens:

    [...]
    Unfortunately, we currently don't plan doing further enhancements
    to this driver like porting it to other hardware. It was more or
    less an unplanned result of a thesis to show ways how to port
    drivers to a realtime extension - and as it was indeed a very good
    and usable result (thanks to Bernhard again!), we decided to open
    source it in the hope it might be useful.

    However, if a real user community forms around the project, we
    might rethink this decision. However I can't promise anything...
    [...]

However, I plan to adapt it to new kernel interfaces if possible. The
same is for RTDM releases.




Regards,
Bernhard

[1] http://en.wikipedia.org/wiki/Media_Oriented_Systems_Transport
[2] http://www.smsc-ais.com/AIS/

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUBRfAw0eiVHo+2lFT9AQJUJwP/REiT0zU/+XqW7aHvcsa47uY7mERrutuG
f+ELf1C6Dq9hoKXAr5PmZvRRDWNDvkWsjcIoci0TWUj+umJkmLeYKRJW10JkrVdd
vbpnGgQR0hN6b4i03YhIuwFs1D/+Bn7Ews5N4dfkXoSpEvcX8ACA2qwu7gyeRTO/
AbpsMS6xtC8=
=wJIj
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

