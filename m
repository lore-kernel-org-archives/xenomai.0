Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CE37646A
	for <xenomai@lists.linux.dev>; Tue, 29 Sep 2026 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716184; cv=none; b=fCOFC5n6pYq3JxlfI43EGtwT6DuFzQ6sLlDrjZ6z1GMUaYEuk9lLV12nBHKjtynjVGLvfma34RmHepmYmcoKO2OaX+4PZZA/sRCapHqWWW1ZYooSq2+iUCLCw0Iy8FeZc6oPPrmkSlEO9uJ1YBE49eFn5gmZxOBhqtJbOtTbxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716184; c=relaxed/simple;
	bh=JkKFtbwrp75y+dIn1sAhks8zXChh9lw+OnhNkB3aKRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfwgkDyD4J/fiKTkL4byxa70kV02m3ES9P12gv2d9OkdOb3fYQKi81fpxbY6Ms2bonZ6kgg8oDz6Cyj14PjCaGptSfgftbDYgLvmV+Kv/s0Yb3YcUJ8H0cFw3sK/nwTaV38e9b+kvWYUYBmjrimivgtjUk6hM0n+i4Qx4GDrM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iwbqjsXW; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iwbqjsXW"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609292109310f6150ff340002072d
        for <xenomai@lists.linux.dev>;
        Tue, 29 Sep 2026 23:09:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JkKFtbwrp75y+dIn1sAhks8zXChh9lw+OnhNkB3aKRY=;
 b=iwbqjsXWsUvL3qAOPOSz+Um55aeGW83wsXRQ0Wv4cdqCsUkFMAbj5eDho3eqRyNZ7sIHXB
 8B91/qjtakvRNNhP4Nuymfl8Ws77KrGLe4psSXGE8enMZrihi4IFQ7MPQwhIrKKNr5Kyysgd
 fgP7qPwxBgEKa2jSAeXT+5G72M3quNyduQZZyLgndDGDjKikxVqX5PI8FiKg2QiRcqe6aG6B
 PWhkL1Hqs1oaioGdUx6WS5KvVfOWNCtYYSMWcOZJkT+O3+ZXdKl60b6eHpC7oJFXbft1t+TK
 DaZDSJfH/GJsAjP4PJEs7yVyXWQT7VWsl4zRGI7UE4xdTJZodPgaMs5g==;
Message-ID: <2b5e9f6f2bb082278d921f6c0269ddfcb168d89d.camel@siemens.com>
Subject: Re: No call tomorrow / Meet-up in Prague
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, "Kowalsky, Clara (T
 CED SES-DE)" <clara.kowalsky@siemens.com>, Quirin Gylstorff
 <quirin.gylstorff@siemens.com>
Date: Tue, 29 Sep 2026 23:09:30 +0200
In-Reply-To: <9509551e-b9e2-4bf0-8669-fecce9ce6403@siemens.com>
References: <9509551e-b9e2-4bf0-8669-fecce9ce6403@siemens.com>
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

On Tue, 2026-09-29 at 18:22 +0200, Jan Kiszka wrote:
> Hi all,
>=20
> quick note: there won't a community call tomorrow.
>=20
> However, if you happen to be in Prague for the OSS EU next week as well,
> we could use that to meet in person. How about gathering after the booth
> crawl on Thursday evening?

Sounds great. I will be there!


