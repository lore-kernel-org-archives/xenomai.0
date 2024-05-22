Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DEE757E3
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357632; cv=fail; b=p8xyHSRzX8GJJod8vG6w0iEsSlSPvil5aw1TicLDEvsZJnqBxZ8eE7wPRSefsZPpQFEydlsCMi1hwM/PUP2WSkC7tMvqlH6wO/POWrpRVVLhtfiCwICCeZK/EdpjX3QezDKWUwb0ALWlB+AyyoRYtFOcVkiowzITuiuxlLWJiiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357632; c=relaxed/simple;
	bh=ms+djEG3rtGk1VtXMqWsaIyc6GWaq5fLDXWyMgneCKU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=I9LDCNV5Cy6qVdiJ9ADijzfa5AMqdZzHWlxTPpAmSkG4yaKXQpKK68UGGFgc0OFuoztgRcEkeNnY/aD9JGdqNar/K2p6ecdytGMJ1toESMkE3kDY4W+NYmTxLLAlvK58qI0nhiGlgHZzHB22nXc8xxao4cbpT50XBncrTdmUnxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Zkegc2jv; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Zkegc2jv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj6SKJd/i8eCc85KrshiGUEkydc6zeX2MRqYVrOBFs4uqgkTs/p4L2LLfZ+z+9Aj5FXmW+Db4z98Vyj5nciEPJ7LBJ1+vS2FJuTQeKQn/OqM28IVfSnXfwCcMcbLMJr4/+ci+pLtIiQww0yDFmu4NB019W+Q82NRp/8cagXtlRXTLVSsmI61XvuGzMYqf9U23j0t9z5ry9uLtzDWSeIRxhv1aW75eFvAtUPlPRow+fuzXSLjuhvb1l9GQOpbOlUY/WAoUqJF5Chg9es7QcyeSLjaAH3BJce/XJe3r8bBcC4Le3HsqEw2N9rC3tdmhHhBhrxXGpn3fQQvEiEYaMEg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovpwRikZkAt+iU8ua/CtenfzEJxcP4/2MJME59CK1V0=;
 b=WEaCEWPOmHxzkLBf13/c94qg7EGEK/54NMVLyXCVi1rYwRYIHfS1Whbkfd68L77vThV5jCTUfUkfshJMN8hL8Pc/Qd+NTYmPuy82oiJa8wf5JQhOXYfDpVxPG475z/QnOX5pBFFV8nYVGP+L1i2mXulowJBap0yQah98gBqCDTZFHZBmrlbgFKU3m/eFflmqfbnggUR3SyF/0GLKp4EpUHs9gG92ACjbPS/6OXNrHjiHh60/lnnDBG6RCqm7t5OjndrYqS5Om0Czk9O+SxsnjPoIq2znKwgeC1XPrvHpCCXzJC6y0359YtPgTCh0RVX0Cu4UXvGM8Bo6FYGHCXpZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovpwRikZkAt+iU8ua/CtenfzEJxcP4/2MJME59CK1V0=;
 b=Zkegc2jvaEu6D6zsv+iSPYanum8U3Ni9qIZ0hMB0z+/cDYYKLmkIeUZtMNvynK+Ft+fsndwwB2pv4du8IRxifG3xE93y3a5nsSSVKJDbBlsbBippD9HoOaYJbXv41gzq1CXlImeo2W8kGHiecplFiDbpeRG5AS0th50J2By6592hBZaMa+c4m72Zz3GOZroYboQHRiGZUM7IBB+O4KZ8sWPK0azh3V5PzcxZziFLb+Zr6wdeVEZgTa4lJwS683/3sU3n7jKJp1DOkyDw695yNtlcMjCtRw+10tRMb62/UJtqASxXHx25pyrP3ncEbI/VBv1YIzphx0p/sdfI9uMaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:00:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 06:00:24 +0000
Message-ID: <5b789e4b-5375-47fe-a49e-f48fba026250@siemens.com>
Date: Wed, 22 May 2024 08:00:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers/spi: Avoid legacy functions and types
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: da9291a5-f8e5-4ee8-7b19-08dc7a24788f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THQxSVpOa2lHOENIVTBWR3ExUkt3bXBNZUZ0dy8rUkxScUpBSFVQWU1JMjYr?=
 =?utf-8?B?cjQzRExlb0E3TkczWkUwZHN0ZGtyc0tQbzc0bTFWVmp4eFZCbkdXOWYycFFD?=
 =?utf-8?B?NTJGTDE4SDJKQ3BVMEtMckZBdlFodjZpYms1NVRTc2xXQ2hVQ1Uwa21mVUVF?=
 =?utf-8?B?THBXbHRpZHR2NWFSSnkwNTdsYXU4MzlhS0pNd0FWaGhwNW1wc3UzZWpXemVs?=
 =?utf-8?B?Sk12WGFqV08wVDZpd3Jtc000KzRTYlUzaG5MZk4rb2JSYm5CaVN2ZGVCVXRq?=
 =?utf-8?B?MHVYUGtJN1hrMVREcW1kVVpLTHhsWVFWdEFWeW5IVTBMRFFYdk5SMERKZDlv?=
 =?utf-8?B?VWhPdU1jeXJqNGF3SS9GL1pxbWc2WDlpOHllZmQxWkRMQWI1a2J3a1p1OUZr?=
 =?utf-8?B?UHdnaXg2QUNNVkhBNE1oSXZ3NzFUQmtlOGJ6SWpsc3JFTWg1K05NWENGN1lE?=
 =?utf-8?B?MDE5TkowZWdmN2RsUFoyTTFTV0swZTRnb0ZLVlB5d1MxYnBjZ0JldWRHZzUw?=
 =?utf-8?B?U2FvbE1sVTVYMWdWVXd0SWxwRmlKTXJhTTNMdWFqZjFJN2l3bk9idnVTN0Zu?=
 =?utf-8?B?U29ualRQSlJXa0cxTmhaWGF5ZHhJaThIWVNlYUhsTUg0MFJqa0lONEs0Vjhp?=
 =?utf-8?B?MTB0ZlRMMzNIbzgvVll6Vm81dzNLcDVMbGxkOEJaL0pBaUExZzVxQ1VubE5Q?=
 =?utf-8?B?bjdOQW1jWndoL3kwTlJ4b2ZXS0syckV0OUJFUVlDTmh2Qi9TbGt2ak94anpx?=
 =?utf-8?B?VjM5Q1hHc1QwQ2N4bkNMc2ZYeFk1ZGpNem9jSkU1aTVLSURFNEpDTkRWMXN4?=
 =?utf-8?B?MGQ1NUl0ZWlpQUNWUDdzUGNRSFRSVnVBOFpmeWM4VzE2QkpTd2lScmRBY0NW?=
 =?utf-8?B?YnZyZHhRZVdoKzAydEZRYnZOV3pBamxTci9TdjlNQ2Q3a2t2RG5Qa0Zicytp?=
 =?utf-8?B?Nkp1S3k1TEFLcTJ1MW9XMEltV2dGZTdQcStyREFEdEVxNUtTK01EZjZIWlJL?=
 =?utf-8?B?QVlBdDYvOWphZjg2dkxqV1VhZTJ3d0NiQ0pwRHFUc1BRT0wrTDlRUEJCNlVB?=
 =?utf-8?B?M0swYWRnU21sblJLdGx0aXM3SkNmdldna1FKTmx2eVYvS3UvN21ULzllbk50?=
 =?utf-8?B?MnV6OHhMN3QySytDWFZqejFIMUM3ZUNaQXZOTDN2YnFMb09hZ3BqWUQvZk5z?=
 =?utf-8?B?Vyt6elY2aENTRjJ1R1NLZjNmVFdrNmFVdXY3Z3FZbmhRRU55RWlDandPMEdz?=
 =?utf-8?B?SFVDRUJqU2swaHNtVnVCSjdPMkN2Uy9mN01qMUt4NjAvTlVzTXNmMmo4RGYz?=
 =?utf-8?B?UFBBYUxFVU1ON0s1SjFWRlErc2JiSEc3Vkk0Z2VkN1FKR3JJbGE2YlFWL3lD?=
 =?utf-8?B?dHFrMFhoeEhCWHhEaG1rMllhOG85cUZuMVVCaGRkcTRjVkpDR1Q1OWVIV3Nn?=
 =?utf-8?B?NmlIdTRka0tiRFZsSjMyTFk0TzU5MVNQcndOVU5waVNkUzd1LzN6VERMUHpU?=
 =?utf-8?B?V2tVQlB6M0xpUlVyTDZqVm5ZVDBUQTZBTE1MMURVNVZ1OTJEMVZIeTZZTmNm?=
 =?utf-8?B?dGExL1JHNG9CWHkwZW5CaVVuUU8vbFV1RklBNVczbk1jWm1sRE1PQ200UTdD?=
 =?utf-8?B?a0RVU0p3a1ZCbEZyRUtKWVh3QStLZzdneTNMTUduejExYU1XaEdZbGE2d0t5?=
 =?utf-8?B?SVhsV1R6UFRRQkV0UW5kdE0xTklUT0k4NHhSQytUMGVsMWpRZnNEK3pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXIwazExdklyQkJpTnVBMVlFcFFYaUpEQ2NVaHZ4N0Z4OG80NU1yb3ZUUHdG?=
 =?utf-8?B?ZXQwMWRualZnem1PTmg4TFp6TWZkbWROMzQ3WTQ2TlMxeVF6SCtOMEFnNkx6?=
 =?utf-8?B?VVNzREUrMXZxaWl4bEhKRnpPTk5kSnM4SE41SDhVcVFORFpqZDN3VmNINUJR?=
 =?utf-8?B?MGpKTllXeEdsRlJDbjFYc244SVE0TXArWFo0NWpyd2xQUTRsaGJQVTgydEMr?=
 =?utf-8?B?NzBBUUFmbzFobTlCU3NhaFF1Wk5wNHhpMzZCRENla2RkY2I0aXpwOENXbThS?=
 =?utf-8?B?cFBSamtxZUI5UTlBNzFSOGNHMWtwYjFMTDZIUjlHTUVHUXNEekpNNC8wcTBk?=
 =?utf-8?B?RHdrenZvdktiVGJocDRaSkljdEp6ZjhjdXA0RjlsKzFzMkdDUEQybzkwaURN?=
 =?utf-8?B?aXFBWnRQa3RDOFpHMFJqR0t0NTltYzQ2STRtMHFGOStodVQ3ZEg4bUg3OFlI?=
 =?utf-8?B?QW8xdE1XY091bnJHbWc0S0k3c0xzbisvSC8wb3REeGVodnR0cDl3MHVhU1Mw?=
 =?utf-8?B?M0xCM0ZtWTRrQWMzdkpGNUNYSWNsK0s0MFdiVUVNTC8zZGgyOFBZYkRRTzB6?=
 =?utf-8?B?dUdoUzcvUFlWc0hoNkpnVlRRMk5ZQ1BMTEJpZW9Qb2ZNR1lBakluUEVLTXdt?=
 =?utf-8?B?c3phOVdkT3VRbHBvVGlTSWhzQ0ZZSGppQWpha2l0a1p5UVFmeGRKZkNDd1Jh?=
 =?utf-8?B?SEM2TDArdWpjTUVMRldWbmJLRHMzdTllcFZPTDVCUStEWDlpckI2V29lR2F1?=
 =?utf-8?B?NVlyd01NTU5kakoxNG5tcVlTYXN4bjl5aHFwSnNEem1yb2xIRHZSYjJjeHV3?=
 =?utf-8?B?RHU4em44ZHMwaHduUGlGT2hXN1pKSEhjZURDMEtLa01ZVmZNUkxiS2pxcFNp?=
 =?utf-8?B?aWVkMkowSHMxUENWdFlRdWpCcWdMQURUZDlGdW54VFJ6ZkN3UDZWRUR2cWp4?=
 =?utf-8?B?TlN3NHRObEpUUzBndnhqelB1TlRXQ3hVQUpGeDIxYWRKWHJBTzhNN2ljNGlq?=
 =?utf-8?B?MGlwUW1PWDF5cC94azB4c1Ivajl2R3A0S3ltbFpXTDR2ck9nazd2aFlqenlt?=
 =?utf-8?B?blVJWFNtalhmYW9acnRpb05uNUtmS2JBbU83MWZXTEx4WUZBMEtvZGF1QWNR?=
 =?utf-8?B?K0w0VjBIaXdLTGMzVG84RXorWnlTcVExNWZMVU9PSU9aMndUMFRyMlpiM2s0?=
 =?utf-8?B?M0I0eWg2bFhyM0N0Q09xZjVmWHFYaVdYQWV6VnpmbS9SZWVDRlFHNmdCNEpv?=
 =?utf-8?B?b28yN0RSeXZQOFBQcWpKQlY3MCtLZzNYMmlHMy9VYk5DK0g5cythSzRSQjhq?=
 =?utf-8?B?Z1liZEp2OUgrNUhXRGk3VEVDYWNWRlVGNVVHTDRrKzBrOTBFVmRDSVp1citu?=
 =?utf-8?B?Wk1JNFFwQk9lL0piVXVCVDJGaDVoeW54TzkreDBSd3VYSVlEbWxockV1N1BD?=
 =?utf-8?B?elJuVXdQVjV5ZnNFdkZVRjRqa3lhZWl3NXMvVm9IMVJjUm03NUdtOXJYenNy?=
 =?utf-8?B?TUF4TXpIei8yeitIbThCdFZhZFdxUnZqaGxVeGx4VXpPQ202MDZ6c0JMVjNm?=
 =?utf-8?B?VThUcTE4aVRQWmt2SXhNRkhmOTk2MkY0bkhwNnFXMDJDMnVTNEhZUVMxSkxu?=
 =?utf-8?B?cnkvWm5OWGdUbmlSV1RSRmp0TXd2UzlwR0RtcTlhb21HSVIrWHh2QTBQalcw?=
 =?utf-8?B?ZEEvYnNGNTk0eFIzbHd5dkIvQlAwREFFRll1OTRxNlNDbjY4WmVZdmZsaGJu?=
 =?utf-8?B?dXk4T0wzektMaXh0MURiamtoRTB6aUllWmFEam5PM2s0cXJlVW4rMXNDaXZL?=
 =?utf-8?B?NnlMcGt1R1ZJajRNNThqbi85ZEEvTU5odGFkZmh3Yi9KT1NPeDdzS25za2JP?=
 =?utf-8?B?V1BNZmJ6REptWG5POGNpT3JadlVwMjk2bC9lU0YwK2xqOTZTMEx4Y01SbTRn?=
 =?utf-8?B?a2EzcXRVb1lnZkxlSVNNVElnWE5tNVBFb1FPNjhyVkNUSUtTS29XamVDL283?=
 =?utf-8?B?WXFweTAwOS92Z0pZUzIxK1VoRFczaEZEOHd6aTMreDdaczRJRnQ0TUIzckpv?=
 =?utf-8?B?WDBwM01naUtRbUw0ckVyaHROeGFxbTh4dnBreUZ3dXFjMTR5QUJSZUlHVFBY?=
 =?utf-8?Q?8uE09iB1HDd+C0//pKj1pjpRe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9291a5-f8e5-4ee8-7b19-08dc7a24788f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:00:24.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0LA1UNjmSdlcmRz350PHJ5ZUn0yGc8NGmiM/uX8R8QMEFl4z7ntoP/nrZQFMqmLR86boN5HPSeUx9eCD7tytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5864

From: Jan Kiszka <jan.kiszka@siemens.com>

Those have been dropped with 6.9, but we already have them since 4.13,
thus before our current oldest supported kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-device.c | 2 +-
 kernel/drivers/spi/spi-master.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 265f98f1b5..9fb1501fe8 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -108,7 +108,7 @@ static int spi_device_probe(struct spi_device *spi)
 	 *
 	 * NOTE: the driver core guarantees serialization.
 	 */
-	master = spi_master_get_devdata(spi->master);
+	master = spi_controller_get_devdata(spi->controller);
 	if (master->devclass == NULL) {
 		ret = __rtdm_spi_setup_driver(master);
 		if (ret)
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 6c3af409d3..b3ffb64b10 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -362,7 +362,7 @@ __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 	ctlr->use_gpio_descriptors = true;
 	master = (void *)(ctlr + 1) + off;
 	master->controller = ctlr;
-	spi_master_set_devdata(ctlr, master);
+	spi_controller_set_devdata(ctlr, master);
 
 	return master;
 }
@@ -414,7 +414,7 @@ int __rtdm_spi_setup_driver(struct rtdm_spi_master *master)
 	return 0;
 }
 
-static int spi_transfer_one_unimp(struct spi_master *master,
+static int spi_transfer_one_unimp(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-- 
2.43.0
