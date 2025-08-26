Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933A2F60C1
	for <xenomai@lists.linux.dev>; Tue, 26 Aug 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191270; cv=none; b=R/sC3kev+S17dIxZL1FQepZ2L5K68kTvzzUI7aiICGufVHSDCuIH2K72teWKO4g3gR2J6eSfiKXRnKFm/IORKS8vyXnci2iOxMVvJUQcaS8fUIowAD5JtcAds7XUUJd9eZUvNuvMt+3Xv0q9csiyya6k80t/qciryNYfavtSK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191270; c=relaxed/simple;
	bh=5YpQBh5NeL1CYpRRXi47IaPM+11UyDAIyRLd3EM5SCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSGCujCazfRseZuHVWPHAndAtUnLh+AjxRQAGZWsQKOKj7j0wbPcgDKZXwPWrIi/Xs06CnGZgGtd36m9RHYAg0QSpBz6CQbZzQd73QpAzl5gB60iRC3KOXaEoYqKhR8iuaU3/H5qLxEOhxZlIb4hlaX/edDkY3vXNTE5fTWPv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atZEu66A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atZEu66A"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so27413915e9.0
        for <xenomai@lists.linux.dev>; Mon, 25 Aug 2025 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756191267; x=1756796067; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5JdTzUQC0mFTy4vO6f23Fd8vwdwVENhNWq8HHK1l58=;
        b=atZEu66A8efqssjZgnLtQVsYaLN9T/2St/H0dvQ9dqDV5zIJVhMEY0Qj6ibCsXPWn3
         ILuwiOPSdMXyRg4pXo9+WW+xc2p1sVxIA+gx+61ubP87SF1phbS6NHQ7xLtL0molfGyH
         48sACOzrD2fbQH2BAnXLRUjvEmoiAiUdp6Pr3FYtt6ZWwQ8cpXkvbGwK6K5QvZUy3X/r
         kBXXIZsdUV/igdsFq18arLswngJNLq6qQfWMfslzYaKRRWjjIzKw3vLZtaZNLkQkVmDh
         wDMQFXuBoG/kBxoCMboj0fivS+CwZ7Xsi0M1JwX+t6XqXMOnLMZc5iKGruq2JMQodjFl
         8rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191267; x=1756796067;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5JdTzUQC0mFTy4vO6f23Fd8vwdwVENhNWq8HHK1l58=;
        b=cnu44dUVCbQm9bXXV5AiyTNmcrrzs6AYpNRWn3H+KdNCOqoQ5pi01VpkGO0Uug2uh2
         xIx02ZPfkw8hfyDdpLvGnyX07R8yjjNflM0w2SaLEFThnRm2l+O2zOPGSXjB9Ch15MS2
         ZXB1HCpun4bmH9+ysQmYvV7++5rqt4bPg1SimgTz4kQ+zn/PxecARObM6hLEeJqyqBow
         y26QGhXQl95ibrvwwB5JmNSUx9mhnNjLo3RO+vp6UcO+nIvknUZ9RvQKeJt30PUdLupt
         /D29khxZmHEAYHHLkvFSk4uCqSu6ufJAlLDhdE/Z+RKK0S+qYG472AiBvW9AIgxWv/5I
         VhbA==
X-Gm-Message-State: AOJu0YxQxdEhuMXGGiMANLm3vdkRC6iJWufEGw6UMnIjvbQiXe+rcK0S
	23DZTuCbohigy4cpXd2B1cYGtndru6tSnqEnLJD/eEHvbf0klZgw3wkb6gzxnw==
X-Gm-Gg: ASbGncundMPGBYyv5eXcz7mMGyMFxzceYMu/zGzQ51AzK0gwkKODQ+rkrkyxX1iJcLN
	/wsNzRjjEHrbUnBJQ3/4XjtEtWbWEm94HhY89QTT5/vdtcEyD0y4pdmcgxaf4rUEYcw2L1Fz14/
	qbgUXCTEF6w6ks/wXeC25mOURcueWOOqletNjGeFskYgQr3yVlm9CfPM0Rof1XboMx3z794DaK6
	uU/lePVbixd+7FM4wBeS5r0LYe8kCYXCBgaO10YcSyuJYif95WO/7yjO5Ly0JpErungq/dyJY3P
	SdMlFPnw5piCVZwmH+ZbQl6HK6owb+aUGNutB9Ct4G3Rq2/7EzCuTTYKN4I44ZRCjcFtpj4geT6
	cUWRej4vuoMw=
X-Google-Smtp-Source: AGHT+IEG68aOsPc78iUSnG4J/ujh3usZ/ua18A2bdnYmymxlXm459Rs1Mvu9MfiHSx1WWzQVJuIp0g==
X-Received: by 2002:a05:600c:154c:b0:45b:6269:d25b with SMTP id 5b1f17b1804b1-45b67440939mr7524545e9.37.1756191266780;
        Mon, 25 Aug 2025 23:54:26 -0700 (PDT)
Received: from bogeyman ([90.121.115.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57498d9csm134248715e9.22.2025.08.25.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:54:26 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Documentation port to relearn
In-Reply-To: <6103a8831efc075fea7ddc7d7cea574f411a7795.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Mon, 25 Aug 2025 10:52:47 +0200")
References: <6103a8831efc075fea7ddc7d7cea574f411a7795.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Tue, 26 Aug 2025 08:54:21 +0200
Message-ID: <87h5xumv36.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> Hi,
>
> Browsing the Xenomai4 documentation I was annoyed by the sidebar loosing its
> scrolling position at each page change. It looks like it is an issue with the
> hugo learn theme. In a commit I saw learn is reaching its end of life, and there
> is a plan to use relearn instead. I'm willing to do the port if it is still the
> plan.
>
> I have started the work here:
> <https://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1>
>
> I think at least the first commit is already useful, as it fixes a bunch of
> broken links.
>
> Please let me know if the port to relearn is still wanted.

Oops, it's on its way on my end actually, v3.xenomai.org is next, almost
done. Basically, only the landing page is missing.

-- 
Philippe.
