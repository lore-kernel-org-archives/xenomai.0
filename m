Date: Sun, 7 Sep 2008 06:35:35 -0700 (PDT)
From: Yasser Kashfi <yasser_kashfi@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <785469.16674.qm@domain.hid>
Subject: [Xenomai-core] Start Xenomai User-Space Task as Service
Reply-To: yasser_kashfi@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi everyone,

I have a problem with xenomai user-space task. I write a very simple xenomai user-space task with one real-time thread, and try to start it as service. I do it properly. but when change this program with another xenomai user-space task with 10 real-time threads and some FIFO, queue, ... ; the task can not start and fail. also this problem appear when system reboot and try to stop this task. although when system is up and I run (service my-service [start/stop]) it work without any problem.

I glad to see your comments.
Best regards.


      


