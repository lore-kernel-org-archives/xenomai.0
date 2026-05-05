Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39C386440
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972007; cv=fail; b=WTS9UiCBlmpyG8WW5gguAWADj9Q1hypWAbGE4nj+hoTl2+W5U9MNePAfChQXba478E0NkGaOdeFjIQitaaDg4DwiLN1zMEGI0O15/213lNab+dxTkxV/fvlMG9LxNe6affF1SQ89wfwf1KVeVeXsGo898hUb4PWzanNMGNBE11Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972007; c=relaxed/simple;
	bh=Zpiv3LiebO4dnUly/sXdwrXkVRG6PaZvwMIeTEirobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNXAX+lyzy8btfZaEW2Rc9q3pdQs6uA2fu1HZi8Ez4ZIVU2Juh/t4lpGLCIxOSSab4L/jwn7+uiqD2Q4BVSer+JpVWeTzG74FyyCINJq4U4ZevWLZ+GZoaK9KGasUzjxfdRQmjWeVTBbiau/g8VfHJO+UuZLG0s//95cAOujuZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D95Npf+e; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D95Npf+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okbUwAPtDA1nlFEmE+yvqhjr4PjrxEOhhSKx7WXRjwoPErKUKhDKl4B5vPXROIrEg7TSE0OeO1Gi8LXC3Lxwcn2q2wfuLCOn2+OB9nFh/nct201wYqFlBbDcEDiEVW0R04r+Z5FtyzPQJUXQovl1dhiR/HONyGUr3UFvcXirD4uHB8VWSykMn+oz4w8/xIXwYXyVZNkd9JKVszLEOTMooit8c+mC5acndPe5Cc2X50Vw/etld+7ODJKOEIB1+h16TXFbEuGMu3yjBoi3zdmAavI3AzSdEeUXXEJjTleKBOwiIapBJDeKEjdW1dJRlz3TeZo/6dS/XbGT1zMWrNc1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=ihISBF2I/6hEPT/QL+sS0nQdNpDFhljqSKXs5TsQAnSz0Fx6HyMWB4fmY15azuVWCvBI71WBqXwrMl7tQaLdzJssvICi1iAzjRf2e2b/l9BXN8eIQf2HyzyE5jVmLsA2xKAjKMPim3XTwX9Ewi9g8dvEpw///a/xgibfm+UGMyolNRMIhh0mi2pXOs8dC5WF55xf8oY7cqtokAZFHz7WICDafPHCbtqaE7BMWIZH0Sl73WNzcIXSipSoYdomt0PMyadJp2BfiF1s5ImYdQDevJ6B2/XZaTVp8rA1VcCY+6dWSV79LssbamB5eQymQyvq2ddI8TvdbAGp2JbWoNttig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=D95Npf+etQg5yX0A1LGXmbZNhlRzoICp6IAZKdxO2l/TqZPjn8NbX1OOx0KZHMyis8CYnXsyLQFgSb+obeDZzW4MfWW4A2r9HNfnpkVHRPEkckmrsnPR+tLEphs0/W0907WwsyPqrtnJ5YjtM05CzhSTbNOPcJ7r0EbR/bDFN5SBEU6YMuc7rVMzzL6p7Pje5cTTb7oX5EGF8Gf3JlRvQNuZ3kjOqw+eAy472IzD9PRUJQhUTzVeW46R4Wa4cMpU7HYwmKWoXSUSSMS2EK4GGmYIEXS/nhtBRRf+6L4SJ4mbTeAaVAuij3sWve+zf9dxoNiHUznoPyQ5+tmkXttG8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:06:44 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:06:44 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 2/4] ci: Fix deploy script to handle multiple DTB files
Date: Tue,  5 May 2026 11:06:25 +0200
Message-ID: <20260505090627.65515-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505090627.65515-1-tobias.schaffner@siemens.com>
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB8PR10MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1e9798-79a8-42fe-78e6-08deaa85a092
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IV8BKotjcHB5lGoRXR8CvKPReL/OfVRUmT0mWzAwtmadLBju3gs9YUJ35bwKlcGXBGcD5nRz77BQbr3pZmNeSw7mySfa0plwPD21PBXSmQ57kaXWJv0WhAp63P7XONrlWjSBpSp9JAEkGK1G/5MTOBc7UaPErMLseNMd1xMJcnWyDzwspNpe7//1uzqvsAnjkuom+997M7MMbWZP05mUwG7Q0ixcfGwI3sFMvZGqrwofOG4wexrcTz7Bf+RF+yhOr5sIyvADyGlCsMuTJ8LA6kdm9N6siOd5xAIDVTe5cDMQGg3XdffMtSngDrnzKA7aCuHsizQDMdnqALXKsjnX9OKs4qZYIG/6g+uFmDbZSVFZOTnjdCC2ToUVrgoyzL4IAKEqHmTuHJHRWEGEatnRnxmlqaavlZllXhawsYdZKESZK1TVex8kJvYiJqpqEH0k+3votLRRupwSLSrDMQ5t6dgMmIvFY0BJiUj9Ytxex+J+7a4FqBKky0CF3zGiCSpGG9PaUG083xmvkKx2a0ZT8lu9myr3+wYt1S0Pokya/haNpQi0qbY8HvyQmJ6mkFxiFtW+Hsk95MVu7/shVp9pQZeb3aCQ+RTItG6l9/G+XGWfuIXlmT2Z31z6GoSvt1hpFvlol4fhetqri+3e5LZRAzuWxAxMfx4Jy6zbufQDXIVzoa1ZzQeFmyRVXg/7WThI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ViPeOzSXLsOs0k4lQMy0z+0T3tQZfLPDKQ4ueW+jqh3dpc3QRCuOYtEz+RBf?=
 =?us-ascii?Q?vXFN9lHWiOQJxlf7iHTJxBIJqzjXgIKMXQY2BcmcbmAzMcNPJ/SDd0iSDt7m?=
 =?us-ascii?Q?ykaqW79JNpfgdaa/Sjf1aU6hNfHBslvd2PFpRTIU3v77YwV2zOvCTdde9Q3a?=
 =?us-ascii?Q?pDqyLYJWXmTiSTInnZFiQmrCO81BH3Z7baYSSGRxLAOOvzvAAtXTgq7Peo5F?=
 =?us-ascii?Q?sSrYriT9lBYG2rjw/UN6iy7pqEo6I94Yu+42Y1uyOn9Mq0ZfhJR/s+9PzJ/r?=
 =?us-ascii?Q?k+VrCD+f9ZoaNFqCb+TcchAyDXq6OQ2zFO4jB9kt7l4WTbGDxMswHCXsLF7z?=
 =?us-ascii?Q?8h3dp93limZ97mdUGlX3AHaU8ivplzXSgXD23FZCcRaENuptQV+dWG/6wLqA?=
 =?us-ascii?Q?yMejWJzpCz5LQS3aVe7mHKn2AQBHHh3ni31MYF/vtBWmBWtE4gc84XDDWVun?=
 =?us-ascii?Q?XVEfa8xOiY4uYNPBTzOGeh3gA29+A5PKHWQwOCoHW87/xHV+0HC3VY0jXdmV?=
 =?us-ascii?Q?d6lZQKx+RH+00jpYqaoafrlUlzm1YZHct/npBzblh53dk3vGwNj4HuRlrZ5f?=
 =?us-ascii?Q?G3WRfRNW7IOHmo/KnCimkjCmNoLTA8ujZL7juNVVn8A/FqxsGqzm8Xq7qE40?=
 =?us-ascii?Q?cI8XA0eZBGyVHz5ez7hFwLKm62GdkQ2SK37uixr6JBZkkhMcdSY2Q5/sF8Z9?=
 =?us-ascii?Q?QuP+e1OfPr9AMJ0wYlUNTXzCoEWwWSRnljfBAMOvmamaI21MT0yp3O4Dj6de?=
 =?us-ascii?Q?6E+hDWI6sRMys7sjlF1fXM/f5zuYyGCf7LL27yNkGWhuxC8/FUD8mzBhhaa1?=
 =?us-ascii?Q?7/tbQp5Owu89o3gfnpc9zeeHmRaxvYkgpaStSN13eabYoj452R9o+KkbXCuk?=
 =?us-ascii?Q?OkVtjwK7B0CD0mixnkY80tPE2jT5R9QGq5qIjKjqALWbAKuoKNY0xZfrDp+H?=
 =?us-ascii?Q?Kk57oSrmDFYt+3Jwb97WQAijWyjWq1OB2ojP8C3I7m+pH2LsybmX4VRdTPIU?=
 =?us-ascii?Q?3446878Ka+wkfVg8dr0WII2S+GuwIDC7pZy3UMW7aoBdPdhfq5hks0mQSruJ?=
 =?us-ascii?Q?C8VJokju2EOWlDgB+qzFGS6zVgg1nWTOA9F+MsCMHIXq86JuDeYvw4rLoYDG?=
 =?us-ascii?Q?QLu2oNAas8s0YkbKewT1kqkfcdU4pfc+l6YtKtyTxaX6/0c6qqToDvb2gnBr?=
 =?us-ascii?Q?e+Sb8MHrQxA7EGtNqAwUhhyMK6Rv9++ntUK9PKKlWSU5A/so7OmCAbvZW5Of?=
 =?us-ascii?Q?7mtfdkPffvq9oAli6923JWr9fkcTjAxDw+aUJLI6VipNRF1aY5XR8UwzZC8q?=
 =?us-ascii?Q?DiY4yhnPW0c3N6LHV4ZC7FHafqHbUYS6/vd+0Cp9DLwIXs+tFCZUjbLJZR/b?=
 =?us-ascii?Q?Mgcrz6DREZWV+tBaEitky18KG7VrafTc2ndhsJXw7BhRsQHC+6XvqMFKZ/XZ?=
 =?us-ascii?Q?us/Epoj713r0cN7NLwOjk92LW+lWKMLvLQeRXLQsuv6sbD+QN6O2GQMwuP9p?=
 =?us-ascii?Q?kXkEjwUGtoAe+wpENsfXMBopTMP+bddI6cvt1QvG5jZHbDB6ILNXa2pr3dWN?=
 =?us-ascii?Q?t9uQEswP0HsnK3m9QnMd+0QYo+Q1j403/ZQgJhkF+vNiK6QLrmjjsV+iDro8?=
 =?us-ascii?Q?co0hjP2NXemiymvNnoPdhIpPKzdVNWn4XN6pGfZGLFJvJH27IUtp8HAfIaON?=
 =?us-ascii?Q?qBkrOAKvXSlJF/RzusuWWP/d6VfrAmxo1Wt5tflMg3RIGOjx9F5CE04+dX1k?=
 =?us-ascii?Q?skAR4TxkkbvuOVGQfv8bu2WTUszBXQc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1e9798-79a8-42fe-78e6-08deaa85a092
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:06:43.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieupijQ6HlOxuqKLu4KtthbFRRVK1Fzag+lRjbPoWaQh9cXuyJmwImcFZs95y+INCjBnVoI3XFg8ZF6SjW4CWGMH0GtYCcVNRkhyGMo0e68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942

Loop over DTB files individually instead of treating them as one path.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 scripts/deploy_to_aws.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 2e0ee41..6c9d8dd 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -53,7 +53,8 @@ image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
 
 # DTB
-dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
-if [ -n "${dtb}" ] ; then
-    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
-fi
+for dtb in "${images_dir}/${target}/"*.dtb ; do
+    if [ -f "${dtb}" ]; then
+        aws s3 cp "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
+    fi
+done
-- 
2.43.0

