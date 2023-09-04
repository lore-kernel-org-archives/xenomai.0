Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A77ECA
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 07:12:39 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230904071237e3a7dbe3a8b008424b
        for <xenomai@lists.linux.dev>;
        Mon, 04 Sep 2023 09:12:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tsNi70rIAHmAopzcE54kb0lz+rcTVn62XjtQUF70FKE=;
 b=ZcP/xNCuqP5og500W1rBx5XzjKembaB+rIpnZMfr413lIEYShrUvVYtPykz3+X7A1IJ1rf
 hRoQw6G2NFDCMDn8VwIvlmxlmUaIJdcg8FbmTDvQH96sqWCcHH/KGykwhXj6AMUbfzzIsYz3
 qy2yoEJ9WwEkWxiLeJI3NSzLedefY=;
Message-ID: <28115494bbd7f93edf8f17bf6bb9c62c76aa0e11.camel@siemens.com>
Subject: Re: [PATCH 04/20] testsuite/smokey/y2038: Activate minimal
 clock_settime64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 04 Sep 2023 09:12:36 +0200
In-Reply-To: <c5c4fa95852cd25596d07beffb6d8664562c5370.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
	 <c5c4fa95852cd25596d07beffb6d8664562c5370.1693753497.git.jan.kiszka@siemens.com>
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

On Sun, 2023-09-03 at 17:04 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> The clock_settime64 syscall is theoretically still relevant, even with
> libc-based settime for standard clocks, but only for external clocks -
> which we do not have in-tree. But we can at least check that invalid
> parameters are detected and rejected
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 30 --------------------------
>  1 file changed, 30 deletions(-)
>=20
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2=
038/syscall-tests.c
> index 0c7de52161..3d4a9106bd 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -278,18 +278,9 @@ static int test_sc_cobalt_clock_settime64(void)
>  {
>  	int ret;
>  	int sc_nr =3D sc_cobalt_clock_settime64;
> -	struct xn_timespec64 ts64, now64;
> -	struct timespec now;
> -
> -	if (!cobalt_use_legacy_tsc())
> -		return 0; // Not implemented, nothing to test, success
> =20
>  	/* Make sure we don't crash because of NULL pointers */
>  	ret =3D XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> -	if (ret =3D=3D -ENOSYS) {
> -		smokey_note("clock_settime64: skipped. (no kernel support)");
> -		return 0; // Not implemented, nothing to test, success
> -	}

We could keep that. In case someone is running the testsuite against a
kernel not providing the syscall under test. Unlikely but possible.

>  	if (!smokey_assert(ret =3D=3D -EFAULT))
>  		return ret ? ret : -EINVAL;
> =20
> @@ -298,27 +289,6 @@ static int test_sc_cobalt_clock_settime64(void)
>  	if (!smokey_assert(ret =3D=3D -EFAULT))
>  		return ret ? ret : -EINVAL;
> =20
> -	ret =3D clock_gettime(CLOCK_REALTIME, &now);
> -	if (ret)
> -		return -errno;
> -
> -	/* Provide a valid 64bit timespec */
> -	ts64.tv_sec  =3D now.tv_sec + 1;
> -	ts64.tv_nsec =3D now.tv_nsec;
> -	ret =3D XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &ts64);
> -	if (!smokey_assert(!ret))
> -		return ret;
> -
> -	ret =3D clock_gettime(CLOCK_REALTIME, &now);
> -	if (ret)
> -		return -errno;
> -
> -	now64.tv_sec =3D now.tv_sec;
> -	now64.tv_nsec =3D now.tv_nsec;
> -
> -	if (ts_less(&now64, &ts64))
> -		smokey_warning("clock_settime() reported no error but no new time seen=
");
> -
>  	return 0;
>  }
> =20
> --=20
> 2.35.3
>=20

