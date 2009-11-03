Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 4 Nov 2009 00:04:48 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200911040004.48756.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PULL REQUEST] analogy: critical bugfixes for the NI
	PCIMIO driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

Here are some important fixes for the NI PCIMIO driver. 

I would like to thank Cristian Axenie for giving me access to his development 
environment. These bugs were particularly noticeable on his PPC board (any 
acquisition triggered a CPU reboot).

Alexis.

The following changes since commit 255cf6b2bf8dca9dad05a1c169dcecf6e742955e:
  Alexis Berlemont (1):
        analogy: force NI TIO / MIO selections when NI PCIMIO is set

are available in the git repository at:

  ssh+git://git.xenomai.org/xenomai-abe.git analogy 

Alexis Berlemont (4):
      analogy: force NI MITE selection when NI PCIMIO is set
      analogy: fix a critical bug in the NI PCIMIO driver
      analogy: rename 8255 and NI PCIMIO driver
      analogy: fix a bug in NI PCIMIO driver

 ksrc/drivers/analogy/intel/8255.c                  |    2 +-
 ksrc/drivers/analogy/national_instruments/Kconfig  |    1 +
 .../analogy/national_instruments/mio_common.c      |   12 ++++++++----
 ksrc/drivers/analogy/national_instruments/pcimio.c |    2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

