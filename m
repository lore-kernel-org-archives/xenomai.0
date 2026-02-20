Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001242C15B5
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599445; cv=none; b=hcp2t3ILVUyYtolH/YI3tUriED2WePNJmGUZWo0uQDWnf7QDo29aBWerXtUB8jWeVYorEb6Kw5GH5zmZYDXfkSHOkJYd0TIho2rCwNv78Q55gRgEG6zx8XjQvSlSotR3r3jsu5DXTrEqN6U4oRJO1YRbDn1moeM/mK8AP5cR8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599445; c=relaxed/simple;
	bh=0KUVTmy9Lzrano9rgrKu+CU+k7lw/EQ7oBMm2msVOA0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBvojqwtlz5jqVL8ELQeYKKlXfZ+90Hwhd+WamXosrX+ht4hZFC6VGIuVf1X+RUik+ARCXchP2HLzVvbk5cC71RQMcbW2KTzOKHg59BevVjw9IT4vlq4xbYwHM2fBL4yzs3izGTrwfbodOWmSvRoAXeXxw1G4hQD8X01WZsb3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aA0Ly2cW; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aA0Ly2cW"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026022014571892f8d4668d0002070f
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 15:57:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0KUVTmy9Lzrano9rgrKu+CU+k7lw/EQ7oBMm2msVOA0=;
 b=aA0Ly2cWhOwclkw/0IEgzhSi5JHuSLlQo/mhWUetfxhKSKXHRrfZA7Bn8oMaXYT5FNu5Vg
 BQTUgvS7IT4vJaexfz2OZkrz/sRzuunDswntG1YRm+0gCg2hv72fj1TWRSChj6W34uK5Ahbb
 ebvNwOEYAPWAzeeWok1YNv3+UrHh23+zRZTfbwZhMlC2e8HbD1hlz9qfNKexXF/hZHdqD3XW
 3ba0/mk45Z+5k/MCDLlbwqKdf+c6ACt7k21hn0Tz7hS0Xicp2a35rBtwHzds/iMhQ02BGPF/
 zoeZ52o2UvlGE1b9WOSzDwK/qfQjUQUZLyO7FLtsVgB0aLlGs8xYs6PA==;
Message-ID: <3f035a32cfc26d2b31047099990f8cb5d5059d4e.camel@siemens.com>
Subject: Re: [PATCH 12/20] lib/cobalt: select: Move select services into
 wrappers_time64.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 20 Feb 2026 15:57:18 +0100
In-Reply-To: <e98cce6f-f488-4ff0-8034-4f09365032e5@siemens.com>
References: 
	<20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	 <20260220-wip-flo-fix-time64-32bit-native-v1-12-731c773e72cc@siemens.com>
	 <e98cce6f-f488-4ff0-8034-4f09365032e5@siemens.com>
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

On Fri, 2026-02-20 at 15:38 +0100, Jan Kiszka wrote:
> > diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> > deleted file mode 100644
> > index 5472e991e126c2f521b346a7cf3c884bbf6f6317..00000000000000000000000=
00000000000000000
> > --- a/lib/cobalt/select.c
> > +++ /dev/null
> > @@ -1,108 +0,0 @@
> > -/*
> > - * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenom=
ai.org>
>=20
> Make sure to not lose copyright notices...
>=20
>=20

That is the only file that gets removed. I will add Gilles' copyright
back to the select() part in wrappers_time64.c as I'm quite sure that
not all time64 services go back to Gilles. I will double check, though.
