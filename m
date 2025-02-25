Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342024888F
	for <xenomai@lists.linux.dev>; Tue, 25 Feb 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491202; cv=none; b=uqRZWVNSlAu4Cvy8CjdsiTToyzeCHhllii/sEpn3zFJd2gCnCO9GDMI6eE0oT+01/EpJjATUxUyxC1a5R4TD7KxaR1vza9mRL5ZwSGTVy5xbEsFJWIOO+5KUNJh6rWB3jetU24CoasHc4moQbVpsYKqg/lZjGBUwkqESBP8hpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491202; c=relaxed/simple;
	bh=9CIcAv/SJF3OWvskI/TmtV7fDPOjCkKnF2ycVIfkbFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hPv6QRm52forY7dgGWAVO9Hs5PNDk1Oj2NGJGskOOgGBQce7rroxokC5j/Pc4Y3MB8wcb7Rp3oAk9WLRl745KBEoxj7f8W2jjjI6ZGMO2nwjnTfCoEsH7acylwS2bUCAGWoYszQuqZD6poKtHbGCFjh6A9JaTeEVkr4lMkA5Bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=eSfImvGX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="eSfImvGX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C67F74422D;
	Tue, 25 Feb 2025 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1740491198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Se6pBHe/0ooOVOL1RtHEpl9/Zm2MAT4vQEjop1Jx6o=;
	b=eSfImvGXDAfLyqAJitcjv0hJAo4FmkC1sAvlNysjeUiZw2AnKU6EfSoci2ABW2twug7xAP
	OkAU9H9Qr9hYc1LBRY/NDQ9WruQ/3+mW7DW3r93BIkhnHGBq4TknbAfqbn80CA+tuho3DJ
	n7SGVZiNLDhA3kqmpc74D4PjfxMfc8Us5CW0VnnZrXHGnppQr1OkHncQzmTdTuI2G4brAj
	CqzYn/RfxbTXgmYQ+Ltqfkwvj3xSngk5OANpGf7LiO2fWDG9APdnKLxYmgkcWO6P36Kf7n
	EY7ylI3pSTyxhKstibEEKhPmAL9hUstVTzlWrp1tXFY+gETDeZDmdUsSm8M/rQ==
From: Philippe Gerum <rpm@xenomai.org>
To: <akshay.vaghasiya@dlr.de>
Cc: <xenomai@lists.linux.dev>
Subject: Re: Header Conflicts Between C++ and Xenomai During Compilation
In-Reply-To: <49e5cf6ae5eb4687b0c1f6387e964cb6@dlr.de> (akshay vaghasiya's
	message of "Tue, 25 Feb 2025 13:21:32 +0000")
References: <49e5cf6ae5eb4687b0c1f6387e964cb6@dlr.de>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 14:46:37 +0100
Message-ID: <87jz9eyw5e.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghkshhhrgihrdhvrghghhgrshhihigrsegulhhrrdguvg
X-GND-Sasl: rpm@xenomai.org

<akshay.vaghasiya@dlr.de> writes:

> Hello Dear Xenomai supports,
>
> I hope this email finds you well.
>
> I am encountering issues while compiling a C++ application integrated
> with Xenomai 4, where the C++ headers conflict with the Xenomai kernel
> and user-space headers. Specifically, there are errors related to type
> definitions such as stdbool.h and bool, as well as undefined macros in
> the Xenomai kernel headers, like BITS_PER_LONG, ARM64_HAS_PAN, and
> __no_sanitize_or_inline. These conflicts seem to stem from mismatched
> header definitions between the standard C++ library and Xenomai's
> kernel-space headers, causing compilation failures.
>
> So far I have tried undefining the functions as // Ensure kernel headers are excluded in user-space code
> #define __NO_KERNEL_HEADERS
> #undef swap  // Undefine the kernel's swap macro to avoid conflicts
> #undef min   // Undefine the kernel's min macro to avoid conflicts
> #undef max   // Undefine the kernel's max macro to avoid conflicts, for some this fixes the uses but then I get the errors related to type definitions.
>
> Could you please advise on how to resolve these conflicts, particularly in regard to header definitions between C++ and Xenomai?
> Is there anything I need to update while configuration setup to make sure that tehre is no conflict between C++ and Xenomai headers

libevl does not use any kernel header. Could you please post the exact
errors as output by the compiler?

-- 
Philippe.
