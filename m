From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/2] For review - core RTDM, RTnet changes
Date: Thu, 20 Jun 2019 19:29:32 +0200
Message-Id: <20190620172934.31393-1-rpm@xenomai.org>
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

I'm sending these changes early on for review because they might have
ramifications, so more eyeballs are needed to make sure nothing was
overlooked.  These changes are prereqs to addressing the device
teardown issue properly, so there is even more incentive to have them
right.

Thanks,

Philippe Gerum (2):
  drivers/net: drop socket-specific module refcounting
  cobalt: switch hand over status to -ENODEV for non-RTDM fd

 kernel/cobalt/rtdm/fd.c                       |  7 +--
 .../drivers/net/stack/include/rtnet_socket.h  | 15 ++----
 kernel/drivers/net/stack/ipv4/icmp.c          |  4 +-
 kernel/drivers/net/stack/socket.c             | 27 ++++-------
 lib/cobalt/rtdm.c                             | 46 +++++++++----------
 5 files changed, 40 insertions(+), 59 deletions(-)

-- 
2.21.0


