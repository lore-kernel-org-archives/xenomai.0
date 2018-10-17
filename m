From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Wed, 17 Oct 2018 13:31:43 +0200
Message-Id: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to
 be built
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch series makes RTnet's tcp module usable again. It was not
selectable in Kconfig for a long time. Now it is supposed to work in
the way it worked when RTnet was a separate project for Xenomai 2.

Sebastian Smolorz (4):
  net/tcp: return ufd in rt_tcp_accept()
  net/tcp: fix listen() and shutdown() IOCTL calls
  net/tcp: Fix bug when obtaining RST socket's private structure from
    its rtdm_fd pointer
  net/tcp: Allow choice of rttcp protocol in Kconfig

 kernel/drivers/net/stack/ipv4/Kconfig   |  2 +-
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 16 ++++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

-- 
2.7.4


