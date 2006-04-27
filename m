Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Message-Id: <CAD034EB-5B5C-4E38-9C26-BA4D2157C8AA@inquant.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: Stefan Eletzhofer <stefan.eletzhofer@domain.hid>
Date: Thu, 27 Apr 2006 23:56:00 +0200
Subject: [Xenomai-help] T_JOINABLE flag and task creation in userspace
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
I've just tried to create a task in user space with the T_JOINABLE  
flag set,
as I wanted to rt_task_join() to that thread later on.

Unfortunately, as soon as I set that flag, the task does'nt get started
at all (i.e. its task body is not reached). Is that a known BUG/ 
limitation or am I missing
something? The same program works if I pass 0 instead of T_JOINABLE  
(of course the
rt_task_jolin() fails to join, then, using pause() in that case ;)

I'm using Xenomai 2.1 on a custom PPC board running a 2.4.25 kernel.  
The latency tests
look OKish to me.

Thanks,
Stefan E.

