Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 17:59:19 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
>1.) The culprit is mlockall(MCL_FUTURE|MCL_CURRENT);
>
>As soon I leave this away, I get much better results:

That's puzzling. Can it be explained?
Have you tried a memset of buf1&buf2 before the first osa_now_timespec?

>2.) rt_timer_tsc
>If I use clock_gettime() this needs 3100 ns,
>If I use rt_timer_tsc() this needs 74 (!) ns.

Have you tried clock_gettime with *_HR clock like CLOCK_MONOTONIC_HR ?
You have to have a recent glibc to get benefit from that.
One of those clock rely on timebase tsc instead of issuing=20
an expensive syscall.

Regards,
--=20
Stephane

