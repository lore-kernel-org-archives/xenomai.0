Message-ID: <4356A4DB.9050202@domain.hid>
Date: Wed, 19 Oct 2005 21:56:11 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] TLB misses on MPC 8xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

the output of the cache calibrator indicated, that TLB misses on the MPC
860 might influence latencies substantially.
Looking closer to the  Linux 2.6 kernel revealed, that TLB entries for
the kernel space (0xc0000000) are not pinned by default for the MPC 860
(like in 2.4). I enabled this advanced kernel option PIN_TLB and
furthermore patched the kernel to put modules in that kernel space by
using kmalloc instead of vmalloc. Then I get the following latency figures:

KLATENCY with load:

RTH|---lat min|---lat avg|---lat max|-overrun|--lat best|---lat worst
RTS|     50560|     98976|    199040|       0|  00:09:45
RTS|     50240|     89401|    174400|       0|  00:10:06 PIN_TLB
RTS|     48960|     85562|    164480|       0|  00:10:30 PIN_TLB+kmalloc

LATENCY with load:

RTH|---lat min|---lat avg|---lat max|-overrun|--lat best|---lat worst
RTS|     60480|    120960|    224320|       0|  00:09:46
RTS|     60800|    105600|    193600|       0|  00:09:56 PIN_TLB
RTS|     55680|     98240|    176640|       0|  00:15:01 PIN_TLB+kmalloc

This clearly shows, that TLB misses are one latency killer on low end
processors.

Wolfgang.

