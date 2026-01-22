Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685A275870
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107472; cv=none; b=TimHfo5LrY1dMT6LiKlZ+RO4iXKdW9CvnkIztS3ATwy1RE96fFAeCFTrFm24rHSXH04pRw5v/KkPYs8DtmjSVsnPF5SdSpHjF0yrqwjH7zCV9u+FvXMdFiPu5tPemvKysc5gYmW2CLY5Jj2E+LeoRZjzTzslf8c9Hvq+8Q3OtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107472; c=relaxed/simple;
	bh=KhB46vTpkD4X8eWw71lBn0xOooMD6NPGTln/CPCf+FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWbkJuSa5IgOFc01UJV27eQTnRJZFQRElC5u6mK7n7fx2bZVDtO8UZ67YYqlVhIs21qmI+9tMMhNUAj3hcIA+2SJCcx/eTa/bK+RS/puK2u5xHgzSb3YVenvKblEBimb+fHgYgOMJy3hgHeQLq1hSXSfeWNwfEZ2D13alH9Rp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=AcIC36Td; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="AcIC36Td"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17238442E5;
	Thu, 22 Jan 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769107460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DCcNm4v7OSaVRNbjQuRKhCT6XqZctcP6aVd4+YGBmzc=;
	b=AcIC36TdDeZBJ/Pj00eenZ5Q5cwtAcAJEx14ss0FhDxTZX42VwH3htVnIcp3zQsdv8UHCI
	lU8H6G1XDyNPj50He16/IeIFczKFSYh+JTph5Ps5o0/jsRcsIdRAEYDGhXsLocRT951PnY
	K7sqH7Ext63+srZz1EapSmH06K1qnWdpx2axuqCJdiaJMayiK+tE7jf/mB7iK3UfhJPg7y
	BdF3fIH2gWFosmF1JCWmIBFfdbgVg4J8uWu7OTY2FfoXR6hPtvrDgT3GcTBX0fWNnm3eCZ
	JXE8j9MWsmmaiDxRnGp2weFYdGPUY4+42arYEy4o5b8Pi8iYow8jwm7cQBN16A==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl] evl-test: fix opt parsing ignoring shifts
In-Reply-To: <20260116084112.2303951-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 16 Jan 2026 09:41:12 +0100")
References: <20260116084112.2303951-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 19:44:19 +0100
Message-ID: <87wm19ij24.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepudejvdefkeeggedvgfehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> The for loop used for opt parsing copies the list before iterating over
> its elements. Use a while loop to make the shift calls work as expected.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  utils/evl-test | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/utils/evl-test b/utils/evl-test
> index 0d0ca81..f17a781 100644
> --- a/utils/evl-test
> +++ b/utils/evl-test
> @@ -18,12 +18,13 @@ test_args=false
>  test_arg_list=
>  test_list=
>  
> -for opt
> +while test $# -gt 0
>  do
>      if test x$test_args = xtrue; then
> -	test_arg_list="$test_arg_list $opt"
> +	test_arg_list="$test_arg_list $1"
> +	shift
>      else
> -	case "$opt" in
> +	case "$1" in
>  	    -k) keep_going=true;
>  		shift;;
>  	    -h) help=true;
> @@ -39,7 +40,8 @@ do
>  	        exit 0;;
>  	    -*) usage $0
>  		exit 1;;
> -	    *)  test_list="$test_list $(eval echo $EVL_TESTDIR/$opt)"
> +	    *)  test_list="$test_list $(eval echo $EVL_TESTDIR/$1)"
> +		shift;;
>  	esac
>      fi
>  done

Merged (along with the typo fix in the help string), thanks.

-- 
Philippe.
