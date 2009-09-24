Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 24 Sep 2009 23:50:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200909242350.25916.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] Comedi/RTDM becomes Analogy.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai@xenomai.org

Hi,

About two years ago, I started an effort aimed at porting the Comedi framew=
ork=20
over RTDM. The goal was to provide, for the acquisition applications, stric=
t=20
determinism from kernel to user space.

As the work progressed, it seemed to me that such effort should be an
opportunity to improve the Comedi framework itself (the internal buffer=20
management is a good example)

A few months back, I tried once again to get some feedback from the
original Comedi team, this time about the suggested changes, so that I
could eventually submit patches which could get accepted into the
mainline Comedi tree. =20

http://marc.info/?l=3Dcomedi&m=3D114459505305823&w=3D4
http://groups.google.com/group/comedi_list/browse_thread/thread/85be8195ddf=
52896#
http://marc.info/?l=3Dlinux-next&m=3D124078248400745&w=3D2
http://lkml.org/lkml/2009/5/6/543

=46rom the answers I got (or lack thereof), it seems to me that goal #1
for the Comedi team now is rather to get their current code base into
Linux mainline, with only the required changes to be accepted
upstream. Changing the Comedi internals and/or adjusting its APIs is
clearly not on the agenda.

Therefore, there is no point in trying to port mainline Comedi over
RTDM anymore, hoping for suggested changes to be merged back to the
original tree over time. At any rate, the only thing that makes sense
now is to keep on developing a full-featured acquisition framework
(synchronous and asynchronous analogic/digital acquisitions,
calibration tool box, etc.), within the frame of a completely
independent effort.

To reflect this new orientation, Comedi/RTDM becomes Analogy.

By the way, the "Analogy" renaming does not mean we get rid of digital=20
acquisition features, we still target any control and measurement device.

Alexis.

