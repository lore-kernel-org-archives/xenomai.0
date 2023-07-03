Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE062DF6D
	for <xenomai@lists.linux.dev>; Mon,  3 Jul 2023 12:15:33 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023070312051772625e836be8ba5a3b
        for <xenomai@lists.linux.dev>;
        Mon, 03 Jul 2023 14:05:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aAod3f/I7zNNRBgGRv0sc4G6CTX58dGS6MLNPrijXpE=;
 b=fHD2Hk6WCCeKu5GQkRt4WVIG7AQKSup8gGyuRwAZGdOP+4Me650oezK2BGvZ8CE+zsajJU
 /Trozr7sn8spKgyTYAJu1VhBLHJeknxTpALjviNv4g6z/0GGupPx1AOyT3cGNwU1NwKu3dd0
 R/nr1NBwZ+Ir7PrNHnsXgOc2LNTE8=;
Message-ID: <5114f4c407bf3013afda322692bb3be6111bf17c.camel@siemens.com>
Subject: Difference in dovetail 6.1 branches
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Date: Mon, 03 Jul 2023 14:05:16 +0200
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

Hi Jan,

the upstream dovetail branches are currently based on different
versions:

v6.1.y-dovetail is on 6.1.26

while

v6.1.y-dovetail-rebase is on 6.1.34.

Is there a reason behind? Is the transition to 6.1.34 currently
blocked? I couldn't find a related and failed CI job.

I'm asking because an internal Debian based customer is asking for an
up to date Linux and Debian already ships 6.1.27. I would prefer .34 in
the "merge" branch. Any release planned?

Best regards,
Florian
