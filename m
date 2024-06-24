Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D2482DD
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215868; cv=none; b=b4Uf2UUOc3JFOI0TqzMmB2LKd09Bc3M/vQ9jxXOJOQbqNql/eUP0T27x6fzbxG4wc0bpCsc82n5ZFYI1rzKpJFssNhT79ksfLltF/ABW1WVMig5aiI95lcXqDpRpG0vQ679BfyoipFbd2BMKM5YJh/1UX6B/6Xdu2DJWwL9oZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215868; c=relaxed/simple;
	bh=UHFhdan9H0GhHYXKlmi8hhWWXWh6a44MrZ8zQZNvd9Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=kX0it5HXPZsoLHLHnhi/COfKK/+rel21LVBXdPPTIxy3EzG/u4dLoBYA1Y0Im3QcLJizc51zHp3Bt3Hse4uqm2Qm7IIFUHEKHjZd0BOm1jDuD1nHpWSmtZD4jayzaxtNOCWZgYVHMtX+g+IoHzg8ZNnceqdaOmqdkW+KfNTlJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424720e73e0so35396525e9.0
        for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 00:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719215865; x=1719820665;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dzLFiGYcU8+2SZTHJXOEbf2tXxJ5/RFNFyzsmpjkgKI=;
        b=MjejIMGaqo0gshroDrPKfhhcvim2NTky91lhiYv4DOgrFnfUKs65ZM5oqyTtH4ic8n
         CT1Ngc6DvZQqaBpzTsushiLf+9qn3CuG6ZI8u23eWYSDfp2wbh/td7a+BLghaP3lr+Mn
         ez+mfEfzh130oSoZG3WiwZsIlyMZHJOluQkbefoSEpOWeINAt61ZOR3BdXmP3ciJJREU
         L36ONFLgVrbDVZk8gKKg018s1Zghmrypj5Wz1r3nCIr5Ep37D8jNRXvkFGMPFzT65W+y
         qEzzt3l4pW75nZab9XCcCaO8eli/XykjZRiuq4iqOjipH6ghjMmqSk0rqNCfDDKHwGTy
         C9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVepuWsfE4S63kfGFPjgBOYoSAUbmU38ag5ldMQ0t/H0Lq3Yekr7+UheRv1ritHZKW9OidLj5VS4CURtFPrs63nPtIWGnlpvA==
X-Gm-Message-State: AOJu0Ywqsa7mQO3czCnZTah7Yx55oWsVjQOm/IBoLaJstospriHMk/cg
	qkrWdbrxRr+RwAGZKR3XWT6KrLvpuKwqWYCnjOsKAbUrRk83vRZOu9qhJetD
X-Google-Smtp-Source: AGHT+IEzEpvffnn4ikm4h3K1rc8qzlRUMLUqXhu89Emer/H3W4QJUQOKBZ3mSM0b7jAMxNPkCol/IA==
X-Received: by 2002:a05:6000:1a8d:b0:366:f010:8817 with SMTP id ffacd0b85a97d-366f010890dmr1816644f8f.55.1719215864509;
        Mon, 24 Jun 2024 00:57:44 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247cf5272esm167038425e9.0.2024.06.24.00.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:57:43 -0700 (PDT)
References: <871q52ry16.fsf@xenomai.org> <1157-666a8f80-f-41294d00@43403104>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, "Chen, Hongzhan"
 <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Porting RT net driver to dovetail
Date: Mon, 24 Jun 2024 09:46:37 +0200
In-reply-to: <1157-666a8f80-f-41294d00@43403104>
Message-ID: <87msnaojrh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Thanks for the clarification.
>
> I'm not sure I understand the sentence "ATM, we only have a real-time cap=
able raw socket interface".

See https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tidbits/oo=
b-net-icmp.c?ref_type=3Dheads

> In my application, we only use RTNET for level 2 communication. Is this a=
lready available.
>
> And so, back to the original question, how do I transition from an RTNET/=
RTDM NIC to an EVL/??? one ?
>

When the upcoming EVL netstack is fully available (i.e. including the
driver<->evl interface along with the UDP layer), you will add
out-of-band support code to the vanilla driver directly. Typically, a
couple of handlers added to struct net_device_ops, such as:

#ifdef CONFIG_NET_OOB
	int			(*ndo_enable_oob)(struct net_device *dev);
	void			(*ndo_disable_oob)(struct net_device *dev);
	struct sk_buff *	(*ndo_alloc_tx_oob)(struct net_device *ndev);
#endif

The idea is to reuse the vanilla infrastructure as much as possible
instead of forking the driver code. There are a few techniques to have
in mind for doing so while preventing too many merge conflicts whenever
the upstream code changes, the netstack will come with the FEC driver
adapted that way as an illustration.

ETA: end of july.

--=20
Philippe.
