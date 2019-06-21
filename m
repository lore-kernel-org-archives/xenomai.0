From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v2 0/1] cobalt/rtdm: allow for device teardown
Date: Fri, 21 Jun 2019 11:49:21 +0200
Message-Id: <20190621094922.17558-1-rpm@xenomai.org>
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

This is the second iteration of the device teardown feature, the one
that... well, works.

Furthermore, it does not require any addition to the existing drivers
to enable them for teardown support, unless they are currently broken
in the first place. Drivers with broken close() handlers would still
hang upon teardown, nothing worse with this change in.

The patch sent earlier changing the hand over status code in libcobalt
is a prerequisite for applications to detect the teardown condition
unambiguously. The patch fixing the module refcounting for RTnet is
required to have the teardown process work for the network stack.

Philippe Gerum (1):
  cobalt/rtdm: allow for device teardown

 include/cobalt/kernel/rtdm/driver.h |  1 +
 include/cobalt/kernel/rtdm/fd.h     |  2 ++
 kernel/cobalt/rtdm/core.c           | 25 ++++++++++++++++++++-----
 kernel/cobalt/rtdm/device.c         | 21 +++++++++++++++++++--
 kernel/cobalt/rtdm/fd.c             | 22 ++++++++++++++++++----
 kernel/cobalt/rtdm/internal.h       |  6 ++++++
 6 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.21.0


