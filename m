Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20465823CE
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217577; cv=none; b=kIzyVHX+39kK7q1FZoO5E/+W7Mcnpg9DjeKoELtxHDHkyrjGEaavbzjtl7dj66uf2n1BqpeSgMhO/qMjQCp023aWSGhWl4gMdIoNL/K7vLaF77gBz/qnIhrMvK8dBYx6IgUqZRzaZ86kvBHjoDtzuIXrt6Mcue0ZiFSSx7vxMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217577; c=relaxed/simple;
	bh=DFE7aQV5dcARO8AfFF6njHGNMBXiUvreYua8LiBvpVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlRFfb5e3cBf8nIB8QRYJ4RYbSnksqGH5oaulHgwDlF64uQAVZ3chTBT3TPfadqWCtN2ZpzgOe5wxQpBwX337kZE4GLV8a39mUNa4WSwBZfGe8rrWGDOSN/Q3UX5KEVEK+Gq/+zfApauQp/k9U9vcu3dEqktLZAMb+PMfy6PbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKKSVVDC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKKSVVDC"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2514391a12.2
        for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217575; x=1713822375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnLGxNot3dtwBnGAJzHyRAeccFxq7BQd/EZfS+KUIak=;
        b=AKKSVVDC+xdALfQCPEUiLGG4e3QahQB33HZfEmc+Ycoye1glegSUZRqLebs09b768D
         w/rgHLQ2KykoQU5K1TkdKrZD0PKVJOujRy72nUWmD6ELCcquqMOu6JkEbKg8/uIr7bD4
         VREmyg8EKIz50KonMURP41qY8eY/b3mBiyDQKTO6M6OA+6PIJkhrZBWthBskvGfkkgas
         t3CUfedaAtFD9bQXXekj+76QwZMA2uVQE9cnIC18+KfvsoLMx6d+2R0FL1ZH69h1sS1m
         iYMD3dxiXUDMzErfdH7Vs4xB4PhGekOKQQuFzqBC61UzGIe5g7jF0HoyIYIDr9sZF9ym
         mBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217575; x=1713822375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnLGxNot3dtwBnGAJzHyRAeccFxq7BQd/EZfS+KUIak=;
        b=mdWlZhcD1NCJT+K+BYBmCVGMuKWQ0zJS/FXxJXagE92axoI+RfgFs4LFv2/NTj4RYl
         dnKP4azr2Xv5XO0khEJ+SOSjIFtf0DmGA/wCWRRz7XCbqlrNUOjdjbrKZllt7McrdS6h
         ZMXaGuKImD32jDenfci5FvxVP505YNP24YdltDXvhgbnngyBI/rTQlo3EZhkVVROuPGq
         Laa3vS7mL3KqRZ8NueFGHDzYiVuV5Gl6G+8Zk+ZOhJdHs6R+wNFaZ4xunDODevpFBJOn
         /0GFqj0jPZD1/fOUzlrhOlnBwnAxl5JTwWIe1FsYOnITt5PQd34M2/5cYlsMa53AjwYh
         btbQ==
X-Gm-Message-State: AOJu0Yzzr6Mt7+Bi8W8Ei0SNVdVPbdOsk0asZJgdyKe5SfWly2o0dsiI
	UEbqBbBY9rcVSy8b3O3Qkdv8HbtAoocH221osdAKaFtVlyWreCrffCh2+DYAn5W2O99cOIaqVvr
	dq1kcOOm8hcjvL1pVGuo3Fz7tWew=
X-Google-Smtp-Source: AGHT+IGRg7RYobFDuO8bg7g9UdXkJHH1APOp3sGzVTxuRUWrt1tXZnL6AIu2XT20gowVE27NsHaEaU0nWDtDCsH6eSU=
X-Received: by 2002:a17:90a:ac13:b0:2a6:e639:ee6d with SMTP id
 o19-20020a17090aac1300b002a6e639ee6dmr8487075pjq.39.1713217575293; Mon, 15
 Apr 2024 14:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
 <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998A90B5CD2F8E507A20E9F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74998A90B5CD2F8E507A20E9F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 15 Apr 2024 23:46:02 +0200
Message-ID: <CAFLxGvzU6c9fz4DAATcq19iLK+B5o6Sjtovacfu1ikr935-1Uw@mail.gmail.com>
Subject: Re: i915 GPU woes
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Hongzhan Chen,

On Mon, Apr 15, 2024 at 6:38=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@intel=
.com> wrote:
> >Would you like to try to lock GPU frequency to minimum?
> >        frequency=3D200
> >        echo $frequency > /sys/class/drm/card0/gt_boost_freq_mhz
> >        echo $frequency > /sys/class/drm/card0/gt_max_freq_mhz
> >        echo $frequency > /sys/class/drm/card0/gt_min_freq_mhz
> >        echo $frequency > /sys/class/drm/card0/gt_idle_freq_mhz

My system does not have gt_idle_freq_mhz, but I set all others to 200.
Sadly, the situation did not improve.

> In addition, you may like to try to decrease DVMT Pre-Allocated mem confi=
guration for graphics in BIOS  to a relatively small size like 64M concurre=
ntly.

My BIOS has no such setting. Looks I have to talk to the vendor.

What do you think about the i915 module parameters I have configured?
