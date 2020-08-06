MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 6 Aug 2020 20:27:52 +0800
Message-ID: <CAAvDm6YF-PcERwDrV2C6NVHqKLE9+_z6R6tQq29uyHff=Oyj3A@mail.gmail.com>
Subject: Question about round-robin scheduling.
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

As per the Kconfig(
https://gitlab.denx.de/Xenomai/xenomai/-/blob/5714ceede70ccd39b1bf6c41a72cfa94f98e169a/kernel/cobalt/Kconfig
),
which says [emphasise mine]:
Cobalt has a built-in real-time class, which supports both
preemptive fixed-priority FIFO, and **round-robin scheduling**.
Cobalt supports  round-robin scheduling whereas
rt_task_create function only supports SCHED_FIFO and SCHED
(
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga03387550693c21d0223f739570ccd992
).

So, I wonder how to set a real-time task to use round-robin scheduling.
Or, am I missing something?

Thank you for your attention to this matter.
Sunshilong
