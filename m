Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2831FFC48
	for <xenomai@lists.linux.dev>; Mon, 23 Feb 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853406; cv=none; b=nNWhxsxrBLVb6JZaowmSoTEdOvWY3gBzAIFw2YBP8cPXMpjSJ/0RxnZPnjLVoCKHAWLh3FDk1MvzVuKcxDKqM9eXYnMF/y/R+4PtePvaBP5Uwv/lPgS3qDqS7kde6Unm60Ekk+YRZNlpX7uqD7l1VUVzK5dRsdPi1zZUnnK5/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853406; c=relaxed/simple;
	bh=g8o+7X4HNZ1M3oEMJ40qdJ4dCioK94FPSdUCqA4UJuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgfraNUYqf+WtRWQL8fQR7T9Au60otQ9QgIMUamE8WGL+rjt3wCppa0n1RetA/f/NnPiZX7o/f5sPuGVJDpTelv70/ng8OKl+S3rdnY+LBYOaZkUGglQGCTYE94G2lqwNF9u7EDUYoonP6mxwZm/eRXV0vbgw95/FuGStJLZlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=jINaZmO8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="jINaZmO8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E869143B1A;
	Mon, 23 Feb 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771853396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86JfQjngoWXTal5fVbInpfyIj6gPfVYwtNaiGL3apLs=;
	b=jINaZmO8kXb+OGJnhNbx94ZdG51ytMz+MIwi03XaC0rcIA6xuuWqBFZwJaWiZsnij/wB3t
	bLdjSRuAxrkmybYrhxnbygGYL1pVkNAGtPVh8PfDe8liuaI6mYdTaFWy+JNf4BhkCRlToo
	FzYXkw5+Lt7d0EFAi1rEhM2JjESwTGEPF0b+9sep3CE7hLJkGUCxbbrO/dX7sDXH3acCFt
	islhsnibBODkAmHVC5+6GeQDABmuxOmYdp4EgiY/X1IlCj+HrTDI9GWAmcaLpAvEEOUP5G
	7XzfFxa1CLEUXp+VE3YTxjv/zlV8/pK/8wlUPZo8E4jqLKQPSoDre89tmSBfVQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: evl ps format output issues
In-Reply-To: <819e7e8f-59b8-621e-6e68-6bff28cbcd18@bela.io> (Giulio Moro's
	message of "Fri, 20 Feb 2026 13:14:11 -0500")
References: <819e7e8f-59b8-621e-6e68-6bff28cbcd18@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 23 Feb 2026 14:29:49 +0100
Message-ID: <87ikbnlh9u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfekieeludegfeeuudetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihho
X-GND-State: clean
X-GND-Score: -100

Giulio Moro <giulio@bela.io> writes:

> Hi there,
> when running evl ps -st there are some formatting issues that affect its machine-parseability:
>
> - the STAT column often is empty (I know this could be obviated by using `-n`)
> - if PID has 6 digits, then it will touch the ISW column and other columns also seem at risk of overflowing (very much a possibility for CTXSW, SYS and long running programs).
>
> The above issues make it hard to use `/ +/` without manually fixing things up to split evl ps's output.
>
> I suggest the following:
> - reduce the width of all fields (not already starting with whitespace) by 1, prepending each with a space. This ensures that / +/ splitting works.
> - change format_state() so that it always returns a non-empty string
>
> If these changes seem reasonable, I'd be happy to provide a patch.
>

Let's discuss this on a proposed patch directly.

-- 
Philippe.
