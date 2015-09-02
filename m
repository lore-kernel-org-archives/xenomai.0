MIME-Version: 1.0
Date: Wed, 2 Sep 2015 14:19:29 -0700
Message-ID: <CAJqUr7wKv5bsR-WuZh2wVtsCTEAWt4uAA3kcx_d2oY=znQWK5g@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] ipipe/ipipe-3.14.44-arm64,
	adding ipipe trace for arm64.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pull request for ipipe/ipipe-3.14.44-arm64, adding ipipe trace for arm64.


The following changes since commit 5711ae4e759acefd98f16f086029fbdbc8a3673e:

  ipipe/arm64: move local_async_enable out of ifdef IPIPE (2015-08-19
12:40:51 -0700)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/ipipe.git ipipe-3.14.44-arm64-ipipe-trace

for you to fetch changes up to 0c1da66af6c6da717a0a718e125d9538259aae65:

  ipipe/arm64: Define arm64 ipipe-tracer helper functions in head.S.
(2015-09-02 13:29:29 -0700)

----------------------------------------------------------------
Hongfei Cheng (1):
      ipipe/arm64: Define arm64 ipipe-tracer helper functions in head.S.

 arch/arm64/include/asm/ipipe.h |  6 +++---
 arch/arm64/kernel/head.S       | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c          |  4 ++++
 kernel/trace/ftrace.c          |  2 ++
 4 files changed, 45 insertions(+), 3 deletions(-)
