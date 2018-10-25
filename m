From: Philippe Gerum <rpm@xenomai.org>
Subject: [PULL REQUEST] fixes for GCC 8.x, automatic RTnet interface
 dismantling
Message-ID: <f5969ceb-572d-ffc5-c516-3810fb33a8fe@xenomai.org>
Date: Thu, 25 Oct 2018 11:43:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


This patch set addresses a couple of issues with GCC 8.x, and a current RTnet
limitation too.

Regarding the latter, I'd like a thorough review of 809847c58, to make sure it's
not breaking some assumption wrt interface management in RTnet. The motivation
for the change is to expose the necessary API bits in order to match the common
behavior for regular netdevices, dismantling any open interface prior to unloading
a driver module. The converse rtdev_up() call is there for consistency but has
no user yet.

Rationale: currently, modunloading drivers may leave stale information about
active interfaces, which leads to bad situations. b28741eb6 illustrates the
usage of the new call for the IGB driver. I don't think we could fold the
rtdev_down() call into rt_unregister_rtnetdev() yet, unless the latter could
be called earlier from the uninstall code of most drivers.

---

The following changes since commit 04df93890befa4e5a642ecdef38eebed4660b217:

  rtdm: expose user-side file descriptors to drivers (2018-10-17 13:20:06 +0200)

are available in the Git repository at:

  git://lab.xenomai.org/xenomai-rpm.git for-upstream/next

for you to fetch changes up to 2b819466ecb5d260c81edc32f0f032954df1759b:

  net/igb: igb_ioctl() requires execution in secondary mode (2018-10-25 10:57:22 +0200)

----------------------------------------------------------------
Philippe Gerum (9):
      utils/can: prevent unterminated destination buffer with strncpy()
      demos/posix: prevent unterminated destination buffer with strncpy()
      boilerplate/ancillaries: prevent false positive with -Wstringop-truncation
      cobalt/ancillaries: prevent false positive with -Wstringop-truncation
      boilerplate/compiler: drop __const and __pure shorthands
      net/stack: export services to switch interface up/down
      net/stack: ignore extraneous interface UP/DOWN calls
      net/igb: down interface upon PCI unregister
      net/igb: igb_ioctl() requires execution in secondary mode

 demo/posix/cobalt/can-rtt.c               |   4 ++--
 demo/posix/cobalt/eth_p_all.c             |   3 ++-
 demo/posix/cyclictest/cyclictest.c        |   4 ++--
 include/boilerplate/ancillaries.h         |   2 +-
 include/boilerplate/compiler.h            |   8 --------
 include/cobalt/kernel/ancillaries.h       |   2 +-
 kernel/drivers/net/drivers/igb/igb_main.c |   4 ++++
 kernel/drivers/net/stack/include/rtdev.h  |   4 ++++
 kernel/drivers/net/stack/rtdev.c          | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/drivers/net/stack/rtnet_chrdev.c   |  85 ++-----------------------------------------------------------------------------------
 utils/can/rtcanconfig.c                   |   7 ++++---
 utils/can/rtcanrecv.c                     |   3 ++-
 utils/can/rtcansend.c                     |   3 ++-
 13 files changed, 128 insertions(+), 103 deletions(-)

-- 
Philippe.

