From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/5] More RTnet fixes and updates
Date: Fri, 22 Mar 2019 10:59:30 +0100
Message-Id: <20190322095935.8066-1-rpm@xenomai.org>
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

Patch #0003 joins the never ending series of fixes removing unprotected
access to user memory from kernel space.

Patches #0004 builds on the multicast support posted earlier.

Christophe Carton (1):
  utils/net: ping: display min and average round-trip time

Gilles Chanteperdrix (1):
  net/stack: increase maximum number of ethernet devices

Philippe Gerum (3):
  net/drivers: e1000e: stop using deprecated pci_enable_msix()
  net/ipv4: ioctl: remove direct references to user memory
  net/drivers: fec: enable multicast

 kernel/drivers/net/drivers/e1000e/netdev.c    |   7 +-
 .../drivers/net/drivers/freescale/fec_main.c  |  60 ++++++
 kernel/drivers/net/stack/include/rtdev.h      |   2 +-
 kernel/drivers/net/stack/ipv4/ip_sock.c       | 172 +++++++++++++-----
 utils/net/rtping.c                            |  16 +-
 5 files changed, 199 insertions(+), 58 deletions(-)

-- 
2.20.1


