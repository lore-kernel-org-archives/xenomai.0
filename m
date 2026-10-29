Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286946;
	b=NOLsNR0TJiOrw2FqwZs9q1axSlz5L1DOuX31ATEx7HgbJodx4wlgHKEIk4HpoMKE+2d+
	 U12LkabTbkSe/8aLoZgnRrE5Mi0QqmE7uO5WYtc+QCI+NPzqC0GaKHJsi0VvA7ETeoVuZ
	 Lbk872svH04wd6SoVRBULTMTIoLuF99KmqUaNQnDnnziQI6jRn1ACEy6KiYuJa0T5l/EV
	 Tof7sFUF/P6XV6996tukCq3i4OqktZFF0SdgJjU8B0NYDPLl+UA9kRSBCGuPr0mVhKmtA
	 TBzn9nPaZ4Q29Z4QBrFNnKbkZ+O08hxb9EQ9bP8npWWY108wXD+p+pvHid4WXV/rf/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286946;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=pqUC4XmodaHR4qqH6jnHW9nJq58DjP5ftoEwF9Xy3m0=;
	b=U8sCp9+UCoRSs/06ctWKj/knU0NKI3mgGhkbOI1uv/TrNA3gZAlobbNr27hr9npPww2F
	 Mx/UxY6lMYgfQEnO4dfccMqV2lg3Z1po/9ZKQQHsBp3DQ2/kOG1OF8RYgeTBO+TdhxlH2
	 JZSo3KBA+p1GkqeF5630BeqSJlYfw0mJnT8WR4JX2VqcAejM7ytM8qzfNRjvEvZWP4USH
	 PgM9sTwmmWFaWLLMMtqzQNRgKzG7m+pqks3wILwNZNUbdSbAEcEsMq0PXGUD5VNH9PzBw
	 HEMXS6k3QqzBGyiMfJWB3F2h9YWEcfvqV6og/fcPtAdZ64RFZ8nO6bi20qth+KRp5Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=PHZUGK2y;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E784606A325
	for <xenomai@lists.linux.dev>; Thu, 29 Oct 2026 15:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E784606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=PHZUGK2y
Received: by mail.gandi.net (Postfix) with ESMTPSA id A691D3F191;
	Thu, 29 Oct 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1793286937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqUC4XmodaHR4qqH6jnHW9nJq58DjP5ftoEwF9Xy3m0=;
	b=PHZUGK2yPRar/jinrkLpXJEUAnXeYdJNSF2/f5nepjKSgBMCqxrfLP+fhT6PexPwwR8F4v
	Lkd2fIMsKPU23yfRFcUWn2xUc22LwjPGTD+/bFuK/sH7zYxdSCvE3OkNXERgM/OfeUU4Qq
	u19DyWiPuEp0vu2kEeW3Nrw6gStul1v0fhwnwQtTD033PCCp3GT8V0LCIvE4k5zNpO3IIZ
	kKmiDBGIAvzeATaMdJqJLm061xK0P23klDBlgQGCJ4b8KsUtIcjdfEkDp5IJvBtHKgSU+6
	M+e3fN+PwU9COy3haADShhcEQcwje5NU0U+yHrYCFxvw7mZN3gge11dzrLkLJg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,  Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: Dovetail 7.3 release candidate available
In-Reply-To: <1e1270ef6b7a899fa095765a68461f2baf8c927e.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 27 Oct 2026 09:49:17 +0100")
References: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
	<1e1270ef6b7a899fa095765a68461f2baf8c927e.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 29 Oct 2026 16:15:37 +0100
Message-ID: <87y0bgmtba.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEJi/brHEnmVOdyf/mgrnDDYW7uGj+YSK7N96e7Lsx+5Q9cDFnKwBAlHZp2BoLiNZEtftBdq67LPrRBS4G4moSW8U0hnEopN+tughX8vbXJFYNbLtcaIUt7YUllHNj/HDzhwvLMUbdtVrpjsC/5u6UJ+kFi0VoYKPZ91+shUM4RVZ94qDLEA4m0GmQHateMvhFu98IqzSwAGiIare6ErMde/nurz0q25t3SJ44b6SOWArsyrp1ARcckiPqDTKMBIr84l9rfKxiim7oWTJQg6ok2kwjVnhDInzRRzYHgCwdeuW9gICtVoP84HPYqdM42QIs8Ig2GtmbPMjLmyPbL5AcgWUCM9udjK7RsnIh8B2FGPEO7bVt7jHO+BOYOejipr5+uZCrjFGzsJV3+9hRWS/S73cBR5Ujg5TulzT27lgy9N8vucENsB8Kc+rVGHqlx4q7MoZ6tZotdzNxp/cDFfzNsadbgFX7VtiZc/B5kZUhmVnJsGufJgPkh0YPGnmkU512Zrb8i0uuINz6DX68jgZmd7/hIXYQdbDQ04EGZuG/ABVxCCEmfWp/MYZAsVJqET4tIA+iET/44Ew7QK5bpHG0oXhFasZMNRzguVO1CkfBvcAAFCV+Y1s139hGNj3u5GQc2owcTlM2dDubh1cKOtN+DLxhF4L7IbW10AYPTHMiQ6A
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-10-26 at 15:35 +0100, Florian Bezdeka wrote:
>>=20
>>=20
>> Missing / next steps:
>>=20
>> =C2=A0=C2=A0=C2=A0 - Expect a final history (git commit) cleanup
>> =C2=A0=C2=A0=C2=A0 - Move to final branch (most likely v7.3.y-dovetail-r=
ebase)
>> =C2=A0=C2=A0=C2=A0 - Rebase evl
>> =C2=A0=C2=A0=C2=A0 - riscv: Run the Xenomai 4 testsuite (once evl has be=
en rebased)
>>=20
>
> Update:
>
>     - EVL rebase is waiting in the=C2=A0next/v7.3-evl-rebase-flo=C2=A0bra=
nch
>
>     - The Xenomai 4 CI pipeline is green. All architectures passed
>       the test run - riscv included.
>
> @Philippe: How do we proceed. Do you want to take over for the final
> history cleanup / branch "renamings" and tag assignments?
>

Ok, I'll handle this. I have a few patches on the evl side which
complete the kernel support for the POSIX interface in libevl, I'll
merge them in the same move.

--=20
Philippe.
