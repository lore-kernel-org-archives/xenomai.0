Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBE34FF75
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325152; cv=none; b=W88KLoATIRtfKaDPzRTcmso644tPmf2XTOHSkm2M/lqet+QTRJe4m4ex7ND7NsidnYQNKLOLktTA+pVsG8/A3e1VOluH6j/ZKGnQlgOI61RCovPBYP0Shqsz+VVT75by+5ojHOvHmltP06UF4lD11wj1bwsWmIBJgUWyQd6VBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325152; c=relaxed/simple;
	bh=inNoL7/IWaahUwK1cCxw1+uQ46pw7Hmp6NsMpfpyayY=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=Epolxm5CGO5vhbdkROoVcBv4MIDoZjiPpjsW7LHBQVKwaQpFKLfgrZlxHTp0mI1dy72SjGLVdsfwAMuG1gyJ0jd6vrJ/YnBH4hNSASH6E74f2eoYOpt3JIl0cMxdBBLWyjGdR3RVkYhK/SqKIJAHC2JaLIUbYdip2EW+v8JIJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=ttmXHqwU; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="ttmXHqwU"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id A8C135FFC0
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 18:25:41 +0100 (CET)
Authentication-Results: smtp5-g21.free.fr;
	dkim=permerror header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.a=ed25519-sha256 header.s=default header.b=ttmXHqwU;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 60DHPeDP132941
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 18:25:40 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1768325141;
	bh=inNoL7/IWaahUwK1cCxw1+uQ46pw7Hmp6NsMpfpyayY=;
	h=From:To:Date:Subject;
	b=ttmXHqwUxHHVUiORWDhWrrqiF8mrOvJMhfj7NdtRWnPsB0mG7vbX1Othqj2WTQVPu
	 WkyT8Kb/ZP6ls+oWiUfVvAkNFAHCFUf3MBTKbBUNVKNZ3RynlUxJbCx2Q59sMHNNtd
	 cHzORRuBC5VpFgtJVovD1ucsTE3TSBer1CqkRf6WYDj+4jYzWxdm1ZXjzPc4fYusi3
	 QLjHfQF1+0F08GZp0fQRdQSjU8LLp+LEe/ucygEpA13g5m9ZL2o01F+rE3DIqL8Kcf
	 Zr3qlxJr0lf9GWrf2zkc+2DcGsxVdbol62/sUXhDOGeplIFJfdhL1j4HNWN//v//Q0
	 EoPyATVnavHpw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 13 Jan 2026 18:25:40 +0100
Subject: [PATCH] add vlan detection on RTNET receive path
Message-ID: <131f-69668000-3-a70b1c0@235185828>
X-Forward: 217.109.173.233, 147.161.180.82
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

This patch allows classifying the frame in the right protocol (skb->pro=
tocol) when receiving an ethernet frame with a VLAN tag.

This allows to make raw PF=5FPACKET sockets be transparent to VLAN tagg=
ing when filtering on ethertype.

|    MAC Dest @    |     MAC Src @     | EtherType | VLAN TPID | VLAN T=
CI | Payload |
| 11:22:33:44:55:66 | FF:FF:FF:FF:FF:FF |     8100       |      0806   =
  |    201B     |        ...    |

With this patch and  CONFIG=5FVLAN=5F8021Q set in kconfig, the packet a=
bove will be classified as ARP (skb->protocol =3D 0806)

The behaviour here is somewhat different from upstream as we dont strip=
 the tag from the frame (for performance reason) as upstream does it an=
d return the VLAN information as out of band (with recvmsg).

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
--
diff --git a/kernel/drivers/net/stack/eth.c b/kernel/drivers/net/stack/=
eth.c
index 427687f..9b3ad94 100644
--- a/kernel/drivers/net/stack/eth.c
+++ b/kernel/drivers/net/stack/eth.c
@@ -23,6 +23,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#ifdef CONFIG=5FVLAN=5F8021Q
+#include <linux/if=5Fvlan.h>
+#endif
 
 #include <rtdev.h>
 #include <rtnet=5Finternal.h>
@@ -107,8 +110,18 @@
 			skb->pkt=5Ftype =3D PACKET=5FOTHERHOST;
 	}
 
-	if (ntohs(eth->h=5Fproto) >=3D 1536)
+	if (ntohs(eth->h=5Fproto) >=3D 1536) {
+#ifdef CONFIG=5FVLAN=5F8021Q
+		if (eth->h=5Fproto =3D=3D htons (ETH=5FP=5F8021Q)) {
+			struct vlan=5Fhdr * vlan =3D (struct vlan=5Fhdr *) (skb->data);
+			return vlan->h=5Fvlan=5Fencapsulated=5Fproto;
+		} else {
+			return eth->h=5Fproto;
+		}
+#else
 		return eth->h=5Fproto;
+#endif
+	}
 
 	rawp =3D skb->data;

