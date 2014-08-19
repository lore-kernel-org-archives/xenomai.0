MIME-Version: 1.0
Date: Tue, 19 Aug 2014 11:45:54 +0430
Message-ID: <CAKKWdtfZm+F3M+VtD2zG=JMun1GYtNDOAbzYvVUDXxq5B8qsMw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] a question about interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Is the following statements are true?

If there are some Xenoma threads and an interrupt happens and it has
no head handling. The execuation of the Xenomai threads are stopped
and that interrupt is played. It can be an interrupt handled by
Xenomai root domain or just a regular Linux interrupt routine. So for
the most of the interrupts they can delay Xenomai real-time threads if
they are not masked.
(the interrupt is logged but soon after that it is executed by synch process!)
so Xenomai real-time interrupts and non-real-time interrupts are both
executed any time.

