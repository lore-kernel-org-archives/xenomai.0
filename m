Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AB14A091
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330301; cv=fail; b=TdT8gnpwY3OQ9K4WfnBys6uba1bjKcJfR2HfcM1uZY+3Jj25lvLf0MAB17lve43oxqm3bLygcOfrnx9lG+JQbShlKdlRCkU3yeC7w7GDUOZcnoTKtRPs0UsowaZzAg92xtQzKyKmqOA4Mn8zAJceMWetO6Tuh+gCo3/rQFq1RL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330301; c=relaxed/simple;
	bh=flyA4wcD9o4IHQgMyj6TwOM0mhy6Nxl08jsREG8JDkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jm6OQ3opeay69RFNrSx1Ac1tYzDbVneH6WQNmy2NY9L/fkLOptnM60ZcKpaUmCR5nDR790AK8TKq9UcirhroIGU64XJZ7Z3enHXYlz5DqX/ZV1ksmeCJNpbxMPb+kisNwwx4Cp7MiIQd7q4EGFf0GpPMJD6du1SDrJrHNKWijCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DSz0pVp7; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DSz0pVp7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvQpxiAJb0MiD9b5aDYgQLDtTxekl1wmVT/o84D7Brcxnr4sNerhGdLZLzr4HQv2cxMTDqMdFO3r4hao8xCuXV+g0WTUBuC7GMXv9W+W+Qhe6AjP0YjRiLLFeBFxRos0Cmr2+RYqy7UONDYEMo7vIiyzhUg0rA07TXHk2mcANc5tL+cZyD6CBQzRq/P9pbOSYQiIeRYJHdiEFqRAnn7pYYLj5glyu7VTO5SWCueN62e5HzDW01SgYZRhNXBkJUeSjoZTKtAfJe3ni8PRA46HYJvKSl/NU/aN8MTcEpykGLAYr2DW/zn0YCqGQpPZqJhKsglhggh+IoiToX2ucXwmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Ao6k4r9FIPL78gEJO4Hbntd5B59SkA06dQ869DBuU=;
 b=mPD/VGH1sjEqbUYuw9Az6ySaCZ6BuNHtRpeznDvfHQK4GbF85nEnczVSTqswgMt8nXWYAR4ORsByAguPuboNEErW+FmuvwBwRfQ3Y2H33pI4tEC63U7D7kd93y7yyes2/w6r91o83GyqxW37kSeQPn8hm3aCR6q7CLNrZfypDSSwFsSEw8DCSMknyVPfR8Q1E+r8oMksZ3xAvbjV7bfC9iA2jR9gzDO6T6i+5SLphoC9g/YotxEuRBUAl1IvRCP/Fv48XehLSKB7E4nEMtYIrUGFiDVZJiEWug03lVDcWpnLll/uVzPcQACr8TH4EZB8zQA5XgRQwllVddiGOsSoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Ao6k4r9FIPL78gEJO4Hbntd5B59SkA06dQ869DBuU=;
 b=DSz0pVp7htD8J71RTUNpnBot5iu1NZYJ2YQdStTINODMMIfl+9eVC6aBjbTFVHkwFIHEcDzeLeCYqtsUs9wJwfUtdfSdXKGzdbsZfBixX6ea9u5mwTyA93Hht1HpHusLSddfJ7VoyxmkRsO8E3VZ24In3+jzhVow2IeixRXyxnB1i+xAWsWwAKZ34TT8LK8UZdZ0yr++g9k+K16cxVlQwrca6YuwJTx6COxhZvRDqKSKlvvKxK1RRWX6ZZK2eNMK0SMy1RU+OFnf12R+yXdnCsR3KlBBIicsBblxeF0LJajd6h4CjsOijriJ1yiQ+N8ykHe0FDsrk7Ss5Cdg+8LbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 15:44:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:44:52 +0000
Message-ID: <393ed939-97f8-4f53-a719-6f6723e50d97@siemens.com>
Date: Tue, 25 Jun 2024 17:44:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240624203341.6263-1-richard@nod.at>
 <20240624203341.6263-3-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240624203341.6263-3-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:610:b1::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b27584-1b90-4a63-38ec-08dc952dc13a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MElUeUNMZmkrOHZtS3BUSGNmN2tPT2dvM1RxeGF1dldoTWN3ci9ieGs3ejBD?=
 =?utf-8?B?YVljOWs3ajVJeStYZnVoZGlrcG1naHlwNzVPRFFHUm8rdVN0WmgycU9FbUky?=
 =?utf-8?B?NGZYbEs5NEFsZkJOOW45YzdlYmUvczZnYkJrZXI3VzZRSU11MWtLSUdwbUl0?=
 =?utf-8?B?MUp1QjllTW56OFgwUlBFZStmQ29qcjhNTmVFRzZDT0VleDNoaE90amNpR214?=
 =?utf-8?B?aDZlcGt2WmdtYkt2M2Q3SnBhMEIwUUdhOUpJaU1ETytnaXY2RnR4WVFnSWhK?=
 =?utf-8?B?NVZTZXRVZ1JQa211VmZCb3lsY2NicGpiSEtKSDlHMkNjLy8wLzViWWRlWDJu?=
 =?utf-8?B?UndTY1JTbEhTM3pVM2syakZYY296d3JVYlVJbG5TUXdIL2xaWVo3ZXFZeHBv?=
 =?utf-8?B?RXgzaUpZbFFGK2NObThOaVphM2RmQUhIVVMyaHdqdHpiOUloY3o4Ymk1OHFy?=
 =?utf-8?B?VWNLR2pONUdFRzdaa3drZ1l2cDdUN20xNEpiM1dYQmo0RG04SERoS0hwVndB?=
 =?utf-8?B?Zm9XcmpWVmJEY0ROQWZ5WmgzT29XdkZpMmVoY3Jlb3JiTVpjSCtsVWZDWTl3?=
 =?utf-8?B?RTFjMmRDV3JISGRmQlJIT3UyN01WSU1HYUE4YXZUNVV0dzlIcW4wakhsYmZZ?=
 =?utf-8?B?YldZTFprcE5uc3VIMnFrNURHOWtjR2hXRmJsSFZqWUorRHdNTTBJaUlkNGd1?=
 =?utf-8?B?SGNVTC8rbVpnSHh6cnJRUjVmbjNDbGNSdDg2NFd2OS9YSjYvMVB3NTJZMDJJ?=
 =?utf-8?B?K1c2YXVaZ2M4eWNtMDMwaEx1OHVETUliMVgycHlLUEd2UXQxR1E4MlF3eWFi?=
 =?utf-8?B?cTFOSk9wNm9vd2oxL2ZIRkpzbHZWSlBaZnRQa2xIV0RPb3IvOVJ5UlE3b2g3?=
 =?utf-8?B?UnNkNTdLdmdzRlpjMDA0SG5PU1lxTVFPZXRZcFBBei9RU2o3TEFRUlRmQkQr?=
 =?utf-8?B?eW05UnQreEE3dEowejZ0WUR0L3FJNGlZOEhQUEhwaTVpVlUxRUF6UTZFOVN3?=
 =?utf-8?B?M3JHRXdIWE4wbTIvK3BoWGVRWk5ZM0UxOXY2eXNMTndBamlHVmZyS1l6L1I3?=
 =?utf-8?B?YzQyOUdpK1BxSFFHRmVEdldHOFUxR3IrZ0xvd0lCaTM1VnF0QnlRYkQxU0lr?=
 =?utf-8?B?RFpXbVFoTnc4K3h5QTRFZlJIay9meW05ZXJoTm13U3lGNCtFWjRiV2Zxdm15?=
 =?utf-8?B?ZVB0eUlvS0xDV01UdTV5Y0NDS3ExZTN2c1VyenJWYkhidi9BemJEM2R0Y3gv?=
 =?utf-8?B?blR0V2FTNWxxcTljY1RYYUdUL3ZCaTRYSlhDV0pwZ1ZPZ0NFbjNDajBVTkhp?=
 =?utf-8?B?azNqZU5Zd3pySnoyWjQvd2Y0RkE3YTMyVjYweEVMSWhxcXUyK2JXcW02RGZL?=
 =?utf-8?B?N25xUndFbUNiWG5MOWdVQ3c2U2VxbCtPNmFLODJ0TVJWQ1FrbG9QZ2x5ZVB0?=
 =?utf-8?B?Vml6c1hOYXViZUFhbGttY0RMRmJhczVVNlcreXBJUzRndURuRUVZKzNpK1pU?=
 =?utf-8?B?MWFyT2cwY3FSUGxmT015azhsd2R0Z2ltVVpDeDVKdldCM0h5VGsyRllYdEZK?=
 =?utf-8?B?OG5tL2hNUDM0UU5Yak1SYUt5aE1OaWtkMi9PZlEzN2Z6MElwME1JM3kxcjVG?=
 =?utf-8?B?eWNOTDl1Z0dNWEUzaXNQZHVCUTVQUDh4SjlINnBITkpjc25wTXp0M1lOZmNB?=
 =?utf-8?B?U2s5REdRL242VmNXOWZZdi9mWk1oSDd6YnY3WUdQdmYwR2MzMi9PQ1BmaUhY?=
 =?utf-8?B?T2NHaHRYTXJ2UWFlRERVNmRHNTM4RHROejVLWUdYRWlaQ0RhRWdBVU9CU0Q3?=
 =?utf-8?B?T2RCLy9TSEM5Y2pldmlsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFhYLzlWanZKMFF6dk5ZQjZEa3p6ZDhTZVhEMVVrU005NWpGa3N1T1ppSVNB?=
 =?utf-8?B?YzIxcjVONlRhTm1mUTF2cjdnb1RMVmE1ZGNBVzBCbk1FSGFKNHYzblpvbEtX?=
 =?utf-8?B?SWNReVdVK1QxaFYwRldaUFFhYk85Q2JHeHNwcm0zRnIzVngxK01UdjB1VVRz?=
 =?utf-8?B?dlRtb3FLTVA5Y3pDMWFsRnJhSnFSZ0dlZUI5ZFRiK0JZZmhwWThSWUg3VGZQ?=
 =?utf-8?B?NmRPTTlObzJaZ29UREFXeGRXdnBPcitJTGtvUml3RFpzTU5YNDhMNDRESmcz?=
 =?utf-8?B?NEh6eUxkemRjQUdrVU5zWXBLb0J3MGJnWkQ3OE8xcFp3dHc5eHkrV3JSZmts?=
 =?utf-8?B?ODgyK2loZGtPRzNpb2Fqemg2VHdzZyt4Sm5DZE1scHdKQ21aQi9ZS1lRZm44?=
 =?utf-8?B?NWcrM0JhVWtkNW1ZR2o2T1pKQTgxdG9QSlpWY1EvUWdUODA4OWh4SkhPUDVH?=
 =?utf-8?B?YVBDdDI2dy9KNFpoNTJ5bkI4YWFDSGJoN3RpZnAwRU41UGpOTVZLWHFXcDZp?=
 =?utf-8?B?OTY1bW5Md3dLUjVIdDI3dm9yTjFsN3ZCUHBOWnl1aGhuOHA5M0RSWkNKbUFy?=
 =?utf-8?B?d0tKRnh6bVdPcHRCV1YrUkxFRHZrTzlFT290aTJ6eVZjNDYxQmJPemQzbi9h?=
 =?utf-8?B?blVXREY4c2xIQW1DbXlhWERUbU9JK0NzbXZTYkR5MWh0MGJFTUJRNmVaVnlW?=
 =?utf-8?B?VERoQXY1TjFKZEFYR095bGFFK0h4RDVWdC9EVkpTaTRvalFUTzJuOWZnZndk?=
 =?utf-8?B?SzZiUEFsNk1STVlrazBjOVlzdGJzd3NFZDZyYTA3N3Y3eGNMaEFKSllkeVlz?=
 =?utf-8?B?NGRkUm1pSEFqYjMydlhGVCtISmRrWFF5ZU1xd3VneFQ3a1RNVFhrVlQzU0J6?=
 =?utf-8?B?RGo1MkZ4NmlpQjNDZDY4QjlPN3dpNmRSak1WbzhqMmdZd2JZWWhnL1hHd1Jt?=
 =?utf-8?B?a1dGU0FRQ0R6NFZZd2JzWG9wNWJXMFhuM0VFSHZJUDdOUXY5VnBzclNoZCtF?=
 =?utf-8?B?bUhkZzU4MDQ4UTVYaWhFU3IwVHZmRUZ4NzFsMmV0TVVYaHArWEdoUk9TdXJJ?=
 =?utf-8?B?Y0t0Sk1VYzQvSW1aVk5IU0QvU1lsWEpJdEFyWEFTUk5RVkxZdDdqYkR2Y0la?=
 =?utf-8?B?azlTVnpZUjY1UFZSU0R2dXA3M1NOd0tGS1FMWG1neG5HUmZsQnFIakN2ZGV2?=
 =?utf-8?B?R1YxU2VjQlNLY2ZPNTRWbTBuTnczNTFjL2NaK1VBOFJMOFd3cTFFM0pqbUdV?=
 =?utf-8?B?czVUUU1CczVqSEdaYjdCTXpvSDZ6d0ZMRTdDSDFKVTBDZDZwY1V4L3BTdFpU?=
 =?utf-8?B?RlRJTHpqNGhuM29hdW1sUkMrTVRORnN2dzhRcHRaVERwdVRJcDFoZDEvU3lv?=
 =?utf-8?B?K1dQU3lDY0JWemEzMjJqNDVISUUxY1BEWm1lTmR5cGxpZHZDaWtLN2RTV04z?=
 =?utf-8?B?VXVHTlBNa0xtVWgzWnRTMEk3eVdvQ2VVRGVwc2Q3MU1OYmN0TFFpUXg4d0kz?=
 =?utf-8?B?cWY4M2RtQnk1a0c1RVp1a1d6TzY2N01abEJhTXFPWFlxZVRrYUpkV2JzbkhE?=
 =?utf-8?B?cEdNMnU0UWhaVnhZM1NJUFFPUzczcFhaQUVXeFVuc0xEdm5GT05KV2dwYWdy?=
 =?utf-8?B?bWRvTHpPQU5ycjFialFpTWRhSlU5aUpNRFFTek04Rmpxd1lxMWFDV0V2RGxT?=
 =?utf-8?B?d3MrdS9JTi9kZytOU2RuWUFCc1R3QUJSVzFyM01QTDVwSTdZbFZqWjFRNzdr?=
 =?utf-8?B?RHU2KzZzNUs3YlBOQXJJV25KdlkwRmZ3Z05saDdTazZpeGxLQXdxMGZKRFgy?=
 =?utf-8?B?SDFKeHNDZkk4Y2NaUXUyU1lvN2lkZ3Z1bUd4Y0VOYjNwWUdSMWFlY3lRQ25w?=
 =?utf-8?B?THdoK1RXSC83c2Y4c2lQOFN6cjFUc3VSZGlMRHl4NndhUFc4RjF1Qk1hT2tm?=
 =?utf-8?B?TGl4cEZocStBSmFnWTlwTmNjQTBqTWVkWENVQmV6K0ZqRTRpY05yaURuZW5w?=
 =?utf-8?B?Q2xQK0pRdm1XR2hDK2YzSVN0clBPR1hyQ29nREZZUS9RbnZLdGJaUWVSdkpE?=
 =?utf-8?B?VmZGeGsrWkFZbWVBZGk3eTJKYWthc25CWWQzR3RMRTZ2M0pOampPZkg0ZWg0?=
 =?utf-8?B?TUdVeW1hRFRmRjNXVVNISEZMNmVxNWZLK0F5SDlVNzZRZXB0b1NNckI1dCtH?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b27584-1b90-4a63-38ec-08dc952dc13a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:44:52.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH4GBZdnloF9tN6Y1pX01pW41ZfoRbSos+Xu+2k9bOwajdNmBuQjjAP2tV7pchWxrj12LsbKzX8YjbB5Cyb18w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6902

On 24.06.24 22:33, Richard Weinberger wrote:
> There is currently no way to undo preparing of a kernel, except using
> --outpatch and reverting the resulting patch later.
> But in link mode the kernel tree needs manual cleaning,
> which can be tedious if a git clean -f -d -x is not possible.
> 
> The new --reverse flag offers this feature, it removes all previously
> created symlinks and directories.
> To be able to undo effects by patch_append(), keep a .orig file link
> as the script already does for symlinks in the linux tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 71 +++++++++++++++++++++++++++++++--------
>  1 file changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 9299aaa97..f294ef0fa 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -55,6 +55,8 @@ patch_append() {
>  		if test -L "$linux_tree/$file" ; then
>  			mv "$linux_tree/$file" "$linux_tree/$file.orig"
>  			cp "$linux_tree/$file.orig" "$linux_tree/$file"
> +		else
> +			cp "$linux_tree/$file" "$linux_tree/$file.orig"
>  		fi
>  		chmod +w "$linux_tree/$file"
>  		cat >> "$linux_tree/$file"
> @@ -66,6 +68,16 @@ patch_append() {
>  	fi
>  }
>  
> +patch_reverse() {
> +	file="$1"
> +	if test "x$output_patch" = "x"; then
> +		if test -L "$linux_tree/$file" ; then
> +			rm "$linux_tree/$file"
> +		fi
> +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> +	fi
> +}
> +
>  patch_link() {
>  	recursive="$1"		   # "r" or "n"
>  	link_file="$2"		   # "m", "n" or some file (basename) from $target_dir
> @@ -104,11 +116,15 @@ patch_link() {
>  		f=`echo $f | cut -d/ -f2-`
>  		d=`dirname $f`
>  		if test "x$output_patch" = "x"; then
> -			mkdir -p $linux_tree/$link_dir/$d
> -			if test x$forcelink = x1 -o \
> -				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -			then
> -				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +			if test x$reverse = x1; then
> +				rm -f $linux_tree/$link_dir/$f
> +			else
> +				mkdir -p $linux_tree/$link_dir/$d
> +				if test x$forcelink = x1 -o \
> +					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> +				then
> +					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +				fi
>  			fi
>  		else
>  			if test `check_filter $link_dir/$f` = "ok"; then
> @@ -120,6 +136,11 @@ patch_link() {
>  			fi
>  		fi
>  	done
> +	if test x$reverse = x1; then
> +		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
> +			rm -rf $linux_tree/$link_dir
> +		fi
> +	fi
>  	)
>  }
>  
> @@ -135,8 +156,7 @@ generate_patch() {
>  	)
>  }
>  
> -
> -usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
> +usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose] [--reverse]'
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> @@ -172,6 +192,9 @@ while test $# -gt 0; do
>  	--verbose)
>  		verbose=1
>  	;;
> +	--reverse)
> +		reverse=1
> +	;;
>  	--help)
>  		echo "$usage"
>  		exit 0
> @@ -221,6 +244,13 @@ if test \! -r $linux_tree/Makefile; then
>  	exit 2
>  fi
>  
> +if test x$reverse = x1; then
> +	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> +		echo "$me: $linux_tree is not prepared with Xenomai" >&2
> +		exit 2
> +	fi
> +fi
> +
>  # Create an empty output patch file, and initialize the temporary tree.
>  if test "x$output_patch" != "x"; then
>  	temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> @@ -229,6 +259,11 @@ if test "x$output_patch" != "x"; then
>  		exit 1
>  	fi
>  
> +	if test x$reverse = x1; then
> +		echo "$me: --reverse and --outpatch are not compatible"
> +		exit 1
> +	fi
> +
>  	patchdir=`dirname $output_patch`
>  	patchdir=`cd $patchdir && pwd`
>  	output_patch=$patchdir/`basename $output_patch`
> @@ -364,10 +399,11 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -		p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -		p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> -		echo $p | patch_append arch/$linux_arch/Makefile
> +		p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +		p2="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> +		(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse arch/$linux_arch/Makefile
>  	fi
>  
>  	patch_architecture_specific="n"
> @@ -375,11 +411,15 @@ test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append drivers/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse drivers/Makefile
>  	fi
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append kernel/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse kernel/Makefile
>  	fi
>  	;;
>  esac
> @@ -387,13 +427,15 @@ esac
>  # Create local directories then symlink to the source files from
>  # there, so that we don't pollute the Xenomai source tree with
>  # compilation files.
> +#
> +# Keep link dirs (4th parameter) descending, otherwise --reverse
> +# is not able to cleanup these directories!
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
>  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
>  patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
>  patch_architecture_specific="n"
> -patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
> @@ -401,14 +443,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
>  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
>  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
>  patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
> +patch_link n m kernel/cobalt kernel/xenomai
>  patch_link r m kernel/drivers drivers/xenomai
>  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
> -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/pipeline
>  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
>  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> -patch_link n version.h include/xenomai include/xenomai
> +patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
> +patch_link n version.h include/xenomai include/xenomai
>  
>  if test "x$output_patch" != "x"; then
>  	if test x$verbose = x1; then

The reverse mode is missing coverage for init/Kconfig. Only patch 14
introduces it. Fixing up while merging.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

