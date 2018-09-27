Message-ID: <1815637048.1538051285886.JavaMail.root@webmail>
Date: Thu, 27 Sep 2018 21:28:05 +0900 (KST)
From: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Reply-To: =?EUC-KR?B?udrA58ij?= <jaeho@seoultech.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] xenomai task monitoring tool
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



I want to use the monitoring tool to check the CPU usage of the xenomai task.



I tried to monitor the xenomai task using the linux monitoring tools top, nmon, and trace-cmd, but I could only check the non-rt linux task correctly and could not check the xenomai task.

When checking the CPU usage of the xenomai task with / proc / xenomai / stat, the xenomai task was checked normally, but the linux task did not print.



I would like to monitor the system-wide cpu usage when non-rt and xenomai tasks are running on the system at the same time.

Is there a tool that can do this?



thank you for your advice

