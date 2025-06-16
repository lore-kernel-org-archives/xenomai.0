Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637822BF012
	for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084998; cv=none; b=ZMlyd2f1jDM0NqNPoofY+QiopEu/8FNOQg4lXEGIZUQ4s/te5JG+7o9d9byLwQkDup4946+Hsk3Xz2OpijkWYnXLCCIQliY6kVF+TdMCkGYd6ZQeMd1pDH16EEdXNO2t2NfVBwIogkIiUkQ/SZgqSWzL3gIfPwGF/0DCXIfBv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084998; c=relaxed/simple;
	bh=k1iz+zrcXXgcsq+znGzeH4SR4S48kaw3dWwFg5jHIck=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=athfrAz4hBuYnrbQmOB+CqnjGNW2r67uVqTogntAsyJ6yLgqPksDe4rWguYz+9P1blkTi6uyTw/EDYomaW2NkIBDUa8tkFmqmp+dLtw0YLUNN4KEMdZYYCgMqkCny5gOmeJ/eCHKgpgH2+72SZSgBJGpm0NcbL7DXRMLFc4o9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=QNEWd5Hi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="QNEWd5Hi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so30363885e9.2
        for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1750084993; x=1750689793; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k1iz+zrcXXgcsq+znGzeH4SR4S48kaw3dWwFg5jHIck=;
        b=QNEWd5Hi4Ps/4yu7b6qRqmMGEjYFcj899x5/KMcAeTG6/2FHNEcpWA3rKw686Rkb43
         O5fQ1YLNUHFwTLKMJE6fGSvLCrn60JxecqwEAehiV3hfDSrhb5fYb7FoTDgHSzZ3VQa9
         9f7h18BPQzuJdnny+3kyEbsYQTQ4wn8TKSmn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084993; x=1750689793;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1iz+zrcXXgcsq+znGzeH4SR4S48kaw3dWwFg5jHIck=;
        b=CnrUQRurnNHBJfjddQ1BH2ddbMXCaDElPGNK8gTJiPmFDPZ7CSRX8qwcjwoYj4afiD
         pR9HIO9tTORYXvHHPmltFfVlcM4D55AYhKXfRYeXsIdm3gksABDZMeOE3ksVXmIRAdmq
         J4XyrPv5OP+5du2U/OlDv9efD3baLkj5ITUtJgdXBn59uO9kcmuFV/vNpg85UkF1J7sq
         mOxz0OAvMI1rwFXJJkLAoaRC+/opKmcmu1Kycm8iaqQQuzgII1jcvBSENk9bLOAD8g9H
         mCPFbAvjU+XlmkEpx1WJfGZltBNZc3WCT5M8b5UybHqWzeCRW+0pZkUvz9KqE9UuWKNq
         M6Kw==
X-Gm-Message-State: AOJu0Yxx9QOvYM/snFF6oRPPWOPT+Pe0BvJ0jDFpj+H6UL6B4aqw9b8r
	o0914XR6QoxOJdrW0g0Xs58O2V8ONdSjNOJG8Gfdj1dVYEeVOS/NZvgAfXPobkrEuMt12mmRTuW
	CuzB3sa+TYSEi7spZnQ7dmw0jnrhfKNHcKvpBHXgQXv3txwHLaAk4NRs=
X-Gm-Gg: ASbGncubbvcQfERjCJv9cTTpjQL/H5v7dqkwKXLBFIq1J8rLfNMDMI7ewK7+YQtoYgO
	4KL+sC+L7WaSbd7FfrVZUskV3aql2QBd2+s3xSVvOEvOS4rGQXlkLQV+I9qEy6OX22yU/IwUQaQ
	QfRWvHSjKtdhtnjcBseI6SzzcB2qSuye7gduOXslRVzOfkVw==
X-Google-Smtp-Source: AGHT+IGzZoKrtdUcg1ezw2Z3ylZZ6nj8UVS+n8VhrLvlCh1O+Az8QQ/pqMFf3G0E4ZREgAvSH3NyOkrKD4NZ8sJ8uZ4=
X-Received: by 2002:a05:600c:5025:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-4533cb5ddabmr97205305e9.31.1750084993361; Mon, 16 Jun 2025
 07:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>
Date: Mon, 16 Jun 2025 16:43:02 +0200
X-Gm-Features: AX0GCFtQq1IDcuTIJGuvh_jiGEsAbb1l0AacJ9EUr3LxlkOflaTHTILD6aj-d98
Message-ID: <CADjXCUf6kmGqzniuX-iAA8tRkvyDYsAtU9+4_wcMoNO=_QLa1A@mail.gmail.com>
Subject: [EVL_XENOMAI-4] Issue with tidbits oob-net-icmp
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99m trying to test the oob-net-icmp tidbit on a Raspberry Pi 4 runn=
ing
Linux EVL 6.14, using VLAN tagging exactly as described in the
documentation.

I have connected the Raspberry Pi 4 to the office network via
Ethernet, and my PC is also connected to the same network.
The VLAN device setup works fine, and running the program shows no
errors, it reports =E2=80=9Clistening to interface eth0.42=E2=80=9D.
However, when I try to ping the Pi=E2=80=99s VLAN IP from my PC, I get
=E2=80=9CDestination Host Unreachable=E2=80=9D, and nothing appears in the =
program=E2=80=99s
output.
I also tried connecting the PC directly to the Pi with an Ethernet
cable, but the result is the same.
Without the VLAN, I can connect and ping the Pi=E2=80=99s default IP addres=
s
without any problem for my everyday use.

Is there any kernel configuration I might have missed to make this
work properly or maybe it is related to my network configuration?

Thank you very much for your help.

Best regards,
Zoran Krivokuca
