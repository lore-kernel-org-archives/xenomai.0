Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA77407CF1
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563519; cv=none; b=PnQUtcaql2+jrITQtot4dgyYhq5gjGPMSnjXTqDEh1ja1MFgNHBmyqhr55kDIJ4h1Nn6G3dP+D3N6n9HIpHK6P8dYUgaIDEFJznbz7xTIIRgomnKqYOMmCy7aYdx7XR2+1HRbvqyV5OMZQ5Sw2tBvw8HrHPQzPYDrKbDc5Y66tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563519; c=relaxed/simple;
	bh=Vyeux0MNK56VfH5Egss16impPvADQtlKVsZ4nxGrmr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRy3dIo4P8sleNXAhkz0GMUPIpUC8kq89nHj8MgmhaYFbh+vkaXS9jaaRTco8I3oJnxSGvh0iHTLfdcxb/1I4Zhogw7Sq3BAzW+6LjksCqklvJoxHFKXsLZh8kAIhtHW86yHYIrsZD8Ue6cK5NrBL5QJBaBdsZrp2iS1jA3sZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ofuhor/6; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ofuhor/6"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260720155502c97051ecc800020758
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 17:55:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Vyeux0MNK56VfH5Egss16impPvADQtlKVsZ4nxGrmr0=;
 b=Ofuhor/6urOYgRS0rIgqdD9qWoWLlwpHRbpYZCQLCrKW+L6nJYmosAUNnLDmsHruVafgON
 6HY12Hx7AO3kSN45C8LsgxDlvUlgOdamf71m5D0rn/w8e1mgtFP1s64TacPuwFFBcIxW1sVm
 ijubnSX82vh6bcCznI5zlFv7q7r75g7EWXh6HAyL7KpSqJVcN9dabIzovoKVk13Rn0OOXBgT
 q5NNI4iF0A0tLR8USlYJ0SGbxlSZvguku3geS8BnHq9QN6bIqb9/YtDeivC8jdlVWo8rVU+I
 AT8HWlw1YuP1YfxhKBFgF1HkBRm4ZyjoycO0QcIlaWQaxqMPkmH0R04A==;
Message-ID: <9fc6efb1a9f1fcfbdddb48e37df0ba7c9078b63c.camel@siemens.com>
Subject: Re: [PATCH 0/1] libevl: Add debian package config
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev, 
	rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 20 Jul 2026 17:55:02 +0200
In-Reply-To: <20260717205820.8359-1-hannes.diethelm@gmail.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
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

Hi Hannes,

On Fri, 2026-07-17 at 22:58 +0200, Hannes Diethelm wrote:
> This patch adds a debian package config that allows to build a deb's
> using dpkg-buildpackage -b -uc.
>=20
> The packages are libevl / libevl-test similar to[1]. However, latmus
> is placed in libevl. One might not need the tests but still want to
> use latmus.

We should try to keep the minimum footprint of all runtime packages as
small as possible. I'm quite sure that latmus is not needed / necessary
on all the production images / machines.

Maybe we could introduce something like (lib)evl-tools or (lib)evl-utils
holding latmus - and maybe even more of those tools / validators in the
future?


Florian
