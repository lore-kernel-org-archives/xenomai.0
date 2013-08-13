From: Manuel Huber <manuel.h87@gmail.com>
Date: Tue, 13 Aug 2013 22:24:19 +0200
Message-Id: <1376425460-5853-1-git-send-email-manuel.h87@gmail.com>
Subject: [Xenomai] [PATCH] Xenomai recvmsg cmsg patch
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

Current implementation of Xenomai's recvmsg syscall doesn't
handle msghdr fields (msg_control, msg_controllen) correctly. It's
necessary to change msg_controllen to the number of bytes written
to the buffer and fix msg_control if it has been used to point to
the actual starting address of the buffer. This would be necessary
to apply another feature to RTnet that allows to pass timestamps
from the driver to userspace applications easily 
(like SO_TIMESTAMP...). Please apply ;)

Manuel


Manuel Huber (1):
  rtdm: Fix msghdr struct (cmsg) in sys_rtdm_recvmsg

 ksrc/skins/rtdm/syscall.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
1.8.3


