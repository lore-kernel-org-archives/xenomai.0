Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EE199A4
	for <xenomai@lists.linux.dev>; Wed, 18 Oct 2023 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Q+cEJo5m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCQA3ErFS2Qd55qRYByVaoQq0Uucq/qYcEMntkEK5Hn9yi6Z2vW/k9G84CWLG5YEy7PcBnJsEy4XtyVQFLN6j2OPvIexEgTwqhp7oQqi7Cyp5V1vr9fx9Zn0LBF2xU8PoZwjw+Nne/9f0zSvqGoPHeUmGnoYLOSNOKFtQnSGko3DgK9atSG5teNDoDk1bv0lFsV579ji+EdUdGIGm5Fc7pXJw/XalbYgv3V3Q0SUvfBFrtEwumx5iNyXyiT+026blpQLoK+naza9NGFIY2AHQMekOSpyZ/5svTP34slxBOfEvkaTXLxbvYjcuRnHyuay+pFiVki3/6Ot2qhpEKx/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5dVnSyGV27sz5zFOSznxtRei/QrdAISnv0MxARsSSA=;
 b=m15guvxoAtRFMeAunciOdB/Jz+sNXISmKIzGJcJ6HzDzcZs803zIV69BJu09D8J8FrQsJmxwsszoOm+bMHtoZD6aW3GglgXkr29qpDJWHbakv629JkLxjE7S02Tc11gYzvfIy/s8nAEnsrVQlkfAsCw4tP4rj7YnB3iDZvlqDTF0qVf8K5yn+/YAjQyAGTlHjlPRHup3Qe6TkELsymVwGLQztTni29j59flEyP/tWfe3LiyWdodsfOvf8KYC80ItNN3hQoGQHf5Cl2/NLKMXJMjEMp2k5oQVC2urmLTy0W7urU0U/XKtZa7DblxGnwgoNLFLg4QHFk4M1Gt0zm9EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5dVnSyGV27sz5zFOSznxtRei/QrdAISnv0MxARsSSA=;
 b=Q+cEJo5mvtbwLU4UmYX2sjTBvulE2AC3hrgrUx2B0JMig9YHGPBqscPy8L+KfLIWoXm4LDpa/w3SLXKl4py0wrpW6wpZUHSf2kX19CsmEc2oSjcu9bsGyq1HZtXI4Eezp/xL/wsfg06LdJBMjvZhdI763oH8jve28KXryAB9TphE1qXMWToUHcM18HfrMgJRV7/KLhOWbwH2MVyeMhlu9lsUSApDJiduajM6c6UNo/k4t9TV97DQDEyCRO/ZsGq+6Dm6V7gcqTi+8orGQ06ELbg2aMqgOybDyZ5rfrEPXiqK7XPoiTjHhPPtCvWVtUffvPx3kqus5bXe9cb7kaLo4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 10:56:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 10:56:45 +0000
Message-ID: <1e70bff8-3f04-4afc-b0f1-73add9ffc574@siemens.com>
Date: Wed, 18 Oct 2023 12:56:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: initramfs can't find root filesystem device
Content-Language: en-US
To: "Baeten, M.J.J. (Max)" <max.baeten@tno.nl>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <40202c26ad1440aaad6cca4463af0e29@tno.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <40202c26ad1440aaad6cca4463af0e29@tno.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d11dc98-2bb8-4ccd-2e40-08dbcfc8eb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m6qM66GBntTEooS/dJulBGtJ43Ox8IR9/kxKcdqiWEV+XV2/nPL8q7psIE3mLb17++KmjY0/71+fDEths4c0xhL8++jK7zALY7JwePqeizehmYLqhaBz7NsaXflFU1g84AXpjARoZ0RVjUlB4yyhiy7VONZ89sEVdctje7QbrhfwYaV+DOw15ezXzF1S3qWNyy45Gq65TokgMCeIll4U6Pl716kb1TiswOxfQkSYax9TKZg6kKuY89XXC3IdULb2cnSUHBNpXTbKQWLak77YoA1ohbf7cpTmRV44kCPJHX0AaAyMvikZOwnco71EVbU9KYRN04kwNGyaibYm+ol2Ovplw0NGipzB2DfWRqxaDmo4JnPqErAz9Nxrq9y9ZtB1uXlvacT2iV8WMNfNv7DZfobGPNrnO1SMVOmnCRb0GlXm7WQesrMvnFXKFj4CTo6aYGBJ40qfTd60Xh6B5/58Y9zDDb+fH1BQH6IHBHNCQdOf33UWF1e9bn1P1Mgu1Vh19RPCXYFuWHmJM6imYsKrOBIMFC+UkcF0alNOmRMTGQK4Pz2eY9KPYrXspnnLv18kjkfF3b4y8kypYbqbgrwdwEo34dPumqq/pk8I3q5MvaAQi2G3/S2DjHnuvfMbM2S5L8nBzpXIZWparByjPJ0iHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66574015)(83380400001)(38100700002)(6506007)(6512007)(53546011)(26005)(2616005)(82960400001)(478600001)(31686004)(316002)(66476007)(110136005)(41300700001)(66946007)(8676002)(6486002)(2906002)(86362001)(31696002)(8936002)(66556008)(44832011)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUJuTXBIeUZoZlBLYjgrWFBXUU9xNTIzK3lQZURBUE5WcExFSkNCZHJuN0gv?=
 =?utf-8?B?YVl6MWRBbUx4MndjeGE4YXVSS2sraHludVdUUlR6Y1J2TEJrbkVrRncyaisv?=
 =?utf-8?B?aFViSXllREh4U1JrTUZGenRlMWI5OXphVFRLcmpvRTlOVnV1dmg1Y3g5aTNz?=
 =?utf-8?B?KzlTWDhDajBYSS9VRFJwdTdmaHJjTitlRGt6ZGxkWkYrMlZxY0Nha0F5V2Zu?=
 =?utf-8?B?dUZ5aDY4S1Fib0xZMlUwWVZMMUs3UEE5bTk0b1BaeXFZRWZ4bExQWGNLTlR3?=
 =?utf-8?B?bkVnL1hOdjZPOHBIZFdHMVdJT0RJV1IreEsweVIrb0h5OWhockxtTlgzR3FP?=
 =?utf-8?B?dGxJWkRSOHY3d1RMenJMYXlCN1k3VHBXc0hsWUVnemUxSTA0U2U4R25RcnFy?=
 =?utf-8?B?Sko1VW5kRHVtWllFZ1g0QUNUWUtpUWxMMzM5U1kxL0Z0VUIrZWc0RkdBSXpi?=
 =?utf-8?B?SFIwaUdQZnBrT29aMUpNRzNXTFdjODRBZXdOb0cxWmlma3FiTythOVFzR0pP?=
 =?utf-8?B?WHBHVFY1N0lKVGNONVhFa0drZUFVYzVadnpKVDFFamczUUlDN0JxOCs3OXRU?=
 =?utf-8?B?M21Dd1YvMXRYRG9ybjllbkxzTnR1MEtPbFlXbXJ0SWpuY2h2QmNsTXA5dUhh?=
 =?utf-8?B?ZTAyZ3cvVi8vTC9jRWF6Q09yU1dDOUZadURyc0hScUZSNEZYWk5pcm9xSE9v?=
 =?utf-8?B?UzAxZHh4MVNHbm1aSkhCdTUrM1B5YWc1b0dNOElkZjlSR2ZDT2hqUFVmYjVz?=
 =?utf-8?B?NnJ1bE54YkY0RzZ2UDRXTVZsZWJwOEhBaHJ1UHpMNndFTzRxcUN0d3pRSjJR?=
 =?utf-8?B?UVU3SmNTYWFmZ2FMSXkrVm95QzVRczE5enI5K1J3aE1MQjlqakJVMmVZd1gx?=
 =?utf-8?B?YnhmeUc5MnpOR01oemZiMUM1NENhUXhwTTFSMGk0cmJOTlNIN0w5ZHFEZm51?=
 =?utf-8?B?Q1pyV0hCdnF3a3pTZHRydUdQRk80WmxNMXpqRWx3M25waU83V1Z2UnRIbjVT?=
 =?utf-8?B?T3N1T292MlNzbUFRejdzdWhPekxBdVAzRExJcE45S0FlcnBnV2ZTM05paVVH?=
 =?utf-8?B?TG1zazFVek9Wb3ptTmRiQVVzL0ZGbkxLOWE2U2UvUG1tUG0vSk55emQ0WmlF?=
 =?utf-8?B?M3QvWG40M3B4NUdVaE1oL3hDa1owV3VjNkpsOE10UW9KS3ZxQjIxaG9WWUlt?=
 =?utf-8?B?SXdLbURPdzhocHBXcVFtd1h0eU56dFREQlZyaU1pS1pEUFd2U1NwODJNbURN?=
 =?utf-8?B?cFl5ZUZkNGRYc0ZEQlFWalNIanlkeXR6ZThpTWZqUEpQU1VZYWdhSFRaWmRT?=
 =?utf-8?B?djhCWFpsTFEydlBnUkx0M1FOZ1lMQkI5b2dBaFdFUWNsRHo4WUt3MkNBMEYw?=
 =?utf-8?B?Y1htVTBHN1lMZnVJYndqWE80VXBsZWdyMmxoWUFLSEVnQkpnaHZZQUpoZm1y?=
 =?utf-8?B?N3g3UTJLVmpNYzlDd21zN0FncHVqRmlkd2oxUUQxdCt2Z1B2TmtuTFYyQlh0?=
 =?utf-8?B?b2JkcjRCVS8yQnNvaUV1QlRpVG85RW1SUHBJNkRiZG90TU5JWHlOdEY3dmZl?=
 =?utf-8?B?ZERyNDhUU0o5RjNaMSsyRVpVcW5SWW1XOTBXbVorQTZDNFVMVFZLT1c4NHp6?=
 =?utf-8?B?cHUrOW9XTFp6enhxNTRNdm5MSUFldXRLNXBWbjlOM1ZGK3FPSTFld3pBNmp0?=
 =?utf-8?B?ZnZXTWdwQlNad0tMeXZsejdaUW1ncjRVdXIvMTkxQXJEOHpia09iMDRaR244?=
 =?utf-8?B?TmExZ3V1Z1RUNHp0SkNrZ2tDSkNjZys1b2dDQTNUa3lWc0dlL2VRUVlLVWxK?=
 =?utf-8?B?MDJLV1VyRk9ueFlUV0dnVFBpUHY2WHNxaVRkNXhPYm9ZZ2I5c3hmeVdRRTRW?=
 =?utf-8?B?R0VEQ0hmUjhtZ2ZCSlNGOWZvT3NpR2d5OHdYK0pzZzR6b3k1aHVsclVKNVY1?=
 =?utf-8?B?T0RNa1pkV2FtbWdIK3VUL2ExVjRxSERqZ2JNQXJ2V3kzRWVtZDEvVHQ3TXYv?=
 =?utf-8?B?NnlHWDhpbi9YcjN1bnZZY3dnaEdpdjRhVE11dTVlL2xrMW9MTWFmbU83ZnNL?=
 =?utf-8?B?czFkb0hDVkFnZ1lEd0doaDh1RWloNlpqaGlGekR3SjVsUkNtdTlvd2VtME1X?=
 =?utf-8?B?WlpjNnpTaDdBYXJqeUZLRmw5K2ZsZi84aEk0TkV1MEprVDQyYVRpaHBjam02?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d11dc98-2bb8-4ccd-2e40-08dbcfc8eb8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:56:45.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x39/MZRpagJJxW769d6pO7XZ5vgIS6VfCyHfnMC21U+vfLRzvvG+zHsmaz8Qtu+DIHj/mtO6ZYfkcaMtscw5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5773

On 18.10.23 11:32, Baeten, M.J.J. (Max) wrote:
> Hello!
> 
> After compiling a xenomai 3.2.1 patched kernel the initramfs can’t boot
> this kernel because it can’t find the root filesystem device.
> 
> Error:
> Gave up waiting for root file system device. Common problems:
> - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
> - Missing modules (cat /proc/modules; ls /dev)
> ALERT! /dev/mapper/ubuntu-vg-ubuntu—lv does not exist.
> 
> When I compile the same kernel sources without xenomai patch it works.
> 
> My .config is included and a screenshot of the error as well.
> Cat /proc/modules = empty
> Cat /proc/cmdline = BOOT_IMAGE=/vmlinuz-5.4.253-xeno-3.2.1
> root=/dev/mapper/ubuntu--vg
> 
> I have tried on two systems with different ubuntu versions, kernels and
> xenomai patches.
> 
> Ubuntu is installed with LVM but I tried as well without LVM. (Similar
> error: UUID does not exist)
> 
> # Config FOR UBUNTU 18.04
> KERNEL_VERSION="4.19.66"
> XENO_VERSION="3.2.1"
> XENO_PATCH="ipipe-core-4.19.66-x86-6.patch"
> 
> # UBUNTU SRV 20.04
> KERNEL_VERSION="5.4.253"
> XENO_VERSION="3.2.1"
> XENO_PATCH="ipipe-core-5.4.253-x86-14.patch"
> 
> Any ideas on what I am doing wrong or how I can debug this problem?
> 

Compare the kernel .configs, of your distro and your custom xenomai
kernel. The latter likely lacks some features around CONFIG_MD*.

Another reason can be that your initrd contains modules for the wrong
kernel.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

