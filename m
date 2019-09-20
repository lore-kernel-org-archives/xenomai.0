From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v5 0/1] Device teardown
Date: Fri, 20 Sep 2019 18:59:29 +0200
Message-Id: <20190920165930.6732-1-rpm@xenomai.org>
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

Fixes the broken fd flush loop from v4 (now implemented in
rtdm_device_flush_fds()) along with a use-after-free bug detected by
KASAN (*), and properly serializes accesses to the per-device openfd
list on fdtree_lock.

(*) list_get_entry_init() is introduced for that purpose, making sure
__put_fd() does not attempt to dequeue fds which have already been
flushed.

Philippe Gerum (1):
  cobalt/rtdm: allow for device teardown

 include/cobalt/kernel/list.h        |  8 +++++
 include/cobalt/kernel/rtdm/driver.h |  1 +
 include/cobalt/kernel/rtdm/fd.h     |  8 +++++
 kernel/cobalt/rtdm/core.c           | 10 +++---
 kernel/cobalt/rtdm/device.c         |  9 +++--
 kernel/cobalt/rtdm/fd.c             | 56 +++++++++++++++++++++++++++--
 kernel/cobalt/rtdm/internal.h       |  6 ++++
 kernel/drivers/testing/rtdmtest.c   |  2 ++
 8 files changed, 89 insertions(+), 11 deletions(-)

-- 
2.21.0


