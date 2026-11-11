Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439324;
	b=DaWcMT90cdL4jA7OuC9hwNeDpp0wJPic2xfTdas9RxwxcZJi7QymIMtq5CiqVfI6XN0w
	 MDZwpvgxUiiqgEmO3Gddxms93oDhuS/k4zUKQbo+dOJrSuGReuuVkQhQ7RsF+afBFTza3
	 Uax/z6N6ipJZQvQeYhpjTbiNF9WD9I+JVxEQy4Iwi09/UAZYmv4hQi19b5SNo2XjGjuVT
	 3A8njWExzXuBGFnh7oNoNS5GvqgLEmfZcuElMsMsn0DoNSctEGESnZJZ1rtyoem913u3S
	 a8to5dWd0KU0hofgGNm9gI2P43btVRucCivv539Skc9rNJksppJO8nbIDGinTLYEDEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439324;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=pqlaav4vIZ3vJm5HtpE5DXwux8KmFbY8KtUvWx2MJqo=;
	b=Rb+K3wLYF/bwkPBHF0EgSaPUBHQiOwimRsmk0s3wcvHlXlcPFM/b0TDgJxlryKklx5jf
	 dX56+qMx9jZFheXX4Lqgzi549MN3ktn6Fhhb6Bex7ZO31LFA31uMkxbz43StaVQbpwaw9
	 BSRVcUZpijXbgzOxN7AJtqemmKUhlwnzclQ4Y4WeP8CrwUZ4QeaDqVUOZ2gC+IdX24yZG
	 1wKOp+JL9IvWhcjdo1JiBy106mLu8wmUAvz62bw+qFliGySfk2wzLgDKRADXvX/8C9TiO
	 I6oKkIntnEiDChuQaf8RYOZGxR8AOKs7UfM9gDvWbn2YmlgmQ720J46s9geYkETxcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=P2AGDP6g;
	arc=none smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF8606A32D
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 23:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00BF8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=P2AGDP6g
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 0C59C3E9E9
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 23:22:01 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id AB6A556007D
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 23:22:00 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=P2AGDP6g;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20261111232159fd5a71ca88000207e1-hpv5tp@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-68982-20261111232159fd5a71ca88000207e1-hpv5tp@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261111232159fd5a71ca88000207e1
        for <xenomai@xenomai.org>;
        Thu, 12 Nov 2026 00:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pqlaav4vIZ3vJm5HtpE5DXwux8KmFbY8KtUvWx2MJqo=;
 b=P2AGDP6gZmUK16l1zR86grkfVTxFIF8beBST+HRON8PHiSwu53DwdYSEekHsCee9rwjyD2
 +8pHslJM13xTPrZuBNZZcBUxrRvbK2rAAimRvanCzsTUqpP7x/b71nZaSm5I1yMIPG8ydLW3
 W/bCbfASsFTXCH9z7ucuZ2yyETDIKJAZa+fo9bjKBo5i1vLexbsl45g8LYGsQHZtY42F/frn
 79LQNquGFwPyMua/1PKhmnhxhyIL0Da57WdhfW61za4x+SW5jfwKdfuLqLYtznoxZlnBCCfR
 9Ek37xXY52yP5+pxVrwwFrkgrJnAYE1Y9pxbxtmsCWNNUe/aXjJrK8dg==;
Message-ID: <9d863011b2e90b1562e5aef41394c683da5120bd.camel@siemens.com>
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	xenomai@xenomai.org
Date: Thu, 12 Nov 2026 00:21:59 +0100
In-Reply-To: <cover.1794399047.git.jan.kiszka@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-GND-Cause: dmFkZTF6kq7NyUUH3YyA/s1tont0Nte5JVTrQSkLWp69P6TNpoT5w6EslpOUg95b6B5yGoKDrOAs88jG0rdxSEfpxVnGUI2iXJK5ZKE2n9S/Eim3HO66tjlWYlzUALzFUUh8tCa3EzkQg2FCep/hOeIBpouzDqp6g0ZzrHIdMKBGg7aHLZEQPLL4YFTEOR5REugRerXMGCsKAzXk4YhWH6lqp5glHTBE0gOrmxuayBMTWgk1miYr4iz+OCb6IFZaQRGPFKAh2Ghf1IA5CaDP10AH/zqsCPrYnfAln6Df2W2XT4d/TQlYNGW3/w95pfNOcIEOQWY1o2GPORelyIklsxHXlA7wSI4GNyzKXpiRCj4IQ2J+KioDj5mhgSkLeJlDdDN6qDnzrjrnwvYSWOFy/HB92+9EYRsuDCRw+OPry6tJ5yfnDSqmXDrxkTDVrwpqyuEZ9gUZzXQ5dRKGqltK/jcM9MR88hZoUykIDa2044FYCvJw2+i09gjovKlqVtXqzq3FSi6PTsE8b/+w6eYv1Lub6/+jPBNy15BxsQAVN9p0qCD3YbU2qS732IQ0GDgfE4xUiu7ierD+rhbe+MJhGn77LIYnPzoosP74eYEYQrDD8yCZQ0s+uWptFJAEWYT7+ywNtEctYhVWUkBT1eKkCQh7J6s1paLb3el4ugC2MabaSqI7Fw
X-GND-State: clean
X-GND-Score: -100

On Wed, 2026-11-11 at 13:10 +0100, Jan Kiszka wrote:
> [v2: rebased without changes, resent due to delivery issues of v1]
>=20

While reviewing the risc-v implementation - and comparing it to all the
other archs - arm included - I already noticed some problematic cases in
arm.

I was able to address/fix some of them already, a couple of TODOs were
still on my list.

2/4 and 3/4 where on that list - with patches already prepared but
untested, so not published yet - 4/4 was not on the radar yet, 1/4 came
up while looking at the other reports. As this is a good coverage with
manual code inspection I'm quite sure we can trust the AI here.

The implementation looks sane. I'm a bit unsure about the comments in
the code, but can live with it.

Florian
