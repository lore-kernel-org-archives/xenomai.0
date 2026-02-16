Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5DE571
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228275; cv=fail; b=QJ7efnnfjflMH2UjnaHAAcvHVGfvtTwX46CCsgTvWJbYszD278u5mjjtsx7aVkQ92EVM/vwliWlof31ylcDnXcPc0nx5WwwqW+f0QLZDEihCvE7VC6o6TBvf3Zky/dPBaS7PhQOYE5yqpROLgstq0gn8S1HQkpxMTwK0goRT2O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228275; c=relaxed/simple;
	bh=zHnOy5jSOfgKqgxxH+dmaQ5mSDKG0WfsWmzpQ+Wg2MU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJKPhBzHPOv7XdUecLgV0jsmLnVl3S8Sh72dWWgVeY3LI6dhZ/ftHQkXLv7u1pHx9CMb2Ruij1sOYW8v6usgdhYTScif1H9doaNjgckeUJXZg5D8X5SA5zDGRtv08CmaY5ee/7iUHOdGFQHK7VQBUI4PvcHojP4EWfrZ8sETWfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WfWKprpc; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WfWKprpc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWapDBzxzfcH9wsXsd78K8L07kNXPvdjfd+lzRdZkzOVF6iuxvLDrKA6ExmZBdByg5uXQcApa2qzco9zdSWM3OInkhkQy6xxUh2RGpIVgT6kpaYvMZE4ij3duFQfH9XLKynr6MB+fdjkMIqQET0c/PUcoPqz9PA069BqeGoxeKsjXMFeOBya8whg+MU/ZV5nUDspEKlIAZVh+Vm8zT3ZZtpJHBD09Bd5iyhGbOZC5NAktyTzPpJ2GGbAUcfTxZL7EK80JbuD/QOEweM/T59/Nfm2jWZLgRr8lKQPDI/JwWqk2+tBYPDm6IMCdnKkt9mHZpM1B9YWV4OBUG9oU47HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRcFE1flRpnSu2C7aT4/Hr2RLttCDqJuZd1LHb+n7jo=;
 b=dpGYbB1SSpKX2kl6521dwXmftrL/g7Zs98obkH7VuUZu8ldXmOR7SUkjomS/36SPLutH49DtSZTh2WHEClfRn22joJp1ZAcdQXPiuKUzRo9iRPXkow/zbV1p/z0NmkxY9/5OvpI2nvjgVvAdYEPiLIUqTkHHOEatDZJmV1n8q94czY59HECIzn/cDTsgFATjqCaBLnJ2UyRRPpkusPcSQAstGbMtPyFppEdrrXFTYlSADJ9j24r0ptta3lkOJOUcJa6e5fOnuYZX8HLIwXtAlzm8vFZO0hVJ47hWctB3EtsoaQfztM9uSHMY2sFjEB9rLLGSWsLXBI/Hk/vq8uF6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRcFE1flRpnSu2C7aT4/Hr2RLttCDqJuZd1LHb+n7jo=;
 b=WfWKprpc7PEEbkSumiFMe889gUVI0kaaDDS8EufxYKtacwWlpAJRKVoz15UCGV7SX+LNv9S6O46qgcmkXIFDvlIvEGJ4C6KXgNbXNvc8/sgL1tFxde/+Whyk1XRbBbA6eqGuQQKgXic6zp1UA5C9ZkmTmlMVKUcjo91x4DXiQFD6EVNb6/6c+S7ayQY6hSlyX8Aqy+VCcFK0Mvg3NaRjslObpL7tqe4h+5habsdGCNXmhj/0G+BI4UI2RWi8eWc0i8Xt9yVfR/M9yOooP/HP93lv795aLvNE8OZt9QlRasYDfu6OkVACID5svmMXn+2liQ8IScEhUuZDpzC7d81DJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AMBPR10MB9276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 07:51:11 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.20.9587.013; Mon, 16 Feb 2026
 07:51:10 +0000
Message-ID: <5895e6be-8d12-42af-8ae0-af8e963d2908@siemens.com>
Date: Mon, 16 Feb 2026 08:51:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci(libevl): Trigger more kernel
 combinations
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
 <b61769b4-7885-41d1-9a31-cc307d90bf88@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <b61769b4-7885-41d1-9a31-cc307d90bf88@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AMBPR10MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 45de50d8-0e7b-4324-55d3-08de6d3026ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTRtMSt5RGhFNmRBY3N6TFRaR1JGaDJ6WlVDQnBsQXZ5WWZuUHF4ZDZnQlpv?=
 =?utf-8?B?cys3L0JjVDNaWi9RVmFYZkRUT0dGMk93YWNRVFZCdWhieGcwOXpiQTlCcUNy?=
 =?utf-8?B?SEhPWTBnZ1d2TFdyaXFYQTBlZzB1bThvYzB2Q3VheENHQnBPeDV6R3pKVnBK?=
 =?utf-8?B?dGVBNFc5d1p0UTF4eTAra21sQW94L09aTEYwd3ZGWXh2bkRrZTdGOTZTM3J1?=
 =?utf-8?B?bkZ1N2NqUWhMa3J3MmJhVHFSTjBYWUJ3TERvdmlmbEI1UWZGNzcvV1huZ0dy?=
 =?utf-8?B?NzFlRmJXSGo4T2xtcWFDUFFDQ2JCTHhTcjJTKysrWUpRY2lEenVGUzREYTNL?=
 =?utf-8?B?elFqSllPL2RFbCtoUVRxMDhnUHQxaDBpNzhhVVd0ZkIyQnZnbm5WZTBOWENU?=
 =?utf-8?B?ak9jYWJLRmlkY1R0c094WFQzNzZDNzI2QWluN2IrcmNrUldXWEVlejJxbGVL?=
 =?utf-8?B?NGJtRXNCdnhSVHhXS1NCMG9yZWtDd2RKMk1KemwxR0Y5MWJCSlR0ZW1DQTRP?=
 =?utf-8?B?MkJ3N2pCVFE4MDFCdHhvaXNuNWVUWTYxUUVucHdJN0Y0RG4xa3V6aDZ6RkRZ?=
 =?utf-8?B?enhYSzRXRTFqc3JUUnROZlJaMXE3bDY0eGFnVHFZSEVONXZBeXNONG8zazhL?=
 =?utf-8?B?ajRkeFdHdnhXSjllQUZpb0ViQndEcE13bGNDcCtnOWJ4WWtnVjBWRkNWekRB?=
 =?utf-8?B?b1NvcGxEMWFXU3lTRVI4SFJGdUsvalZrMjQvMVlkZE5nakJrTmVJMHYyd1VB?=
 =?utf-8?B?UmxzYjFRSkcwZWFYODdqVmVKSGJRSWVnR1dzeGxUcHZkNE5NVzk5NEV2eXpX?=
 =?utf-8?B?Qko4aVo4NlpTNStqam5GeUs4ZkZCZmRQZk40b3owUEJiMVprRjZWaVRRNHV1?=
 =?utf-8?B?NFA3STZSWVdHdjZuWkVnbFFDMHhwaXFLRG84cC9VVUJhQ0UybnhJYmtpTEc0?=
 =?utf-8?B?a2c3T0NDMGJUV3ZUaURBOEREeHZDZ3JrWVJGRDRsZXE3Y1JUd3kwNlk1MHFE?=
 =?utf-8?B?Y3dYNjdRaVVHYzBtYkJOcklOTE5wajJ6d2QrM2RVcW9nVWZIbUhzUUU2eU9l?=
 =?utf-8?B?K3NXMnVxc2J6ay85bWhJMGs3WjVSaThzbDF6TzNkTXk3eEprd1VRaTVSOWZz?=
 =?utf-8?B?bXB0NENsZmJLUXVJaGpzZEF3dUxCTlRuUW4wQUtJODhFdnJ4QkZEZG52aUxn?=
 =?utf-8?B?Vm5MV0lvckZRYXlreUdHNXJsMm1lK0FSVGxBazgrSlBLYmZDSEg5bE5ZV0Nw?=
 =?utf-8?B?Yzk1TENiNjlzd2ZRczdINGgxeFlVUW85NjFoTlhiUnRGcjNIbTcwQXhUV3Z0?=
 =?utf-8?B?eEdCV2tDU0xNUjZpeEUvZm93YllDNzFtRmhCTFdRdVBkOW9acC9yN0Y5MmR3?=
 =?utf-8?B?aThlZFhTN2o4cGlva0RERGNMeExOZ040RjhHdzVxeUpadTRYSGxWT2F4U1gr?=
 =?utf-8?B?VVgzK2tiVVpjNDc0Y3o3WWFjdG1YUDEzeC95QkRlT3BRdTJLSnROVi8wdDN6?=
 =?utf-8?B?bERZb2RkaVFaYjVJWktBdGtTYWF0WnY2R0hxd0U2WUo4NzJmQ2VROUxMUmVI?=
 =?utf-8?B?YitkYnVmNkNIVEp1eUZqY3BKUFMyazlJbktTL043L1VsalFnakZwN0ZVUGNk?=
 =?utf-8?B?Y2FaTnF5eXlKTjBJRmlpcEluMmR0YUNOd2lNSjArLzd1UU41MzlaY1UwSHcz?=
 =?utf-8?B?b2ZNK1BvU3ZBdHFIYkhqRkp6QjEvWlkwR092YXlTVTZBeTF4QUgxTzZTM0JT?=
 =?utf-8?B?Sm8xMjVRT3hHKzJ4S2x5U2RrNTExRnZmQ0crdFFnSmxiVmNwajNqT05HdkdW?=
 =?utf-8?B?QzNkajMyZnZ3T0VUb2NDZEpVb3NYZE1CRHhocXpMU0FWS2hHbWRJODBFWjJu?=
 =?utf-8?B?UVkzZEhNQ2xIWkoxNHFWQlltb3pyWFFNT09YRUpJZ1RxcGNHVEVYVHpxY1Rj?=
 =?utf-8?B?dUVJNWYrdU14M255SHpLRityVmUvc3owK2VVQ1pVeTNQckgwOTZqeHZqM3pj?=
 =?utf-8?B?ekpYMXE0enBvZjBHWnJGV3FhSDFpS0RSR3pCaVlkVDFoOUtlOTN3QnQyWEJ4?=
 =?utf-8?B?M3k5UmUrTGJRdEhOWUtPUFFkVms5dUhpVjl3d21KTnZrVVFic3ZMdEhTaU12?=
 =?utf-8?Q?dorY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29waEM3ZmgwWlhwR200UllCOSsxVTc1NXZJbWZkVVRGejBOTmF4UUcrbS96?=
 =?utf-8?B?aG1OM2JXZ0dGQ0h3aXVtTzNlbmhoSGNzc3BtL2o3U0Z4ZkR1bWtGNU5pZklE?=
 =?utf-8?B?M0UrMWIvbFlFM2NmcGRud3JuVnN4cVh3TENiTUZVZVEyMTIzQng5T3o1QkN2?=
 =?utf-8?B?ays2ODVsemtMWFo4aTN3KzF2T1djS1VXb2ovT2hObzdUeWRnRENISE1yNWY2?=
 =?utf-8?B?V0hrUHVPLzRyUGt6NUswUG5jWU1TTkFXelhmOThSMGoxeGtJeFRZbkM0aGJP?=
 =?utf-8?B?KzZVdkx0VWc4cldubmcycmMyS0VjZjFiOFo5RG1Ha2RiSDA5b05LUlRtdEpT?=
 =?utf-8?B?VEY0Y25tdXBodTF0QXlDNG5DK1BzNWtNQnJnbU01SXpFcG51dzF6UUdIUWNP?=
 =?utf-8?B?ZFYzZlo5amVoSlgrc3RuK3lhS2Q0eG9jZGFBUVEvcjZBYlFmbTdVTzNxenhx?=
 =?utf-8?B?cS91WHBmRzVucG1DSUJsMmc1WGJORzEwd2d1WlhtVmU2ZzFwc3lPYSs2dExE?=
 =?utf-8?B?UUhzRExJOXNDSllJSEJzYzFpT3UvVUEzcEhhVmRla0dQOUVBMlB1OUN2LzJM?=
 =?utf-8?B?VWViOXA2ci9OZGhpUkxFT2s3S01tMUVGN3NWZGNBTEV4bmp2eXRudC9DZndu?=
 =?utf-8?B?bVA1RGd1RFBzSnNQalNTS3BUczJ4SFFVNng4ZUkrSytsWENSc2dkaHZEWVc4?=
 =?utf-8?B?c05tSFRicitnRnRlWWJKTStuU0lWREdUdmRVb09SdkIxTW0zSlZ6NGdHYS9Q?=
 =?utf-8?B?MGNaY3k0enorUFJqMVBPM1NQN2QyTEZ0NzEwUWs4Vy9LS2Y4WVNvT2tZNjlW?=
 =?utf-8?B?NjBmRDVkRUNzcVREbXR6TjdRc0l0RVF0Y2hldkUrWEdTQ1NrYmlDQ1lYYVNS?=
 =?utf-8?B?NEhoamxQTGlkT0wzSStTMHNGYjJZOEZNQXByVWlRcllFWmlEaGViMml3OW5k?=
 =?utf-8?B?Nkd1aXFGdVcwd0hrbitGVllHaW1sMnpuM3ppTFpkUnFGTkwyVHhaUnljOXB3?=
 =?utf-8?B?M0U3bzZQWFZKcEgzWGNGcGNFblp4ek1KK2RHZ0krQzU0OUF3NkdCVXBoSVRR?=
 =?utf-8?B?VlNPRzhHaUFKaXZmc2RVdW5BZmc3TGpZbUtPam9TTmlZNldoZnFVdnNCN21R?=
 =?utf-8?B?amRycHFXbm9ndGtGRXliZlkxSXdOV0JjT2N2bzV2bjRycHNOS1JqWk13Y2F4?=
 =?utf-8?B?eUk0dlRwelNoa2F2NE1VRVU3RnRhczFqZmZ4SC9FUlhVUnZmN1NIUzhWRytq?=
 =?utf-8?B?Mlc4aWtQTllvRXhkaGdzVG1kUGwxV2JXOVA2QXAwcE40UlNZVGFDSENUdW9k?=
 =?utf-8?B?M0NqckxmUWpqcTlvNFZYYk40cmVSQllBemJCZm5zQi9ENGpqOU1TVXpCSUx3?=
 =?utf-8?B?NGk4aFdWUldEVVhIRTRmNldjMkMrQnR5ZHFMUm9CcG8yMTdoZng1UTZjcFQz?=
 =?utf-8?B?NXRiSzAwL2hCYlhrYkFoT2l3MmdBOG1YeWVRZmRiUjJjT0dmd01DV2RsMUVU?=
 =?utf-8?B?VjZXS1hpZDZhZGVqOVN6MFpiY2o1d1BCTllUL2ZkZHdpQnVDMzlXbUJublU1?=
 =?utf-8?B?NDlYejVSSkJjZklwUmQxMGd0Sko5MnhtTld1bGVXZThRWXJTTFlhOE5OUXVN?=
 =?utf-8?B?YTlXa0lmb20wQjFNYUpia3ZnUndxcVFEQTUwYyt5SEVkZ2JkNVhScmRXTVgz?=
 =?utf-8?B?R0RUeDRJQkNtZFlaN0V4NjJVdWw0RENveFBXRnB6ZDJyU2NmS0g4RnZldCt0?=
 =?utf-8?B?Z3RMaXN1bzVCQkZQZWloMEIySEt4YTJoZllnczJoeFlDNmZVWHZwTXNjQ1lq?=
 =?utf-8?B?Tk5IWHZFbGYyNzg4aFdxbzVvMzNkcDFxQzZvclhTb0Q5ZEZNRWw3aGlIblpK?=
 =?utf-8?B?VnFpcnlJS0hJSVQ0YlpuSUVFZEprWFFGM3lEWUZ6TEVaMldLU1RCSURSMDVv?=
 =?utf-8?B?dnVsQ0FpMU9XQ3hjMy9EZlVEZlRVWEZwOUpjcTdPdXN0SWhTSG9vN3ZTRDVN?=
 =?utf-8?B?bitoU25XUXRjZXNOdVVucUEyK1YzMEJTMGx2SzUxandOM1lwNmhhSm1zbE5s?=
 =?utf-8?B?eVNEZnhqNk9OdFVUbkw2T1R2Y0pYWG5nZzE2cWIwdkxQVVZsS0ljZE83SFdu?=
 =?utf-8?B?eXNRekNvQ01WTlJ5QWVuWHJHa2g2VVE4c21EOGE4VzVJTDI1T0tVV0VFL2cy?=
 =?utf-8?B?RFdkb0NTdkdsaGxFS2xtOVNpUHdweTFWaXBHbERWUjdMZFdvNytvbGl6UjU2?=
 =?utf-8?B?dURzNCt2UlE3bHhPaUtldExBZ0s2UWJwbytQN1JZcVExQkdLMEVPTXhhSDBZ?=
 =?utf-8?B?WG9uMUJIWnRlWEVwdnhRbXRQUGVRakVPTnRFaFZCNEZPcTRWZmJPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45de50d8-0e7b-4324-55d3-08de6d3026ae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 07:51:10.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUjQSvs0u9l1Am8ksPbwWlySvYO+523r4BWEqkYNgIHZ/bxnPlMoHDiPIWgvUD5m/3NHe/QQeexkhCjc3cQbztTR/dhFQzWayttyS9xis+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9276



On 2/13/26 17:57, Jan Kiszka wrote:
> On 13.02.26 10:35, Clara Kowalsky wrote:
>> The libevl next branch triggers a pipeline in xenomai-images in
>> combination with all available kernels (6.1, 6.12 and head). The
>> physical targets are built for all kernels, the QEMU targets just for
>> the head.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   ci/trigger/libevl.yml | 2 +-
>>   ci/xenomai_4_evl.yml  | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
>> index bbd4e13..f9228dd 100644
>> --- a/ci/trigger/libevl.yml
>> +++ b/ci/trigger/libevl.yml
>> @@ -19,8 +19,8 @@ trigger-xenomai-images:
>>     stage: trigger_xenomai_images
>>     variables:
>>       ONLY_RUN: xenomai-4/evl
> 
> Why not simply triggering xenomai-4/next? That would be in line with
> https://gitlab.com/Xenomai/xenomai3/xenomai/-/blob/master/.gitlab-ci.yml?ref_type=heads#L272
> 
> Jan

Ok, but then xenomai-4/next needs to include /ci/lib/kernel/head.yml as 
well. I'll send a v2.
Clara

> 
>> -    KERNEL_VERSION: head
>>       KERNEL_VERSION_WITH_QEMU: head
>> +    KERNEL_ALL: "true"
>>     trigger:
>>       project: xenomai/xenomai-images
>>       branch: next
>> diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
>> index 0404ca3..abc1e56 100644
>> --- a/ci/xenomai_4_evl.yml
>> +++ b/ci/xenomai_4_evl.yml
>> @@ -13,13 +13,13 @@ include:
>>     - local: '/ci/lib/gitlab-ci-base.yml'
>>     - local: '/ci/lib/kernel/6_1.yml'
>>       rules:
>> -      - if: '$KERNEL_VERSION == "6.1"'
>> +      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_ALL == "true"'
>>     - local: '/ci/lib/kernel/6_12.yml'
>>       rules:
>> -      - if: '$KERNEL_VERSION == "6.12"'
>> +      - if: '$KERNEL_VERSION == "6.12" || $KERNEL_ALL == "true"'
>>     - local: '/ci/lib/kernel/head.yml'
>>       rules:
>> -      - if: '$KERNEL_VERSION == "head"'
>> +      - if: '$KERNEL_VERSION == "head" || $KERNEL_ALL == "true"'
>>   
>>   variables:
>>     XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
> 

