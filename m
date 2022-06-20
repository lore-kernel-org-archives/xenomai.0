Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3A3205
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 18:11:15 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 6D6D9240005
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 18:11:13 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 48055AC0FCE
	for <xenomai@xenomai.org>; Mon, 20 Jun 2022 18:11:12 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id o43so16996118qvo.4
        for <xenomai@xenomai.org>; Mon, 20 Jun 2022 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=1YTy0Pk3xhNtNbw7x7VDPp/UZAFzaBdpd2kDT2wftQ0=;
        b=J6qF8eovVuzeAGwG2P6ZZoMlw03Js+xu9Hnq1wjPssFuJbpmVazNjGDLgiNUZ6MUVC
         Dp2v/J/bRaWMeu8y47kShyf9QaP2ZV2XIp6oVdwtKgLaIT8hpZZQW4Ad/eo8tsmFN4pX
         B0D99s5N7uTlQbuQQXB5sDk+7lCjSNE4dKOa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=1YTy0Pk3xhNtNbw7x7VDPp/UZAFzaBdpd2kDT2wftQ0=;
        b=xma1vGzN0bqGBIsKIRKCP+yLjA51dg4pCjs9UxAijJ7lS6vHzhqyXE5uSGHL9ytY5g
         k97SrrJ6q/j32ksqtx0k5pp0lJaydOuYSvNEH8MwFZDens/cdDCUTIIjvXcR9NES2+VO
         hj1wVRFFNj5i5lr/Q/tuVuRdnybNSsGxSm4fIENkRuMmBwxJa4JvEcJPV0M+bRzIhJny
         EqotyOWmrHEcUA6Dd174SoaGY4X5ihA7QZxxi60y/QgpxjP26tH//HfRN1xrl5TniJoe
         nEcNVJlUCpZOD40Tb5Tpxwz/lBTA2hGbEGw+Igwq0k2r3mbiKbKAO1a8DRjBjx3jUcnc
         XWXg==
X-Gm-Message-State: AJIora9YcizPGbmZdyBSnmNeuOeS84HQ2immsTY7qDOcOhKzQNcoIsAp
	r+5MuC0CFaWdunGzK3tI+dhY7puKGpt2pw==
X-Google-Smtp-Source: AGRyM1vxHcqnPnOU66CK1AEXD5Vl0Z6nx6EUCHxvAxh++El2kaEdOGeXjnWXPjOu3TT7jq+/z+5gPw==
X-Received: by 2002:ac8:5949:0:b0:305:1445:f413 with SMTP id 9-20020ac85949000000b003051445f413mr20393199qtz.27.1655748671053;
        Mon, 20 Jun 2022 11:11:11 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id bx4-20020a05622a090400b002f3e2435ee2sm11038245qtb.63.2022.06.20.11.11.10
        for <xenomai@xenomai.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:11:10 -0700 (PDT)
Date: Mon, 20 Jun 2022 14:11:09 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: xenomai@xenomai.org
Subject: Test delivery to old address
Message-ID: <20220620181109.7hau3evwtlzw3qsc@meerkat.local>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass (spool3: domain of linuxfoundation.org designates 209.85.219.45 as permitted sender) client-ip=209.85.219.45; envelope-from=konstantin@linuxfoundation.org; helo=mail-qv1-f45.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=linuxfoundation.org header.s=google header.b=J6qF8eov;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (spool.mail.gandi.net: domain of konstantin@linuxfoundation.org designates 209.85.219.45 as permitted sender) smtp.mailfrom=konstantin@linuxfoundation.org

Hello:

This is a delivery test with the old address in the headers.
Please ignore.

-K
