Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352041BD4FC
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716522; cv=none; b=LzbxMKX+rZufO7L+g91dAeQg2oVp+Ta7xV3j8eGl+cXiiSzgOgNYLw1DKmEgBnbtvC41xD6YKi3BLHm4/f6O5QLEdEXi+Rn4JfiyYfXl5GZYGTb5dQesgynqjL1ERZ5wqpswnED2lU4d1QT0TCrdPOfInQ5pd7Vnahivh8hWxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716522; c=relaxed/simple;
	bh=eLPbppWdvA92DzYRCPrmWgjicvWFhoCxKd4MggCQRs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8ViH53hrxBpKh8ozpU4+kkp6vnN+7asVNwlmMyRvkeuIDvH+LQ3vyTLhr4LRrcuJky4BiH5uYY8Hl+LfPvgpVneW0QgtUyVT6pFSe0686ZWNiEau917XinRXcV9JPMH9Pr0Q7IyIThXsPXBs3mv/pknz33bPUBmvIY4m0A+c+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=buU2SqeC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="buU2SqeC"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240815100819d1debe11c9a2d20e40
        for <xenomai@lists.linux.dev>;
        Thu, 15 Aug 2024 12:08:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eLPbppWdvA92DzYRCPrmWgjicvWFhoCxKd4MggCQRs4=;
 b=buU2SqeCFOMuQsPsstZtU0A2imUhlWAWtWCweGCRtUzM9Pufl2aKdKktST6j3dhbxhrCOl
 xfOvxD+t8z+Usgfr/A0CfZC/Uc9e1ptI94Lg9maeqyNbq6uYWNM+5Tg60r1i43MqQd3LMSQw
 H0NCY6tpNtJa+bQ6zCiNv9qqeingMVmvEdmRsr4uVJhwx8I9hCxXyyVfnC44TUL3Gdpt+rrT
 8/Ozgq3RTE6El+eJrYinEaUOjH8wlzaRa0yQjjZbUEfdvPET4ydXf2VzIBMhPTGni2XUzGWx
 3t8evvMlocwUr45cUw4ALFCgmz3pRH0yvTE1YMvd8ZapK4gAnOdGP16w==;
Message-ID: <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
Subject: Re: Xenomai Meetup at OSS Vienna in September
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	 <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 15 Aug 2024 12:08:14 +0200
In-Reply-To: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
References: 
	<CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Richard,

On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
> I expect that some members of the Xenomai community will be attending
> the upcoming Open Source Summit in Vienna. If there's enough interest,
> we could arrange an in-person community meeting at a local beer
> garden?

Nice idea! I will be there and yes, there is interest to meet.

I can already tell that Jan and me can not join on Thursday of the
conference week, 19th of September. Every other day should work on my
end (- can't speak for Jan though).

Florian

>=20
> --
> Thanks,
> //richard

