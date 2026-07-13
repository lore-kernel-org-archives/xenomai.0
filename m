Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21BC3563E1
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945654; cv=none; b=W1b5CU4p0+Vq6lN1JeDm/y0ZDLy4Yy4MGqMQ8Q4fYYc22o04nM+iDmF6LxGyj9WTOnbQhKEnevJS4lviBfKKfZfOBuBUwofkcgTfmIK9JrrjjCDM15xsDhssvNzOyPjXkLTfK85lguSSZ9pjjYijMMwhgl5RrMHxGgBQU1Ytp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945654; c=relaxed/simple;
	bh=gXGfYjh0r/Frq8PapplgClleQCKZII+8ji7UCnu+I3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRJo4GtchCA6I2Wm+EZ94nyT60xHKX12KRTHwplTYOwXoh6w+z5eo2XjNt48ga/eN7obsCK9lK6JAP+KO7njrdtpHSb3aMM/YOyglzfSpyXtWGwSrD+Hx+uTTrAHTXOnQ5nilAx8R+hnQpTa3vBCAZlccS8AdxzdbiMg/KWJhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YMnEWvqS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YMnEWvqS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C33141F6BE;
	Mon, 13 Jul 2026 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783945644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUgrD/QuIhpBk86u5ahCT2B3J9Uj9Vtpl2wVIC+FuJY=;
	b=YMnEWvqS6QX1O/utQv99BnR4jutSQiGKziYoh6xuJJuCiH/TQbXo/HKeBeMH1amRBnGkN9
	T3LQvQ6zGHpsvINQZNMRA47UcnDmHFRmqOA7IDFE5SysnYYVObfLJbXX5+ZqwRfXYD5I6t
	tGnSuQlUgNmWjZ1hQnevWHv6oZINGUIUXiyeWyZDBp5PXR4EmMXHd5OGmIjPoCq7Ck6Ivx
	y9ZsziGGvWEvfffmdAc3XzHpP4oReDJgd/5SfGeV3pUYHpR25OV/ANyjD24Wyb3BsPfx7x
	TDvwCUCol7MRqAgsIQUToZni99NyWWnmvV605d7x+2h1TnzMaObbgultHcNhDQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl] latmus: allow to disable max latency abort with
 -A 0
In-Reply-To: <20260713103911.34666-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Mon, 13 Jul 2026 12:39:11 +0200")
References: <20260713103911.34666-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Jul 2026 14:27:23 +0200
Message-ID: <87h5m35b2s.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFDzTHkKqS59RDPv6fO3HB1/rSr3IUradc6L+zCTc2XTLQL7/prreCmKSwrICxMj3vEM985b9AxL3b205uFGm3n6mYG9/0eEPQiAIcGaN827ChVwVy31G2DZANf0wuOPiMtwoHzvtynHf+qCH5IVq8OGajUBPW03RkNeo4Zx2yrDDx1z0BW7vGjuZ1WsuQAwVt8ILOt+73b8iXWAP4odt3jb4ju2QeTYE0EAKntxM95UrcWzRAlgeFP7jI7iQa2df1pkCVcsBtMw+zQz0VYgm/qYoIgp+uTaatIZA72gfRcyu8Hun2dS+pzEonsiO/sP1mqMyOLx8lO9j4nd653f0QZQpHvAKUfu82qirA1OqT1TfP4VP40m7TQ3PcU2OpYkou+pYR1WkTYfr9bSKVmbhL5QebF5arwmzITxgTscHJQO0D0I4n7YBVgRX89rSHd4/SgORZCT2TyBusFpV4NVMR0oKh+InG4EJ681eMFMGgFD4wJFkMpxEqSbiwAfC+qu2Meko5N9Cq1No9BV2UcwT4nZNGOHdqQznI2KN5qtz0A1EmbnJvx0bqWXAarF02n/ictJIs9G6PKWbyctaC4Uw7fFy+9huC0oQsipIZ7CEVORmxnxnhIrbkiH1GebJbt/dWsZq57YFIqRPyGS+RqCJnweowvggMpcRyesbTFgoVwsQ

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Accept -A 0 to explicitly disable the abort, matching the existing
> default-disabled semantics. This makes it easier to always pass -A
> in CI with a single sane default.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  latmus/latmus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/latmus/latmus.c b/latmus/latmus.c
> index 772cd9f..1bf1f95 100644
> --- a/latmus/latmus.c
> +++ b/latmus/latmus.c
> @@ -571,7 +571,7 @@ static void usage(void)
>          fprintf(stderr, "-r --reset                 reset core timer gravity to factory default\n");
>          fprintf(stderr, "-b --background            run in the background (daemon mode)\n");
>          fprintf(stderr, "-K --keep-going            keep going on unexpected switch to in-band mode\n");
> -        fprintf(stderr, "-A --max-abort=<us>        abort if maximum latency exceeds threshold\n");
> +        fprintf(stderr, "-A --max-abort=<us>        abort if maximum latency exceeds threshold, 0 = disabled [=0]\n");
>          fprintf(stderr, "-T --timeout=<t>[dhms]     stop measurement after <t> [d(ays)|h(ours)|m(inutes)|s(econds)]\n");
>          fprintf(stderr, "-v --verbose[=level]       set verbosity level [=1]\n");
>          fprintf(stderr, "-q --quiet                 quiet mode (i.e. --verbose=0)\n");
> @@ -669,7 +669,7 @@ int main(int argc, char *const argv[])
>  			break;
>  		case 'A':
>  			abort_threshold = atoi(optarg) * 1000; /* ns */
> -			if (abort_threshold <= 0)
> +			if (abort_threshold < 0)
>  				error(1, EINVAL, "invalid timeout");
>  			break;
>  		case 'T':

Merged, thanks.

-- 
Philippe.
