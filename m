Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5043AB480
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513579; cv=none; b=cdh94eoLtcd0RjuLt9u6TySsS/s5lwoIwCatzE5UdyHvwpeQKRLUyGrtxIEDIKrCpT5ZHiZEzkOGWYmAbqMjKgU2iS4OofKSDVnbdGcwndJE/1S7iOcdQK/Ujqu3ujHKjRrIYffHcH3tnYoppEotVAfMisfr+x3G1p2da+99/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513579; c=relaxed/simple;
	bh=KxR+3xwO52UlxJpj53tZgh10nngEzf/BmkeWqmom5os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZks6FQlXEE7ymH0fSZ+NAAoKrfWyTq00xNv82wQh42K2TcRmDyPCcMbUvvqFPwF2C4o6+cEqq72ETTWuJ5PBLTEr/WwKn5ypxWZNQnKeb/N6xdtwyUPbqdmX7HMX4osjNidyaejH4sB7eNd0XvWlvIENVoR9oVIjTaT7oeligo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JvOrzUDn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JvOrzUDn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 863DF3EA04;
	Mon, 15 Jun 2026 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781513564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxR+3xwO52UlxJpj53tZgh10nngEzf/BmkeWqmom5os=;
	b=JvOrzUDnpyZAFeqDK3AMDtN6n4KRKd3V8CBsiajbT1eidd9OTQ+UtH0/HTC2/rEJ2o5wP4
	U+9EjguVfv1ZOoluQjIEUQrFqISO7Xq/gqrrAzWSg7otLBScfilUxJfLI9ZFgz6/UpfJUZ
	91iiXuZxbHhoM9uJFakK3ljFqxjyU9Qx3B/ipO2GXRBXSamUv8MAmLPUqawtddNuzkLim2
	I/S3TBx9jKRGq8PAbP3TefGnCneUWFJwNxAsdM61ZiA0J+oSZpWAyhEAdTas1UgY13MJvL
	a3mu5WfaMSBxEvtUXOjjmNrQaT9NL8naVQq3xohnVAOo82Av7fkIxpZeaesZZg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>,  Quirin Gylstorff
 <quirin.gylstorff@siemens.com>
Subject: Re: Possible Xenomai 3 latency regression on arm64
In-Reply-To: <28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 10:33:13 +0200")
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
	<87tsr4fe74.fsf@xenomai.org>
	<28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 10:52:44 +0200
Message-ID: <87cxxsfan7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEKhdIP1Qqo8zxf/COfeZNCzEZ3jAdYHbrs6DVF2LHy81umc9/eyqZc5/j5Hx3SsGOG7D06mHf/MdiFEtIw6nmTC+nBLeUd6iRGpzrVF5P3KJJS5soEZuAlg/8skH4UxRiHQYdR82p0KDZcbiBj8OqKTD3CyNJfdLmaTIvb3/lW1DQQ79UWkIYi0AyiRVLLuraneI9/aVu+4VYtQQKu4suN4QlcXLRvsqYq2QtIEIQwpIdoWNYe0QLAke9AA1YGsXPdwZ4UlLiRxKZmU0ZhFl9XOpyMxkxXu2KJ9gtLo1WluOak5IxPZlHOr09mDMoavPNkeKufyjOGdb9a6wfLNWIldlZ30BgEuDGcw1nI53/jFeRqa4Kyr2dGn8HeBgNdsbcyebdOxmlmn/F4g8aGQwQMTi0fnt8WFWQ4xOLIWp2ijaSFf7hwTzIUn7r++AH6E/yrYAyjMtwr3WMLZBJ50a6wJmd88Ty4I0m8QVowtHETXv10LPM9ZOc8FwzC92pXQjXSMnZtQGBOHJst5RWNz1/70q19Yw+feY4nbrliURLb7YeDEWu7HUbKhtEVbjarQ3PNCKAZ4zKZ4bMrjvmcXI+fTNZ4LP/5b0kASAV+G34TJHocYfmiAZYQ4EcRyrB4Jdlt86LzHnqM523NGvjT5/HCUjD7bVpZw8P+wp5efpMKUA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.06.26 09:35, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> Hi all,
>>>
>>> it seems we got some >10% worst-case latency increase over the last
>>> month with Xenomai head and 6.12 - that is at least the setup we use in
>>> our long-running weekly test.
>>>
>>> Tonight, the RPi4 test triggered by exceeding the configured limit of
>>> 150 =C2=B5s [1]. About half a year ago, we were in 130 =C2=B5s range wi=
th it [2].
>>> x86 and beaglebone are apparently not seeing this change.
>>>
>>=20
>> My rpi4 fried. Is the issue visible with x4 as well?
>>=20
>
> We do not have long-running latency tests for x4 yet, do we, Tobias?
>

Ok, I can try this on an odroid c4. Did anyone succeeded in booting a
mainline kernel on pi5? Last time I checked, root-over-nfs was not
possible yet.

--=20
Philippe.
