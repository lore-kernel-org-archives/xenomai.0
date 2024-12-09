Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651322C6F7
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747013; cv=none; b=YOmmrp6tvYT5KfeX7pYoc5phDnQ5HkPUTNQDmTqzbPRuS5s6uCDPQEfqgsyCGyu8AkzeBUy98ZpFy9RBd/CeIjNmSyh7bwnTjj9BkkrmyXW7jCc5LFbQz8VHsdWVdhA7wFo6nSyXAyKiudnmM6DC1sHd+onl48j+uk1e5C8SoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747013; c=relaxed/simple;
	bh=w9/dvdVy2a0xDvnPxJSh/ihUFiKEIyNuzq3hKo1IL/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2oOR2eTmcNlVLV5+5uj4FFbcGYsCV1tG+uHaNuGbEpgDSa+rzoDYPJf9NZN8YtomVUulgK6bNXn3C7hi/nJdAKnTj1kk+q8NHwVc9Lx/mOPe8kbr1m+ZThl9ZWh1GA5z1Tgv6asX4r5EETGt6E+kwdqcD3BvpjR8CqH0rlRRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=N8COmnlK; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="N8COmnlK"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024120912232264e439f5bd7f32a73e
        for <xenomai@lists.linux.dev>;
        Mon, 09 Dec 2024 13:23:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w9/dvdVy2a0xDvnPxJSh/ihUFiKEIyNuzq3hKo1IL/A=;
 b=N8COmnlKdwklfXZp3cw6p+NnWdMwI91+gzqtZXNsgO1+xSYF39sk0t83Jm/LZ+3MP9vBPJ
 Pt0gpjCgjlOeZ5Rqivyz6R1zO4dKD/ELBfbPQ6u8O2NxYCy+wArpCZsjUXtFZ444Wr4TQn1E
 5ewu/9ge+pn2Arztc/0aLTOPaeUUOvirolp1MhVkTf2+6bNo+s/clyHyB4MzxPAuxJOTSP6r
 82PRGc66JvhbDC4kTRqN5VQWub5R8mb5grMJI5N0yzregir5ms+42abHCRCq2Y1g41cki5s6
 y8x8ugw7rvpioqFYgtMXx6fgXCO2RuTgepxLskzPkMUxIZRRS0iv3+pQ==;
Message-ID: <bcd3335e56237b6fea42153d0c193afa56c93ffd.camel@siemens.com>
Subject: Re: Re: [PATCH] lib/cobalt: remove unused
 `pthread_attr_getdetachstate`
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Qichen Qiu <ruiqurm@gmail.com>
Cc: xenomai@lists.linux.dev
Date: Mon, 09 Dec 2024 13:23:22 +0100
In-Reply-To: <20241209122046.706065-1-ruiqurm@gmail.com>
References: <faeb387ee51b7d32574a582a771d4fe5108b6b76.camel@siemens.com>
	 <20241209122046.706065-1-ruiqurm@gmail.com>
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

On Mon, 2024-12-09 at 12:20 +0000, Qichen Qiu wrote:
> Hi Florian.
>=20
> I apologize for not using the checkpatch tool initially. However, I=20
> have reviewed my patch again and did not find any DOS line endings.=20
> Here are the steps to reproduce my checks:=20
>=20
> b4 am 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachsta=
te.mbx
> ./scripts/checkpatch.pl 20241209_ruiqurm_lib_cobalt_remove_unused_pthread=
_attr_getdetachstate.mbx
>=20
> The output is:=20
> 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachstate.mbx=
 has no obvious style problems and is ready for submission.
>=20
> Additionally, I used the hexdump tool to inspect the file for DOS line.
> hexdump -C 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdeta=
chstate.mbx | grep '0d 0a'
>=20
> If there are additional steps or tools you would recommend for=20
> verifying this issue, please let me know.

That is/was a problem on my side. I ran the tool on the mbox instead of
the plain patch. Local tooling bug. That one is=C2=A0fixed now. ;-)



