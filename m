Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86371144D3A
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177772; cv=none; b=Tc//+GBA32HApaeCm1l1U1yDUiT2cauw8VnMMxjN6qSOTP6TtVGLzSQA1djpKMvPO6peDJITjiWbiy21Ew3jABixTTiMVwekuv53o9N7w1fqpuBRaItkgHgYzgqSzd0NwiVPf3e+NlRbbzC8KDUCwpJ0kFcBU2arEKVq04k4S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177772; c=relaxed/simple;
	bh=uAdqzTK/NPeBy6cVOlg/o+5e5OrqrGHK2hs3hUW5O4s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIOa6xAbk7dUL1cpO4uD2kElT7o5sVTVDhNee5kzanKYHYE540VQlVFde0S6d2qEs48Ptm1p1sg5v1ht/xYjwMf+xZURkChblXNvAOzuCEYE6Oa+T449XUNFerbxZvgNtRPO7GU9uM3whP047A7CAyk+6GTW7LzUSyP83MrT410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RPD3N06/; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RPD3N06/"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024070511091515873f3fe2a48b85af
        for <xenomai@lists.linux.dev>;
        Fri, 05 Jul 2024 13:09:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=okWJEc6vYGv4btHUIweDTEO6aryAasbRn2bDj0dxCsU=;
 b=RPD3N06/54O5BVYi0VAI8hu2vn8LF4x599WUnuqDnCSSkdwdDMzysiJS50Mr25HNIT7XR+
 KaYMF2/bxBIPrTUkBp6ykHLAk6V6nU5JZ1jEZ4+Osu2RiAnmhf85GEOMSLNoY99ZQrquBXzo
 GgxeYpk8DXV7Vci+AcLxMF9xz2QsA=;
Message-ID: <e5dfb611b7544f58adcdcac5e5f5051ab208df33.camel@siemens.com>
Subject: Re: [PATCH 03/33] drivers/analogy: Migrate from rtdm_printk() and
 printk() to pr_*()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 05 Jul 2024 13:09:14 +0200
In-Reply-To: <56a2015f-c36d-4836-9b63-881ff98dda24@siemens.com>
References: 
	<20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
	 <20240702-flo-removal-of-rtdm_printk-v1-3-cc91bffdd063@siemens.com>
	 <56a2015f-c36d-4836-9b63-881ff98dda24@siemens.com>
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

On Wed, 2024-07-03 at 18:49 +0200, Jan Kiszka wrote:
> On 03.07.24 15:25, Florian Bezdeka wrote:
> > There were a lot of (rtdm_)printk() calls with missing log level
> > information. The default level (=3D warn) does not fit well for most of
> > them.
> >=20
> > Adding log levels is addressed by migrating to the pr_*() API.
> >=20
> > No functional change.
>=20
> Besides the rewrapping topic below: By giving the outputs a log-level,
> you do have a functional change. Some messages may now only appear if
> the system is set to the right loglevel. Not agains the change, just
> against this statement.

Yep, I wanted to make clear that there are only log level changes, as
some of the patches are quite long.

I can rephrase that in v2.

>=20
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  | 16 ++---
> >  .../analogy/national_instruments/mio_common.c      |  3 +
> >  kernel/drivers/analogy/national_instruments/mite.c | 68 +++++++++++---=
--------
> >  .../drivers/analogy/national_instruments/ni_660x.c |  2 +
> >  .../drivers/analogy/national_instruments/ni_mio.h  |  2 +-
> >  .../drivers/analogy/national_instruments/ni_stc.h  | 19 +++---
> >  .../drivers/analogy/national_instruments/pcimio.c  | 21 +++----
> >  7 files changed, 69 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/includ=
e/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> > index 1de219f96..2adcb15b5 100644
> > --- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> > +++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> > @@ -35,14 +35,14 @@
> > =20
> >  #define RTDM_SUBCLASS_ANALOGY 0
> > =20
> > -#define __a4l_err(fmt, args...)  rtdm_printk(KERN_ERR A4L_PROMPT fmt, =
##args)
> > -#define __a4l_warn(fmt, args...) rtdm_printk(KERN_WARNING A4L_PROMPT f=
mt, ##args)
> > +#define __a4l_err(fmt, args...)  pr_err(A4L_PROMPT fmt, ##args)
> > +#define __a4l_warn(fmt, args...) pr_warn(A4L_PROMPT fmt, ##args)
> > =20
> >  #ifdef  CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
> >  #define __a4l_info(fmt, args...) trace_printk(fmt, ##args)
> >  #else
> > -#define __a4l_info(fmt, args...) 						\
> > -        rtdm_printk(KERN_INFO A4L_PROMPT "%s: " fmt, __FUNCTION__, ##a=
rgs)
> > +#define __a4l_info(fmt, args...) \
> > +	pr_info(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
> >  #endif
> > =20
> >  #ifdef CONFIG_XENO_DRIVERS_ANALOGY_DEBUG
> > @@ -53,10 +53,10 @@
> >  		trace_printk(fmt, ##args); 				\
> >  	} while (0)
> >  #else
> > -#define __a4l_dbg(level, debug, fmt, args...)						\
> > -	do {										\
> > -	if ((debug) >=3D (level))								\
> > -		rtdm_printk(KERN_DEBUG A4L_PROMPT "%s: " fmt, __FUNCTION__ , ##args)=
;	\
> > +#define __a4l_dbg(level, debug, fmt, args...)                         =
         \
> > +	do {                                                                 =
  \
> > +		if ((debug) >=3D (level))                                        \
> > +			pr_debug(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args); \
> >  	} while (0)
> >  #endif
> > =20
> > diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b=
/kernel/drivers/analogy/national_instruments/mio_common.c
> > index 7cd57ecf2..ae9af547a 100644
> > --- a/kernel/drivers/analogy/national_instruments/mio_common.c
> > +++ b/kernel/drivers/analogy/national_instruments/mio_common.c
> > @@ -42,6 +42,9 @@
> >   *   as yet. Terry Barnaby, BEAM Ltd.
> >   *
> >   */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include "../intel/8255.h"
> > diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kerne=
l/drivers/analogy/national_instruments/mite.c
> > index 2f2014bcd..736656f06 100644
> > --- a/kernel/drivers/analogy/national_instruments/mite.c
> > +++ b/kernel/drivers/analogy/national_instruments/mite.c
> > @@ -41,11 +41,13 @@
> >   * ISSUES:
> >   */
> > =20
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/module.h>
> >  #include "mite.h"
> > =20
> >  #ifdef CONFIG_DEBUG_MITE
> > -#define MDPRINTK(fmt, args...) rtdm_printk(fmt, ##args)
> > +#define MDPRINTK(fmt, args...) pr_debug(fmt, ##args)
> >  #else /* !CONFIG_DEBUG_MITE */
> >  #define MDPRINTK(fmt, args...)
> >  #endif /* CONFIG_DEBUG_MITE */
> > @@ -254,17 +256,14 @@ void a4l_mite_list_devices(void)
> >  {
> >  	struct list_head *this;
> > =20
> > -	printk("Analogy: MITE: Available NI device IDs:");
> > +	pr_info("Analogy: MITE: Available NI device IDs:\n");
> >  	list_for_each(this, &mite_devices) {
> >  		struct mite_struct *mite =3D
> >  			list_entry(this, struct mite_struct, list);
> > =20
> > -		printk(" 0x%04x", mite_device_id(mite));
> > -		if(mite->used)
> > -			printk("(used)");
> > +		pr_info(" 0x%04x%s\n", mite_device_id(mite),
> > +			mite->used ? " (used)" : "");
> >  	}
> > -
> > -	printk("\n");
>=20
> Hmm, no functional changes...? Is there a reason to rewrap the lines here=
...

I just merged two printk() calls into one. Other option would have been
to migrate to pr_cont() which is not SMP safe, so I tried to avoid
that.

We have a line for each device now, so the trailing printk() is not
needed anymore. Maybe I should follow the same pattern below.

>=20
> >  }
> > =20
> > =20
> > @@ -399,7 +398,7 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_=
ring *ring, struct a4l_subdev
> >  				   n_links * sizeof(struct mite_dma_descriptor),
> >  				   &ring->descriptors_dma_addr, GFP_ATOMIC);
> >  	if (!ring->descriptors) {
> > -		printk("MITE: ring buffer allocation failed\n");
> > +		pr_err("MITE: ring buffer allocation failed\n");
> >  		return -ENOMEM;
> >  	}
> >  	ring->n_links =3D n_links;
> > @@ -716,63 +715,62 @@ void a4l_mite_dump_regs(struct mite_channel *mite=
_chan)
> >  	unsigned long addr =3D 0;
> >  	unsigned long temp =3D 0;
> > =20
> > -	printk("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
> > -	printk("mite address is  =3D0x%08lx\n", mite_io_addr);
> > +	pr_info("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
> > +	pr_info("mite address is  =3D0x%08lx\n", mite_io_addr);
> > =20
> >  	addr =3D mite_io_addr + MITE_CHOR(mite_chan->channel);
> > -	printk("mite status[CHOR]at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[CHOR]at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_CHOR_strings, temp);
> >  	addr =3D mite_io_addr + MITE_CHCR(mite_chan->channel);
> > -	printk("mite status[CHCR]at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[CHCR]at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_CHCR_strings, temp);
> >  	addr =3D mite_io_addr + MITE_TCR(mite_chan->channel);
> > -	printk("mite status[TCR] at 0x%08lx =3D0x%08x\n", addr,
> > -	       readl((void *)addr));
> > +	pr_info("mite status[TCR] at 0x%08lx =3D0x%08x\n", addr,
> > +		readl((void *)addr));
> >  	addr =3D mite_io_addr + MITE_MCR(mite_chan->channel);
> > -	printk("mite status[MCR] at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[MCR] at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_MCR_strings, temp);
> > =20
> >  	addr =3D mite_io_addr + MITE_MAR(mite_chan->channel);
> > -	printk("mite status[MAR] at 0x%08lx =3D0x%08x\n", addr,
> > -	       readl((void *)addr));
> > +	pr_info("mite status[MAR] at 0x%08lx =3D0x%08x\n", addr,
> > +		readl((void *)addr));
> >  	addr =3D mite_io_addr + MITE_DCR(mite_chan->channel);
> > -	printk("mite status[DCR] at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[DCR] at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_DCR_strings, temp);
> >  	addr =3D mite_io_addr + MITE_DAR(mite_chan->channel);
> > -	printk("mite status[DAR] at 0x%08lx =3D0x%08x\n", addr,
> > -	       readl((void *)addr));
> > +	pr_info("mite status[DAR] at 0x%08lx =3D0x%08x\n", addr,
> > +		readl((void *)addr));
> >  	addr =3D mite_io_addr + MITE_LKCR(mite_chan->channel);
> > -	printk("mite status[LKCR]at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[LKCR]at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_LKCR_strings, temp);
> >  	addr =3D mite_io_addr + MITE_LKAR(mite_chan->channel);
> > -	printk("mite status[LKAR]at 0x%08lx =3D0x%08x\n", addr,
> > -	       readl((void *)addr));
> > +	pr_info("mite status[LKAR]at 0x%08lx =3D0x%08x\n", addr,
> > +		readl((void *)addr));
> > =20
> >  	addr =3D mite_io_addr + MITE_CHSR(mite_chan->channel);
> > -	printk("mite status[CHSR]at 0x%08lx =3D0x%08lx\n", addr, temp =3D
> > -	       readl((void *)addr));
> > +	pr_info("mite status[CHSR]at 0x%08lx =3D0x%08lx\n", addr,
> > +		temp =3D readl((void *)addr));
> >  	a4l_mite_decode(mite_CHSR_strings, temp);
> >  	addr =3D mite_io_addr + MITE_FCR(mite_chan->channel);
> > -	printk("mite status[FCR] at 0x%08lx =3D0x%08x\n\n", addr,
> > -	       readl((void *)addr));
> > +	pr_info("mite status[FCR] at 0x%08lx =3D0x%08x\n\n", addr,
> > +		readl((void *)addr));
> >  }
> > =20
> > -
> >  static void a4l_mite_decode(const char *const bit_str[], unsigned int =
bits)
> >  {
> >  	int i;
> > =20
> >  	for (i =3D 31; i >=3D 0; i--) {
> >  		if (bits & (1 << i)) {
> > -			printk(" %s", bit_str[i]);
> > +			pr_info(" %s", bit_str[i]);
> >  		}
> >  	}
> > -	printk("\n");
> > +	pr_info("\n");
>=20
> ...but not here?

I think this never worked as expected. I will apply the same pattern as
above in v2.

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

