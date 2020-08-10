Date: Mon, 10 Aug 2020 03:54:51 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <745093004.715850.1597049691365.JavaMail.zimbra@wolfram.com>
In-Reply-To: <4baa56a0-13dc-08d7-79d4-00f63f85c2b0@centrum.cz>
References: <20200807171220.E090CB18@centrum.cz>
 <166391923.711496.1597041953464.JavaMail.zimbra@wolfram.com>
 <4baa56a0-13dc-08d7-79d4-00f63f85c2b0@centrum.cz>
Subject: Re: Posix periodic time first tick
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
Cc: Petr =?utf-8?Q?=C4=8Cervenka?= <grugh@centrum.cz>

----- Den 10 aug 2020, p=C3=A5 kl 9:52, Petr =C4=8Cervenka grugh@centrum.cz=
 skrev:

> Hello.

> The problem is only when I use Xenomai linking flags and only with
> thestart time. Period is OK.

> That aprox. 16s time delay can be "compensated" by substracting of any
> number of seconds from the start time.

You could try using CLOCK_REALTIME or CLOCK_HOST_REALTIME instead of CLOCK_=
MONOTONIC. I use timerfd and similar heuristics without issues afaik.


>From the top of my head I don't recall exactly how Xenomai timers correspon=
d to Linux timers but you may have an issue if you check your starting time=
 a non RT thread and use that value in a RT thread, depending on your choic=
e of timer. =20

Check out: https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Porting_To_Xenoma=
i_POSIX

I have had some issues with time-keeping of my machines and I had to do a b=
it of manual tuning for it to work properly (talking 0.x pct drifts but als=
o a bit of a offset). For debugging I used the  following:

* Hard coding freq using boot time kernel argument: "clocksource=3Dtsc tsc=
=3Dreliable xenomai.clockfreq=3D2807909955"
* Using (in my case ) "adjtimex -f 2080674" to adjust the time-keeping scal=
ing
* "clocktest" from Xenomai test-suite.=20
 Right now I have (for a setting tuned to some machine and then run on anot=
her)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0          110881217.1       316239.964          0            0.0
  1          110881224.7       316239.943          0            0.0
  2          110881216.8       316239.928          0            0.0
  3          110881217.4       316239.921          0            0.0


Which is about 110s and drifting 0.3s per second.=20

Regards
Per =C3=96berg

> // Create timer
> timer_fd =3D timerfd_create(CLOCK_MONOTONIC, 0);

> // Get current time
> struct timespec start;
> clock_gettime(CLOCK_MONOTONIC, &start);

> // Set periodic
> struct itimerspec timer_conf;
> memset(&timer_conf, 0, sizeof (timer_conf));
> timer_conf.it_value =3D timespec_add(start, -15 * NANOSEC_PER_SEC);
> // compensation of the delay
> ...
> timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &timer_conf, NULL);

> There is strange unexpected difference/time shift between product of
> clock_gettime and timerfd_settime. Only with Xenomai posix wrappers.

> Best regards

> Petr Cervenka

> Dne 10.08.2020 v 8:45 Per Oberg napsal(a):
> > ----- Den 7 aug 2020, p=C3=A5 kl 17:12, xenomai xenomai@xenomai.org skr=
ev:

> >> Hello.
> >> I have created small example of periodic task in posix.
> >> If I compile it without xenomai it works fine.
> >> When I add Xenomai linking flags, the first tick of periodic task take=
 around
> >> 16s. After that it continues as it should.
> >> Used clock type for timer_fd is CLOCK_MONOTONIC. The example should in
> >> attachment.
> >> Do you have any suggestions?
>> Just had a extremely quick look at it. Are you sure you don't get any ro=
unding
> > errors when doing your period arithmetics ?

> >> Best regards
> >> -------------- next part --------------
> >> A non-text attachment was scrubbed...
> >> Name: timer_test.cpp
> >> Type: text/x-c++src
> >> Size: 4351 bytes
> >> Desc: timer_test.cpp
> >> URL:
> >> <http://xenomai.org/pipermail/xenomai/attachments/20200807/d4203f59/at=
tachment.cpp>
> > Per =C3=96berg

