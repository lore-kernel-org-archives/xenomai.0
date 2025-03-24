Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99D18DB02
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815310; cv=fail; b=mk3JE/TJoH9MgQjUGTfnDN0ch/5oOb3EAhhusPSrLblUQKSwjHz/2jG6H29THHgTf3d84qJxV7pNyb8lelX/ysCvzp2zDx4aSGBw6YyHHsNfAxXjxp3DrAi1cO2zH1dU/siV8AV0+wHePEstJ//oC/U6R6pTbm+DNu90Iz7GUY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815310; c=relaxed/simple;
	bh=xH2ro1XZXJusKm53I2fbZAIgaaaPhC2NobpGm+EbaYA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owZ2e73vZn0jHqDtg4kbnBNLsj+M1mBbBFHSCdxU2G6MLvoM6PkRAiq7w9fAAReE2DDcxkzyv7bfN5jRPiaXZ9vyCrK1OmHeZPRAMey6XDJ5otMVXON7xvJmNABlNrryu9CV2Qsu8CxDC6KTn45T0ifkMVm6OyWGZqZL/8Cqw/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Z0krIoz/; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z0krIoz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0R8+QJXi8vLW+iX5/0cfldxD4cbLO/FYYQp66Wdqz1O0/7ZYxIfsLec85LG9/XoFKIf6HtNAmBICeRVTU2NJiWVgz1HhYVBxGPd99MNdb3DqcM6vQEGF7CI1qf5fKzAx6dwSWBFfkDZmyn4+gcBNEBr1QsR04kov8dspeJ136AMUptKaBGLTHZ42yK2l2vwvss28mlzLpEhvRgaoATXIebGHfN9KvpUFdTgb4+VOuzs+Mdw73G8daDkiSaIADYh/GmzhA028aE6UPvzESoVq01gffIXdmXgesQgQ5qjbYD6WplU4gioN4TrDt7xgc1wqHQ+g1ORXwAkfhEwFiAP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDdusE60BXzGnsQLtnLeilJCvlkQvcbRQhHM5DMbdM4=;
 b=oQFTBwfXvqU4WuqmOcxTxWnWitu5qTrigflojqif+Mf8/4qEQpTD5jOtbQlyOfbNP9cPvVSYf0M6iOT6zpi6ti1XvUJ2BiOM9pKwSdkD+A175t1qL1gXQArDC39urbCgyWIoMIalOQe+56x8hIH7JpAZLGPDD2jRVCXvcSwiuo0qvjSgP56M/ZHCdJ4ciArc/YHZ6ls8oHsH4cGOMS4ceKtIDSt2Te4NmMnSDZZB9JAXToCKbjkxV3Bi+CdS1qkR1YlxSYZ6F8te+14sWdj/Xq2t91crUAlgZLmcU/PXWIzyLzIxjGRUEFiqQKafNr3iqrpypCVq2VxnTUfBw/T0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDdusE60BXzGnsQLtnLeilJCvlkQvcbRQhHM5DMbdM4=;
 b=Z0krIoz/ubvWCoSuW3ryyDy0LuCBmZQL5tFroXicjBqwPUBWfeyA4u47RO3DEBaUl1RTRdmXlBT6oSUTIjosjgG5Tp92ynQafJMWCANivf8qswcmCSOsR5njTDBE/THGzIPSwofEqmZHc+thLO1D+2q8UkZemCawTGkwO8EWPDl8vw7F8EGSeTlg1U7w9r4RS2s0XfkQFnP3aA2m1T67Qh8tCGTnC72F1ypBaseMZxIAwHGDsLaj6TQn16z0xnsXFD4x16Y0YZGyIDEKVcLOFoJ0AyuzKZbAWXT+wLSJSYtIrxKn3V7mj5AB3KAcGzxfbF0EsGkzsA79bx342CekhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:21:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:21:45 +0000
Message-ID: <6bb944f4-9611-4075-9e7f-abf77114d18a@siemens.com>
Date: Mon, 24 Mar 2025 12:21:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
 <6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e76dc2-3ff6-4de9-472e-08dd6ac60f40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ykg4RnlLR1ZqUUZhdEtkY0pIOTcwTFF5bUEvd1I3WG5abXNFMnRkcnJqQlh2?=
 =?utf-8?B?aUVEWUtNTWc2d0JrZ054Q1R0ZmZrd0JKbHEyeHB3NVJubTg5Tnh0SlpSMWlJ?=
 =?utf-8?B?akpYVE5wZnB1VG9nS0dEbFpRK0ZxUnNwWDBOT2owajV5c0hoZ21MT3NaWkR5?=
 =?utf-8?B?SmdrR0x6M3hFZVZ4V3RCYzV1ZDBqNnNmOW9zZkRGY2JEY0ZPdTF6cUVoT1Zu?=
 =?utf-8?B?UktwMHVoWHFqRFZWNXlremJBbGRScEwrRHdkMHVWbGhtdVpZcmFzaVU0bmdR?=
 =?utf-8?B?Z0pBM1FLZ0xNV25XRlJiUWxVZksyTW9PbGlaengzemc1Mkc4Z3Q2MEd1SGhC?=
 =?utf-8?B?czVzMlJHWVpncjE0Zy9LaC85ZnYrRzBxdTJFYVd6UkxCSCtZTGMyMHBsNTRO?=
 =?utf-8?B?ZmZ4QWRhaWtGUmZ1dXplUE9vaFo0Q3dVU2dabVFNcmo3cUZiUmMrT3NUWndI?=
 =?utf-8?B?NHRXQnF0SjV4VkFKMWpMQ0U4bUZSQXBvR1hLUXZtYmJuR2tRY3VhTG1XOU9Q?=
 =?utf-8?B?YzJQV0dQQ2VReklzdWFvY0NRTytUOTVOR3AraWlVTzc0eEM4OVNFUENKNFFa?=
 =?utf-8?B?aElVeVo5TkhKWDJ1UG1raS9nSUpPSkJUZHBFbFVtd3dydUM3VFd4SitYTy9O?=
 =?utf-8?B?MmZ4TXNXMGF1cUo3MnRYVTVIbDRYTlBRaDZGRjNXdjdSODZmYVdKRDhLNkxj?=
 =?utf-8?B?QlpJWmJVRXM0YzFUbExrTVNCcUtNZWZkb1Q0d1J1bUhPTm5yRE9RR3ZIT0Ix?=
 =?utf-8?B?RHJRQmFSUjUxWjM3dzN2eG9DZzVta1paS0ZHR1ZudDBlaWN5Yi9KSVFxaXFK?=
 =?utf-8?B?K1ZPcFZmeWd0MndOQ2F4RHlKaEpRSzZhSUtmRXUvcnA5eXhQa1pSTlQxY0NF?=
 =?utf-8?B?MFdvbXkwQnhuTE1wVkh6Q3Bodzhxd0JPYjVVRzh5ci9mNVJYQnEzYnRZdW8r?=
 =?utf-8?B?RHk0NzRTTlJSaFlsT044cmZmNXBaTmNEWHdUK0RYSzlPRFNlVGF3aWEyUjJ5?=
 =?utf-8?B?a0VvSGVuZ3A3RDJscVhESDREMkNDMTdFOU5yWGs1cFZyR0NHSXVVWklXNkZu?=
 =?utf-8?B?WkU1ZXFrYlZ4SkZOd2NKK2dzYnpPOWJXT1prUGV5QUs4czgwWTFkMHZBd3BM?=
 =?utf-8?B?ZEE1ajV1QWpmL21YTkZZMWFOWnorZ2ZZRGpmbGc0d01zL0hndkZ0bUV3ZFFl?=
 =?utf-8?B?Yy9iSkJ2eE9WcjFuTnRsT09EKzVHNEN4Q1hKUGJGR01ZRlQ0ZGNJZmY1YlVT?=
 =?utf-8?B?SFVxb2ZKU052dlNUVnpQMG9pSnJqTDJibDVWdWpzRmo4ZGhBdTBpeDdHcERy?=
 =?utf-8?B?eWdTRnRBVFF0dHVrc1dDVG1oZVUzWVlnN1dVOUo0VEJwMHVNVnI5NDNRa3Fl?=
 =?utf-8?B?MkRQZDFFWXIwNjVVcVREalJpOFB5dFN4ZjFpbHpjcWJtY1ZvOVl4cEgwQ3h4?=
 =?utf-8?B?ajRnRStHNzFSSHdmQTE5TVQ4d2RNUDE0RzNSQkJJYzFCdFFRdlhzSGdENmpN?=
 =?utf-8?B?VFJWQXJDWklGczBEbXlJK3RrL0JwazNiMnA0UmpRWW9JWmRJblpQK2N0aGY5?=
 =?utf-8?B?ckJ3K0ZoaC9yZ2JzSStvVEc2UEdCM2s4MWRkdjJWZUhKbkxjTUFERFBkWmVX?=
 =?utf-8?B?MFcyU0IvZnNiUWwxbktKM0RwTjRaNW9ZQ3ByQjFiTzAwQVR2cno2UVVkbTVh?=
 =?utf-8?B?UXk1VGw3RVZQYXNXZkppSFNIUER2ci8rTVdYZGRyTTNkQlV0amEzVmtPaXlQ?=
 =?utf-8?B?QjlnVDhhd3BpUzFkc2x4MEZKZ2Y3T2ZEZGljV29YVGZZUk5OMUhSdWVNQmZz?=
 =?utf-8?B?amY1QTVOdys4L0d3M1FTcHo0c1U1cWQvcU9OdWhxdzAxVTg3NnhpajRySjM0?=
 =?utf-8?Q?vt7Fer/VaE5RE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmhQSGV4QnV6UGtDRHdyUk1tNDhWKzhqNHl4bGZGM2x2ek9KbEEvMTFCSVFP?=
 =?utf-8?B?ZisyanV2aktQQ0JJakpZcFNlS25vUEhaQ3dpTlBRZEhRVEsxWmVyRW5ZMU9r?=
 =?utf-8?B?eVVwRC84WFBGT1Nwazd6V0N4YW9QS2RnWXVUa2kxc2thRWMxREp3L2t3OXcr?=
 =?utf-8?B?MnlNTzdRTytJd1BLY2FaZVBMM3ZUNGk2SXppOXZtRjVrck1sWEFSWFl6ZUxo?=
 =?utf-8?B?SWNaQ1RnZWYzMjNHUHVvVmUrZU9tZVJzd1MxZFdFVDFLOWlaVElPa0tOanhy?=
 =?utf-8?B?MmxGRUFWdkQrUlR3QVRjNjJLTCtYcWpjV0M1Z2pqTUZ5dk9ZSWd6WDZjZTMw?=
 =?utf-8?B?YXAvbGJIYkpXM09vQUptTXdtbHArallBTmVBKzQ1Mi9EbGxYS1JhRjU1WU9V?=
 =?utf-8?B?ZVhiaDlQTnVkejNsM3lZUkd6TGN6QURURmpTdzB4WmRPUkk0dm9DMi9ycnpo?=
 =?utf-8?B?S2Y2RTdZNS9uci8xSkd5RXhFbTh4Mm9SWU1IR28vSzZNWUJ4VG9QdnVOTWxS?=
 =?utf-8?B?Y0FveURFT0MrTFFPd280UHNPSnRZWjQ4QlcyN3p0ZDZJbVcvM09Qb3djQnJG?=
 =?utf-8?B?TU9FWWtULzhPTDh0aVJ3SWhqOFJ2UUVrTDR1c0ZPZFdyKy9kVTNlS3RYc2Ux?=
 =?utf-8?B?R3JSUjEvOC90MGxYeldVZTdudGluSzlnTjQxT1ZyNVVBdjl0bUFVc0R2cnd3?=
 =?utf-8?B?TllucFQ0QVJ2eHd4Y0ZwVE80eEl0eWkxOVZobGtWdVZKOWhCNjluU0hPN2tV?=
 =?utf-8?B?L1UxTW5LWVRqRzlyTnk3anVxbEhQbHJtWHMyaUhjVFNpc1podkJQaTd3eFRP?=
 =?utf-8?B?S3ROOEZia09Ra0x1WmJuNzF5Z2lOM0dTK2pQRHNiSFNoOUt3U0xiUU1pVFBI?=
 =?utf-8?B?ZittdmdRek5LN2NBQUYvR2htcS9yd2Iwd0tneDkxajRVNTYzY3g1UXErbzNy?=
 =?utf-8?B?KzUyNTB4UklLMlBQYzd3SlJlbXduWTZQdjVmNFU5eDdESk9oQWEyM1NtOW91?=
 =?utf-8?B?Mks0bThOTUhjVG5MVVZTZUE2aUY4Lzdmc3F4STUvb2tVd1BBSU5SK011bVlG?=
 =?utf-8?B?SGxYczJraG5wdVJzYnBLZk1kTndBQ2FGK2svV1JsWGpwbEpSdEc5Uk5Ib2ov?=
 =?utf-8?B?U3cwd3pHYXRMTUNSRlg4aCtncyswMGtFNThVd1BsS0tscS9SQ1k3bUxOVDNS?=
 =?utf-8?B?VmtsYWsza0Nrdy9DTWxxcmpSbFl3UHB3Nk1hZ3VHZ0RxbnRCZ0RRaXVoRzVO?=
 =?utf-8?B?NTVQWXBFZHBiekx0MUpQa004TmpHM09SRGNFcW9uekdTRUtLODlpbUhvS3pB?=
 =?utf-8?B?NDdsMXQzQWVqeU96L3U5QlBXbHBhdG1IN1Q4YW9oZUM0d0ExNzFCcmw5L21i?=
 =?utf-8?B?cDdWQ2ZnZDFGNGlyM08xVENJOU9TWXpzZnZuSzU2VFVGazYzSmdsNWVZR2NC?=
 =?utf-8?B?dTlxMzlPRVRnMHQvVC9EQmJtU0RhdnJYUU1odHg5Rml1OVlXU2h0Z0NzaHQy?=
 =?utf-8?B?aGlNMkk2VWxoS2ZIajlWbk1BanpxbERNb2hVbks4K2ZGallFYWVrQ1NVdStn?=
 =?utf-8?B?dzdoSFA5dmlLcU5xUVV0ZE1lVDB6dS9Va3BBWmUyVFBzSnN2MnN6QkVsSnM0?=
 =?utf-8?B?d0NkWUhIRUp1blNORy8zRm1CbCtHSVE5Z0tqUEtzaDhGQVkwdXRiVmxIc0JX?=
 =?utf-8?B?NmpXSG5BWkJFNm1jeGRPcFFaYjEzeUNPWUQ2NG5BUGdwdW10bjdPVHF4T3Uz?=
 =?utf-8?B?RGprOFVocGNWQmhmOHQvQTZhY2R5Y2tqdW5Zb25hdnowWmh1V2l6SUswa1hv?=
 =?utf-8?B?R2FmcGxNVHgwc1JiOGFHT1NyWUphM2NQMTAwbHN4c2w4Y0RWd2ttaDVMUENS?=
 =?utf-8?B?Ny9UOVc5MjZXb2pJcWJSaG9mK25OU2FSVXlMdGxVMkI1UDdiQ1k1NjkvTmV6?=
 =?utf-8?B?VEhZS0N3UDhjMkpXUHJqdmo1TXJ3TjFvanQvRnFzTjFKVDVZY0J1YXNabHBu?=
 =?utf-8?B?ZEhWcHNzV1VWMHowdlllRzFGdThFcGRUSW5selNlc1YzaWpVSVlaYnBqWi9H?=
 =?utf-8?B?NnlET2xET0dFRDY3a1BpbENUcUpJekZUWkQ3Q3hSaGl4a0ZUQlZ1S0N3SDVH?=
 =?utf-8?Q?jbQHzXTcK3/+3MxIujuGq2qcb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e76dc2-3ff6-4de9-472e-08dd6ac60f40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:21:44.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijlYCITjpvj/716fmWuQPa9rJXIMp4Dq0CsGf4LxYi3kEo0ksYZ4SzqZiGRh+QdWB2kZcNf+umOUDRLS2Rxemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6891

On 24.03.25 12:18, Florian Bezdeka wrote:
> On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We had unbalanced hard_cond_local_irq_disable here so far.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Minus one hunk that is already in current 6.12.y, this needs to be 
>> applied to older stable versions as well.
>>
>>  kernel/power/hibernate.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 733b1a196f09e..e1c05f276a453 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>  	syscore_resume();
>>  
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
> 
> General question about ordering here:
> 
> The order hard_cond_local_irq_enable() followed by local_irq_enable()
> seems wrong to me. We enable hard irqs first, then we unstall the
> inband stage.

Normally, this is the right ordering because you cannot process pending
Linux IRQs with hard IRQs disabled.

> 
> That means that an hard irq might arrive and will end up in the IRQ
> log, which is not processed by local_irq_enable(), so we are delaying
> the IRQ processing to an unknown later time.
> 

Why should local_irq_enable not process pending Linux IRQs?

Jan

> The other way around would make more sense to me. Is my understanding
> right?
> 
>>  
>> @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>>  	syscore_resume();
>>  
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>>  
>> @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>>   Power_up:
>>  	syscore_resume();
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>>  
>> -- 
>> 2.43.0
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
