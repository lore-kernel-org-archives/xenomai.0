Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675672;
	b=bNvtoAhn2sDzjB+Sm5NjL/zXKeSW3an4ip0NCnDkvizmfR3b6jNraBHVX12j7Y4V0hiA
	 tptPp7Bo7K3mxEZDtd5ADmiyiI2zQKRV6l6PcRRlvA3v2RrB0n7oqLfWOqRrMX9cCS0V9
	 3kdFCENj9vzRTFQz7WUVrbeUYPFq9FXm0l+pLW6ldwmu3lnBt7zyDav44wlIoMihB1HPv
	 Rg4uttQMEdWNRr4oJaAkl250rnru0v0ZfFuzV/xIGFTDwz1JITNNb813/ZSQtr45QdCx8
	 ybu7e7sgODax2+ORLPQQBNWP2bG9KyPQ9t+TsA6E+gbDi1mxzsViP5rg+yIsOeShf9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675672;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IwmOxdt5O7vfslyLoP9sl19OVT+DR9U2D5xg8T1TiHY=;
	b=A11NM1qoo/NwCxDbDMDDsX3m1hsEvyr/3+lRxH1iE/DmfeQo+btllRpFlIVHTjNWPZIw
	 xEq/TYMpCnlmznyu3KOmXGbGCqa+07V0ngKk3eal0l3zoXTA03/CMm+BV3Rf15So3ls6j
	 gzbZCSF9Ny/X1F1DxYgi19FTpIOsbauaEHj4rdvAoH17ohkZLFMxveAV5H12FpfGM8fnk
	 q0cQbnXV50T7ExPts24aY27SxjtjBuvA1JsmLWFh50YUrFSgT0YpHEpoAbhKb3gccUcdr
	 /oHr150LMaCDYYr6l3qNlqOW/gRkc4Cqtm36SrXgLOXE6+nDBavTFomuqGoRuNqy3tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="lRW7P9m/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24425606A31C
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 06:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24425606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lRW7P9m/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGABZgUgfiP9EXDSb31P1V22P1X5aL6yDjAVMHoCOH++6IwVDLhjBUako/nBUjgmLKG8+VAsJiB8tRMsBt6oEGNOC6o9ER3Hp54oV9u6V7PmZYF7HbReOW1CLB2aVjcytE/UEm91fVQA0iC15poIl1E4tMfk88LemsuLnSMYKIbSpbZoRptTgs9QHqqMweZU5B0+rJPa9+VHZHwoDSW521VxQerGRCUXxhzaux/6Vl4qsQORMfajYJfiXaF/eT8HH5VXWR2gpzyyFRY36mjeXky0pen/dlPLhPaWs9UN8KlUr6NPOcnLdJTqaaFK9vqUfhXZV0pM32nEgzci99WwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwmOxdt5O7vfslyLoP9sl19OVT+DR9U2D5xg8T1TiHY=;
 b=KtfiBJpTC61JbEpwWBLiLqZqUXRVVa71hH3r3olibr0Mnv9clGHt8WDSmk+QtyqhE6AzzHwQ96aiI9jGGfKJnqQbq8b/LDwl6b4VOXUcq91XjNSphVZ3DJE4Fnd8047mW3eQvspBF/vEru/d6U7diRh2efaEVohOeWw+xg+SvfGCuZfi4FTBHwjcuhb+M/R2mqPuruHys7Z5NdWwoKshaKBzwS0vvdCXsbDXaWdowrlzaprPCUAk/ehL5iLZ+etkyG4mS+0j41eeyD1geL1d90870uhDY01iQt2Rxp3sKbsad2AH6JsUSpbdWKaiLuHAPRa2QwJivXCpNsiJ1DEfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwmOxdt5O7vfslyLoP9sl19OVT+DR9U2D5xg8T1TiHY=;
 b=lRW7P9m/jS5bRuY/RLGLcuRlt1kFYjIxSb0HQKk2dVJeNCRNVANGXrHTSZdTxE9hqBSqjy4MvCXE0wO9Uo1xCmsXN0LHdtA/R3FJpsv2gBjiBXtSE2EGYoI87m61oo6q1NhMJ/m1DtQbMHbchh8ocaP3Kd7srBLPikcM46iHt7N4Glyn59qK3KcZHtgw1NnmP046qbvzD+0HZnRKrcLYZ3KCl0YQvFzt6Oc9Hv9zF2ekGCyT3Emwf46RKqfN8JHhy4xILATZwj2Da40C8dX7CRZVLU3XNhmKH7LZWBJr6oofhWhgtHsJI8jYkmyTVCzOt1/5mMWkRd4QtQHLzwdhdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 06:47:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:47:48 +0000
Message-ID: <a2b3f0e9-0696-43bb-8635-7b20b72b2118@siemens.com>
Date: Thu, 26 Nov 2026 07:47:47 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: smokey: vxworkstests: Pass --vm switch to tests
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: d330cf98-d09e-47af-2172-08df4b892efb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|55112099003|261021123027099003|260925021311599003|260925021911599003|18002099003|261021121427099003|260925022911599003|261028144727099003|261022105027099003|261102123227099003|261022075727099003|261026140227099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	S6aLr3B2HNl20vEJO95dvOzhhR2Z63nbQ5SdHpdLiZ3fch8KGBkl3w1MOIUW4otxkWrTz3lmI8yayoWzd5GjtejFDCiRPAkoHNuakQd8lpdX/CR6jNLUGJgkMuJOkngwp1HHD1ZOoUfG4/AZFFrWfLmcaFd9LSGeI+pSX+pLGyJDbJMxG8PK6/2tLROEsdxjb2z3bGxatQ1hDDfYxdINcg8vnWkRBof0aaGBBWwsK/c01TaMtMlqAc0c17UKX+szB63ZrWs09YGfR5Hq3Hrw0Fvw5ol1UujbVUG4ehV6L1XHZ1Kt/pKVHxZrWZsdzQNnQeaprUMEM+QWKFDbCzrCOqvtT05l6bKJvrm4zUGIWrJkIP8ds5/YcS4m/BxxgnG+rKOi5UrupGbzsNyUNvvwv79UowwO7jRygDHXk27zDmFosdFxUIAhgq3B5606lNXyX8uCn1ofRHas/Fwa8YU9wAM9uNnwC7Nehf52d3rcMhoO/qGc2r4xllIkST2GZ59pYLwqoxmfxNkdko3C9aew5HaU2WssJYU55/AWwLPCPYTgOq+i5w8n9wnQFStcwUO1ZNA2Bf6SvWcbguosi2aDwawjeKPVtitgz0XLEeWoeVHmssNf1/vz/ir72GGU3HzZarTvwlw1FUYqL8B1/TbikdlhSOkUCW4jB9e5wq0b8T4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(55112099003)(261021123027099003)(260925021311599003)(260925021911599003)(18002099003)(261021121427099003)(260925022911599003)(261028144727099003)(261022105027099003)(261102123227099003)(261022075727099003)(261026140227099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blU4NTIwd3J3cE9URVVlcVRXNkJ2NnVxM2dzZVhzOHBrUGpmSFlIYjVrZkV1?=
 =?utf-8?B?VjV6MmlWMUdWSklGTFlER25Pckg0OWtTZmpUV1cyMDBEOWcrMDg4cDlHRnE1?=
 =?utf-8?B?Q0ZLcUNRRGVpT2wvQTAzdlh5dzVpbnAvdTNrOTBGWGJLUjgzOXo3aW5lOEE3?=
 =?utf-8?B?dmxjRFBmaWNBUnZqNEdOV3UyeU5NR0Flbm5NemRMZFUrRGJUN2pubzV0aGFa?=
 =?utf-8?B?d2ttZDdDQUw2RlczWjcxYUpVRFU4N1M4TEVUYlRoeTBDYTBJWGhrNk9UT1Az?=
 =?utf-8?B?UmtQbTFGNlVCQWY3M0JDTUo2bjVKSXA0NXQvU3hMRVMvYW1DaFBObFozL3RS?=
 =?utf-8?B?YTBLYjFjdy9idVo1UDdzVGdrS2FsaFR2eXNJYjJ4dGNIK24wT2ZQdHpCRk5p?=
 =?utf-8?B?cGZMTGVlblFkdGpidFRqam0zTEpRN1U3T3J4cWIzeGI2Z2w2RGNISGtIRzE5?=
 =?utf-8?B?QXJtWEtsMmlxK1FGTHdROEZKMFJzc0ZaTFZSeU9MY2J0ZUwwSE85cXBjTlhQ?=
 =?utf-8?B?NitxMjl5RnlBWVowMG9sYWRLOG9Od29sU2tmYkJyemE5cWJZb1BSMkhkVjNF?=
 =?utf-8?B?eS9aVE43Tjh3WnhObVY4RzRienFhMXlyUU5oRXZuUmVKc2ZMWU9oTmR4MXlF?=
 =?utf-8?B?RVh3empBbDErTVpZVllRVFRQejVlUEpjRmlwU3gwQUJ1eFNlZ2ppdnlrNndN?=
 =?utf-8?B?UU5weEJaTXBNV05xck04N3hrUlBxLy9yekhKUEI5UW5kb2NLZkZrcEVtZVFI?=
 =?utf-8?B?c2FUM1hVMm1JbDE1SW1PNFA4d2RKUVYrVnB1a0J6VzI3WEltbzZjN3ZLYkNW?=
 =?utf-8?B?dlpYeDJGUGFFaUltNExTekNVUUpWWTBBYld0WWFUb1RqZEo0cWdWLytCVjBP?=
 =?utf-8?B?dythQzUzS3NMSXEyMjJOMld4WVNYNld4YTBFSm5VZ2R2OVVWMVZuNjZMR0lN?=
 =?utf-8?B?dVhnRWpDYnRkVks4TkRzL1hid0VkMlBuRENmdGltRG11TElZMlphbGswdDRU?=
 =?utf-8?B?bmFhZ2VzOTN4clZRTm9ZTFdBMzRBbE5WOWdYdkdsRElLWE02ZlVTbWNXdVlX?=
 =?utf-8?B?c0R5SldaNGxHajRyamRUd3Z1d0RNMU1BWWZCYk5qYTI0SXFXMzBUTHlMVnNl?=
 =?utf-8?B?bEZBVG54elV2c21XU2tCdXNocmNsYVozMldDNmt5OWZQdkRyc1JTVXByZytC?=
 =?utf-8?B?Q1orclcveWhmN0F2Q1NQbWtVcTM3SVVlUHY5WmNpdlUzQitvRzNmZGNQRU1t?=
 =?utf-8?B?WjNjTXZmYjFoQW9Pc3Y5REpJQlF3ZXR3WVJwdTZKZXN4NWhBSzk4SldWc2xQ?=
 =?utf-8?B?Nk9IUkxKOElvYjU3d3BYZHZ0MHVWWWRtVnllVUhZZnpRWHhyQWpYVVRuOGRu?=
 =?utf-8?B?Y1FaWUFNV2VMMXdTUkFXUnZkZFI1eDVxemNFTS9XWjEvdThSRW9oVzc5MlVo?=
 =?utf-8?B?RTNXY2VYL1pSR1NqYU1aOFJlbTVLQTBMMm9zNnVuZDJ1RVZBTG93RTBsZkpi?=
 =?utf-8?B?R0ZKakFJUTN6VnRSSkV3Y3F3SitvN1pYZWRjc3lXZExBNnZkVTdibDJDMUxh?=
 =?utf-8?B?aTVBY1dpVXNyTnpZUm9oWmR1bXBGZ2tHSGJocVFoczVRUVhpZUVLNlp4TTdN?=
 =?utf-8?B?TmVWUWwvTmpMOHM1Yi9nUndxdkVqUlhSOWF5QWU3VVQ3T05jMVVHbzRKQXA2?=
 =?utf-8?B?NDVuM25TcVM3NjJNMmtDTWtaM0g0TENWckwrdW9PWjNLVStPS290RzYvWldV?=
 =?utf-8?B?Q1prVTVoSVFlMGVuaUhOMkFiU1ZRcnBjaXBvbUhmYnhjVDAxTDYrTjhVNGsx?=
 =?utf-8?B?SWVSVzViODdOV1EydWJKa0NhRmZqYmkvL09CMEJ6ZHhHRFJrcWgyMkYwK2tS?=
 =?utf-8?B?ZWE2TmlwNFU3UzBZb0RpR0kyYUlyaUFzTCtmZ0tKY0g4S09haTI3UVkzTkhy?=
 =?utf-8?B?QmhOYjFSNU5FdkhvNDZRVjNFb2NPbCs4U0dUVWkvdm82YTMvdHJqMHY2VjN4?=
 =?utf-8?B?WkJSc3ZEM2l1cjNOVWpjYVM0OGtkNld3TVFSMjRvUTZiQXF6NDNTZ3NiYmtI?=
 =?utf-8?B?WmtXWXdjcXBEbXdTa0JHb1A1V0JvN09pa1k0K3RKSVBUTFkwZmxSY04xT2w2?=
 =?utf-8?B?cENYeFdMQkRZcUxEeVRSVnNXK2dTNFRGYmNPSGdDNE01UVB5RTlud1pZSXBm?=
 =?utf-8?B?OWU4Z050K0VRRUs0ZVVhMXlLSERCdGt6a1l5ZjNFaGg0UjVJdlFPc0ZtZEFl?=
 =?utf-8?B?VzVuRHdabVZvWG5EczNkZkE5djk3NkMvbEJzU0EwYTAyYzYyalJ0ZXI4aFRJ?=
 =?utf-8?B?dWtlclRqTWQxWlg5YTRVQVIzQ3o4dG1yWEo2NkE0dElZdUgvR3hkdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d330cf98-d09e-47af-2172-08df4b892efb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:47:48.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlCpsZZqr12CaT5a4geL3huZhg3a/B71qEbEJQ9noo/SrbdscYS8OeeuSRWzcX5o3ZKoFKbUPFq5AjwgejfS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten while introducing the first users.

Fixes: 79df634b5b23 ("testsuite: smokey: Raise some delays in skin tests when running in VM")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 78068a4d15..5287380679 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -25,6 +25,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	smokey_note("vxworkstest skipped. --enable-lores-clock missing.");
 	return 0;
 #else
+	const char *args = "--vm";
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
@@ -38,7 +39,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 NULL, &test_ret);
+					 smokey_on_vm ? args : NULL, &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
-- 
2.47.3
