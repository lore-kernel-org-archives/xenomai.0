Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B21AAE1B
	for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839970; cv=fail; b=nH9xNEIjJvRNi96vNej7rhP6el9aF+ScwH5xN+LNNO/ZaAgmKCVl1EMUr/vLVi7sias+9XFLofcFYHL6BOcE59szghGwdp3LBCiBi75JDLWe/dDSw8aHuGhEoP9qsteK8YFExYc8AmaCuNtMZNgHj75ZfVttuRMqr3Aym2U+3MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839970; c=relaxed/simple;
	bh=aUqlEJQD+9odHLO582TKXZKHuJJq5AKdyvPfnENno+s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/2Y3+zIKP3uo8vHwxG7qvXdyn1YMk6RFHrHqj49JLTCXovc79AGC8G8J9Ua9o0XWoqhBBQsrRRNh/S5iq+862qZf8c0elXsvUT3dTSsivuU0Pn4Z7fQ5K+mxwCTnS95Be+u/v9s4V24Y7PIqTT8XFC+rI/GCTrFRVVedp3T43E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QGOieGbl; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QGOieGbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu6MQgZNEDuLUrx7AXie3QcP6aWGW/Bm3SYurjjB8JfGuS5M4AHkez58NHDMk8CJtXx5fl2NRWSueK3Hbr9EAEd6hdqkmrzvTX0iLJaVbIW1SWzPkYBnhwc485UwR+j6Vk60SASS7/UMwEIIYP+g4+R02fij72cJoznRXE5aO87lQktIZg7AwVon5+Iy4JsgfK0upJ3GMVuDNTCOSzP6/iPYlhxCU6ZPtrek9Vf6/1WH7steAOOY4jnx3AVQszjoem15jfPgvWEqgCpdElCNXYN2SoQuee+K0gMi4YLnuizQ3rqzYyOtScvhQZyaJrdZHbVLdMBA4BSRsLu013TxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aywp6s3Cdi/U9gZFd2dt3nthytq0xX8TBpbIPOaGxWg=;
 b=oTyY2b1uWns6fnshUyx4RyaIkUPC1BcGxUpjaa4OMwpe06b93LAmPMmf3jT03hfldYwtbgCwEgUK/RKzAiLfGLowZPV01h1l0gwrTNdNEKl5GuR1B2xdthHxIqinF1i8HDYjRSfnDKG6EDHsWgI8vjvMhsF4x5o9jNArv4cjVNZyqWEQh2OMBE6ZZI1Qj8rJF1ixI8fkJOHeevQHQRJ0VtiBQW8oHCptX082AdVzfarWYaOYG4C/aKtcZsNM8nXdS7Hat9ilOcyElU3aMJh+R7FzLDByPOi0RaQD5mRKxzMMitNbSMc1l9+onzQDEJcvGS667ZX00kjUNZ4zF8bNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aywp6s3Cdi/U9gZFd2dt3nthytq0xX8TBpbIPOaGxWg=;
 b=QGOieGbld8i0TKBJEBpAae4TNZlxM6DbDX6Ynq1h6NhvOFYWnYuHUvgHLPTlk8ykz0jI0xOoPbXNYBeiD0ljSVy6YVViZuh8b2Wt0+Lg3jAkO7DW0NP9B3kdRNXvSdt+I4kWkrEveQdn9efQ3UcuQzsmwqs7G90MCHyodaLIfBJn4BRswJjp6WxzRsF8ewHASr+Ckkf8XgIhfiu2in29b9EvSE2XsG7fdU3fsuXv6+nuGXUZYXGZ4JmQGzyOdKEiXNvOIWNQURGLpo6yHu8PolfesNAp9rXwwkGlKYNIJBas+w9O9YGwW8wO/GJ3R0p0IR34zUc4RSVd2lZXJEihmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.7; Tue, 10 Dec
 2024 14:12:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Tue, 10 Dec 2024
 14:12:45 +0000
Message-ID: <1da1e22f-84cb-4dda-a3c3-e0741e10bc9c@siemens.com>
Date: Tue, 10 Dec 2024 15:12:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Intel speed scaling
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPERb-5hy-Ta9QWqbJVV=V7E1_w0bK2kvivxLNYcQB6KZg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPERb-5hy-Ta9QWqbJVV=V7E1_w0bK2kvivxLNYcQB6KZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc28278-4293-4aa8-a78f-08dd1924b7ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDY3SEF4d0VmYmxwOEhNWkhoTzlvRDVsOGZNSkVLb21VTVllWnlhUEhaWWVq?=
 =?utf-8?B?RXJsWHYrbW45aXRNNUxFRnhKMTkyNGlZNFprZ3VxOHk0Q3lsRDdtZ0ZYeHNt?=
 =?utf-8?B?aEhYcHNGUlB2S2dvcE0ySVR4Q3ZUbzdNUmNzYWp1aHlveEZEL2xBRGQyZ3ll?=
 =?utf-8?B?MTh2dE1xRXFXQjAyU1h5ZzcvWjI1YmN0bWZ1UmppWTZudDdoREFxd1JFbGgz?=
 =?utf-8?B?S1NKZE5TQVJhSHJpcG81TjRjbkh6Z1BaYSs4aWxUM2pPWnVYRTQ3eEZzQnNs?=
 =?utf-8?B?RDZvaXFrUmQ2QW9NNTdVdWZqd3M2enRVeTFXR0tnbzFsYnA1TFNwbkplc1ZJ?=
 =?utf-8?B?REVYSm1BZ2JqbDBENyt3ai9uakNSVjM3Y0tEck5FT1RSZXB5ejJZUDVyck5F?=
 =?utf-8?B?TlNvS2pOcUVjcTh1OVNoVTVaTXBEd0RzaXU1c05td1AxTnZ5QUVRaVVkWTU1?=
 =?utf-8?B?N1RPS1RsN3h6YllUb0Z1ZGpEaWFhNloybCtjZFhaUVk5NTlZSHJxZVcwcWZI?=
 =?utf-8?B?WGpYQ0VhTHJwNWpxYjkrSUNTaitKS0VmMS9QRnZ4dC85U0FpT0dtcG9UVlZi?=
 =?utf-8?B?NXNjQ2diU2MvcEk1QVlQTVU4ckdYT3hLRVNHa3JYTmdndTg4RXFWVk1tMW5P?=
 =?utf-8?B?RTNnMHlKbWsrYkdTOHQxWUZOWERHN1FidFE1VE9ad0NpMWFiM1hpclNGTWk0?=
 =?utf-8?B?VGU4RzN3a3dWWFBKWjhUSDJBYTVUaVVGQW85VE5NWEFTclBDRkdNL3czWU02?=
 =?utf-8?B?dlFEVWkxUkxVNElOa0luaUgyQU5jQXJid2hOVXpCVXk4UHFhUGdlMU16aWJj?=
 =?utf-8?B?NUVBOTRKWlN3eVZEekNhNUV1SlFGM1A0M0NaaVdQYmRXRVFHUUtoUkExbTZh?=
 =?utf-8?B?UjJEREthcVluNGNlZXVKT3BUeStGTUhTMitwQjNXcCtEV0NwNis2dDRNS09j?=
 =?utf-8?B?SkpJQmFJUXEwNFJnemc0QldjNWY3YVdoNmZtV0NzYWRicmRwNW52ajN0MERC?=
 =?utf-8?B?YUR3Z3ZZTldOWFhmYzlwUW80b0N0Z3BHQURxaTVUWENFVDV3RU9sNGYyVks0?=
 =?utf-8?B?NlJOMFVBN1NtSjJsQ2pmVUx4aUlxdDZVR2lCZDlqa0YzS1F2eEtHRUQyRG1D?=
 =?utf-8?B?WmxpQjFKSXpDTTU3WUVTak1maUUwdHc0UW00aVpzRzFKSzg4MXA4cjNDOXpS?=
 =?utf-8?B?YVYyemk0djBLeVg3ZjRGUXJucjJvN3ZyVjFBd2x5eVJmRXppd0RQdTdiQU8w?=
 =?utf-8?B?WUVidmRKSTdCOGVWU1lVUCtGY0VRYWNtRXlhR1FCS0dFUE5Ic3ArUUozbjFF?=
 =?utf-8?B?bFhaNzlGRUcycmpzamlkdkFuZy9VdFBTZHhYNDVaVGxiV1Z6S0ZYMkNXWE8r?=
 =?utf-8?B?WENDaTJHTTRxbHBkUTZUWmo2Vm1BYi9YTjBTV3NqSFpqVXRuWmtNVzJqMWU4?=
 =?utf-8?B?bzdKMUlRdDdRREEzVXcxaUc0cHdxVjFXN0xaNnZtbDgxWms4YTdwb1EzelY4?=
 =?utf-8?B?U3VLOSt2QTdCVG13NWZ5aDY2aEJGc1N1K25kdWNBZFR2N3JyNzlZUmtLeEFZ?=
 =?utf-8?B?M3JBZTBIUzFyejdWVnBpSDNkY0czelltd1A4VDEvQU1Bb3Jna0RVOVI0d0NG?=
 =?utf-8?B?bEVMbTBGaGxFVUUwUGhyNzZiUkdGWjk1YU5GN2VUK0NXWnpxdW1SczlHY2hr?=
 =?utf-8?B?NFZETjA1MVludmJScnZiM1IzcTRiajdkcllJY3hRMHZpTzUwNE9mbzlYSGd0?=
 =?utf-8?B?dS9pRDdOQ0QyRHpIWnEvZEFPbERCKzZUV0lxNDI3ZENCZEZXZ3c4bFNvTUJG?=
 =?utf-8?B?Vi9KL1VtMjArM1dzaWV4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hWTW5qRkZYU2p2YWF0TEx6dE5DS3FFUnJkbFBxOWN3TWtzNnFJeHA3YXo4?=
 =?utf-8?B?MVNXVEN3bHBkeHRHTnd5dnI5TWthb2R0K3ZFcTltRkR5SHg2KzBydjhMdko4?=
 =?utf-8?B?YkxHUlZKY0ZKWFFPVDBiNVZ5cHJMVmM1Zjg3c2hWZTVndHBRUmdpdTAxcGpE?=
 =?utf-8?B?WndlRCtiQ2FaaWJJR1lVOXJaeXR6WEJkUW1BRnNKTHBGZXljK3AzejNGdmNR?=
 =?utf-8?B?RnFZRzRLMjFZY0VrUmhPYkhaNnQrUGgxWGNUWkx6TEx1Q2ZTbU5vdUZBcDA1?=
 =?utf-8?B?TDcrUkt6Y0FqaFBoL0hJV2VMbE9YZEhuWi83a1U1Tk90aVZTMzJMVnBnZ1kw?=
 =?utf-8?B?SXd4dzYvYk0vZXdOTmJKOFJNNkpZeHBXTWkrNnhRcDBBRFZ0ZEtON3BLTjBO?=
 =?utf-8?B?U1k2QW02bGhvTzQ0MllEdlB0R3pYMnQxSHI0RDd0UzJOczRPMWpkMjJ3MTlu?=
 =?utf-8?B?aXFtWHF0Y1R5dDFSMDdtd1IwMkhxR2YxektzSmFRa3A3eUhNOENJaW1BVnpu?=
 =?utf-8?B?WnNRZldhSXY5UUo2anBYaXdVTWMrWVA1ZmQ0WURvTlBERlhyWU5MQVhxc21W?=
 =?utf-8?B?ejk0eGhlMXlxK3YrcmJGYXdaRVRsdFhZY1Z1MGtPenQ1T0xmb2N1d2FYa29R?=
 =?utf-8?B?U1JTNVppUUJqcFZUMEs2aFh5bFhtYmRoYXROSndQMUtWOHJGNHVVSFV5YnQ0?=
 =?utf-8?B?d09MelJuR1ZlOURxbmJaQXZmZk1PbG9oaTNYMEswT0NzY2pWYkJoSld5RVR6?=
 =?utf-8?B?eVQ5ZDhWdUk3NFBRK2M1WVRaOTQrMlpocnlQT0V2ZDVrVkMyNm5ZQUIzdzBI?=
 =?utf-8?B?WlR6TDRFSFdubGlBTkd3Y1JQZTJsS1hjL1JvYWt6NS9UMU1tUWpXeldLSHgy?=
 =?utf-8?B?bzNjSjhUOXRlUnVvdWxaSCtHZ3N1aElXNE5ZZE5pa2JyMTNYL21SYWhaTVYw?=
 =?utf-8?B?OEtKV3VzaVlXSHhpMVp1bUNxVTlNSnhXY1dKb0tpdkR3VWI3UzN2ODZQQjcw?=
 =?utf-8?B?cDBObm1LQ0ZyTktGY3Jmc2ZzdHJwSE9jUW9BVkwvQVp3TUlnd3BKaCtVajNO?=
 =?utf-8?B?ZXV6WVp2VXJHYU5zNEhtRjNraUlpUWVONzFTTlhMYitJK24zRjQydUkvTEpu?=
 =?utf-8?B?Wi8zcHF3bXZYa1FGcTk5ZGJaOThva2VyanRxbnc1Y2dTSjVFQlh0dnJ6Qlgw?=
 =?utf-8?B?WmYrck1DWFliellHTnBLa3ZPSFJOL0lIeDB2WEJLeXdaMjVJNmt0Q28wZFJS?=
 =?utf-8?B?QkJmTjFXb0lma0gwRU9vd3ZHUXlNcXhjcE4xV2pHQU5VdFJJQXdKRWxLakUy?=
 =?utf-8?B?ODVOc1FUK0NsbS9tN2tEM0NDbEt2ck1HMlQyaHNRcmRuekcyYWorTjNQZHha?=
 =?utf-8?B?ZE5HcHd1UDRNbmJxdFJ1L2ZtNWN3UDFqSDBsMEU3N1VobzgxdlRwWm1QbTNu?=
 =?utf-8?B?T2FGSVBEaVQyNmF4dDlRZHgzZmZKMFJrcTV4WnZwRkZPWDQ4MXY2TkdidW1I?=
 =?utf-8?B?TlNuWWhOOXhjYk1wV0g4NzM0ZGhxb3ArTWprSnF1N0tFNW1FeVUzaGpqbmNw?=
 =?utf-8?B?QWlmMmt4bVgxMlpSdzk0Ymp3T2lGUGlwWGNhTlc1emZOd1VCNmx1Z1JiNFVQ?=
 =?utf-8?B?MmRPQ3A0dWFJSmpVeWh2Wm1LeXhLMHdmWXpYVnRTdEpxZWprSkg2dGZ6cFNZ?=
 =?utf-8?B?dXBnVzJUbjJkYldKWEpaWk5OZ1owUU5TQy9QcXVRYitGa3NoMWYvcndoODk1?=
 =?utf-8?B?TUk5ZzF5REtDOUdWcXBZaUcvaXdWRzRMMjhlMUlpYUlkb1l5ZnkwQm1Gc0pO?=
 =?utf-8?B?NUdITEN4ckdSOXN4YUU4d2xJdkVidWNkSXFESU1vaW8zZEU4Y1MrYnk4dVFu?=
 =?utf-8?B?UEJ5NFVLTktRbGhQR3hqMys0c1IyTjJWbU5Md0pjN1BDMUtZaWpXdlR3NXBt?=
 =?utf-8?B?N3BQVVU0cHlsdXVhWklDYjlMK1lmK0FNUGFLeXIwL1B2T0ViRUFIOG8wMzhn?=
 =?utf-8?B?K3cvRkw3QXE2ek9DM0JYNExUWFJmOG1BT0JaS3lpR3lNY293cWZ0K3V2ZHNH?=
 =?utf-8?B?dHRBRWxGbmdsMkFCNjBRSFk1N2ptK1kwaXdNMklpR3JIOHBHTlUvSG10Ti91?=
 =?utf-8?B?dk1rZGdZQ2NRM1B0ekx2L3BpS0dKOHdDRk16QWFIQjBmYlFHTlMwMDVIT0dQ?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc28278-4293-4aa8-a78f-08dd1924b7ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:12:45.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /G0TD7JYOV9ekL0MYYDJlT9P2LyF+9uYgW+UBLqqKFGtdqX/hdXvNn3koszSda9zlATpzAwEQL6aoKRssCDpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7845

On 10.12.24 09:03, C Smith wrote:
> My Xenomai RT application has good timing latency but my processor
> seems to be "speed scaling".
> I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281 on Intel X86-64 CPU.
> Speed scaling is turned off in the BIOS, and as far as I can tell
> speed scaling is not enabled in the kernel config, yet when I do:
> cat /proc/cpuinfo
> I see variable speeds.
> Are there specific kernel config options I should be using when
> building the kernel?

Normally, turning CONFIG_CPU_FREQ off should be enough here. But maybe
the firmware jumps in then and does own things? Never seen that, just
speculating. If that kernel config switch is already off, you could try
to enable it again and set the cpufreq governor to "performance" instead.

Or does your CPU support boosting / turbo mode? That may also explain
peaks. Documentation/admin-guide/pm/cpufreq.rst says that control over
boosting is with the hardware on x86. But the BIOS may allow to turn
this off as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
