Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A3145B16
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264467; cv=none; b=or32VciHgveqAoFVK1Y63nEimdW8XnHeB3UuvQCmsJTRVEx8AQzQ4oZzx4bBRNg/JpLo4L2vgYbMmOprgJy4FmAzX8GM8Argc8pzfkE2enJU8bfjno4ezzDefUho77GJTaaXufMH4Z+AjLK/hueYWyAGxP8JZlaIBUeuhevkad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264467; c=relaxed/simple;
	bh=FRFy+rwueVHu8JKxWd0IT4i21d5mOPD50ln3K0hp0Aw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2iMiUzTTFYMIhTQNZYuIEVvGpAJft9MWcJNVBnIA0iosx53TevKeYivVTiW/VhRUaqr3bqQscxOZZUiyKJVX/TdNf5Cv1Hf0ctSIfdEwGUBBuxgFxZ0Uxz9WcCQ3vgg+iK3RBQEe1YhZla2KjANvnjmDLDPlnLj8rMO1s3BrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Bl9JRSnH; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Bl9JRSnH"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250919064738fd0e549588000207fc
        for <xenomai@lists.linux.dev>;
        Fri, 19 Sep 2025 08:47:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=FRFy+rwueVHu8JKxWd0IT4i21d5mOPD50ln3K0hp0Aw=;
 b=Bl9JRSnHnQ6/VMf0H8vtkNwpmMflx1zBEealuXtI70wXY8SrVwfIb8LeDnnt4wUeS132nt
 5a2PPPZoRR2wqs3PjncRvZH/A09YnSpAW0HQM/+F85XIJ/uhckuwHihWz4U8iMKvoJTuV2b6
 dnkU6DNwDko36618kgU7XO/3el/85ZJFpt813P6U/4Wxz+xE8b+lvyYWb8FbAf9TBYNhyzy1
 i35TLilvYRBo0jsZPgmD9BCeINHjBEyXBSmtnYQceo00KIB4mEbjJHQu8LX0c1fmz99bukMt
 dMdKiyLu4SrobgOEZ7fS6enUTqbCTb01BWFh+TOalph+ZE35wM4Z61Pw==;
Message-ID: <864bf229d505715df5d0b9f43714021e29a67a77.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 04/13] libevl: Unbreak build of r51..r55
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 19 Sep 2025 08:47:38 +0200
In-Reply-To: <45ee3b4aed024b1fc66864a77e09ddb49346e1a1.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
	 <45ee3b4aed024b1fc66864a77e09ddb49346e1a1.1758210955.git.jan.kiszka@siemens.com>
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

On Thu, 2025-09-18 at 17:55 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> One patch is needed since r53 up to and including the r55 release. An
> additional build dependency is required since r51.

This is due to the compiler update, right?

So the patch is already upstream but we need it for the older releases
to get the Debian 13 tool chain working?

Hm... There are no stable branches, so we have to maintain all further
patches within xenomai-images?
