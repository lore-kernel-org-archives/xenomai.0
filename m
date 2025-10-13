Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEE3081A3
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363105; cv=none; b=M6rWYUi3n9bGlyFyN/YtEVlI4nM4Kl0ogUJpuorEEsI/qCVGpkWsBV9cJyQz3Ine9ZPf1+StOVL+KfWHviJxaNWfofO6kJKq94DHV2IS8hTyV3N1+7838fk/b7Iz44Fr6ErfzK/SsKw8lFwkCrCmgj6eHQUT3YNcdY8/Vyd4Evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363105; c=relaxed/simple;
	bh=j1S73JNSIrB7VZSt0YMkd48rzPbFY1we00+HsVDn/7M=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=QDDMTVqh4kNL2uu4StgXGnHyXE/VOE4qtHKu7NfDyWi03ug+tVnCLC4PkmN7TGE1YVmW9XgrsNsTkQB3dyiCAxUTVhZsHsPBC2gRIM6d3H0bCGFIWNBFiW/BWxjk4TyjBQ2woQkCB2wRUyPlAnRie3fEUCrSyty+Zfi7vgJLEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecraftsmen.org; spf=pass smtp.mailfrom=codecraftsmen.org; dkim=pass (1024-bit key) header.d=codecraftsmen.org header.i=@codecraftsmen.org header.b=rNxBcjYP; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecraftsmen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecraftsmen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codecraftsmen.org header.i=@codecraftsmen.org header.b="rNxBcjYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codecraftsmen.org;
	s=protonmail; t=1760363085; x=1760622285;
	bh=+7GPlR37QjoUXELUeRsyXiB8WSdV44GuHnf6qPvwNgs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rNxBcjYP1bB4BmEDvhcs7SH+khfbllF27JI4w4HGRTKDqTwxTi4B1+L7zF8eVO2zU
	 O9tH368dqwjpg0VzUjmb1y9UtyTj6BxxtfJQqKqW1JaYYV2gOMxN8m+fFKaOUTrwHV
	 2lqR/oDC6cA5f0eVo0L5vcs4aRfkOWaqMoFlchAY=
Date: Mon, 13 Oct 2025 13:44:37 +0000
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
From: Jeff Webb <w1@codecraftsmen.org>
Subject: Latency issue on 6.12
Message-ID: <UyAUfjoIsmXhBUPBcslxRMNNb8GuRTy_kf6DCgLluexP13gUInYxr2sneftMAHkSwlvsvfMJMWnYvdXgpQCSsVSEDKG2-sFu1AV3dogwtdo=@codecraftsmen.org>
Feedback-ID: 11561076:user:proton
X-Pm-Message-ID: 4f05818f879a69030979cc3ddf5d3efd9ac7c806
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We have recently upgraded our real-time x86 application from ipipe 4.19.266=
-cip86/xenomai-3.1 to 6.1.137-cip42-dovetail4/xenomai-3.3.1, and the new se=
tup seems to be working reliably with both our own application and the Xeno=
mai-provided latency test program. When we use a 6.12.30-dovetail4 kernel, =
however, the latency program and our real-time application seems to still w=
ork properly on some older hardware (i7-8700K processor), but we eventually=
 start getting some latency spikes in the 700 us range on our newer i5-1440=
0 systems.

Tracking down this issue is on my to-do list, but has not been a high prior=
ity, since we have a working setup.  In light of some recent posts mentioni=
ng latency issues with 6.12 and later kernels, I thought it would be a good=
 time to post this information to the list, in case it is relevant to the i=
ssue others are investigating.

Thanks,

-Jeff

