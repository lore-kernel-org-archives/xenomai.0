Message-ID: <835858898.1538735255720.JavaMail.root@webmail>
Date: Fri, 5 Oct 2018 19:27:35 +0900 (KST)
From: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Reply-To: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Xenomai priority does not work properly under certain
 circumstances.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

It seems that task priority does not work properly under certain circumstances.



I created two xenomai tasks and assigned each task as a control task and a stress task.

experimenting with the beaglebone black, Zybo-z7-20 (ZYNQ-7000) board to verify the periodicity of the xenomai task.



Priority of control task: 99

Priority of stress task: 98



control task cycle: 1ms

stress task cycle: 1ms



For the stress task, the rt_timer_spin () function is used to consume the cpu cycle to give xenomai stress.

I tested for 25%, 50%, and 75% cases by specifying 250,500,750 as an argument to rt_timer_spin ().



Check / proc / xenomai / stat

stress task's cpu usage. The figure shows the zybo-z7-20 board, and the same CPU usage was confirmed on BBB and PC.

The Cpu Spin task is the stress task and the EtherCAT Control task is the control task.



stress 25% = https://imgur.com/a/PIOueUI

stress 50% = https://imgur.com/a/sl7EAoI

stress 75% = https://imgur.com/a/AGWE0ff



When the xenoami task was run for 30 minutes and the control task and the stress task period were checked, 

both the BeagleBone Black and the Zybo-z7-20 had stress tasks occupying 75% of the cpu. 

As expected, The control task has a better periodicity than the stress task.

However, at 25% and 50%, the lower priority stress task has a better periodicity than the higher priority control task.



I did the same experiment on the PC because the result did not come out as expected.

The results show that task priority is normally applied to all 25%, 50%, and 75% stresses and that the control task periodicity is better.



The figure below shows the period data obtained from the test results using boxplot.

BeagleBone Black  = https://imgur.com/a/hpUpkH8

Zybo-z7-20             = https://imgur.com/a/J47zCoa

PC                          =https://imgur.com/a/zfzMdjr



What causes these results in the BeagleBone Black and Zybo-z7-20?



The test environment is shown below.

------------------------------------------------------------------------------------------------------------------

BeagleBone Black



kernel version  = 3.8.13

kernel download =  https://github.com/RobertCNelson/bb-kernel



xenomai version = 2.6.5

xenomai download = http://xenomai.org/downloads/xenomai/stable/xenomai-2.6.5.tar.bz2



ipipe patch     = ipipe-core-3.8.13-beaglebone-pre.patch

ipipe-core-3.8.13-arm-4

ipipe-core-3.8.13-beaglebone-post.patch



filesystem          = ubuntu 14.04

filesystem download = https://rcn-ee.com/rootfs/eewiki/minfs/ubuntu-14.04.4-minimal-armhf-2016-04-02.tar.xz

------------------------------------------------------------------------------------------------------------------

Zybo-z7-20(ZYNQ-7000)



kernel version  =  3.14.2

kernel download =  https://github.com/Xilinx/u-boot-xlnx.git



xenomai version = 2.6.5

xenomai download = http://xenomai.org/downloads/xenomai/stable/xenomai-2.6.5.tar.bz2



ipipe patch     = ipipe-core-3.14.17-zynq-pre.patch

ipipe-core-3.14.17-arm-4.patch

ipipe-core-3.14.17-zynq-post.patch



filesystem          = ubuntu 14.04

filesystem download = https://rcn-ee.com/rootfs/eewiki/minfs/ubuntu-14.04.4-minimal-armhf-2016-04-02.tar.xz



------------------------------------------------------------------------------------------------------------------

PC (i7-6700)



kernel version = 3.14.28

kernel download =  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.28.tar.gz



xenomai version = 2.6.5

xenomai download = http://xenomai.org/downloads/xenomai/stable/xenomai-2.6.5.tar.bz2



ipipe patch     = ipipe-core-3.14.28-x86-7.patch





filesystem          = ubuntu 14.04

------------------------------------------------------------------------------------------------------------------



thank you for your advice

