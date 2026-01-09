Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018F35CB9A
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974846; cv=none; b=QtFGkZ6B0nr7DVy8HrgAxQppVr1Gf5eYHzPaerXXs8TsqOge3dEaOBDH0EY+AR9ipWdoF58ubO+f4E2iiiOSOU4xHDBvxfuVfV8P765rX5hVm5YIpLaMADNw6RUjrvVbYq0ejdHnM1Wg9zx6LjkXTFP7zfFaXF0d9TKp5Ai1Z8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974846; c=relaxed/simple;
	bh=4L0uELMvz8HUTjH4XjPKggcVkW/MbnxlKkeDZEK7fX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khkn6TK1sGQ2j2N9fJdHBhtSNJTglWrQ4SgWUauvslixwBWfHOKmKRZPDvrRDj/FuY2vV4KEAqS+FBGuKwShg9ezDYCwjZZ0BDJP39utLISwJRXbo5/ROmqng7SeuiWySkFSIAT8K4EkCJZgFwnaJhYnxaBGvL/Af+PWeT76pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=T8VkBuaN; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="T8VkBuaN"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DD7C35821D9
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 16:06:34 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16FC2201A1;
	Fri,  9 Jan 2026 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1767974787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/koOAGWqaJis5khx4WCqi4Y1QTAHgibHakxeJEUt/o=;
	b=T8VkBuaN7XV36ExVrznoGEPhOJQm5yY9gtYOpTpBRjlxx19MOPn5PSMNzLmd5b6UkgNzZA
	MVcI2Pezo2vuHRCSsw391SaZBHTDD5G4dtv8re5gFdwDDm2eFMKfG92TuMv8jJodmQFx8f
	kxVU1H3gvT5WxJFxPDyJYGiX1KPNWwgZZvvo+K8ExqMqI99FRg8GLE7pIwXvfAdbHBCOA8
	muXeeFUQ5u71AQsZtgqQhFeVpxN2+k/RaIEwK5aW6VqWIqMS1nSM0S/MU9KVWjRm6TjgTh
	AevBng8VWnnOsg5FUF+LHXQxLCNFo83E9A9sUK2AVHpmjQT/2EBKQPZKbRbEfQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl] evl-test: return non-zero status when tests fail
 with -k
In-Reply-To: <20260109143157.1102568-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 9 Jan 2026 15:31:57 +0100")
References: <20260109143157.1102568-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 09 Jan 2026 17:06:26 +0100
Message-ID: <87344ekby5.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepudeihfevvddvtddutedupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> The -k option of evl-test allows the test suite to continue running
> after a test failure. However, evl-test currently exits with status 0
> even if one or more tests have failed.
>
> Track the failure status and return a non-zero exit code when any test
> failed.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  utils/evl-test | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/utils/evl-test b/utils/evl-test
> index b2d3a7f..0d0ca81 100644
> --- a/utils/evl-test
> +++ b/utils/evl-test
> @@ -68,6 +68,8 @@ if test x$do_list = xtrue; then
>     exit 0
>  fi
>  
> +result=0
> +
>  for t in $test_list; do
>      test \! -x $t && echo "$(basename $0): $(basename $t): no such test" && exit 2
>      # Swap stdout<->stderr for the test, capturing stderr into $log.
> @@ -83,9 +85,10 @@ for t in $test_list; do
>  	    echo "$(basename $t): no kernel support"
>  	else
>  	    echo "** $(basename $t): BROKEN"
> -	    test x$keep_going = xfalse && exit $status
> +	    result=$status
> +	    test x$keep_going = xfalse && break
>  	fi
>      fi
>  done
>  
> -exit 0
> +exit $result

Merged, thanks.

-- 
Philippe.
