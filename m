Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2008 11:15:58 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Interrupt latency questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antonio Del Cinque <adelcinque@domain.hid>, xenomai@xenomai.org

Antonio Del Cinque wrote:
[...]
>Then I open an ssh connection with the target, and run a "cat /dev/zero
> file". The target=20
>is mounted on an NFS root filesystem, so this generates a high number
of=20
>fast ethernet interrupts. Now the oscilloscope shows 15 uS jitter in
the worst case,=20
>and a visible variance. I would assume this effect as increased max
latency.

This figure has already been seen with SoC in the range of the e300,=20
and sometime worse.

>The ethernet interrupt is handled only in Linux domain by the original
vanilla handler,=20
>but Linux should be stalled/preempted when the timer interrupt occurs.
So I assume=20
>that latency is to be justified by the time it takes to adeos to record
an=20
>ethernet interrupt event in the i-logs when the timer interrupt is
executing or ready to
>execute. Is this correct?=20

Cache miss and TLB miss are also good latency killers.
To some extent, long DMA transfers can bog down the system bus.

>Is there any way to lower max latency for the timer interrupt?

Has anybody tried to play with cache locking?

--=20
Stephane

