Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31145AD49
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 15:47:29 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 45C8915E2
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 45C8915E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1694533649; bh=dKPIkR0sh0PAE+cVH7CzYvKAqPTgVlNz0nolAmoevw4=;
	h=Date:From:To:In-Reply-To:References:From;
	b=yj8iXQ7EBV8I9N76j/jzQ4SMg7PbtAoWsWVneyqYberS7/5yYJ3qg62wgufxnHz0J
	 gtd+53yzbSNaPSvMr15NUDnZqLD+9d+izDdtCCfGP8oJKmlwpDO6db8pN5OISmrvVj
	 vg9XKV22CWRS3xbF5yMaWk02Oh9wu8kKJ1zF35mY=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 4134430004E
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 3DB991006B6
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 235631006B7
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 235631006B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1694533649;
	bh=dKPIkR0sh0PAE+cVH7CzYvKAqPTgVlNz0nolAmoevw4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=K7BePeGyQPbUaeAr20mlk6TCOOFhOcoUiWdUFmRIJQU6yao16zEqlb1T2k15uOM1P
	 k063eXSCrQ9XH7hQ1qWXvqophMN617gJOVDVi/9OVTAKG/Al6jqpCWhdL3Rk7+Q7oh
	 zVBvCLikNE84pWQqZLtSzxsc+n0lE0VqXlUu8LUE90KtLc6XJPkwtegardzat41Fem
	 aZSv+acFPvfrpF8gaXG7GGZVzDQLyOz0PYvaF3Aaj+XtfSbz6TKkAHsBolKoRlh6QR
	 io8E5Txvd3FSD/3+vRBUb3n485i12Ad8zo6EXwKqA4eGKJYZAZuL8f4O4xIXPnR//p
	 BjYM46MG5NUhA==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 16AiXMagrAho for <xenomai@lists.linux.dev>;
	Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 12D7A1006B6
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
Date: Tue, 12 Sep 2023 10:47:29 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <418657333.3203498.1694533649042.JavaMail.zimbra@wolfram.com>
In-Reply-To: <1727274074.3200069.1694532621162.JavaMail.zimbra@wolfram.com>
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com> <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com> <1727274074.3200069.1694532621162.JavaMail.zimbra@wolfram.com>
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
Thread-Index: zoiVbPfcXj13la9JIj/I4v2rft+EFdRf3QjG


----- Den 12 sep 2023, p=C3=A5 kl 17:30, Per =C3=96berg pero@wolfram.com sk=
rev:

> ----- Den 4 sep 2023, p=C3=A5 kl 14:20, Jan Kiszka jan.kiszka@siemens.com=
 skrev:

> > On 04.09.23 12:14, Per Oberg wrote:
> > > Hi

> >> I was looking at the Xenomai Wiki and noticed that there were some out=
dated
> > > information.

> > > E.g. :

> > > * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
> >> Dovetail, kernel git trees and recommendations are not mentioned. Ther=
e is a
> > > section on the powerpc part which I seem to remember has been depreca=
ted.

> > > * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
> >> Embedded Linux distributions & Xenomai points to ELDK which seems to b=
e no
> > > longer available.

> >> I think I might find some time update some of the stuff. What are the =
guidelines
> > > and procedure to contribute to th Wiki ?

> > The landing page(s) are being reworked right now, and that will widely
> > replace the wiki-based homepage. Will probably surface other issues. If
> > you like to check that instead: https://v3.xenomai.org. Feedback highly
> > appreciated!

> > Thanks,
> > Jan

> > --
> > Siemens AG, Technology
> > Linux Expert Center

> Thanks, I am currently looking at this and I will try to get back with fe=
edback
> and patches when I find the time.

> Some early notes:

> * It's a bit unclear the relation between dovetail and evl. It's not obvi=
ous
> that dovetail
> is available for Xenomai 3 depending on kernel version.

> * The Xenomai3 installation page [1] mixes "--ipipe" and "--dovetail" whe=
re
> "--ipipe"
> is used in the black box and "--dovetail" in the list below.

> * The installation page [1] only talkes about the "prepare-kernel.sh" app=
roach.
> I always
> found that approach a little error prone because it is necessary to find =
a
> kernel matching
> the version to patch. Perhaps it is better these days but for very specia=
l
> hardware it
> used to be hard to find the exakt version as time went by. So, it seems l=
ike the
> simpler
> approach is to check out the git-versioned variant available in the tree.
> Perhaps the
> installation page could mention the git-tree approach.

> [1] https://v3.xenomai.org/installation/

> Per =C3=96berg

Answering myself here...

What I meant with "The installation page [1] only talkes about the "prepare=
-kernel.sh" approach." was the use of "--ipipe" or "--dovetail" separately,=
 I think.=20

Per =C3=96berg=20


