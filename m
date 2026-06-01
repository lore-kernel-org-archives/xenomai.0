Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5D3A2543
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307357; cv=none; b=UI0ETuRl4hjRVcygMyFGRbI66IR1BgijNHqd37uQhqjFL/ICzIMPJM3tjMVt1usi1EqeKwDMjVquNh5lptFLM5cVHdoM9Rn9HJ7I47EJwSooe9WUVwA/6QIMi20lsY1kh8rjgNkAAKDe9aAm2Pn86+plfC04YUfscdl0g5GVGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307357; c=relaxed/simple;
	bh=WsMHi6PP1HVXEL1Wx8Af1k5HNKqvcXh7X/4oS36tbQo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=kOPf20djLQK3UZhKHfsFdzfD2Qi36bxq28gPPTE9rc+1yjb569DOxHtAIETNaMjuXKaQZGU4rcC+ZzB45+rSoMbfnjEjsu3/KMwHWdtsGat5rjaqU7cfmaV/Y6LIpbLkvngvumDJVAcOikVe8JtlsshEUPyEYLnbXo/JoTdWF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LDjwNBT/; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LDjwNBT/"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202606010949035982dc28b6000207e9
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 11:49:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WsMHi6PP1HVXEL1Wx8Af1k5HNKqvcXh7X/4oS36tbQo=;
 b=LDjwNBT/+O45X2PuM6EnGz1ahM1LL87wPKSW7Cul4xfhMVX1mrywW9zWPPzqQKlF25kose
 GRYh7n8gY0AK7Vhbbc9BTmPEa6HZInLxB4toNIHup0dqVWZOSjqLrK75/qp6iCcTlG8KL02X
 ZE1QR6Y+oCO6lYIsoMYQVpVCSBkVE2Kk9gh7+c/9IhWst+buE69FKLX9YCEfhhkeNShEBbW0
 NPIzEICOjZhsQyH9E4HPO6SYIgVCb8fadA/dZoDaCN/EwYb+rq081Ny0dA+dSRJ56R9Wi8fe
 P3/+uhD8W5oJxrwoTxQonUB+Mku3FMyhvRyatJDJzf+qOlrgQ770jGbA==;
Message-ID: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
Subject: Dovetail 7.1-rc6 updates pushed
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Date: Mon, 01 Jun 2026 11:49:03 +0200
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

Hi all,

I just pushed the following branch updates for Dovetail based on 7.1-
rc6:

Dovetail:
wip/flo/v7.1-dovetail-rebase
wip/flo/v7.1-dovetail-rebase+riscv

Evl:
wip/flo/v7.1-evl-rebase
wip/flo/v7.1-evl-rebase+riscv

The +riscv branches are containing v8 of Tobias' riscv enabling series,
maybe we need v9, let's see.

Any additional testing on those branches is highly appreciated.

@Philippe:
I'm still waiting for some feedback for [1]. That seems now to be a
invalid combination of kconfigs, which is dovetail specific. Upstream
thread at [2].

Can you remember why KVM_INTEL is not selecting X86_FRED in case
IRQ_PIPELINE is enabled? I haven't checked the details yet, nor tried to
remove the dovetail specific adjustment.

That's the last 7.1 related TODO on my end, provided that testing goes
well.

Best regards,
Florian

[1]=C2=A0https://gitlab.com/Xenomai/linux-dovetail/-/commit/0f02151294aad2b=
e733fb6f03b09edf4f864e6f9
[2] https://lore.kernel.org/all/6ae24df3f3a62957ca997c6788926fd212f074b3.ca=
mel@siemens.com/
