Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185135E948
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436543; cv=none; b=Doo7Fh2tsLhiAaBdWkUc7L+2jY1TJ/KSEHcTPyCvoY86InW9522IjyOupTTRmmtMAuf06RH3Sd2YSmc+Sj+u8k104rgaH6N/bQ/WgGHtXXtCRK3B837VRNVEURfxy/dw5m9CALJyGp2DheoEHeqvg2pcP2VpupJu98kgD3wbpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436543; c=relaxed/simple;
	bh=bV2g5+JNPZKxmu1jvrLrLc/hul09vBVRRA9psmmdY1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKqGD48ZHTgBvgv845LY5tRSnVhrArrOjtRA+6S+YndkpiE/GvVX6m4SiHImPCCqGH3SpORWc971KTnyhBDbBO7SkNF8p2YUjNAtaIYDtcv5iZWbFEoMGCSMrSGyjvEv6CikAT1OZ1YbmOtE2r+f6ktrn9NR0PirDKodJ9BJiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=G9szdYiO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="G9szdYiO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35D783E802;
	Tue,  7 Jul 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783436539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bV2g5+JNPZKxmu1jvrLrLc/hul09vBVRRA9psmmdY1E=;
	b=G9szdYiOoJinxXS9RwAfaAwKH5s2Y/i0HeDR1tcKXVCvNzIhfsEt+EQ+8Jiu5LsaXJ+wwE
	I3uqVmHse/1H8PRV1lKbfr1oFNj3WGimD8a1OvQcuKjn/xaEwGFa7Zfvh5Rbq/zw98UTCH
	8AMguJsiQenGkiuQVcsKYDHZROm9KEUmund0dpZJkblNcR39A0Hg2V8abSJOo6G9TlQ69l
	UNitKP6O7c4OEW5j0Z7dPBBXSuHCtLt330AWvNgW+iYCUgBu/mbZORHGSxQEQVkczjEQhz
	uDMsAHqq+byd/8MMalnoeVObRe+M0qF3Y7KhN0POKi32CqSgCwa0+dhI3QxLEg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail/Evl confusion on my end
In-Reply-To: <877bn6vpu0.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	07 Jul 2026 16:25:59 +0200")
References: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
	<87o6givqdi.fsf@xenomai.org> <877bn6vpu0.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 17:02:18 +0200
Message-ID: <87y0fmu9l1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEm2n5GJq3JP1n7IQunjgoiAjdeOQ9p717G9wcrKNW+UY7CCYyd/4Lp4SvgcH1WtFYGO8WrlVCVZZigfgKYn+mARYGUR2gWFQdhqmFWxT5Pc9qJ4FX3brxxkopy+sGAA1e/HMljQilj5yEZPpQ+3n42aTbL5E5dSoBzt7dCuuVfl0g7vKHjOVXUTqN/xzoNuxBchyc/PPRj6Iit2ThU/cNZ55Xj5euEtgdpiKQieRmkmxMVlLQ2UwcUKtsbyWU9OfTUjDaJ0mU1igfwuSr3fbZTVykrr+w+U8yRi18ivG3mtV1tEVTVd7+H/No7/eO449EsLwCkvpLsFZVJs9rnJg+8W+kr68EIZPnZrUhaIOYmgJw0gWeboeQIyckU5L7XRvbR+mXyc9iCb3aMU8m/dqYIp85iOPKtfBXzYNmD0m3cFKxqfo0gdhs+qi8yDnum4i79e2JzVIWzqTbVs2OeunecjLgwc9ntONybPZkJw3EkDBd62eiD6MnmY1U8nx6OpGWgFZjjLfxKGy74iDRPs6QKecDYL/6P3xSPRp9wNQTSiePJY7eE5gigpwi1s4MFEqDmDzw2rxgrMPXv7ghD9f1i58PY+1xxnOBGZEjfnZGwjghuP1QoKA/UdiXeNoQm5tEkCdIzOPlRURaPi3ABjVuFGu9RFbI0q57Au4KgIPAQ8g

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> Hi Philippe,
>>>
>>> I just recognized that you updated the source of my rebase branches
>>> meanwhile, so v7.0-dovetail-rebase (for dovetail) and next/v7.0-evl-
>>> rebase for evl.
>>>
>>> While syncing the missing pieces I noticed that commit=C2=A0
>>> ad7e492ff2 ("/dev/{null, zero}: dovetail: drop deprecated .write handle=
r ")=20
>>> is part of v7.0-evl-rebase but is not part of v7.0-dovetail-rebase.
>>>
>>> Why is that? Any specific reason?
>>>
>>
>> I pushed this patch yesterday, and wanted to have some hindsight about
>> it for a couple of (testing) days of the evl tree. I believe it is
>> correct, but given the patched area, better safe than sorry. I plan to
>> merge it last on top of 7.0-dovetail.
>
> To elaborate a bit more, this patch only helps evl strictly speaking, by
> preventing stdout/err redirections through proxies to cause a kernel
> warning, which in fact reveals that some portion of the upstream code
> (namely the /null and /zero cdevs at least) are still using a deprecated
> file_operations handler, which the VFS complains about when using the
> kernel interface to write to them.

The feedback I received from internal users regarding this is
positive, no regression.

--=20
Philippe.
