Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0728EA
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 06:33:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D1B0E0006
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1694586812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jgI2b+jEOc6p+8F979v+DJqnKSjxgU+YEyYnjOuw+jM=;
	b=oWWz4QJ/t8bWJEI2/3iFRdqxsz2IVHnjamoiWOLycz5kZ+QeqSI3A3IEHZqiRWvf2kxB8x
	Me/w93HyKoYkI9cY2+sMLRTPzKo8p6dJDUdq62OKxcyUbJoAfIQjAHU5TLFoNYiYScrm4g
	0yHquV+9/tVW/juY5JIr+dAlUDbwOYvPYNASPiuWlfXnyV+a+FO/DFnrGVEWYQ7Wz/77FX
	s+HQYF3dnndefJdlmGTjqwC0vrK9VMIb61JYZdSfWbvM7c6oYvckhyaembJceliA/Vb8zh
	zZQlROyqGOyGT4rUOh5l/wpCXQ/xXCUNzx8ABq4aQMWcn0shp7x7f8B8l8Kt9Q==
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: Xenomai websites
Date: Wed, 13 Sep 2023 08:09:32 +0200
Message-ID: <878r9atwev.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


As you might have noticed already, https://xenomai.org was revamped in
order to move Xenomai v4 [1] under the domain umbrella. Meanwhile, the
Xenomai v3 Wiki content moved to a Hugo-generated website [2].

Each site is backed by its own git tree, namely [3] for v3 and [4] for
v4. To contribute changes to these contents, please send patches on the
markdown files found there.

Thanks,

[1] v4.xenomai.org
[2] v3.xenomai.org
[3] https://source.denx.de/Xenomai/website
[4] https://source.denx.de/Xenomai/xenomai4/website

-- 
Philippe.
