Message-ID: <5347D5BB.1070107@mitrol.it>
Date: Fri, 11 Apr 2014 13:44:59 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] arm imx6 and hardware FPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all,
I'm trying to test my imx6 with xenomai 2.6.3.
I use the linaro cross-compiler that uses the hardware floating point.

I made a simple floating point test.

If I use two non-realtime user-space tasks the test works OK and I have 
no errors in calculations.
This means that compiler and hardware works well.

But I I use two realtime user-space tasks I have errors in calculations.
Real-time tasks are created with rt_task_create(&demo, "demo", 0, 99, 
T_FPU);


This is my kernel config
============================================
...
#
# Machine
#
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
CONFIG_IPIPE_WANT_ACTIVE_MM=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_UNLOCKED_SWITCH=y
...
#
# At least one emulation must be selected
#
CONFIG_VFP=y
CONFIG_VFPv3=y
CONFIG_NEON=y
CONFIG_VFP_3_2_BACKPORT=y
...
============================================

Is it possible to use ***hardware floating point*** with realtime 
user-space tasks ?

Regards,
Paolo Minazzi


