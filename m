Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6735B63B
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925720; cv=none; b=TeMXN3OnxnpzBdm2lypfTbOSRGaGUWRXgFhWWNMv46nIlTiVv8A4ZDTgu9+89ChMkW65iw8X4X5TiNn/LlRnAR0rRChfADuiv4VSluKYjlUGzNebiOxdsyULZDnArJ3iYF94ThhAXih+zpY3qLYA4w4B/eJbYDBqDAtKLDbSxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925720; c=relaxed/simple;
	bh=ikaByMKLCDVuFJOOz9CJZmUIP3n/VIPwNzQVrZntB5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXbuOMxAcpbW7oaPwJz+cChFCZKGttMvFS5cLXeB71OZpl5TtbHYed/IM/qlvZoVGhFueNsbT8n4YksiakCVnLPV6WFjLPbjDaP61ix7FPJddClftFjvpI9mABkkinUaodSjJ5osbsI+DPDgD/OGRcOW/gf5Y6NnUKlfIUFVbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PbYxvCZt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PbYxvCZt"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 818A43EDB7;
	Mon, 13 Jul 2026 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783925709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1v8zqaWfPe0kESmPbdrxCkKA9IGLfKD1L0EGce/hre4=;
	b=PbYxvCZty9oMsMGIeXh2gpfgDa68O/jOYFr1xXPg/lHuSDddBxEw5Y+JcXN94XYu2fxCpE
	KYlaPA/M+rM9XqzmpyFdBO6mLbElvprUf5tiZq531eCqT8uYzEC4ZIsctJbJDx0uy0kUkM
	YXGnBAMcLNp1nCX/jFA1DBiMPro0jMp5zJ+G7PKnpZysVLkKV+3mDCpTT0O7DESglJabYJ
	KMvdVQnYTUM0lD4hp+Pz4fFi4lrRtdpViRHVqwV2K+1e/PxaoUhWYIINByKnx8k4R8T4op
	Y+aw6kok+fZXhd/tDB9aqt/9iCUdQ06hC3cRLju1PTZXtYZm5OuiBqgbi+c/ZQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl v2 0/4] evl-test: stress load and latmus integration
In-Reply-To: <20260709143516.395611-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 9 Jul 2026 16:35:12 +0200")
References: <20260709143516.395611-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Jul 2026 08:54:53 +0200
Message-ID: <877bmz751e.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEa9uR43egCQzlslEB3/RDCXdeS1io0m+cu9Vc41LaIYk3FYrwYaaZ/jVt52ojIVtmV5iLOGzO+N1suZzyCdvMYIsLAZmgo38sA4HRxDYJ8V2uf1fNNFf5Dd+3+6OcvL+6RPXu0Nlw/y1sobTR7b5KrJR/rssOVLqIXYHE03+HLdtVvdgRffyztRu7sgleb/ZwZFC3gVLx5gJreHjXG+3Vww53bVjM1rJ3WuTNmpzMIMbtS1plCXNh/E4AP2TUw6DX9iqKwjMbqyVX7+gERzX6HDFK0pQfY8bpyO22gIGvExwK6Uj8cO6s6DPf0UyXjXo5+tcyxYHWWlNvGtFTOJwdWJfYuYWPtA+TewHxvKBC0aGG3VDuJbo3MxYMD5qc7dOQW6Alzt1tGZOfFJEAKHhTgDll6G6YDaW0yHQaKt8ZPuSUfmywbK0yhIQiJcTXOfMe7aYvNlK7pugKwgpfhj/Aojx5K93Q8yx+9s1TTZtuhdO/2JRm4NEtkl4G8Uc7vX/ftpnYV0tLP6dogAiEJ4zp7GLGswLPiKtOS2SsJ8CQzqar05Walg5ec4Phgk3Xr7W0uSy1nRXXSSteUoGe8fUsVviHOsiBHWynH4YUiUCZwwEjknINLPZE8AojukfjNFdOi7vZluKTXmNg8KEHzQn80bRbOlV2s+rF0os8CpnkSow
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Extend evl-test to exercise the system while the tests run and to
> measure latency at the end of a session.
>
> The motivation is to allow running the suite under stress in CI to
> surface bugs that only show up under load.
> latmus run under that same load and with a latency threshold will allow
> the pipeline to spot latency regressions.
>
> Example:
>
>   # run latmus under CPU/memory stress, fail above 200us,
>   # keep the latmus report
>   evl test --stress-cmd "stress-ng --cpu 4 --vm 2 --vm-bytes 1G" \
>            latmus -- -T 60 -A 200
>
> Changes since v1:
>  * Introduce a small shell script wrapper in the test dir to add latmus
>    to the testsuite instead of calling it in the end after the other tests.
>
> Tobias Schaffner (4):
>   evl-test: add stress command support for background load testing
>   evl-test: improve help message with detailed usage information
>   latmus: send setup messages to stdout instead of stderr
>   tests: Add latmus wrapper script for evl-test integration
>
>  latmus/latmus.c   |  4 ++--
>  tests/latmus      | 16 +++++++++++++
>  tests/meson.build | 11 +++++++++
>  utils/evl-test    | 57 ++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 85 insertions(+), 3 deletions(-)
>  create mode 100755 tests/latmus

Series merged, thanks.

-- 
Philippe.
