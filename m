Date: Thu, 28 Mar 2019 03:47:45 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <76739224.1358458.1553762865210.JavaMail.zimbra@wolfram.com>
Subject: clocksource 'tsc' marked unstable, CLOCK_HOST_REALTIME went bananas
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello list!

I am running Xenomai 3.0.7. released version with Kernel 4.9.90 patchlevel =
6.

We have a new x86-64 hardware, and during a test-run the clocksource went u=
nstable, see (1) below for dmesg.

After this, calls to "clock_gettime(CLOCK_HOST_REALTIME,&timeStamp)"  went =
bananas. Like if time stopped completely, (or possibly jumped back in time =
at least a few hours). Stuff running on timers (using CLOCK_MONOTONIC)kept =
running fine. I tried switching time to hpet using "clocksource=3Dhpet" but=
 this didn't work at all. Either time (CLOCK_HOST_REALTIME) jumped back and=
 forth or it completely stopped.  Now I'm using "tsc=3Dreliable" and haven'=
t seen any issues since.=20

I think I know why tsc may be deemed unreliable, but why can't I run using =
hpet?

What are the drawbacks for xenomai with using tsc=3Dreliable ?


----------------- (1) -----------------=20
[19139.502750] clocksource: timekeeping watchdog on CPU3: Marking clocksour=
ce 'tsc' as unstable because the skew is too large:
[19139.503499] clocksource:                       'hpet' wd_now: f347622d w=
d_last: 35ab9afb mask: ffffffff
[19139.504245] clocksource:                       'tsc' cs_now: 31567c07fb3=
6 cs_last: 30ffd3d5ec2d mask: ffffffffffffffff
[19139.505045] clocksource: Switched to clocksource hpet
----------------- (1) -----------------=20

Best regards
Per =C3=96berg=20

