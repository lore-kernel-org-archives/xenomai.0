Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928E17BA3
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915954; cv=none; b=OG2ghHyqzte2+JQMy+x7wV4kvhIn7tnWkzGRRd1aerh2mYmw63aVc27ioGf9w3OtVlCaLufhZHUg8nz9+4vGLtJlwM8WBsb7ghQtixgFaNhkFgIkB+robFp3BQ0aHyzHPtMtlOY1VCT6WmMWa2rbw0q62BlXMVJ7fLoyUNr9qMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915954; c=relaxed/simple;
	bh=FL4zL2Dxk3K6JuPHgnYwfnnWwcX+inwMJH1FJ0BmpIE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=lhjAmbucF4R+eiq9pq6rLRMs1UqwerFYa144oVqwgoyuhh2Lwgecn08Q2vbIG25VH5Joef4GCKsiaPQlCM42kTKLQMkZcN3++yrhdRUCpbaviVLiIDrkGoOgUdhueaDmM6j7hG/Twem/QfdaSzdtRttP3dyokoVYbuAPv1Vu/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=G9+QVUan; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="G9+QVUan"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id B202E200002
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 07:45:50 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 01F60D8119E
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731915949; x=1732175149;
	bh=FL4zL2Dxk3K6JuPHgnYwfnnWwcX+inwMJH1FJ0BmpIE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=G9+QVUanOR4ZUxD6D3Au3DqFJQMkiopC1MxGn1yVT2Sg7qfr8i7RQbEagUnxv7GHQ
	 y92pBWL4+/voCEkSarzkuUM+Te6/CP5AK2/OBYIGaPZb734JgFMjWKin8HS1rGkiEq
	 3Uiog77AAyn59/KTo4BMgG9niD8EnQkKrTXANhR5a8XXybErY16tAv08p7E8LBZFOt
	 erMgnvXgk6W+/xBOrAMRq581PaZExTqcza/Adkg8of89b0+CI1BcatmsfM0C+KWzVb
	 MpddbBCxpsAgiN7ipoFRq+xR0UqsluVlfN6GIEktAZFETYRW8doVohSNN5MU+9RBgh
	 hA8jVAzvhMovg==
Date: Mon, 18 Nov 2024 07:45:45 +0000
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
From: Andrew <andrew.penner@protonmail.com>
Subject: Using Xenomai in Medical Devices
Message-ID: <giN3vearN1y6Zs5xQuBxzIuE9sPhO-y12RSvKKFYPIZnLJJW7dN1vmlmEpLBDuSVKuk8qYA3O_I--946KsBwJRceRx2BKlYxkHLaAJic_Ww=@protonmail.com>
Feedback-ID: 36040464:user:proton
X-Pm-Message-ID: 7584b1f25bb70a1fba20d99f2fc378320d13b3f7
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=protonmail.com header.s=protonmail3 header.b=G9+QVUan;
	spf=pass (spool.mail.gandi.net: domain of andrew.penner@protonmail.com designates 185.70.43.16 as permitted sender) smtp.mailfrom=andrew.penner@protonmail.com;
	dmarc=pass (policy=quarantine) header.from=protonmail.com

Hi,

I am looking into RTOS for medical devices. Since I am fond of the Xenomai =
project, I thought I would check if there are any know use cases where it h=
as been used in existing medical devices (name of the device along with the=
 'yes, absolutely' would help me convince others.)

Thanks in advance,

Andrew

Sent from Proton Mail Android
