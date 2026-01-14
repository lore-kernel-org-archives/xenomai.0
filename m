Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670A163
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387341; cv=none; b=iLXfLZR25CCZfuOTHanIxP/QC8wmu5E9jnnORoQlNawvRNcFpME60FehSrx17pGAd4SqWdrUug2Fw1Sj+iY6D1kbv6I/GhryHqIbvDqHTi8X0J4osNljo3ksu1wRE2iEvd8v1ahMloE+lMNU9YOykh0dGX4f3q3g3XuwEpeLsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387341; c=relaxed/simple;
	bh=Jcbmctwl5Zb5jPI+9Cvvyak7vsgouPDWMFCqiVoktQ8=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=DKxcvtIlfDmpJsr9t/ymFERxkGk0AHJxxf5A+Qv02rz4W1d4I27R5O1eb/lALx9sH8VvHigmeESeij4qnJkvSqkL9TubBaI2fHWnZqGWM1vZk4WhlLRuBCCVTpJgXCsY18YoeiwEZW4ZaprAeaR456ZWU4P47/mRtQfcGJsCCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=F7SPPoN2; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="F7SPPoN2"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 8730660129;
	Wed, 14 Jan 2026 11:42:14 +0100 (CET)
Authentication-Results: smtp5-g21.free.fr;
	dkim=permerror header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.a=ed25519-sha256 header.s=default header.b=F7SPPoN2;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 60EAgCxL173328;
	Wed, 14 Jan 2026 11:42:13 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1768387333;
	bh=Jcbmctwl5Zb5jPI+9Cvvyak7vsgouPDWMFCqiVoktQ8=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=F7SPPoN23AN5YZUZJBcSYxeMfktOPCoUgRZojKwhIDn0R26ywLIJdJuaoNnKSyT6F
	 1V4Y7J4d/hAaLU2KPyNU1gh5ZBvAlIbQtFAoOpDNF5Vplu8zRnC9HAjLFl9FVDEfW9
	 YP9wIcuMl+9sz3PTuzSfGgMWIk0hh0tZYk0fDuj8JM9fWCGZB+hr3s4nr7NYP1SO/A
	 7hT8QGBTd+As6+wGAHrm7+i23JYwd50uHm1YPVIE8oAn5kaocE8yMiSKCu82Nojty4
	 gyp+ns6ElQJtGqCKzGpeK91PUCbRqSOy+vnUhnhrRBivGwDHBm1lBiulPwOCKPFkzt
	 jgx1oyA1H4Q3g==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <00cd175a-59fe-4cdc-8446-bda6624c8817@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.180.82
Date: Wed, 14 Jan 2026 11:42:12 +0100
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1320-69677300-11-384038c0@265651652>
Subject: =?utf-8?q?Re=3A?= [PATCH] add vlan detection on RTNET receive path
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Mercredi, Janvier 14, 2026 09:10 CET, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
 
> On 13.01.26 18:25, Fran=C3=A7ois Legal wrote:
> > This patch allows classifying the frame in the right protocol (skb-=
>protocol) when receiving an ethernet frame with a VLAN tag.
> > 
> > This allows to make raw PF=5FPACKET sockets be transparent to VLAN =
tagging when filtering on ethertype.
> > 
> > |    MAC Dest @    |     MAC Src @     | EtherType | VLAN TPID | VL=
AN TCI | Payload |
> > | 11:22:33:44:55:66 | FF:FF:FF:FF:FF:FF |     8100       |      080=
6     |    201B     |        ...    |
> > 
> > With this patch and  CONFIG=5FVLAN=5F8021Q set in kconfig, the pack=
et above will be classified as ARP (skb->protocol =3D 0806)
> 
> We generally avoided to bind RTnet settings to regular network stack
> configs, just to control them independently and avoid surprises on th=
e
> RTnet side when changing something on the Linux part.
> 

Ok. I'll submit a new version of the patch

> > 
> > The behaviour here is somewhat different from upstream as we dont s=
trip the tag from the frame (for performance reason) as upstream does i=
t and return the VLAN information as out of band (with recvmsg).
> > 
> 
> So, what is the envisioned use case with RTnet? How does the RX-side
> handling help when not doing anything special for TX? We should docum=
ent
> that as well.
> 

I use it in a data recorder app, where I want to capture some ethertype=
 traffic wether or not this ethertype is in a specific vlan or not.

Fran=C3=A7ois

> Jan
> 
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > --
> > diff --git a/kernel/drivers/net/stack/eth.c b/kernel/drivers/net/st=
ack/eth.c
> > index 427687f..9b3ad94 100644
> > --- a/kernel/drivers/net/stack/eth.c
> > +++ b/kernel/drivers/net/stack/eth.c
> > @@ -23,6 +23,9 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/skbuff.h>
> > +#ifdef CONFIG=5FVLAN=5F8021Q
> > +#include <linux/if=5Fvlan.h>
> > +#endif
> >  
> >  #include <rtdev.h>
> >  #include <rtnet=5Finternal.h>
> > @@ -107,8 +110,18 @@
> >  			skb->pkt=5Ftype =3D PACKET=5FOTHERHOST;
> >  	}
> >  
> > -	if (ntohs(eth->h=5Fproto) >=3D 1536)
> > +	if (ntohs(eth->h=5Fproto) >=3D 1536) {
> > +#ifdef CONFIG=5FVLAN=5F8021Q
> > +		if (eth->h=5Fproto =3D=3D htons (ETH=5FP=5F8021Q)) {
> > +			struct vlan=5Fhdr * vlan =3D (struct vlan=5Fhdr *) (skb->data);=

> > +			return vlan->h=5Fvlan=5Fencapsulated=5Fproto;
> > +		} else {
> > +			return eth->h=5Fproto;
> > +		}
> > +#else
> >  		return eth->h=5Fproto;
> > +#endif
> > +	}
> >  
> >  	rawp =3D skb->data;
> > 
> > 
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

