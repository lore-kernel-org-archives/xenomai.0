Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0D34F478
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078770; cv=fail; b=lC8P1+fVCHTonJFVE+PjOog4/wS0sJeS25/LvdmcPhoDYmAlckLgLdWYzi9kYX/c8M8dMaW8NwWm8GdY0wCJfAMQML+4nPxdgd3HxjGuJqk4JGUQoXpgmbs9899chWporYTx6nHr9nHItJpSAy/uwtNlZAwY77TnAL3Bh4KvS7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078770; c=relaxed/simple;
	bh=5E2nq10qzsVfVUn/Zl42rIb1VT57HlxqkqRZ9WEolyY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Etj5fUUYZWvK0OV36phFOeMmHATG8excIF0ec501TG9bGqj/a/HK/1ZGe1i32pZi2fn1FSHIgdrAJUhj9WZ1rq8R1BLcJ9WCxibJ3jNJKDCt/YY98gxzQvklWCyv1+fkyKIhCKuvdgYkWmCeXrqf1MTAgslUmqeM/y/Bma5EFAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qPZIzYRi; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qPZIzYRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=objjAGeJENBfAtbGJ8U17cUjGZpF9Y5CPrW+K/AXcDrPGaEaJn/ombyteS28EcRibFxHk7PaynceK2mlIp64cgN5OcBnSq3iWMDoAWxI7R9Ew8VtcW1gTW45IIUYBOjG0VFDstIszZvEKmziYiF2TgOg/tUbNaiVwvGBcjRYpK24j+oTf9j4YrOGGJCLv3nBF5GSgiX+7f+T+IX5f1Ic7AMAt3qmfXlWTn9SDZA0L3pww9aKMr/xw5B7dffkYUlu79iiT2+L4FrL1DNjrU2JWz4bI43MJE3X1cDk0bz1I215uOOnRhMOOqCfACYEbkwyVNeV+5Xc9YC5Aw87aMGQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9yZw1ZK8gxGLVcR1jI2ha2LGJYPRRH2UY7Q48m6aJw=;
 b=O6DIhOEgkUAuQkGVv4fwBmPanHkTTLaugPNK65AAF7MIeWw6bCmgVwVjaWes1KwvTk+LOuw8OtXaP40zW2Gw448ywOVUPC1WpHU3uuDhGs5xz0kREvtQq31hgL8p8j2xrGqdokGtYNH14Zf/u5CWqPElYbumlXIm1UselHo3tP3SKgewbSgjr5JESLQKJ1TD9YGTOB3BpQ0WxDZzHQmETHon90LeoqF0Bpf7bPhrG5x8rhJ6Do+QtNkaN72P6b9aF+vgzsVccg1MjXsnyq23qIkmj12zpbecC5UoZhCsE8LGL1NSZQesqq+KG1FYyGyLhJuvuBdwaaU0r4gFlUaslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9yZw1ZK8gxGLVcR1jI2ha2LGJYPRRH2UY7Q48m6aJw=;
 b=qPZIzYRiaFn9pl5qJO2qo/qIRbbjJUWCoA8lbc5335DJypS8VdgFUlNI3kpEbToOgUGLCUc9W0fAv3SFuTqRJgtZ3BlLnULG0XozpurrNOGFx2mcvBkUryYyux7hkOuoVeWj47ajiZOxKxL1C9qYX1JjiD9WnyDHlGC1dk/Z2+/JXxbERUApCLdcE0fIITATHAjLSn6ZAJqWMPNvXZeq2KYgod3ND0PnquK0Rr8ytuQSaxB7wmwBBmDtUNOBFqGQgPrG1sTV8CaDGTdbsxO2iHX7XYmYzfXr1ro/te5mABpyvqI+IEB6powl1tOBpqzgr15z0bW3Io+9AUn7B8XTxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:46:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:46:03 +0000
Message-ID: <c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
Date: Thu, 22 Jan 2026 11:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260122103928.424945-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 299dff46-69f2-49f3-8c25-08de59a37064
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJ0UkNNZjJ1aEJRQ1I3U1NyaGJnbnIzQmhoWEt4a3BFZi9HZ0dQSnNRM2Nz?=
 =?utf-8?B?cHhHSjNEeTlrVlV1ZTkySmhFQ0FSMjFSakU4cTh4TE85YWordHVQYlRkYlVP?=
 =?utf-8?B?UUgrdUYxSVBhZmljdVF4T2ZrdndUcFZHNkt0RzcvTDFtdHozRFJOZFNBamNF?=
 =?utf-8?B?RzEzdHFCOVp5blphSk1TOEFheWdCT0dQeUFOVHZJT1NabFFkZW1odnFzK0RL?=
 =?utf-8?B?cTNpNURKc3RGYkdOQ1Q4dEI2cEhkeWUxbjNFRHYzS3BCTUFPWWJNVWEwaGdS?=
 =?utf-8?B?TThBOEhVZUphOXcxZXNVY0czTzhJNi93L1o1akJOdVNuNi92YVN2eHRsMktw?=
 =?utf-8?B?alloQlk0NmFnd2ZxanFmaXRZRkdzYlRGbkRBeHEvMUNMeXAwMTdoSFQ0Yklq?=
 =?utf-8?B?dFNMdzUxSllZMUNycFBWU0o3Rm1OWkR4UjZjcHpWYnd3SWQ3N2NLbkNsVnZ5?=
 =?utf-8?B?YUg4QkY2NmR4bmk3OHNINlgyWk43T1AyeXVGMHZTNWtHSGlBMlJBR0lHbUJs?=
 =?utf-8?B?R21QWnpXSmFRdVkrdlpUQytpYWJnYnNKL2NxSzNIQk9jVW0xT1NlNTlDRk1x?=
 =?utf-8?B?KzYzSDZpa0dKSzVYMkdvZnlnekxRWEVYQStkbDYyYnlQai9WeEdtbHZZZDVu?=
 =?utf-8?B?TWJvRnZIMllRSUY5Tms2UDdydVd4bTVxcGdZYi9NVXovWVIxQWFrNUtMa25W?=
 =?utf-8?B?MHpta3JNWFY4VGEyTkNQQ2pQckNOZFQ1Y2pVdSt1dWZLcWdZeXVROHNHd082?=
 =?utf-8?B?WUZjS3M4WDVpcVVMSUF2T1ovMklmNXcwZWFhYXVFRGhZNXFrTjZGY1pPWldz?=
 =?utf-8?B?KzVGUUhkdUhnSVB5MFhYV0M1OHhaanhlUGU1ZlA2OEZpcENDWDhWQlJsS2tN?=
 =?utf-8?B?Q0h0cGJVOVZ2SGdkTUZoZC9UUTJ2cW4vZEJMTDhaODVoZWtpTXF5RVN6UnRr?=
 =?utf-8?B?MGNnOUVkcFhsMGNNK3kwdWJESEtPY1BzZmM2M1pWMXBjRmJiVXM0YkVNMVIy?=
 =?utf-8?B?Nkg3MFBmTkV0ZC9ZV3l4VGlqUFZwSVZzcU5mcDUwZ3VZVzhjM20vNkZOSThD?=
 =?utf-8?B?YkxCb2dUV2h6SG42YXNyVkZzMWlCMUhwRzZWelRQVFJ1d0NoSEpCdGwzcWpJ?=
 =?utf-8?B?WW5pLzhYSVFqUnRxcXZiRG40RmczUTdwN05TWGRTek5WUVpscmM5R0FqNS8z?=
 =?utf-8?B?TW10citMRHBFaGxsWjR3cWF4ZDRHN1RQdE5oOVBtTzhndUMzWDRvWVFtdkU0?=
 =?utf-8?B?aWtZeUVKSGF0UHBjVzdSUENxVkcxd1NDdFlaaWtGVEVTTjdPS1k5WFMrRUEw?=
 =?utf-8?B?WXZsblBJVzFTcjZQeU51Rjl3aGZNRlB1L1IwTkhha0M5ODQ1a1RtVE1IZ0N2?=
 =?utf-8?B?UHdQcVRTTnM1bWRibEJPYkJaVEFpYXg2TlJBT29tMVlUak0wbGpPRjB4VG80?=
 =?utf-8?B?cXJISUNpSXBsNnNjTzB3SUgzT0x4NWs2K3habUxFNWlWTjI3QlMyTldua01V?=
 =?utf-8?B?eE10NWFiNTNEVlJiNXVXVGFxT1ZOU0twMlZ1V1Y3V2lYSXFvYzhIcWJ4YW9t?=
 =?utf-8?B?N210TlE3cmM3SUdQdGpWOVFNek81SC9BNmMvVDF6NnMyQmdKeHcvNVN3bnEy?=
 =?utf-8?B?TXByTUpkclZpU1dOWDhBcU9mM2NYVmUrZURjSmJTQWlFRzVDT0lzeEdvRHhs?=
 =?utf-8?B?QnBCdXUvVm9BRktKRkowOTFWR3NlaHpMaHV1clA2R2dUb0l5NmNrdGp1WUJz?=
 =?utf-8?B?cUdhN2ZQcUwrdzVHRnNXVmtheFZhOVVhWCtXdzVTNStCNU5NdTlmcGJOUkR6?=
 =?utf-8?B?U3pJaFdRbmRIdTQyT3ZibUEzbS9FSmlTanpQbWZtSllMekRwaWxmRDJ4UXRw?=
 =?utf-8?B?dGRIV3NFYno2TkRNakg3MzQxMVFXU2lpaW1yYmhjS09tRlN1dmoxOWJCK21W?=
 =?utf-8?B?blk0OFRPemx3VXZDRGJNNnJjQ2NnaFZrYXhiaHlqWFpySlc2T0FGU2xyUzlZ?=
 =?utf-8?B?bnR4ZXp0b3V3dWU3eTE0OERlSVRqYzNUc0EwemhOWkc3a3VPRXpqZHlCVGpO?=
 =?utf-8?B?dDhjdWZLOGhIWldKNDBoU0tFNWY3NEhPNDJBN1JVLy9LNFhRQzNld3BZNHJ6?=
 =?utf-8?Q?v2kU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3FrVDN5ZEk1akF6WjJ3Q000cFg1M1lCN0svOXVpRitoMVE1T1pVTTMvK3Q2?=
 =?utf-8?B?bHhaSFpzR1gyTGNxNkJtUUJuVlFUWmU2azdSZndQYXIvb3ZTY1BBNkxDejdn?=
 =?utf-8?B?TEhSUi9vZlJuRTcreHhjOVVLNTRrZGJrbW1TWWsrdHFTY2tLNnd3MXpjYW5B?=
 =?utf-8?B?bHg1dWE5aXo2WnhWZzBpYVUxeDd2TXBITmJpTWtuQWhZQ3NOUWlkV3F3bks4?=
 =?utf-8?B?Qmx4MTc3dkhFTTN4WmpYd2RETWI2Rmpqc2trZEwySEozZTBySUQwZU1GMFJu?=
 =?utf-8?B?SjV2QUQ4cVlRK1hjRFdDMHZDVmp2YlIvNk41VGFOVzd4K1RFZllzczd5Mkl1?=
 =?utf-8?B?d0pNeE83dVBqL2pMdU1iUGdHMGh4NnhkQkd1N3ROQWpFWFVlME1BRDM0ay8z?=
 =?utf-8?B?TDhHMWZIOTRsN3VnUXFlWWJMZ2tGdEpkVkU3V2R2bEF4YVlqc290MEw2eXJy?=
 =?utf-8?B?K3AwejlDZzZ6U2tKd0U2aWMwWlJkSGVnSGhaWnRNUEw3SUZ6bHJ0MGovR01a?=
 =?utf-8?B?YU5GTTV5YlBzQnFqRFF6enlPR2FORzVLYjNoc0pCN1FxWW9JMUFzY1NoRnpP?=
 =?utf-8?B?Q2IxeVBBUnFCRWFlUVlzYWVMdis1RDRXRFNqTzRUM0RzblNKU3ZWT012K3FF?=
 =?utf-8?B?aVdxMDk4T1RRYlNBSTF5Uk9lT3YxYTJQTVRMWGhKTnptMEUyY3RDNWVsOFow?=
 =?utf-8?B?M2o5alNudmlhNVNvVlJqcWR1aVpHVUthbHZlUFYzWXg0S0dTTnpnRnc2VlJp?=
 =?utf-8?B?NmoxNFJRODJQMW1JUXdkTTBLMzlGMDRKd2NlTVJOeFlKT2xhNm5MUktnUGJR?=
 =?utf-8?B?VUpob1VSNnpOR3ZBV29FN2dqVUgyRmxBWkFUckZtSDF3QTN2ZE1rSE94V0V3?=
 =?utf-8?B?TEdzRlZJU3FNOHFxdXB0OWJ6Q1oza29VcUVrazR2UDRMQTlWNDhCZGh6bHZR?=
 =?utf-8?B?THRwSjJ6UXJJSm1QOGNZdlNoMWZBd2EwdHVRa1owMnVIU293TFgrRlA4SEly?=
 =?utf-8?B?LzRDekdZWTJxd1VwcmdPYkR1V2lJeXRjWHpGZHloWitRMVRpZ0lQMWhZL2Zp?=
 =?utf-8?B?SjI5KzlXVC9iUlJxOURFa3VIMEFvV0ZDVHcvTWN4dTVzakhaSDJqbjhJNStm?=
 =?utf-8?B?alYyL1UxbTkvZ1lqZHFBZEhnT1h1TUhSRlJQN3FpTFBPTXdjRTgxc2c0SGVv?=
 =?utf-8?B?NUhwTkFiWWwzanJqaU8zdzEwT0twWVVsU2hBanEzWE51ZFh5VUFRTjNtOVF1?=
 =?utf-8?B?VVNZcmFkK09weTl6SDc1OXpjRUlmUWNjc0dXMW9wVUxNWHp6V1gyNU9kMkNl?=
 =?utf-8?B?SXA3dWZ1RTFEeWVCUVJPWjlCNHZCVkE1T2hGOHEreVI2T3ovYjVsZXhiZWRw?=
 =?utf-8?B?dlFBMjEzZnF4VkF5TGIxTVVKSDRyZ0hzdHI4T3F0azhNTERyRFZEdko1aDA3?=
 =?utf-8?B?eW5TQVh5L1MydWlKVWU5bEZEbVF6cWREYzBMZVZXODlaV05KUGZEbkF0VEl2?=
 =?utf-8?B?cktpZzY2bFMxeXJhYmZnK2RDOVhNZnNkNnN6dk96MGhEdEsyTEUzQ3NmTW82?=
 =?utf-8?B?Ujc2RXQ1cDcybUZXRyt4VnlzNWREY1BxZEkvM3dWTDRCTEdOdTdVaXNtTW9C?=
 =?utf-8?B?ZlJhNUkwS1U3Q2hDcFpMZ1AyYW9OMjVTd1J4c2VJZEFXQ1gyUGpiMkFOblFl?=
 =?utf-8?B?Y0xIUjQvRU5pMS9qdGxEekFodXNUQ0tXNGdKQkpDNEhIcjBUUEUvc2xFMFg0?=
 =?utf-8?B?dEptN2dxdGNPMzdvaU83aTlEdU1RVEFYUE16VDcxaGZzTitBK0xmVlU2Q2lF?=
 =?utf-8?B?U1BDSVJsMHJ1ZG84RGpGSlYwaEdzQUhWSGFYdTZGengrNXlGNGUzY1hGZ01s?=
 =?utf-8?B?ZkxzL2xMV1ZKWnYvR3FTeTUzd1Rsdk5rdHZyUzhLYnRWT2hGS0VvbW82VTJx?=
 =?utf-8?B?Ulg3VE90Qk10MDYxNndDL2JZaDJEc2JsVHd5YnlTTTExaEVjamFJdW9yZDJQ?=
 =?utf-8?B?a2pDR0QrRDJPd1pDK0dYSi82TEdHU2hsc3NLWXJCTlIxNEhZL2dybW90VjFs?=
 =?utf-8?B?a2VDTm4zMHNBMDZZb1hmMkRWaUl2ZnJ3MjJGdktBOFpZZkk1c2szcFhxUnQ3?=
 =?utf-8?B?dW43Q29zWHhHRU1YMWt4elhZSmNzNmIycHl4TGtpWjN6ZzZDb3F1eEZsOXRW?=
 =?utf-8?B?UDVveWVnMGFmYXpITmM2ckRxT1hZeHpPTTR0QWtyV2VNNGFqY3pjSEJyQmJW?=
 =?utf-8?B?NnB4eHVzV21sWFBLODMzczllTVJWOFExQW1KTlJQb0Q4bFJ5Mk0yRXJsNjl1?=
 =?utf-8?B?cjd1OXlWeFowcWExZ1FiN1JQSFFPOFE0VUdlQ3p3bFZNb3FYV3ZtUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299dff46-69f2-49f3-8c25-08de59a37064
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:46:03.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8GjwmYxROK6THYnKY7sfjjZmasauUtyKHRsHmqrCZm3zjTNE+MNKuvSFJ8/+tZKArfOl5JJfd2uEsONDHffaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117

On 22.01.26 11:39, Tobias Schaffner wrote:
> Run the EVL test suite for some first smoke tests.
> 
> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
> the moment this is used to disable scheduling quota tests that fail on
> virtual targets.

And why do we disable them?

> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 5 +----
>  ci/xenomai_4_next.yml | 1 +
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 186d1cb..76e38e6 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -107,8 +107,6 @@ default:
>          - report.xml
>      expire_in: 1 week
>    rules:
> -    - if: '$XENOMAI_VERSION == "4-next"'
> -      when: never
>      - if: '$LAVA_TESTS_ENABLED == "true"'
>  
>  .test-qemu:
> @@ -116,9 +114,8 @@ default:
>    variables:
>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"

Why set this variable here, rather than close to its use?

>    rules:
> -    - if: '$XENOMAI_VERSION == "4-next"'
> -      when: never
>      - if: '$LAVA_TESTS_ENABLED != "true"'
>        when: never
>      - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
> index 30ca9b1..03dc233 100644
> --- a/ci/xenomai_4_next.yml
> +++ b/ci/xenomai_4_next.yml
> @@ -20,3 +20,4 @@ variables:
>    KERNEL_VERSION_WITH_QEMU: "6.12"
>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    CACHE_KERNEL: evl
> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
