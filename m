Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FD19ABCB
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938261; cv=none; b=K3GWZabIbH1iS1B/WNIGKwWWLyZhA/8UWc5o8835HEOpTlqveGagIYaBUYQ8GcjzVyYyCBda/68Bk7nXNVseimdWn59EWLeNgVHHszosxs0Z2//F7BexbTsDuYgQfiyzC/PzplbOR2YZXuSjTC09YSaddtO5lovLpefb3JoyTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938261; c=relaxed/simple;
	bh=9BXuMZ4y8oQnuPj3+3CYCv9fKsXInEw6PvHA1BAiGss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrzpkIDwrMPs3xaZDbbzYt9QL7jorIep8v5ErLkHqBN+5WA/Q/7dNBwBkWsoBPiVaO1TS3LQWi5Mys3F4SsPiCkkcXJ+1y+JvcnV8MK69lhF7CdDVaUS4XXNKY5alCkwemQO9MoX5qEVhwa4vh6auJfVsSB4kilLA+HOXUP0tJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Edjy6K3V; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Edjy6K3V"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id AB3A4100006
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 13:57:35 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DD85D74003A
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 13:57:34 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20241118135734148136a05298b9ccec
        for <xenomai@xenomai.org>;
        Mon, 18 Nov 2024 14:57:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EJj0huJQ5awtb8+WorKv/EFrHaeDjxmd/PqpP48jK6w=;
 b=Edjy6K3VubTItsAm52RGfyMHsukiqXDmbFV+BluaeuQclxDotXg5R1jWgm/yQNWww9zVQb
 qtoqFAt37de1c9z9ywobMUGIYLTDqjAxgW3UegWicJ18rYmh+TIKnlmqSCdrB4q5t9qP42Va
 Zm9lNP0fcbL9sZDkJ8XDTWW1OTWQXIt1hqQunRCoQtK4y8q7OENLtNSASntvYovcknpLeEe7
 rU2dxZPjJn755PyZrmsIB9R15knHYMyUnlc+SQbkpWcnWzVgiYgoTbVg/5zKINFSGV+ZY2vY
 SocUkjebPCxV77RJEhdkC5+BFyeuIAu3xtJ2DwR/dV3QpNufa787KXxg==;
Message-ID: <cdadf4a26e6ee96beee6788eea1d9bf8b567fc5c.camel@siemens.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, =?ISO-8859-1?Q?Fran=E7ois?= Legal
	 <devel@thom.fr.eu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, 
 =?UTF-8?Q?=E5=AD=99=E6=B6=9B?=
	 <suntaoworks@163.com>
Date: Mon, 18 Nov 2024 14:57:32 +0100
In-Reply-To: <87cyisk6ia.fsf@xenomai.org>
References: <1017-673b3f80-2f-2c5d8800@259496866>
	 <87cyisk6ia.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=Edjy6K3V;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20241118135734148136a05298b9ccec-QQVRXM@rts-flowmailer.siemens.com designates 185.136.65.228 as permitted sender) smtp.mailfrom=fm-68982-20241118135734148136a05298b9ccec-QQVRXM@rts-flowmailer.siemens.com

On Mon, 2024-11-18 at 14:37 +0100, Philippe Gerum wrote:
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>=20
> > Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit:=20
> > =20
> > >=20
> > > [ Updated CC list to merge both mail threads ]
> > >=20
> > > On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
> > > > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > > >=20
> > > > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.b=
ezdeka@siemens.com> a =C3=A9crit:=20
> > > > > =C2=A0=20
> > > > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
> > > > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka=
@siemens.com> a =C3=A9crit:=20
> > > > > > > =C2=A0
> > > > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > running on an Arm v7 cortex A9 platform, I'm trying to sw=
itch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail=
).
> > > > > > > > >=20
> > > > > > > > > I can successfully boot my system with linux 5.15 + CONFI=
G_DOVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck a=
t boot in a do_idle loop. Did I miss anything ?
> > > > > > > > >=20
> > > > > > > > > Attached is my config.
> > > > > > > >=20
> > > > > > > > Can you factor out from it what the SoC is, if you patched =
the kernel
> > > > > > > > for it (in the past and now), if you had to adopt Dovetail =
etc.?
> > > > > > > >=20
> > > > > > > > Jan
> > > > > > >=20
> > > > > > > The SoC is Xilinx zynq 7000. I have custom patches for custom=
 FPGA peripherals (which most of them have been successfully ported to 5.15=
).
> > > > > >=20
> > > > > > We had a similar report for the zynq 7020 a couple of days ago.
> > > > > > See [1].
> > > > > >=20
> > > > > > What happens if you disable CONFIG_SMP? (Not that this should b=
e the
> > > > > > final solution, but it might help to track the issue down...)
> > > > > >=20
> > > > > > Florian
> > > > > >=20
> > > > >=20
> > > > > Disabling config SMP makes my system boot again.
> > > > > How can I help working this out ?
> > > > >=20
> > > > > Fran=C3=A7ois
> > > > >=20
> > > >=20
> > > > This looks like an issue with the proxy tick device. First thing is=
 to
> > > > disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST. =
If
> > > > the kernel still hangs, we may have a hint about the reason
> > > > why. Alternatively, you could keep CONFIG_XENOMAI in, booting the k=
ernel
> > > > with "xenomai.state=3Dstopped". If no hang occurs at boot anymore, =
there
> > > > may be an issue with proxying the timer device on this SoC.
> > > >=20
> >=20
> > CONFIG_IRQ_PIPELINE_TORTURE_TEST seems to report OK (attached bootlog C=
ONFIG_IRQ_PIPELINE_TORTURE_TEST.boot
> >=20
> > Starting with "xenomai.state=3Dstopped" works (attached boolog xenomai.=
state-stopped.boot)
> > Starting up xenomai with coreclk afterwards seem to work and not hang s=
ystem :
> > root@Arkens_SV:~# /usr/xenomai/sbin/corectl -start
> > [  117.328878] CPU1: proxy tick device registered (333.33MHz)
> > [  117.328883] CPU0: proxy tick device registered (333.33MHz)
> > [  117.339995] [Xenomai] services started
> >=20
> >=20
>=20
> Ok, so another usual suspect for this issue: some weirdness in the CPU
> idling code, which causes a (timer) interrupt to linger indefinitely in
> some per-CPU interrupt log. A typical scenario is as follows:
>=20
> CPUx
> ----
>=20
>      default_idle_call() {
>=20
>       ...
> <IRQ> -> logged because local_irq_disable() in effect, _however_ we do NO=
T
>          expect hard irqs to be enabled [1] before entering the idle call
>          next =3D> issue is there.
>       arch_cpu_idle();
>       ...
>       /* per-CPU log is not flushed, because of [1] */
>      }
>=20
> At the end of the day, the (most likely) timer IRQ is marked as pending
> in the log, but never played, so the kernel activity stalls on that CPU,
> especially if the boot CPU is involved.
>=20

Taken from the boot log:

[    0.000024] clocksource: arm_global_timer: freq: 166666665 Hz, mask: 0xf=
fffffffffffffff max_cycles: 0x26703d7dd8, max_idle_ns: 440795208065 ns
[    0.012959] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.587268] clocksource: Switched to clocksource arm_global_timer
[    1.065121] clocksource: ttc_clocksource: freq: 54253 Hz, mask: 0xffff m=
ax_cycles: 0xffff, max_idle_ns: 537538477 ns

So the last active clocksource is ttc_clocksource
(drivers/clocksource/timer-cadence-ttc.c).
If I'm correct the OOB enablement is missing for this driver.

Philippe already pointed us to
https://v4.xenomai.org/dovetail/porting/timer/.

Could someone try that? I have matching HW at hand...

Florian



