Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660541DF75A
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534632; cv=none; b=NRr++2wGC8ZukoIKjMiTV0tLgEWZ/4Qoo/ZCsi3Y7zAx3TLrnBKVdYjiiOJ8fYMrFhV3AlgoUT+5FWwFctCisXrlWHqcxAmotqbBVmzRc+LvoO44m5ezA4gm9HXDA1d9BOiH8tamXmSwINVz2bVlx4O/aoOjGlU8rMxzNT/XhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534632; c=relaxed/simple;
	bh=mgVkfOcvUU7/hwNUFzgMiM/b3omN/jQLHs38fQW2jNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8Fi4o48+zKrXV1BRldxMTolbGmfR9GnAvZS270iBU/mDb0NfGRyecz2PkqWRdR8vlxiJsGzmvmT3U8Lytjr7FSwEQ54FZF0Fg5HZz4YvNGoheLB2J5u/4t/B1ri98mRK/yMK73iAAU8PDb4oxcRzqJNIbAgBp3KU2DLac62InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecraftsmen.org; spf=pass smtp.mailfrom=codecraftsmen.org; dkim=pass (1024-bit key) header.d=codecraftsmen.org header.i=@codecraftsmen.org header.b=lYZ6+yWR; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecraftsmen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecraftsmen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codecraftsmen.org header.i=@codecraftsmen.org header.b="lYZ6+yWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codecraftsmen.org;
	s=protonmail; t=1760534621; x=1760793821;
	bh=ItMKPDUx4yhx1ZgTSgDB3BNDnQI2pM/Ss2YLtRvYpzA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lYZ6+yWRgg1cc7QauXPuwSbjkqDc2QdHIeo76CwhR+Z8LxGZp7nOi8eRIUhcR/hIV
	 haI61Z+TUN8zuFmlqnzhrBeysvt7VpaN4mqg5ecSG7mg4uas+xkNk6FVap9r/TrZc1
	 rxMNkYUVNpgNYjfTnAQTyJDd1y1YXk0kDnvCifVM=
Date: Wed, 15 Oct 2025 13:23:35 +0000
To: Jan Kiszka <jan.kiszka@siemens.com>
From: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Latency issue on 6.12
Message-ID: <e00zlRP9qnjiSENhMq8gvn0Zrb0TwaxHu1QRYV89O__6QXmd1UsSX5Ij9fbJLlEufSZI1MBPYFMBy4xniXi6oF0YqdKrN9XuirJS9Q96HaI=@codecraftsmen.org>
In-Reply-To: <207334db-048c-4c38-ad21-bcbd139899b4@siemens.com>
References: <UyAUfjoIsmXhBUPBcslxRMNNb8GuRTy_kf6DCgLluexP13gUInYxr2sneftMAHkSwlvsvfMJMWnYvdXgpQCSsVSEDKG2-sFu1AV3dogwtdo=@codecraftsmen.org> <207334db-048c-4c38-ad21-bcbd139899b4@siemens.com>
Feedback-ID: 11561076:user:proton
X-Pm-Message-ID: 107518787626fda47c6bde867000d772d8902e7c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 15th, 2025 at 12:41 AM, Jan Kiszka <jan.kiszka@siemen=
s.com> wrote:
>=20
> On 13.10.25 15:44, Jeff Webb wrote:
>=20
> > We have recently upgraded our real-time x86 application from ipipe 4.19=
.266-cip86/xenomai-3.1 to 6.1.137-cip42-dovetail4/xenomai-3.3.1, and the ne=
w setup seems to be working reliably with both our own application and the =
Xenomai-provided latency test program. When we use a 6.12.30-dovetail4 kern=
el, however, the latency program and our real-time application seems to sti=
ll work properly on some older hardware (i7-8700K processor), but we eventu=
ally start getting some latency spikes in the 700 us range on our newer i5-=
14400 systems.
> >=20
> > Tracking down this issue is on my to-do list, but has not been a high p=
riority, since we have a working setup. In light of some recent posts menti=
oning latency issues with 6.12 and later kernels, I thought it would be a g=
ood time to post this information to the list, in case it is relevant to th=
e issue others are investigating.
>=20
>=20
> Thanks for reporting. I think we will need some traces from an affected
> system in order to understand better what's going on.

Thanks, Jan.  I figured as much.  I am not proficient at using ftrace with =
either the vanilla or dovetail kernel.  I see some documentation specific t=
o EVL here [1], but I am not sure how to adapt it for Xenomai3-dovetail.  W=
hat path do you recommend?  Should I add the mentioned tracing options to m=
y existing Xenomai3/dovetail kernel config, rebuild the kernel as before, a=
nd then follow the instructions in [1] to run latmus?  Should I (or must I)=
 build the kernel without the Xenomai-specific stuff in order to do that in=
stead?  Is there another non-EVL approach I should consider?

Thanks,

-Jeff

[1] https://v4.xenomai.org/core/commands/#evl-trace-command

