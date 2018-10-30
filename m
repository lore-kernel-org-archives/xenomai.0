From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH 0/3] fix several compilation and linking errors with old
 toolchains
Date: Tue, 30 Oct 2018 11:29:11 +0100
Message-Id: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sebastian Smolorz (3):
  lib/cobalt: Do not call glibc's {recv|send}mmsg if it is too old
  cobalt/time: add missing include for old toolchains
  utils/analogy: fix compilation of analogy_calibrate with old
    toolchains

 include/cobalt/time.h             | 1 +
 lib/cobalt/wrappers.c             | 8 ++++++++
 utils/analogy/analogy_calibrate.c | 1 -
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.7.4


