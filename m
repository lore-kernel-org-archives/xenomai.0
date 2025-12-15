Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793628727E
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765794513; cv=none; b=ruCyVsYU6n14Deehjrhul/oR8kxql4JvW3hnQFJTaJpEBB/0XkhxucZMk4EiRjYocOzx4imRD72PWteEeWvOneYPZnEscMwYfoCmdRi12fhgWfGbqSXQ/p53NV4d44FzWRkT23XbDPBr6nQawGY57IHlx9cQ2LybYZC7wc69XXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765794513; c=relaxed/simple;
	bh=jVRg/Sq0S6iGYOZZ0kS9t92FcjU0BFi4kg9E5jiP0JM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hi37/PTTD8peCXxqxxvn/9t+/zDF/G+1qPHKbffFjPSTIMweqh1ILSug5F7mcuVqs/RbZbGHMKAJ7uRV2qT+yem/nqdyorjwQYn3ks7I+ZcFCcyfEVcZ4+KdJyjOwQQL0slKDWNWQ6eKFoxq4a0hdcAT+fz8meujyPxgYl+FlUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bctp9m/h; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bctp9m/h"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251215102820146e03399a00020719
        for <xenomai@lists.linux.dev>;
        Mon, 15 Dec 2025 11:28:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8n95YUc5QsXz2mZlWvJMhidIGOYYlcsj6soCr7l9dMQ=;
 b=bctp9m/h5CLlIR6k51Hl0LRhmiz2iYuZN+VmHjF/WZpdQqG0zkw+ERzxAgiQxalXHtjcWU
 78MuJO9IlUIxUUBDGyc33ZpHB/d/K3IVo56kLzpB8hFCtzgbWzyrWM3YUJpU6DCOzfDrAeAS
 c+ykG65XLHjDig2dGR9VxhhD6STD/yLWUd7Uy7goLiqoxi0bMDpAo5bYzZWb3nJHI+kFdAEp
 4IWaY3BBOLrUD/zw3xZozQL7yX395hZ78N46kUE7H+OSjwwafmzjI4sRH+5Gioot4dxMKE5s
 VDUUxm4hw+NFTZvQ8ELITox/YupJaOs3YY59RJaHagMuNrpdwcjqGxcg==;
Message-ID: <19de2f5d6b7515054ead79a11c90767598a7c0c9.camel@siemens.com>
Subject: Re: [PATCH 6/6] testsuite/smokey/posix-select: Extend the testsuite
 by invalid timeouts
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
Date: Mon, 15 Dec 2025 11:28:20 +0100
In-Reply-To: <12fc2bb5-4abb-43fd-bcb3-ea7823501bd4@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
	 <20251204-flo-fix-select-syscall-v1-6-7f9c545a63ce@siemens.com>
	 <12fc2bb5-4abb-43fd-bcb3-ea7823501bd4@siemens.com>
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

On Mon, 2025-12-15 at 08:14 +0100, Jan Kiszka wrote:
> On 05.12.25 10:03, Florian Bezdeka wrote:
> > One corner case was missing a normalization about the timeout value
> > supplied to select(). Extending the testsuite to make sure we cover
> > that case as well.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  testsuite/smokey/posix-select/posix-select.c | 28 ++++++++++++++++++++=
++++++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/s=
mokey/posix-select/posix-select.c
> > index 154b3d730..6d1fcaa0d 100644
> > --- a/testsuite/smokey/posix-select/posix-select.c
> > +++ b/testsuite/smokey/posix-select/posix-select.c
> > @@ -143,6 +143,30 @@ out:
> >  	return ret;
> >  }
> > =20
> > +static int test_select_timeout(void)
> > +{
> > +	struct timeval tv;
> > +	int ret;
> > +
> > +	/* Invalid timeval, usec too big, normalization to 1 sec, 1 usec */
> > +	tv.tv_sec =3D 0;
> > +	tv.tv_usec =3D 1000 * 1000 + 1;
> > +
> > +	/* y2038 speciality ahead:
> > +	 * select() services provided by Linux and Cobalt both normalize the
> > +	 * timeout value before using it. pselect() services do not do that.
> > +	 *
> > +	 * As the select() service of libcobalt is routed to the pselect() of
> > +	 * Cobalt we have to do the normalization in userspace. The test belo=
w
> > +	 * is exactly stressing that case.
> > +	 */
> > +	ret =3D select(0, NULL, NULL, NULL, &tv);
> > +	if (!smokey_assert(ret =3D=3D 0))
> > +		return ret;
>=20
> This is checking that no error is returned but not that the timeout is
> actually > 1 s. Maybe use a much larger overflow and validate that as wel=
l?
>=20

We can't really check from userland that the overflow was correctly
handled. I will try to add a check that the select() call did not come
back to early. The upper boundary is obviously hard to test as we can't
predict the jitter on all the platforms in a generic way.

>=20
> > +
> > +	return 0;
> > +}
> > +
> >  static int run_posix_select(struct smokey_test *t, int argc, char *con=
st argv[])
> >  {
> >  	int ret;
> > @@ -151,5 +175,9 @@ static int run_posix_select(struct smokey_test *t, =
int argc, char *const argv[])
> >  	if (ret)
> >  		return ret;
> > =20
> > +	ret =3D test_select_timeout();
> > +	if (ret)
> > +		return ret;
> > +
> >  	return ret;
> >  }
>=20
