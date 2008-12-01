Date: Mon, 01 Dec 2008 11:28:14 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200812011128.20250@domain.hid>
References: <200811281535.7647@domain.hid> <200811281536.819@domain.hid>
	<200811281542.2528@domain.hid> <493099C6.1070807@domain.hid>
In-Reply-To: <493099C6.1070807@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Hang at glibc time() function call
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


>Could not it be that the highest priority task is using all the CPU?

No, it's highly unprobable. The task runs at is should.

>Is the low priority task also mapped as Xenomai task? In that case
>calling standard Linux time services can be lethal:

Yes, the task is mapped as Xenomai task, because it waits on real-time queue with some timeout.

>
>If the Linux clocksource is TSC or HPET, glibc will use a syscall-less
>variant for time of day reading. That variant has two properties:
>
>A) It doesn't switch Xenomai task into secondary mode like ordinary
>   syscalls do.
>
>B) It can deadlock with the Linux kernel, leaving the caller spinning
>   forever so that Linux is no longer executed.

Hmm, probably my cause.

Meanwhile I replaced the glibc time() function call with rt_timer_read and it seems to work fine now (for 3 days).

Thank you for you support.
Petr



