MIME-Version: 1.0
Date: Tue, 15 Sep 2015 21:34:41 -0700
Message-ID: <CAJqUr7yEepPti2-DzW+5NXNTC1JY-eei2C9wQ+rQ7aVxNhxQZw@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] ipipe-3.14 fix setting of
	IPIPE_IRQS_NEEDS_STARTUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pull request for fix setting of IPIPE_IRQS_NEEDS_STARTUP. Applies in other
kernels as well.


The following changes since commit 4a903c4ac406d52d84f2a438df939e73ac17bef3:

  ipipe-core-3.14.44-arm-12 (2015-08-15 17:35:19 +0200)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/ipipe.git ipipe-3.14

for you to fetch changes up to d62d986645aa5853541c06cb4cba067bb4110bbb:

  ipipe: Fix setting of IPIPE_IRQS_NEEDS_STARTUP in irq_shutdown()
(2015-09-15 21:14:45 -0700)

----------------------------------------------------------------
Mark W. Tyler (1):

      ipipe: Fix setting of IPIPE_IRQS_NEEDS_STARTUP in irq_shutdown()

 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
