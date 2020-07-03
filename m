From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 0/2]GPIO Loopback Benchmark Tool
Date: Fri,  3 Jul 2020 14:37:15 +0800
Message-Id: <1593758235-9182-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In general, we use cyclictest and latency to evaluate the determinism of our real
time system. As we know, cyclictest and latency use hrtimer to set up a timer and
calculate jitter by comparing expected wakeup time and real wakeup time.

Besides that, we can also use GPIO to evaluate more modules in different scenarios. 
In this case, i apply 2 GPIO ports, one is set as output, the other is interrupt, 
at the same time, connect them with a cable. Once an signal is sent from output pin,
an interrupt will be raised in interrupt pin immediately.

Timestamps are recorded before gpio_set_value and interrupt handler respectively, the
diff between them is jitter.

There is also an RT task running in the user space, which collects the information and
output the summary at the end of the test. What's more, it also records the timestamps
in user space, syscall overhead is included.

Further, Making a little change will enable the tool working with latency box,once a
signal from latency box is received in interrupt pin, the tool can send a signal at
output pin as response. (I haven't got the latency box, so this function is not in 
place yet)

chensong (2):
  demo/posix/cobalt: App of gpio loopback benchmark
  kernel/driver/testing: Driver of gpio loopback benchmark

 demo/posix/cobalt/Makefile.am      |   6 +
 demo/posix/cobalt/gpioloop.c       | 516 +++++++++++++++++++++++++++++++++++++
 kernel/drivers/testing/Kconfig     |   7 +
 kernel/drivers/testing/Makefile    |   3 +
 kernel/drivers/testing/gpiobench.c | 288 +++++++++++++++++++++
 5 files changed, 820 insertions(+)
 create mode 100644 demo/posix/cobalt/gpioloop.c
 create mode 100644 kernel/drivers/testing/gpiobench.c

-- 
2.7.4




