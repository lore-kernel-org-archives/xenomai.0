Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127723C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErVij+VoPv7s/R3dwbqslmRGKJki67wmEmw1uS5ot5uTtqClAWhW/4p3ZH1pCe/99CgFMTNqqKnNpOj87mQmqgyNrG5wezPnHxxjCdPWHCA6eFZexDDWIJpB65KjxwCBpVyYadHfSRbHeKeQqTX+S8vNXopNX8L9dfqksA2QOSr+bkQDYZKAjaFDnDqH2Qfmvyo0o3kyT5Ol6+y1pya3VghBP3MZQlVkwGd8AB1CkRJkUZsIA2xrSNecyv1a8yimAHs5BjvKcsJW64zDra4P6mZ8hvjZh7BeuXg/6rVzUYVURpO5gAAUUOGWBCDCaM2wQ7FrhrTL+GuiHUZNQC+kLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BZFdpCea2TSybk598dz9IxfdKFmUU6jAH1UrZaqjTI=;
 b=k/4xs+eIhDyWH7gzFcSfUag1t24Pu86cUTxbez/b3iKpq8MlP7Irr4xWcS6QsKzx+bP5s8aTE/QZ5mwvDhhUmIKWvlWhxLYBW8vPSPW6l9i5o3gs7SV83X19hefq70af/uJAKtmpvQ6xLH21NA4/2bOuVWhk5F/0O/+W8G4woz8SbXo8MNf7ZHtBLgcq3XEqaiv8+0RgJEWmSTLBe+bilbR9KqFlJFa2CKIrqRGe6C92bmRnqI0PtFBGi7xD97IwhnUwMwV4CBmS2d1yAmMieMJHCj0fz4jw4mfKfF6vyylChY4WnqQs0VNOTBSIKBbdSGGw/65lSVo2NfWYbldgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BZFdpCea2TSybk598dz9IxfdKFmUU6jAH1UrZaqjTI=;
 b=KikLYVS/1RbVPlVL+RLNQzcRJa5TE13JIjTl2FNbbenubnqtt6kCx7gRzPbMySMDJ1chMSE7Euru7THBssSElBciSsW/ALOWCHkVNglcgR4FCAGTQk2wmfvsLupkgdl6PlQgSCardlsJ0sLwaOP0f0Zqa7AEd0lwuhAP8fCIrlv8DqERkWU9D2MRbtMq2Odk+Uw/vHliJ+GAZ3zVU8I5IhStxKjaZ2teEsn3gRbXYjKbh3+dVDTs+Ut6QcqX8QVromRVQcCy6erlAnKwgCgwNouRdgDprc8sUUwudRBnzqySUwWFnLiGqRr3/VEDUg1A2uMs3BSWxHc+Vl76quHxTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU2PR10MB5126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 07:14:58 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:14:58 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 3/3] drivers/net/stack/ipv4/udp/udp.c: Add compat support
Date: Thu, 18 Aug 2022 09:14:42 +0200
Message-Id: <20220818071442.16567-4-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818071442.16567-1-florian.bezdeka@siemens.com>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91fa1556-b842-444e-8b68-08da80e95bf0
X-MS-TrafficTypeDiagnostic: DU2PR10MB5126:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CquDYiSRNjPjsXJpX1ZMsjEPq2j6Et6o0wqCHFAH+6RHCDQowU+2JjFBgahIYFxl0DL6fRr5kjQu9paZ6xQALbyRuI6fD5i5Ra41MeKJcAuzo633UhrvahyJVIJKKLRkzOC4Z6wdLfrVDRYjM5Ac/dwsm+Bvzs4ZK7mN1wpfPCK1+NR6wVLVHooGNMBXwt1luY7d+QxoMh1Dm2lI/b26NHnnNb8CmspDMHjxOk5Ns8O+vAxcGnRqBP6Y6waFtvzMZOTs3b4y6Ued5R9gA6w9rNWPXNZVYMNx2Eu/rpYrvLAojgw7UDfI/qoQzRqAlG68GN6iYqv0RRYZO7oEuMchq3kjXRkLnzRISFPEjew3ZWhg+5pExd/DX+51B8a4ukqXv0vmSlYMSre4L18Xs9wAcU+u4cHg1mh+Gle6C/enyLsHnqOu7YEZd8ncmIDU5YVT/VGRNA9QAzmrBUP8qbIa7+0O+3Wxrat0csFSonJjWDru92GeOBhkpXMDGzebNDKye2Nl0C4wcu45PszThY66synGar+yUO7gTEKP80Q7B8GA8r/KYyJOABhtxhTVeBHWQDLnN3nJSd1N1CtAfgYKluoaMa9xjqp3OOPW54X82qTmTVXhUo3Zz8AHwx05C5qb0CAxK6jtWVGkqfs2rxyIlcjHUXRDcq4OV85JmZU4wHEPBRPrpESSbwnRPwvz2B2bfLAwDwfWyRs/CrjQvbM00g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6916009)(41300700001)(54906003)(316002)(478600001)(4326008)(38100700002)(6486002)(5660300002)(8676002)(66946007)(66476007)(8936002)(66556008)(44832011)(2906002)(36756003)(186003)(86362001)(6506007)(1076003)(82960400001)(6666004)(2616005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7vDMDuSrTXO0jZMTSPluUu3qUhEXzZRV8C2l2JC1CAKqw6mvl7LsCYwL9Ks?=
 =?us-ascii?Q?VqMkPvcikpM29eAGc4n0YDgvy1DkPQ7IJFF48ExcdKEpyDDY4B0xbOskP5HN?=
 =?us-ascii?Q?3hs88vFNXB+PRBxis7Wnr3Sceq/dianJgYq8cFGST/EtYppz8o0bBMfEZTRf?=
 =?us-ascii?Q?3KekC2dCW8Xsr5bIqvOXfGhX71Pw2eSpunIKff9M4D/tp27iooiOmDbE5NN7?=
 =?us-ascii?Q?q0OiffM1RQU3koZ596SEaRsS0anqHtebdc9aMRDt4HmMj78GI+NU3F3zqWoG?=
 =?us-ascii?Q?e7LZHXoaRhPQkGFKUP+NOF6j0Y38tPenYfINlj1Mbw0WboNzIOxVKN1Icin/?=
 =?us-ascii?Q?l+a5aEGH7sh9lPMHkNOsUR7F6lnHjmNtJxPPOIy6gyZ6PqV4tlb1Ga33NorH?=
 =?us-ascii?Q?uQqxEBhEuSt7M/asJ3dVnTZzRF6P09yQRQSuiQ3tAC0bA1EEYGz6zIWSkDSM?=
 =?us-ascii?Q?+2yZdUtvfWCYqQOKr67JhJRoFhWXgQTXHVhLUTvpiGmeJhuFR96BPPaaVFBH?=
 =?us-ascii?Q?KwZXz526FfgwzxkM0ihn8yF/oGvJBM0xJfut8b7XjIPnfERsvk0NHXUUgkNa?=
 =?us-ascii?Q?xfUcVCA/EWv/fuEmV1dP0dOviVUnIR6TKl4NztQoSS31s07O7zKYZTzQfPaQ?=
 =?us-ascii?Q?K5aRO/VucBjBRDo0NYXu9IdH5agLtDSNECLwuFVoYO0pgdTJt03GhM6QGcjB?=
 =?us-ascii?Q?Tnj28y6Y/Xa8JO0ifOHhWYuqpgKzy0jSEfp0jgzfghq9zyBX3WwEAS6xUdJ5?=
 =?us-ascii?Q?xBO9fbXz0zUsvdVgICsVlG/quE3BCmd2jVv+j7fbwz2XJ3Xy1IaU0F+xymX1?=
 =?us-ascii?Q?WvCC/sSAYgUwytgi5k236RxFUMtCDKq/y1LdcaGwHhxu4uPvUr+rpIdKIc+g?=
 =?us-ascii?Q?PohXr1mXEM2+0E96kmrPLcFOy0FZoJ6PkRAxvqJqvkHr82I7E3u7LZObTcJJ?=
 =?us-ascii?Q?dq1sx7g3tjsbSis2d0GjojGUsqAL7dRRnHf0bKQPjiGGIkhJXRVRCcnIDNgo?=
 =?us-ascii?Q?L9JbyCMkhIMbpZvUM74EZgJSYGJJRRy7Iim/PNNJG52DGewHktrMQOgB0Sme?=
 =?us-ascii?Q?JB3eSW4p3qOttCifs6Jt0apj9XImYwAR6SYzYJ8I90R+ppufzDteQIfXD3Ix?=
 =?us-ascii?Q?rpcXDu3jEYm40HoWoQlOV3Sgt5MQ/MSLjiV/+J6m1/Bvdd70JaNhT6Nm/i92?=
 =?us-ascii?Q?n9SmcOoTwLZCZag5p39dwToq1BwOHgW0mizvBhM/LvscKU4Mmbsoi3/kbKMQ?=
 =?us-ascii?Q?NKP7m12AK2sFn3d7r9/edvO+Pe4+D0v9Dze33RWeleonPgF/0RPRgNnAGciV?=
 =?us-ascii?Q?PSSu2FZK6lZGC9QspOEUbciJRhQj/0DSz3Cw/b/zx20tZJgB2IhP1fK95YlK?=
 =?us-ascii?Q?D1/LckKmxjmT9ORes5J/1miWsaDeE1xgzXGa27QGdC5yhoB3JwHs/HhOw63l?=
 =?us-ascii?Q?qn8Gc2S8xlGDhLwKI1xaI1CJkFfjkKNdcsshrGbP6VRcr8DsYX3lsVxJuh68?=
 =?us-ascii?Q?etNg5KGPbdeAaXqgdFhHa/nfp6BRZG5pk4mGYp6XUa+JkV694wJ/jrfsxjhk?=
 =?us-ascii?Q?6L6QqMK8xR4sNQwvugonRtuPmZGbNTwuN7E+kgTvFgi7VcdDnLknrLlp5op6?=
 =?us-ascii?Q?VZD+mHbCVpZI+I+hlw7+JHKgcHzyftEN8YHj707zloSJDIdRN9Q2hils2m4i?=
 =?us-ascii?Q?/Ed+eg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fa1556-b842-444e-8b68-08da80e95bf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:14:58.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da3XUjoEcmRZX7uZam0f1k87TDVyMUue2LnJFzptxGiMhZmprD/2jsMuDC7HAb5LRJ6c+Ghq0hB6gSVrZL5TTIWrIrzTreHxspcQVqdkfK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5126

The rtnet interface was lacking compat support for the following ioctl
commands:
  - _RTIOC_BIND
  - _RTIOC_CONNECT

This patch is heavily inspired by Konstantin's proposal but migrated
to some rtnet APIs that allow us to stay away from
  #ifdef CONFIG_XENO_ARCH_SYS3264
sections.

Reported-by: Konstantin Smola <ksmola51@gmail.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5977a3bc2..777c8a27a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -31,6 +31,7 @@
 #include <linux/tcp.h>
 #include <linux/list.h>
 
+#include <rtdm/compat.h>
 #include <rtskb.h>
 #include <rtnet_internal.h>
 #include <rtnet_checksum.h>
@@ -355,25 +356,27 @@ void rt_udp_close(struct rtdm_fd *fd)
 int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
-	const struct _rtdm_setsockaddr_args *setaddr;
-	struct _rtdm_setsockaddr_args _setaddr;
+	struct _rtdm_setsockaddr_args args;
+	bool do_bind = false;
+	int ret;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
 		return rt_socket_common_ioctl(fd, request, arg);
 
 	switch (request) {
-	case _RTIOC_BIND:
-	case _RTIOC_CONNECT:
-		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
-		if (IS_ERR(setaddr))
-			return PTR_ERR(setaddr);
-		if (request == _RTIOC_BIND)
-			return rt_udp_bind(fd, sock, setaddr->addr,
-					   setaddr->addrlen);
-
-		return rt_udp_connect(fd, sock, setaddr->addr,
-				      setaddr->addrlen);
+	COMPAT_CASE(_RTIOC_BIND):
+		do_bind = true;
+		fallthrough;
+	COMPAT_CASE(_RTIOC_CONNECT):
+		ret = rtdm_fd_get_setsockaddr_args(fd, &args, arg);
+		if (ret)
+			return ret;
+
+		if (do_bind)
+			return rt_udp_bind(fd, sock, args.addr, args.addrlen);
+
+		return rt_udp_connect(fd, sock, args.addr, args.addrlen);
 
 	default:
 		return rt_ip_ioctl(fd, request, arg);
-- 
2.37.2

