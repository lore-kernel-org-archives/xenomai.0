Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474533B945
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226087; cv=fail; b=PyhSWqBguf/sJPyIzR1qoei12itPSX55mVSozJLsCR5bA/E4ybG2SknRJVqkU62yfSwhnxXNg4NbsfQM7mPzllZOekUpicWs11yOb7pCOVSmrHySgQ3BcY8tTTZHdaMqpmYEuBsDmcwf7ekIcGhTuL2Mibrw4gOiVf3jkU50Ag0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226087; c=relaxed/simple;
	bh=gzLi8B1xcZlDlwEdN1SrjZh6ywOm4ZoE+RgaqbIFA2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsbD1JD630ZPKcr+djbWyRNy/7Dug+G2McPqBUvHtiXUGXw65vwwvRjhfrZakzUBKCaTQUdQlVJ48/e0y6BlCrhKZbLbIk3lp+e1/p64d8aASyXay0OQ/4aQDdHjiMd6wCii0oCf9VucCHuEwkJ+AzqScvd7jsrRLAGRjxc8hgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=O5rNpNVp; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="O5rNpNVp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBf2QUWKjaKSwxcRI0/eQ6uNfevW9oy1Zmk/TWnV4qGkyPlbC2aGkotcobb9AaO5+jiZFO4SwwJfTrIH4Ev4Ioze9rGmEA6szwJfHzcpoXi0Rtu+lcipBJr0QkSmAhlcAeG4ZpKlzr66BFqb5r3oP7d2Yu4HfNe68wUboUNhX2xJCwQf2WoUxTUIwMepqAZWmjrA8CQmxiuf1xj5agjCr2ObztcJxv1oQ4O9SQA1ha4n4gGURftO4nALfb+BniQnDwYYpYtdHv45NMFnMyvK8UBJbW4eQVI788cjQuvzR07Xnyoy2h2iu730lsY9VkQdWDYCG5zvWedT85NxkHU37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLhIAy2TeNVkdE0w/W0+Obc9G4dmlC1UGUwfzLUJyYg=;
 b=c1fEK0WcY5elLK/Dt+Vu0mWodEIxXu99siVYdlmMIFsu+q+ZFgGD5eaLTqdSnQpzgja0sXXCIpiaqqX2WODBQAXkR3pF8KQEhr9PZRHEr+R4dQHYx7l2rJiQ0/Fm5Tm1F9nvqMOcFP1WHt5WGsUJvetbCSckUSWuJ4UQxrHwTNf/d6UenxSavgN1EbeApS/AEXzYhd7M2BCHQKbicSej3GDqSMC3uvHGrlupQ+DEDoQOopXvUgsWn2Zy7l9ULmv/GMiwQx8SyliEeevaYRPmZuaERATwCDmfaRQoRAKJFAz7UYo11E5LY/iKkckH8qqHZehU2/U+fb6rpqwmJPJ+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLhIAy2TeNVkdE0w/W0+Obc9G4dmlC1UGUwfzLUJyYg=;
 b=O5rNpNVpJ0NgOtN8nfWlSJ5D7umx16yN6PVkD6jyH8cH6pgIfUp1nfdYD9mwgWzXdD5Q6pb91OqVIx62zz0l5Btl0lp0u6unPq8WyS2kYsVaCZw+O05ZTHEHSqOylcLSDw3itD028hdgDis+RUxlicGVfTqNkICu1HBUtwvyGWIXSW9qF9FXLmWsGgc3c4lJuG358Xlbgwmeh884QoG/xcMed14FFe1pEfUfiAw7ywDNFazUfHLjBAyFSbbJwpGq17bkinv354IeWC2KKInO2S++2e7TPOksE5DNsSkq1RSP+Vzg7AbQgqyY3QM5lm8S3tImFAwlng6hXusCyluK3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 17:28:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 17:28:03 +0000
Message-ID: <ee18b4b8-22df-480f-be6d-38e23a3d6c1f@siemens.com>
Date: Wed, 4 Feb 2026 18:28:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at
References: <20260127213927.26960-1-richard@nod.at>
 <9873549.lNWL4n7ouV@nailgun>
 <1310f7ea-9326-4200-b92f-17a828975328@siemens.com>
 <5491679.p2sp48Hzj3@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5491679.p2sp48Hzj3@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c258e56-a9d3-4242-4bab-08de6412c01a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGRab0pRUW13L3lySDB5UkNqWDcxS1QxUVhFdWhtREMxSXJkQmM5SjEvVXAv?=
 =?utf-8?B?bnhuQ3pTRlJZOW1Bb0gxVnlleEhTMXlnbWtRY0tvMlV6WGVLRjVxV21vQUJU?=
 =?utf-8?B?QjF1b3Z1TXRqNzNrQ2RHekJteHRGRjNhaHZNdlluK1JVaE90a3FuNTc5bnpE?=
 =?utf-8?B?OTlobFFWZjdBbzFGdk05KzNBbHN0WUJUMG9VNEY2U0xJZEdrREFvRG1INEtk?=
 =?utf-8?B?TUNzWHdnQTRIa1VMM1hjUHJCQjNBeWp0WmVPUmhBZTdIdDNqK0hrWm5oM2k1?=
 =?utf-8?B?SVc2TmJQZGpaaHhieERKZVUyWFlORXRieHpKN01vYzJqeUJOSkd2NW5iN0ps?=
 =?utf-8?B?NnU0RTZXalBFSFluMUdEL2tNbU10UE9kMjFUL1JoU0pmeXpsdmhCK1pzUUJ6?=
 =?utf-8?B?OWZPOHhPZ1RXb3d3MUFSUExxZ1pUVnVseFhvTmRUc3FKK1JUQVA5amhyRUh2?=
 =?utf-8?B?RTMzQ0VpWFdidTZFaUtrNXo0RmtpM2F4dW1qeEdGUXNSU3BkeWgra0NwMmNx?=
 =?utf-8?B?Z0NjN1hGTFZGVUwrWStLL2taaGV0WlhZWU1nQTFVQmlGclcvUWIyTjB5S0Rn?=
 =?utf-8?B?SlhWcjNHcmxwVUkrT0NEWTVDcDFDVTkzWFlOVmZucXBCdHVYN0FVbndYSTUr?=
 =?utf-8?B?ZStZdTlFNitYZllselluNXdBQmhnN2xRWW5wc08xbGo3eXFPQm9heDJ2OW9u?=
 =?utf-8?B?ZE9rNWZidmtQTmpXZHZNQjM5eE4rNWllYS9DN1ZxcjZlVXZmM3U0K2JzQWha?=
 =?utf-8?B?Z3l1eERhOXlScE9aOUFTd0p2WnZyb2NzQ1huaFVxOVZhYUpURkdXZEpYNzN6?=
 =?utf-8?B?aDlSZnkxSTRlME5NVGhzTnZya0ttQXJHVVo4UWl2N2hYRWQ0Nm1nam9xb2lw?=
 =?utf-8?B?ZWlaSEpaT25FYXlrdWZKTnVzKzNTNkZFTHRMOTJCVm1ESVVrMkxkL2NEQ0gr?=
 =?utf-8?B?Rmx0MkNJNWtabkl4NGR0TWdMQUZpYTNuODRiNkFqWTBuQ2g0UmIyTXplZ3BX?=
 =?utf-8?B?YmM3U1NtSXNwd3dpd2szSEFPQTlRaG9GLzhRdGRnNmExNk1rMm5KZnZibkxQ?=
 =?utf-8?B?Uk1BbitRTkdhSHhCR2FjOHU4bGhqTndjSUloaUQxQWwvRFVpcVY0ekZLSjF6?=
 =?utf-8?B?SEtBZGs0Z0pGQ1l5K3gyQ3UrUHVsUldhVmtIcTVCUGxaK3NaaWVNU3RyTjFJ?=
 =?utf-8?B?NXl3SFZPN2JTaTFlZkduWFRPWGduaHpkWkZwb2JIVkpLQW1SbW5GWUtLalpE?=
 =?utf-8?B?N01jbEdLUHlOMTJXNFFyWE1IbHRtOGhkTS84VFJGRjBzODBZTERhUXF5S2N6?=
 =?utf-8?B?VTlMOFVXQkRic2dRVkhVcGdhZGZ4alg2MVFGQVdxTmVQb0hnVy9wbU1mMWht?=
 =?utf-8?B?d2xQUFlSakp6cmcvcDZhcng0RVVOM1dwaWRIRFlTT1lWSkdsNUFQV2U4Y0ln?=
 =?utf-8?B?L2Y1c1djdFBydGZlc2NvYU5wNDZBVTRyZE1yNmFTWGVtK2V1Z0tySk8xY1Q3?=
 =?utf-8?B?c3lZdVBqeHM1ODZER2dHSlJ4UVhUSFFFZm01TmpXZmFEbzZ6TFJsR2RxanEz?=
 =?utf-8?B?UHlDVjYxUTA2V2IyNWhLZFZVb2hHUFNEUmdxenZlRC9RcFdsZjA2cnBIVjNL?=
 =?utf-8?B?ZU1vdWpBZWM5VUtad1BGd1ltNVJQaERmR1FzLzh2eXhUWldrYWpjeGRjS0Vp?=
 =?utf-8?B?Q1owV0ZBbVllZEgvN0NybEp1Ykl6N2dSUWdrVllzcFdza0FhSDdLeGlwUlgv?=
 =?utf-8?B?VUFIQ0tLaW1YZ1JPUmVqMWNqdVVjNFRoR2dwNmhRTUlJUHlkOXZVM0dhR1JQ?=
 =?utf-8?B?VmtPWVNZYm1XV1pyN0t2TFVJUnI4OGtZTDQrdXg2NExjMkdxNEdvRitpVDkv?=
 =?utf-8?B?djRiQXRyKzZMd21tVWg3NmhRRGs5Yk03aURTcWxjS0tCQVdic1BJdzI5Y0tr?=
 =?utf-8?B?QmJjZnFSK2FIVWJhL2VsMXljK1BMWUgzeDVrR09OY3ByTjVRYStiZWdWRTZs?=
 =?utf-8?B?bW9kMDlwV2VEaGhJN3NuSmZlcHZUNDFYVnpBKzNnZThzY0dmNFFqZ1FzWlRu?=
 =?utf-8?B?U3ZFWWRZbytVVm5XQnpvYzRYY0FjMHpnNUF2WXh5QThEUEJPZDYzWnp3RlNn?=
 =?utf-8?Q?deV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJFV0FFNXhiQkJSdUxUNjJlSEd2WTUvN0lxOTM2TkpZVS9CNldzZUpyYkhl?=
 =?utf-8?B?dGtJaWxNdE9nd3drYStpQVNORDdhZmoyb00vNnZCQnVvTjc2b3VmRktFSTFn?=
 =?utf-8?B?TGdmUzhXUzdKQTM5bUJNSzlpNkFtSi9HUWZ4dzFDU3ZzUFY4QU53RitEUUY2?=
 =?utf-8?B?T3hvWERZLzJCTURKUktwdzI4dDJwc1d3R3k3MDJRbE1VbGhjaVRsQlM4YmJU?=
 =?utf-8?B?NnA0eVd3Qyt0S2U3dVVYckVJVlBFT1p6TGtJdU5MblZGZDZzcG9jdUVwWEg4?=
 =?utf-8?B?Z2FiUVN1dWYxQnFtcWhKRy8xclRzSHVVOXhTK3N4SU1zWnNnRDNZMUpSdFVQ?=
 =?utf-8?B?V0dZNE9ya01xTDJJZm9oMlhjc0J5K3hWNGpjY3U1T0xQUUlENzVUb3pyaTI4?=
 =?utf-8?B?L1M5S0pUZ3o4NWpPYTdqTzVaekp3eWxkVDBkVVFwdm55aWpxdmdRdkpRV3FE?=
 =?utf-8?B?L2VrblZLc05PM2JPMTUzMzBrekFFYWxET2prSHJMZDA4UUtYakNEL1RLc0t5?=
 =?utf-8?B?MU1wZVpyOG9jUEVqbHJmSnliQWxDcEFyaTRXTFBFMkRCd2ZqcGZPMXlqYkxm?=
 =?utf-8?B?NUhHOXQwR3hmZTF3cCtyNUFlTDVveVpXTTdYZHZLY01rOGJTRUtnd0dGakRY?=
 =?utf-8?B?bk5YUlJlcmlnc1JQL1kzWlltWkUrb0RvbGpjdTdMY1VsZUp4RlFLWHZ3dTVR?=
 =?utf-8?B?bmhBMmJHRFVlYXpZd3BCLzZTYmdWNXZpT1pJdUZ6OFdOQTB4RlhsM1RCcFZ3?=
 =?utf-8?B?aTk5MXVFSWVyUStvcndlSzZuSERqa09SU0x6ZndxVCtlK1hBZTJESmZvcHJD?=
 =?utf-8?B?OGFENjRjRUdIRWEwcG13akVoQjVseDJZUytrMk45R0ZMUU8zNEU0aFVjeUNl?=
 =?utf-8?B?Uzc4U3NiKytrREFaQlA3eFZuR0pycVMya2NwZjBRYi8xbmw1UVBkeHpLeENw?=
 =?utf-8?B?eWp0OEExZWpTS0llVzdkL2h0dDVPZkNmZGxBWTJzSjFCWXJ6TjM3SU5QczJs?=
 =?utf-8?B?RFRpUkFjZVNZUjRvb3RCSkZyem5aaTVLYUVZdXBhZ1VJUnhueE50bGljd1FM?=
 =?utf-8?B?MTk2dEI2Nm5ZdjBBTzRlTTZKcnlqZ0tvb0VtQ2xZOU9tTTFjdWpsT2VLdW42?=
 =?utf-8?B?RVhFZnlBbWM2bkNhcHNKamN4Z0lKUXp3RjZJa1dVNTFTdUtNOFVKNVFCcCt5?=
 =?utf-8?B?N0RNYzFEd3VsZWxRRW9XeG9JVUlYTXhEMnpobURIN2Z1RlpFdStac3MxM21k?=
 =?utf-8?B?OTlTYks2RURqUWFaMG9hOVpkT2N0aW9keSt0dDVMTG92ekhYZzNJVnVBcy9Q?=
 =?utf-8?B?Y3VlWlJreTVaZHc1MmFFRjhLWDZPalRpYmRIbE9Od05ZK2lidnlHelpIb3dn?=
 =?utf-8?B?R1MwV0Fvbnk4aGRKU3p0bWdKLzliSEZ3cFlQTklqUnNJMXp6ZWVvL0FnQ1hn?=
 =?utf-8?B?QVBxQkQxZlRacDdIQUtYZWRCdGUwNDhremRNU3JlVGVNdWhKT1UxTXZzRW1k?=
 =?utf-8?B?U0cwOHRhdnZibXQ3Z2NkbFg1UVpzbjJuLzJmbnV2d2hFUkZhb2ZHdGpnN1Zi?=
 =?utf-8?B?NkFFc2hwRVZVTVRuOXlmU2lGNEk2dS9xcVRtTzZFek1CNHNWaVlHZDVFMkND?=
 =?utf-8?B?VHpNWUhLYVN4Zk4zemVMMWlGcHZVazdGWHJWK0UwV1JMdHdLTXIyNXhJc3or?=
 =?utf-8?B?QmhhWVFXRmw3NndDcUhjTlc3Qm45aFk4eHd0RlRUWVA2SmI3aC9WM0hlbHQ0?=
 =?utf-8?B?ZkVPaTlmRU9xK2todWlabmFueGE3V3VvdnNwQjB2N0Q1QUZDQlBMYkg3bENB?=
 =?utf-8?B?azVTTUJVdGcwd216TlRGNmNXUGdHUHJKakcvc1VlRE5rUmFPQVBUNStjc1ZB?=
 =?utf-8?B?K2lsajJBdjQ0OGdIZjJJOExuVCtRdUVHNlVOMVF6RkVJV0NEQThUeEtpbDlV?=
 =?utf-8?B?enpWdmY3S3RtemwvVlNiUVJYSlppbXhFYlNQdEJGWEFtQVhVd3YrekdKeGNz?=
 =?utf-8?B?NE41dENGdUFMS0dOc2xtSmNydFlpR05DeHJyQjhKemNHOGdZMnVKQlVMdm1h?=
 =?utf-8?B?YmZ1aUdLR3hkY1JQZ0ZQRHp1cEhmN0p1akh6cVZBamNmZndsWTRYdDViMUdK?=
 =?utf-8?B?RUdWcEFYQ3YvVVZXVVl0QW5TVEw2K3dHUmZQOXdQVUZaTDZMckRkWkZLWi9w?=
 =?utf-8?B?L3JGZmpqblRHVkVuazlpQ1NnWjBhdGZMcjZFVlFPKzkzNmVVdnRDS0hGc01X?=
 =?utf-8?B?aGdoY2RKZXFYS245ejRCN2p2NFpoSVkvVFhKUUhCNit5WkRVVUZ1bS81ZjA5?=
 =?utf-8?B?QlQ5QmEvaEcvWkwzUXRWNmNFMGNiY1F5aGd3ZWdKZE9PMkNnVTJIUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c258e56-a9d3-4242-4bab-08de6412c01a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:28:03.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY7sQQ1QD5qkjxnF+nTjAwu63FZDUPBlhoGHBp7IYugdUT2SCnCZkSuZfDAMhw++yvumOUluKLs8Jzf27gWOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8451

On 29.01.26 11:34, Richard Weinberger wrote:
> On Donnerstag, 29. Jänner 2026 11:29 Jan Kiszka wrote:
>>> Hmm, for userspace I'd expect that Linux frees the task struct only after
>>> the parent fetched the exit code? So, after zombie state.
>>>
>>
>> But Linux has no idea if we are still holding an xnthread struct reference.
> 
> Yes, but Linux does only free the task struct, not xnthread struct.
> xnthread struct (being rtdm_task_t) ist statically allocated.
> 

I've looked into that again: Cobalt threads - the other user of
xnthreads - perform lifecycle management themselves
(cobalt_thread::magic). Even more important, they do not need to
synchronize on the thread function to have exited
(wait_for_rcu_grace_period), thus do not have this race.

So, your patch would be sufficient as-is, but I still do not like to
lock the task struct over the whole lifecycle of a kthread. While we
demand RTDM threads to be closed with an xnthread_join, that was
technically not needed so far from the perspective of xnthread.

Thinking about it, I came to the conclusion that it would be nicer to
keep a copy of the host pid_t in xnthread directly. That nicely solves
the race and even simplifies existing code. Patches will follow, tests
still running.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
