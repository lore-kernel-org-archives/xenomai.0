Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2786122
	for <xenomai@lists.linux.dev>; Wed, 21 Feb 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540029; cv=fail; b=dk9sJI32XarZVo+F0w+KmpyNNSveNTrMHS1UykpW813gky4df9pjPm2Tnwmz5BTA2phSVN6MRWmi0ya6eyTCM3MrlF0HxCzEVbxhFvbAOltH36+smCXnNgOV8H/n4FQInRkTl+fg+C93ptvH0pi8uGTYLVj7bIiL5YTQXttnHt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540029; c=relaxed/simple;
	bh=RkMGfX5b/PYkOJpNQ/f9hsip1xPFlip3FdUg15GrxUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F841XsRWeJMkaqX+PTF2r5bWxSK/+VgFSHEjbYykt6qadEt/hnZgneoVWHwnJw1WbjOntwN5ttfog04JknuoCryS1s8Sp6vCqqInABm5nanGkGdWKtWJmfsR3HGbU7Ha1tma50PeDYkQNlKA9j87k/ShmsBSMH/FPgdxXUU/Wj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QtA9SWif; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QtA9SWif"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBK25K9AeFUwGo3eGBlM1caN/oIjCSYQcStBRd5nFfh7UZj/UR2h/Ai5d/aWJ/t1l2L+w8lOPL4MKGwRgO/2fG3Zv93R+nif2i+F3TOMhtCUEQsv5/nK8AtsC3uNen4GKRyE9389qALjto70e5S4rJs3g+6cm5djLIkNDOadiScIE0O+muY+dXwk7HGbIXO/C17VvI3niwMABzd6+2Ex6Nblzck976kBv14DGRbzDCAnp7gs15xlM4LBqND9ue4PYPtXUi8Bf1j1FgrQ9M/doeG9eG5rAM4ZUtTjUXjtsMOAcCntOGNC4ah0OkUpTINVTY7gogYe8BaJ+DKmXFV33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBjIYzPEZz9H4ngmzJtfHYfaOhJqh1gKHOAEmASl/cU=;
 b=J7h0oiE4uYkDxwYw7nKd6rzWP2pj7EYieci+pOl5T8XfAqliv945ScmPwNaIISi3j0fHv3WDT8Ex+JU7c4G0/Kl8PcxW4PuW9Aapi/aoOWT0QeFQ6wumgQxyJt0ltUAq1u1/CqJnSAU328opaN1fZKpbvDcqyGwdUM5JJZhq+b/IZoz/1qJuBRyuEtkkF5gGKzHuybUwAp1581o/h61Af+wNm9nLsBoLlADHQFyU61W3iqn+ZIffiF3yglb+f9RRUHscXCC1vR77Q7S3TrX/79qrZWe8OUefioz0C7j5HVobaKsWL+W+h6JUx8mVQy6ksx6QKWfZCM2RrC8Hjs4g/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBjIYzPEZz9H4ngmzJtfHYfaOhJqh1gKHOAEmASl/cU=;
 b=QtA9SWifqIsLbTEJbzQHhkQXnh6QavX7da09chgivXqHFndtGgk0BxfDev7U1vviyXJBdOm/3m0ceA66lpze9cnqIDeyx449slIV1viTvph6WRd5WlxnD8EoSuPiT3Orm7R0wmUvRJLkqSFFkvlorNJt5omn1AIX4vhPWhT8HwXiIPOLwNN3KlaFXHtHjkyKp1+ZErnmxkvKjDEM4FOuVm13AkO8yCkT/9ybjAivezg08/NnGmSaH039x/79LOpOh2IVFZOiAt4xWSQoO14lB0uc019XLL3YO/yIt5VpLv3s15S5D770Ya4UnRlgnE7oxGvfz0AbAW0ort1LOv0ezQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Wed, 21 Feb
 2024 18:27:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 18:27:03 +0000
Message-ID: <47a00861-f1a7-4559-a550-5bc197781557@siemens.com>
Date: Wed, 21 Feb 2024 19:27:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: latency: pthread_create(latency): Operation not permitted
Content-Language: en-US
To: mars_liu2023 <mars_liu2023@163.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
 <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
 <5da66ea7.23e4.18d2c1eddae.Coremail.mars_liu2023@163.com>
 <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
 <4038884f.9223.18dc59ac79c.Coremail.mars_liu2023@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4038884f.9223.18dc59ac79c.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 8006eb9b-3f49-4a85-9233-08dc330ab36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0q5+xgWitmeAMDS4Bqk7roV4RZZqvAUdD7ikoyj2loWKWIKoZDACXn1ybEzi8uPK4sfwPfqOqL4JscXRGkB0BsjohqlAH/bGIuuVUBCH8G+/z27MPXLgGX5D2r4Ad035ZMKLtcTg5EwSgEY3YSTrPFbA+MPyY1Yq8ygA5wbtpfo9/DoYtoOsJLhpxkUtHDrlLeAfEx0KCKJd2elFfkkfP8zFSGy6RhSW0okXcizvEsl3SmrvynlHFqFjjoOEdjJCIiKDN/tVN3dsmFZ6JXLHCaNnJdw/Opa02yL9ja8RKf6Bn0gHbLiJgvDZDrBAp/bYk5Xa+lyjxEoEPkrjJTRmNiXtxG5TuAgIatqxvq/PIk1ByQbgMp/nHsBTXFvlYmKETs90LXGsIz8v73sRg1badXqD4EHr82uiB8kkoLyua/dDirp2Djlg0XuWlbqXJsBQYbJW23n48eEZBuGc73SC3gEG2xGF0+6y8QkPiQY1GzsOrCW6uh2CN0sMiQEuv+tt/b212TTPhCrlR33lqF6NJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEFxRlBzOTgwblRBVnpJZnZMdElZaGdkaUpHQTB2RGtxZmt0d0RFYVJFWDBC?=
 =?utf-8?B?M0tML3dmZHVkSnRNYngxc2p5cDdnVWxKak1aMTRMVGRpc0ZneHpnOTZ1cDFl?=
 =?utf-8?B?M2JFOTZ6a3pncElNdmtzLytXT1JsSTRJcTA4TGk3S1UweHBNeWJNUzV0TlJz?=
 =?utf-8?B?M05ZUWVvWGo5L2lLbU1tdE5Pa3RRWW5BclhBM0JmTHFiNFNKZFFYZDhUSDZo?=
 =?utf-8?B?Z3M1MWFialVWZ2VSem56d3QyK2dCcmZic0IzbzE0WWNtQUo5TWpCczcwa2VI?=
 =?utf-8?B?WUtIOEEyUlJ3Zi9vR1hVcDU0b21ZbDdQVFJFTUY3TUgwVlVuelFscmJTUWVj?=
 =?utf-8?B?ZFpOTlVndXJJRnIwdStTSFdSdThPeU5xNklMUEszYW9wekk0ZG5hRTFOK3cz?=
 =?utf-8?B?VzZyQStzQVVqOU8wdTJ4c1FIOVN3VWhMNkNmelNtSUIwRVlDZUc0dE9pVlRN?=
 =?utf-8?B?OUdGZ2dNVjZiMlpoOXI4Y1BpYUN5SUtpVXdLdzRPVkYrcjgyTEoyczFNYkFl?=
 =?utf-8?B?Q05OeFlKTCswRkJmMTVaOXJ5VXZqek9UK3dKWjFQSFJ5emQyN3NFR2NoUkJV?=
 =?utf-8?B?MVl2alM3eGErNU9zU0tFaFQ4UkhvMEZvZnpYclc3VGVmMGg4OGp1NitxSU1O?=
 =?utf-8?B?aXBrNGdZc0p4eWx1Rkx5VWdFeVp2emgzM0lBY1ppRXQ2cVZ2aWZ4RVlNVFhF?=
 =?utf-8?B?ZTVZcm1uTVpJQnoxb1VLVkVmYkJTVXdIVlFncS9jZmxNZWVUNFRkTVlsQm1C?=
 =?utf-8?B?REhWU3JiL29iRGc1ZXZIMVN3eC9DTVYvYzRIVTg5ZTBsbGRUa1d4R3g4MmZJ?=
 =?utf-8?B?OGFlTitCT0E0T1l4Z2REbVduYzlZQ1dzUUd2aG90MHBoQ3dLc1ZocUlXOEtS?=
 =?utf-8?B?Njd0ZFI0c1gwQXREUXpldy9EMnhVTGpXV0czWCtmZkNDL2R6RDZUOGplZUZk?=
 =?utf-8?B?R0N6NnFqYXIrRi8yY1hvNzlxZkVFa2l0SXNpVXoyUXlTMlRBZ01hbTFkSVRk?=
 =?utf-8?B?U1Qyd29KOUtVVTFDNGhiOGVxaXpDT0pmbWt1T3hiUitCeXZNU1lqTXNvMFNx?=
 =?utf-8?B?WHJuWGNIblgvNlRLMzlIZTJOM3hyakxWR1N3OGdhZXJZL3hybUtzcStiZThv?=
 =?utf-8?B?cnVqMzJxVE81akgxRVpWTGtYRU1YSnUxZXZVc0FiWkhkMmtzVzYyMjA5OWNr?=
 =?utf-8?B?bnNRWWl3UkNvVmFCaDZaL044NVd2UURjU1ZoMkk4MVpoVmpGQ3QzZVNNR1ZD?=
 =?utf-8?B?QU1LOVJsRk5tQ0JHS1MzdGtFNURQYkppam1LY1lhSDViT3gveGRGY0pmVUNL?=
 =?utf-8?B?bFNCOFl1cTBKUURoMzVDa29nQ1ROYzhXVkhzanRtTHFYWlU5V3hNVERZbXhV?=
 =?utf-8?B?SnFDZUthOGNvSzMxMmNWcFl5am9HNkFqRzRHVGFSOVpyZERkUXp1WFdQS2FB?=
 =?utf-8?B?QlpkS1llSEVNYlNSaGM1ai9zNDJ0WmFidGRTeGJmcGdzWjBsc21ZeW5nRW9i?=
 =?utf-8?B?NHgvMW9qb0NMRWFFVnRmY3lscXlLSWNxMy9VMDd0eDk1WEFOZzBPdVI0bEE1?=
 =?utf-8?B?OTdHYkVYSUNLalNTZEZYMHg4U2hWY2VWN2szNWlTWVZhWDVMZHNBeEgrUHAy?=
 =?utf-8?B?RDZkcmVSRDR0VTVlcGoyNHlud2Z1UjFoUHZyUXNCL1hhbmxkNFZpdWphTTRk?=
 =?utf-8?B?aU4rRmx6N1IxcmpyQXZIL2s1OTBHOHorRVZmOEMzNVRmbTR2Z0xsWlFQN0tv?=
 =?utf-8?B?TFdFelQ0VTMvc2FzSmpQby9zOHNKS3BtVUpSQmZsTmdrWEdINzBxUmNxUGpF?=
 =?utf-8?B?YTNZZFl2Qm5zMEVmTk1talhseVM5QkoxR3kvRCtVL2dMaDRLSTJnaUxpczJ1?=
 =?utf-8?B?Qi9ITXR1L2lvTll4ZmcvTVk0Nk5OS2VZb3o3TWRSTVJpcjBxL25iSE15OXFr?=
 =?utf-8?B?VlZNMTBkMXVLY1ZETzFlMTNzMlZrdEVjSmZ1K1lNTnBJQWZIUXhMdkx3NDVY?=
 =?utf-8?B?UmRLd1dQRFVEdW9NSXVSSDcrcUF0WUphK254NVVHOFlVc2JuQkVEMTNVbFE4?=
 =?utf-8?B?Ui9qYVFDQzNpbmxPTzNDMFk5aTZwR29mOHo4ZkJLY0JPOXdQYzQ0VEZ1NVAy?=
 =?utf-8?B?WFErZ3NZa0JLOWVkZ3Z6YlZEbzZ0eXd6Y3lhdXQ4Rk9GanBkREZ2d3o4ZHNC?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8006eb9b-3f49-4a85-9233-08dc330ab36b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:27:03.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrDMXRU0aOlBskTgeYhu5P9YurJNrjlehptRMXvYHMd09F0pIBnYOztzffeO97k/qCplh0g+Ud3z9RzzPeyIqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8169

On 20.02.24 09:21, mars_liu2023 wrote:
> 
> 
> 
> At 2024-01-25 00:39:17, "Florian Bezdeka" <florian.bezdeka@siemens.com> wrote:
>> On Sun, 2024-01-21 at 21:03 +0800, mars_liu2023 wrote:
>>>
>>> To Florian
>>> This error is running the latency utility outside the container.
>>> I installed the containerd.io package through the dpkg -i command ，then running latency utility  outside the container and this error will occur.
>>>
>>
>> I tried to reproduce that here in three different combinations:
>>
>> a)
>> - docker 20.10.24+dfsg1 (docker.io package from Debian 12)
>> - Xenomai 3.2.4
>> - Dovetail/Kernel 5.10.
>>
>> b)
>> - Dovetail/Kernel 6.1 instead of 5.10
>>
>> c)
>> - Xenomai 3.3-dev (next branch) instead of stable
>> - Dovetail/Kernel 6.6 instead of 6.1/5.10
>>
>> a) is running fine here
>> b) showed the problem
>>   /usr/lib/xenomai/testsuite/latency: pthread_create(latency): Operation not permitted
>> c) Same result as b)
>>
>> Disabling the systemd units docker, docker.socket and containerd
>> followed by a reboot "solves" this problem. I have no idea what's going
>> on, but I guess it's something related to cgroups or any resource limit
>> that is changed by one of the daemons on startup.
>>
>> Further investigations necessary, unclear if I will look into that
>> soon.
> 
>>
> Thank you for your reply and comments
> After some time we still can't get around the above problem . Has the solution to this problem been found？
> 

I also suspect it's something around cgroups, maybe similar to
https://access.redhat.com/discussions/2950611. But I don't have setup
here to reproduce like Florian had.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

