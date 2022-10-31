Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD2290F
	for <xenomai@lists.linux.dev>; Mon, 31 Oct 2022 15:11:26 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D4B37CE86C
	for <xenomai@lists.linux.dev>; Mon, 31 Oct 2022 15:06:05 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 55EA51C0006;
	Mon, 31 Oct 2022 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1667228757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybKSjJXnfWpdYOOr0O+gQRDUQEpAZoZEZVyFLffiXCk=;
	b=Aj4MbR7j+Tgd60c2dx0fcexwgHSnVZwhq2pOrgw75qmt54rIFe0A0Zi5PtxDMsIP2miH8L
	gv9+xnGvlHnsEuRH+7y3l2aNQ5dAPhYyL4DCzNbkUz1451Zev+wSmigGncwYdrtD9w7KS/
	D1aOJccaygFjG1COvOK5isu0WmkQuTUEGU5FjfQHLooc24R1oTf+X9HoNTAGza8zut91gT
	W1E7QEYZJu6+Z5zFXZRWmq7DxsT+SFnNv7QNEJDAO2Sr/luHIv6PDYUr3YJqyadHU1EI+J
	JpoRzIYpw/7XOpgCXWiVFRJej6y1VhqvgP3BjvZHJ86qtz3m0ZqZv+ymN+8aDQ==
References: <20be89e589cbdc9172533b4c096017524e24469a.camel@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Dovetail build error for arm(64)
Date: Mon, 31 Oct 2022 16:05:38 +0100
In-reply-to: <20be89e589cbdc9172533b4c096017524e24469a.camel@siemens.com>
Message-ID: <878rkw9goc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> seems that the latest commits in dovetail-rebase branches introduced a
> (build) regression.=C2=A0
>
> The following is taken from our internal CI infrastructure. Maybe we
> could/should extend the upstream dovetail CI to trigger the Xenomai-
> Images pipelines as well.
>
> I run the build for the 5.10 branch only, others might be affected
> too.

Fixed in all affected branches, thanks.

--=20
Philippe.
