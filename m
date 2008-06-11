Date: Wed, 11 Jun 2008 10:23:38 +0200 (CEST)
From: Andreas Erler <a.erler@domain.hid>
Message-ID: <21830053.6301213172618935.JavaMail.root@domain.hid>
In-Reply-To: <26287316.6271213172573467.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Debugging realtime tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "." <xenomai@xenomai.org>

Hi,

I want to debug a userspace task created with: rt_task_create(&demo_task, "trivial", 0, 99, 0);
When I set a breakpoint somewhere in the demo_task function I get the following message and gdbserver exits:

Child terminated with signal = 5

Child terminated with signal = 0x5 (SIGTRAP)
GDBserver exiting

Is it generally possible to debug realtime tasks or not?
If yes, what I'm doing wrong here?

Thanks in advance,
Andy



