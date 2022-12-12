Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DF2F22
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 16:49:32 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20221212163921281bd7088ffa0512f6
        for <xenomai@lists.linux.dev>;
        Mon, 12 Dec 2022 17:39:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=J8M/LRb3LpdiNukMZ03seFjWKPljowjbXWKui/ssgqA=;
 b=hZJS0IzIdL1IzuEIu4F79QFghAD1ORraG7Xu+ZJRZhj4ZoJf7JTxKisXPqd9YCXgIaCOiV
 UjzEo3eS9sVtx4Z7wHCjDS1AfE7zNKP2th+jYA7ZyzhIhHJvWs6mX3+sK5eW+7Glbi33gmL0
 0LJEU/Atmj1pPTm/5WNfOCXs/8kKo=;
Message-ID: <9d5a712df42f12ccb691454e64aa47cd6d6ab63d.camel@siemens.com>
Subject: Re: [PATCH v3 3/3] switchtest: test mode switches while in kernel
 mode
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "T. Schaffner"
	 <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 12 Dec 2022 17:39:20 +0100
In-Reply-To: <d99de5a7-3c00-8c61-374d-5c0366c794b4@siemens.com>
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
	 <20221212121650.1294772-4-tobias.schaffner@siemens.com>
	 <d99de5a7-3c00-8c61-374d-5c0366c794b4@siemens.com>
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

On Mon, 2022-12-12 at 17:05 +0100, Jan Kiszka wrote:
> On 12.12.22 13:16, T. Schaffner wrote:
> > From: Tobias Schaffner <tobias.schaffner@siemens.com>
> >=20
> > Make the rtuo thread switch between primary and secondary mode while in=
 the
> > RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
> >=20
> > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > ---
> >  include/rtdm/uapi/testing.h         | 10 ++++++++++
> >  kernel/drivers/testing/switchtest.c |  8 ++++++++
> >  testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
> >  3 files changed, 38 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> > index f8207b8c7..c389cdc25 100644
> > --- a/include/rtdm/uapi/testing.h
> > +++ b/include/rtdm/uapi/testing.h
> > @@ -24,6 +24,7 @@
> >  #define _RTDM_UAPI_TESTING_H
> > =20
> >  #include <linux/types.h>
> > +#include <stdbool.h>
>=20
> Breaks latest kernel build, eg.
>=20
> https://source.denx.de/Xenomai/xenomai/-/jobs/541475
>=20
> Jan

This is due to a change in Linux 5.16 removing user-space
headers from the kernel include path:
https://git.kernel.org/linus/04e85bbf71c9072dcf0ad9a7150495d72461105c

Kernel code must use <linux/types.h> instead of <stdbool.h>.=20

>=20
> > =20
> >  #define RTTST_PROFILE_VER		2
> > =20
> > @@ -71,9 +72,18 @@ struct rttst_swtest_task {
> >  #define RTTST_SWTEST_USE_FPU		0x2 /* Only for kernel-space tasks. */
> >  #define RTTST_SWTEST_FREEZE		0x4 /* Only for kernel-space tasks. */
> > =20
> > +/**
> > + * @brief parameter for the RTTST_RTIOC_SWTEST_SWITCH_TO syscall
> > + * @anchor rttst_swtest_dir
> > + *
> > + * This structure is used to tell the RTTST_RTIOC_SWTEST_SWITCH_TO sys=
call
> > + * which threads should be exchanged and if the mode (primary/secondar=
y) of the
> > + * from thread should be switched.
> > + */
> >  struct rttst_swtest_dir {
> >  	unsigned int from;
> >  	unsigned int to;
> > +	bool switch_mode;
> >  };
> > =20
> >  struct rttst_swtest_error {
> > diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testi=
ng/switchtest.c
> > index 312b4d870..e2c0f4bcd 100644
> > --- a/kernel/drivers/testing/switchtest.c
> > +++ b/kernel/drivers/testing/switchtest.c
> > @@ -647,6 +647,10 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
> >  				    arg,
> >  				    sizeof(fromto));
> > =20
> > +		if (fromto.switch_mode) {
> > +			xnthread_harden();
> > +			return rtswitch_to_rt(ctx, fromto.from, fromto.to);
> > +		}
> >  		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
> > =20
> >  	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
> > @@ -701,6 +705,10 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
> >  				    arg,
> >  				    sizeof(fromto));
> > =20
> > +		if (fromto.switch_mode) {
> > +			xnthread_relax(0, 0);
> > +			return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
> > +		}
> >  		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
> > =20
> >  	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
> > diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/s=
witchtest.c
> > index b1a87b27e..cd6da2936 100644
> > --- a/testsuite/switchtest/switchtest.c
> > +++ b/testsuite/switchtest/switchtest.c
> > @@ -358,6 +358,9 @@ static void (*switch_funcs[SWITCH_FUNC_COUNT]) (voi=
d) =3D {
> >  	switch_to_primary_mode,
> >  };
> > =20
> > +/* Switch two times: primary to secondary and back from secondary to p=
rimary */
> > +#define MODE_SWITCHES_KERNEL 2
> > +
> >  static void *sleeper_switcher(void *cookie)
> >  {
> >  	struct task_params *param =3D (struct task_params *) cookie;
> > @@ -377,6 +380,7 @@ static void *sleeper_switcher(void *cookie)
> >  		clean_exit(EXIT_FAILURE);
> >  	}
> > =20
> > +	rtsw.switch_mode =3D false;
> >  	rtsw.from =3D param->swt.index;
> >  	to =3D param->swt.index;
> > =20
> > @@ -517,6 +521,7 @@ static void *rtup(void *cookie)
> >  		clean_exit(EXIT_FAILURE);
> >  	}
> > =20
> > +	rtsw.switch_mode =3D false;
> >  	rtsw.from =3D param->swt.index;
> >  	to =3D param->swt.index;
> > =20
> > @@ -598,6 +603,7 @@ static void *rtus(void *cookie)
> >  		clean_exit(EXIT_FAILURE);
> >  	}
> > =20
> > +	rtsw.switch_mode =3D false;
> >  	rtsw.from =3D param->swt.index;
> >  	to =3D param->swt.index;
> > =20
> > @@ -679,6 +685,7 @@ static void *rtuo(void *cookie)
> >  		clean_exit(EXIT_FAILURE);
> >  	}
> > =20
> > +	rtsw.switch_mode =3D false;
> >  	rtsw.from =3D param->swt.index;
> >  	to =3D param->swt.index;
> > =20
> > @@ -727,6 +734,9 @@ static void *rtuo(void *cookie)
> >  		while (err =3D=3D -1 && errno =3D=3D EINTR)
> >  			err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> > =20
> > +		/* Return to default: do not switch in syscall */
> > +		rtsw.switch_mode =3D false;
> > +
> >  		switch (err) {
> >  		case 0:
> >  			break;
> > @@ -746,8 +756,16 @@ static void *rtuo(void *cookie)
> >  		/* Switch between primary and secondary mode */
> >  		if (i % TASK_SWITCH_MODES =3D=3D TASK_SWITCH_MODE) {
> >  			uint switch_iteration =3D (i / TASK_SWITCH_MODES %
> > -				SWITCH_FUNC_COUNT);
> > -			switch_funcs[switch_iteration]();
> > +				(SWITCH_FUNC_COUNT + MODE_SWITCHES_KERNEL));
> > +
> > +			if (switch_iteration < SWITCH_FUNC_COUNT) {
> > +				switch_funcs[switch_iteration]();
> > +			} else {
> > +				/* Switch mode on next
> > +				 * RTTST_RTIOC_SWTEST_SWITCH_TO syscall */
> > +				rtsw.switch_mode =3D true;
> > +			}
> > +
> >  			mode =3D !mode;
> >  		}
> > =20
>=20

