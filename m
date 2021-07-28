From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>
Subject: [PATCH 0/7] Update fec driver for xenomai 3 and linux kernel 5.4 and
 add I.MX8 support
Date: Wed, 28 Jul 2021 09:27:55 +0200
Message-Id: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Current fec driver does not build on xenomai 3 and on recent kernel (ex : 5.4). This driver was completely rewritten on mainline kernel.
This work uses previous work from Gilles Chanteperdrix and Philippe Gerum (rebase over original driver from kernel 4.14.85 for xenomai 3) (patch 1 to 3), update the driver to 5.4 kernel and i.MX8Q (patch 4 and 5), fix buffer free issue (patch 6) and reduce latency  (patch 7).
This set was tested on i.MX8Q target

Arnaud Bouvet (1):
  net/drivers: fec: remove 1ms latency on frames reception

Gilles Chanteperdrix (2):
  utils/net: rtifconfig: display device name untruncated
  net/stack: rtskb: increase buffer size

Jean-Baptiste Trédez (3):
  net/drivers: fec: update from linux kernel 5.4 and NXP I.MX8
  Kconfig : enable fec for ARM64 build
  net/drivers: fec: fix dev_kfree_rtskb on wrong buffer

Philippe Gerum (1):
  net/drivers: fec: rebase over original driver from kernel 4.14.85

 kernel/drivers/net/drivers/Kconfig            |   11 +-
 kernel/drivers/net/drivers/Makefile           |    6 +-
 kernel/drivers/net/drivers/fec.c              | 1859 -------
 kernel/drivers/net/drivers/freescale/Makefile |    5 +
 kernel/drivers/net/drivers/freescale/fec.h    |  642 +++
 .../drivers/net/drivers/freescale/fec_main.c  | 4676 +++++++++++++++++
 .../drivers/net/drivers/freescale/fec_ptp.c   |  638 +++
 kernel/drivers/net/drivers/rt_fec.h           |  153 -
 kernel/drivers/net/stack/include/rtskb.h      |    2 +-
 utils/net/rtifconfig.c                        |    2 +-
 10 files changed, 5975 insertions(+), 2019 deletions(-)
 delete mode 100644 kernel/drivers/net/drivers/fec.c
 create mode 100644 kernel/drivers/net/drivers/freescale/Makefile
 create mode 100644 kernel/drivers/net/drivers/freescale/fec.h
 create mode 100644 kernel/drivers/net/drivers/freescale/fec_main.c
 create mode 100644 kernel/drivers/net/drivers/freescale/fec_ptp.c
 delete mode 100644 kernel/drivers/net/drivers/rt_fec.h

-- 
2.17.1


