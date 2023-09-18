Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53238F83
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 11:43:29 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 1F67B1A0003
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 11:43:22 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 312B9D80A38
	for <xenomai@xenomai.org>; Mon, 18 Sep 2023 11:43:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93F01E000B;
	Mon, 18 Sep 2023 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695037401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T62Uru8ypL6ftKXyfaPxS+chkudXWhd241KmRdwb+9k=;
	b=BhDP45hx0A2PMeR+Nlv1TjJtYkcjyV7/6plWAg9c8sQVJ+9N8yW80HMA3PKNRKHe9QEUxd
	5c84N0JzQTj1s70UUIgehM9e0WSHgdTnVyILdK3gzzlPRlIPONOc+dLp88dYAf0wwCZjuU
	bt1XoSWe0BqiyR2hAV0WCp8F0ZWQMXdOvQlo3Ol8DIeU7CnJ7aOm9etgHWHtzj9JRuH2d2
	DboCWyA6zu7B/TnGmZTlBdGY8vmjCz6lIudusBNJb+xOclQm00PaI3teE8DxHlzfmGDG2A
	DQNkplnyKJB/d82QWa2fu7re2VGqD3fJm7A9I+n1G8OIYBg371i7Mgq1xfteKg==
References: <2099512930.605027.1694630572180.ref@mail.yahoo.com>
 <2099512930.605027.1694630572180@mail.yahoo.com>
 <95d4f7a6-1237-4ae0-9fb6-3979fa058bcc@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
Subject: Re: Downloads and mailing list pages broken
Date: Mon, 18 Sep 2023 13:40:21 +0200
In-reply-to: <95d4f7a6-1237-4ae0-9fb6-3979fa058bcc@siemens.com>
Message-ID: <87a5tj7llz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=BhDP45hx;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::224 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 14.09.23 00:12, Alec Ari wrote:
>> The following links no longer work:
>> 
>> https://xenomai.org/downloads/
>> 
>> https://xenomai.org/downloads/xenomai/stable/
>> 
>> https://xenomai.org/mailman/listinfo
>> 
>> https://xenomai.org/mailman/listinfo/xenomai
>> 
>> Just letting you know.
>
> Yes, we rearranged things recently, see also [1].
>
> The mailing list moved to kernel.org a while ago, you now find it under
> [2]. Older downloads are now at [3].
>
> Philippe, setting aliases, specifically for historic download URLs, is
> not possible with the new hosting, right?

I'll ask. The landing page now has an 'Archive' button pointing at the
new location of the legacy Xenomai tarballs and I-pipe patches.

-- 
Philippe.
