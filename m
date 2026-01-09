Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36131D750
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961524; cv=fail; b=s3B/U6KaoRdxtQk7oTK6JIFheqkjnQ5YPJ7Byd9NAg/NnGkcdLf40fIjCDXGNLj5wKu1g593oPrRFc/jToTUGhGxZHM7wyvRIx7bau9qFWLr/N3bQC1u6rRmUos38NP0qY1ondFZ9zMFGHKOPi7YE6JPBUx5aW0SvsXSSMpLgZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961524; c=relaxed/simple;
	bh=PG7KM45Z3aKcHOMpJ7251Xcwvy1wUWH0sco3r3YlZ00=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GubaL3qVsUijyTwC43jaqmiYupL2pKYW02/czFH8ApCZb8TPZ7Knuw7tvO7l4c2BLuzjoTlRopvEnLvOQ555zxdT2tvHS7yRbrfGpc3H28lXfPeZH0cm1sxNiMSu9RNL0l4Lf4bu5MKaBkh6fj82WZrhaLnIIJPV/F7wllaAb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cRBGjDs0; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cRBGjDs0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEjFsrmk4xpY8tRu8Guh+uVGpMBa7v6/V7dGj1D2LqmIJBg3Xy9TLCRmHZOSp9QQ804rXzIV19znkzEsL6xq41sefvzla4qfskckcRk4vlNyAA+7L3fzmpY+Sod5jT4YlYH3Jdn1xickKqfEHAoCPFRnJzADm9bsv4y3iI8mAJ1rwEHbBFknMHGNNdcmdDdy97wtgC5NLUeRQqLOE+Oj2OHdyWt8ifJtpOG/qeymsnHOLetkoyyeRPLZcRVnVItPmx735HA6GhwXbF9NCJZC1zlOJadUhupwwjTi6No20BIHGEixDeZ82hFAN+zOuQCIoildL0gYeu8Xj8g2FakS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o9z38IJQohqwhIo7VECxIko9iJK1PGQSxoBUIxd6ZI=;
 b=hnGI4u6UhFnvwZ9kFpo6XGdnV5kqv6x61wv1CGkP5YhVQrTuKeYZyv1NjokyV7P2hFtOiJHpzDPJs0U97hc3qKAjYqBv6m9u4fZssk92jswoQxZO93YKQAwF7X0nXnCLtXbb4QBplCEbe6Ow+utqXcv3FvZ0UHudg/i9wFwpkYukMfTZMPFgh2FzWMYINvSVK1WZvtvWfdNspV24FWd4yBZmHdtw4bqkP6Giq7ppEaQHRrjrOBgrOVmoB/3t9zDTkPvUWdFcwkMOFN8aBabEQ45FySJ0bkhutUPicxqLybXS/LK9DHlYA68xeos7n79SDU8rblfb7cwu1yKRthqojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o9z38IJQohqwhIo7VECxIko9iJK1PGQSxoBUIxd6ZI=;
 b=cRBGjDs0N8BhcZNZfqaPvY+NLHEMPicUSLv1tL2GiBX+6OnMvY/PqsuK5fEjUmfSM/nSYZMzFFP7yAlhd36MR85EEOupYjIwOKYnN/0bHvSpTp1r5qS6AkdO6eBeYdOKqZW5FeC97RoFkXD9co3zJR6xp3OHwa54Y6GPOMjKxLuuis338TuQedFoT+sl97lq3K8W8QsgIgnyoFmGKXXvwOAERUnURJFc1gq7VDiw5zZp3+ZxLVjPw8X2TKvjer3HEm9W28XX2DgXGFcLyWhcKlzaFRMUDzrDZiBDy2DpYIGWkixDZggacUUckNuZ34ASsv0vYJ7dDqZVxKY+DjI2nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB6875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:464::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 12:25:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 12:25:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] libevl: Don't install UAPI headers
Date: Fri,  9 Jan 2026 13:25:11 +0100
Message-ID: <20260109122511.778599-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: c713f60a-9627-46db-e68b-08de4f7a2735
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MptXQe+P3GO05c63tLqsAfll5j41ZAe7Kq8Gpd1FQLm9pB+FuJCTBISUwdlf?=
 =?us-ascii?Q?8zbF1vNUt1wLas38dZjUzLwrRZn8l34X5SrDCroiOZOolizdyfzRnvdKCm7B?=
 =?us-ascii?Q?ii4SEQ3cHTN6zxzKlC4p+e725YVo/XEZI1vHxBVdOqIcH7qmTH14Gr0ilB1w?=
 =?us-ascii?Q?5J5irwyKrRKYAaO4AoMVMf7sPYD4Rja8XCQn86LqWQS1Ncl7oy+CNjj0cP2b?=
 =?us-ascii?Q?jA11TSJJxP68DtC7GJ2HicHgYZK8ZYxnLlJRvl6G43V9kL8OuQo9mYxfQKDD?=
 =?us-ascii?Q?vif8Hg+s4BECRV/nP7nF3q4GwxMvRXdfMQ61SS4G0mGHLZjYzVzcaM+AKqPb?=
 =?us-ascii?Q?z50sZyahz0ccCeBPilj+RdhYYLGg3SV8BkEAiP02wVF2tJCnq50aZaMloTFX?=
 =?us-ascii?Q?bPZNjJ+2/F21lswxY14ZhOpbe6esViyFg/0PwRj8oXV4ByBy3iIbgUHCtsYi?=
 =?us-ascii?Q?+lE84egzwsSjMSoHDuHpnVXaIZcXF6uU0SXOfyhEsq8uicKUyX3SVjVY34BE?=
 =?us-ascii?Q?mBEJaiq6N/+V2JGKDH2PNpK1lTs/rWE1IYaSA4Q3cB2qMXErQsKy5kFA8FmO?=
 =?us-ascii?Q?uKuQ/IqhP7RkBrKl+WCllzk2eI83k1xmzMIskZxahHpMWc+2KbNtTH5Ehhoe?=
 =?us-ascii?Q?MDAQUnX3eWtIAa4jpar14V3id9tyI4fD+u9c0bbZP4VSVA41rPXBmQFDbxoQ?=
 =?us-ascii?Q?ziZShGICf18R7+lPWdhCXqM5N7zNFA5V/RbJopn+jLM5OSva3Jkdp8QTkted?=
 =?us-ascii?Q?31VmghnX5N1miEItkCMxgt1Cj6waNLgFaQ8/vEhrbdK/MUwOfSnTvzv6AerU?=
 =?us-ascii?Q?d0AlURNYKScEXPFpEp0qnplI/amRHeE0W2q5cyk3KaTrGCnJoMqavJOp39Yk?=
 =?us-ascii?Q?zRYHA5mVNXt4BWoI/zctPOwRe1fhSvUbYChR4K7GHVYhpMskwJjkJ/u78wk7?=
 =?us-ascii?Q?d5HdKC7p+nZRkWz3sOSbRCk9dTH7j0C4Rzm93Si6iICfWeAKczWKyKDg2jxq?=
 =?us-ascii?Q?ken/2wZnyIhzuxlA0vKDtInHa7SxHZusXCZEsKgIEXJXUwL+cgcHw/XSRMAD?=
 =?us-ascii?Q?rZcjNxAY+Je2koSLhZ7f6IGWvUI1lVgrnJSxff3hwWCr5SbtqGu1YR+xps8c?=
 =?us-ascii?Q?l8JqmztzM5OfgyiekYGoCA7bZJV1Q2a3HlfSwtUzJCKevLdAzjX03mwo1GYf?=
 =?us-ascii?Q?ruW8oIDeq44f8Sn7cGUGDIVR60HnbUZBIrTJeEZjnvNfAY0wOkig358RSt8V?=
 =?us-ascii?Q?SEJuriXH3jv9AhB6b1HtXkWdwW/1ajhNan4bmEh+Bu7WRtLj/7C9hxI2847B?=
 =?us-ascii?Q?VENit+t0uuftP4vvJx6WnNmHB3nHtKyL4kEOd//N07QmwiJcvGNKOqSg3BVW?=
 =?us-ascii?Q?2i6LBSV6zjPJCgExqFpliXVAHP+9ISjiCs8xE/W4qmhbgb6t6lvtPHm/42qU?=
 =?us-ascii?Q?8UkUqeB7czPjoK2tBZRh4KLRY8Rg+Rjr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33b70GSVask7hT4V5loViBi6wTQIOtKh9CY9BQtHznlOeXsNUqrP8kJzhwNR?=
 =?us-ascii?Q?ruDzAa5e6snlEqbWHfcv24f1Q0fZou3Z06enZs98/FrrgFweHHt1ZnU32QCm?=
 =?us-ascii?Q?UYus5OVff4Coms+6HGr+/nYNVG2rOCM04kKelDTbkYM3Wm7hsxzaxCuDelfY?=
 =?us-ascii?Q?Aklik1HpS0mmb4d1B9rMJMmkpCApRKEfy1Z0hF9t0oYkYFRXwAgE0aPg1BW5?=
 =?us-ascii?Q?rthf53D+CC7kqBGDhRDCDHwrZb77cPoZted9vRTqUlsVN3Vebkdic94WYY8h?=
 =?us-ascii?Q?POlfqD41XCgtcHNWe1MWeapqTFuxT51XQrt2Vjpmj1pRVWrQu5nhj8d/kxMT?=
 =?us-ascii?Q?f7c7mvepJSqHzn9f0UfqF6kVeyl9Va+m2yUs3/bxkii1P4pqHVfXxJaTFOC9?=
 =?us-ascii?Q?6L3Tb6M2YQ364WbG3QQRNR1a/JuwGz+DCUxVMJZn967xRSHqmzWc7SD66lJn?=
 =?us-ascii?Q?MvN/eCTTcrNt/b6gfh59tGNHy5NJiPYazRf/s+54e+PFPqIQ167GB9DA84pr?=
 =?us-ascii?Q?TKNUDBGUSLgC8HP9PrQtlhR+GaemTuR/tKFWuYcYXZoyVtGYNZhIkTv12O8V?=
 =?us-ascii?Q?mk0P80DjOulkvJ1HBUhuFJzOrka6gDj0pI8rYNWeZtrG482rg40IxFtZa1fb?=
 =?us-ascii?Q?bhFdH/dJ+zSHd6pj9GiY0cfYq+D5eMcugIdxLPXL71SdMOgeifudgg/AJqxa?=
 =?us-ascii?Q?15mePaQfkRxV8/QqtIW/20ZUm2LVlg9g3ZKxHPYEYE8JbTSK4gCKShE6Jk0N?=
 =?us-ascii?Q?hsvcfU0oFBpT14rsfc0Yi+TDGTkkKNPFiPLO8qZYGs+egfE/RJLaKtL6eFDv?=
 =?us-ascii?Q?WcyEq8RQ6M3V8WVOVyTMoP8b9YdNgh/lB6hSnvatpSyP0ncwP7jjFfyTuZqU?=
 =?us-ascii?Q?HP8tD00xl3yEiCzEsUs7adJ/sqWwkQ5X7BQ/HasaC/Hp37YPqvOttpr24i2B?=
 =?us-ascii?Q?KxkweXQLDJZ6HwKuhfRx2OxGrGwS5GyaxPInpFq+xVebIIqrq79LyIfLEIOF?=
 =?us-ascii?Q?YdvoWkSmc1Ox9ufb4a4SERbYj4D4+xH4RU3dTR6DeOUxlEMKX0XjVQVqytFc?=
 =?us-ascii?Q?+2yo96nn1oSQ4IVIXpMa0zB161+p8jYCntK5Ux7HXbViLQb5Q0fVLG2pzh2t?=
 =?us-ascii?Q?RO+YwIKoyQ+kfIpuwMuEeMz9+M2H6gB88TI+vt30LtwEybjIkFEgiNKIvJ2T?=
 =?us-ascii?Q?CoDK3ykKr287h02I6Ubh6JdCfbeWygx7BCQ7itwqQHZDOe/uFOFJwKwN9Y+P?=
 =?us-ascii?Q?ZuswpjgjPNituZeBaYZHAXokiw/I0h28sDENk+cz2AF5XnCLfKEeedkMlqxZ?=
 =?us-ascii?Q?b1ID5fXzCmg37UUT/fN0VHpB9GE84g/TGoiO0i9q2lz/CMVEFF6USZ68a7+U?=
 =?us-ascii?Q?uma51P8mk9/tXoKZgFdKLDPKg2Mas60R0qV7SFDVcd7Xj4JDR4YOWrRZEpg+?=
 =?us-ascii?Q?MhZOLUHaSyQTukTvkZeCosklWAlin5bcLM2kLHdI1OGDFrl2k5UxoYm1k9EU?=
 =?us-ascii?Q?BC0AYFpyDP5nRSDbgrDzMAcumqM8iMZr24ZNSqVFOx1X9R65NQGg0ZN8bkyX?=
 =?us-ascii?Q?pBmcr1ShnxElyUERAFMrwq0KMTObUfSRMjo6aGSteNLxbT0KcY6PNcrVCATp?=
 =?us-ascii?Q?X/x8n6bMctZ8zPhy+TpUOxgKtIRsZIG1d2D88CjqTFHqVZ7D2LRC182zXwM9?=
 =?us-ascii?Q?uK9cNvBx5wINdsJvR4TYyUq+c2ss2/X9AYw4LcAV/4IaLlBG9MBlsqg0I9ga?=
 =?us-ascii?Q?lpyODoHxc1jm2CeDE4u5b31YxyaWlNY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c713f60a-9627-46db-e68b-08de4f7a2735
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:25:19.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVpbqWNuqtox8wWBdpT2+62u/OxNAY5p5Y87BBq0jNYKEpEBpp9OZS6f87tB+DlZYGL5LP97hSKs237kebeEJa70T+7MAa0vKeFt22We9Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6875

Commit 084c3253d741fc9022a0169ab9ad95f7f943add8 changed the default for
libevl UAPI header installation to true.

linux-xenomai-4 already provides the EVL UAPI headers via
KERNEL_LIBC_DEV_DEPLOY. Installing them from libevl as well causes
conflicts.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-xenomai/libevl/files/debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
index 9c9148f..07c28b9 100755
--- a/recipes-xenomai/libevl/files/debian/rules
+++ b/recipes-xenomai/libevl/files/debian/rules
@@ -13,7 +13,7 @@ override_dh_fixperms:
 	dh_fixperms
 
 override_dh_auto_configure:
-	dh_auto_configure -- -Duapi=$(UAPI)
+	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
 
 %:
 	dh $@ --buildsystem=meson
-- 
2.43.0

