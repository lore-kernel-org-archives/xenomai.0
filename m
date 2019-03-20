From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/5] serial, net, testsuite fixes
Date: Wed, 20 Mar 2019 16:44:20 +0100
Message-Id: <20190320154425.30639-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

No critical changes here; although patch #0002 fixes a locking
imbalance in some error path, the latter is in theory impossible to
trigger.

Philippe Gerum (5):
  testsuite/gpiotest: define missing 'timestamp' argument
  drivers/serial: imx: fix locking imbalance upon -EBADF
  drivers/serial: imx: drop useless EWOULDBLOCK->EAGAIN remapping
  net/drivers: macb: do not check for initial checksum value
  net/drivers: stack: remove unused assertion

 doc/asciidoc/MIGRATION.adoc              |  4 +---
 kernel/drivers/net/drivers/macb.c        |  2 --
 kernel/drivers/net/stack/include/rtskb.h |  2 --
 kernel/drivers/serial/rt_imx_uart.c      |  6 +-----
 testsuite/gpiotest/gpiotest.c            | 11 ++++++-----
 5 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.20.1


