MIME-Version: 1.0
Date: Sat, 23 Jun 2012 14:16:32 +0430
Message-ID: <CAKKWdte32SZLW-RT=8PLXJfWYqN3ErG_W1oywjCmHVgU27Uzbg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] some questions about the architecture of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1) Does (ADEOS and) Xenomai project changes and extends the Linux
kernel sys_call_table?
2) Considering i have used a VxWorks API function, will it be
translated to a new Linux kernel system call?
If no,  why there are some emulators and interfaces for VxWorks, pSOS
and so on inside kernel?
3) Does all the real time services and API functions will be
translated to the nucleus API calls at last?

