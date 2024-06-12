Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D531CABD
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205434; cv=none; b=Zd045URpl4jRjqKiC0Vlm5WunPTRMYiumquJhlsLQRKiVtVX6VTNvIztyZ+05Op1q4eqDZFWN2+dwgbAWaWwxIZ4hPF19gd2HzAZvJdeMQNVDa94vyWND6xjHZVLxdByCXr2RQXnTlvWWmLDzJHhociT06wyRBASN4r6Bcq9UCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205434; c=relaxed/simple;
	bh=whnYu/lKPW38R/fPPyTV/EbEaQZaQOpizSW8E+amyuo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=sKaCYBLWwAWHOVtOxeIGI13y6BIVDy1ULorZFadb6LoMfmW1guuFEuqYE7cHeHcmQruGevIj/+jY8rFxymSrpxgD5+8B4ARx1QuFbiECJmaG7cHxXKH2HnhCzk7flIQ3SEfjL1E+9/6NOLi134simKJMrLuPnkLXfHipYE4UEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso7824895e9.3
        for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 08:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205431; x=1718810231;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whnYu/lKPW38R/fPPyTV/EbEaQZaQOpizSW8E+amyuo=;
        b=QwkQqUXqZj8hY7AyATBm+mwutiI/OfTg+c83StgO9h3OQ1EAkRBmc/B5VGyCvjpRRY
         m1VC5b0mBdUVnOTinrIWLhTMgHyFWMoQoZMQlVAydlwLe6DjX8TrjCFPfdy+kyzd/B3i
         Tq5eTM3GplmY6EWTrtP+wf4d0fmjpda38GS/bY3HxKP43ivbTYBlOYyTnctSWSTFffBx
         YlnpXlwXg/ihDJpgv+evpSeLxG6ycavx/JQRuTu6OlrGMYZOjlajnkZd9/1P+YQRZsrk
         RFveZ7ThN8kr2q5Y++SS6zx3J6DuYo5iKp1sGx9FK392MFKqujqpTrPVLaD7B3dhpWfL
         1q/g==
X-Forwarded-Encrypted: i=1; AJvYcCUL4WXkGenAgYcMsu2slSqM/BfhZx91HDPnPzT8Uchi9BJBM5exHoI//ew8AbOv0OcOVyS/JfY5cAUI61T1irFD56uN98YtFw==
X-Gm-Message-State: AOJu0Yzu8WktJlmpea8Z2DrhzA97lGxg7PeOIvmfxWnWdNHOmebhcQl5
	nm4qGwsTpZ0nxivb/yp3uoQ1LzN+HYP+WyipoEw4aj2OACS8f2A4mhiwsTYB
X-Google-Smtp-Source: AGHT+IEdRHWAAW4CdWUp3oSyZj9ou40pH5eAaUHaLEv2W6vXS1+Q0jEujkZ3v56andWh0SXoYea1vA==
X-Received: by 2002:a05:600c:1e14:b0:422:7eca:db41 with SMTP id 5b1f17b1804b1-422861aeda1mr19687205e9.2.1718205430685;
        Wed, 12 Jun 2024 08:17:10 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75c4sm30029495e9.5.2024.06.12.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:17:10 -0700 (PDT)
References: <CAFLxGvzhmZEL4+22UjkPD34g9AqMfdA4xUavug5itv_1GR=dPA@mail.gmail.com>
 <1158-6669b880-17-2e725200@6131903>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, "Chen, Hongzhan"
 <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Porting RT net driver to dovetail
Date: Wed, 12 Jun 2024 17:09:45 +0200
In-reply-to: <1158-6669b880-17-2e725200@6131903>
Message-ID: <871q52ry16.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Well, I'm not sure but last time I checked, RTNET would not be part of xe=
nomai 4 IIRC. So I guess EVL is the way to go.
>

Correct, this is the one providing a real-time net stack based on the
dovetail net services (which RTnet does not use). This work is ongoing
(see the wip/net branch of the linux-evl tree). ETA: mid-july for a
complete UDP stack. ATM, we only have a real-time capable raw socket
interface.

--=20
Philippe.
