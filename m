Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FF62D
	for <xenomai@lists.linux.dev>; Tue,  3 Oct 2023 07:10:09 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EBCDDD0643
	for <xenomai@lists.linux.dev>; Tue,  3 Oct 2023 07:06:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79DBB1BF20E;
	Tue,  3 Oct 2023 07:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1696316796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AleeyNyZK01KSroxhEVTHjgWdyPHh/ujS0jB8ji8UyI=;
	b=J5JC/NXLoUzXpEMgSWopxHBvtQc9UkIzf6vzXIbOC1hZ+5hj87KWiP6xkA+fJrMxO32ioY
	wosZyG7FmD8PRjmRQXs+yosPp5jCjby0VK9JfyYcR3qneIQbkFN1t52dho9dNCUe1Aa6SN
	SXWMTDx0HWKev35oWO3/ZNXG65kRsmfyxTAFnH9F2WLzR0Pm8PvzhC+ABvQcVysYzaxKib
	k5wsjpXl2Ax7B3MA4K/3PdGhM/Vv4FsU91vr+cwkDEy8y4E5i7kBHm2nMqyOgYJo08vgR+
	ZPdBFjIIUAmgXf2uoy6znVjCK1XmKmdzObJyG/DmIx5lpcLaKvGhZLywx77b4w==
References: <1cd875106cdf555e52734462a9d846ffd3549556.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 6.1.54: IRQ handler enables HW irqs
Date: Tue, 03 Oct 2023 08:56:08 +0200
In-reply-to: <1cd875106cdf555e52734462a9d846ffd3549556.camel@siemens.com>
Message-ID: <877co4rxqh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe, Hi Jan,
>
> I'm currently testing the latest Dovetail 6.1.x release, which is
> 6.1.54 to my best knowledge. 
>
> After updating I run into the following problem. There have been recent
> changes to the handling of per-cpu IRQs, that might be related.
>
> The problem occurs when using stress-ng to simulate system load when
> running on VirtualBox as VMM on a Windows Host. The Linux host is still
> running the test but might be affected too.
>
> The machine "dies"/"hangs" a few seconds after the first reporting.
>

Capturing a trace dump would help in debugging this, with
traceoff_on_warning set on the bootcmd line.

-- 
Philippe.
