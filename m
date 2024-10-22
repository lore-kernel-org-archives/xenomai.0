Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2114B97E
	for <xenomai@lists.linux.dev>; Tue, 22 Oct 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635492; cv=none; b=HXGcCghHvsiS6UZ+ov6710zEF23yM0RhSIEYPxlJHRaSAZBxq04DB8ibSBJKwQGErtsCXAi74g5wvxONCf3u5Cvigo03y5yXTq9mfUJx+nBfSCZCVoUEOCOcOKMOFVUgyS22Vf7t8WhmLS8b0v8iL2PeBYM2xoBPvnuqvZMEWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635492; c=relaxed/simple;
	bh=mSThl+/0sv1yNwezHN0vL1K8f0HmrTzoC9s5G8gl2iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRwiMaTWdlTlMdwMdwRgN1IxV5CNYmdXXsE0pIY3dqb41fzhECHmmvUDzZ+X3eQhabgDuvrmAib1imxA3er8oZokb8AhmtvjDfkbN+ZHZ3KpRJZ2nbf40PdTkptAr1RvOXVsyZZxLcObXcaxJkpx+WOHBP3NUu/QR1t8Kllr3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=O9gguczO; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="O9gguczO"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024102221374148996e485059b702bf
        for <xenomai@lists.linux.dev>;
        Tue, 22 Oct 2024 23:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dswDNPbJGOibFJjubAK8bjYJm/hCRaeHOHdpx6+Renc=;
 b=O9gguczOzXf4tWy+GRFp7+Xb2fgI+1pY1Z5t3SQSg00DFVXYYr9bQHwMlmXb0fS7jYm3RV
 AO/z1xB0WLKQ7Vu06IbNu8wQk2Su09sHaaHxLGXxRvJPvIFkTwCX3lFW/cEcdDtwGrd5W7on
 wwveCMkDTSMjytBI5O7XDsS/FfLsWgwLY2c6jBVB/WaFWBNOWZC/7XQQWoOjKMChy32ALJ5L
 589qUZRsWgiEblT+bGG/9WN1yhXUIviGADa8OdbLPxNsoX+zswTOFj1FS433Q0hCUsyLietH
 M2oHQiVLDapNLs1BpU8JFfq5wWfBH8LX67kRIFJizLQxAe96qYGpAa7A==;
Message-ID: <f5168eb20757b6b27b93f24f627ffc82fc00999d.camel@siemens.com>
Subject: Re: Re: Re: [PATCH 1/3] cobalt: Move relax related lostage_wakeup
 work from stack to thread
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: JerryJun <jerryjun123@163.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Tue, 22 Oct 2024 23:37:39 +0200
In-Reply-To: <4d324baa.b48a.19295ceea26.Coremail.jerryjun123@163.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
	 <95ccd795ec5db6c2d4d867b0f29fae964cffcf82.1725016413.git.jan.kiszka@siemens.com>
	 <cd1d4b2.302.1920cbd5314.Coremail.jerryjun123@163.com>
	 <46532234-69a4-448b-9fc5-a04ac47fba0c@siemens.com>
	 <afecd73.90c9.192948dde67.Coremail.jerryjun123@163.com>
	 <eebf7a9762eca3f6fed8dfbb2a5bb3055397c9c6.camel@siemens.com>
	 <4d324baa.b48a.19295ceea26.Coremail.jerryjun123@163.com>
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

On Wed, 2024-10-16 at 22:50 +0800, JerryJun wrote:
> It seems to have something to do with migration.
> it=E2=80=98s not triggered it by "taskset -c 1 ./xeno-app" from "Attachme=
nt #2: xenomai-alchemy-app.tar.gz" which make the main thread and child thr=
ead on the same cpu.=C2=A0 besides, there is an interesting problem that it=
=E2=80=98s also not triggered it when replace alchemy with pthread(libcobal=
t) API from attachment.

The affinity just closed the race window. It was clearly a bug in the
task shutdown sequence.

>=20
> At 2024-10-16 17:07:51, "Bezdeka, Florian" <florian.bezdeka@siemens.com> =
wrote:
> > On Wed, 2024-10-16 at 16:59 +0800, JerryJun wrote:
> > > hi jan, in this patch you mentioned "As the lostage_wakeup work is cu=
rrently on the stack,
> > > =C2=A0it can become corrupt when xnthread_relax leaves earlier on the=
 new CPU than the work was processed on the old one ",
> > > why it=E2=80=98s not triggered it in the switchtest benchmark which i=
nvolves "xnthread_relax" due to linux syscall ?
> > > may be you probably describe the triggered scene detailed? Or how can=
 I trigger it in switchtest=C2=A0
> > > =C2=A0by using xnthread_relax leaves earlier on the new CPU than the =
work was processed on the old one?  thanks
> >=20
> > It's about task destruction, not migration.
> >=20
> > The reproducer did a lot of task creation/destruction to trigger that.
> > It happened that the task was already gone while there was still  a
> > node in the irq work referencing the "dead" task.
> >=20
> > Classical use after free due to missing/broken synchronization.
> >=20
> > We're still missing a proper test for that scenario. To my best
> > knowledge Clara will revisit this topic.
> >=20
> > Florian
> >=20
> > >=20
> > >=20
> > > At 2024-09-20 15:58:49, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
> > > > On 20.09.24 02:03, JerryJun wrote:
> > > > >=20
> > > > > =C2=A0 hi Jan=EF=BC=8C the issue reported in [1] has seemly not b=
een solved in ipipe.=C2=A0 Will this issue still be maintained on ipipe?=
=20
> > > > > =C2=A0=C2=A0 =C2=A0the test case is available from Florian Bezdek=
a ([-- Attachment #2: xenomai-alchemy-app.tar.gz --]).
> > > > > =C2=A0=C2=A0 =C2=A0linux kernel: 4.19.89
> > > > > =C2=A0=C2=A0 =C2=A0xenomai: 3.2.4 + patch[1/3]=20
> > > > > =C2=A0=C2=A0 =C2=A0
> > > > > =C2=A0=C2=A0 =C2=A0[1] https://lore.kernel.org/xenomai/770b1e4bc4=
2cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
> > > > > =C2=A0=C2=A0 =C2=A0
> > > >=20
> > > > Sorry, that fix is still only on master (upcoming 3.3), not yet in
> > > > stable trees. It's still not expected to be I-pipe/dovetail-depende=
nt.
> > > >=20
> > > > Let me recover a bit more from yesterday's Preempt RT merge party, =
then
> > > > I will close that gap.
> > > >=20
> > > > Jan
> > > >=20
> > > > > [=C2=A0=C2=A0 98.182433] general protection fault: 0000 [#1] PREE=
MPT SMP NOPTI
> > > > > [=C2=A0=C2=A0 98.182453] CPU: 1 PID: 69131 Comm: rt-task-20 Kdump=
: loaded Not tainted 4.19.89-ipipe-9-xenomai-3.2.4-proc-20240909 #12
> > > > > [=C2=A0=C2=A0 98.182475] Hardware name: VMware, Inc. VMware Virtu=
al Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
> > > > > [=C2=A0=C2=A0 98.182496] I-pipe domain: Linux
> > > > > [=C2=A0=C2=A0 98.182507] RIP: 0010:xnsynch_sleep_on+0x15d/0x250
> > > > > [=C2=A0=C2=A0 98.182517] Code: 30 12 00 00 3b 78 e8 7f 07 eb 4a 3=
9 78 e8 7d 45 48 8b 86 50 12 00 00 48 8d b0 b8 ed ff ff 48 39 c8 75 e8 48 8=
b 86 48 12 00 00 <4c> 89 40 08 49 89 86 48 12 00 00 49 89 8e 50 12 00 00 4c=
 89 86 48
> > > > > [=C2=A0=C2=A0 98.182552] RSP: 0018:ffffc90006327e30 EFLAGS: 00010=
046
> > > > > [=C2=A0=C2=A0 98.182564] RAX: dead000000000100 RBX: 000000000005f=
3e0 RCX: ffffc900012d2a88
> > > > > [=C2=A0=C2=A0 98.182577] RDX: 0000000000000000 RSI: ffffc900012d1=
840 RDI: 0000000000001032
> > > > > [=C2=A0=C2=A0 98.182591] RBP: 0000000000000001 R08: ffffc900012d2=
a88 R09: ffffc900012d2a78
> > > > > [=C2=A0=C2=A0 98.182605] R10: 0000000000000000 R11: 0000000000000=
000 R12: ffffc900012d3708
> > > > > [=C2=A0=C2=A0 98.182620] R13: 0000000000000003 R14: ffffc900012d1=
840 R15: 0000000000000000
> > > > > [=C2=A0=C2=A0 98.182634] FS:=C2=A0 00007f888c3bb700(0000) GS:ffff=
888133d00000(0000) knlGS:0000000000000000
> > > > > [=C2=A0=C2=A0 98.182650] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> > > > > [=C2=A0=C2=A0 98.182661] CR2: 000055738facc000 CR3: 000000012ad44=
005 CR4: 00000000001606e0
> > > > > [=C2=A0=C2=A0 98.182698] Call Trace:
> > > > > [=C2=A0=C2=A0 98.182708]=C2=A0 __cobalt_cond_wait_prologue+0x26d/=
0x850
> > > > > [=C2=A0=C2=A0 98.182720]=C2=A0 ? handle_root_syscall+0xd3/0x310
> > > > > [=C2=A0=C2=A0 98.182730]=C2=A0 ? __cobalt_cond_wait_prologue+0x85=
0/0x850
> > > > > [=C2=A0=C2=A0 98.182741]=C2=A0 CoBaLt_cond_wait_prologue+0x1d/0x2=
0
> > > > > [=C2=A0=C2=A0 98.182751]=C2=A0 handle_head_syscall+0x106/0x3b0
> > > > > [=C2=A0=C2=A0 98.182762]=C2=A0 ipipe_handle_syscall+0x66/0xc0
> > > > > [=C2=A0=C2=A0 98.182772]=C2=A0 do_syscall_64+0x22/0x170
> > > > > [=C2=A0=C2=A0 98.182782]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4=
4/0xa9
> > > > > [=C2=A0=C2=A0 98.182793] RIP: 0033:0x7f888d29575b
> > > > > [=C2=A0=C2=A0 98.182801] Code: 8b 73 04 49 89 dc e8 54 f0 ff ff 4=
8 8b 6c 24 10 b9 23 00 00 10 48 8d 54 24 44 45 31 c0 45 31 d2 48 89 de 89 c=
8 48 89 ef 0f 05 <8b> 7c 24 2c 31 f6 49 89 c5 89 c3 e8 25 f0 ff ff 4c 89 ff=
 e8 7d e9
> > > > > [=C2=A0=C2=A0 98.182837] RSP: 002b:00007f888c3bab60 EFLAGS: 00000=
246 ORIG_RAX: 0000000010000023
> > > > > [=C2=A0=C2=A0 98.182852] RAX: ffffffffffffffda RBX: 00007f888c56e=
6e0 RCX: 00007f888d29575b
> > > > > [=C2=A0=C2=A0 98.183195] RDX: 00007f888c3baba4 RSI: 00007f888c56e=
6e0 RDI: 00007f888c56e7f8
> > > > > [=C2=A0=C2=A0 98.183530] RBP: 00007f888c56e7f8 R08: 0000000000000=
000 R09: 00007f888c56e6d0
> > > > > [=C2=A0=C2=A0 98.183854] R10: 0000000000000000 R11: 0000000000000=
246 R12: 00007f888c56e6e0
> > > > > [=C2=A0=C2=A0 98.184182] R13: 00007f888c3bad80 R14: 0000000000000=
001 R15: 00007f888c3babb0
> > > > > [=C2=A0=C2=A0 98.184500] Modules linked in: fuse nf_conntrack_net=
bios_ns nf_conntrack_broadcast xt_CT xt_tcpudp ip6t_rpfilter ip6t_REJECT nf=
_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv=
6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf=
_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv=
6 nf_defrag_ipv4 libcrc32c arc4 ecb md4 sha512_ssse3 sha512_generic cmac nl=
s_utf8 cifs ccm dns_resolver fscache ip_set nf_tables nfnetlink ip6table_fi=
lter ip6_tables iptable_filter vmwgfx sg ttm drm_kms_helper drm fb_sys_fops=
 syscopyarea sysfillrect sysimgblt serio_raw snd_pcsp snd_pcm snd_timer snd=
 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc evdev aesni_intel a=
es_x86_64 crypto_simd cryptd glue_helper soundcore ac button binfmt_misc su=
nrpc
> > > > > [=C2=A0=C2=A0 98.187446]=C2=A0 ip_tables x_tables autofs4 ext4 cr=
c32c_generic crc16 mbcache jbd2 fscrypto sd_mod ata_generic ata_piix crc32c=
_intel mptspi mptscsih mptbase scsi_transport_spi libata scsi_mod e1000 psm=
ouse i2c_piix4
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > At 2024-08-30 19:13:31, "Jan Kiszka" <jan.kiszka@siemens.com> wro=
te:
> > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > >=20
> > > > > > We cannot rely on the lostage_wakeup work being scheduled only
> > > > > > synchronously over the CPU of the relaxing thread. It thread mi=
ght have
> > > > > > a CPU migration and other wakeup events pending and resume on d=
ifferent
> > > > > > CPU. As the lostage_wakeup work is currently on the stack, it c=
an become
> > > > > > corrupt when xnthread_relax leaves earlier on the new CPU than =
the work
> > > > > > was processed on the old one - ugly crashes ahead as seen in [1=
].
> > > > > >=20
> > > > > > Analogously to the signal wakeups, move the relax work into the=
 xnthread
> > > > > > structure to avoid such corruptions. We intentionally refrain f=
rom
> > > > > > using irq_work_sync in the relaxation exit path to avoid starti=
ng to
> > > > > > wait a CPU that is already busy again with a lengthy RT task.
> > > > > >=20
> > > > > > [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc85=
4956f3e78bb60.camel@siemens.com/T/#t
> > > > > >=20
> > > > > > Reported-by: JerryJun <jerryjun123@163.com>
> > > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > > ---
> > > > > > include/cobalt/kernel/thread.h |  6 ++++++
> > > > > > kernel/cobalt/thread.c         | 15 +++++----------
> > > > > > 2 files changed, 11 insertions(+), 10 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/ke=
rnel/thread.h
> > > > > > index 7f9a37d29a..22ed61168c 100644
> > > > > > --- a/include/cobalt/kernel/thread.h
> > > > > > +++ b/include/cobalt/kernel/thread.h
> > > > > > @@ -64,6 +64,11 @@ struct lostage_signal {
> > > > > > 	int signo, sigval;
> > > > > > };
> > > > > >=20
> > > > > > +struct lostage_wakeup {
> > > > > > +	struct pipeline_inband_work inband_work; /* Must be first. */
> > > > > > +	struct task_struct *task;
> > > > > > +};
> > > > > > +
> > > > > > struct xnthread_init_attr {
> > > > > > 	struct xnthread_personality *personality;
> > > > > > 	cpumask_t affinity;
> > > > > > @@ -214,6 +219,7 @@ struct xnthread {
> > > > > > 	u32 proghash;		/* Hash value for exe_path */
> > > > > > #endif
> > > > > > 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
> > > > > > +	struct lostage_wakeup relax_work;
> > > > > > };
> > > > > >=20
> > > > > > static inline int xnthread_get_state(const struct xnthread *thr=
ead)
> > > > > > diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> > > > > > index 8738fadfce..7dffb081bd 100644
> > > > > > --- a/kernel/cobalt/thread.c
> > > > > > +++ b/kernel/cobalt/thread.c
> > > > > > @@ -1974,11 +1974,6 @@ int xnthread_harden(void)
> > > > > > }
> > > > > > EXPORT_SYMBOL_GPL(xnthread_harden);
> > > > > >=20
> > > > > > -struct lostage_wakeup {
> > > > > > -	struct pipeline_inband_work inband_work; /* Must be first. */
> > > > > > -	struct task_struct *task;
> > > > > > -};
> > > > > > -
> > > > > > static void lostage_task_wakeup(struct pipeline_inband_work *in=
band_work)
> > > > > > {
> > > > > > 	struct lostage_wakeup *rq;
> > > > > > @@ -2052,10 +2047,6 @@ void __xnthread_propagate_schedparam(str=
uct xnthread *curr)
> > > > > > void xnthread_relax(int notify, int reason)
> > > > > > {
> > > > > > 	struct task_struct *p =3D current;
> > > > > > -	struct lostage_wakeup wakework =3D {
> > > > > > -		.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(lostage_ta=
sk_wakeup),
> > > > > > -		.task =3D p,
> > > > > > -	};
> > > > > > 	struct xnthread *thread =3D xnthread_current();
> > > > > > 	int cpu __maybe_unused, suspension;
> > > > > > 	kernel_siginfo_t si;
> > > > > > @@ -2069,6 +2060,10 @@ void xnthread_relax(int notify, int reas=
on)
> > > > > > 	 */
> > > > > > 	trace_cobalt_shadow_gorelax(reason);
> > > > > >=20
> > > > > > +	thread->relax_work.inband_work =3D (struct pipeline_inband_wo=
rk)
> > > > > > +		PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup);
> > > > > > +	thread->relax_work.task =3D p;
> > > > > > +
> > > > > > 	/*
> > > > > > 	 * If you intend to change the following interrupt-free
> > > > > > 	 * sequence, /first/ make sure to check the special handling
> > > > > > @@ -2081,7 +2076,7 @@ void xnthread_relax(int notify, int reaso=
n)
> > > > > > 	 */
> > > > > > 	splmax();
> > > > > > 	trace_cobalt_lostage_request("wakeup", p);
> > > > > > -	pipeline_post_inband_work(&wakework);
> > > > > > +	pipeline_post_inband_work(&thread->relax_work);
> > > > > > 	/*
> > > > > > 	 * Grab the nklock to synchronize the Linux task state
> > > > > > 	 * manipulation with handle_sigwake_event. This lock will be
> > > > > > --=20
> > > > > > 2.43.0
> > > >=20
> > > > --=20
> > > > Siemens AG, Technology
> > > > Linux Expert Center
> >=20

