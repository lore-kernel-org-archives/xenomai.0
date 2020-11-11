From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: [xenomai-images][PATCH 0/1][REV 1] Enable RTDM SPI on BeagleBone Black
Message-Id: <2D9558F9-78C0-4C72-AD8B-719B8E0BE205@gmail.com>
Date: Wed, 11 Nov 2020 22:37:50 +0300
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

=46rom dbc3add6bb3130d40602d3144d152acc0e0e3bd9 Mon Sep 17 00:00:00 2001
From: Deniz Ugur <deniz343@gmail.com>
Date: Wed, 11 Nov 2020 22:27:07 +0300
Subject: [xenomai-images][PATCH 0/1][REV 1] Enable RTDM SPI on =
BeagleBone Black
To: xenomai@xenomai.org
Cc: quirin.gylstorff@siemens.com

Tested on the next branch but it possibly works on master as well.
I've tried not to modify too many defconfig values but it wasn't
possible to make it work without these modifications.

Worst latency during spitest was around 100us. Although, I don't think
that's related to this patch.

On a final note, I'm not really sure if it's possible to assign
spi0_cs1 but if that's possible then a second channel for SPI0 can be
enabled.
Any feedback on that would be appreciated.

Deniz Ugur (1):
  Enable RTDM SPI on BeagleBone Black

 recipes-core/customizations/customizations.bb |   9 +-
 recipes-core/customizations/files/post-bbb    |   5 +
 ...01-BeagleBone-Black-RTDM-SPI-enabled.patch | 110 ++++++++++++++++++
 recipes-kernel/linux/files/bbb.cfg            |  28 +++++
 recipes-kernel/linux/linux-xenomai.inc        |   9 +-
 5 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 recipes-core/customizations/files/post-bbb
 create mode 100644 =
recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
 create mode 100644 recipes-kernel/linux/files/bbb.cfg

--=20
2.17.1


