MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 23 Apr 2018 15:20:52 +0530
Message-ID: <CAOuPNLjfpsTq6UNxQbu2VOyt128ecX5jQJr8VrWuHWBH_x+tog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] overlapping and missing output with large data range
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I am facing one problem with Xenomai when I try to output some 2-3
columns data on console, may be 1000 or 10000+ ranges.

This is one sample output:
{{{
.....
.....
1369 100.232 0.232
1370 100.247 0.247
1371 100.240 0.240
1372 100.2181987 100.491 0.491
1988 100.758 0.758
1989 100.794 0.794
1990 100.805 0.805
.....
.....
}}}

Here I am trying to measure some latency with my test program.
Its a simple program where I create one thread, then sleep for 100us
and measure latency.
I do this for 1000 times, and print latency data for each round.
I am using normal printf/rt_printf for printing the data on console.
Finally I take all these data and plot a graphical view.

In the above output, as you can see (in one big line):
The next iteration data is overlapped.
Also may rows are missing.
I guess the correct output may be:
1372 100.218  ??.???
......
1987 100.491 0.491

So, may data are missing.

I need all the data to be appearing correctly, otherwise my graphical
plotting data goes wrong.

Is there anything I am do about it?
Any ideas will be really appreciated....

I already tried by storing the latency values in an array, and then
printing it at the end of the task.
But this also did not help much....


Thanks,
Pintu

