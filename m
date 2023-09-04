Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEA7E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 10:14:52 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 4AC645FF7
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 4AC645FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1693822486; bh=YRitSSoI1QfxZW+jVvx4N/sxaJD/fSBsgAeYoG8goac=;
	h=Date:From:To:From;
	b=lUOtS/JCUKJ30WF2woEOW8eDSDyZbe5MhqztuDWrcFUUnfUvbdCABQ7jmcIqbKNE3
	 YBE9XVM4YmvfTsnXb4MSeCQMXdK0qEuwNYbK20V/RQijvqct4wNhpeXddOW834Ccrz
	 V0xiaexOkkH/befTY136yPqngHq3nlKynWWOyp5M=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 46E2930004E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 43E59100672
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 262F91006B7
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 262F91006B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1693822486;
	bh=YRitSSoI1QfxZW+jVvx4N/sxaJD/fSBsgAeYoG8goac=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=bjwjpwdD1jJ3DAyvQSQL+S5Ra55MueV6IW8zFi/KSrvBXZttQihupONXQ0TFSn6D+
	 d+o/LF82NOfCRyu+bT8Y2KL4cJisaRk0iJqYKOOOjoGQrDtPgxotHKv6uAzsxoC3pm
	 m99KrminSAN+BdIyEoF8qPizOgHTctgr1R+l9iku3076+jQY66g1vGMkq8dbObQ3Q2
	 0buwZbOHuizdDGCcXw51U4WJ8YxGHXyvV8ozRGkornsuBVwFcJ5DCMJ0gfKT4kgzhg
	 +gaTZjODcvSYEp++bYCD8Fi7yAg3tQoT/6i1zDO4czRLX5NRqVFU/t1HpyoESw/BxL
	 n0HO2IiCt5v7Q==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sp717Pghzliq for <xenomai@lists.linux.dev>;
	Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 0CF53100672
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 05:14:46 -0500 (CDT)
Date: Mon, 4 Sep 2023 05:14:46 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <295930955.1965703.1693822486006.JavaMail.zimbra@wolfram.com>
Subject: Xenomai Wiki updates
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
Thread-Index: j0jDyxRCJI1fvbzeeDAkZbH5CK5uZQ==
Thread-Topic: Xenomai Wiki updates

Hi

I was looking at the Xenomai Wiki and noticed that there were some outdated=
 information.

E.g. :=20

* https://source.denx.de/Xenomai/xenomai/-/wikis/Installing_Xenomai_3
Dovetail, kernel git trees and recommendations are not mentioned. There is =
a section on the powerpc part which I seem to remember has been deprecated.=
=20

=20
* https://source.denx.de/Xenomai/xenomai/-/wikis/Start_Here
Embedded Linux distributions & Xenomai points to ELDK which seems to be no =
longer available.=20


I think I might find some time update some of the stuff. What are the guide=
lines and procedure to contribute to th Wiki ?

Per =C3=96berg=20
