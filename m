Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8F1EEF9
	for <xenomai@lists.linux.dev>; Wed,  9 Apr 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208730; cv=fail; b=sNl4/v5AHenRjLrESvU0LEo5MSxKbYxHWk4pclCaHgBmEv109Nwrpv96lm97vihSPEEcWahlGUtsXAZSyBAPjcWzvn4QfW6qdwGBBRAQHzg3ufj6jKODhPzal/HGN6WBBUEtyTHSPsT2mbXoYdXad/vnz0v1ty9MKDMSexjdgBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208730; c=relaxed/simple;
	bh=2npYjltWIK+BVcO93SUuSF34kky1KV490OSkWTZ2XPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGHD+zr8IcOfSCdwvyXe33IOG/5fcYreVDkngCrYHJ+ua9TSpVfHJGdQjb8qvKJqXm+3NKlH3vu9hLEcPAB1jue0rgVG9gG7Z/YQgTdmdS6joR2YDLbP3XxKBY/YWhq5DlGVkJsiXJyKJ+tc15b86DsJFvm232ivQ4DFwgWpRZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sjvQQAvt; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sjvQQAvt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSJxvsfdrj6tQr9F9UOZWyw8GAg4LyM2GJbizDuN8n4av6++LD+GAGfqtLETDjlkGOT0FW0XOKcyCQOw1cwkv/aUeXIbpxPu3vuKvt9KmIPGfSbSVR/7brR98KBWQUmQbZ3D8woRKFMVmwR9sjilHsBnFDSHSQJT9TiXuxySSEZPP8inlLylhnVqm9aRu/zKjCGbTRc5Ij99lS6/JrombQp8qySwAVBnTX7eGElie6GzfP/szMsAMtZ9JDmmo2gyB0u49CB6oyoLnEl7bXZWxQECRhoYsz9HFL8LSZHT5Dc4GvmZeUApzIXY6Lwz6bu+MFHTdIh02547B065RuuY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiFOy5Q/W1WRzAQMaiy4imKckE3QVslqdObbYr2I5IM=;
 b=HhCcI/Gnr4/BXVXpC+EzCLetbS3Ddx26anyDHVzK9AOyie8+Fl5xineNfQBnMR2k1jzJv20TgFLyulRj2PPkJdL4itcpkBzE+s/cCdNQ8uAXrLfNOZt2R3KhoVRjdyVfqWmZrgc+AYlQeR8Mk1FqDe+M5O5E7M2UlHIDMCiK6dIdgGqkGNvLAT+m8ZMM7kkZvECY1phjsJQ0AsVBfGqkXeezeITq+lcTzyn68BWl62BO68GpOsEzbk6AL4Eb4drybO8om47g7wFV5/J9hSGIS5x5PGwBv9v7aUBgIC0I0OpJeuvaH4+UapTIgEdWa5ncFe6d9QZMHnnVX760Ep0adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiFOy5Q/W1WRzAQMaiy4imKckE3QVslqdObbYr2I5IM=;
 b=sjvQQAvtsFYrRSIC8TlZysDVkxqAvhhydCedxZ7HWAhxuTO0ON+e6l4GoL4zFkzYFxu9PrKyY6+NyHdInK/LXeUAVW2MVjYQuZafGxvuGFuVsxVHP6hPB5rDTtWJw75gzfkCF4y5d2KoGm0qtFnpGmfT1Zlc2TjeH6scA4oZrCUppBw8QvhEFLxHSykP/8rY+vZSpfV1djK56tiQakLdby9Y8Q886lqBVVTPENwmErGuXqNxKFGdst7iwNWs/lZlcJyY+D7kNWB/+l6QFyGU+G2pQQvJIjJvXRZ4C38jakasT2FDC9V5Vm84S1GcMPyfuTJcUowS2iq+GfNPTN88kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:25:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 14:25:24 +0000
Message-ID: <e8253555-abea-4839-8d51-dc078eae4d37@siemens.com>
Date: Wed, 9 Apr 2025 16:25:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dovetail: Allow early return from traps
To: Richard Weinberger <richard@sigma-star.at>,
 Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Lorenz Kofler <lorenz@sigma-star.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
 <a28841a2-cb96-4356-93c1-ba08eb954210@siemens.com> <3083486.KX7oQKdZxJ@anvil>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3083486.KX7oQKdZxJ@anvil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0035.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d4ce20-870e-46d1-d9b4-08dd77725e03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGR5S3p6Ym5HU0xjSEFYdW13aHJOakdwdEFseHduRHZIOGd1MEV6UTA0TXcr?=
 =?utf-8?B?ZlVvQkcwVFNTT1M5YkViL3daVU03VFlZOWJXOGs1dU10bGNoN0czN1ROUXhB?=
 =?utf-8?B?Yk1RTGltU092RFNmcUJwa3ZzY0FYWFdpVGtoN0F6RWYwSUY0dTliQWhBQkVx?=
 =?utf-8?B?dEhvMVA2cHp3VWdvZk4wWkcyVzJDeWlYdnhZaFFZWm5PWEhod0FtRERnUTlO?=
 =?utf-8?B?QzZWSExrcEVJcVpEaWRDTGRsMnJqeVF2ZE41KzFOcUJEQndRVng0YmlkWHZU?=
 =?utf-8?B?ZmRtKzhrU0J4WWQ2RFl2L1BPNkJiYWZUajNvQlpaTkNnanp2M0RnUThtUGlv?=
 =?utf-8?B?WEREaGpnSXNXQ1FydS92VWJLR3FrTHVFalh6MWgyekpwcXRBSmE2bGpZQnhO?=
 =?utf-8?B?ZFhLdEMxVGtDdXRnR3UwUWdxbTJpek5sN3BCdllKaW14cHF6SmhDSHZaZUV0?=
 =?utf-8?B?Z0p6alVqWUhGSmJjbTVvdE1QMHNHZnRYSjF3M2tWRFhMcTNJeHdnZkg2NUZW?=
 =?utf-8?B?ckpoRUNCb1d5V3R3d3ZzaVJ1bW9MUHRkSVBUMHlWWTNTcmRETHFvY0hYSFVw?=
 =?utf-8?B?OEF6VjFQdmgrUTdQVy9YN0VEQy8wWi96OUhGM1dia05lTWY3N0RYcnhtaEFW?=
 =?utf-8?B?WG1YakNybGIrMG9ockZ3dkZJelVOTUFITUxXSHE0REtNS0tYcFByNCtvOUJm?=
 =?utf-8?B?QUs5V0l4N1FhaXE5S2o2MzNaY08zMlFOZ251WU1pczRBVC9UUnNiQThyZ3Vn?=
 =?utf-8?B?VUVtc2VzWFB1c2ZzalljNSsvOTJlNjE0bTllL1lzVElSTmlJMWJrWlFUdzFp?=
 =?utf-8?B?TWJ6REJxZEhjVFFMRENKT1Fuek5FcEl4RWF4b1ZaVjViU0I2QXJpRGFiYzhY?=
 =?utf-8?B?ak03QXJNblRsRlZyWmdaMVV2V1BiZ05DeWp2ak9DdTk1NGtDSCtETlp0WW5s?=
 =?utf-8?B?SnFYaHVVdU5USGgwUU5WWEVyOUExM2xyTUhkb2N3MlltR2ZrRlo4WWtsK1Z1?=
 =?utf-8?B?VEtUVkJjbUErY3RTenAvaHZqYzlUVU1NVzBDU2hiYlpmNXdsZ3ZOc0hUdW1r?=
 =?utf-8?B?MnRMWFNqWXVDSmRlOExxdkFxbE9yQ1JjcllTOFpDU2I5dHJRMWE3OVQveC9P?=
 =?utf-8?B?UFkrSE01UmRJdDdzbnU0QXdrNHdmMUVMWGxvNStvUHdNbXh4SWx4cGtYdmh6?=
 =?utf-8?B?VWhjeWdEaTkreFZFRVpLSk96S2JyazcvWXd6N0VGNWk2bWN0NkRPbmhWeVAr?=
 =?utf-8?B?dG5RalRQN2JwRmMxRUQ3OHRkY2xXTXJEQitKVnh4Smp3TDRFMndSS05OblZu?=
 =?utf-8?B?MWpZbnRydWUwZUtMV0hFTjV0WEFYeHZEMXFLMVYzd2J3ejNERnVaMTNmUm96?=
 =?utf-8?B?eHhKZU1aU2paQnh0MlRkeVplNVZpcGhRcFAwdEpzWlhKM3lhdlUwOEJ1bU1k?=
 =?utf-8?B?S040NXdWYSt4NnU1Mm8ycUt3UUQyRVZCV1N2cHkvZFRKanNVRlJKMmFXQ3NU?=
 =?utf-8?B?RFRkUytwZUVKVnI0dnZhQzVMK0VHZTQzTUxONUJTbVl5MTZoTkF2ZTRJOXRq?=
 =?utf-8?B?ZUwzV3BXS1hFSFY5Q0Zmb2ZmWHhMK2lZS3J6aStLcW1LUFp1cnNZeUR4Nysz?=
 =?utf-8?B?S3hoU2VIQ2s4ZmNaSGtUNlBtV2Y4S1hvWWkxU0xBS0NCQmtwNWt0RUo3TEdh?=
 =?utf-8?B?Z0VrRk9HWWI3azRtMjQxVWZGTEUvZFd2eVJpRVZSdDl2RkVVOWIvZS96d2pZ?=
 =?utf-8?B?dHhzdnlDVm4wektGVmFrcE8rSVNldlY5OVhBNXd0UDNHWkQ2aTNlNlQzSGEw?=
 =?utf-8?B?dnpDSVNkOGo0SmkvMlBRUytIaVc4T1A2dExkOGw2QytnNWc0KzllL2FRYXdQ?=
 =?utf-8?B?U0xpVTYwNU9tZm5zWTJ4NGFOWXJJZGtCMlFlaGo2aGExUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U05lMDI5K0tpRzNIQUIxOE5oY3lka3pSbHA0QTViKzllT09vb3pUZkdaMitW?=
 =?utf-8?B?cjgxZ1lQa3BndXc4VHNjOVRDbDRiYVhLWC9PK2dyUEkyYUR2emlWQ1kvNlR1?=
 =?utf-8?B?VlQySEgvanAzNGVmQlR5YU0rNDVRM1k2dm9HWko4WDUwSGVCZGtaMkphLzhU?=
 =?utf-8?B?ZlY0Q2VqMkZsME4yTCthOUtBd0hGd2NzTXRVdEUzS2JiMjBGbnFXVEpWa2x0?=
 =?utf-8?B?VUpKSmlyVStvd2lxRkZmaXh6STUyQ09xMFpYUzlaK1g2UmthVUNkSmNDeWQ3?=
 =?utf-8?B?QitnNVBYc05FblUvWHB6dXMvenl0bXlWenBJczBTQXRMMGtBQUNQR0kwSHdt?=
 =?utf-8?B?UFNFbHYreWVtSVVVTmhXeU5UQnFUUTZwWjhhQktYQjN1L1J6ZC9oRHorZVJG?=
 =?utf-8?B?VzRXMGRaRWpSZGFwUm9rS2oyd0tmQ1hLRFBnNDhJV1dsMkFETTZWcXVwSkRU?=
 =?utf-8?B?aGh2QnR2MGpicXZUWjA2U3pQYkZmWkxlNFZGdkxvTzFvOURCWENsbG1tNjhM?=
 =?utf-8?B?YmMvU1o3emNhaWFqZWFBdlgzd0R0OGU4NU1MRlZRb0xrR0F2WkdKNUZsOFlD?=
 =?utf-8?B?OGM5M003QXpmNXpxVUN2SGxtWjJjU3ZBbGpnbUhqWEt1Y0RxZEhWNGJrdHYv?=
 =?utf-8?B?a1A5aHBUV1lxL2pIQlh1TStzMnZVaytJOHJ4alBNbnhMTHl2RnhjNVRsc2NG?=
 =?utf-8?B?KzBoYjVnTEQvczYvWEhuL1ZIR1RreFkxUGNDWExrN01FSkJmbkMwcTFiRDEw?=
 =?utf-8?B?c0RtKzZ1ODJscEZ3UGhnUFkzcHdKeU1BMGRBQmI5bkl5V1BKR3E5aVZHdGx5?=
 =?utf-8?B?VFE0K3cvdXp5ZHBUS28rcksyNzJBSzFmSVRsWHgzMnhHcko5Ykl5VEVza0k3?=
 =?utf-8?B?VXV0eWZxSXptQzFya1ZNN0dnN3JCajV5T2I1L005cFNJcVBncThFMUZvQ1hs?=
 =?utf-8?B?SXV6N3cwUFJBTFg2MFcxcDFVb1pXcU1hZGsvUDBDRUwvS3ZDUlg1K3R5UGtW?=
 =?utf-8?B?MUFsOHQ0UWJFMXVWL1JCc094R2J5YmNvRGlFTlg4U1FtMFQ5RjYyN2hYRHFh?=
 =?utf-8?B?NmdCVWkvcnJ2SVN1Y3FITmRleTVpZlB4bHlnQzN2anlqbDU5NFdHcENqcldm?=
 =?utf-8?B?TnFleE1NM09WU2F1d3pITlU1aks2V3dNQm9vUGlMNi9tOFJ4cjBmZDE0SlBV?=
 =?utf-8?B?NitMUTdvR3dNbllzbnVSQm5VUEt5NDdGU1JsRlZhNlB4SG9mZE54TlZSazlQ?=
 =?utf-8?B?L1AyZTJ3aEwxZHQ3SkhTNkl6M2N2YXcvUnNGaG9xQzNoVlRCa0dBOGoxZFUx?=
 =?utf-8?B?NzhwNHpGWWxkRXE4cXBCaVJpZ2ZTZ1lMSXNJWFB5M1daU1FTaldqdVF1UkNi?=
 =?utf-8?B?b25IbWtEd2hXVGxVZk1lWFVtazlnMW1qVXRJMktrL3ZqMW9mSkY2Qmgxcm1U?=
 =?utf-8?B?VTBIN1dYTzdENEJvbXVFMnBUdmZET3Q0Sys4MjkxM0hrVG1DVWRNZkxEYXkz?=
 =?utf-8?B?ckgySUtaQngzY1RDM21IaUVwL3BKOFVoSWQwOW15NUxuZkp6MkNEY2JFZHdh?=
 =?utf-8?B?NUFPMVB0QmZDWmFTbEtPNVlHRjRxUmc3aGV4T0hMOVp3VVBFZWNzbXVFZlVn?=
 =?utf-8?B?Wk9qR28rK21TSGYvVVZ5SXBFeXBTdm83TDJZZmF0cW1tRmtHeGZNeVM4a0xk?=
 =?utf-8?B?ZW1TcjNxU0NxdmRIOWttZmt1MDBiR2NPTVMzQ2g0UzFVaE1yTVJReEs4Y2xp?=
 =?utf-8?B?N2hYdlRzL2lyeUtoUDhEYWVsMklJSElJR216cXNOK2NSbEhlQ3l5UEFhL0ZB?=
 =?utf-8?B?WDVlMHdiQWNVSXdoYzI0T2x1VkE5VzVPNy9ERXRoREtneE1QVGFteXhka2l1?=
 =?utf-8?B?c29QdGZjM2FpV3pCUjY5dDNDMnlrMEFFM0dMckRCQkRLb3crOHpHVFE3NXdj?=
 =?utf-8?B?cUR2NlRiaURWTUJIcU9EV2NwcWI3ZFdhOTM4U09LVEY4MkR6OGtDYzZaL1Nj?=
 =?utf-8?B?OTJQdGhoejhQd25pUzdOL1N4ejVneXhsMnhtKzBkK1llSDMrL2hIdTU1VGFM?=
 =?utf-8?B?eE5Yam40bFkycExBN3VzM0hLVXJGSWhRVEhmdVZkWDFCeGhMd2x3KzVBU0lB?=
 =?utf-8?B?Qm5IVVZHclNYUGRPbHdLbnpsdDlyNXJ1K2tBcHF1eWhnOExaNmh0dUJwMExs?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d4ce20-870e-46d1-d9b4-08dd77725e03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:25:24.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JE7p2By5je5PrECRb/257W1ADQ3d3F8si/imh7CRLmcubgMf77efqsBM2ygaBp7aPFr/FN3aTpRI7BkT4/P9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5523

On 09.04.25 11:47, Richard Weinberger wrote:
> On Dienstag, 8. April 2025 19:06 Jan Kiszka wrote:
>> On 08.04.25 14:34, Nikolaus Funk wrote:
>>> From: Richard Weinberger <richard@nod.at>
>>>
>>> Like on the x86 side, allow early return such that
>>> handling the exception on the Linux can get avoided.
>>>
>>
>> Which traps can be caught and fully handled in oob this way? From my
>> past experiments, that list was not very long - and when I look at your
>> Xenomai 3 changes, it still isn't. What was particularly hard: DABT and
>> memory access faults.
> 
> The list is indeed short.
> So far ARM64_TRAP_UNDI/BTI and ALIGN look good.
>  
>> Point is that we need to have some kind of consistency, between the
>> archs and between the reporting information (Linux vs. OOB signals). Or
>> we extensively need to document where all we are deviating (and ideally
>> why).
> 
> I'd vote for the latter.
> Plus improving the rt_signal_hist test such that others can
> test whether some exception handling is good enough or nor.
> 
> So, I suggest exposing more exception but mark/document the known good
> ones explicitly.

Could you assemble such a list next, ideally also listing the not
supported exceptions? That would be a good foundation to discuss the
general feature in the context of evl as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
