Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E64429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7V+EMp0KVE1VpM5HGy0K07HrOam9scqRdrZzWnuezZiMfb7N6WQwe/kEVhJt9SRfu2QqUN/42SpDaxQ6ZyQzOpK0MyyB6+YIKjCVLOMihPB5leC4pwFZeKxURpYhKCyJxnXirHmjx8oXk/qLPqJ+9fz5otQewhCNSP1B2+fWLbKVYcaL8Kxe/+bkopBv25be3hYAgJN+nSJ7SQ6u98jq+dP5IzAY8YWcr5mp+lnqdQSKilPFPgNsbomeWR5Sf8rFlpqr8cq2eD8Gm+357wturzN/Uj725fZW3UQAqX+vtRTWtIR2BqFBRdQ4FBuVeMsuGxxPdITc2MquVCn8JpMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz7LQEzdDEGyysyLl4jIZyI4FevNBlOydnq2VZvDBtM=;
 b=aknCiuyta2H6oHqSNSvv05MNRZIWYvSHijdoqHtVhTlhMNoClGSTz6mXzfAzG/WqIaSNzYkHb+UMY9c20g8ghpXxclk5DirSjpffA5OQH72xmyQkuO3PmKomCGcbauhAuXI4SRMZsBDCML4BCgl6N4wnyD1aa/nK0N9NBx1WMFlhtc6vUd061xLfXjEHrUcdIKTsTcx8TYqm9OtoTav+9iGZH1DONbUkBnkeotjAovtKN6QTQHnVKMHYAQeDczgwQ2n+SFPvFdNdVVLtW2wF2R3VsoEnh3YSawHRbRznx33nw9AxgvdYWQRbOWdTuLLAHldue+dzFZibzuNykgjgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz7LQEzdDEGyysyLl4jIZyI4FevNBlOydnq2VZvDBtM=;
 b=ZEv8i60fC80anSeJvQhUs9uB7riWzVohrhbEhICHv+9gw2+d844QCNKgI71msRj/B8uiITK7Md0lNvqEnbEMCyVXGh5HTCS2G94qm8ct/l+d9kO6/zROhitxrkD0txJldRLADyWcUPiMq69uT42e4KvFgRi3sQY9th2bbafiiFNDfQTkPq2g6S+7o/sNS56X/NVtYgUSpIVgsvggSGcywAU+1z7H5JtAg2oLteWNKqG0V5zVh/aXyla8U2VZ81l7H3YkZRRDorLS798KJj+vdlAyJ4fKdRFDl3TdCJNEa5ddLjw2xZ5LqsTMclahtUW30Qio2wmSjIAJBIiroPe83w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:52 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 37/42] y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date: Tue,  9 Aug 2022 15:43:21 +0200
Message-Id: <20220809134326.23688-38-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::33) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a0eb7f6-1e1e-4a2c-84da-08da7a0d463e
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnKTZKVZuRWnUcR/hBw5KDR7YialH9UI0sFuBq7lXgu3BVqbLrq5T0Pg05j7PwGBKNXS2DIlNWww/Cv5g3CjEsqMQtjCyIdYv7LhOhfO/x14a4ubqIHAt7Qop8GUu3QvJLyW27gpuME35Nmf78G2gQEq4PU87Pi/RzTTNNwWLq8YVGxB3VwM8wUthxEdDzLLTFBJu2hqMKqhscMzHbLKb/t75qEKy7CdP5n9hJZK9CQDpdF/KVcUEZ12WJR4n+JNfA+b7frmFCoFo0dp1f6WdjqdaBCMGIf7xgNsEWOjS7xmAOMZ1hRFy0GhfV4dNXTPToZkScxXWHC1rUEQKDxY0uwlMpMLp3yov6ShFxBOLRp8f23L3nyCseM1eYQ6dXtIG1vEMPLVssEFur8XBOjIaJq+USTJLpubQ+x4bWJiBWgxPtNmD8ipoQsAdMmLmNcUEDMHsLShtWsCp+rNQtGPoYqc8EHb1tt1InU2gI+tilXC/6ruQx03Q2E15EZOTOXS6r0KD2gSgisC+XfUB3yUQLYitUm0vaAycn3G41KrgZjjOLpnS1JM/VQQiniqNXAuW/Ei0m+3lCJyYVRPlAK86KbIL+IT0LWb5pbT1ZnxPdaynRHlsM6EmLcPHkaaXJauFbWGib22prQkzscT/q4ddlIXzcgGyN6vPy1zFeTyOlPR72eeUMp81gi+VzNEF5LzWXxyN6/n8cT5EW9eJLGc5OAs+Bj7gp6s3p1XjKWRPZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(2616005)(186003)(107886003)(30864003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veS5mAJDgjvR/hhAtkx1CSwu2n9il30ynfUt5wV9gDqXWQn2tueE5pGCH0pH?=
 =?us-ascii?Q?RnRuXmomVpT0ukPdhflw6rVVaJObatn7JNr/MoP3CJgM3U1hH5X4DV1awYO9?=
 =?us-ascii?Q?PTJh28yArwpWMAufTWPpn774NMfI0Num1qcFiO3UtyfmO0Nh8Mnll9SHWnKy?=
 =?us-ascii?Q?go9UvE79xc1Jly5/IPuWh0H3ycAK0xCjd7yBbvqgprqbCqHpV5t9aQ1XTidR?=
 =?us-ascii?Q?gtixTj394DpYcyWSBsfx2qUKbh8cyISjzPvJPh7/16IeURdbKAfXPTUdoViK?=
 =?us-ascii?Q?5Vzt99GrXX9laGxY+sMSw8lycU+JM6d76JRXWaGF/X3N2UTr7w3OFZRd2vrH?=
 =?us-ascii?Q?/p0M+er0IC6EpiBKc5A/3iBYHHHLeVxJJeciKdph3WyO2llPMRaEwC+Xy+Jt?=
 =?us-ascii?Q?ysVW1nAW8UcjahE2h15O+JFAmN3JtymGZxJAcWYGiYpU1C3HKp4PIL02cEqm?=
 =?us-ascii?Q?Piih2sfk8uMKlXJXf5/ySc6IktAHM/jFcMM57f9tUn0xWOTY8smMxbNlMM5K?=
 =?us-ascii?Q?M6FzjqcXlmrvlENanW2CXgkluFCCdZPu0wFRxd7CAUstWOSpGYZzc6kRpFs8?=
 =?us-ascii?Q?3nNE6+5S2p3GvzERZrdkORsCXbNKyLnKNvFyKqxfQLTuwe5yDpdxTGnB/d/R?=
 =?us-ascii?Q?dzumE5Ozm1HHbkKoyL7xhlMhHXU/YKtWrQ3iPSp7p5qErQFwh7XhPvlTsaDs?=
 =?us-ascii?Q?t/El2vrExlIIEChr/bQfo+Nd6M3h7Tg5+MK6963+qXRrw8P8fLf5i78AgIpF?=
 =?us-ascii?Q?5Hwtk6WV2Ewe3/SZN5TTcazCwU1ISAcHU8ySSWe5vx23Vo+G8ypZKe/mLu7u?=
 =?us-ascii?Q?Hr9N+ERoiQVFJ2nhO/Skn/vmUiMlcEgwpjuxViHQoomFVJj9u6nfhnOmV5h/?=
 =?us-ascii?Q?BHs9UCFVEO7Qp47CVHQnQNPuOzRd+wpReFiI5ObyqQf7PpNznJNxnNOBn0H0?=
 =?us-ascii?Q?Tmtb+YBsL6YzXsntMDgcEnzy0tt1UqtocYviIC7YPmPFJgtDSo7GWxLtKj6D?=
 =?us-ascii?Q?CJL4WmXP5lGwNKPp9lNuQUK9rsIxk7CilegiBl4GK+MymfLUvBxWUV3LLx7h?=
 =?us-ascii?Q?EcLW6qfjxAfvx567K+aW4jApDdOaMFpN9LzxPXSUGOBsr2dfQC5BF+UkcEqV?=
 =?us-ascii?Q?wl5col4EIIflzrO2A2xTeahUhP74fY1ZPTKdNa5cC/X0QjUWqAMqUyquw9/q?=
 =?us-ascii?Q?wKkF/PfYKGs61S9Lbgk+PiQlnYgi4B/6VjNce3Q1mtY7AZKyqmVHOhGezuoM?=
 =?us-ascii?Q?pbrPItusW9Q+r4Rls65nO9CYW92sPZQMYu8SVkV/+2vTZL01q+uLVezCNjga?=
 =?us-ascii?Q?yzry58Fc5JqFF77jiriIoy3iBkmYc3gNoArGe9EKQxxi+AAHZp/o97BQmi5s?=
 =?us-ascii?Q?4gccyGVpTHvTTN1+YMQ971u6J680UoSglBVz+FXm15IhByrWtxCMt1QhA93G?=
 =?us-ascii?Q?1zcUKlRx3raTGKbdwY3m9aieRHQZgvR1pEd4xew6BI3FPdiPzbRkeFo8EnlX?=
 =?us-ascii?Q?oJjgF+cVLCZwTq4J4aqCbCFNIjGCw9yR5KvCyYxE7UI1i7KE0n0KyzTggGOd?=
 =?us-ascii?Q?FFqSV+7l663K+v2ldGAU9JefgklqVljdDo6P33MY4GM5dQvudKmDgb45OOn8?=
 =?us-ascii?Q?kiclkO5LS3uAonCLraKzPcU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0eb7f6-1e1e-4a2c-84da-08da7a0d463e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:25.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiT//Btd2hw7+ql2VxRDC+5g7un8ShlifYWtLmI/gElLIKVqXH+/SIkayyu/MaU6wXXYW8UVxMxOzAjk0vUeld89/Uy/nx+P8zXpJxkhhNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

When requesting y2038 support from recent glibc versions SO_RCVTIMEO and
SO_SNDTIMEO will be auto-converted to the _NEW variants to make clear
that we have to deal with a different (now y2038 safe) ABI.

Implementing SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW where necessary.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/ipc/bufp.c               | 34 +++++++++++++++++++++++++
 kernel/drivers/ipc/iddp.c               | 34 +++++++++++++++++++++++++
 kernel/drivers/ipc/internal.h           | 27 ++++++++++++++++++++
 kernel/drivers/ipc/rtipc.c              | 29 +++++++++++++++++++++
 kernel/drivers/ipc/xddp.c               | 18 +++++++++++++
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 31 ++++++++++++++++++++++
 6 files changed, 173 insertions(+)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 565409dd6..f1936d846 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -824,6 +824,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -844,6 +845,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
@@ -851,6 +860,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
@@ -913,6 +930,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -936,6 +954,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
@@ -943,6 +969,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 				return ret;
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 05d019339..e4893a378 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -704,6 +704,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_setsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -724,6 +725,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
@@ -731,6 +740,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
@@ -793,6 +810,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 			     void *arg)
 {
 	struct _rtdm_getsockopt_args sopt;
+	struct __kernel_sock_timeval stv;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t s;
@@ -817,6 +835,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
@@ -824,6 +850,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_SNDTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
index 919a5d978..f29ba2204 100644
--- a/kernel/drivers/ipc/internal.h
+++ b/kernel/drivers/ipc/internal.h
@@ -76,6 +76,17 @@ static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct __kernel_old_timev
 	return ns;
 }
 
+static inline nanosecs_rel_t
+rtipc_sock_timeval_to_ns(const struct __kernel_sock_timeval *tv)
+{
+	nanosecs_rel_t ns = tv->tv_usec * 1000;
+
+	if (tv->tv_sec)
+		ns += (nanosecs_rel_t)tv->tv_sec * 1000000000UL;
+
+	return ns;
+}
+
 static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs_rel_t ns)
 {
 	unsigned long nsecs;
@@ -84,6 +95,15 @@ static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs
 	tv->tv_usec = nsecs / 1000;
 }
 
+static inline void rtipc_ns_to_sock_timeval(struct __kernel_sock_timeval *tv,
+					    nanosecs_rel_t ns)
+{
+	unsigned long nsecs;
+
+	tv->tv_sec = xnclock_divrem_billion(ns, &nsecs);
+	tv->tv_usec = nsecs / 1000;
+}
+
 int rtipc_get_sockaddr(struct rtdm_fd *fd,
 		       struct sockaddr_ipc **saddrp,
 		       const void *arg);
@@ -105,9 +125,16 @@ int rtipc_get_sockoptin(struct rtdm_fd *fd,
 int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 		      const void *arg, size_t arglen);
 
+int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
+			   const void *arg, size_t arglen);
+
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 		      const struct __kernel_old_timeval *tv, size_t arglen);
 
+int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
+			   const struct __kernel_sock_timeval *tv,
+			   size_t arglen);
+
 int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 		     const void *arg, size_t arglen);
 
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index 211b496ec..66176adad 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -290,6 +290,20 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
 	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
 }
 
+int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
+			   const void *arg, size_t arglen)
+{
+	if (arglen != sizeof(*tv))
+		return -EINVAL;
+
+	if (!rtdm_fd_is_user(fd)) {
+		*tv = *(struct __kernel_sock_timeval *)arg;
+		return 0;
+	}
+
+	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
+}
+
 int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 		      const struct __kernel_old_timeval *tv, size_t arglen)
 {
@@ -312,6 +326,21 @@ int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
 	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
 }
 
+int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
+			   const struct __kernel_sock_timeval *tv,
+			   size_t arglen)
+{
+	if (arglen != sizeof(*tv))
+		return -EINVAL;
+
+	if (!rtdm_fd_is_user(fd)) {
+		*(struct __kernel_sock_timeval *)arg = *tv;
+		return 0;
+	}
+
+	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
+}
+
 int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 		     const void *arg, size_t arglen)
 {
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 2ca0da5fd..864375d94 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -861,6 +861,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	struct _rtdm_setsockopt_args sopt;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval stv;
 	rtdm_lockctx_t s;
 	size_t len;
 	int ret;
@@ -879,6 +880,14 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 			sk->timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
+						     sopt.optlen);
+			if (ret)
+				return ret;
+
+			sk->timeout = rtipc_sock_timeval_to_ns(&stv);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -967,6 +976,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 	struct _rtdm_getsockopt_args sopt;
 	struct rtipc_port_label plabel;
 	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval stv;
 	rtdm_lockctx_t s;
 	socklen_t len;
 	int ret;
@@ -988,6 +998,14 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 				return ret;
 			break;
 
+		case SO_RCVTIMEO_NEW:
+			rtipc_ns_to_sock_timeval(&stv, sk->timeout);
+			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
+						     len);
+			if (ret)
+				return ret;
+			break;
+
 		default:
 			ret = -EINVAL;
 		}
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 71628ba03..5bd114530 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1743,6 +1743,7 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 			     socklen_t optlen)
 {
 	/* uint64_t val; */
+	struct __kernel_sock_timeval stv;
 	struct __kernel_old_timeval tv;
 	rtdm_lockctx_t context;
 
@@ -1793,6 +1794,36 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
 
 		return 0;
 
+	case SO_SNDTIMEO_NEW:
+		if (optlen < sizeof(stv))
+			return -EINVAL;
+		if (rtdm_copy_from_user(fd, &stv, optval, sizeof(stv)))
+			return -EFAULT;
+		if (stv.tv_usec < 0 || stv.tv_usec >= 1000000)
+			return -EDOM;
+
+		rtdm_lock_get_irqsave(&ts->socket_lock, context);
+
+		if (stv.tv_sec < 0) {
+			ts->sk_sndtimeo = RTDM_TIMEOUT_NONE;
+			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+			return 0;
+		}
+
+		ts->sk_sndtimeo = RTDM_TIMEOUT_INFINITE;
+		if (stv.tv_sec == 0 && stv.tv_usec == 0) {
+			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+			return 0;
+		}
+
+		if (stv.tv_sec < (MAX_SCHEDULE_TIMEOUT / 1000000000ull - 1))
+			ts->sk_sndtimeo =
+				(stv.tv_sec * 1000000 + stv.tv_usec) * 1000;
+
+		rtdm_lock_put_irqrestore(&ts->socket_lock, context);
+
+		return 0;
+
 	case SO_REUSEADDR:
 		/* to implement */
 		return -EOPNOTSUPP;
-- 
2.37.1

