Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405C12A157
	for <xenomai@lists.linux.dev>; Tue,  6 Feb 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206997; cv=none; b=md+Ou48FEBKiDcVQ6T81kLS8ZfsD3OBPRl8zOUYp/9EQ4eSrcmFa+ySeFncO4FsS9EYMspkTgssuUzAlzY840Tp9Km4tSUMjWsN+fdP7Y2zw5OT0pBH8jklNoWAsoGJlaXyVtfabBuK9gp4SAFSbNe1+ZUQutYd0YcC6eZa+anM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206997; c=relaxed/simple;
	bh=U6IHXpRPyakKXaw46OMM5rHTp40dZ7oqL0buIV5ytHg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ApYZ/Zy7fTF2IyNHGucIP3RW3Kftv3UIIEWGITOJRNIFBjhbVA4hFB8+SgqgKjgMg57eLSITK/+IHMB15CE7E6W1w51Va2m3Q8yY0joD1gYCA3hAQB0YxrX0290Y6XD//T6Khx5lh6I3N+JKbRyEB6fH0MAL5Fi8uWQa2l+5UzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3JX2/vy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3JX2/vy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0b0853818so2113171fa.0
        for <xenomai@lists.linux.dev>; Tue, 06 Feb 2024 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707206993; x=1707811793; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6IHXpRPyakKXaw46OMM5rHTp40dZ7oqL0buIV5ytHg=;
        b=c3JX2/vyUt1HWfhbsjiEPyJPjE5bztRd6EusEar4F3/hfQ0t/6pyrcaB31luCODc1n
         KWTz/BSlZzWxFCtXpHyEBQwBmu3yssmHiO9IXm78BiKw0ZPI8/4n24OCFle1MPSuc16/
         GAZeWTPrJ6lkmMfDbiNreYt9U8INxXT8avR2Wiw2KADfHdzRtTHUrkHXNsAt/kEKdjfP
         0nBZMENuA2SeJNBbdkYSLNPWnP/UEjB/MGSs9pToHnOuKFFej0vTiwfRtrpcOcsGtcr0
         ornFbCBDhty8g5C5nOO/72gJ4dN5kAWCDIXDv44uebiN/LZxHNA0HDI7udsZa59MAH4v
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707206993; x=1707811793;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6IHXpRPyakKXaw46OMM5rHTp40dZ7oqL0buIV5ytHg=;
        b=CYJ1Naj40YR9LnlPHYTfVW9xxKvFT7/rUN5hHiJTRFjl/GgZwazINQZPrKM8BE/mLX
         HpQTMVGibxWQSyTN+6VA0J+hrcC3JZ32TqafTvngjQsd8975MiDNpIb2NqoBvS8R98nu
         AQFVway8px9Bfo5ohB4dDwcFI6LTcnBCBCh3gJv2cI7mVJjVnXQzuOnXvyOaZPPnKmDR
         OS2xmU7KdWqLZneov4T6kqroRgqXi9E7TDvSN2WLzMJfyKA/8AUouBEdXspVP/zBAigb
         tTXcCssZ7CyI/GmtppFqtWKHoMH17Ugu+unFVOksO2kXRXh3qTjzufVV/penTvGyvhaE
         13Dg==
X-Gm-Message-State: AOJu0Yw9kyRd1TjnBUKPlruIWK61hWd7M1LH+ZedGb1fHjjMw6uz6QcX
	H1diCNe/sFBGLoFu5CU9TuPiZ0QEg9YquhoGdX8uga9pzDXs3yTQrVtKZySHqtFPXLAg5H2qMtX
	QDDWEMLPR8hUnx9m2coNLEskGkRYCk83aXPpi6fQ=
X-Google-Smtp-Source: AGHT+IFNOKS0ae01OFGVuKIsXcjRhPrH4kiuVEjlpazAZBCPkZusSuwNpOUOkpYcNu5TpqmIwPwZNb3Hl1WkmLiEoxY=
X-Received: by 2002:a2e:bc28:0:b0:2d0:a258:3003 with SMTP id
 b40-20020a2ebc28000000b002d0a2583003mr1769610ljf.2.1707206993411; Tue, 06 Feb
 2024 00:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: John Ho <johnho26@gmail.com>
Date: Tue, 6 Feb 2024 09:09:42 +0100
Message-ID: <CAMjL99+fdd2Tvwv1Av3BxPycAk-j+1+1+7PTW2ETQUTzid+qeA@mail.gmail.com>
Subject: Query and Documentation Contribution for CPU Affinity in Xenomai 4
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

I wish to ask if cpu affinity is still a thing in Xenomai 4?
and If it is still valid can i add some documentation to this feature?

Best regards,
John
