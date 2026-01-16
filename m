Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED7305045
	for <xenomai@lists.linux.dev>; Fri, 16 Jan 2026 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552889; cv=fail; b=KNuX+kOXB94LBk34Nu79fnZm6XK2Deh8EeKbBXpM7fSiCYtrNGrvvBorb9CwolzThPYJxWVn+2MCQbuYE8hq6uMRYQk+BcJjRH7/eRml0j9dSR2AuRbgU0wbEUmdIeNA6Lw359zCQwOL9cK9kRvzfpwV42efEdsIB7vtgdw2Cgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552889; c=relaxed/simple;
	bh=+u+hPsP+7LqPt4C9n3XnXCZVByY5JmFl97RggQU/91o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ctHW2pO7f0I5ko+nAy6iHZR9CWG/Bh4Y2kyqpHY3I0T3+Ojv/QotW3JhXEUL5qL+gtjyllVZ/yBtY8AH9EqN5FAoaQfGV29nJYkB7iG/9RCeOqFLVgJTbK2q/+puCWmNli/JGsvFcqWjz5WV8rnWcyQc9QkY4/vhv9Dh2NWk6ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FUTrN7r4; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FUTrN7r4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENCzrUjsRJ7rJltIe4vC7Em7W7XTvCAOxG7clN3fm5mg6Iff0tMkGOtkZMreISKCt9cY2I90Lim276EMZwi6/7WhlX7jKFDACM9Z4ZPoOwi/n72bTrXf+rtnHzOvfGnSPJuOT49C+Mqx08g/gi3exJ0kP9Q7u0xNNXQLtfnuISy/EdZcfy8i6aRU1Clst2zSidwXpgkkntuOgqZaE7Ok8KJCO/ToXlHSxlyorgzFaXrCYZ7IHpNeYAjaqQXVr269hgWYu+KI4Fgr6ViQDI/vtaJoVhXg/HsbJTyC3gQBzgC+KMUfSOsgKEPOfzzkSdp/HrGe9vn+4EwwfINKuvVkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIYG1cAd4Ah67roFK0L/eqVkdVirDXhByhSGUmVMfXU=;
 b=WIKMjlR4OBGn5YQo+JtXxq9sZHqyQmRNfG50CiejwAzqxkE2+R/Bm/jbJnubVx1Bga+dCL6MwhyYjEt9KCTIiRa0Z9oiaQj+2EUVNfXFT8hEAP1Gk+Y9hB3aistz+WB4U6/JK8QdhuZMTRukdVmOlGQuVUbGYRybKfPVx1edfIWQzFZJgMEaWT5ztMf9o+V5LhzZinKlpEqv1tvdkbcktKhWRccolAOl0exMh0uT44B9Q8apOI0ImVDSKd0vdpLg1tbQW4RU8mTq7Ky9fljSIzvOP6RcYz7r6imdJ3y1JJlwmWXgM/AwXJ3pucvRHoElCtcnj7t0jFoNVTf0/ztLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIYG1cAd4Ah67roFK0L/eqVkdVirDXhByhSGUmVMfXU=;
 b=FUTrN7r4D4xVAkBNBgPNZr2PkqmWzv7xYNzM78UM2Vg7NXEAVag8KE91qEzxA6TThfxTxz2cIj0u+5i995017JxQGJJpPgxFxOr2hPkMReOuXPVZsfShvojetGLDe7MTGlIQneeqZMuTjKpExi4fI+diJBEWOgXViEGuoTwyv+o61Az3Db0EdPLoAGK60GV44pzgeSvmBUn51zxkZhSrJ3/UA+fa1omcd8zVm9cx06YpVWhuT7MJo6B/91RICL15hDAeW+x+olkwxyI7OMjCQn+wxE7lroZ3GF12098gyhNhSb0y4RRpeYPOIW7MPvSLcti3QjnHEkqY+J/r1E548A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:41:23 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 08:41:23 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] evl-test: fix opt parsing ignoring shifts
Date: Fri, 16 Jan 2026 09:41:12 +0100
Message-ID: <20260116084112.2303951-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:610:77::21) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: ea239ce8-8144-4157-7d3d-08de54db0774
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+cn0ZgnNLsaEfYTyBxpwYXGSAbF8hGw1ZxhAUc+DORmp42QfNEj4oAwWc88?=
 =?us-ascii?Q?d8uPmAdSAOo257ltfXhmb9gdOgrXGfMFF8wZlBjUKMKg1swPjiYGx26gpP35?=
 =?us-ascii?Q?xCccJcRWchv8zGmpvQXgp8k79xWAI1q2wQK/9cGdPfsllWuGXZTJehSQNkoQ?=
 =?us-ascii?Q?WXjhcrSOzZQba7R7rdDtes0XNWzjCQdidDspc2nPUekRBjxQ7Tg3b2CCXIRc?=
 =?us-ascii?Q?KVwKH4HtU75QqoSOhsRDc2Swze7k1G9co22qjgvgi8uxlnR72oOZFDuvJ9sQ?=
 =?us-ascii?Q?LTy2bdBs8wqhoBuUNzyZazWWvViNQLwWJfC+fjX3Yh5QDvpkkKio9FC5Ce6z?=
 =?us-ascii?Q?cLXXxr2EAQ9REcWEHJvCX+DjLSsOMzkuc/QGhVIHNFWfYBUH1aCJ76IpuX5B?=
 =?us-ascii?Q?lnuA92R3CKJC2S5b2utCMpRYAa80dWZufbmZY69KzOtkY0tJ4iIYqNjoKjPQ?=
 =?us-ascii?Q?hpkpT6mUnhffMlp6YyBaX9CsCa08CAjcc/PMYNmNnvsiaRr1WTKAuqNtVdVj?=
 =?us-ascii?Q?6vExDVCO2HMh/tpXNamesklnipknQ9EJjQaOFazrtr4WIxcXJqLXtGCPiCGn?=
 =?us-ascii?Q?N1BLbWeiKUFznA6yfbnMxwTt+PMTbzTpecITYi2yF0c2zxLuP8RsHHGtv5vM?=
 =?us-ascii?Q?sCVqhx7OGsTTfpALisGJVJ0q6krVlLOqDg+SoU2yYgk2bwwP5hSg9T/EuSSM?=
 =?us-ascii?Q?pR6eSpPJ6JXjKKodQxmGTGHANexZDEWAMVQ5fMmUnxzLnxr9fDY6lIJQ+8JQ?=
 =?us-ascii?Q?SsZxbcMHkECxCV2XjevNruKh5qXRa+1IaToB8NfLVZ44QgbQCygk6ZPF0LOR?=
 =?us-ascii?Q?Fa9vCm0Ib717Ann4bSlCrvdB+NpjK7TogsmSk3h38J1zg429BaiuZ1X9Czhs?=
 =?us-ascii?Q?nqWiti1Q1HCgFYZEv6/WCBudj7lOxz6t8PnQvuVK/FOl0EwIfZijvubVTNEj?=
 =?us-ascii?Q?nQceCTodrik4O1VIe+HxxfppS+DoAgy6NUpFlJiJw9AMYAsxuZrSZ6m3EYHT?=
 =?us-ascii?Q?sbTa8phaVAo1lrE6Qf/kW/bkMVw+lxePpG4PabToAddARWLcX3qQS7xqmrbM?=
 =?us-ascii?Q?MKjXUk1ykb+MQhKANzohwaOgx3bZe4HhdrXOAi2aI1YA/CEglbQMUbrVLLlW?=
 =?us-ascii?Q?+LBLHUx1Hlxg3Y4EHRjghNZFhIRNzn8UiSQBGwttMHKguyC97ydPRte7wOnO?=
 =?us-ascii?Q?omImxgvBM/ppZdOg+yrJXVP94D1Ge67thu70I8TlA5pnfO+m+T24iu5+Aam9?=
 =?us-ascii?Q?iezSW10f15laHnKITfkK5uCTl4dtcmE6J6ogOu//Uoo4hIrvURqpY+98yGqY?=
 =?us-ascii?Q?URdObcpWtH0YIgsOPzEFp6vwq40I0oFUsN7FKzVZ/44KSTnIhpPGXq5DJtsq?=
 =?us-ascii?Q?OIrYq0fJlU9jfkTNu+z344ForHlEKjAOm+di4+IawlELPUFlRJndQcev9k5V?=
 =?us-ascii?Q?P1FzzKhe903/2CTpvFqUAzLNh4kGsNKzb4+0TgH+IYefkqo0I1FMmCcsqi1q?=
 =?us-ascii?Q?dzq/XtxcJMsmvzsdwxG+HXox7JpCKOS9LOv7t2wKAyC7RthJ/609c2kUa0WQ?=
 =?us-ascii?Q?Q9o1PsNWiMSmmmQqw6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eL6PR7hOusLmsVXXl2hNYfvAptcCNeh1+OOePuzONAKK1Iks5YcepM0uOJ0K?=
 =?us-ascii?Q?cuCKEuTBBjLoG6kQ+PDCVZX5p8hl6hBRquY1kLWm67ZLwYhQU+Vt24X5D84G?=
 =?us-ascii?Q?ArwG0MMYxpzCS8yc4Uvu1pYOcXPbfpSmRy9W2jRm67tMz7R/YkQrMvGL9vBg?=
 =?us-ascii?Q?2SsY2eEGDk4Vz/eZ+vDNnKLPR6AMOop3BNFv3yfRQ6bf4OTPId/+fifRpRqE?=
 =?us-ascii?Q?FczfI77nzogD9U05hi1vrClLZBLzGcM8x24dzVyFB0pZg5OGwl67Auy0OQ3l?=
 =?us-ascii?Q?NSMYKPEXRbibEJ7uIBIr8zjWg3/UaOObbHxZy6GZlWqjGdMn/SgD2Et9JWzN?=
 =?us-ascii?Q?4PTCBw5Has+O/rkdSfgIwY5+X58LfS28iPbACF06gDI2IaUa/F+CskvAan0Q?=
 =?us-ascii?Q?MfGhyQSyEayYXNDVhdu5LAM1fQltlkqn0Ey2JonqGXA73T44wpHBv0hj84nV?=
 =?us-ascii?Q?JzHZf5VjDURYYRJ6sHmUFqBOdpviPGGRtgUCwVkks2cifUcj9xWXOXC+egqz?=
 =?us-ascii?Q?16wg5jYOh/Y007XbVCBauHFmMkFOGvK7+nvpiFpMinQIe/96iJTvXwmnd9Jd?=
 =?us-ascii?Q?AvPetVAtzF08UDNlZEzgyx1rTZkTMWLvD8yDaZZKDBCN7QJtqE7ey191N6ln?=
 =?us-ascii?Q?wJv+EfH78lpRQaHXW/K0ESZJ/2H/0WWsIn9dy7fHK5BCACq1UVhJQ+GVLY3J?=
 =?us-ascii?Q?0EY3/Km2KSegc+Mo2iIWGEcNw1bUuXo0jsib0oo10MLyt1fHE5512UwQU75j?=
 =?us-ascii?Q?ZslI7kNXaWUDmps9LLpdLzpdeHDDlp1ziBYHzStyj22WPJs3ubSD7e1OQmSU?=
 =?us-ascii?Q?4lko39GFbvSaZ+oKr3wz5C0BK6uIArVPAw2Meo7sTVPwZ/kY4p1QRJcr+Pyj?=
 =?us-ascii?Q?dxfdxP/Dm7IX1gDG3yWaH8TTDlH7/bhWRiNr2SQCscEI/7AV/VhokcFNfKz5?=
 =?us-ascii?Q?wdub6h4YegeKyJ+TztdmR7GwHqzbuHyFk64rfRe3Paf262IsR3izgryUE5DU?=
 =?us-ascii?Q?iSNNKMQlUwLIFjqY43wQksLgfDrZW8Q5GsKDWvYM4e/KM7uqfwK+MyFJAQhC?=
 =?us-ascii?Q?Ans2img/QELs0L1fYv1WQoGreaxDvU5vsE7f8qZvgB6FYE4SxoUAmyuzyEs9?=
 =?us-ascii?Q?sNZB7rPrjTtaM0v6/uOBspYHNAW7eDxr9X2YDdBODgGOPXv6abfjP3Gai0lS?=
 =?us-ascii?Q?+sfEPZGdheMMum87Pw8WHurWedUxzF5D6+74mv9LzIjUuF9Aa+zRG93udU7i?=
 =?us-ascii?Q?IjhMVspNTsH/Lw+Lbi07N0zuKoqQbeiB2sNbDGONo04y0Jvp9mNqUC6yePTG?=
 =?us-ascii?Q?xMBqgFOzFgJj7vI57d5hx4U45mHK2h2IyZTGbB8dSaj/W+fJhjjmtyX1eakx?=
 =?us-ascii?Q?qTa+KhVa/3xBkqB91pZScHU4wsQLn6Scqnd0TX1iLPR9DSb9PsZIe6We3ON1?=
 =?us-ascii?Q?VRWy8X8b1r3xAfwYH2Rik8ijWfWw0UaP6rAg3BCLR23zsXUR9PA2z8GWVLvO?=
 =?us-ascii?Q?vxzd9PV1/XU8q4lWEfUgFOTpj/AMTQc92ACHcAfuayfD5zBgTp15WlRgrKK9?=
 =?us-ascii?Q?apdLuavaXzSTG0Dn05djAd3kzgbFkVzdPDcGCRkamvtPxtewiOJ/hJ3CXJ41?=
 =?us-ascii?Q?bQH7Hloy/ivfHGbnAVtcur2+RBbrVt9SeZu/sN/HzMmmrDxySxbL1ARyl880?=
 =?us-ascii?Q?IAfzxcac6znRxygAvwgcfWW5iLv+0AidCcBalk3LtJ99p6tVwq0OWYFVISBi?=
 =?us-ascii?Q?GmIC09x7Uu9rn8FmGJjoIK+DsOLxRvE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea239ce8-8144-4157-7d3d-08de54db0774
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:41:23.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O1yCFCgbFMOUG+j+lfixTEP/ksVpgAAfD9yrIU2wZChrIibx/7wMsGJ6Zu/gBzk1ewdZV7GefaWyuglO/PbMMN8pjhSh9g4FywIL0H+fLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6451

The for loop used for opt parsing copies the list before iterating over
its elements. Use a while loop to make the shift calls work as expected.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index 0d0ca81..f17a781 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -18,12 +18,13 @@ test_args=false
 test_arg_list=
 test_list=
 
-for opt
+while test $# -gt 0
 do
     if test x$test_args = xtrue; then
-	test_arg_list="$test_arg_list $opt"
+	test_arg_list="$test_arg_list $1"
+	shift
     else
-	case "$opt" in
+	case "$1" in
 	    -k) keep_going=true;
 		shift;;
 	    -h) help=true;
@@ -39,7 +40,8 @@ do
 	        exit 0;;
 	    -*) usage $0
 		exit 1;;
-	    *)  test_list="$test_list $(eval echo $EVL_TESTDIR/$opt)"
+	    *)  test_list="$test_list $(eval echo $EVL_TESTDIR/$1)"
+		shift;;
 	esac
     fi
 done
-- 
2.43.0

