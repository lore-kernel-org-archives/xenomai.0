Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948023A564
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782331; cv=pass; b=SSx4Kv2hd4e3nLnws0gkQNF54DePLmz6NdiJnjo7GZXvzmHNgUrBhJFRrtTvoxjDdQhNfNt+gFuS1Q2khGcN+aKRZ7TNR+gvh/HeMppwfoiW30qra8c1QTCIrGjhLYSTrKQLlig0e0Nb8m2QcAuicLK4V5tTiBTeg/13PLgWojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782331; c=relaxed/simple;
	bh=M2JuGrVg0SBpXXh2Zn3tYlhP7awtoU7EtllhnBWvrnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCkIZHYENxgarTJj/662WLv+wkROY7LyG5NsfAS+mjNCKg+zNBzIeVlDofowhyLsO3C254f+tXMGHRXfbgaaIt2zw/q1rQDSLzr6NtTccPqK6c065ae6IZMAHs2VkJTK9arSSSBQ6uT8Ywp44fTYEVLu+jl6Xv88XnzDtGY2/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=VBCfrW7Y; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="VBCfrW7Y"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so4770649a12.1
        for <xenomai@lists.linux.dev>; Mon, 07 Sep 2026 04:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788782328; cv=none;
        d=google.com; s=arc-20260327;
        b=jUxvEL3ZxeJcdSrkEohBhlogEoeZTauCL5B1EA2Z4m3YT6/TOWNk+7bLOx8A9eFUlw
         wCnqpS75aT3kiShdPyyN9mTUDwkP+epkpc62Xd+mLGIcaBAreqPwMOtS3eVV3oqBAPSO
         kTJaMa0eCuD/7doBIrIVM0gmxgbawRuqUzMN0s4ThOdJuXWq9/EEgiPxztui+ZfcUk31
         eTzTTG34S5SA35viNWCcpouSTsOC0jZ6tQvAx50QoU/wfnmZFljTZnBpUnM7PvF/uw0P
         KFKt+yRbzcNxXhVWTBbBu5m519OrPQCSHFzOKCzviXMzcuoNakuoP6I4eW3C65BwlgmZ
         zh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2JuGrVg0SBpXXh2Zn3tYlhP7awtoU7EtllhnBWvrnQ=;
        fh=ap8Zyw0ha59oONhWmjhPN5dyLMaIEyJm6axKzT8UsbA=;
        b=kLN64j8qfBNuvTJh0oiyBhZsQSTSyo3n04A5HRak17le764JZQ+lrgoNHrQKD49/te
         fPJOwlG0Y/EGOMkHMk5bMnXR2Tudp18S9rRpcwGO44SDJvBC49JRFlIkr5wPLYPykTKg
         CRrj+CMWNKVF8mgfQ1QLEtRZnYEzzsToke2Hi28fb+JXKkumZGid/OLju3vslDcNIMXe
         azxlG/ZMhCFq3NeIL7sOiVuyJm1CKNbNGALTk+y17qvXr14UXMPDK4S8vyQ3SCBA9nB6
         TdnwZttGIn79uevM7i8X26D203YGN+dAIdJfRurn4Ih/DlQqy3LbeW4s1GE1cdBH0a2H
         Svwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1788782328; x=1789387128; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2JuGrVg0SBpXXh2Zn3tYlhP7awtoU7EtllhnBWvrnQ=;
        b=VBCfrW7YMHgHJMjzMniH/blnnFVYUzMolBlgwU9xrVvF5w3aEtVucpgEu1XEKNBDhc
         zEp2Zz0ozACr44ya06/ZU806yQgftvQnZUXzRNCR+W2DzpCu0tSDz5X4dNWuCVuMIERC
         Z0l1HZUWdu3t6Zqv4eZZ4WmARS98ldVcNmlQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782328; x=1789387128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2JuGrVg0SBpXXh2Zn3tYlhP7awtoU7EtllhnBWvrnQ=;
        b=exl2VIBMy32z6Cmvdy+87bMXjeRC3xmu2YS4dwmz3SGrxh7rlEIEd61+tKmcG9jFTi
         3ESGTfNPzUrwkVHohdvMzJX1TKwxuWkNWBHIdqJi4UN5KzpR6Ao8UG8yYei0aSeZMLf7
         +/eVg24+QOd6Mbx3xPVrRoF2/n1bfxrrFctAhcXa2JFZCZ45bnA0MCbXgDPYJ58CG67E
         NuX37H3u9eQA102vBIO7FnZqd9pW02e9PDNi6cbNPLCnH7meJee1Wmeum9jtvLB1JTUP
         SRToaJtWuHHhbxqqwjJA79JTjdHV5hKQRYcm5dSy6RmsK1rHFJg/gxmk3HZvS2Bkr3ME
         yiSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzqaGhMLC+rrcNYVqfzxOyMHGZFNWOYQcKVeJ0c4CQQD/0WlF9V/FugPpQo/3sKI3GzdNho2LH@lists.linux.dev
X-Gm-Message-State: AFuF++k/gzDsA4txcqgBmiTRtXqIC/T63cvS39+oOdZMcgUruW13A5nT
	9KYZimXcD5SPHezVc9/1Gjd5X5Ch0l9P/0iSQELEz/qkV44CrwcQoSfMjLdJK9jCDIvidYOPNXH
	RsM+Jgzpn8f4mvSm98GnrHQT6o2JPeNGG0Z9Slj/vohX8l1vWu/LYfGdFG1Q8qO5BPech7usl+J
	0ljq6F45NlcA2HXiV9/kY0w3tK/iSz97xbj/30gDNlk186mCSHaIyDTgC9Dz5ABvHclmVjbLB9s
	i2TToRJ6s6Avw8Jcyev9jSVGefe6bfNeUFP9ZHwMXbdRqsz+w==
X-Gm-Gg: AYBFou0eXq9fSpdJexWEn+sw8K8ha+0Pkkl+GL6GylslgaBgX4pKq+DBkxmiTXB5qP/
	IXJcWDP2I1Q/9p7KiVEsk50IT9z4EMZxL8Cr/YyB+ZEIwWdh1tHh8YF60zIjjg0TcpGsMlJTyA2
	VTNO78Z9VWFy16huQ98zrp0mDj2N96KCjhsGgkcL1RWaKUKbFpZyKMOENmGdrKVI9kUSxcCeHPl
	KvduDWgRX5c4Cxxle58klmrIYJKxh3zWECxx7YKKfoCWQfYNKKfciv2hFE3WCrVQmOOMbuTME5C
	Es7nan3eH5i2cJLxGhqjaZ2V0dNqNGfzf1j6jcFr8btfDodd217VzjPJTuRNjB2n9C4H0XinnXA
	s4sw0LVvp/5IiZSpfZCZFejcAd4cJxLAQctDmqo6mZMfni9Tycn4guod0Vdr+xoc=
X-Received: by 2002:a05:6402:a547:10b0:6a7:f25e:6db1 with SMTP id
 4fb4d7f45d1cf-6a7f25e6e51mr4266043a12.37.1788782327878; Mon, 07 Sep 2026
 04:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
 <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
 <CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com> <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
In-Reply-To: <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 7 Sep 2026 14:03:49 +0200
X-Gm-Features: AcwNN1WZyADCxbT52kmfnkaSUZB20mK5cV1ufhY1vnbU9_EOcI3isPJHU4EAWeY
Message-ID: <CAKndYJGCXChO5zFfA+Cij_xCk6rOipnGJ+hUmt46_hb1uHiOiw@mail.gmail.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev, 
	Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian/Andrew,

On Mon, Sep 7, 2026 at 1:34=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> [..] It should fix the problems reported by Andrew and Gerte.

Yes, confirmed on my end. Awesome!

Thanks,

--=20


This
email and any attachment(s) it may contain is confidential and is=20
intended
solely for the use of the individual(s) to whom it is addressed.=20
If you are not
the intended recipient of this email, you must not take=20
action based on the
contents, nor distribute, nor expose any part of the=20
content(s) to entities or
person(s) beyond the original distribution list.=20
Please contact the sender and
delete the email if you have received it in=20
error. Thank you.
