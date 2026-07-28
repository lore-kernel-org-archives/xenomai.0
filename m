Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA53B71AE
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245640; cv=pass; b=n31AwYSV9U0lYvypNdYejJqNA5QEgwWaGVRKUkZm5RqdX8nHRmm16PA+T340nCTYAPxzzuiv9bT5/ghg4HLfDDwHo9ldx70DAEbc5PXiFTxXjTkt2FxUE4yVr6AgP3tOzN4RhUCuL8WX0YQIIo8zqkMsQzcgD3SFXnE2rNZg+hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245640; c=relaxed/simple;
	bh=owKPDL6dQjBZGSd1cScVHs+SSrecAAzeX+z5sLtmJG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCOwHHX52ib4I7Bi+vWJYBtQlfF0v6mQzoxCRZzRODfAKCTNSwWae+YYvVRuJ5fj26/Hh9ltrQxEa6KSNBhYNpI4u3FJGBM5EI8QpyKqWP7W4WVUsutnMnKLjJcGvLrr19+R10Kx963341HMFPWRcddHgAXCQIZJdxJqIpugTW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com; spf=pass smtp.mailfrom=aerotech.com; dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b=ApmmOolv; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerotech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b="ApmmOolv"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso3192545e87.1
        for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 06:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785245635; cv=none;
        d=google.com; s=arc-20260327;
        b=arezxfA0/bItsyeekVVMsmWSVvechzjhEOar3w4bsy3BNPlgJSjzaYqu2OVsbsagI7
         GA7EsiLUCRyaDdr2zPnJuLH3IChQPaFtvGcu9kwKvxhmWvVUUGFjeVjKEESp0WCpbkxF
         ZjH06iD1gbh1JU/4TPLqIj3IqWpcGR7CdzUdGpvnORZt+gxaj2B4EcSlOneS5sXtjqH1
         +K4xJk5ikQCpGxdtO4JBkUpgU6QYGuADi40jhz/Glc/qXv1suj+HjDNLdzJ0RwaUPF7A
         lFKaMi/UHMHocrotmNBzQZvg1lsdrf21kGZh0Bdpr1h/gcNcWX/4aIOm/2kU70usWuTc
         VXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=owKPDL6dQjBZGSd1cScVHs+SSrecAAzeX+z5sLtmJG8=;
        fh=zmyoEc4rEtwXjEEppPJHE7SCPEZsUI7ZQAEV/Q9KTpI=;
        b=bN2exvs7Q5DqJqLsfUoNS0B9IsMJXqXf7axA0SClOBWQRSBjcPzG/wGAgd92FctPFL
         Kg1GglFaHWUHv4AfkutqxFiR3+QFbM1df+vTHT9RCMWgpxOprFeWTLOM4ZMK3V/GYN1Y
         2DauNNRvwQqLXPzxt9K4LKgTetuJUU2OHZvBg2UfHl6lLLxkMI6Rsw0MsXqItyi97swJ
         s4Ob94gtMphRuXTbgSxcsa9rRYu8Cpgem/TNKc8HObSl/bt/r7gr8ZvSEmpC6Jz6Hnqs
         Je/May4P+r/n0vZ9L3zrqtOoyMu+a0jzNc3OWGik2OrOBHBijp63gwt/7vcYuXc1IK8K
         mJxw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google; t=1785245635; x=1785850435; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owKPDL6dQjBZGSd1cScVHs+SSrecAAzeX+z5sLtmJG8=;
        b=ApmmOolvO+O0UDjyu7aVO/mXrOttbd/QKKF2sCmKdEW5oPqrtNOuvSw6uw9KBM/YBU
         e/HxM6zzzXYHuOB/+56BSwJCSnIj2uZsml2D0WbTUwU4UlB6tDtJBWJ/KnH8bvvtIVBn
         08YUnPU784OjLLU3Lk5L8gjglyXCILdNwNcRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245635; x=1785850435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owKPDL6dQjBZGSd1cScVHs+SSrecAAzeX+z5sLtmJG8=;
        b=ILGaoQgnPE2WF9IvdrTVtzMKOf4jyz9AKUXwR6qOrO7FXMcyS3oifTLvpZo84ODIQe
         OdpWRkJo5nQn1Nduo0/x18cIDOH+ZV+D6j8GNEUNaoldqExKX2GsyxA8Tz3Rbemzmssv
         BTmldeDaGPZfzKgwOMVmU8u0eRdAfHkTjOq42lU8tVbJtyWSgmok3Nrjfcas2WpDq0R+
         rzf74CfGPw9dHlQuXAQgBbDm4bj4tZzPO5TKwNAkST8xksoGGns7TgnJw++0jkypYxgU
         ZKDcxVL/KIxWVml7UczFAdtFIYsA7lRgZJmph5kFJE15MAUZ0kywTyblh0CqsHVzeFGv
         MVqw==
X-Forwarded-Encrypted: i=1; AHgh+Rqux4qQtlSlFP6jZuYDbnXwLgToU1tMzLhCk4wjvMpaJ2IMvIXxpHPOb7n3MGM2QwUg2/XiKX5X@lists.linux.dev
X-Gm-Message-State: AOJu0YxIsY9sIPZvLtGx4sObIwrW8diGs2firyke9NnfHEDGFBo4jG75
	JpF3QS97LCTNQ7lP3CeWVpc0QhEBjRgncmrw+E5ZBh2LaUS3ggneuET/l8u6uPzoR3IrrG4XehP
	+fZqbrc+TNifxAFywekQ3CkqWq86CovLTiMJ4O7iLb52Tck8Ftqvs3YYjVBP0PsqRnANg6Bq6fm
	+hofsdVaNfQQYqB2FGxXCrD1TKFaE8wRSFojWuawG7H9iYe/D2yTSXH6h2EqtHGL2cPaONbnRek
	g8DHhqN5PFsWLEHvQaWNtWxs3kmF9jy/oMi+63mcVynjBZu+I1aQQYW0b+/1PBfe2Lp+aSRP1kw
	oA==
X-Gm-Gg: AR+sD10+eK0f/Oq8wNw8mHf/Q7rhnpXEK9hN7wF7EkJsw8HlPQb9imD+4Rsq1iztoL3
	7MF4AGejapqzIK9kIjo5jWYEKp08LckA0Yr1Pl5+s8qID8qD4RUFF+6n8GhG/HSZOHIEwsct0Fd
	qgZuY0o+j9SKPmY6ljzzI0mHYg9ahuU9dZ5/G9uOEUv1vz/GuMJVbr2eqXps760kd25o/clxnzK
	ApShAOv86VLB+Jf3OrXv5Cz4NF1NoAZuA0IYBUD9n5bc65RtP+tBqbnFIQXB+G23iUFCdd7vg==
X-Received: by 2002:ac2:4f03:0:b0:5b1:5061:e5d2 with SMTP id
 2adb3069b0e04-5b2d0251476mr576026e87.30.1785245635331; Tue, 28 Jul 2026
 06:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
 <875x2gmuoo.fsf@xenomai.org> <CABE=YNs=T-x2iyDjOMcuDzkEOx6EQCUeX7ivGy15O01cZ8682w@mail.gmail.com>
 <87y0evvcug.fsf@xenomai.org>
In-Reply-To: <87y0evvcug.fsf@xenomai.org>
From: Bryan Smith <bsmith@aerotech.com>
Date: Tue, 28 Jul 2026 09:33:28 -0400
X-Gm-Features: AUfX_mzziSsh9EG5nP7UrbEssGo4rwnqoxMCtCqnZ_La_Ex5yAUgbLwx8Y4grFQ
Message-ID: <CABE=YNuwToOBR1gUUP1mYPtHQaNXWVKuWSxO9HJC22aAfqxBZQ@mail.gmail.com>
Subject: Re: Xenomai 4 Allocator Fragmentation Questions
To: Philippe Gerum <rpm@xenomai.org>
Cc: Kevin Strell <kstrell@aerotech.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: aerotech2,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

Philippe Gerum <rpm@xenomai.org> writes:

> Passing a NULL format should make the core pick a unique default name
> for this private element, e.g. evl_new_mutex(&heap.lock, NULL);

I didn't know about that capability, that's very useful. Thanks again.
