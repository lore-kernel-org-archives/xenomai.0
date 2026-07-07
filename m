Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41C234994
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432586; cv=none; b=g/7GwKBnmA7hm9negtiTCVHObg4/2Knq9I+B6QcibKW00+PMpnwdJmrSKk19xEFSfm6dNR5bPMD6vOHWFVTHM05CndISXyaYlOAYXl5ycr7QdwRyXTvFt77MfLtAFK8FIIfUNzImLVUxL2PJ8xCSPBH/hskMYTFUWffjIlnvU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432586; c=relaxed/simple;
	bh=k69dxtexJdAOWVkIK9KSWQqily14EbVHoq2IKV9vlj4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WB7iz1AxnpDlMFWk52tXHCoYTdYnhoF3qCWMbrgLp49j7xno5H8zQiXucn30y7B2OZeyK2SdixpQ6iAqSRB0kL6KB59yfJGinDDambw47ozP5DRdOxpo1vRDQkyjhS0chHPI7hPfFzZa+/EolFa828CzounqTTxhBFPoZ+qdI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QTdNRmZs; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QTdNRmZs"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260707135615f6f6cfa6c300020753
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 15:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=k69dxtexJdAOWVkIK9KSWQqily14EbVHoq2IKV9vlj4=;
 b=QTdNRmZssUByIH5LENtAPW4YY1YFm53cEYppYes1a2FkyqTvRZAsW2tXJ43lVtMNLNVQ66
 nfBXq8KKmEULhCSxyidIvalx6AhLxWTzPiAy/RwZ/gs774uQFBPCGJ7hVCY/dv8vcQ8LHRYK
 psRLokiiJ07dH1ThwhmaWfKBAsVzSfQKhcbO1oWeOFLZcJ0WgCKiIjsGkggCzKfRtcytbJcr
 XR6yIA1y/ZY4AlGjQydm9VOOPK0m53/QJvLEzzU1p+5MJEKAKO8i7yDl0NGxOTlAZv4amWG0
 ADIg1kIarcLijHxIkt7URcoHGbH7LXF21i/232FtoLDDdvS/D4vKJ7Cg==;
Message-ID: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
Subject: Dovetail/Evl confusion on my end
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 07 Jul 2026 15:56:15 +0200
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

Hi Philippe,

I just recognized that you updated the source of my rebase branches
meanwhile, so v7.0-dovetail-rebase (for dovetail) and next/v7.0-evl-
rebase for evl.

While syncing the missing pieces I noticed that commit=C2=A0
ad7e492ff2 ("/dev/{null, zero}: dovetail: drop deprecated .write handler ")=
=20
is part of v7.0-evl-rebase but is not part of v7.0-dovetail-rebase.

Why is that? Any specific reason?

Best regards,
Florian

PS: wip/flo/v7.1-evl-rebase will be updated soon again to bring in the
missing parts.
