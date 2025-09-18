Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED041DE3CB
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212370; cv=fail; b=D4oIwJhFIeCmAXlyKQqVzRRxY9n5+dtMel8RGCPyC51W6l8dn6NsAL9Izs09mQCuzTrDk2F+D9pBnA+0+INf+r11JSOneNw7JlbJh2ZSVee2LoSv87dM8hfKLQheQQoqXx8V6UWLYO5bGzajL0sAQHs08jmuc13v581j0Zo/x0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212370; c=relaxed/simple;
	bh=esA/Eg0NhkqNXyESqTtdNvtayV+Mud0sz+lqt5FlXH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYylvBzqW7GdaepykIM29iUV8Qgxnin4TMgH3DPt/HkNWfikB1hf6RxcNHKNd4Ks5t+GR/eWy6/c5GzMKYoF/ohhWTINJk8BPhLRtgFa6jKvzaRRB9eN1H7ws6kYTsVA7monk0oVmaj47yPO+nF1MV2hJ/BxWr/PuioycEfP41E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dLQfvXLZ; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dLQfvXLZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4zwhaePlL6oaGFcxaNzKwHCnKhg45jkKJ/q3gnuKro8ubwG1nsfmsvGTWzFVaiemOTK+zA7NJjxes4URpwvrx9PkkWyqpZz80rzYjG4J1ubV0glb5A4+hRB/UkKLT4UwWd1pKx1bqZWgJJL4iJwI1Kx41ckhjTT5RTM8C4whzeP93C/+JwBJ05xllBTFjq9QH1Udrrh9sEYrqZRa6fffMxdvW7ctpkemqfR/r2kSzo5dpkgxJ9rzDCwfFPIL4pVbq/Od6O1MCKr8drqseKEXMOLvLs4XEmWxIuJH8U7KjpYYk9pcLlaOGkcyTxrWEPXuVZr6RLXgO8HO6H3jauRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/r5lgbXnJ6tJ/DAZcf4CcwA7JwviP2mBbXP1lv4nJA=;
 b=cpIvsMWq0f3iRhbf9Hyvesns6QeII4LXwfYUfhAYk/qdmIOVS8AGhTaxDosi56HF3tPRXpF56D5EYTOn9/FcAnhNPoBI9arns+RuzazDIdXp8qUu0gPaDozmO8xUyjFQlun9gkeCj1GuwLotETXQtpYN0KpTEWSFmjo6QgLk1RtNQPxYov3JXvaef52IZko1YVHOI0Ffans+HdhnCtM0HeZTCBm6hkKttX3/A/rAQajgOedQ6z2dk4NpCqT2uYNUvUmzfUQfEGkR2mIG38nAU/klUuCxcDpLCk6xDheORdYWCV005A1bWhQzH6r6CgKOEkYeUD6Z5Cx9L2ZUxqKZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/r5lgbXnJ6tJ/DAZcf4CcwA7JwviP2mBbXP1lv4nJA=;
 b=dLQfvXLZuFMLov/IrXDWrQJMuc03B2D4DfZhK7zYtLscKbFRm6AmdeH4u4y/ZaO9v5yd0JsNOMcaoVudT8bl9oRxIHnCyQAVoSTKCPjkOcZxJHQhHjB4trSa7Y2XGEEZ+HKxVlFOzhNn0MamU8WBUPNahjesrE/pajd+zCVCa0e43yDBfXeQkHEhCoMOV90gworFr48hObCWgYWFbYjblSOwpv5DCmKQjM5JRDADwbNSXexnUznWj+lrH8LTEh8MVLokWwGQo1rVQZRcXkndjLsbd1zmJIA70Ty8RT1Di4Nyvn/y2mXTS+6hLtx+RS+wtuYCBKZsDo7NWMjcIXwdog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by GV1PR10MB8493.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:19:23 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:19:23 +0000
Message-ID: <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
Date: Thu, 18 Sep 2025 18:19:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v as
 hypervisor
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:610:54::29) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|GV1PR10MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: be50c32b-9001-4120-b8fd-08ddf6cf20e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE1nRURQRVF1YkwxVHhocG1tamgxVFVlK0dQUHdKSEZUeWkyNzVKc0RyNjFH?=
 =?utf-8?B?anZSRGFtc3BleTUvUlh5ang0TzFEbGtkYUtLbW1Dc3doMktoN0NOSmNrOTgr?=
 =?utf-8?B?K3ZUSkduNFhNZmUwTmtuOEdKSjJKeUMyVXIzVXRXZVdYMUY0ZHV1TEI1WjRu?=
 =?utf-8?B?U25GVWxMQlJOVG02bVdYN3g3elFyY09mcUxIRDY2ZW43V3lCdEIwc3dIaFlK?=
 =?utf-8?B?K0Z1MVJBcW5HbitmWGlDMlRkSDNVb3NFWFc0K2FhZjdMRXlXQ0FQcDI3bGlE?=
 =?utf-8?B?MHdhbjRwRm5xaUFWNkhGYXh4eDJHS1ZpajNOZXdtQyt6RWxtY05SRVFVczRZ?=
 =?utf-8?B?dVIrUWtoQUt2QWpkY3IxTmg3VTlaY0Z4WThZQUhqWkNHdVNSM3d1M2ZNU0dj?=
 =?utf-8?B?TXN0WTlrTURvQ25pUk43RzNYTDN5b0tUS3hWdk1PY3EreHRucUdpeS9lTk1k?=
 =?utf-8?B?VXJPR1Z6a0h2QkY3ZGJPMnJSMWdMVEliZGgrbnkrUTZRSW4yL0grcytXOTkz?=
 =?utf-8?B?c3FyLy9MOHFrSlJMNzNOL2NhWHVZcVArK3ZSU2NCaWpiL0lMTGFtT200cU8v?=
 =?utf-8?B?Mkc0Uk5mbUhBVTJUQWJtakdmZHpySGttQlZuOUx1aE0yTm9TUW5LbGplbm1T?=
 =?utf-8?B?b3A2ZkNZcllMQ2RjQmtzdVVITWpyZFRsMDlmbHBZUFFMYndUbzRVNGZjL2NC?=
 =?utf-8?B?VTVsNTM1cDZGQUxldFBvTkg3VmlxSHo4MDFIalVBemNUSkYyR3JJazErY1lW?=
 =?utf-8?B?L053dkE2bFBWMlluRlFyY0dyVGZaYzlZbEVxL2pSamJZUzdCblh5MldjWm5s?=
 =?utf-8?B?dGlZQnhDbHJ6WjQ2UDd3VlJzZEgrWUxSSGxTWW9kdVlDRWp5SGZVQzlhRWY5?=
 =?utf-8?B?cXlFQ3JnaHJwRTg2Q0dRTXpUNlVmS01RdEFjN3M1WnlQYW4xL2loeWtLWE9Z?=
 =?utf-8?B?QkNOem5CRlNDRHQrUVdmZHAxOHdiTTFmaGNZZmFwbmwwQlBORTl3K1V5L2c4?=
 =?utf-8?B?ZTlkYzl3K3JNVUM3VndtemdLbzNrNlB2eFp2bVYxbGg0aWg2b01jRjRMZm02?=
 =?utf-8?B?eHNoaUs3ZUFsM1RjWENXeXRNemxGRTdzZmhTd25kbi9rVDdoMWZZU0NFZWZQ?=
 =?utf-8?B?K0s4UXZFLzhFS0hra2VpekxOMXpwdVJubTkyeWJ5YytXSFNJUHNNSHgyaWIr?=
 =?utf-8?B?cHVjZlRqc0huNUV6dmN1Rm1neGtLN0JwamNldUdtS1NNdy9XTnlXRnVIT1J6?=
 =?utf-8?B?Yy9Yd0VZUGgra1dTNGljb3ZSSnpTUERCNE9CYWVXNEMzNjRGSUtpY0FFZkFX?=
 =?utf-8?B?OENiUHpLSHM0RjAzSWJVQkJEOFhSUHVDT2NJOWcrdEtEcHBJRTU4N01RNUo0?=
 =?utf-8?B?THlzejYvaktoRUs0ZlhCNFQxcWJhMXdBSzZXZTdNTHVOeStIZW5Hd0Y2WS9w?=
 =?utf-8?B?cHB6MTc4a2VNbmZmRS9ERlBlSW5Cc04rZ21ST3lOUzZzcUV5ZnFUdXplaFBY?=
 =?utf-8?B?R2dyWkl6aVZkd2x6Z2tnOTZOMVpqSkE5MldYTnUyK25ONzFOcnUwWklFYzNi?=
 =?utf-8?B?N25Td1FDdDdjbVlQMDR1V2VPZGxXM1pYRjBNOFlRU3NFaFJGaFF1S3BUV0ta?=
 =?utf-8?B?TUI3bEFUM212M1BXQ3N1L2dlamx3bE44OHNRU1kreDAvU1AwVi9icitQTWhy?=
 =?utf-8?B?NkNmOTUvYXl6S3FpdG5FL2ZyckNoczdSWE5UN1BFVFhlWXY0QXlGUDlVaWNj?=
 =?utf-8?B?R2g3R1M1TXY3YlZTaEs2UmptdTJlU05OdThmNDM2bzE3NFBydWNadWROcGFZ?=
 =?utf-8?B?d2Fkd1BJcGM5aVNVa1hVMTYvMEFRa1FHTkpBZndTdmVoY2lYdEpIN3JxVjV2?=
 =?utf-8?B?STVibDVKT3lsQXNDVjlqTDkxUk1qOTdwcVFBZmlhb0JaK0tCSHIvY05KWDdY?=
 =?utf-8?Q?NUFDD7AWWz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVpkbHNxYTNvK3dJUEtFMThkUTBHUlQwalRyazlyMlR2bThrVmRRRFVaL2Nq?=
 =?utf-8?B?bFdTQmdRNUdWdjEvaXgrQWRHNk9NQ1pqSUFnWG9FWjMyQkFzVVJVUVhuRVp6?=
 =?utf-8?B?M1pLT1VhUUxTUVJ4QTN2c1Vhb0tiL29uRXowdlNMbGtmbGNlSjhjR05KVGl1?=
 =?utf-8?B?RVkwVktnblJodXdTWXEvai9aczZLMzA4SExoQWhPN3hHR3ExRzhwVTd3ZWtK?=
 =?utf-8?B?aEhpWW44RTl5R0NoMnFndjJCMHVBU0tQT2ZmTW01VTQ5VUtzdFIvVXh6Zk14?=
 =?utf-8?B?czdVT0FsbHFUOHRORjVMNmVXWSsxZjZ2T2ltODJrVHVYbHlObm05TWlJblVV?=
 =?utf-8?B?RW5ERm52ZTIzd3l0UnRQc3pGQ1g4dFNzTHY2dFdrVnV6dnRSR0xMc3c0MFNP?=
 =?utf-8?B?OFVTUTlKclNUQVNxK0oxWGNFaDVHR2FuUHZQclBRalJVVEdJWHU3ZmFUYVhx?=
 =?utf-8?B?ajlDeGNaV1JmdWpLYk92QklMWENhd3lsK1lyNk0wNW9Yd0daQWR1N096c0RV?=
 =?utf-8?B?QTFJY3ZwS01xbmlCSDZHN3lQM3VJbkxuMkFFTW1VWjBGTkpLQ1U0V2ViT2Rr?=
 =?utf-8?B?aE9zc2ZEMm1wS1ZpNUtoemlraTFoQVVGNHFFUVprT3NxVlJuRUR3MVFYd0d3?=
 =?utf-8?B?NFdWbnBNbFNCdTdKeWV5T2t3cWRwZVBlN09zWVhEWVMyUnZJNXNNUGRZbTI3?=
 =?utf-8?B?RDl5UkdIa0ZWTXM1K29CL3V0cXBONHhCamRKdG41WlU3MHA4a3YycVRXNWhl?=
 =?utf-8?B?Yjg5L0JRVnRLQjFPenhHUmdBVFlsOEZxTzlyQXMyN2FTM2ZYQmJGSEtiVkFS?=
 =?utf-8?B?U2Y4N1ZKYlhFQm5NREdQT3FKVFRpS3ByWllDelFCUW1OZU00SjFXVnhzSXpV?=
 =?utf-8?B?bk9wamFiV2hRSlVFRVFka2hHdTNxTTkvemtVZGV2a2FlMUZ4b1pwWE1TZG9v?=
 =?utf-8?B?MSsvcWtlenRzTGZZaEZ2aGVVSnNaZVgxZm9kZkJiNkx6TWY0UUFpN0hRYXVI?=
 =?utf-8?B?MTMwMUZQN0MwVDVCa3ZEZXJpN2ZGYStRYkJ6R3FIOGxiV0tFNmlNanZyMXlr?=
 =?utf-8?B?WVVZaUQza011SmJ6RVRMbEQ2cW9VdzlzMTlwajFBV3hkVXF6b2U2ODRBcSsv?=
 =?utf-8?B?VUdrTXNMRjhJNnFzTTJxYTRGU1ZPbi9lUkxRS0pLOXVFbWZvSG90ZG9jZDll?=
 =?utf-8?B?YXhVK3BHamZkODluNUllR0NzbUg3WUowYkMrRVExNXhXY0xHL1RKR3IrWHFP?=
 =?utf-8?B?OXZZZzBjTVIwVlZ2UDhJaHU5M1BXOTJiWnZvYUlNR0hmTkZSSFNDc0UrZzlY?=
 =?utf-8?B?bmozelFILytZbnVQQmNMckJWWUVmUHZWQVphUzFGUHZyUHZJNU1SWkFTUXIr?=
 =?utf-8?B?bUkxbGNSY3lmNHEydFNtaXVRaVZlcFdPMG5BQWVZakRXVDFkSzFJd2ZCbWVJ?=
 =?utf-8?B?MDNpMzFuajhScHZ1OE9BaDlsY3BBc1R6bUxpMFNmUTJRUzY3cEJwK1NweFBM?=
 =?utf-8?B?WkNSR01LV0ZUeDVwYlB5M0l2Z2NVd0JhaEREWEYwNVdBaDdGbFZtN2t2Rk16?=
 =?utf-8?B?NXBtL2huMnJZYzBXbGdWZzBIc2d0UGgzUy8rMGJqZThHSkdib3ZyQzR5anpF?=
 =?utf-8?B?RWVEelpGYmVLNWdLeHBuYnJTdW1wcWxjUlJUUXg1RnJkMFk0UndUREJBUFhk?=
 =?utf-8?B?TVNTL3gza05NampYeFVGWUI1S21mYy9yU2JYSWpHSi9MaXNoL0sxcVl5THkw?=
 =?utf-8?B?TTFOaGlCYmdCMmQ4R0VYVHNxS1ROL2JhTjJ2RzJIUHdvZW92aEVyYzNBeEQx?=
 =?utf-8?B?b0laRFFwTnRtZmM3NEpoWTNvN3FzYXhwQnhwN2RvRFpXdHUwbkhOdXUvcjNV?=
 =?utf-8?B?U3dncmtQVGpJdFVuR2s3ekRCRC95eGRhcG9Lb2d1QjFVRk9MbmlVRFNJOFpC?=
 =?utf-8?B?SVZpSWdNM254cERDbENISDBiclBXRzJrbDAwbXFKOHhsODlsL2FOWUh4bld6?=
 =?utf-8?B?WXJhV1hiVnRIdU5HYjY4cEc0TjlCSi8rbVg2dWl1KzBLTmdjZFEyL3JZbVZF?=
 =?utf-8?B?anllT1FVODd3emJEZFpTNDRRc1MrSG9uOGVwQ1ZETGd3Z1NIb3F2YVRYRUlR?=
 =?utf-8?B?cWxTUVJOaTZHNUhydmcyUG1GT2NubzdESndRNmJxWklJbjFvMUhrQ2tJbXA3?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be50c32b-9001-4120-b8fd-08ddf6cf20e8
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:19:22.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFmBl2gD1EWXip2r0S1lB2E4GHjrFHd4W1ZnHZ55/gqDEuBBA8vBU7MRMK/sQa/1iRRKetjDvHrfBKFyEnokCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8493

On 18.09.25 15:41, Florian Bezdeka wrote:
> Hi all,
> 
> with this series applied dovetail is successfully booting up on a
> Windows host using the Hyper-V hypervisor as virtualization platform.
> 
> You won't get any RT guarantees - that's clear - but it helps to test
> non-RT stuff using a dovetail enabled kernel on such a platform.
> 
> The following config knobs were turned on during testing:
>   - CONFIG_HYPERV
>   - CONFIG_HYPERV_NET
>   - CONFIG_HYPERV_KEYBOARD
>   - CONFIG_HYPERV_TIMER
>   - CONFIG_HYPERV_UTILS
>   - CONFIG_HYPERV_BALLOON
>   - CONFIG_HYPERV_IOMMU
>   - CONFIG_HYPERV_STORAGE
> 

Looks good to me.

But the only way to stress these things remains running on a real
hyper-v. QEMU/KVM is not able to emulate essential PV interfaces that we
use here, is it?

Jan

> Best regards,
> Florian
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Added correct "Dovetail 6.16" prefix
> - Updated Cc list 
> - Link to v1: https://lore.kernel.org/r/20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com
> 
> ---
> Florian Bezdeka (4):
>       clocksource/hyper-v: irq_pipeline: Enable pipelined clock events
>       x86: irq_pipeline: Implement inband handler for hyper-v specific vectors
>       hyper-v: x86: dovetail: Close race window in PV spinlocks
>       x86: irq_pipeline: Allow CONFIG_HYPERV in combination with CONFIG_DOVETAIL
> 
>  arch/x86/hyperv/hv_spinlock.c      |  4 ++--
>  arch/x86/kernel/irq_pipeline.c     |  9 +++++++++
>  drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
>  drivers/hv/Kconfig                 |  2 +-
>  4 files changed, 45 insertions(+), 4 deletions(-)
> ---
> base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
> change-id: 20250602-flo-add-hyperv-support-for-6-15-37378bd63fe1
> 
> Best regards,

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
