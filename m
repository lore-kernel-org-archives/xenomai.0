Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889663B3
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:39:57 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2022113014395523b54d76bb551b0092
        for <xenomai@lists.linux.dev>;
        Wed, 30 Nov 2022 15:39:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7bqv8ASW5ojX6E8n/z9C5n7V0/js5e3nu/5cahotzqk=;
 b=b+sNDXbzY7kFlCCUfLW3ZlyixhVm98AeOiXUbDwn2/ZSUtk3ncAeTR2pF/D4isXmOwDzUT
 8QOv+E7fgwdWujRE5txobdkF+mGgM0oRTVx6bnfliy0dWTNw0wki3EEke9JggJsPwxosfdm+
 TfTaA+4pGA3QgchvtwviwZkpUxCGw=;
Message-ID: <cd369b2ca41fc5e058ba521eb2c2071a56be4416.camel@siemens.com>
Subject: Re: [PATCH 4/5] switchtest: Remove assertion after fault migration
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Wed, 30 Nov 2022 15:39:55 +0100
In-Reply-To: <20221130141134.2503172-5-tobias.schaffner@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
	 <20221130141134.2503172-5-tobias.schaffner@siemens.com>
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

On Wed, 2022-11-30 at 15:11 +0100, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>=20
> Faults in a xenomai syscall lead to a migration to secondary mode most bu=
t not
> all of the time. Do not assert that the migration worked but expect it to=
 work
> on next iteration of the test.

Seems this patch should be folded / squashed into the patch that
introduced this code.

>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/swi=
tchtest.c
> index f3737d193..970790b2e 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -309,7 +309,7 @@ static void _assert_primary_mode(char const * calling=
_func) {
>  #define assert_primary_mode() _assert_primary_mode(__func__)
> =20
>  static void _assert_secondary_mode(char const * calling_func) {
> -	if (!(cobalt_thread_mode() & (XNRELAX))) {
> +	if (! (cobalt_thread_mode() & (XNRELAX))) {
>  		fprintf(stderr, "Switch to secondary mode failed in %s.", calling_func=
);
>  		clean_exit(EXIT_FAILURE);
>  	}

We normally tend to ignore cosmetic changes.

> @@ -338,7 +338,12 @@ static void switch_to_secondary_mode_by_using_linux_=
syscall(void)
>  static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
>  {
>  	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
> -	assert_secondary_mode();
> +
> +	/* A fault in a xenomai syscall will lead to a migration most but not a=
ll
> +	   of the time.=20

I would be very interested in the reason why this doesn't happen all
the time. Please enlighten me ;-)

> +
> +	   assert_secondary_mode();
> +	*/
>  }
> =20
>  #define SWITCH_FUNC_COUNT 6

