Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615279FE
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279935; cv=fail; b=UtHv5ciNkh8uDqS0Q/TZFuGLcbEt4ksHUljmWljnGdG31aukkgqrVrU0i3L5SncR2DArkAQ0vGKt0WbyK4oXysIGm92d8j+PxLwyD9NYTjeWnPhBAwPmoY5YrShhSQrVKhIB+OXFHaqJiFnz9NXzqS+cYgSdZKdQt18dc6SVXgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279935; c=relaxed/simple;
	bh=N1SqEfHvuT9rzRqkrfxGyx83L33CerqKhQhOA/1r98Y=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h86L64ZMu+G2h9J9x/jQ12rxPICGTH+7EjPMNASCzouX20RI0wAbimSSVLCgbvpdnPeUC0GFD+/4Stiqr0oIVYUZfgma49SoCK5WTMHNqIosX3w7bm8uZPF5WJcq6tRnmdKFPY0+GvGkQElfFb/52mFobmxZ6dgyxIffl77041U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=I6i60VNs; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="I6i60VNs"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 53E49240003;
	Fri, 22 Nov 2024 12:52:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::611])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9201FD810B3;
	Fri, 22 Nov 2024 12:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIdbtvCqFbLQ25B4usxcLQeYQDsV+ZegDmQyARDIIzagwbMEtNG0tJ/leRoWmjp/I06HRpRfhqzjDkebtIQ5rwecMaRGMn87rBJ3oL4+I25UfjKspnzfStCD3GonJqbkEP61QnKwr9XykHe8bFClmDUV9Mh7FOloIvPF+GLNJe7mqL6o8GYrc5ESfVkNS+3RrfE1oEFEDOQ8lplvgZ2PKEPuAu/V08S/XI2y9N/hL9L76C67qfONCifBzo1/0OeeMycwZFF9Lo7BUhckAZOElrsW8l7VokzovquMSKh8IRH/BMrLRvXfrmGXI8CNG0GGh9t1tCtH0kiBbgj1pOaLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS5PGBojIh3s9JF0BOVo2MZb13nMYthwvhAQo5z5yc4=;
 b=yE5tzGxp9aXJOQFNAZ78hYkDnUj3nEyhTJsrgk2J9EbrCj3L4FIDaBTUFwbdyDWXVn321LXhFYR1vlVlLqvYEhsMKTotS4SY4rU29rvsJVaT4/1XB32pDtIVZL7wTpT2E3kDx0ZflyKLhuPbe1RRH27FEFh1krIlqW9+gFEqyD9dY8TVIplzdb+YPjvaxnD/TfeOOVw03TsxugZRvePSNI4XGmyF0q7NpMOoP9XN9m+R5x1PK1r2+mKjlDC9doWEdBEI53YqiWtdmM0ZXTvitkFcJUUZSo7ivYpJstzBS4gybYlZis2B7wQSJ0Zw09ShIJxeJ4Fn69jTgL35CeFZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS5PGBojIh3s9JF0BOVo2MZb13nMYthwvhAQo5z5yc4=;
 b=I6i60VNsR1WUSSTtU9i+i48nTh45P5VQAOI8yokx2V+76qk9ld269/8l+UTJrq0luqzsf9gP9N5wPH2Dg/PrwjFPRp7HsKPuSX+BJkxKT/gmQOAGBjsb7/lZixiugQDOiBM3sMSMIsWHdhQX4Vt2T2kWFnPDnK2XSw1jb+SHp2GOKPOZRwPJhoBUXl8LKWSNl+mP8Tdqxtpc+VsxAYj86RdsSeMb3Wjhuzw1aKFuVSEbcVDkWVnoV8HpGkSm7s0o+eJqQmL7512cHPBPeJWDbuhhxidCN7XfolrlHjAjOJhLrQp+kMii8Hpe1jUNVYfxZnFSf8FD1BDLXvc2uaHehg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 12:52:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 12:52:06 +0000
Message-ID: <3b14df79-5b77-42a3-ba64-4f0a454c7d3c@siemens.com>
Date: Fri, 22 Nov 2024 13:52:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai.org + Giltlab
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>,
 Philippe Gerum <rpm@xenomai.org>
References: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
 <c0d68831-8391-480e-94c3-b5666edac991@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c0d68831-8391-480e-94c3-b5666edac991@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 51169bc6-2ad8-4492-dd8d-08dd0af47862
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dC95bDdqODAyNGRVdkg3ZHpIRlYyclRRdHNVL2MwN2ZGSHJWZ1lkdmtLSy9K?=
 =?utf-8?B?MzhLaW94MVJCVGtvZkFLNzZhY2F3akxwNUlxWUVHUmhLcHU5dFhGUCthY1Ft?=
 =?utf-8?B?U05GRzRVZ1FWQnNyVEhoUnd4SXBPWGNTKzlMbDBMbXJyQktDT1cvZzJjZ1pm?=
 =?utf-8?B?Vk5TY3B2TStmdUxmV2hYODJKZXg3L0IyMHltVVhZNFNlY2RTYzJVWEExQUZZ?=
 =?utf-8?B?R2ZLVjNsYnRTQytxU2ZheWV1VEpKaUJWbVZZNkFoMUNJUHA1T3FRZHpaM01C?=
 =?utf-8?B?VUFvcitOQkdRbVh2RjBlREdKcytxUENWY1dJMjI5YmlwWlRtU0ZLSWZrdEhV?=
 =?utf-8?B?TWc0dTJzNDdMVnFNdHEzWFhaOU5aQzFQeTFuWTFrQ2U0cnQ4YUc0bVZibXUr?=
 =?utf-8?B?TW5RNjZVOStoMk9MTnljRW84M3B4U3dtOVZ2cE5aRjdBOVo2cUxDekp5OHhN?=
 =?utf-8?B?R043cm9pNTdsdDNKME5STEUwVS8xcmR0bURhUTZSQjdTZEtmYkZWZlpRRmNj?=
 =?utf-8?B?S1QzekltVjJRaWV2WEJmYUxYbnhvVXF4dGlBMWhnQVB4dWhxSmhsM3pVbG0y?=
 =?utf-8?B?bEZJQVRQQmZVQ2tEdGQwb0VTTnJqUkRLSmZwYWU0OERWVjVrc1pzL1lEQy84?=
 =?utf-8?B?dFlvcmV6RXEyWjN0R2NSZ3c1akhLdkVXZkpDblEzWnhla01MK1lwb0lncTl0?=
 =?utf-8?B?VkVWaks0YXdRa2lqSG5xZHFBd0xwOWVadEZxa0Y1YXpQZ2NybUhpNjFVa25n?=
 =?utf-8?B?ajk3Tkw4Z3VSU3ZIMGhrR3Y2dEpEazh4cWYxVUx5RWxQTjhUdXduRlVEZEMz?=
 =?utf-8?B?bVNPaFNUcFpDaThka1VFYVpjSStuYWFRc04yZmVIZjFscitod0cwOENJZU80?=
 =?utf-8?B?ZjVGdVVTbTMvczFxZTg0MlVyazMvRnJoMUwzRUZLRTBkNFhwK3ZpTi9vMXBL?=
 =?utf-8?B?Z0hqNDVHZTkxUDFRMFQzVENaWDlRSm1md1Rieko4SW1UTWltQS9qbkxFMk1F?=
 =?utf-8?B?OTZoaTgrY3E2SExNajAwaGVKa2E0cXd5VHdZOU0rS1dkRFZZQVQwYitQVHY1?=
 =?utf-8?B?ZC9BWFBIU3diVGlIZmpxWDZjMVdyWnNBdW52RGQzbXFndVg1YWtsRGpKNCtZ?=
 =?utf-8?B?bWJEbmU1NWV4SXcvMmhMYzIrZEFhZlhha1NmdEgrZVA3aTFnR0RxbGJ4SkNz?=
 =?utf-8?B?K1g5b2pXekdpVjkzZ0h3RUl2bzdCNW5lS0R0SFZlamNQdW5ETHdlTysyRk43?=
 =?utf-8?B?dWhnYnMveUVUUHNvdEVrZ1lidFQ3UkZZVHdhd1NiKzlGUDJMb2ZnczBkV25V?=
 =?utf-8?B?RWRpb2ZiTlNieHhzYXcyUTE4Uk15M3hOUVhBSStXOGQ5c0lDV2FNSGRvWDlm?=
 =?utf-8?B?KzFZcVhDMUNZRVJDai8xYzB1MTVjOThNQVFXV25qZDVmbE43djlKQ1hzSXpM?=
 =?utf-8?B?T0pBMjZLYjNOcFkxRDhJZEQ2ZTdnU1czQS9TdHlkUDNpS2xCUHRjNUJ3NG1m?=
 =?utf-8?B?T3FQVmt4RkVOb0xGSTg0MEkvMHByZXg2L2JiOUgxdFU1d1lzZWxYbFU2cVhr?=
 =?utf-8?B?czVjdmM0VTZBQVlla2VxTEpGM2ZQYXAvZXRVUWNOMnNSMk5PY1FhUmRVK1c0?=
 =?utf-8?B?S2luSkRWQ0MzTEF4ZmxXbVc0ZERqVW9DSm9ROFR6M3VFTVBudUJPWERFTjVH?=
 =?utf-8?B?TEJhb1l6a2loUUZyVVdIVkcyUDVQbk8zQ2VDeXRhdm0xWDRYdXpRYUUrN1BK?=
 =?utf-8?Q?bLpdZZTO1OgH5N9N4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0dYMGpGTUx1NlIycWh3cnlOZTFRYnhscjdhblNmNU5oTEcvUGI0N2xuZmFo?=
 =?utf-8?B?YXhIRGlsbm1hM1hMZ1AwMXdYT29NRGJodzZJTU53cE1KQnlDYzlyN3ZXK2wz?=
 =?utf-8?B?d1U5L0NkZVlQSVJ1RnpuK1BoQjE2QmIyTkFmcFRIS01KZE8yN0xZWVdkclpD?=
 =?utf-8?B?WHpvK0YwR0FJb3BzUzlpWUNHQUIvTzFVTDdpeG5uU2xEclZNTXZpQjlPNjJZ?=
 =?utf-8?B?ZWdXTDMzNy9QRGRsSEU3THpmd3RCYXhTaWROcU4rNkNwRlZaM09hamhVWXRV?=
 =?utf-8?B?YlZtZmJFeWtoNjhybktIUGszTlFCMTQxdGpXR2Yrd0RjaVdJMHlabDgxVXBW?=
 =?utf-8?B?UE56K3phd2JON1dXaExtY3pmWHI1SGUrRlFmR1hsTVlkYldJU2RvREFsOWlm?=
 =?utf-8?B?SkxWcDhzL2tJbVFSQjc1ME0remZhLzFKVENVNHFWUTVWSmVYSHRieWdLVzV2?=
 =?utf-8?B?b2lCR2Y5d1NaSlhsZ1A4SVhaYlpzR3NsN2pOaGJTYjVla0lVS0hYUm5zYTZB?=
 =?utf-8?B?M0FodDFDdklTMWtPbzNpT256S3RqWVNZb0w2Y0dsMXBiV2FlMXg5Z3JlblRx?=
 =?utf-8?B?aXZPN0NMZ3Z2Nm1LQWZZcGlRc0tnZldDQ2F5SHdYaGJoYlVYOFJEL0o2NDJw?=
 =?utf-8?B?c0RZRm9udkgwOWRWUURmRjdISW4rck5Rb1RVQU42NFRaazZ0UTZNVGR0SHF3?=
 =?utf-8?B?LzhxcmNkN0thS0w0eWJ0ajFpRkVmTnZyQWpCN2RhbkYyNVR2ank4dDFQOGhW?=
 =?utf-8?B?Qk1McUhVdXlkdUd2bjJ1VlN5MXBXaXhCUWIvSkM3QXNEekpsU29Jc01NKzN1?=
 =?utf-8?B?RTBrK2Q1cmZTYjRGNXhvQWNxZ0xIVTRCTk51QzJiUXpNMmVoVVBkc1hsaTRp?=
 =?utf-8?B?N1B0RGttQUMyQktuLzdzSWJ1N3lGQmh1MFlWNnZTS0tsY0tXaEduWXZqUDI3?=
 =?utf-8?B?N0VEa0VhZ2pzclhhTGQwV1hwaWtqYVMzMlNhWGlzbzRnei9MTHFNZUg5Z09p?=
 =?utf-8?B?ZFJsMTZtSlovZC9vQ0xseGh0YzkyT2NKcnlrbzFTZmFBc0dEU1puVWhaTm41?=
 =?utf-8?B?NUphN1grUFhBRm8wUVgzSW1abnlXOGxmZ3RJMGFIeWl2cUxQaVVVWG1XRTQ5?=
 =?utf-8?B?MjN3TGlZb2k5OUR0Tk1CbHRVZTl2QmNpWHdBQllIRHQwc1E3Yi9IVlJ1dEcz?=
 =?utf-8?B?dEdIK21JV3d5b1ZLcnNWYys1MFZpWjd2UzFZQ1MvNUI5bjNBYjJPUG9CV29R?=
 =?utf-8?B?cXZHUkxPMllXd2VSQnlaeWlRbEdyYlJrRFNOZFhrTXlIU1cwb3RKZ0F5bmZK?=
 =?utf-8?B?ak4wSy9ReCtBQW4vWG9MWVVJbGRaWTJQeXlUWk1mU1VYaVJoVFZKWHVEZjJZ?=
 =?utf-8?B?NnpFdXNuZGR3NFM1OWdRN29XWCtlclV5aWtKRyt0Q3BQb1RBVVMwcWIvbDl6?=
 =?utf-8?B?b3dCZlIraGZ0WnptalROTU9IcGxvbjgxTmxEYzZqV0NhN1FlY1dBSzRyL1Zm?=
 =?utf-8?B?QlJaVzNhVDdtb05tUUx6Y0xHNVRrdEc1cjdidFN5SzAyb1VNZkZuR2phQWdW?=
 =?utf-8?B?NUl1VWwyZnNpQVNVdlpud2ZwdlU3eUQ1K0xNRFdLTzJ3aDM3Ujg2djMvMTBy?=
 =?utf-8?B?NGE4S1hCVWgvVzM1TytNVUM5ckM2NERuYUc2cVN1VUFTd2RGUW5iZFA5dnhs?=
 =?utf-8?B?a215WlhVUnBpbi9iM3lHWEsxcWFMN3Zhc0tPKzI4RjMzMHNlVnN6OWJrYzdT?=
 =?utf-8?B?aE9TSGJ6QUtRT2EyWDhWTnNqc2J2bVhqTmZyM21XSGJxdUpCYVZBaG1wa2JI?=
 =?utf-8?B?VndYVytEUlFHWW9xWWF1MTlqcmpKSTFwTzJPSWxlUldMMnlWSkdXVkR6L3Zu?=
 =?utf-8?B?VnRSU1NBOWxrR3NiMjgzR3gwQ012WFpYblBEVDJLQTliNUZuMTExTEtPc2pE?=
 =?utf-8?B?OWRyc1hRSmgzaHdielhFdWlqUXY3UjdvOXp6U0hiQitqcnR4VFRjOTUwMFNB?=
 =?utf-8?B?aUdSQmtBWldndnZxTFVUQUlFMURRZVo1SmYzd1laWFk3SDROaVRBNVRpQklh?=
 =?utf-8?B?UTYrdTNsN3FDQU1VQjlOTGNvYytPa0ZNQlRjeVBFYVJ6R0VGNEgrengwR0M5?=
 =?utf-8?Q?C4ataMOyUtQEMwwo3id26w5ff?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51169bc6-2ad8-4492-dd8d-08dd0af47862
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 12:52:06.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jrrv/E1lNW0Vr6hbQN+GuJEnzIZisFxH29xIFMd0Ww37QEJ0bUq4LhNAE46SGv+WuCKEqoN7lbXGGapAioxopQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8835
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=I6i60VNs;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2613::611) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 22.11.24 13:51, Jan Kiszka wrote:
> On 22.11.24 13:44, Pierre FICHEUX wrote:
>> Hi,
>>
>> Looks like there is an access problem sometimes...am I wrong ?
>>
>> Error 502 on the website, very long access to the Gitlab.
>>
>> regards
>>
> 
> Confirmed. Philippe, anything related to you refactorings?
> 

But now it's fine again.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
