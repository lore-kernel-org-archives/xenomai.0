Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EF45BD60
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905962; cv=none; b=khsZvb97DAgGclytDw/ft3oeUvZaT0gkYxw8Q8eidFvX9NDo/tUtXJzEXYbeLHrx0y5RKipurc+02Ss1Zas7uUvzdT8sJs1+BXFVn3vmyI8pNWOjbNrNB676TUMvkbAkytQgDre1haXP3pdQiAqcXNBtXwGTyEvPgqyaO4r6JhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905962; c=relaxed/simple;
	bh=HrJ5HIp9On242bz3iN3zgxWUeKGVbJkOYpGbgOR7OSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TsyYSkGeA3ATogu28BvbvRVas8Mzos0hy5v5gOfntB9poRmNLov/rgsWOkP1ogWTSaxptvV/lDF4G1Pf7k1CeSHfbqAbw2iCaXZvHX28i5SbG+4SONJ0OFZmG28NJTSxm7ouCnFVcaVjtR7YTNdiJ44jebR9NJxa0q6aEdQ2vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bhluTIrM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bhluTIrM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E30E23ED7E;
	Wed, 27 May 2026 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779905952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9utDPkknh42iDzdoTzVqV+PFvW1eiOwciWaGsOB4q9I=;
	b=bhluTIrMC070LrQ7a+kXtBB7Um/9Iw4GwVWAsA+HRFFbc7kvKWK+2X+c6a7zS/lFtPtBQk
	+zn9kJMH8yqVikF3d6WB4UdIFYruasXLoWoJBtR/rLl+cKV1/uzf3R31FKxCY4yLkctqaQ
	eF73buwgBhRK6J/XYQe85Yk23HT4VsS40/n2lc6S0Q4CkYKtdmJSNYFuQ1TDf1ASucfXLz
	n/QUiyditR9nyh416lfiHI+yWfKRlQGffRpQqecZmD+gqiTLyZiNH3APP7vQ3p1HW0cvzt
	nL/8sALmTAgb3xSOuyvsa8XzaX2PSfn4Y4sk23dkrakPPu3ipeBdPEY58Tmn+Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
In-Reply-To: <05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com> (Hannes
	Diethelm's message of "Mon, 25 May 2026 23:02:33 +0200")
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
	<87cxyjph49.fsf@xenomai.org>
	<05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 27 May 2026 20:19:11 +0200
Message-ID: <87jysohg0w.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFd0SEVZi57RhaT21CwEk6C9cTEy/WoNZDmajrdUEc9640TQzqyIl+sbcApgzScwD77+3CzpcKIVTpGFnY5spN8cXjE6PezcymhWrYljDQ91tilgFpF7J/6nR2gLbNFfDGT6o5HEaK+tcbXRvv61kLe3P4pGuR5dGXSwjlwDWjl2fXftC6H/n6VYDMMfYrjuqnDwj7Wev4w0xmd/EADTXDurrsfHvO177TB1rz+394tNvVNmTquGsN8lz/xekSwB/u1LoOGbtqt7TkgxYgflgWAwFePEwSNLmpGmqVExkIqGGsyxZaiY1E2qHctpR10P1tmIfkazKxScmWhLFF8511/I8owaBQxxAi83uyA6uwUAI0Kr2BnOoooGqHne1WdNDfGhVmuFFyAWq50IlA6KUM8XllUZ9kLBVaEpmy01gWbcVGz2ws/ecr0KCjWlQDosJ0l+6qpiaNQ44e5YXqxjc2cUoPHyg4o9yefTvLTpVnBSmmvCE39CqBphw+ngrPtUdNOrQo3HlWuuLA+jtusjkbbxXi8eHzIY6qYUigiVZc1iHM1lhxrMQNpCntvqNlYKxvnwmC2gfMoFY7fxhURFiJmHQN7lx+JO27b4MuvqzSdt4KejX/ZD5ex33JRpejpjNZtO7l3TVd3AqZ6xG2xWfmC3bkdels6HVBRzrCeKOPZEw
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 25.05.26 um 18:51 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>=20
>>> Additionally, fix memory leaks
>>>
>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>> ---
>>>   tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 240 insertions(+), 18 deletions(-)
>>>
>> Merged, thanks. Would you mind sending a patch to update the related
>> doc
>> on the website at [1], regarding the new -S mode? The pages can be
>> downloaded from [2].
>> [1] https://v4.xenomai.org/core/net/udp-demo/index.html
>> [2] https://gitlab.com/Xenomai/xenomai4/website.git
>>=20
>
> Sure, done. Is there any way to preview the website? I just used a markdo=
wn
> preview, I hope it did the job and I did not introduce format issues.
>

Sure, I'm using a plain 'hugo' server for that [1].

$ git clone https://gitlab.com/Xenomai/xenomai4/website.git
$ hugo server

Then you can connect to localhost:1313/ to view the website
locally. The server immediately auto-refreshes the view on updating a
markdown file, very handy.

[1]  On fedora, from the 'hugo' package:

hugo.x86_64	The world=E2=80=99s fastest framework for building websites

--=20
Philippe.
