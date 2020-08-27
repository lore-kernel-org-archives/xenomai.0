MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 27 Aug 2020 11:00:38 +0800
Message-ID: <CAAvDm6aw3mLyhsJsXmd0G+EbYddR-GC+bWTunCzsRgfOY2ws4w@mail.gmail.com>
Subject: About the priority that is seen by /proc/xenomai/sched/threads
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, list

Which one has a higher priority, the thread named by "main" that is
created by rt_task_create or the
one named by "timer-internal" that is created internally?

As far as I know, the priority of the thread created by rt_task_create
is between 0 to 99. It could not
be greater than 99.

$cat /proc/xenomai/sched/threads
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  2  0      idle   core       -1   -             R          [ROOT/2]
  0  630    rt     core       98   -             W          [rtnet-stack]
  0  631    rt     core        0   -             W          [rtnet-rtpc]
  1  5414   rt     cobalt     50   1ms887us      D          main
  1  5416   rt     cobalt    259   -                        timer-internal
  2  6708   rt     cobalt     50   1ms994us      D          main
  2  6710   rt     cobalt    259   -             W          timer-internal

