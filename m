MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Fri, 4 Sep 2020 16:00:17 +0800
Message-ID: <CAAvDm6Ze+LAuXFUvQkwiWPtmCiEVQJQ2aASirAJy+JRhKprcdg@mail.gmail.com>
Subject: What are the per-cpu host timers used for?
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

There are several host timers that could be seen through the virtual
file named as /proc/xenomai/timer/coreclk,i.e:

~ # cat /proc/xenomai/timer/coreclk
CPU  SCHED/SHOT       TIMEOUT     INTERVAL    NAME
0    239162/150321         3ms467us    -           [host-timer/0]
1    33839/31631            10ms657us   -           [host-timer/1]
2    22189/19355            60us        -                 [host-timer/2]
3    45244/41172            90us        -                 [host-timer/3]


What are the per-cpu host timers used for?

Best regards
Sunshilong

