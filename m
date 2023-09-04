Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9517442D
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 12:51:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 575B31C000D;
	Mon,  4 Sep 2023 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693831900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZChMA0Rov776g65EJiqg4M3UT/AlBcRk2I4A3xYNTo4=;
	b=OFQYvylWU1laF5WIr2UYUnNGnbOzjbEiUKNnEH7ARQCwKu+sygfctNQcTFRkz0xFRcuQLd
	23KQWhDtxDQD2akCHwjAti27z4piOINZZV4Nm+HMybcgIyMdQkEEX6rugIQnoPXD/Vu2qq
	3P3TW9oSU+7c48Yi747bt7Ar2xUWhfbiu1T9WLPBjZ4rmloGDrLCRIjWPjFkxAeLmOQbW0
	93sdd9E3hUB1Vcb+U4y+HpHVDywcTdLPwmXWtelcsp72GD6n4asLHOb5s8GTZcQl+6qZcf
	Na7rEoJz3RlXgQxBmKM6N/DIfbYuB1MPJHioZlIkrAVbbC/1XSfiLd5KrXdv6Q==
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Per Oberg <pero@wolfram.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai Wiki updates
Date: Mon, 04 Sep 2023 14:35:01 +0200
In-reply-to: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
Message-ID: <87fs3up0dg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Per Oberg <pero@wolfram.com> writes:

> Hi
>
> I was looking at the Xenomai Wiki and noticed that there were some outdated information.
>
> E.g. : 
>
> * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
> Dovetail, kernel git trees and recommendations are not mentioned. There is a section on the powerpc part which I seem to remember has been deprecated. 
>
>  
> * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
> Embedded Linux distributions & Xenomai points to ELDK which seems to be no longer available. 
>

Significant updates to the v3 documentation is direly needed for sure.

>
> I think I might find some time update some of the stuff. What are the guidelines and procedure to contribute to th Wiki ?
>

The content of the upcoming website at v3.xenomai.org is maintained in a
git tree, which is now public. This is a Hugo generated (static) site
using the 'learn' theme, see [2][3]. Likewise for Xenomai 4/evl at
v4.xenomai.org, content available as a git tree from [4].

The workflow is pretty simple:

- apt/dnf install the 'hugo' package
- git clone the website repo
- make changes to $repo/content/*

hugo provides a local web server [5] serving the pages in $repo to a
local browser, which automatically renders any update live:

- cd $repo
- hugo server

The website should be accessible from localhost:1313.

Contributions are welcome, patches should be sent to this list.

[1] https://source.denx.de/Xenomai/website.git
[2] https://gohugo.io/
[3] https://learn.netlify.app/en/
[4] https://source.denx.de/Xenomai/xenomai4/website.git
[5] https://gohugo.io/commands/hugo_server/

-- 
Philippe.
