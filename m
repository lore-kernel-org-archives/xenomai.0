Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DF7A
	for <xenomai@lists.linux.dev>; Thu, 28 Jul 2022 17:52:50 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7A2E5D2769
	for <xenomai@lists.linux.dev>; Thu, 28 Jul 2022 17:51:25 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 07945C0002
	for <xenomai@lists.linux.dev>; Thu, 28 Jul 2022 17:51:16 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 11787941B54
	for <xenomai@xenomai.org>; Thu, 28 Jul 2022 17:51:16 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1431423wmm.4
        for <xenomai@xenomai.org>; Thu, 28 Jul 2022 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CuUm98RHm897bS8y5U020rQlhp6Y1Qs7uuGlXiVg4Y4=;
        b=F7M1GwFLlMmbr/TROoYB1E9+/ZmbdibiJuRgIcBlJQO7QujIHiIkze0YZ83N1159q5
         jcE0tTfgMgENxviMCs5wT7GOE+x6hdf4Ee/LdheozrtDAM9Wllxd9UxeJUjojxWayjV3
         zhYI/SSIZlJkGv+Lz45kgzTzQOqvWsL1s8PetyY4AZxk7hXE4Tjdn12AWs0Gnhbk1SEX
         ClHvOGvdYb6lI/Iu7UvMCbS+zZr4RlRHGefldBldtr1F0hpgmKLoMFupHNLnfBGEL5XL
         IVYMKgIFPCa3Ke9yz2mKK9CKq6em4svVmBVRQ+4NJByb4O59ne3YWZwCT2kuRafCUyhq
         gGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CuUm98RHm897bS8y5U020rQlhp6Y1Qs7uuGlXiVg4Y4=;
        b=3uUUf7gfuoadkSqssiG/4sGMT2PaW7w7/o4jrITlePzQG7Mb2AcmeMwW+6YBZjdBjW
         Auzf1KRfNmJGJM+ISdY0UbDPRAvUuOoF5x8jZiskEjVnBqRMMQunFy+IP7WwWTEcUzyL
         p4H6KtqkmhWFU3ecjRXnchYH9U2o8iHcUEQu/malACuAOqRWNzxV4olqZfOqfbYJ9TbX
         wcfumXqsdGWNxhzl9r27mZztK8mOJpOYlqyAaw6HAJxAt4TMfs4v8WnrunZ7zwYu+Msr
         BnCSiLqppozPfeOYge5GjyS3Kp9FHdcdzgUGc+1CbJUcQN4+yOdNZH2dGV8T2B1kk4L8
         H5sA==
X-Gm-Message-State: AJIora/SToqBmUj8BesXudPNUflYkp3ML3RHO2DBK2QgaBV85joPpe03
	ztbm4xeZBpwGXMcCt8K6ZHlOQvUTKW4Z4iC6TI1R7Ad++QE=
X-Google-Smtp-Source: AGRyM1t8dm4sDuqlGBl6jiapw0oMFZa0oGScpIPN5Hb6FGgHLuOgDWSUaCo5/AYxW03itAwjxheBtmXNVibzPLQ4/kg=
X-Received: by 2002:a05:600c:3847:b0:3a3:5333:8bcd with SMTP id
 s7-20020a05600c384700b003a353338bcdmr32252wmr.36.1659030675444; Thu, 28 Jul
 2022 10:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Thu, 28 Jul 2022 10:51:04 -0700
Message-ID: <CAAm9oxrU8-ohehSY2aUMc8acea2zGEzrvgi56nQzCiHv+gKv5w@mail.gmail.com>
Subject: oob_recvmsg and protocol filtering
To: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool1: domain of gmail.com designates 209.85.128.47 as permitted sender) client-ip=209.85.128.47; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wm1-f47.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=F7M1GwFL;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.128.47 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

Hello,

I am trying to minimize the latency on the network path of sending and
receiving ethernet packets for a fieldbus application on a Raspberry
PI CM4 board.

I am using oob_sendmsg and oob_recvmsg (of course, the driver, in this
case GENET MAC-based, is still using stock Linux, so this is not a
perfect solution for now).

I am binding the interface so that the allowed protocol is ETH_P_ALL.
I am able to send the fieldbus packet with oob_sendmsg.

However, on the receiving side, there is still filtering going on in
kernel/evl/net/ethernet/input.c in evl_net_ether_accept() which checks
if the protocol is ETH_P_IP, so oob_recvmsg doesn't push the fieldbus
packet up the stack.

So, 2 questions:

1. Is this right? i.e. should it be changed to accept the protocol
based on the specified interface's bound protocol?

2. If this is right (or used to limit the OOB interface to only IP
traffic), I am looking into patching the kernel function to allow the
fieldbus protocol. Any guidance on the acceptability/desirability of
this approach, or are there better avenues?

Thanks
Sri
