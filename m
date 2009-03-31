MIME-Version: 1.0
Date: Tue, 31 Mar 2009 14:53:47 -0400
Message-ID: <f73fef8d0903311153v625518bakc38f1667d73fa99c@domain.hid>
From: Adam Bennett <abennett72@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_delete segfault in libnative.so.3.0.0
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

I'm running xenomai-head, linux-2.6.28.9, with uclibc-0.9.30.1.

I have to run configure with --build=i586-gentoo-linux-uclibc
--without-__thread.

The problem I'm seeing is a segfault whenever calling rt_task_delete.
This even occurs with the example program trivial-periodic.

I have debug enabled in the kernel, but nothing interesting appears in syslog.

Any thoughts?

Adam

