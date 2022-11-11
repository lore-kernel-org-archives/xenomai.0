Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDE80B
	for <xenomai@lists.linux.dev>; Fri, 11 Nov 2022 09:12:17 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 88B90240006;
	Fri, 11 Nov 2022 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668157929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwJZxPm0IsLxvHP/Kgpgv13mNUk8dzPFlfo10keUJrY=;
	b=UHCVGqFY9wVrY7vaic9rGw+SYSJ3BcE0PbfNPkqDzvyjupNDNxaoSIZwHuulnhqZ0C+q76
	wyyQjpuvKMG89B/zLm5DJnPQLAr+Y6afCOITbaD+ZNI5knFGFrm42b3ui32gwz0SJIQt+Z
	xidRryk2WcVBnZtqH+NlNK7V/hmIYryFwtPsbpsjVUDunx53bDpxmN3aD5ZZ7/Hj6hBPwv
	A7+Btq5iImbw8nmZcs1Y+zXqqJ8iAAGbipFcBmf+i9FPPtojAyIr4uT27FxFhgQrd6/J6x
	A2F2TWykcoy5NRKGpG5W+GRFZVcqoQHL//1Hry3YCuYDbIoWDb+auCtMkhzjKg==
References: <49fb01fa-abda-46eb-cf47-31d48810d7eb@gmail.com>
 <87a653p28w.fsf@xenomai.org>
 <3ef4b7b1-8bd4-edea-9518-1b2efce90cce@gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Robert Berger <xenomai.list@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: cyclictest vs. latmus
Date: Fri, 11 Nov 2022 10:00:53 +0100
In-reply-to: <3ef4b7b1-8bd4-edea-9518-1b2efce90cce@gmail.com>
Message-ID: <87cz9tc0t4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Robert Berger <xenomai.list@gmail.com> writes:

> Hi,
>
> Thanks for the explanations and sorry for the late reply.
>
> My comments are inline.
>
> On 07/11/2022 08:32, Philippe Gerum wrote:
>> The results are available from [4][5] and [6][7] respectively. To
>> sum
>> up, we have ~62 =C2=B5s worst-case in non-isolated mode, 37 =C2=B5s when
>> isolated. Both figures are in line with the expectations on this SoM.
>
> Yep and this is what I would expect, so most likely something is wrong
> in my configuration ;
>
>> To help figuring out the reason for this behavior with latmus on
>> your
>> test board, you may want to share your .config. However, I don't think
>> the results you observed with cyclictest are relevant to EVL.
>>=20
>
> Please note, that I use a multi_v7_defconfig. I guess you use
> something else.
>

No, I'm using multi_v7_defconfig as well. imx_v6_7_defconfig won't boot
that SoM.

The latency spikes you observed is related to CPU frequency scaling (see
[1]), the "performance" governor was not the default one in your
Kconfig, but the on-demand governor was, leading to dynamic frequency
adjustment. This should be reported by the following command on your
system:

~ # evl check
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dn
CONFIG_FTRACE=3Dy

CONFIG_FTRACE is also reported because it does have a noticeable impact
on the latency figures even when no tracer is enabled on ARM, although
the overhead is still negligible compared to actual latency killers.

Setting CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy is enough to fix your
Kconfig as I did here.

HTH,

[1] https://evlproject.org/core/caveat/#caveat-cpufreq

--=20
Philippe.
