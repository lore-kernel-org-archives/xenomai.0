Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB673783BD
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161847; cv=none; b=fNHjIT7BPdx0z27RKupN4O1jE06coOaNiiPx3k95V+6Yp/4Y7lxEcF0M6XW1xbb2xZaQJQrpWVqOwbgIOIC/EE9fffxHuY9OVY41HY3L13AaavIbyGvQLBP7vlQsm5k190hSYepSMrhSn60EYa63XV0cvjIksHJSWYbW9ru4rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161847; c=relaxed/simple;
	bh=K1cv7zXydMFh9ly3hOCZ9eLPLRz1U+q4Sp1ICbn9iTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNk2GuwOuK33WPFnOCJnKnG3wlRCdsE6uuMyNC3AoypP5kt6Ec/MZ2rSQTpyzQqTXwdyAIfkUxKD6tVW/JRceA4SV4V/VIso9IRnSOTA1haT5x8uCI/mbgVPxwDv/I6p2hic3JHzX7yfvvbKn9a7U9R4+CZe/jWNYb2bUGRqT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=onWgeQJT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="onWgeQJT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D1574338E;
	Fri, 23 Jan 2026 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769161839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhMLf1MWhWnC4ijojZXbQQsb39OtgCSQ7pItEKHyM84=;
	b=onWgeQJTZaCBSDK/MaHMqNWx39JHFs186vyQY4LefzlnJ+0bDJs/kVcgisAhX91uwPW+uk
	QyuAbNFj2TFQCIJ8uzVOumhWBBC2Y8z/s4mPRLpMdxo+HGgkcoAQ+WoDc8UvXLYOy03UPM
	mIn443ZNDyQODlvev0TC/+2t+6sp2OdzHVX0APFGjTO1F+YceQ/weeHOtHHKP5K3Gf4X6W
	9tDXmV7yOpogTNdQ8JFvhvNskVWgohjWQBu94kKKUyMm/11BN2hjsCytitH12XaZaOxvSg
	LykyMnpSMcd8aS2fqUdByuF1eYXgkWmS8cvBdyhAYx0MDjYmW8ohc++q9yJaTw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH] tests: ptrace-sync: remove gdb prompt escape sequences
In-Reply-To: <20260123092531.1143219-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 23 Jan 2026 10:25:31 +0100")
References: <20260123092531.1143219-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Jan 2026 10:50:34 +0100
Message-ID: <87v7gs1wut.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepjeffudehjeegfeefkefgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> The readline escape sequences in the prompt bleed into gdb output,
> e.g. "\2Breakpoint 1 at 0x271a:", causing regex match failures.
>
> Remove the control sequences as they serve no purpose in pipe-based
> test automation anyway.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  tests/ptrace-sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/ptrace-sync.c b/tests/ptrace-sync.c
> index ec6fbb3..239c803 100644
> --- a/tests/ptrace-sync.c
> +++ b/tests/ptrace-sync.c
> @@ -137,7 +137,7 @@ static struct dialog {
>  	const char *expect;
>  	const char *send;
>  } dialog[] = {
> -	{ "^Reading symbols from .*", "set prompt \\001(gdb)\\n\\002" },
> +	{ "^Reading symbols from .*", "set prompt (gdb)\\n" },
>  	{ ".*(gdb).*", "set env __EVL_DEBUGGEE__=1" },
>  	{ "(gdb)", "b bp" },
>  	{ "^Breakpoint 1 at .*: bp\\.", "r" },

Merged, thanks.

-- 
Philippe.
