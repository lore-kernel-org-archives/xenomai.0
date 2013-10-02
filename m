From: Manuel Huber <manuel.h87@gmail.com>
Date: Wed,  2 Oct 2013 22:47:37 +0200
Message-Id: <1380746860-1409-1-git-send-email-manuel.h87@gmail.com>
Subject: [Xenomai] [PATCH 0/3] Fix control messages in sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@web.de
Cc: xenomai@xenomai.org

This patch-set shall fix the recvmsg system-call and its handling
of control messages and the msghdr structure. It is necessary
to be able to apply another patch to RTnet, which depends on a
correct handling of msg_controllen.
Jan pointed out, that all driver code that relies on the current
interface has to be adapted to the new one. I checked the driver
code and I found can drivers to be the only ones affected.
Finally, the changes to the system call have been documented in
rtdm_driver.h header file. Please let me know if it's unclear...

I used a recent linux kernel as reference of how to implement the
handling of msghdr. The patch changes the hadnling of msg_namelen
as it won't get written back to user-space if it has been modified
by driver code. That's what the Kernel does. However, there are
also drivers in the Kernel tree that write to msg_namelen, so I'm
not really sure what's the correct behaviour. So this might break
user code that relies on this write-back although I can't really
imagine a use-case where you actually need to check the size.
Usually you have to know the address type (structure) to be able
to interepret the address correctly.

Manuel Huber (3):
  rtdm: Fix msghdr struct (cmsg) in sys_rtdm_recvmsg
  rtcan: Adapt rtcan_raw to changes in rtdm
  doc: Add documentation to rtdm_recvmsg_handler_t

 include/rtdm/rtdm_driver.h   |  9 ++++++++-
 ksrc/drivers/can/rtcan_raw.c | 33 ++++++++++++++++-----------------
 ksrc/skins/rtdm/syscall.c    | 18 ++++++++++++++----
 3 files changed, 38 insertions(+), 22 deletions(-)

-- 
1.8.3


