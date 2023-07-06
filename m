Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E015A1
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:48:50 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230706074843f958962a0871485f82
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jul 2023 09:48:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y6s/nTEeMBQYwBuUR56hSU4iwkqR3F3uwBWZizoxz28=;
 b=NlDni/MEFusL68B/p0J/SJTt+3uLKnNpjk/NmAJj1VNL0Acd1xpmo9QvMlR7cZsBe7DGUh
 YelkKOyhZK34UJ7iUGb/F/H+3QkM1BVQkQgUHlDFeftQL/Xvmlm61hBTpAaRbNfLtq8kerFY
 fy3ZYvT5aO+jzOlOWUoSZe3Hss3YY=;
Message-ID: <bc9d6fe748fd6b67f024ed8bbb4f47e8bea26291.camel@siemens.com>
Subject: Re: [PATCH 01/12] y2038: cobalt: Introduce sched_param_ex64 and use
 it internally
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 06 Jul 2023 09:48:42 +0200
In-Reply-To: <aa889b3e-4b0d-66d7-8096-ae08a103274c@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
	 <aa889b3e-4b0d-66d7-8096-ae08a103274c@siemens.com>
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

On Thu, 2023-07-06 at 09:14 +0200, Jan Kiszka wrote:
> On 05.07.23 08:38, Florian Bezdeka wrote:
> > Introducing a new type sched_param_ex64. All members are (always) based
> > on time64_t. All internal APIs have been migrated now. Existing compat
> > and native system call entry points will do the necessary translation.
> >=20
> > This is a preparation step for introducing time64_t based cobalt thread
> > cobalt services.
>=20
> One "cobalt" too much here, I would say.

Grml. Yes! Something for v2.

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Competence Center Embedded Linux

