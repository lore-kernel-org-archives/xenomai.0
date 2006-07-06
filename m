Date: Thu, 6 Jul 2006 13:43:51 +0200
From: "J. Niehaus" <Niehaus@domain.hid>
Message-ID: <20060706134351.2e582664@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Detecting switch to secondary mode
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

I have written a xenomai application (posix-skin) with several tasks. All of them should normally use primary mode (SCHED_FIFO). While some are allowed to switch to secondary mode for stuff like I/O and memory allocation others must not switch due to hard realtime constraints. 

Is there a way to check if and how often a thread has switched to secondary mode and maybe even what system call caused the switch? While a test from within the program itself would be great some information from /proc/xenomai would also do.

Thanks,
	Jens

