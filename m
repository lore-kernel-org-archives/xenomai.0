Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0CA45
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 06:14:48 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 589E11969
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 589E11969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1694585687; bh=FsDWq3f4PUQSjCc6g6bcVPL6DB4wjiKm2h/QulAYu9Q=;
	h=Date:From:To:In-Reply-To:References:From;
	b=xlDKkszqrozF2YIijJWPKjp6NQOfTd9aHhW+4uDW9PO6ujmhBIzHyUr2pd8BomA98
	 x6+Wq7OtBijJ9chguPkhYK2wUowyGX1SletX6fCdn53eLYCSZXgYggW5WJrruVZ1p7
	 XQO+EPo8kdSAvUXj+vA341aklVRhFG7+1khJxv7I=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 4FD8C30004E
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 4CB00100671
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 3082F1006B1
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 3082F1006B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1694585687;
	bh=FsDWq3f4PUQSjCc6g6bcVPL6DB4wjiKm2h/QulAYu9Q=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=CB8wnWI6JDSYZPQ2OkFN/L/DOtTlR/FpojjgQhIOBJmb4Y823n/5uF3uzkWtUE4/f
	 4z2GMpBmFY/D8QslwXLxct0IqHjUQYPQ5oGpfk4IOS/rtYGSldZXqLeit5fwfemrdf
	 wnR5h1r1hplKpabl0p1Gja0nb0O61pNNrMYUd8Y1yMIoVvx9fdxHgovWNYgchlcEwm
	 q9ILhYO4S4ApD2RoJ0ErJBCGiZ89Ls17XHENRlzJEAS4B+q6Rd+WFCNXkt2DxQ7/79
	 QNvaZS9+mikhu35h2olw9HGjyxc5AGJnf4DvqFxobwYOvSRBpDk2vYl8rdwczYksqF
	 wBV5y0lG0oaCA==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DK9TGrMPnHAw for <xenomai@lists.linux.dev>;
	Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 1ADEF100671
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
Date: Wed, 13 Sep 2023 01:14:47 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1565342606.3314781.1694585687078.JavaMail.zimbra@wolfram.com>
In-Reply-To: <23f187f0-44b0-4657-b137-c0fded0671f0@siemens.com>
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com> <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com> <1727274074.3200069.1694532621162.JavaMail.zimbra@wolfram.com> <418657333.3203498.1694533649042.JavaMail.zimbra@wolfram.com> <23f187f0-44b0-4657-b137-c0fded0671f0@siemens.com>
Subject: Re: Xenomai Wiki updates
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [46.59.13.250]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC116 (Linux)/9.0.0_GA_4478)
Thread-Topic: Xenomai Wiki updates
Thread-Index: 9mUJM7/TnxPmKlQRQpwVvSbbomqEPQ==


----- Den 12 sep 2023, p=C3=A5 kl 19:21, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 12.09.23 21:17, Per Oberg wrote:

> > ----- Den 12 sep 2023, p=C3=A5 kl 17:30, Per =C3=96berg pero@wolfram.co=
m skrev:

> >> ----- Den 4 sep 2023, p=C3=A5 kl 14:20, Jan Kiszka jan.kiszka@siemens.=
com skrev:

> >>> On 04.09.23 12:14, Per Oberg wrote:
> >>>> Hi

> >>>> I was looking at the Xenomai Wiki and noticed that there were some o=
utdated
> >>>> information.

> >>>> E.g. :

> >>>> * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_=
3
> >>>> Dovetail, kernel git trees and recommendations are not mentioned. Th=
ere is a
> >>>> section on the powerpc part which I seem to remember has been deprec=
ated.

> >>>> * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
> >>>> Embedded Linux distributions & Xenomai points to ELDK which seems to=
 be no
> >>>> longer available.

> >>>> I think I might find some time update some of the stuff. What are th=
e guidelines
> >>>> and procedure to contribute to th Wiki ?

> >>> The landing page(s) are being reworked right now, and that will widel=
y
> >>> replace the wiki-based homepage. Will probably surface other issues. =
If
> >>> you like to check that instead: https://v3.xenomai.org. Feedback high=
ly
> >>> appreciated!

> >>> Thanks,
> >>> Jan

> >>> --
> >>> Siemens AG, Technology
> >>> Linux Expert Center

> >> Thanks, I am currently looking at this and I will try to get back with=
 feedback
> >> and patches when I find the time.

> >> Some early notes:

> >> * It's a bit unclear the relation between dovetail and evl. It's not o=
bvious
> >> that dovetail
> >> is available for Xenomai 3 depending on kernel version.

> >> * The Xenomai3 installation page [1] mixes "--ipipe" and "--dovetail" =
where
> >> "--ipipe"
> >> is used in the black box and "--dovetail" in the list below.

> >> * The installation page [1] only talkes about the "prepare-kernel.sh" =
approach.
> >> I always
> >> found that approach a little error prone because it is necessary to fi=
nd a
> >> kernel matching
> >> the version to patch. Perhaps it is better these days but for very spe=
cial
> >> hardware it
> >> used to be hard to find the exakt version as time went by. So, it seem=
s like the
> >> simpler
> >> approach is to check out the git-versioned variant available in the tr=
ee.
> >> Perhaps the
> >> installation page could mention the git-tree approach.

> >> [1] https://v3.xenomai.org/installation/

> >> Per =C3=96berg

> > Answering myself here...

>> What I meant with "The installation page [1] only talkes about the
>> "prepare-kernel.sh" approach." was the use of "--ipipe" or "--dovetail"
> > separately, I think.

> > Per =C3=96berg


> Are you able to send merge requests against [0]? Otherwise, please send
> patches to the list, marking them as "[website][PATCH] ...".

> Thank a lot already for your findings!

> Jan

> [0]
> https://source.denx.de/Xenomai/website/-/blob/master/content/installation=
/_index.md?ref_type=3Dheads

> --
> Siemens AG, Technology
> Linux Expert Center

I will give it a go!

Thanks
Per =C3=96berg
