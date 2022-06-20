Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DA7E6
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:56:21 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5B41E24000A;
	Mon, 20 Jun 2022 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1655708179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=delPbWRZpzeuWeECaAAJmU3g0Fy8dhNnhN5+3V/Wgvc=;
	b=jW7OSWGkHll8+hC7/ICJJ+ae1pMq+u9cx0ZpdiGvPpPNUe362ezfJ9RNHVnR+affzWWx9q
	K0nnram/RGOeKRN9AP+Pp+zwryc8Y7Nr3rl+r9ZVUuK27zYSV3C/Y4VqWAMxXg13HpTKu5
	xgtb1+5A6WvHQenL+It/uw/SFiul/Y7U9n+f58pFNZ4Cc5IBj347VvMNbly1AB0GsKJGCR
	BmTT/KoUJxwL8WbYA/OKm9dc7SUq19rFJn1RIJqVbcSsVevbg5o7k+TipeDVMMMxSiisqv
	P+SzdV/ZAKxqzKYs1AOyQ93wLFMLO/3TYVohdFLHDLeitfDe5SvTx+PwcHoA+w==
References: <875yky6idl.fsf@xenomai.org>
 <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
 <e644a78c-b8cb-edc6-7caa-9d6dde48fd20@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Mailing list enabled
Date: Mon, 20 Jun 2022 08:52:40 +0200
In-reply-to: <e644a78c-b8cb-edc6-7caa-9d6dde48fd20@siemens.com>
Message-ID: <8735fzkelp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.06.22 08:13, Jan Kiszka wrote:
>> On 18.06.22 18:11, Philippe Gerum wrote:
>>>
>>> The mailing list rehosting process is complete, welcome back.
>>>
>>> Unlike I previously announced, it looks like keeping xenomai@xenomai.org
>>> available for posting to this list via mail forwarding is not going to
>>> be possible. So please switch to xenomai@lists.linux.dev for this
>>> purpose, the information on the website has been updated accordingly.
>> 
>> Fairly inconvenient. What prevents this?
>> 
>> Did you already updated the ipipe release script accordingly? Just
>> pushed a 5.4 release, and it seems the announcement is not making it.
>> 
>> Thanks,
>> Jan
>> 
>
> Another question in this context: Will it be possible to migrate the
> archive? Would allow to retrieve the whole history from one source.
>

Yes, this is planned.

-- 
Philippe.
