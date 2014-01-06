MIME-Version: 1.0
Date: Mon, 6 Jan 2014 18:30:55 +0100
Message-ID: <CAOm2F2aOBQK3mGT462JNWbensZKrWS86HoVrsPe-+qwsQsq4kg@mail.gmail.com>
From: Simone Chiale <zimbo2288@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai-help
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
I hope this is the right place to get an help for Xenomai.
I'm new in Xenomai and i have lot of doubts about it.
I've patched it correctly (or i hope so) on a Pentium M 740 (1.73 GHz) 1 Gb
RAM with last Xubuntu OS.
I've used patch 2.6.2.1 and vanilla 3.5.7 following "Installing Xenomai on
Ubuntu 12.04 | A novice's guide" and it seems all ok till now.
For my studies i need to create a real-time timer that every 4 ms use a
thread to exchange informations with other threads.
One of my problems is that my sistem uses NTP to synchronize the system
clock and i have seen that with standard POSIX you can use
CLOCK_MONOTONIC_RAW to avoid NTP jumps and adjusts.
How can i use a similar solution with native xenomai?
Now as now i've created a rt_thread and then with rt_task_set_periodic() i
set 4 ms period. After that with a counter and a switch i can decide what
to do in the right time, but i don't know if this solution is ok for the
NTP problem.
I attach my simple example based on other found in internet.
Thank you very much,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: threadtimer.c
Type: text/x-csrc
Size: 2569 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140106/a5c2935=
e/attachment.c>
