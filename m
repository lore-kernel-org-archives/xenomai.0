Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 15:33:44 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768BE@slcmail.slc.mew.int>
In-Reply-To: <47A6405A.8040706@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768B2@domain.hid>
	<47A6405A.8040706@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] periodic issues/watchdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> What is your target arch, what is your time line for experiments? I'm
> expecting to work on the LTTng thing soon again, maybe this week, and
> that would be a good tool for all your periodic-timing-goes-crazy
issues.

I'm running on x86 (geode... puke) and we I can help with experiments at
least daily. I have removed periodic timing (for now) and also set the
scalability stuff to linear, and am very happy with the result. I'm
seeing about 6% of cpu usage in the IRQ0 handler under worst case. I
don't trip the watchdog with the timeout set to 2 seconds like Gilles
suggested.

>=20
> One further note regarding overhead: Timers (or timed tasks) running
> over a periodic timebase are expected to have a slightly higher
overhead
> than running (at the same frequency) directly on the master
(=3D=3Done-shot)
> timebase. That's because the periodic timebase is built _on_top_ of
the
> master base theses days (since Xenomai 2.4). So, unless you can
benefit
> substantially from a jiffies/ticks based timing for your application
> (/wrt internal time calculations or due to the clustering of timer
> events), running directly on the master base is often the more
efficient
> approach.

I don't really need jiffies, but what I do want is there to be a common
timebase for all my tasks in order to implement true RMS scheduling. I
don't want things staggered on creation or after various delays are
inserted into the system.

Thanks for your explanation about the timers, though. I am very happy
with Xenomai's oneshot timer handling. I never could have had the system
playing mp3s with a realtime sound driver and a DAC while controlling a
stepper motor and handling user interaction with oneshot and RTAI (at
least a few years ago.)

Steven


