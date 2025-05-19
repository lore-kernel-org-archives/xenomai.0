Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0772AEE9
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680908; cv=none; b=RApjZEutlbl8X/iyyeMeBxxzXfuWSNLeK3HW6bdTYdvcXD7tO1me0qD+wCEzop0nsQTCx7XX9m0aUBPmVwzcGR7M59hGPW6UmTzNWk8ulFFlcew/g14dovWwcw6qSB2HjyMunu5+IcaYnfwOuBAe7RU5+CQVXT8SUkVKgHhFb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680908; c=relaxed/simple;
	bh=Zs6aVKoy7E3OtHiTaIWg6dE2SDIwE8hbEvJXf+Iar28=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KyiEhuHnw+SItOzJKYTtUIVQuHVzxpdPVdrsORzJcEV1WVx3/ya8zSfPBT/bOsDymymDbN+Qzx/hqbhCDFOUB94VIYutFLf2PEAyc2ZH1R7cmUkFZKtuhRXj1zgyvbO2B4qrQGoEZm+AI/jBIoPsRY32kPOMchT5M9t/f+aESoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSrbtvsv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSrbtvsv"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fcfc85f1f5so1392191b6e.2
        for <xenomai@lists.linux.dev>; Mon, 19 May 2025 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747680906; x=1748285706; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zs6aVKoy7E3OtHiTaIWg6dE2SDIwE8hbEvJXf+Iar28=;
        b=PSrbtvsv+zp2WuW0cSonDHkQjpn3PA4jZ5mAzRCbB1jFOao1h36nfPV1SMI29AtcKm
         369oW962CPkNE+QWgEky37QZM+GeRv9p27HWv/g6axWfkbURiiGS8/qQZzNjyeH/QVSH
         ak7w16KAo2hchBUTtmoqIqIgfpKvm+LUrxgE4E7LxYUT75DT8QcB4oY8EPkVSYEBbGsK
         mQhQGC4xJQSip0D/5tpRDxo79vvMGQ2uC8cI/1hbSxgn919aTa96TE8cWYXStmyQdTUc
         v22wti+2DMYNrQkmSeL7VKrlovpgGqAQF2PuESj7SxnAwDPcFhYU+lPBf0A3g1bi6J0a
         OnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747680906; x=1748285706;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs6aVKoy7E3OtHiTaIWg6dE2SDIwE8hbEvJXf+Iar28=;
        b=fMuJT8cx4Dd8g51O44AnpYi2mxS9QAYCizi8dA2PoA4VQoRJ3CewNiCSgk0TN5WqpC
         Di/hvrCmSdMW6BSY+jU1lDTapfNi3HirHaSKmHFImDoKoU5OgSy2touPrC12vg8Q8+N0
         zdnhwULiOqvM7QYgYlQ1AQ8vW9oFSBgL/YjhwderRF6EZ6WoTPwndpwZFU0f1s5C4aMH
         xO+2WD9ZXbfaykSgdusUZUkmPjUk0aspORLMYzXs1dTCtMrXbVqDv+8wO+GLFFF7X/zh
         6qy01N1WP4bNl30+R1x8566fz2YKxtAYA9p8i07CBXwVCTRRcHxKUby1U0GT06RWado/
         frzg==
X-Gm-Message-State: AOJu0Yy1emeeM4JGHBLCYQZf0R9OD9s3mJeM3zQByAhuxn1d0lBtYWqq
	Sc3HB4kxD58R9Z1Ej7LWzRU1pZYb0WzdTPQepzc5k4AZhXVbeG7nJlNE7BTx38embqGcfG0wAp6
	3QRWmJECbIiT6hm+vdUJOkTF0QwOBKExojv8L+4hMKurR
X-Gm-Gg: ASbGnctpG9JMHoJuEaWSnbQSuvSqPwQ1roh8qAs1XbXiJsKvmzJE5UEkKe94nY1WPDy
	mq3ZmGDk/RouPLOg5qlU7T3q4h1smLNWPepotRx0DE2Qg5Y7QCKZApDdYEFLP4SjMSSrL7j6J7q
	YCDMwm/hkUotLBspguE4A1jGySupU5FvgSWNMfkSxP1CtZ
X-Google-Smtp-Source: AGHT+IGjkKt0512GbcW+iQGocJ6M0cQoXtrh7Io21BioFOjnl5aMyOELMWiXOODXOzxWhvgsxZ+j5D6IoSI4G3kaYR4=
X-Received: by 2002:a05:6808:338a:b0:3fe:aeaf:316d with SMTP id
 5614622812f47-404da7719cbmr8671781b6e.20.1747680905992; Mon, 19 May 2025
 11:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Tom <t93252352@gmail.com>
Date: Mon, 19 May 2025 14:54:57 -0400
X-Gm-Features: AX0GCFtoPPh_mCMEYkwHaxgryWEQgmjqec2rWnensYGsiMMw5LqUiPFI8-PtOoA
Message-ID: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
Subject: Xenomai Installation Inquiry
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Xenomai Project Team,

I am part of a research team currently evaluating Xenomai 3 for hard
real-time control on our system. Could you please provide an estimate
of the typical storage space required for installing Xenomai 3?

Additionally, if the installation has a relatively large footprint,
are there any recommended alternatives that offer comparable hard
real-time capabilities but with a smaller storage requirement?

Thank you for your time and assistance.
