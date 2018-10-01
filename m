Message-ID: <759115071.1538372023382.JavaMail.root@webmail>
Date: Mon, 1 Oct 2018 14:33:43 +0900 (KST)
From: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Reply-To: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] What does activating SMP mean?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, all



I thought that activating SMP makes tasks using all cpu cores, but I realized that it doesn't.

I did not explicitly specify the CPU when I created the task.

I have created two xenomai tasks and checked to see how much cpu share the task has on any cpu with / proc / xenomai / stat.

As a result, we confirmed that only one cpu of two cpu works.



So we used T_CPU () to allocate different CPU cores for each task when we created the task.

As a result, you can see that both tasks are running on two CPUs.



I expected to use both CPUs when I enabled SMP, but I did not. Why is not it?

Also, does one task only run on one cpu?





The environment I used is shown below.

------------------------------------------------------------------------

zybo-z7-20(zynq-7000)

Dual-Core ARM Coretex-A9 MPCore Up to 866MHz



xenomai 2.6.5

kernel 3.14.2

ubuntu 14.04

------------------------------------------------------------------------



thank you for your advice.

