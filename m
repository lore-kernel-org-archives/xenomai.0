Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6761FDB
	for <xenomai@lists.linux.dev>; Tue, 20 Dec 2022 12:47:45 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E9CD4D43AE
	for <xenomai@lists.linux.dev>; Tue, 20 Dec 2022 12:40:51 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5D885E0002
	for <xenomai@lists.linux.dev>; Tue, 20 Dec 2022 12:40:44 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 79A7874003C
	for <xenomai@xenomai.org>; Tue, 20 Dec 2022 12:40:43 +0000 (UTC)
Received: from zimbra90-e16.priv.proxad.net (unknown [172.20.243.145])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 7007178034D
	for <xenomai@xenomai.org>; Tue, 20 Dec 2022 13:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1671540043;
	bh=pVZ+JlalWx635H3tzt9tM09DIRW8/r511QC+iWuhcuQ=;
	h=Date:From:To:In-Reply-To:Subject:From;
	b=tT837ReltQWAIt/KvDzT4hSE7TlvnK+o+WeMjoCVl+Hnqz5N0AFrmiqa6TGy/S8gM
	 2by9jmf3supg5acjm6TrVuacuy33ILMQ+DJWlvUYNF1nhZgF3kEvOqgxxwo1qWehru
	 QQuR6AmjHVTGgAmq/UdZ9WDyaVxEkMlB5gGgj4b81RxWDKk86CxYtCHRgUefG8Q3Rc
	 is+zUZaR9wwG1mOTpWSIQkkBookimLjrntDH1rHSsgEGeecTfMIz1As/XmBQeuQ18j
	 X0a7lEvDBzzxrxQGLxiHKXk7R+tRqB0t4tlDYUupekNYxfuSD57nDl5ieb0HiWJlr4
	 cYODZSv79Rg2A==
Date: Tue, 20 Dec 2022 13:40:43 +0100 (CET)
From: hansen.franck1@free.fr
To: xenomai@xenomai.org
Message-ID: <1231689819.651785197.1671540043295.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <1360970257.651782515.1671539985508.JavaMail.root@zimbra90-e16.priv.proxad.net>
Subject: Re: Incompatible pointer type error when compiling kernel
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a04:cec0:10d8:335c:81e5:5a21:b6d6:b8f7]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: hansen.franck1@free.fr
Received-SPF: pass (spool2: domain of free.fr designates 212.27.42.6 as permitted sender) client-ip=212.27.42.6; envelope-from=hansen.franck1@free.fr; helo=smtp6-g21.free.fr;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=free.fr header.s=smtp-20201208 header.b=tT837Rel;
	spf=pass (spool.mail.gandi.net: domain of hansen.franck1@free.fr designates 212.27.42.6 as permitted sender) smtp.mailfrom=hansen.franck1@free.fr;
	dmarc=pass (policy=none) header.from=free.fr

You can test this :


        ....
	__prev = (xnstat_exectime_t *)atomic_long_xchg(((atomic_long_t *)&(sched)->current_account), (long)(new_account)); \
        ....


this work for me
Regards

Franck
