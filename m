MIME-Version: 1.0
In-Reply-To: <20100812093944.14467.qmail@domain.hid>
References: <20100812093944.14467.qmail@domain.hid>
Date: Thu, 12 Aug 2010 12:11:07 +0200
Message-ID: <AANLkTimZDnDnofKR6Of1pfrysQgE7GexWXx1Ejeiv_tP@mail.gmail.com>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Timing calculation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: prakash srinivasan <asprakash_83@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

2010/8/12 prakash srinivasan <asprakash_83@domain.hid>
>
> Deal All,
> I am executing a simple for() loop and like to calculate the time period =
for this loop. I used rt_timer_read(). As per the document, it mentioned th=
at rt_timer_read() returns the current time expressed in clock ticks. I cou=
ld not able to get an clear idea about it. Suppose if i convert it by using=
 rt_timer_ticks2ns(), I am not getting the proper output. My code is,
>
> RTIME start, end;
> ...
> ...
> start=3Drt_timer_read();
> for()
> {}
> end=3Drt_timer_read();
> printf(TOTAL LOOP TIMING=3D%ld usn", (long)((rt_timer_ticks2ns(end-start)=
)/1000);
>
> I would like to convert the ticks into nano seconds first and then into m=
icro seconds. The final result is irrelevant. I am not sure, where is the i=
ssue. Help me to find the timings details properly.

Irrelevant how? Not repeatable?
What are the printed values?

Did you try without rt_timer_ticks2ns first?

Did you see the note on rt_timer_read() ?
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__native__ti=
mer.html#g9665d6947e29d1a19dafb5401b0f6285
Note:
    The value returned will represent a count of jiffies if the native
skin is bound to a periodic time base (see
CONFIG_XENO_OPT_NATIVE_PERIOD), or nanoseconds otherwise.

> In the example program trivial-periodic.c, they mentioned
>
> "NOTE: printf may have unexpected impact on the timing of your program. I=
t is used here in the critical loop only for demonstration purposes."
> Why?

Because printf is a complicated function ending up with syscalls which
would make you switch to secondar mode etc.... (you can search the ML
for answers on this subject).

Note that in your case the printf is after the loop (and timer read) so thi=
s
must not be the problem.

--
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

