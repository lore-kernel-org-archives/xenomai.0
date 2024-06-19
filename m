Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87E1422A2
	for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810941; cv=fail; b=heKHxkC8mkc9QLas1YqQTXKcdCdm0vPef2iZO/82+5I7uGJ7TJWGgYO9cEebe6im1IOqTa/OGdrjB4gYD05OzD39OrlHLGD4SvcRMQYxp/BsWp6hNuqNon+qb0nKv6GqeJ6FNKJQ00L7ZW/XTiwQonoI5gkui4CYjWdMU+agFwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810941; c=relaxed/simple;
	bh=KRLx/hHA387qojdy9meIIr3+7x3iF0xL3iNx5nxaAYw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCPqT65J9eFT+dhVLgjvYk50ZtHn2IBobIPwE8gUfAfY2znxtPdojETu/M9nMmb2JTR4ach0xPHcfsQIyyj4n/WL87UBnLC52iDN/B7kRg8S7YwxmUj07/6UCqn+aS0vYY7TqJmzixvngHm4NSmgwEwuN8uQH4mJJUL280bD+TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MVCIcAu/; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MVCIcAu/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoopkhFRUrLSeeN+cT2IuF9B1jcePa0DYxDWxpW7lizeZXDWAXBLnW8MND/tMBTExdiO+8kOkA/0/MfmRcFnHqHNGKH9FQr1vbe+vaLuw/C2pGYlyPOTT2pR0UK6g1jJL+0NnW6f4iEd3GDFJojVd1+fPsXXAObzgFzidqGCvfkEAKpxtctgBIfj6FBTCG1sve4hsSrP0bKeH78hj7Y4y7PTtQ10dbP5ghaFPRshwmFmhMxsQFh48f1P1/9nSYC/BwFjee8ric+B/6dbycPHBkh4Ge2iRlEsNhBh2IyzK1wLGMMu7Z0vVlWFBQsTxag17YelylYo1yqi9u31C3QTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2IJB0kQxZAXkGaedp7xI5uoeaPTQi4r2ZJzTLBoiro=;
 b=i1nPlhcg5a+7aYr95fcoLE4BYAHW1ci6rlc1ju8BW0Jj/5rIwWpVGkBdJ+TLnv8IaM84oOTbxNnWFIMvpAeS2E307Kbd5nSZUjEoB6dWkeolo/CGG0p+b8P0PdsbZlSZFF4MoJzy37w8ym6KxR0b9stCp+DTQp0r2cix1i/N39x61YN64/fU2POPMFIJURvAXmQRlRapGFrAnF/jGtMRWQzxWA7SS0gXhZSncBdz/K4heCBrM0IS3jQaAa6B8b0pie4xDesjHNUJTQE0D3dXEu0jJ6lnxcQlvs1ddVYhaOladCM6oyyAoqzm7rKlplq7X9NYo0+7cZLyJzKdYmvZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2IJB0kQxZAXkGaedp7xI5uoeaPTQi4r2ZJzTLBoiro=;
 b=MVCIcAu/ymweJ17/2hEoky0elIIObpt6umwFQt4TyLOUfUOni9UXKR5MMHiErDI0iN5MbiGbS0vc8URPavpyXIgavjW2SRSVgYizDUd6dR39AnArnV2/oENbYHPm3qZGq76smnKs9SUSer2bplAUSUrXGfZFHooGyeC5M67bZ9Tb7+Ysmg4ar2FuQko93HhybqvEjUoDuKkH5WZ7ktk0Y8tCZvMEC3w1NNG3SbPxZ7S4X3t4Zo+0/SrAFrkraPJu7IUQRvrm3CtHruF7G3M4HZ+80MJo7Nik4DufJgSVo8N7UYP7RLBVOlUHSORLBIAMN3y22HOF2YQDLCYc/gfOFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:28:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 15:28:53 +0000
Message-ID: <faf3ef95-f6f3-45b8-ac26-d3d8dd2167a4@siemens.com>
Date: Wed, 19 Jun 2024 17:28:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: EVL kernel config on x86 only for 64bits ?
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <ce3d9b5c-f9f8-412d-86dd-2d3579043359@siemens.com>
 <87bk3xrneq.fsf@xenomai.org>
 <AM6PR05MB60245777DA0C3A6A57EEC44EADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM6PR05MB60245777DA0C3A6A57EEC44EADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b15f35-a073-4176-c762-08dc907486e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm81VnlCQjVhanZOcWZZSnR2MW9RYVNHdzBrMkRCNUtwbmtNQ05odDJqYk1N?=
 =?utf-8?B?a09JalkwWDl6cHFtQ0ZSdUZzWmlpbjdZcmhjQjc3SmQ2ekhudXAwd0l6Y2Ev?=
 =?utf-8?B?ZkJabHA3Zm15T0NoM3I1MkV6eHh4MWJKSjJuWHNjU0JaK2laVTh0YmdRZ3cx?=
 =?utf-8?B?TTNjMmdpaWpLa0pycnhBK1daQ2ZVWFRMcjlwV09rSWxaY29uSXVGdDJ2UUcz?=
 =?utf-8?B?bVVFT1hGWXgzdWVEaUdwQmgzaXkzWURFaDhIN1NTUDcvVnJZdlpiMmcwMHhh?=
 =?utf-8?B?Vk5STUdCeVRiSHNIVmVOVGwrRjVybTRGcVdvVW9oQjkyelVoQTE3THFzOTVs?=
 =?utf-8?B?bHpvOTFjSnhsTkM4cDRwN3E4KzRPbDAwQnJ5MTVRTXh4OGN5R21uVWN0RjBz?=
 =?utf-8?B?ck9oMldpU0pldlRYQy9QUFZSUHhVZWxaSG5DaFQ2TGVGbnY2ODRCWnlaTWRZ?=
 =?utf-8?B?VlMvSXZGSjdJV1ZXa1ZkYlNTcUtnTnR1NFhaMXVzMXBCUDhIckpHcE90SFJD?=
 =?utf-8?B?MXVIaEFHajhKL2w5VERCUmlWNEQ5dTFXenRJSjFEOE14aDYzYkFIWmVuL0FI?=
 =?utf-8?B?Qjlta3NaUVdrb3ZhMUdSckJDeklNTWI1VHVZSGNsSTRhV2h6V2tYcVRKRmt1?=
 =?utf-8?B?ZHlvaElKOW9wU1h0TmlWa0ZQMXRxdU9hUDFqdWFrMGF2K1pROUNPUUJCMTBs?=
 =?utf-8?B?MkFhc3FzZHhrNUFLeGdyYTBVRUxFQWJURzNocGY5SWNRYlpEZ1ZuOHZSL3Nz?=
 =?utf-8?B?UDYyYzQvSFlKVlh6U2FsQXlUYzR5bExZeGErNnNhZTBoM0ttbXpiaG1KZkdp?=
 =?utf-8?B?VHBwWThQRHh6aVpRL1BMTjFkOG9ZSmFMNkRXcHpUaDY3bWFwMXpuMER4TlJ0?=
 =?utf-8?B?alVLV2FOdm1yY0djZUlmeVczRkJFWTl3ZDlteDI2UUhvamhsWFFxNUdxOUk1?=
 =?utf-8?B?bTA2ckwxMkg0RXJzVUtSU3R2WGhkVS8zUU80ZnZkbnVPYWhrK0ZJKytSL1Mv?=
 =?utf-8?B?WHF2aW56a0FjM25ud0lGVnhhMDJTaERNZG1jQ3FhR1RjQVlwUUNOaTF0Z3pU?=
 =?utf-8?B?VCs3a2NWaEpuY3hDbHJWYVRlcWMrMk4zYURMQVZIRnpxVHpaT0YvS09pR2kv?=
 =?utf-8?B?UVlUUXJsaWlBUWZvVHcyZU5Yb3FhYnJKME5sR0xQOTNoWDdkOWVsK1hNRUlN?=
 =?utf-8?B?WFVQb2hLeGsza2dTNTN1REM5UXZIREtpRUYxRFVobGpvUjdPMDBXNmJQL2w2?=
 =?utf-8?B?eXlXMGVKQzkrZ29abHZFME5PQUhXdnNXeWJXb2czc09XYVJtLy9JK0p5UDgv?=
 =?utf-8?B?TlNyZ2NIYVZMSXhyYm9naGpXdWpHc0NoOGpwRnJCWENxaGh6VmhJaVA5SC9K?=
 =?utf-8?B?T3N1bCtmVnk1SWJKR3dPVkwwZFgzRDZoRW9MTFhDYy9aTk5UUmFZdXlqOUEw?=
 =?utf-8?B?QXNaYS9UbDFnTGp0SHZHREZGTm93bFlWWFFxMVFoQnFxbFJPNzcvUWV0TlJ5?=
 =?utf-8?B?S0lyZ1pjVTU5UjBHSm1FdG1naHdlUTFwRlFJZU9VU1ZNN2oxb1hzbDVsUUcv?=
 =?utf-8?B?SWtaSHFYWXJONFhUY0liTU1yc1pBN3c5a1hsc2N3OEtsTVZEM0NES0Z4RDcx?=
 =?utf-8?B?d3poSTIrZFlaQ1FQdjM4RDZacFoxelAveVlyOEdLNnV0TmFRTkJpSzI3clJk?=
 =?utf-8?Q?G8oeRslI65V3jwYuysh9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNVdVFJcEhSb3A1ZkdtQnFOOWlHbWFETlkrajA2ZUZYNUM5eG5paFJ5MlVW?=
 =?utf-8?B?RWdabExMZkFsWisycm1KbXJsZWM4VFBoWkRqNkUrTzJ1bnhQWjRaSkFuYlpK?=
 =?utf-8?B?bFk3amdxNjlLY2NyRFFPQ3dvUVJXbDRFTDZZMDhRc3oxSlJwNVYyVm0zbWJO?=
 =?utf-8?B?RkJZZ1paU1R2Mmo3Ri8zcnlOcGNRR0dqUkZWTVZIWVdyQVNDSFNJdXlERWxy?=
 =?utf-8?B?SEtSLzRpcUhvODBpNWV0Um4zTkhBb285SjFOTy96MzMyZmV3SEYrVmpEcG45?=
 =?utf-8?B?VVIrdUZXU1lHNHgzMVVkSENWS2V4bnE0ejF6bnR2Tkd6UUo4SlRWU3lhamNF?=
 =?utf-8?B?WjJjMHpsa3k0UzlqTlcwa25heU9yT0NKMlViZzF2WnR3L0dOSlBhTGViTnhh?=
 =?utf-8?B?Y00xMCs2UWYzNVRvSnF1Q2JjZUpsTjNwQTYwU1RkbG1SWW9Zd0Y2ZGNSVmhJ?=
 =?utf-8?B?bzFSWVVDRjA2Z3R0UFJyUktLMUhMVUl3MWxaMzE0SVZKZFhDMWdSRnNCSWll?=
 =?utf-8?B?RkVnd1pmQk1HY0xjTUI2YzRvNXlDN3hSejhBOEJDMzg5c3hVRVVteDBUbW1z?=
 =?utf-8?B?TjZWVjJZNkNCK2lYZjdQRWh2cFB5MjhLc2JOUmhrUUtGSzZCVjA5TEdmd0dV?=
 =?utf-8?B?SDRHT3N0bkxBRENTZ1dHanU0SmZsK3FhalVHeVZRMEtCNzR6QVVZdDM0L2N2?=
 =?utf-8?B?enlyelhLY08xTzRaQVMyMHVoR3o1M0x1RmRoT3ZNbCtTcGt2WkErY2ExQkIz?=
 =?utf-8?B?M3NWME4rQXR2eko5V2syM053bStMbUxMd0w1T051WFRhbjFvWVlTSktBVC9z?=
 =?utf-8?B?RS9BY3pnWVlvOEtha2c1U3RhenFWRzRzdVl3amN4UmRaSHNweTkvUGxVSVlG?=
 =?utf-8?B?UElKamJZTmFPSUE1a0U1TnI3UHdrOG9ReURlM3hvZ2tCZlFCOVh0b1RuWFJR?=
 =?utf-8?B?RnBmY3RjeHB6YmJIQ0pKZ05nS1NIMGpPdTNQY2E3L2Jma24vK3d4TW8rL1RK?=
 =?utf-8?B?a21uWUNGSmI0K3ZDMERqRTNhQ0x6eEJLTUMwbXlSVXBFWGVhZWwybXFRQUxE?=
 =?utf-8?B?cWhlSUxDdVBsQkk0dTR6eGg0SmhXNjJqZDc2dm1YQnFVTHgwZ3dqNHdqb0Er?=
 =?utf-8?B?VGphRTNsYXFyS0djL0tXL1lMbFoxTmwyUTFTSFF5Z3ZYVVZSU0gwOHpyWDZs?=
 =?utf-8?B?WGkxVkpOY3RiOUdTSWpKR21rYzJCUW13a1M2Zm5ObFRMVmMrcUJma0diNlJq?=
 =?utf-8?B?cjZlNnNJWHFRdnlwT3pxZkJpMEw2dE5Qa1JrcEYwZDVwVTJzTHBpVFBGV2p3?=
 =?utf-8?B?VWtoOUF6QlE5VXVkMUdjOWtrYkhoT3dmejRwNlVxRUZpUkR5ZE92OXE5ejZs?=
 =?utf-8?B?cWVVYWR4d0xFT3YzaGhoaFIvcVVNU0lWMklSaWZXYVMzQVFtdEhKazhhdzBJ?=
 =?utf-8?B?V0NxYzdhZ3VxakIwMFVsYjBBdDhuemcwd3hheDhHaUM5TzZwYTBTeG9DVnpM?=
 =?utf-8?B?ZWlnZ2gyRnJRbDlSelJ4TjJVbDh3QVJDeGNONFJkQXZBdFdETHlYaW8zd2Fy?=
 =?utf-8?B?aWc5eENSczZkbG1pTEhpUnRqRWFFS0pTSVd2Q0RPejVhOU93UzgrTFJpQWVi?=
 =?utf-8?B?Q0h4SGNQL09CanhrYTRLK1VRM2w5WXNpaXFXRmI1QytHMUNJM2ZzWm11MHZp?=
 =?utf-8?B?RDFwU1RWcE5OcjAwQUtWYWVoYlVlSnNrZjhMU1g2UmNONEdtVDlxcFE3WEVM?=
 =?utf-8?B?bDhkdFRSaGVhU3JmS25BdkNkeDRYZk1kazV3T0VHVjFYUlJLb0NyM1BybVJQ?=
 =?utf-8?B?TDNWdHVUSTlDRGtkYUM0NzFtT3UrL2tCYnZBT2lwNHlQZnFjeGNlcU5Gd0p1?=
 =?utf-8?B?WkJBKzd0TTFJd0VQaHUzYkxQdVpaVE9uTThJMVRsUWJOQUxaSGZnQUtwZ0xS?=
 =?utf-8?B?Z2JySmsyWjJidkdCL0l5NFNOUS8wc1c1ak14bW9MeDU2dlVkSVBlR1FmbHd6?=
 =?utf-8?B?SUluMHJpQmxrU0wvTm01bVJaa2JzUzgxNHZyei9hWDgrclg0MXNQeS9vQlUr?=
 =?utf-8?B?U0xBRXIzZ1pJQ3VFcHBHNEFpa0kyakx3aEkyNGhlM2s4ZTdSWXJDNmNGT2hB?=
 =?utf-8?B?b1dRZ3R0cGlYZG96cS9TMHR1Wnl5OWNMbUFQcXhtSVdxMVdnMkNsTVhmQkZM?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b15f35-a073-4176-c762-08dc907486e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:28:53.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD9xapMtKlRx8G/RoTsIv7fzr9r3zR+ytuvrxvk7PcsGwHfBHCTftdsWSVbopVuLtt6LbUdVgvmM+YcLyRUExw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321

On 19.06.24 17:17, LE-DOUARAIN Marc wrote:
> 
> 
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 19.06.24 16:13, LE-DOUARAIN Marc wrote:
>>>> Hello,
>>>>
>>>> It took me some time in kernel config for x86 to discover that the EVL_CONFIG menu is hidden if < 64-bit kernel > is not checked.
>>>> Is EVL for Xenomai 4 on x86 not compatible with 32 bits processors ? And Xenomai 3 would be the only choice available.
>>>> If it is the case, it should be precised at https://v4.xenomai.org/ports/ for x86.
>>>>
>>>
>>> 32-bit x86 is processors are history now (no longer in production for 
>>> almost a decade IIRC). 32-bit-only x86 kernels should no longer be 
>>> used for many years already, also on 64-bit CPUs supporting 32-bit 
>>> modes still. Use the compat interface in that case (32-bit apps on 
>>> 64-bit kernels), but that is indeed Xenomai 3 only - unless I missed 
>>> something as well.
>>>
>>
>> x4 does support x86_32 apps over x86_64 kernels in compat mode, and
>> armv7 apps over armv8 kernels.

Ah, sorry! Good to recall when expanding our tests for this further.

>>
> Thanks for your prompt replies !
> 
> In the world of industry and embedded systems 32-bit processors are still used
> (example with Vortex86 CPUs in our case, handy for some historical PC compatibilities)
> 

The Vortex might actually be the last one today. Even ARMv7 is getting
rarer in new designs today, and compat is an optional hw feature there,
unlike on x86 up to now.

But be reminded that you are already vanilla kernel-wise on a barely
tested path with i386. And with X3, it's no longer tested.

> So a small addition to the web page on this point to clarify it would therefore be interesting.

The web pages are projects on https://source.denx.de/Xenomai/ as well -
feel free to send patches to them.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

