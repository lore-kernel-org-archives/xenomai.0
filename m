Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B926A0FF
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117125; cv=none; b=QEZ5oQLc2+PrC7k8JiTHN9OsdqRPQrv6Opg3rKcIBuH8623Hp2j8oDf2uup0m4e4zMPKp4vcvJ3zF8+o9VDQFrMuHme/36JhU6oVHUxpQ8GI68M1/a8LwF/YPivO98fGucNI7QJvXa05O4JojAOnKdmoOKM7Sfe4yw4af8jp0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117125; c=relaxed/simple;
	bh=uSHCmdle0pgKhtgEfjdKH8yiPRqIoekegM/zCp5bkFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0pdG9jXFPDZJOys6YXa+Z2BHKta1U9+URIAtLUp0CovlE1vnVkAoeJeE5aRNYglQQ5LHBnMPX5qqBcuDn1ZRYq3zvQ9eziEZvQsqaxnjlCFjjaRqqUAI6Uv0zQSwkKzfwe6eWnp6kcohoyx6f03NYd7a7dPWzhcxAnIIPdXP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OlhY6rUI; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OlhY6rUI"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025040812583774886a5a85da17a458
        for <xenomai@lists.linux.dev>;
        Tue, 08 Apr 2025 14:58:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jQeQJ0gp97R/Rcezf6HWEnpATYSqx4PGmNKxqTYa2d8=;
 b=OlhY6rUInBnTjUBlz+5ySEdcQnxnGExrpIl9aD6CtplD67bG9LXC/y2xwJCzG7KKhZAaOn
 ZuvjfAKLRRQ2mGbqhPxWSGxArDm+ne3eVqORq/oiOzcDgJa/CFzea7u/XCqI+mmiNNSPRJhA
 zz8eNDS3Soi7hwWouICqHSsl/WRA88/8GsYPMaQT4xS9Z9TIVe3y9mh20KRX13nAuUZM3Aco
 vl4GpywJR5U8Qi3a9cobOtPzv149hbqoxaFYG2jBV7ZAFA+16v8r6OoB02SqPJXfQZf3+Anq
 EXFViHX+TkifwYKi2fJWYogtwbwL/+YVxxDHoa7NTwWuoiRocAH1SgOA==;
Message-ID: <b7a88e1a195a47892cb40e29ced523cda043d533.camel@siemens.com>
Subject: Re: [PATCH 3/5] arm64: dovetail: Allow early return from traps
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>, Johannes
 Kirchmair <johannes.kirchmair@sigmatek.at>, Jan Kiszka
 <jan.kiszka@siemens.com>, Lorenz Kofler	 <lorenz@sigma-star.at>
Date: Tue, 08 Apr 2025 14:58:33 +0200
In-Reply-To: <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
	 <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
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

On Tue, 2025-04-08 at 14:34 +0200, Nikolaus Funk wrote:
>  void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_reg=
s *regs)
>  {
> -	mark_trap_entry(ARM64_TRAP_ALIGN, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +		return;
> =20
>  	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
>  			 addr, esr);

This hunk looks odd: ARM64_TRAP_ALIGN vs. ARM64_TRAP_ACCESS?
