Message-ID: <4D46CB77.5000004@domain.hid>
Date: Mon, 31 Jan 2011 15:47:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_SELECT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> In the Xenomai 2.4.x series there was a kernel option
> CONFIG_XENO_OPT_SELECT. Unfortunately there is no help available for
> this option and Google  wasn=C2=B4t very fertile.

CONFIG_XENO_OPT_SELECT is an internal option of Xenomai. The options you
should be looking at are

CONFIG_XENO_OPT_POSIX_SELECT
CONFIG_XENO_OPT_RTDM_SELECT

These ones are documented, and selecting them, simply select
CONFIG_XENO_OPT_SELECT. So, the fact that CONFIG_XENO_OPT_SELECT is off
in your kernel configuration is off simply means that the other two
options are off.

 Could somebody tell me,
> what this option is for? I am asking, as we face some problems with
> "select" in a Xenomai task (task is stuck in select, was permanently
> marked as running (R in /proc/xenomai/sched) and lower priority tasks
> weren=C2=B4t  scheduled).

This looks strange. Each call to select should result in a call to
Xenomai "select" syscall, if you are using the POSIX skin, which should
return -ENOSYS, then select should call the glibc select. Since
obviously what you want is to call glibc select directly, you can try
calling __real_select instead.

Note that the issue with priorities you observe show that you have a
task with a priority higher than 0 using a glibc syscall, thereby
causing it to switch to secondary mode. The fact that lower priority
threads do not run is the effect of the "priority coupling", but the
real issue here is that a task with real-time priority is using a linux
syscall, which is something you should normally avoid.

--=20
					    Gilles.


