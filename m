Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090968;
	b=BJ/tZa0KdVVpo7GE/bKdhJcWzazNv7ehJe/x/TogLphblmRwMKpHZUZ+Rfd2zh714OZE
	 ilmJDGWalGD6iMXXkmF5xKhnlLc6jA0/+AWcedbHMSnvUd9y7kW5gZ+gNGoFytKJFduFv
	 DVKGTJqPo7RNjjEZcKagjohboF2pdIJfeJLYHp2YPnQ3NyqODz57aO9P24fKAMjWKWFNU
	 CAT8fKy9PEj5c+RULev6g4SJXLVWgAKHOYHfnijtqH6mgCoEYMzfitEPL5DfkIVyy2zXJ
	 ULOWKUa5J4syfdCui7aC8J4v90eHDO/QdkqgPTBE28++heR4kp1362WyjkuB8OHfjBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090968;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=cZ/16l/y8/EiIBvf7MlmR7y5eJ80RfXf+Aqa2r3N9Gs=;
	b=ooMgZuwNkBQoknb7kU2fsRn1a5FhIWmcLKfmggFrQMjoDOGeSxPCuNbpmgZji5XelVQ6
	 ViQunsJ7bW2OGyPcfWLPTTmKrnN1Q0klBCm8fWV1jH5ovoL8PX7/To99ovIT+Hm6v/Wij
	 Hz9la+y6BrMA5ogEdSnJRak0WHc51qlQyL1nHL+ciU/n8N6WGdDXPCE49NH27GpLItkhT
	 RQRPeVSc9u17zmHwK+fhoLHHqImEvUW2tAh+WC0f7rJD+PfP9Tj5FvJUy+pnjX9oBaqmt
	 mb160illbFWfoGQr3w7TdjO4iZvnehpFXVSOs+5HPIWVqfB2/JnV1brTdh+Y8LIBC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=TK+62Ds0;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1569606A326
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 08:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1569606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=TK+62Ds0
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202610270849170be218d44200020747
        for <xenomai@lists.linux.dev>;
        Tue, 27 Oct 2026 09:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cZ/16l/y8/EiIBvf7MlmR7y5eJ80RfXf+Aqa2r3N9Gs=;
 b=TK+62Ds0Arw0luUaVgoDmdTpb31oL2VmCuZxSzPU2RRv7maU1IxDvCI1wLR9wSkqOpAYgk
 qiuLgg10LKMQCRkUOv83OQExCj2qW/LjBJKwhSFNDx059IV5WrOKuZlOcYDDFMtOSU2V30M2
 rdimhTnTblOX4Nsbh6ShzOTewezOCHwyVQt63vmR4dZbl2ek8JXNUXqJKJpxpIEfi1Hcc/5Y
 87ldzJvGxG8pncNVEn1QkaBX2oyhyvQHFPOFqVXmm6tZupdC8Js18wC2HdEcODTDkN9AOsYh
 vPh9crwlVQ1kZ/yM2T7dats1m26kmOPED2DJw/w0BADWYQRDUFVFS3sw==;
Message-ID: <1e1270ef6b7a899fa095765a68461f2baf8c927e.camel@siemens.com>
Subject: Re: Dovetail 7.3 release candidate available
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Tue, 27 Oct 2026 09:49:17 +0100
In-Reply-To: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
References: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2026-10-26 at 15:35 +0100, Florian Bezdeka wrote:
>=20
>=20
> Missing / next steps:
>=20
> =C2=A0=C2=A0=C2=A0 - Expect a final history (git commit) cleanup
> =C2=A0=C2=A0=C2=A0 - Move to final branch (most likely v7.3.y-dovetail-re=
base)
> =C2=A0=C2=A0=C2=A0 - Rebase evl
> =C2=A0=C2=A0=C2=A0 - riscv: Run the Xenomai 4 testsuite (once evl has bee=
n rebased)
>=20

Update:

    - EVL rebase is waiting in the=C2=A0next/v7.3-evl-rebase-flo=C2=A0branc=
h

    - The Xenomai 4 CI pipeline is green. All architectures passed
      the test run - riscv included.

@Philippe: How do we proceed. Do you want to take over for the final
history cleanup / branch "renamings" and tag assignments?

Best regards,
Florian
