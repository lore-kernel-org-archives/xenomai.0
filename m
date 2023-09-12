Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FAA31
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 15:39:56 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 68AF615E2
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 68AF615E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1694532621; bh=L0qk6E3pkZFQogbjgp0uNBg312zVVt/bpJn0XeYhhV4=;
	h=Date:From:To:In-Reply-To:References:From;
	b=FZRqIgm61zIHAbNArpbpH1QFNSrjszli6pTTUDNLNMHZLAG9cXk3nqo/09omcxKMq
	 4wxptSAh9jIQ5d0tUoMicqkOq4H3k66K/g3HV2K/vEayBFr3YRLgvTK2V6GMrMHB3J
	 4WYWIS1JbFB1Wfk1wQjrMXYZPLyFXiKd/iK3Uxj8=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 6345030004E
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 5D04A1006B0
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 4272E1006C6
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 4272E1006C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1694532621;
	bh=F0hwuGxzk6OBt58vWrWF/s6Y28nNhxzNcyN15pFhsyQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=nS/qURKcTW8QRXFncF9sqme666olNltTe/LuMVbQdE3FgWJzytj0s5EBOmO1HY+b0
	 Cq8QkrYTOysJDk6c5axOnDcLWlw+cZySDsK9AGeKe+nmuGmzrzgmXYc9bJgnNRyam+
	 cUvQ2X+SeCKxP4Q+rUPRLHxP4YWS7H1ZQyahc+INpvZvz4rMGk+fftIyrhrV9nzuZg
	 o3S8kZQ63a5SR6is6Ucsyv48XzjafGPdTGwM6cen+6oqOn4kUN0Dnq8RjvsAXaG67x
	 SIw6IUybzeHVeevkJH1KOu6+eN+9D4XaD4u+rbXz6DurBK9clJ7g1iUjiA5n7E9w/U
	 Vx1B2sZd2QUsw==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kCHYnRIDZEEU for <xenomai@lists.linux.dev>;
	Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 2FB8F1006B0
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
Date: Tue, 12 Sep 2023 10:30:21 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1727274074.3200069.1694532621162.JavaMail.zimbra@wolfram.com>
In-Reply-To: <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com>
References: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com> <3787b663-bd66-41a6-8725-8d8a80b09cee@siemens.com>
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
Thread-Index: zoiVbPfcXj13la9JIj/I4v2rft+EFQ==


----- Den 4 sep 2023, p=C3=A5 kl 14:20, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 04.09.23 12:14, Per Oberg wrote:
> > Hi

>> I was looking at the Xenomai Wiki and noticed that there were some outda=
ted
> > information.

> > E.g. :

> > * https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
>> Dovetail, kernel git trees and recommendations are not mentioned. There =
is a
> > section on the powerpc part which I seem to remember has been deprecate=
d.


> > * https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
>> Embedded Linux distributions & Xenomai points to ELDK which seems to be =
no
> > longer available.


>> I think I might find some time update some of the stuff. What are the gu=
idelines
> > and procedure to contribute to th Wiki ?

> The landing page(s) are being reworked right now, and that will widely
> replace the wiki-based homepage. Will probably surface other issues. If
> you like to check that instead: https://v3.xenomai.org. Feedback highly
> appreciated!

> Thanks,
> Jan

> --
> Siemens AG, Technology
> Linux Expert Center

Thanks, I am currently looking at this and I will try to get back with feed=
back and patches when I find the time.=20

Some early notes:

* It's a bit unclear the relation between dovetail and evl. It's not obviou=
s that dovetail
   is available for Xenomai 3 depending on kernel version.

* The Xenomai3 installation page [1] mixes "--ipipe" and "--dovetail" where=
 "--ipipe"=20
  is used in the black box and "--dovetail" in the list below.=20

* The installation page [1] only talkes about the "prepare-kernel.sh" appro=
ach. I always=20
  found that approach a little error prone because it is necessary to find =
a kernel matching=20
  the version to patch. Perhaps it is better these days but for very specia=
l hardware it=20
  used to be hard to find the exakt version as time went by. So, it seems l=
ike the simpler=20
  approach is to check out the git-versioned variant available in the tree.=
 Perhaps the=20
  installation page could mention the git-tree approach.


[1] https://v3.xenomai.org/installation/


Per =C3=96berg=20

