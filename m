MIME-Version: 1.0
Date: Tue, 3 Feb 2015 15:46:19 -0800
Message-ID: <CAEMXjGxMn6s=LA=_a63KPn2vwBOCpxvcDGmys_o+dtMeeGjYHg@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Setting execution time limit of task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,

Related to my troubleshooting thread of the last couple days, but this is a
separate and simple question.

In POSIX skin is there a way of assigning a high-priority RT thread/task a
timeslice such that it must yield execution if it exceeds its allotted
time? Or is this only possible in the native skin?


Is this what SCHED_RR allows us to do?

Thanks,

Steve
