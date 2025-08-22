Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136D1632C8
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846813; cv=none; b=Afg4X/g6fuhbLvqf2L8nUI7xx7cz/mTs1BK+GC7UFnCzpOwIbSySXl3gLost6b4x2Baxz1LgoaZ4WR7bq0FhIb54sr4qk6Wp5262kpk1uSHN7+ykDFwzmS8U6o5EW9rzFkzPx1ZAOvjdLrNBg82tp5uKZqc6UWrbraCm0uDYkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846813; c=relaxed/simple;
	bh=qjd849uhhlmgq9AVS3MKpoz4roSVEKI+sASo8U4f+fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJdDJ3BUW4kjvLHqucJnJdWEj06mX5iAM1ijrGj7GyIMFB3VAPmxeYll1r6+A2vFGsO0uCl9YQs9tqEA+1o5zQdLgAoVUORnHbYJBt6G0JSTTK+ZfKVG09j5Qqz9u7eFZFeZQBrTszTN9B3BEbhfE84NY65D5RJuOmoAfXotLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Cr4Nrt3j; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Cr4Nrt3j"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5ECA4442D0;
	Fri, 22 Aug 2025 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755846803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuKNd+BySqIwPUlKGj/gmUH3PQuK4blDqtcNx0+VYcs=;
	b=Cr4Nrt3jXPVcapyaIdk0mWCvQ4jd3IqWmv9lQ43HZ8bd5cf7SudAitMWrAFTAtbQHZhJ3p
	70mNgvxC9ujNcQfIoFCm7MDjQIGJrqvYE7G6ogdOIzG/qLRGCojNnhMfx8frtQ2BK5CTLj
	UHV6E3wl1Po52xQrQJUvXLx55UG+HNqV70zAMJTiReG5r2Ar3u3l4iCCT9fyjpDR5pSxNA
	+pq1qztql5p06jUTDpYS/GQDAF1omXdDj6XEgfHCffNzFcDAXgluItTH1L6h8+ulfaXuxq
	QnUgNN3edr/eeq030h0O10mm6YLYPkMBMwQtnmTHYDAOeSuJdUy4fT0ddZsrNA==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: xenomai4 - running applications as regular user
In-Reply-To: <a597e0a51e4adb69e3ff9041f83a67d588c861e6.camel@lapp.in2p3.fr>
	(Emmanuel Pacaud's message of "Thu, 21 Aug 2025 16:56:43 +0200")
References: <a597e0a51e4adb69e3ff9041f83a67d588c861e6.camel@lapp.in2p3.fr>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:13:17 +0200
Message-ID: <87plcnhlrm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevueeigeeuteegleevheeifeevveeufeevvefhjedvteeihfevgfejheeifeetheenucffohhmrghinhepgigvnhhomhgrihdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghmmhgrnhhuvghlrdhprggtrghuugeslhgrphhprdhinhdvphefrdhfrh

Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> [1. text/markdown]
> Hi,
>
> What is the recommended way to run out of band applications as regular user using xenomai4 ?
>
> In xenomai3 documentation, there is a dedicated page about this, <https://v3.xenomai.org/tips/regular-user/>, but I did not find similar instructions in xenomai4 version.
>
> Emmanuel.

See https://v4.xenomai.org/core/user-api/#device-ownership-and-access

-- 
Philippe.
