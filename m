MIME-Version: 1.0
Date: Sat, 7 Jul 2012 17:36:53 +0430
Message-ID: <CAKKWdteYpbU5y65GXtS6j6aHQ_ESDk0C41B-MjC93cVzfW8mvg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] questions: Linux/Xenomai domains
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1) Suppose an interrupt happens in a real time task. How that
interrupt detects the execution context of that task?(Linux domain or
Xenomai domain), is there any flag in relation with each task set by
the user space libraries?

2) Is there "interrupt shield" mechanics for Xenomai, 2.6.0? (It seems
there is no CONFIG_XENO_OPT_ISHIELD)

3) I call a Linux service in a real time task and that service
finishes and CPU returns to the real time task again to execute next
instruction, is it in primary mode or secondary mode upon returning?

