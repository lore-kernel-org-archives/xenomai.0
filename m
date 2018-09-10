From: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 10 Sep 2018 09:24:46 +0200
Message-Id: <E1fzGi2-0003xx-IR@xenomai.org>
Subject: [Xenomai] [PATCH 0/1] fix breakpoint handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

Hi Dmitriy,

This patch fixes a long-standing issue with handling breakpoints set
by a debugger when hit by a thread running in primary mode. Hw
breakpoint events are properly routed to the co-kernel,
software-triggered ones are not.

Philippe Gerum (1):
  arm64: ipipe: route debug exceptions to co-kernel

 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.14.4


