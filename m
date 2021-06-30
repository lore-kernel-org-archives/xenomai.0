Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/2] [florian/y2038] try to acquire mutex before checking
 timeout
Date: Wed, 30 Jun 2021 14:31:06 +0800
Message-Id: <1625034666-29093-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is going to change mutex_timedlock's behavior, instead of
validating timeout first, it tries to acquire resource at the beginning and
returns 0 if resource is available even timeout is invalid.

smokey test for mutex should be adjusted regarding the change. 

Song Chen (2):
  y2038: cobalt/posix/mutex: try acquire mutex before checking timeout
  y2038: testsuite/smokey/2038: move mutex test to another thread

 kernel/cobalt/posix/mutex.c            |  5 +++
 testsuite/smokey/y2038/syscall-tests.c | 74 +++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.7.4


