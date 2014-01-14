MIME-Version: 1.0
Date: Tue, 14 Jan 2014 10:27:07 +0330
Message-ID: <CAKKWdteBOh9yTRsWSBxpO+orgwLztR+i_2YiZ4UaM4bVYSTMWg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai test for rt_task_suspend() and rt_task_resume()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I am using kernel-3.5.7 with xenomai-2.6.3.
I think the scheduler should schedule task1 and task2(for 3 times
alltogether) and then both tasks should be suspended but as it has
been indicated in output.txt , there are many "inside task2..."
messages (part of them were copied to the file) and then sudenly task1
is killed!!
Xenomai function seems incorrect(though i may have ignored some facts
as usual, i apologize in advance)
-------------- next part --------------
dmesg
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: inside task2...
Jan 14 09:58:47 localhost kernel: Clocksource tsc unstable (delta =3D 39220=
90473 ns)
Jan 14 09:58:47 localhost kernel: Switching to clocksource jiffies



cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT/0
  1  0      idle    -1      -         master     R          ROOT/1
  2  0      idle    -1      -         master     R          ROOT/2
  3  0      idle    -1      -         master     R          ROOT/3
  0  0      rt      50      -         master     Sf         KTask1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: kerneltask3.c
Type: text/x-csrc
Size: 1443 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140114/7118e44=
9/attachment.c>
