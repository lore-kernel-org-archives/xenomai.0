Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CF3446B7
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510821; cv=none; b=SwEd0JfTt91AMWRtPJK0JFXL5q5bfQBlkARs1AxD+6tjD5k9KUgfUu4Rr+gQ2Dma4ww4bARr5jb/7EHxChAjNh9doCN4xB4mCUzkQkx+F4GdRwKAXuEJoq4Kn5lUWIHw1hE2zbIQv9ACzZRB8yHnXYZ+sdFHWTfbLVlLEzV8Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510821; c=relaxed/simple;
	bh=S60J43/vHggk3avmepRbjGZOWAYnjC45pIhQUEO+UV4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QGBiVQ46bvXqItWHHrNdbk7megwf0dPgJ6XHlEDNlc4doNx9PIphSKHMAIQ+PLQJ8beVwNKX3/fg2pEmXG5QYTTaR1ZINUejPDVqegg/FLRxzi0VBoq8taCwfzdItaYRuX5qZ0ZTtW1C3VBs1dfWDL1O4+oTnnxwCmF7Q2b3IIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7AB4D2C14AB;
	Tue, 27 Jan 2026 11:46:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LFk0UYQs4qkR; Tue, 27 Jan 2026 11:46:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EC5812C14B4;
	Tue, 27 Jan 2026 11:46:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TGXS16w7oFzC; Tue, 27 Jan 2026 11:46:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C13E72C14AB;
	Tue, 27 Jan 2026 11:46:55 +0100 (CET)
Date: Tue, 27 Jan 2026 11:46:55 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <71486589.18531.1769510815576.JavaMail.zimbra@nod.at>
In-Reply-To: <e0ae25a5-94b3-4d8b-8b92-faf40a5ed2eb@siemens.com>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at> <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com> <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at> <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com> <724391155.14329.1769456288068.JavaMail.zimbra@nod.at> <e0ae25a5-94b3-4d8b-8b92-faf40a5ed2eb@siemens.com>
Subject: Re: CPU Hotplug Splat
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: CPU Hotplug Splat
Thread-Index: xHlq1OEDYO4ceMwUWjs1GUc7gVx2PA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Regression, i.e. was 6.12 fine? And all it takes is some "echo 0 >
> /sys/devices/system/cpu/cpu1/online"?

I have v6.12 a try, seems to work. So it's a regression.
Yes, echo 0 > /sys/devices/system/cpu/cpu1/online is enough to trigger it.

Thanks,
//richard
