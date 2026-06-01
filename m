Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA3DF6C
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338535; cv=none; b=reTMSI4oU7xOuXE3m1M+vqTI/1uqRORncKkXF5BhDoYmKY1fThw9irigsdlE7GEbQ7HMVyxcbaX3jQz5eUhNFzwTmaflD/VstMqRpz4lJ8frZQDcRbWBswjaEnEAU6uUou6SEtL2WCdYmNoNUEoyHPtJHuDKyzAMAkNZUvs62Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338535; c=relaxed/simple;
	bh=5GJnAbWeaLFw+JCtHwbrXMM3ZtCTJWDHfbBiU0nLW60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejNYK12a1rOwL1NP/eH0AV9WPceOmYhr+0O50UNWZKJIf/b3KFe7tLPkI3pVTdVUFj07JWtAEA15QDtZ2EyMo3t4yc1/eiLeVxrOC/+cx/D9+lSgcUOfpyEEIW/zDENxgAfHYooOjXodgAQ7R0PKrSAJfFfiJetrHwv2OLuyt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=oDygcIRN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="oDygcIRN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CD313EC84;
	Mon,  1 Jun 2026 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780338530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVqRfUIjRmAPZY9Zmakua3jvkOdjMg0w9aqcAbe2vEo=;
	b=oDygcIRN4BggYMsAiureoCc/WPdmln1T9JfjpUyQCJOzBDmUCXUKSiVn/cmbw1QpCEIFJX
	3C6KjIkSSxG0ElW2ou5IHghoc6Ed72R0fE9B+YgqoVDqP3mwt1cZYjHVGwOrA0zwBc9J0S
	n0c9DJu85PjLINnHtqtcALuyqCyYk5C+qUydLPw7lPaTqXbaCEBTc8m78navv//5SgMBPa
	vgOwpOHtAZiMgc94bDinMkVBAGJb2YUkO1HOx8f1/eYh0Q5Lsx2q5f5lJSlqRZOAvGuFCM
	u0ZhBKDihjPk4ViVljJgBMUOhTVwZr3X/5Hsi9tjiR4D+pnIThNU2KgPepLJaQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 7.1-rc6 updates pushed
In-Reply-To: <27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 01 Jun 2026 20:13:03 +0200")
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
	<87y0gy4brj.fsf@xenomai.org>
	<27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Jun 2026 20:28:49 +0200
Message-ID: <87se763yji.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFBzh26IG1G9zW89KbgucioCMwsxWYAuWCrTcy78qVN4kXwOzG2cU78B5v5NUZ/SbHY9jGRzyEBz7FBo8sKoiDufwpF6BGf2XuI9Vn4o24FcEKnrGp+Qf2+Bl8+ucn6BhL6QN0qnufe4S+6eViHbn4ztbPJI/0la/XSVUMjLezMB3AFVvVJuPKiE21tSNu1GVQNM8Yzt2rdwEBzgE/eS5RZ8THNHaUlgT9/HBXIxcxB1dZv8aswnVWRrjbY7AueVsjIcyR3eRRBLnLKqbkwEbZknQNMAsF870/mvVpUhaXLxFHYVdTNWAgYpdqKeBmw5hzasg4mMMUfDWXDH6c/4PyYcy9PCsVgpYWvf5q+wZFn8PlitBaS3F1QW2mLQbia5n0+ybY1Z/nBFt+dil+xAl2z3ECH+8w75iEw9jn4hMws7neppaV3eBsx6u1w8REEwfNeGDLifQaqpUckYg9MAzJkG083109AnrckrvSI8DJRnY46xnpO4HmSzu2u8cgKOYwBzHvHlvUP2CjIW7oIyaMXdLGpduvYmn5nLDJpqef46cf6QwsUJOA57NTMc225EPirOKJkigWAAYXCWW9EVRSKgh/n+QlefsFWndfXTChTjzjP/hiDxdA3hbpa7WHsVXywdtuSl8LS8IqrZ+/wpdA7dbk1uBFcuyiYJuSnoJBoTQ
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-06-01 at 15:43 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi all,
>> > 
>> > I just pushed the following branch updates for Dovetail based on 7.1-
>> > rc6:
>> > 
>> > Dovetail:
>> > wip/flo/v7.1-dovetail-rebase
>> > wip/flo/v7.1-dovetail-rebase+riscv
>> > 
>> > Evl:
>> > wip/flo/v7.1-evl-rebase
>> > wip/flo/v7.1-evl-rebase+riscv
>> > 
>> > The +riscv branches are containing v8 of Tobias' riscv enabling series,
>> > maybe we need v9, let's see.
>> > 
>> > Any additional testing on those branches is highly appreciated.
>> > 
>> > @Philippe:
>> > I'm still waiting for some feedback for [1]. That seems now to be a
>> > invalid combination of kconfigs, which is dovetail specific. Upstream
>> > thread at [2].
>> > 
>> > Can you remember why KVM_INTEL is not selecting X86_FRED in case
>> > IRQ_PIPELINE is enabled? I haven't checked the details yet, nor tried to
>> > remove the dovetail specific adjustment.
>> > 
>> 
>> Maybe because the pipeline never supported X86_FRED, doing so would
>> required to rework the irq-entry trampoline macros, which is deemed
>> painful work.
>
> I sent out a RFC patch for that, input welcome.
>
> Meanwhile I can provide some updates on the testing part. The following
> problems seem to be reproducible on 7.1-rc5 and 7.1-rc6 - while 7.1-rc4
> was fine (at least once):
>
> x86   x3: Test timeout. Something seems slower than expected.
> arm64 x4: Same problem
>
> To rule out problems in our CI setup I spawned some 7.0 tests, which
> were fine, at least twice in a row. Seems someone has to look into that.
> As I'm running out of time: Any resources available?
>

Not here, at least not yet.

-- 
Philippe.
