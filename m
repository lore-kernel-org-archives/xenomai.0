Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C2BE6C
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431353; cv=none; b=hpD2RUI0d5coQ/QPZBhEyAcOoU1nm8W1tl7I414N7TM4zJgTSP9gIovz/9E8J1uTK9Y8yJG3ikz7gZrIuM+ZjIYKzrJByW0GhE4NMcawd0UC412PJ6HD+9we4PDiXavBrqfvFajkNFD3kQ3k+FaC2nDp8uidh6J3xD+pBzKTHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431353; c=relaxed/simple;
	bh=GEcuYf2oAzSnQEV0aL0zneWtDo4X0vubGg9fBhWUxIU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tz48rLfa+DeR3/47LTKq99IYE9XN05fG/XJ7pk5xNHxqel2cSg3xyEB2UgQ49Lwzfv6Z9UfC/5Rkm2ZqBPX64iFp94EXhl8gSDdOVhIXY1CqiE6CD/itwWUS+tiWbjsIA2wyxCIs0X2AX7KjXcMk0yevMEBie+WUn/UmScjMcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgTFTgsU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgTFTgsU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c8e422c40cso594474a91.2
        for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431351; x=1720036151; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NalmPhG19HIVPvRsD1YUCOz5copQ15Yb8ZEDxjxbI7c=;
        b=MgTFTgsU/ABdiOo/MjBKq8qyJ/Dr1Is3CBI3YPR8Jn4RaOQ9BZ6JP7KKBUmJUXeMqc
         1nD/MQjUkKBnFEwcUUNYgFGoEqcrEGNfLAuy9Wljte0ZWmuC8cqPbK+N2/9Qij3vtM5T
         oeA28UGw1y8/fKJegpOVqvC2dez56L8zfrNYvZRxfGVj/HxYnYyiSqXSNXvzVEhVHwoj
         +F8bNwjk+TlODv7bz76OqVG+4DxHYzyd7tJl5zPh4ke1aNctvM0ZB33DdKqMPjdeTEIw
         C28/JnYIA3drdEEVZDkVMe0ltg5byJiQ3f+qiKTt/yoZtUzBP2WdHy7lJ4aRLPHcMJVG
         qDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431351; x=1720036151;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NalmPhG19HIVPvRsD1YUCOz5copQ15Yb8ZEDxjxbI7c=;
        b=q7sg25QomLJCzibuoKBQQLhN8To6Iw7zrVkYOfS8XMbU4r0tiiqyXfJG/ldJW2UDiP
         XzarYQ/dZ3p4ETw1HIgSaBBQVlbc4fnixAyF1D4omKONDFMb3Ugp+nbv+7SMwR4mLG8N
         jdeSx0siicKfgwYX47qtNcZripy0l0G0GXpM+dNC+gTj6smf7eUjL+22uOwRf4eUnXEt
         cub/E4tsFIXdI4gvp4xLoL3XL6ImhElZxbqFvK4aDH546FEm1Vw8clP15dB73D8Dv5yq
         X5WQ2R5kq0OceMXoxQr53RkTLgjSw+PHj23q3d77spiPeaNGRQP4PezUaiispNZ9EmQq
         91Pw==
X-Gm-Message-State: AOJu0YzaI1LY2X/fMGI7pt35yf2Vr3KmFc6SuzAJzuvW6+HNxGuRmxKg
	gz6cpDzUVDCTDMJSa9HUaM2o9Ntv7wP9xaRmBnzhWzbjncZ9wM3Hu19bV5Qi6FqG0OvLFr5eJUc
	/Tn2B98cceZQwy6o/Ycqzm+EqaGACgZBU
X-Google-Smtp-Source: AGHT+IE90dqb5bJAEA2MDmQrXqpKZsz3ZGiqDcGSsbiH6HTnIer8wxdDzAg/fbuXDwIxUlnu5nVuCnSlYGpvf3YdGgY=
X-Received: by 2002:a17:90b:1896:b0:2c8:1cc0:49f6 with SMTP id
 98e67ed59e1d1-2c8504c8242mr11546323a91.6.1719431351238; Wed, 26 Jun 2024
 12:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 26 Jun 2024 21:48:58 +0200
Message-ID: <CAFLxGvy74--ghqXA9dAdnw40UDr6sT6T8NY5dv95Kg6F-uav_w@mail.gmail.com>
Subject: cleanup stage for .gitlab-ci.yml?
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi!

It is possible to have a cleanup stage in Xenomai's .gitlab-ci.yml file?
I'd love to run something like that:
- pushd ${KDIR}
- make clean
- /path/to/xenomai/scripts/prepare-kernel.sh --reverse
- git status --short | grep -q . && exit 1

...to make sure that both make clean prepare-kernel.sh --reverse
actually clean up the kernel tree.

-- 
Thanks,
//richard
