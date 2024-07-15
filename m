Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8174185E75
	for <xenomai@lists.linux.dev>; Mon, 15 Jul 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039356; cv=none; b=gGp1ih0AzEJaNJHxZdHl+rFXsa8SMKLsnI0yAqI2KdYr6kQgDzrPKA2IfEyhjKhsybu3aTXVLaeBeWmTAa9i5e/mlICO9wiaLV9fzPlvpEufdsoIOYBjHm+GKM3xJbp/ZZMBFHouGzXW/uFJoZXpddoJkBsH+641ePW0YM6w9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039356; c=relaxed/simple;
	bh=u94jtLn80bEBcHuWye9sNKDz97QGGBfjXBqLyq1pu+8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V35QATm/z7s47fuV5oSfbveVf60n4KEQsqH2Qf6d5uPNBNiO/KcN5vDaqoU/9VfocHeXc5PIlhPf6qvCvj08yrytiypVBvlWvLYqRzDwUP6uuAxuANBIUjKyKNYo1AoOjAHQwXxg46gc/sFwXuohiJeztQgEmQqJyHufoOp/6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pmhws8u0; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pmhws8u0"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240715102859c10c0821d7958df412
        for <xenomai@lists.linux.dev>;
        Mon, 15 Jul 2024 12:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=u94jtLn80bEBcHuWye9sNKDz97QGGBfjXBqLyq1pu+8=;
 b=pmhws8u0dZWhLtR5NAy6t+y5OKSQFg1FFkyUy+rJfmb5mZBZPF3kXOb+GDH3KChr9taC5m
 7UcDpQR8CPRMaPXGxJTycRZAQchqTTdKwqAX14uQktW7U8fQWHowwfHKK1uomtH/EaKsKmX9
 J1TLMBDHoc1NeKK0isi8mw6jvNpyU=;
Message-ID: <8abba50b7b6e1237cbaebdb4317b8a2a7736c233.camel@siemens.com>
Subject: Re: [PATCH v2 00/33] drivers: Fix missing printk log levels, remove
 rtdm_printk()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 15 Jul 2024 12:28:54 +0200
In-Reply-To: <1adb6804-7db5-475f-99ed-21487f67fea5@siemens.com>
References: 
	<20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
	 <1adb6804-7db5-475f-99ed-21487f67fea5@siemens.com>
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

On Mon, 2024-07-15 at 12:20 +0200, Jan Kiszka wrote:
> Thanks, applied to next. I just additionally removed the dead 3c59x
> config switching from gitlab-ci.

Good catch!

>=20
> Jan

