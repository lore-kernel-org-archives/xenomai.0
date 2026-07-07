Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F941B351
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434365; cv=none; b=DfjAiRl3DFJOVUg3bRwb50vGHWmVa6hFgB6H5Sz5OxtRmNwgU8jXWI4Pq+Bhy65hoTYyrh9zWqL+nokR+aQhYHO4Y/PAGn7YA8BENkmdKbLEVhL5JHhQrTAvhO2orasOm/zSeeV4/WfhX9BpR9QEzBv/Ym7ldXZqGi0NeBPMmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434365; c=relaxed/simple;
	bh=8IrPlwrCWneTHakWXxx7o8xKhYc+VQUNiGiggUadDbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMJIWwjfShmmogWBjmtz8EkUExBbtTjTKOFqnctf2ozdh6/Z8f8L7DwAf8RggP6aNW88n7HLzqgeGhdXG/6W+pdc4i8AMGis+5ydo59WTm58ZfG/ut/Yca4IRCGIzCGznTyieU+SdijhftJsS4AcFWSLFr23Q0XfBb14f6uEIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SVdDhAqJ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SVdDhAqJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FCAE3ED60;
	Tue,  7 Jul 2026 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783434360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IrPlwrCWneTHakWXxx7o8xKhYc+VQUNiGiggUadDbw=;
	b=SVdDhAqJSfENfxjyskxWN/5CLYFhJUNEwZszzosbQ4X9UqVV9dD8hkzzfoP3l27ch1wthi
	l/sQ+CYbi3MwotYI+f+0H0cKjBwP5PzUb+i2uObHWHI5kRCDPVrrpAv9nzhQsYOSNcQXxr
	fVSFZhEPZJzTE+tfCiybNlbs/Ccwg2fLSr8Mv7vHe2R8Chjae3tTWGl8I4aUQozZQL2uSP
	5JCqnfWz5dk3ocefEd+YaOpcnK/nzSB9hiy6zAtwGLuMtv1g8yh+Q6yXnnljz5ADWOxVrY
	Q7EP+mw1ZmPTwQsTkRejw8b+pSo+NdBv2C6AhF32KcuuGF2+PEoYvShdikwXJg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail/Evl confusion on my end
In-Reply-To: <87o6givqdi.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	07 Jul 2026 16:14:17 +0200")
References: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
	<87o6givqdi.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 16:25:59 +0200
Message-ID: <877bn6vpu0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGnQ1e0GdNK4r1sq2flhElxr38p1P9ff4GU5QsOiQ4p/zbCboYvZymC1OYNwFwooPKZdj2k0LScYjV9yXOVc2bq2kLqW7SHjII7sRRrYuGChsIUJ51tKCyeFxpq9pvA6HsQ9euyDDOg67xsobzf8VP8o9MHAvNFolAQr+FoQ/fzQu9nb/q8wA/yUbmRGQSn8g/UN4bMUhNsQ59zrS9dos/UzClfzwBrGwatG8ddk/C/AoVlSWwKgTp2vYUGPTFxzDu2A2PxtgxHluYveqvOT/kx6og6GAcqeHL8B8QXbNskCZquX1KeQ7A5j9P6erYzO5TNh6MsijpECuItzbvzpLYjpWc8HWbHTvb8G1rMSf4MmRQoNm4wD6uswWdVNN4WZoOTCNJwbAR4fh157lotyhreM7vn6r8MmBtekKS4xJ1W2Fft1Q52g5KTrHh/wVm1SUB4U2e5TQ2OMXAdaH6w6uR3RfAwTERMeFPs0NY76Q/+/CFvXVVZFaw9CSTtaFPyJqIX+PaXMk5wlnLqOiFhxaiNn+Vqb0y4xatmnLMEOZIEK4dtmGI8dYe4Q3cYaiQzwxUmxEKL9TJV7S5MVp86ofZpxVl5P9A9At36hiKbfg+JzdrD6fY/IXUc7heQCfVUSBD3I56Ukf27G7k/kqGOIrQUF2tm0//oe6ZlpP4u/lcmVg
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> I just recognized that you updated the source of my rebase branches
>> meanwhile, so v7.0-dovetail-rebase (for dovetail) and next/v7.0-evl-
>> rebase for evl.
>>
>> While syncing the missing pieces I noticed that commit=C2=A0
>> ad7e492ff2 ("/dev/{null, zero}: dovetail: drop deprecated .write handler=
 ")=20
>> is part of v7.0-evl-rebase but is not part of v7.0-dovetail-rebase.
>>
>> Why is that? Any specific reason?
>>
>
> I pushed this patch yesterday, and wanted to have some hindsight about
> it for a couple of (testing) days of the evl tree. I believe it is
> correct, but given the patched area, better safe than sorry. I plan to
> merge it last on top of 7.0-dovetail.

To elaborate a bit more, this patch only helps evl strictly speaking, by
preventing stdout/err redirections through proxies to cause a kernel
warning, which in fact reveals that some portion of the upstream code
(namely the /null and /zero cdevs at least) are still using a deprecated
file_operations handler, which the VFS complains about when using the
kernel interface to write to them.

--=20
Philippe.
