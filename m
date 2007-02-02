From: Victor Shulyak <V.I.Shulyak@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Feb 2007 16:28:31 +0600
Message-Id: <1170412112.11967.6.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] rt descriptors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai <xenomai@xenomai.org>

Hello

Can I use RT_HEAP (or others descriptors) in the following way:

RT_HEAP h_desc;
create descriptor (rt_heap_create (&h_desc,...)

fork
child process: rt_task_shadow () and rt_heap_alloc (&h_desc, ...)
parent process: rt_heap_alloc (&h_desc, ...)

Will h_desc be valid and usable in child processes?


Thanks, Victor

