Message-ID: <2F8EE677D406514ABE53EF9C0934A666017CAF39@domain.hid>
From: Dominique.RAGOT@fr.thalesgroup.com
Date: Thu, 3 Nov 2005 14:59:23 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Xenomai-help] number-crunching execution jitter
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

Hello,

I am using Xenomai 2.0 for a number-crunching application on bi-processor x86 SMP and using the Posix skin.

There are 2 tasks on each processor that are awaken every 20ms and execute for 16ms.
When there are no perturbations on the machine, the jitter on tasks wakeup and execution time is acceptable (approx. 5%).

However, when adding a simple load such as find / -print redirected to /dev/null, the execution jitter is much worse (more than 100% in some cases), whereas wakeup jitter remains good. My conclusion is that the tasks are preempted when running. Is it right ?

I suspect the interrupt shield to be inactive (although I see it in /proc/adeos). How could it be activated with Posix skin ? How could it be monitored ?

PS: too bad the cruncher will not survive 2.0. Would you consider including POSIX tests in the new 2.1 release ? I did not see any in the 2.0.

Sincerely,

---------- 
Dominique RAGOT

