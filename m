Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C342288A4
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721733; cv=none; b=QCcqmGPhazkjSnO3UQXgm35EeFC7pUdRsSE2acGQ2M1QR2kBivhBOyu1ADJdKSjcu4Ae6Hyw5JjEzAOzyBpTIg1kXnhph62JP+Ur4q29fd9qZrBMsPmcO4Y195itQKHqxiZfTU7O+jSiwXUm3MFZs8jvZiycCB3xpotl6Nzq5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721733; c=relaxed/simple;
	bh=+/n8RdS6freN6CrlEEUrkRtPCM1Dm2lc04+14xLRY/Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ku1FtcfMa3cxfvWmaSxk6KBlkbLEd1tNvKoaVrqxr06zDVDVgVmi2gf3y9hsJbGbJXcgYo9UT6RzSrlBczqg3bLrxKBMg6xqHtHqCa/IFUgwMlQH/YsIW8/TbaQN2Ouh4VXT06ftF0LRrCTgYU3THlLryajv3AwZCngDZEjisZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UvzyDrfH; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UvzyDrfH"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240711181517da2e7736dec065b420
        for <xenomai@lists.linux.dev>;
        Thu, 11 Jul 2024 20:15:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=odZLbA+QYLXcntBzoZpfyCvz7HW2bdKi5pLu8CvEGhQ=;
 b=UvzyDrfHYuK8gkF7IvoLfRdeCxv9rYqWbqwXaTVkA4ZU5eG85JcnJIa29ATBeFFBJpff94
 YQgsJC1jaHXWJQkspP/oa/GlkJv5onXdSt+GoPs1/4xcAcq9BjfVEp34wbZO6FsvmpGu5vzH
 FbocfRsMVs5vLjR2kIHmAdpuUT9AQ=;
Message-ID: <10b0083c33b9854909c2a68223c24edb52a9c9ad.camel@siemens.com>
Subject: Re: [PATCH 27/33] drivers/stack/ipv4: Migrate from rtdm_printk()
 and printk() to pr_*()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 11 Jul 2024 20:15:15 +0200
In-Reply-To: <e04882ea-4d3f-431d-9e7a-6c48dc4c82b6@siemens.com>
References: 
	<20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
	 <20240702-flo-removal-of-rtdm_printk-v1-27-cc91bffdd063@siemens.com>
	 <e04882ea-4d3f-431d-9e7a-6c48dc4c82b6@siemens.com>
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

On Thu, 2024-07-11 at 18:14 +0200, Jan Kiszka wrote:
> On 03.07.24 15:25, Florian Bezdeka wrote:
> > Some (rtdm_)printk() calls were missing log level information. The
> > default log level (=3D warn) did not fit well for them.
> >=20
> > The missing log level is addressed by migrating to the pr_*() API.
> >=20
> > rtdm_printk() itself is just an alias for printk(). Migrating helps to
> > remove this function once all drivers were updated.
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  kernel/drivers/net/stack/ipv4/icmp.c           | 25 +++++------
> >  kernel/drivers/net/stack/ipv4/ip_fragment.c    | 17 +++----
> >  kernel/drivers/net/stack/ipv4/ip_input.c       |  4 +-
> >  kernel/drivers/net/stack/ipv4/protocol.c       |  4 +-
> >  kernel/drivers/net/stack/ipv4/route.c          | 21 ++++-----
> >  kernel/drivers/net/stack/ipv4/tcp/tcp.c        | 62 +++++++++++++-----=
--------
> >  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c |  9 ++--
> >  kernel/drivers/net/stack/ipv4/udp/udp.c        |  4 +-
> >  8 files changed, 73 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/=
stack/ipv4/icmp.c
> > index c3b80b18d..d96b4fc5d 100644
> > --- a/kernel/drivers/net/stack/ipv4/icmp.c
> > +++ b/kernel/drivers/net/stack/ipv4/icmp.c
> > @@ -24,6 +24,8 @@
> >   *
> >   */
> > =20
> > +#define pr_fmt(fmt) "RTnet: " fmt
> > +
> >  #include <linux/types.h>
> >  #include <linux/socket.h>
> >  #include <linux/in.h>
> > @@ -184,8 +186,7 @@ static void rt_icmp_send_reply(struct icmp_bxm *icm=
p_param, struct rtskb *skb)
> > =20
> >  	rtdev_dereference(rt.rtdev);
> > =20
> > -	RTNET_ASSERT(err =3D=3D 0,
> > -		     rtdm_printk("RTnet: %s() error in xmit\n", __FUNCTION__););
> > +	RTNET_ASSERT(err =3D=3D 0, pr_err("%s() error in xmit\n", __FUNCTION_=
_););
> >  	(void)err;
> >  }
> > =20
> > @@ -254,11 +255,10 @@ static int rt_icmp_glue_request_bits(const void *=
p, unsigned char *to,
> >  	unsigned long csum;
> > =20
> >  	/* TODO: add support for fragmented ICMP packets */
> > -	RTNET_ASSERT(
> > -		offset =3D=3D 0,
> > -		rtdm_printk("RTnet: %s() does not support fragmentation.\n",
> > +	RTNET_ASSERT(offset =3D=3D 0,
> > +		     pr_err("%s() does not support fragmentation.\n",
> >  			    __FUNCTION__);
> > -		return -1;);
> > +		     return -1;);
> > =20
> >  	csum =3D rtnet_csum_copy((void *)&icmp_param->head, to,
> >  			       icmp_param->head_len,
> > @@ -435,23 +435,22 @@ static void rt_icmp_rcv(struct rtskb *skb)
> > =20
> >  	/* check header sanity and don't accept fragmented packets */
> >  	if ((length < sizeof(struct icmphdr)) || (skb->next !=3D NULL)) {
> > -		rtdm_printk("RTnet: improper length in icmp packet\n");
> > +		pr_debug("improper length in icmp packet\n");
> >  		goto cleanup;
> >  	}
> > =20
> >  	if (ip_compute_csum((unsigned char *)icmpHdr, length)) {
> > -		rtdm_printk("RTnet: invalid checksum in icmp packet %d\n",
> > -			    length);
> > +		pr_debug("invalid checksum in icmp packet %d\n", length);
> >  		goto cleanup;
> >  	}
> > =20
> >  	if (!rtskb_pull(skb, sizeof(struct icmphdr))) {
> > -		rtdm_printk("RTnet: pull failed %p\n", (skb->sk));
> > +		pr_debug("pull failed %p\n", (skb->sk));
> >  		goto cleanup;
> >  	}
> > =20
> >  	if (icmpHdr->type > NR_ICMP_TYPES) {
> > -		rtdm_printk("RTnet: invalid icmp type\n");
> > +		pr_debug("invalid icmp type\n");
> >  		goto cleanup;
> >  	}
> > =20
> > @@ -467,7 +466,7 @@ cleanup:
> >   */
> >  static void rt_icmp_rcv_err(struct rtskb *skb)
> >  {
> > -	rtdm_printk("RTnet: rt_icmp_rcv err\n");
> > +	pr_err("rt_icmp_rcv err\n");
> >  }
> > =20
> >  /***
> > @@ -492,7 +491,7 @@ void __init rt_icmp_init(void)
> >  				   ICMP_REPLY_POOL_SIZE);
> >  	BUG_ON(skbs < 0);
> >  	if (skbs < ICMP_REPLY_POOL_SIZE)
> > -		printk("RTnet: allocated only %d icmp rtskbs\n", skbs);
> > +		pr_debug("allocated only %d icmp rtskbs\n", skbs);
> > =20
> >  	icmp_socket->prot.inet.tos =3D 0;
> >  	icmp_fd->refs =3D 1;
> > diff --git a/kernel/drivers/net/stack/ipv4/ip_fragment.c b/kernel/drive=
rs/net/stack/ipv4/ip_fragment.c
> > index 113a71238..d20cbf52b 100644
> > --- a/kernel/drivers/net/stack/ipv4/ip_fragment.c
> > +++ b/kernel/drivers/net/stack/ipv4/ip_fragment.c
> > @@ -19,6 +19,8 @@
> >   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> >   */
> > =20
> > +#define pr_fmt(fmt) "RTnet: " fmt
> > +
> >  #include <linux/module.h>
> >  #include <net/checksum.h>
> >  #include <net/ip.h>
> > @@ -96,7 +98,7 @@ static void alloc_collector(struct rtskb *skb, struct=
 rtsocket *sock)
> >  		rtdm_lock_put_irqrestore(&p_coll->frags.lock, context);
> >  	}
> > =20
> > -	rtdm_printk("RTnet: IP fragmentation - no collector available\n");
> > +	pr_err("IP fragmentation - no collector available\n");
> >  	kfree_rtskb(skb);
> >  }
> > =20
> > @@ -132,10 +134,9 @@ static struct rtskb *add_to_collector(struct rtskb=
 *skb, unsigned int offset,
> >  							 context);
> > =20
> >  #ifdef FRAG_DBG
> > -				rtdm_printk(
> > -					"RTnet: Compensation pool empty - IP fragments "
> > -					"dropped (saddr:%x, daddr:%x)\n",
> > -					iph->saddr, iph->daddr);
> > +				pr_err("Compensation pool empty - IP fragments "
> > +				       "dropped (saddr:%x, daddr:%x)\n",
> > +				       iph->saddr, iph->daddr);
> >  #endif
> > =20
> >  				kfree_rtskb(first_skb);
> > @@ -197,9 +198,9 @@ static struct rtskb *add_to_collector(struct rtskb =
*skb, unsigned int offset,
> >  #endif
> > =20
> >  #ifdef FRAG_DBG
> > -	rtdm_printk("RTnet: Unordered IP fragment (saddr:%x, daddr:%x)"
> > -		    " - dropped\n",
> > -		    iph->saddr, iph->daddr);
> > +	pr_info("Unordered IP fragment (saddr:%x, daddr:%x)"
> > +		" - dropped\n",
> > +		iph->saddr, iph->daddr);
> >  #endif
> > =20
> >  	kfree_rtskb(skb);
> > diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/=
net/stack/ipv4/ip_input.c
> > index 26642ef6f..933e38b56 100644
> > --- a/kernel/drivers/net/stack/ipv4/ip_input.c
> > +++ b/kernel/drivers/net/stack/ipv4/ip_input.c
> > @@ -21,6 +21,8 @@
> >   *
> >   */
> > =20
> > +#define pr_fmt(fmt) "RTnet: " fmt
> > +
> >  #include <linux/bitops.h>
> >  #include <net/checksum.h>
> >  #include <net/ip.h>
> > @@ -102,7 +104,7 @@ static inline void rt_ip_local_deliver(struct rtskb=
 *skb)
> >  #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
> >  	} else {
> >  		if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG))
> > -			rtdm_printk("RTnet: no protocol found\n");
> > +			pr_err("no protocol found\n");
> >  		kfree_rtskb(skb);
> >  	}
> >  }
> > diff --git a/kernel/drivers/net/stack/ipv4/protocol.c b/kernel/drivers/=
net/stack/ipv4/protocol.c
> > index f56177da8..bd74b05ba 100644
> > --- a/kernel/drivers/net/stack/ipv4/protocol.c
> > +++ b/kernel/drivers/net/stack/ipv4/protocol.c
> > @@ -23,6 +23,8 @@
> >   *
> >   */
> > =20
> > +#define pr_fmt(fmt) "RTnet: " fmt
> > +
> >  #include <linux/socket.h>
> >  #include <linux/in.h>
> > =20
> > @@ -80,7 +82,7 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
> >  	if ((prot !=3D NULL) && (prot->protocol =3D=3D protocol))
> >  		return prot->init_socket(fd);
> >  	else {
> > -		rtdm_printk("RTnet: protocol with id %d not found\n", protocol);
> > +		pr_err("protocol with id %d not found\n", protocol);
> > =20
> >  		return -ENOPROTOOPT;
> >  	}
> > diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net=
/stack/ipv4/route.c
> > index d9a9c8b9b..0863c9d03 100644
> > --- a/kernel/drivers/net/stack/ipv4/route.c
> > +++ b/kernel/drivers/net/stack/ipv4/route.c
> > @@ -22,6 +22,8 @@
> >   *
> >   */
> > =20
> > +#define pr_fmt(fmt) "RTnet: " fmt
> > +
> >  #include <linux/moduleparam.h>
> >  #include <net/ip.h>
> > =20
> > @@ -479,7 +481,7 @@ err2:
> >  	xnvfile_destroy_regular(&rtnet_ipv4_route_vfile);
> > =20
> >  err1:
> > -	printk("RTnet: unable to initialize /proc entries (route)\n");
> > +	pr_err("unable to initialize /proc entries (route)\n");
> >  	return err;
> >  }
> > =20
> > @@ -588,8 +590,7 @@ int rt_ip_route_add_host(u32 addr, unsigned char *d=
ev_addr,
> >  	} else {
> >  		rtdm_lock_put_irqrestore(&host_table_lock, context);
> > =20
> > -		/*ERRMSG*/ rtdm_printk(
> > -			"RTnet: no more host routes available\n");
> > +		/*ERRMSG*/ pr_err("no more host routes available\n");
>=20
> I think we can get rid of all those archaic /*ERRMSG*/ markers at that
> time. I don't call why exactly they were left behind, but the fact that
> these are error messages is now documented via pr_err.

ACK. Do you want me to do that on top or within this patch?

I can hopefully ship v2 tomorrow.

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

