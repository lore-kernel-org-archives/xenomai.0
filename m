Date: Mon, 18 Dec 2017 10:26:30 +0800
From: Peng Fan <van.freenix@gmail.com>
Message-ID: <20171218022628.diwrxfzjqmuqvgml@linux-u7w5.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] xenomai cyclictest negative Max value
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I compiled xenomai-next on my ARM64 platform, but met Max and Avg not correct.
See below:

./cyclictest -a -t10 -n -p99 -c 0
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.97 0.51 0.21 1/135 3018
policy: fifo: loadavg: 1.00 0.76 0.38 1/128 3018
T:[  200.650323] random: crng init done      0 Act:    0 Avg:443149053456561 Max:      -1
T: 0 ( 3002) P:99 I:1000 C: 373066 Min:      0 Act:    0 Avg:395570629834068 Max:      -11
T: 1 ( 3003) P:99 I:1500 C: 248710 Min:      0 Act:    0 Avg:148339383810136 Max:      -111
T: 2 ( 3004) P:99 I:2000 C: 186532 Min:      0 Act:    0 Avg:593359125738518 Max:      -1
T: 3 ( 3005) P:99 I:2500 C: 149359 Min:      0 Act:    0 Avg:123506076458128 Max:      -11
T: 4 ( 3006) P:99 I:3000 C: 124465 Min:      0 Act:    0 Avg:592833136181562 Max:      -1
T: 5 ( 3007) P:99 I:3500 C: 106684 Min:      0 Act:    0 Avg:172910127795260 Max:      -111
T: 6 ( 3008) P:99 I:4000 C:  93349 Min:      0 Act:    0 Avg:1383273613171719 Max:      -1
T: 7 ( 3009) P:99 I:4500 C:  82977 Min:      0 Act:    0 Avg:666934598998863 Max:      -1
T: 8 ( 3010) P:99 I:5000 C:  74679 Min:      0 Act:    0 Avg:988055226969271 Max:      -11

Seems xenomai cyclictest and rt-tests cyclictest is not sync, or there are
some differecense. Could you please help me clarify what's the difference
between xenomai cyclictest and rt-tests cyclictest?  I did not find out which
exact commit number when importing rt-tests cyclictest to xenomai.

Thanks,
Peng.

-- 

