MIME-Version: 1.0
Date: Wed, 2 Sep 2015 14:18:00 -0700
Message-ID: <CAJqUr7w_HXCCcxC5GzygKPvf0w5-K7o8K0Q7eCm5HMBUOyhy7A@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] ipipe/ipipe-3.14.44-arm64,
	adding missing ipi_timer change
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pull request for ipipe/ipipe-3.14.44-arm64, adding missing ipi_timer change.


The following changes since commit 5711ae4e759acefd98f16f086029fbdbc8a3673e:

  ipipe/arm64: move local_async_enable out of ifdef IPIPE (2015-08-19
12:40:51 -0700)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/ipipe.git ipipe-3.14.44-arm64-stage

for you to fetch changes up to 0475f0c95fcf7f78bac50575d5523028cb9b2af5:

  ipipe/arm64: tick_receive_broadcast -> ipi_timer. Change was missed in
"apply ipipe arch/arm/{kernel,include,asm,Kconfig} changes to
arch/arm64/kernel" (2015-08-31 10:03:37 -0700)

----------------------------------------------------------------
Don Mahurin (1):
      ipipe/arm64: tick_receive_broadcast -> ipi_timer. Change was missed
in "apply ipipe arch/arm/{kernel,include,asm,Kconfig} changes to
arch/arm64/kernel"

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
