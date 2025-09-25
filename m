Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638635957
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805409; cv=none; b=P0sjYR1lQ6AKHb8BXLgdVawiopfE12WWPjc5V3V3/TVvNiQS9wQZxQd6EOITlP8i/dcuzWH7a8w6dXl8GMcqghjvhA8nOQtSnJjHYvlUIhhwMpMiokQVs4WTBXfHYPTlNga0XOTiLv88/Nn06rN0eZ8in0/LT7X450yvk1g5YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805409; c=relaxed/simple;
	bh=9G/J6E3UqYsSUwffjbTWdlsl57dhDa7WJSV0WbcFrGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obwh99/t/dIF8T1awQmfAx1nexfwkgbanAC+wdIDgNcobuhQF+PlIGNiwZpQphACXtHchiHDmHqcJ8X7olxaMDlv3lbKtfflrHQ9+v94HhBYrzgxaCwnVxQNKoXJ2zQezsMFubcOdHxr09HIJnTenbm0vuOTjyDbBFOQYB3Z1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FJXM3Aty; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FJXM3Aty"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id B3F7541B5C
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:03:23 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 251BF7803DA
	for <xenomai@xenomai.org>; Thu, 25 Sep 2025 13:03:23 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025092513032210a776e531000207ce
        for <xenomai@xenomai.org>;
        Thu, 25 Sep 2025 15:03:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9G/J6E3UqYsSUwffjbTWdlsl57dhDa7WJSV0WbcFrGg=;
 b=FJXM3AtyN/vBp/6Y1PbyUt3Lyvi/W62o8ZVgpf7FWlPmCvCnP/VqpOIo6TQrpONpJSwpcM
 azvtlHgXk/8+PU2X7QKdk9VGtGRe8lG2MBZFTfI1fvWgZQKbYGSRKiPSlUG2giAcl1jODnUQ
 xFaerpu1UR0sUwNNq4qP31kVLQt11IhDqSKfHE774xoNDvOdRMq6qm8MznlX5tY9Z5hEnwZ3
 mqNtikDK0tgWzFZLmnRAsZHFWD/d+YFJBPD1eHA0c/wJrn/FLhp1X3z8vAd/H5qeFJPuFbVe
 LOiQk/7YpOAk9f9tXfvukQZtu+NWHF8mJYU1WcJxCzLJ2Ck+D4hyKC4A==;
Message-ID: <ab2fb1e6e11e2042c232eb7a5cfd7bd274f744e5.camel@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Thu, 25 Sep 2025 15:03:21 +0200
In-Reply-To: <ed50d23c-fb0f-413e-b19d-284ee56bc0bd@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
	 <87bjn1m28m.fsf@xenomai.org>
	 <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
	 <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
	 <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
	 <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
	 <ed50d23c-fb0f-413e-b19d-284ee56bc0bd@siemens.com>
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
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=FJXM3Aty;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-2025092513032210a776e531000207ce-gaJmt6@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-68982-2025092513032210a776e531000207ce-gaJmt6@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgggesthhqredttddtjeenucfhrhhomhephfhlohhrihgrnhcuuegviiguvghkrgcuoehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelleffffeivdejgfdvvddvleevteekueeuieehhfffieduteegfeetffekjedthfenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvddufedpudekhedrudefiedrieegrddvvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqdeikeelkedvqddvtddvhedtledvhedufedtfedvvddutdgrjeejiegvheefuddttddtvddtjegtvgdqghgrlfhmtheisehrthhsqdhflhhofihmrghilhgvrhdrshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Thu, 2025-09-25 at 15:00 +0200, Jan Kiszka wrote:
> On 25.09.25 14:57, Florian Bezdeka wrote:
> > On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
> > > On 25.09.25 14:47, Florian Bezdeka wrote:
> > > > On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
> > > > > On 23.09.25 20:51, Philippe Gerum wrote:
> > > > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > > > > >=20
> > > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > > >=20
> > > > > > > Not all callers of this function do that themselves.
> > > > > > >=20
> > > > > >=20
> > > > > > Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu=
_put_fp()
> > > > > > would not benefit from doing that themselves precisely, to crea=
te an
> > > > > > atomic section around their internal state change _and_ the fps=
imd flush
> > > > > > op?
> > > > >=20
> > > > > Is kvm on arm64 officially enabled for oob (-preemption), or are =
we
> > > > > patching blindly here? If no one was looking at kvm yet, then you=
 might
> > > > > be right. If it was reviewed already, then this here is just clea=
ning up.
> > > >=20
> > > > We have
> > > > https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3=
655577fb34cac7996f166d2a
> > > >=20
> > > > since 6.14 (AFAICT). At the time of writing this was the first kern=
el
> > > > release that used in-kernel FPU. Maybe that changed (thanks to
> > > > backports)? Btw: Which version are we talking about right now? 6.1?
> > > > 6.12?
> > >=20
> > > All of them.
> > >=20
> >=20
> > In case backporting is considered:
> >=20
> > Please also take
> >=20
> > 97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")
> >=20
>=20
> No signed-off - still testing?

No, just realized that as well. Must be a glitch somewhere in my
workflow. No idea how that happened. All other patches in the same
series were fine...

>=20
> > into account. Just a "couple of weeks" old and brings some
> > optimizations.
> >=20
>=20
> That goes to Philippe then.

Would be nice to know upfront if that would fix the actual problem...

>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
