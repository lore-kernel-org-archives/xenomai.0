Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DD12AAD3
	for <xenomai@lists.linux.dev>; Tue,  9 Apr 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662553; cv=none; b=YurL3qPhIFzbW+EkDKxIqlQ2kiBx5pW6LWI96vZdLOA6mzVlcGhhOvbXzB+ompizb0M5E3gOS1gcj/IAcPrh7dmmoOH1s6oDi/owq8NabPnymyFQrBcg7joaxxESEBeIa39nZDms+qyt4tXsnJWCMMEi0aO6Pvd5CDMLlk4pqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662553; c=relaxed/simple;
	bh=zZHlQZDo5GLo7oxmAMGBw3WQMkI1XEyW0SFWLnrgsaA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtS656gZG5yD3+CXxMYv7hkf1Cm7+wC+Ep9oc9ka6KvcI7HAa5vRGZIlmKXRxoMDM9QKQlCHXN8LZJ0ix0Ix8j0xrQWoKRClhIZYKlSGGf4BjgYNDQeBVU+gYRfabk6CqUCyRo4P5WgYYJw0DGz/Yy01o9Za4NxRfzrpakg5hLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=W2kCjqIX; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="W2kCjqIX"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202404091135454c7635eef3f920e43a
        for <xenomai@lists.linux.dev>;
        Tue, 09 Apr 2024 13:35:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MMdaQImnNHb0nI8lFvwfZcJlHNDk8/2LT9T2vZk9zkY=;
 b=W2kCjqIXcWNoO8O3eC/3Qfz2saGIPkksS6atc0VcDDgsSGKISsr457znmn7ggFDJxQP9aC
 aAt73qLASzJRoSute2Xzw3m76ViIMlQuEGuVZj4eHpc0D/3dnJlkk6ToGYfzQdL084bGyDib
 ZiV4TUo1zbYdfcl6NXGiLr0LeUcdk=;
Message-ID: <94a4793d828e988c4c501da67cc6da6be8408c05.camel@siemens.com>
Subject: Re: config-4.19.89-ipipe-9-xenomai-3
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: JerryJun <jerryjun123@163.com>, xenomai@lists.linux.dev
Date: Tue, 09 Apr 2024 13:35:44 +0200
In-Reply-To: <3ca18868.5e91.18ec0f24d71.Coremail.jerryjun123@163.com>
References: <3ca18868.5e91.18ec0f24d71.Coremail.jerryjun123@163.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi,

between 4.19 and 5.10 happened a major change in the underlying
infrastructure. We moved from ipipe to dovetail with the first 5.10
based release.

It might be that the numbers are (completely) different now, but there
should be no negative impact.

Best regards,
Florian

On Tue, 2024-04-09 at 11:41 +0800, JerryJun wrote:
>  hi=EF=BC=8Cxenomai:
> 	We have an issue where the same application was used on different kernel=
s , the MSW became larger in kernel-5.10.199 + xenomai-3.2.4 but not encoun=
tered in kernel-4.19.89 + xenomai-3.1=20
> 	please give me a hint. kernel-config by attached this email
> =09
> 	CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
> 	  0  0      0          9996742    0          0     00018000   99.8  [ROO=
T/0]
> 	  1  0      0          2024119195 0          0     00018000   95.3  [ROO=
T/1]
> 	  2  0      0          2586560269 0          0     00018000   96.5  [ROO=
T/2]
> 	  3  0      0          121156377  0          0     00018000   96.2  [ROO=
T/3]
> 	  3  2962   0          121156120  0          0     00000046    3.8  [kth=
ead1]
> 	  0  2970   0          9920415    0          0     00000046    0.2  [kth=
ead2]
> 	  1  2975   0          1650262    0          0     00000046    0.0  [kth=
ead3]
> 	  1  2980   0          3099325    0          0     00000046    0.1  [kth=
ead4]
> 	  3  3167   156        181        632        0     000680c0    0.0  XX
> 	  3  3224   9          9          45         0     000680c0    0.0  sysr=
egd
> 	  3  3226   8          8          30         0     000680c0    0.0  sysr=
egd
> 	  3  3233   8          8          30         0     000680c0    0.0  YY
> 	  3  3234   2          3          8          0     00068042    0.0  remo=
te-agent
> 	  1  3236   15         372743488  537438761  0     00068046    1.1  AA_3=
167
> 	  1  3237   327351466  652251196  327355285  0     00068044    0.9  BB_3=
167
> 	  1  3238   666888185  1000550068 2334622549 0     00068044    2.6  CC_3=
167
> 	  1  3239   856330     2163224    1710753    0     00068046    0.0  DD_3=
167
> 	  1  3240   117        2476148    128        0     00068046    0.0  EE_3=
167
> 	  1  3241   15         4962912    26         0     00068046    0.0  FF_3=
167
> 	  2  3249   163093685  326186203  163096062  0     000680c0    0.5  GG
> 	  2  3252   196178072  391844998  196181535  0     00068044    0.5  HH
> 	  2  3259   141521731  260330959  201102670  0     00068044    0.4  II
> 	  2  3260   163141603  326283087  163141808  0     00068044    0.5  JJ
> 	  2  3261   481724449  963372088  481875166  0     00068044    1.3  KK
> 	  2  3263   163130135  326258458  163132953  0     00068044    0.4  LL
> 	  2  3441   8648757    12961988   13009962   0     00068042    0.0  MM

