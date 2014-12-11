Message-ID: <5489D81D.7070003@nta-inc.net>
Date: Thu, 11 Dec 2014 11:45:01 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] switchtest in Xenomai-3.0-rc2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

In Xenomai-3.0-rc2, doc/asciidoc/TROUBLESHOOTING.COBALT.adoc still says this:


=== Issues when running the _switchtest_ program

==== pthread_create: Resource temporarily unavailable

The switchtest test creates many kernel threads, this means that the
options +CONFIG_XENO_OPT_SYS_HEAPSZ+ and
+CONFIG_XENO_OPT_SYS_STACKPOOLSZ+, in your kernel configuration,
should be configured to large enough values. Try increasing them,
rebuilding the kernel.


but, it looks like CONFIG_XENO_OPT_SYS_STACKPOOLSZ has been removed in Xenomai-3.  Is there another an equivalent variable that I might need to increase, or is increasing CONFIG_XENO_OPT_SYS_HEAPSZ sufficient to get rid of the error below?

$ /usr/lib/xenomai/testsuite/switchtest
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
ymm0: 1/1 != 2/2
ymm1: 1/1 != 2/2
ymm2: 1/1 != 2/2
ymm3: 1/1 != 2/2
ymm4: 1/1 != 2/2
ymm5: 1/1 != 2/2
ymm6: 1/1 != 2/2
ymm7: 1/1 != 2/2
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4 rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10 rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtuo2-15 rtuo2-16 rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21 rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4 rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10 rtus3-11 rtus3-12 rt
 u
s_ufps3-13 rtus_ufps3-14 pthread_create: Resource temporarily unavailable
rtuo3-15 rtuo3-16 rtuo_ufpp3-17 rtuo_ufpp3-18 rtuo_ufps3-19RTT|  393977:40:56
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0
RTD|           3|           0|           0


Thanks,

-Jeff

