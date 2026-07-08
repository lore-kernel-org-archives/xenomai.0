Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F542E8DEF
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526106; cv=none; b=Y/XDPjADiqfKxheuDaQovmqOaAZtx60B0xp0ORuED58BXqvUVDFeQj+Jfvs3zbdp74cZrf7p3GRoQkM5zcmMW0Qi7BZpT0FOqAn5HwojRU10GjrexDeykLU2n6n9CZ3gWLpJEmxoQYWxWDEGnlbseRr0+cZvr2kN4IXjOeE87n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526106; c=relaxed/simple;
	bh=tw3ee/AHKumsSOqN4Khe11vpvOj1xo2eu1QWucA9TQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjKbRjJ3LMGOflZtiOQVjDQ/fx3nz9/wRMb8m85xeChNu1WmABaizml2Jtk8+ZccYDq7LDxZlvDDLJJC8BeCofr5P4xVwjMhTP2XZ7ampK7Z1rzR4ks8os6T/OXQFw/R9ASji79Yj5MQ3h/NAdDs+d/21gB0GWhaq/xpY9IcitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mAgxVxFp; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mAgxVxFp"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260708155458ea28e746140002073a
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 17:54:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3XpJcZ2ExX5h4870E60q3W59sTqBcD5brXVX0um2U48=;
 b=mAgxVxFpg/yhQcgF0fSBoRLYmlGZuyqN2fvEQ/LbNGSUsoCmn3QXLU7/Yp+W7t5b7Roev4
 9RcIVqcBFf1o/4Kuvps49+tU+YZqBCRNXqtPyu1KZb7hWWDhQ2gJaqhnJisKcOXKCDtjthXE
 vreNytXIR/x4KOmf1SFkUbvqquBn7uPlhQkBoCHRItLy2r5TGn+PiFfCTGGMynn2RVLSxfcu
 CaWvCuBvfKR9kf4arFSPHm3KlCXJD5/xtdqf5xUIbHy3F9cYEnlWo1nlEdOLbl+me9puCA8V
 A0kzncUz9YDsE0gDHyv0YfTqgLy6jvCfWsFmEMLbzQCJTim2qIQ5qVwA==;
Message-ID: <51af61e74903e45b7eadcecd912fbd7f2eed962e.camel@siemens.com>
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 08 Jul 2026 17:54:58 +0200
In-Reply-To: <bd695b7d-fb94-4f2a-8ed2-d02d87ac9217@siemens.com>
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
	 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
	 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
	 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
	 <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
	 <bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
	 <87zf01lv1z.fsf@xenomai.org>
	 <a72d61e20ebd3c5279b1f80f2a7d5225eb8fdb08.camel@siemens.com>
	 <bd695b7d-fb94-4f2a-8ed2-d02d87ac9217@siemens.com>
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

On Wed, 2026-07-08 at 17:32 +0200, Jan Kiszka wrote:
> On 08.07.26 11:51, Florian Bezdeka wrote:
> > On Wed, 2026-07-08 at 10:55 +0200, Philippe Gerum wrote:
> > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > >=20
> > > > On 08.07.26 08:26, Tobias Schaffner wrote:
> > > > >=20
> > > > >=20
> > > > > On 7/8/26 08:07, Jan Kiszka wrote:
> > > > > > On 08.07.26 07:17, Tobias Schaffner wrote:
> > > > > > > On 7/8/26 00:30, Florian Bezdeka wrote:
> > > > > > > > On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
> > > > > > > > > Hi all,
> > > > > > > > >=20
> > > > > > > > > this series introduces an initial EVL port for RISC-V.
> > > > > > > > >=20
> > > > > > > > > While some tests are still failing, I=E2=80=99d like to s=
hare this early
> > > > > > > > > version with the community to gather feedback, reviews, a=
nd hopefully
> > > > > > > > > some assistance in refining the port.
> > > > > > > > >=20
> > > > > > > > > The patches have been tested in combination with the Dove=
tail RISC-V
> > > > > > > > > port on top of v6.12-evl1-rebase.
> > > > > > > > >=20
> > > > > > > > > Looking forward to your feedback and suggestions.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I tried to apply this series today, and run into the follow=
ing issues
> > > > > > > > reported by my tooling.
> > > > > > > >=20
> > > > > > > > Patch 1 is fine, patch 2 has some checkpatch findings.
> > > > > > > >=20
> > > > > > > > A couple of debatable warnings like:
> > > > > > > >=20
> > > > > > > > WARNING: Misplaced SPDX-License-Identifier tag - use line 1=
 instead
> > > > > > > > #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
> > > > > > > > + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-not=
e
> > > > > > > >=20
> > > > > > > > WARNING: unnecessary whitespace before a quoted newline
> > > > > > > > #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
> > > > > > > > +
> > > > > > > >=20
> > > > > > > > In addition to a serious one:
> > > > > > > >=20
> > > > > > > > ERROR: Missing Signed-off-by: line by nominal patch author =
'shannmu
> > > > > > > > <shanmu1901@gmail.com>'
> > > > > > >=20
> > > > > > > I did not get any responses from this email anymore. I can tr=
y to reach
> > > > > > > out to him one last time, but what do we do about it if he wi=
ll not
> > > > > > > reply?
> > > > > > >=20
> > > > > >=20
> > > > > > If I read that patch correctly, it's majority is taken from the
> > > > > > corresponding Xenomai 3 logic. How much is unique contribution,=
 how much
> > > > > > was your work, Tobias?
> > > > >=20
> > > > > I added the evl_set_fpregs/evl_check_fpregs content which is a
> > > > > translation from what Gilles Chanteperdrix
> > > > > <gilles.chanteperdrix@xenomai.org> did for the x86 and arm archit=
ectures
> > > > > with some isa enablement bits added.
> > > > >=20
> > > > > This should be the initial version by shanmu where I added this o=
n top:
> > > > > https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv=
/
> > > > > evl_port/arch/riscv/include/asm/evl/fptest.h
> > > > >=20
> > > >=20
> > > > At least for this patch, I think it would be fair to claim authorsh=
ip
> > > > for the final one and only refer to shanmu as provider of a baselin=
e.
> > > >=20
> > >=20
> > > Agreed.  This is a trivial adaptation of the pre-existing
> > > arch/arm*/include/asm/evl/fptest.h, which is in and of itself
> > > boilerplate code.
> > >=20
> >=20
> > We had a short chat about this topic in the Xenomai community call
> > today. To avoid further delay of the dovetail 7.1 release we decided
> > that we will move out the risc-v series again.
> >=20
>=20
> As you already removed wip/flo/v7.1-evl-rebase+riscv (which broke
> xenomai-images CI, unfortunately), where will be the new transitional
> branch in the meantime?
>=20

Oh, those temporary branches shouldn't be referenced in public CI
things. If necessary we can bring it back.
