Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFA35972
	for <xenomai@lists.linux.dev>; Fri, 12 Jun 2026 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246922; cv=none; b=XbQPcuHD9TunavKTbl031YRCltvid2eBnetlNmlt7VUFJZsdLD/dIC7UU5tbRgBGDMDOzmELWG3J6cXBSwXe1cBi0r4kQEQErRa22vWih3/VDgxSugWHfVQHZFkq9sZF5BZSiFxkrnbI+4qC9oNKUrplrWbsw8d9nJWHIV51Rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246922; c=relaxed/simple;
	bh=FqNDGZ00lHkn6D48wByeM9qp4opv81vfar7m8zGr5i8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6xxMA6MTQzUIa5PfJnHZpztBV8i5TkVQgB2jLLjrGZo2DFpoY++mMS0DfgkrTY/blDaaCEus+h0fcNF7GePB3CCwdbMaceccEakiz+//Q5mBz8vQkiuBn1gyTDmJGV0ZrDVulR6dG7vaKLc4uiavIwud79pLuxh9IgBBB+4pys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KwTWS2z/; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KwTWS2z/"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202606120648270137a80906000207e7
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jun 2026 08:48:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G2L5JyxA+bhdoblt1QtmCGLWddA+4UPvK+2NXKBOme8=;
 b=KwTWS2z/W5QDPfo0mD3zRvDt+josQV40tX52hqso6DOw7n5TP3HhpB1pde1xPjOZVUQtEf
 Z0+fX+WKj/KkVQJ1Q8TGDtwYBYy3uZrXRM4CoPbuisiSwV8gHuxmuxM2M2DuHPwkpULktaAZ
 cGsbHcsKRc6etlo/xMc74vOAyye/CvmiBnHJ6uKItzt1sBTczmlrdmrLbXDc55nzbGqxe5CQ
 ES6F/PN7VtoHnEKizAamHhKYCCJeafDP2TbU6U+Yl+MkmBcsEH+I80Q7Mr8OJDE8h/ZIcsJV
 m0p7RKkaPe2Ix8KEA7bnGshW4Tk/9AA4Qhc6+kTfD1xv1Eecwyks58LQ==;
Message-ID: <4c54868822f967af3e3fa18a2d6688991efbfacd.camel@siemens.com>
Subject: Re: Dovetail 7.1-rc6 updates pushed
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Date: Fri, 12 Jun 2026 08:48:27 +0200
In-Reply-To: <3551ce7178079f669dcf8a15981132be3641571a.camel@siemens.com>
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
				<87y0gy4brj.fsf@xenomai.org>
				<27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
			 <87se763yji.fsf@xenomai.org>
		 <eae9c7c7ecfebf7503f52051e8a444a4cec90888.camel@siemens.com>
	 <3551ce7178079f669dcf8a15981132be3641571a.camel@siemens.com>
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

On Wed, 2026-06-03 at 08:20 +0000, Bezdeka, Florian wrote:
> On Tue, 2026-06-02 at 11:43 +0200, Florian Bezdeka wrote:
> > On Mon, 2026-06-01 at 20:28 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > On Mon, 2026-06-01 at 15:43 +0200, Philippe Gerum wrote:
> > > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > > >=20
> > > > > > Hi all,
> > > > > >=20
> > > > > > I just pushed the following branch updates for Dovetail based o=
n 7.1-
> > > > > > rc6:
> > > > > >=20
> > > > > > Dovetail:
> > > > > > wip/flo/v7.1-dovetail-rebase
> > > > > > wip/flo/v7.1-dovetail-rebase+riscv
> > > > > >=20
> > > > > > Evl:
> > > > > > wip/flo/v7.1-evl-rebase
> > > > > > wip/flo/v7.1-evl-rebase+riscv
> > > > > >=20
> > > > > > The +riscv branches are containing v8 of Tobias' riscv enabling=
 series,
> > > > > > maybe we need v9, let's see.
> > > > > >=20
> > > > > > Any additional testing on those branches is highly appreciated.
> > > > > >=20
> > > > > > @Philippe:
> > > > > > I'm still waiting for some feedback for [1]. That seems now to =
be a
> > > > > > invalid combination of kconfigs, which is dovetail specific. Up=
stream
> > > > > > thread at [2].
> > > > > >=20
> > > > > > Can you remember why KVM_INTEL is not selecting X86_FRED in cas=
e
> > > > > > IRQ_PIPELINE is enabled? I haven't checked the details yet, nor=
 tried to
> > > > > > remove the dovetail specific adjustment.
> > > > > >=20
> > > > >=20
> > > > > Maybe because the pipeline never supported X86_FRED, doing so wou=
ld
> > > > > required to rework the irq-entry trampoline macros, which is deem=
ed
> > > > > painful work.
> > > >=20
> > > > I sent out a RFC patch for that, input welcome.
> > > >=20
> > > > Meanwhile I can provide some updates on the testing part. The follo=
wing
> > > > problems seem to be reproducible on 7.1-rc5 and 7.1-rc6 - while 7.1=
-rc4
> > > > was fine (at least once):
> > > >=20
> > > > x86   x3: Test timeout. Something seems slower than expected.
> > > > arm64 x4: Same problem
> > > >=20
> > > > To rule out problems in our CI setup I spawned some 7.0 tests, whic=
h
> > > > were fine, at least twice in a row. Seems someone has to look into =
that.
> > > > As I'm running out of time: Any resources available?
> > > >=20
> > >=20
> > > Not here, at least not yet.
> >=20
> > I scheduled a couple of overnight test runs on -rc4. Those test are
> > looking OK. Something in -rc5 seems to trigger that. The problem seems
> > qemu/kvm specific, test runs on real hardware were OK.
> >=20
> > I found a couple of recent discussions around VMX/SVM regressions, some
> > of them related to the delayed hrtimer arming. As we disable the delaye=
d
> > arming completely, that should not be our problem. Maybe we should just
> > wait for -rc7?
>=20
> The last remaining problem for now:
>=20
> 2026-06-02T22:14:24 proxy-poll: OK
> 2026-06-02T22:15:07 [  116.129252] bcmgenet fd580000.ethernet end0: NETDE=
V WATCHDOG: CPU: 2: transmit queue 4 timed out 3700 ms
>=20
> That was taken from an evl test on rpi4, the same happens (without
> watchdog warning) on arm64-qemu. Seems the system is dead afterwards.

Short update:

All branches have been updated again. All branches are based on -rc7
now. Tests are looking good now. There was one issue on arm64 remaining.
The entry code got some refactorings which needed some pipelining
adjustments (see patch on the list, [3]).

Pending: Feedback for the arm64 modifications. See [3]. Already part of
the 7.1 branches.

Pending: Feedback for the x86 build failures related to FRED [4].
Already part of the 7.1 branches.

Pending: Feedback for the arm pipelining fixes [5]. Not yet part of any
7.1 branch.

With that I'm considering my part as done. Waiting for some riscv
updates, which should be easy to handle.

Florian

[3] https://lore.kernel.org/xenomai/0a76369a44e33ca1c8c27c5c2690770b4668be7=
c.camel@siemens.com/
[4] https://lore.kernel.org/xenomai/558767f3737914500bcfb1d0bb3f27c0089a98e=
e.camel@siemens.com/T/
[5] https://lore.kernel.org/xenomai/20260610-wip-flo-v7-1-arm-pipelining-fi=
xes-v2-0-62c9c477f8f2@siemens.com/
