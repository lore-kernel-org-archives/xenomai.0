Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262220ADD6
	for <xenomai@lists.linux.dev>; Mon, 29 Dec 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766999058; cv=none; b=UxejrT65mNjxQXsDHp1g7162CiRwoUiUOCp3b08Ehx3YHK8CZxF0hwgY8m9vHJIwWK+7Je++xwvtEs5Imv6bgbMslNpAqA+t1/OxqABWNQ6sNEZdcoDnc/ZjJW9Sg6b2MNPv6pBseCWI0ASFbTmCD3edBsilW8eRDd3Eyw+/3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766999058; c=relaxed/simple;
	bh=iMfYkHIEQndVlkOpK8bkjw9aTYTvLGQGVaDaHKg3jI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAz7qWHmp6NA8pd22XlT1XopA/8DoQ14I0Bvqxc7jraje24sGMLLjTmNuwdM06KYub4GhOj0OQN6Zss5Rcwsk4GCKpSKkkAVhFcZfM/Cwum+UD2QHx5EwzOPVGDb4KMoYayLvy/FZuy78CxTexp9niqOr4kGTju+gCW4amhJXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=UaenWAnH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="UaenWAnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766999053; x=1767603853; i=jan.kiszka@web.de;
	bh=iMfYkHIEQndVlkOpK8bkjw9aTYTvLGQGVaDaHKg3jI4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UaenWAnHBABx0Lrh8IW89ATtFPlP83Xi3MSK/cepLNqJdMp7XBZygEFWMb1v54Lg
	 AZD0v2yt3/eCXqHxpDeh5lIthZzuFbfeXT513n8HFMo7+80bRyfuLt1uNazNvWB/R
	 w+F6w2wfTUOUrwDpkSG3lurfjiorA45LKNMJ6i1BxvTwfmGnGvKrsNxbhyw6w/327
	 HUzo1wpqiimjWBvBkXQGrWjsbF1a1SWHpEGXJU0/RCSLwReXJrXuHILqUn1wUwAOA
	 QJ4tAVE4OVeld+tFQ+lJaLCVfw3TCKK1GoASNYBaZehsYv91u4sk28KLtx+dxMs0J
	 czX3Z9/v6IUizUZCfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.21.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1vpMyU01il-017TlJ; Mon, 29
 Dec 2025 10:04:13 +0100
Message-ID: <9e679d7b-c247-489d-8351-5e5976ae40b1@web.de>
Date: Mon, 29 Dec 2025 10:04:12 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the kernel hang with kernel 6.12
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?6YOt5Y+M5ou0?=
 <guoshuangshuan@sinsegye.com.cn>, =?UTF-8?B?6YOt5L+K?=
 <guojun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.90c6520a.23af.43fe.9b63.9c6842941db7@feishu.cn>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.90c6520a.23af.43fe.9b63.9c6842941db7@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ng7LWezYP6ynEP42+RA/Pocq0gvB+JOart6QcWYCwqL3tC/ZL8w
 GQTLfQ3EQkusIo6F41spLQ0K8+R1usWoHLqbC70JCNgsy3baTdPdSc1nDI6tP6AVzz1MBlO
 KDs4R/b8KBL+GBfeRLbz5dEfYBevM1S4aqzYxpPJXHiF8njq2fOMhw+CcMIkSmLc6a7nT8N
 1YCG4pt28ydMQdPAeCwIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:665DPMkwVlo=;fP/MJz+S2XqgUJ+6cUYXXf8JjAF
 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
 0aRpgRpppLqIDJvfNEhi5+1R/U/3iIjlwdxP0F

On 29.12.25 07:53, =E5=88=98=E6=9D=A8 wrote:
> Hi xenomai:
> =C2=A0=C2=A0=C2=A0 After testing, the kernel hang problem disappeared af=
ter applying the following patch. Is this modification safe/correct, or ar=
e there any potential issues with it?
>=20
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c48a466db0c3..c5e0456b63e6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4280,7 +4280,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm=
_vcpu *vcpu, bool spec_ctrl_in
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/disabled.=C2=
=A0 Note!=C2=A0 GIF=3D0 for the entirety of
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren't actually u=
nmasked while running host code.
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_enable();
> + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_enable();
>=20
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 amd_clear_divider();
>=20
> @@ -4290,7 +4290,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm=
_vcpu *vcpu, bool spec_ctrl_in
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 else
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 __svm_vcpu_=
run(svm, spec_ctrl_intercepted);
>=20
> - =C2=A0 =C2=A0 =C2=A0 raw_local_irq_disable();
> + =C2=A0 =C2=A0 =C2=A0 hard_local_irq_disable();
>=20
> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 guest_state_exit_irqoff();
> =C2=A0}
>=20

Sound reasonable. But given that we have zero patches via dovetail on
top of arch/x86/kvm/svm/ so far, the entry/exit paths need a second
careful review. Studying what we do for vmx and comparing it to svm
would be a starting point.

And, again, we need CI testing for this. I've just created
https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55.

Jan

