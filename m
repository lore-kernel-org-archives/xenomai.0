Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DA6125
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 17:04:05 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6B1B6FF803;
	Mon,  5 Dec 2022 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670259843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wfez5Zk0omN/8nANdDQ6pzy8uYy3lypK1HQ53PgOLEI=;
	b=Z3QuXAQ50tRyWyAw6mUaYk2yuPzMbzmjO1JMDjMyCOljVcULC1fi4XlB4ddjBfZazHlK8r
	4yzqomUiUrry3WT+KMZoUnoYP9rFFIGE1nFsr8+A7toeWfUmV75in1ueNwOCoA3Y1gD5Z+
	rAMTySiFnIXQcuKCVfnQmEzmv5vDigWmrsphBzjQ0sY65AMdHZ/uHoIF6J3btR70vE2Ohd
	2ndpjuSGZmsc231sD3TyUemz7tA1paOYrxNsBNXd10qsINLuzsOTuS6XTgU69gCwzAJM+9
	DfuAlw76a3C5OCBSxI6uz/2LPt3eAeSaGh4GncJj8QERgJ578I16/ooLTSryYg==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87wn797rj3.fsf@xenomai.org>
 <PH1P110MB1050356B939910A6A0406B96E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87cz917m8z.fsf@xenomai.org>
 <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8mshg4n.fsf@xenomai.org> <87r0xgh4n2.fsf@xenomai.org>
 <87mt83zano.fsf@xenomai.org> <87iliryrgg.fsf@xenomai.org>
 <PH1P110MB1050A989B8056FC64EA8C093E2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050AFF2769662D3ED430659E2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87edtez1ih.fsf@xenomai.org>
 <PH1P110MB1050D16BD5BBF2713A9B1B80E2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB105075331395948D091FB38CE2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Mon, 05 Dec 2022 18:01:44 +0100
In-reply-to: <PH1P110MB105075331395948D091FB38CE2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87wn75ye7y.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Once I run as root, it works fine.. Sorry about the confusion.
>
> Thanks,
>
> Russell
>
> [[End of S/MIME Signed Part]]

Nevertheless evl-ps outputs confusing information in this case, if not
plain broken. Ok, I'll have a look.

Thanks,

-- 
Philippe.
