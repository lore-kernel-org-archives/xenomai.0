From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [wip/dovetail][PATCH 0/2] Bring back ia32 support for some
Date: Thu, 11 Mar 2021 17:38:25 +0100
Message-Id: <20210311163827.67202-1-florian.bezdeka@siemens.com>
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
To: xenomai@xenomai.org, rpm@xenomai.org, jan.kiszka@siemens.com, chensong@kylinos.cn

As Jan mentioned that he needs a first test based on davtail I thought
it might make sense to push that out...

That is the follow up of some topics detected while scanning the code
base for y2038 affected syscalls. Compile-time tested only so far and for
wip/dovetail branches only.

Florian Bezdeka (2):
  cobalt/mutex: Bring back ia32 support for mutex_timedwait
  cobalt/mqueue: Bring back ia32 support for mq_timed{send,receive}

 kernel/cobalt/posix/mqueue.c | 3 +--
 kernel/cobalt/posix/mutex.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.29.2


