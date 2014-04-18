Message-ID: <1397815203.1378.21.camel@port-msalvini.smigroup.local>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Fri, 18 Apr 2014 12:00:03 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Disable L2 write allocate on iMX6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I'm testing an iMX6q Sabrelite board from Element14 with Xenomai 2.6.3.

First of all I tried kernel 3.0.43 from Xenomai git branch
ipipe-3.0-imx6q. This kernel works well, a 15 hours running latency test
(with manually generated system load like dd, netcat, ssh) shows an
average latency of 5.690us and a worst case latency of 42.186us.
Then I tried 3.4.6 vanilla kernel, but in this case latency test average
result for is a bit worse, with a value around 18us. Worst case is about
the same (<50us).
I read in mailing list that L2 write allocate is disabled in 3.0.43
kernel (in facts log says: l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL
0x02870000, Cache size: 1048576 B).
This feature is enabled in 3.4.6 kernel ( log says: l2x0: 16 ways,
CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 1048576 B). Could
this be the cause of latency degradation observed in 3.4.6 kernel? I
also tried 3.8.13 with same results.
Kernel configurations are the default ones for each kernel, with hw_perf
disabled.

Thanks in advance
Mauro
