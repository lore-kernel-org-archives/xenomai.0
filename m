Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E861F4615
	for <xenomai@lists.linux.dev>; Sat, 15 Nov 2025 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763190586; cv=none; b=YZrF7DOvfsj8936gn8tH7FsmtlmGKhLLZnYYK810k4r4VIhP6S0uECvoVeKNsqsmIVokR3EvoJAmogpK6oEsVibodrhY1lv0wbwSKO1RLY8OTF1L414Roq577MmvyQQzdTyrkvPriOHthP9aFxnE3FUL6lbtI/w1wT9Qmg7BbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763190586; c=relaxed/simple;
	bh=vb6qMqFbCpaWK3RZtxlZZm6RmLbfvcTmnOW6liqqMT8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JZQcL+59RdXC4G21FsK17j5eMpVGUwVnSk9sRftFuhLUi4vfiX4e1BCb0Eq8JefQFn0qapjNrYZOBT7W7A+XlGYUG7NnZ0CIvmRbnbhe82OMKQx1BQr8O+a5t47rxCeBmDPy80Z1gPWF+UWlLLvYkWl4ccaZFbUfnSJGghpERIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSjewZqI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSjewZqI"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so4704320a12.3
        for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763190583; x=1763795383; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3jaIsKilHuvjeTctmnHu8SW0xcpGWt1llmy5OkhmG4=;
        b=aSjewZqIdLGTU22nvnLcIf3iJ1ENim2jEdKiR/VRciwMtzJfi9p9S3tW6cnkBQzOfs
         EQLIHAaSpSdxoUn5t4KPQrWkH0HWtFqJPF/YCDZB98V/z5TWU7uiFztLc45I2QJPZanX
         UwsKdknykww12VKsy9acW3TJl/xqe7dkQKokS2lAHBWsLOoidGkkVUCZ8So891h7clNI
         I4f6D1Wr+V428aZnko0URLKESB6HufMBJHmUVElLKZ6uPtvhSet4+BXnHDasSG/Jr7o3
         /rx1oxfcRPfLoKGPmlvQNQ+QtNXyrdxBhXhytJfMZXO3RlUlB0qa9C5bEa7reIes1KqU
         OcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763190583; x=1763795383;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3jaIsKilHuvjeTctmnHu8SW0xcpGWt1llmy5OkhmG4=;
        b=j0LFJYHPm5W9JvAesbqj0uuyrWTOlWc01kYOj3aVcJsQiVKcmT4armQSlhx4yzLw0J
         d74bEIZaKZLim1OJ2rmCWdydLX0kZwp7O9nyoosDrMQuoDTk6AR0MH4Y/4tfG3hQtbVc
         1HA39nqY2GnVhYH2BU4Ixv+te2R74ySgkH+Ec6cqm9xbtRHBWEveLHgf7Tu23j49qoi+
         LwbIUErfglVPBhBb1ABSogIAoaZa10vkCZJrpP/oXnTATPhUXWm4FZyAM0cYgRAKyoqc
         KRHRlVlb2QNZQXc15vkWC8kIDkxveCFGbA6T+mnoWLXKl3jAQifrvKuMdITWEaDVZi31
         CrFQ==
X-Gm-Message-State: AOJu0YxFnKfxq0OVsOe/EH251e9pJK6cUo2l0Wy4uFZqVXI7Z0Q5sPB2
	UE70vzqHRIar/NpYhKU550DUmaPaiNAEdmk+HVLTeGJVT1CAqJH4a04TurrG3XbuPxb9vlbKzrU
	xAoZqH8N5YOMZzr309W2YiS2CQlmYqsWWx47x
X-Gm-Gg: ASbGncs/XULAj4VG6zLryoxl+ezQ5mImO5b/32RgL9obZgn2Is7vLyMsFwrUVO9C1D8
	F8ZVj7MECiHhbMnYUbd4pMDVsxPIZLl1J06MuLmxHax/vSURStwQmWLKHfJCvywXi4iM7MTtcOV
	+ovCHcxa11+5/2or16RscTdaVdb67266maPL2s9LjvF8viPdp13j79zERRPB9cTXD6aJjX/SNW6
	F+t3qtDXhgRSzmzBN9dgSVTZK7iQ0zKc3zjnV38VIRWWAk4OzADY4Zkcg5qkHA=
X-Google-Smtp-Source: AGHT+IHrmHTK67eBuNqkTaWjM4rgvdn1Ld+KzVtMT/jL+KBYgD3lxgWXqs+mEPMmozje8begevBTuc61x2L66p54Zdo=
X-Received: by 2002:a17:907:3e21:b0:b72:b6ae:266 with SMTP id
 a640c23a62f3a-b736787e1a0mr637918466b.10.1763190582702; Fri, 14 Nov 2025
 23:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 14 Nov 2025 23:09:31 -0800
X-Gm-Features: AWmQ_blHqs2RSkbEz9I8OO0MnEIobhMaPpd5_FfiHCur2OciIKHqMoFSKsiuNec
Message-ID: <CA+K1mPGw0T0tOz9kYb0qmJaF0RLoKfDLJCbJ0Kx5yzvy=2icUw@mail.gmail.com>
Subject: rt_igb Ethernet support multiple devices
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Can anyone verify that the rt_igb module will handle multiple NICs
simultaneously?  My motherboard already has one xenomai rt_igb
interface which works fine. Now I want to add an i210 NIC to the M.2.
slot as an additional rt_igb network interface (with a different IPv4
network address). Has this been tested?

thanks,
C Smith
