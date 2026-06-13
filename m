Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F1400DFE
	for <xenomai@lists.linux.dev>; Sat, 13 Jun 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370740; cv=none; b=tgNFPHmYrQU1asWTP++V6w72QS+ufmFLOpKwuvNMa8+9rhb2mLUP2/CT2DdMMbWFQa/bQhAGjWwbI7mDB+BVSW+67SBmgxRrznaUl3054B41uPglxH4on762Z8Q7z+61Cw2MOK6H/YKYYlMmILiNuCQo0IwLGrxWy8bW9y8L9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370740; c=relaxed/simple;
	bh=AcpRSCd1qK8Cg4vY+trDmun6w5scuZm+KKHyce9J5/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZeOHnX2vwP7pea0lmmJzhfyp5WdP+fGVPYtGQTR7K11+iPWjOIW4dnH0hCwWZcTCYNOHjV9/ZSfpQMAfeafvD/61kixF37a1QkSI4zR4gQTZPTHUYD7SqQ7HjsRC/EH4ZauoVAiJ4mCwprEKsYQ+Ba41ivjiOLjZyJTGou239Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=iELrsp3x; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="iELrsp3x"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A89853F523;
	Sat, 13 Jun 2026 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781370728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+xOsmLAq2I3y88u6twurQLDU6QazTsSZ8XQrENzNUB0=;
	b=iELrsp3xrYQI04YAl9MNF+o2P29uR4FbONb7xUWhhzeWntLudRvJpIzftn7Ll1PIAd1Vsf
	9TxHIXyuYRSp4sgiOu+6Y/SgOxGtNgUDkHB+zEUgQgZJoWvjw3e61SjvBn9kjN61ukxhRV
	H1NyFUe7uCMMnxTlVQcqAKRacIySt9v9Rlts5s+MiVPiPIReEQ8g+939Zl9bAn7VwFcdlY
	9FLp5pN19NJfmrEDzBgxgjSs9xSlQsmdi6cOZbEn7V7zAETsqEdkK4ftB7bh0qv13GVtQQ
	4hM59W0eRv2lqLgk6CfohX0qfH5RhA+aD8V2QFVGfKM6TfYd198HArGOrI9L+Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Call trap exit code with hard IRQs disabled
In-Reply-To: <20260612211719.3054905-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Fri, 12 Jun 2026 23:17:19 +0200")
References: <20260612211719.3054905-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Jun 2026 19:12:06 +0200
Message-ID: <874ij6tleh.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTE6N7SXzxHMleIui1ReVogiRwLQzyzkzacFm0Gvn4/V3wdcmSCkCbaKTLcRzLQQ9+nDi6LMph4DcGaZEy5DEKiZw5xFR7o29itmC7Zs+NwtewOmt/T3PBSrK5++WSNLA4Qh0u1U1YdBtiZTfuY4fo9BUhY7v152ZqfeECSxhPRRqm80oyEMjatKnHuoK7a3lqst/BFKq/4b6ZXXt8zOdKUZJcCZpk7xua9etpVwEO78vzW9BKSXDdPNhMF+w0wMvco7otI2TWamxAHYjinTYb+FvIE3i9GT/y0JXqGOzDVWehjejVWqRAHI9e61wmWEa1DRgGZO7FuE8df+DbSdRpBWo+Nopp2X7SdvzsezOB58ePDefiNPHZs09iqhFt8+JGcmcnRLLWOUNFvhFLEUlFBCSM5LJFd7boUCrrkdqggu4zOOCcDjg5GJw4Qqtg4KZ35KBP6Y8nQgiG6ONpidwLt/q5lSC5RVYa/vQlhDKHptY02eUY4MFV2zKiR1+o+uu0oGo41eVLdV3vfwI4qbc63hvBcXvKBgVyJMwgrT3PLuNA+lGJaeJeNbOcf74Jz/QNAM5NOXv9YkKEXbVvu0mijvrdvdW4JsEbAtvZE3PezR0YPSmtHW9j+zC9s1BXb/BC41GO02GEKVQOe7/poU1OAGBwgT+umaH0k/PgJA8ZuVNg
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> mark_trap_exit() should do the reverse operations of mark_trap_entry()
> keeping ordering in mind. Especially as oob_trap_unwind() is expecting
> hard IRQs to be off.
>

oob_trap_unwind() does not require irqs to be disabled,
__oob_trap_unwind() already takes care of this. However, we do want
oob_trap_unwind() to return with irqs off unconditionally because
handle_oob_trap_exit() might not ensure this. So the original ordering
is right.

-- 
Philippe.
