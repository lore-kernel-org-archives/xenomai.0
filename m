Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F13AC33
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 15:20:00 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id D02BD6070
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com D02BD6070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1695827633; bh=S/V5mcSCYdRYL6clRB5RfeOSfgjZ0xlN9ZTJqnU+znA=;
	h=Date:From:To:From;
	b=1PxkvJG0Lqu4GYoxyAO2hk2I+3RuzODVn8dy1Onbnc1zHTAj+AHBY61+VLxQO+n4H
	 xRY1rIfxlBcRJ8paCSTShzHynhiGT+MAja2SsdseCS/A9lI3Ikh6SJusLdc+QqgDN7
	 1hErV1UysUqQ78+1omYXt1iDGF8oDRy2SXwO9lXY=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id CAE1C30004E
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id C6BD61006AF
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id ADBB11006C3
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com ADBB11006C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1695827633;
	bh=uO8qc18QVaRvGMjI0743aW0LXy4Pm8rYyJnYkrZ/XqM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=A6fbd/X9ZEyhVejlbsJn64exc+gsZjQhIQe+rIKjU3cDrqGIJk5MspyD4/c7NbyiR
	 jOnMKAU0rjm/rjt7ZfkFL25L1VwDrVXGPR7a0Hlde5BUfipKmQTH93w6+rlvIt8umh
	 TAmEoQjRuDGsU4iZ3I5s93xC9dwEE/zh8bVRBGKwyWjJbmMMGDzARedP4GmMB725wf
	 JMtlB4TlHtqQVhGqHbp7KmRR2jTi9B7YyqNA0lPRDPiv+BDE6wv9nhiA17S8Vkllik
	 4SGDbrS5/IF0QdbyfkZWgfEyc5JZoxV1/V1WErO16oGjtXlTZ6qlTmO9ltZrG0H80n
	 3nokkBXDwCxRA==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bKWAABr8lF6u for <xenomai@lists.linux.dev>;
	Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 859531006AF
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
Date: Wed, 27 Sep 2023 10:13:53 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
Subject: accept after select for RTNet/TCP
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
Thread-Index: 2zg8kbPctA5DuQ0Nzvdd4l+xftlVXg==
Thread-Topic: accept after select for RTNet/TCP

Hi=20

I'm currently porting parts of an application that uses some TCP during sta=
rtup to Xenomai. I have a working example of a TCP server but i cannot make=
 the "select" part work.

If I do=20

fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_addr, &client_l=
en)))

without the select part it works. If I do a select before it returns  "Inva=
lid argument".=20

The "select" part:
------------------------------------
fd_set in_fds;
FD_ZERO(&in_fds);
FD_SET(list_fd, &in_fds);
int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
(FD_ISSET(list_fd, &in_fds))
{
  printf("list_fd (%i)  is in FDSET\n", list_fd);
}
------------------------------------

The program works when compiled for regular linux.
Is select for TCP RTNet a no no ?


Best Regards
Per =C3=96berg=20

