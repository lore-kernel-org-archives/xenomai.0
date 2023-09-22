Received: from mail-01-1.mymagenta.at (mail-01-1.mymagenta.at [80.109.253.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577081E518
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 09:42:42 +0000 (UTC)
Received: from [192.168.232.135] (helo=ren-mail-psmtp-mg01.)
	by mail-01.mymagenta.at with esmtp (Exim 4.93)
	(envelope-from <martin.elshuber@chello.at>)
	id 1qjc2R-008PIY-5l
	for xenomai@lists.linux.dev; Fri, 22 Sep 2023 11:01:27 +0200
Received: from theobroma-systems.com
 ([IPv6:2001:871:22c:e819:e254:4206:be7a:b595])
	by ren-mail-psmtp-mg01. with ESMTPA
	id jc2FquadbeboCjc2Oqq5iV; Fri, 22 Sep 2023 11:01:24 +0200
X-Env-Mailfrom: martin.elshuber@chello.at
X-Env-Rcptto: xenomai@lists.linux.dev
X-SourceIP: 2001:871:22c:e819:e254:4206:be7a:b595
X-CNFS-Analysis: v=2.4 cv=c5PI/Txl c=1 sm=1 tr=0 ts=650d57e4
 a=hJFyE5+EYuf3O8AJ+kz6Ug==:617 a=xqWC_Br6kY4A:10 a=NXpJzYs8AAAA:8
 a=Cvq3sMK4KJuAEpzDRPMA:9 a=cwV61pgf2j4Cq8VD9hE_:22
X-Authenticated-Sender: martin.elshuber@chello.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chello.at;
	s=201801custpemceu; t=1695373284;
	bh=PT2qXSmbERKyP7y6H6ghd5eRS4qYlr1ilpO3F2XuIRA=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=p0R3IG7BPIsXIeg24Kuw/MvXQAg6p/h0kTJsXrticmRC23E2/cUbhS/z9RLkcBKMN
	 6Fo09GpErDBogjFND4geeeGE2T9UoIhxLWOMgv1Za/TDOuv083gGn08yq30hJq5f41
	 J79mJmVnrIgiuzlKRr1nWK2PVg1yX4NEDzIP6sRxqYL9JRIrtqwDvkdMi6BSdq9ix1
	 3gWzWmjakFuBt+8K6okDbgkRh4Emg5Qk9p+IYOWyNyp9JXlx+EVMy05QoZUbCax/FY
	 VdHAh3gH51JKqK6+CiTjVX0GOe9pYtxa08NVJb/L8LucjKEwYCt/ydHJcOSq0S15k3
	 BVzEUEHwqDG7g==
From: Martin Elshuber <martin.elshuber@chello.at>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai @ lists . linux . dev" <xenomai@lists.linux.dev>,
	Martin Elshuber <martin.elshuber@theobroma-systems.com>
Subject: [PATCH 0/1] *** Fix NULL pointer violation when receiving fragmented ICMP/IP messages ***
Date: Fri, 22 Sep 2023 11:01:11 +0200
Message-Id: <20230922090112.344174-1-martin.elshuber@chello.at>
X-Mailer: git-send-email 2.34.1
Reply-To: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAWh11DkylM9z3RFxSopzGVYYxVkMZ8WpK46YSGNCc4sDcrSsU78l5S0i/6voNxLfVuRkpxaADqMg0vJITRUL4swulQf0hc/mBw8l/TisRhG4j1uMW8O
 mvyNBOl5Ac8zzodK3rhIrHiLPAYy6DdPBdcEFTkLJahnOeIyG41rl0wzWfI9oGq14ruq74ByjXDilqEMwSbQfh4tXozv9Ow0BX7gOlXS/hcnqwUqo5hnnUwV
 CJt3RDO1YvWonCZL6iRb6vlq4oNJotgzU+GfRLpitNspM4yoTUxfWAac5KBc3vpRe4zsK5hbE/vdNwqB8jfz5eneroX3GWPIGnWuXdF94H/jjVspiPQB2cmO
 x30/QQnf/7R6GCEnfwTMRvtBI4vENKHPNnAjVb1FOiTa1zrUcF+tIOnSFUb61eGdX+X5NFi7

From: Martin Elshuber <martin.elshuber@theobroma-systems.com>

* Introuction

I understand that fragmentation is not supported for ICMP
however receiving such a message should not lead to a NULL pointer
violation.

The issue is connected to the IP layer below, since it already
collects the rtskbs during fragmentation. The problem arises since
when receiving fragmented IP packets rt_ip_defrag is called and the
message is delivered to ICMP once the complete messages is collected.

When rt_ip_defrag returns a completely resembled message
rt_ip_local_deliver relies on skb->sk being set to (ip_input:68), in
order to dereference the socket (ip_input:97).

Since the ICMP socket is referenced in rt_icmp_dest_socket I think
this is also the place where skb->sk should be assigned. This is also
where it is done in TCP (tcp.c:841) and UDP (udp.c:653).

* Testing

I stumbled over the issue while work on a driver on a old 4.10
kernel, having ipipe patches applied.

The problem is that I have no Ethernet hardware on hand where a
driver, that is compatible with a recent (master) Xenomai version, is
available.

I managed however to get a Dovetail Linux + Xenomai/master running on
a target (no Ethernet HW though).

So my test-setup is a bit odd (Arm64, Linux 6.0.2, Dovetail patches,
Xenomai master/74b74c0ddb65ea2e0436067f1edc3a54375a4286). I used
rtproxy to forward packets to rtlo. Combined with some static ARP and
(RT)ROUTING entries the changed code path could be reached.

Martin Elshuber (1):
  rtnet: icmp.c: fix rt_icmp_dest_socket triggering a NULL pointer
    violation

 kernel/drivers/net/stack/ipv4/icmp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1

