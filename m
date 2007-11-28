Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABDFF@anubis2.clb.tcfr.thales>
From: Laurent.POYART@fr.thalesgroup.com
Date: Wed, 28 Nov 2007 09:24:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [Xenomai-help] Low priority primary mode threads scheduling vs
	linux regular th	read.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

It was said in a previous thread under title "scheduling of low priority primary mode Xenomai threads versus high priority secondary mode Xenomai threads":
<<Plain regular Linux threads unknown from the Xenomai scheduler are always preempted by primary mode threads, but they _do_ compete for the CPU with secondary mode threads according to their priority and scheduling class>>
Consider the following example with 3 Threads (coupling between Xenomai and Linux schedulers is On):
*	TL : regular linux thread with high priority (unknown from Xenomai Scheduler) => ready to run.
*	Tx1 : xenomai real time thread with medium priority in primary mode => running.
*	Tx2 : xenomai real time thread with low priority in primary mode => blocked (waiting for an event).
Tx1, which is running, issues a linux system call and then switches to secondary mode. TL and Tx1 compete for the CPU and TL takes the CPU control (am I right?).
Then an interrupt occurs and gives the necessary condition to unblock the Tx2 thread. Does the sentence <<Plain regular Linux threads unknown from the Xenomai scheduler are always preempted by primary mode threads>> means that Tx2 will preempt TL or does TL keep control of the CPU because it is still in competition with the secondary mode thread Tx2 which has a higher priority compared to Tx1?
Regards.
Laurent.



