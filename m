Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA97194A60
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997265; cv=none; b=Vf3E/nNDf0+UvGtAReOOV7Q1pPW/f6v6sesSil6uCs7DybX5aVpxW9H4cy+vsJKlOZ3jPsDtNke4puoKAg7tkMMQ0Pj1hcUBhtcw/ayhvF6xMuKXBAYYt5o7UqevVKgTIctJTPPLqH4DfLQmCkVuxOORkBTW2abCRQh1KnNfiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997265; c=relaxed/simple;
	bh=B24zKWvjayDaGcXcDJ9FOTc5ePxHqjgXSjAK7Jr1h3w=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=YxONCBenKcld4lHyyOIzJCmHzGnSyxaFCLXU2kvxj2u4FI63g9ytJNs7UX/LnizW5u9SQDMrHbtrV5c5RDrTUAw4EvN0nrgj0sBLKyFb4GrtKGvmq0yIQewuzkmLEUBauKa5Otej8XxLtRrK6wfDH23456imtqaNdk1bx9JJ2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xvq9A77n; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xvq9A77n"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026021315405213df475e0f000207f1
        for <xenomai@lists.linux.dev>;
        Fri, 13 Feb 2026 16:40:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=J9oYp5bhP0SIMdqVzccZMYDXqAySlLFU3mcRQzf8uxw=;
 b=Xvq9A77nkO2e03kUeRdZdfgwvLXFZE2YaeHECpEtQwOo4djwFAUlID//LRol3NPksit/Vv
 AHENniUl2u55s6WELWGb8qhHWb8XivS/GF6zZUuJNJvQdYyfZZA+0RhxNwEuO/fjPAEtx7Wg
 BVESdEowF6BnjjfwsunduBdNfU4x6EnkfieE4FYjQLmMfzF5XK/MYT7Eg+AFYeFdgQSavCfa
 d57VMEaXJd0yUq9HlegtRr0/FoetxPZ0TGZT/iOspeFW2lgbP9vOyOP5weTNbkrC1bTLnc9Q
 MNGL+SX7pz7IWQKeXNHQJ11AInX47CA9n1lN9f3DTZm6m/UsyOcP6uTw==;
Message-ID: <32f8c1523e0c4827a9f35f462d33199d3951307b.camel@siemens.com>
Subject: Dovetail 6.19 - Request for review / testing
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerume <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 13 Feb 2026 16:40:52 +0100
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

Hi all,

a first draft of Dovetail 6.19 has been pushed to [1].

The Xenomai3 testsuite should now build and run on all archs, I'm just
waiting for the CI systems to confirm that. Build and test jobs will
continue over the weekend.

Xenomai 3 needs some modifications to build successfully. Those changes
have been pushed to [2]. Once CI confirms a smooth state I will send
those patches out.

Any additional test / build / failure reports are highly appreciated.

Known API changements that will need adjustments on co-kernel side:
  - sock_oob_bind()
  - __request_percpu_irq()

Best regards,
Florian

[1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/wip/flo/v6.19-dovetail=
-rebase
[2] https://gitlab.com/Xenomai/xenomai3/xenomai/-/tree/wip/flo/prepare-for-=
6.19
