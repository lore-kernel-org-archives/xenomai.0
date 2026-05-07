Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF213AA4E7
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162571; cv=fail; b=nuPnnplazciOEPB6Tzdp0Hxx20SmqLoAcIOsQKSa5mF2GXTs45IORCwfJsN93TZ8deslELcpTZHQI8FCYcP2YFeayrYw7cgJZpf4IO/C/lYVI7o01lpf9rJ2KzJ0mDd8tcJT4Oiw5v/4Tc9c733SDFaNs1OVg4xOEub2ttnDWzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162571; c=relaxed/simple;
	bh=DxbzLuO1TLBqE0vvGOGIMsCcL6DFzH9fxAp5th00NAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3hbYqheH9jbZGVsHSI0d9LsMWbuSkM9G/QInNvnjUKhr8oKIJWQr3rFWf3/29OMz7PWGfoq0MwEhPo0B/HXm0OsJ210z5ScagWd5ck1WrUxQvJUQy2cONZ+joyZgIh1mH7Nd8ffT9WtPQhY5c4nx5bh9DFl0VUmRpCVzeR6HYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=msuqCx5b; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="msuqCx5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHh+Gg/tyoGlJOD0eKmdHom5a5bW42lhf83QgOf/hh254RRSf9K65/gDGdI0uGq/wh3r0ArQIGCbdcR0vxhrmECwkqlIyiB/MuvPw+uX9M4udHR8uXx1cVeLnWkGVGjP2xFcd/QcWRgg5cWyPnr53jp7U1kA1Hh703xPsVb3Q2QpSfrxfxj+jg3TEmb5emnUmTIxImfA58VtsBqyFajrsRatEwVXxd9QkFOZafTWv9a9dMZ6boAxhKj04japib5/oos8emSTlzs967OI/yJdXNNl8mRA0ABYk3INnFNtyX9RWIFmglODOwtG7JgihJjEe2Ukxz7AuBjOeLDbExxwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tA6m8V2XGjhWTCNANeAbOcrTRc3saJA7t64qwnF1oM=;
 b=FlHusVYWqgfu09xxMh60yK6E2jJ78GzJbOBNUOd7ktNjnzxZGygRHp8HwUtSZtiRBM0TN4qzEySGbzwGVMu2xfVtz9/mGh1WVtB0tFZCNF7emLZdHFhapKxHEGfovdOfyd+Gdyb641qODxjsDL2lDJgAsOiqKa1NqLfC949Pdm8R2MGZXIHDANM4fcsnrzjPMplOBGJdqdumDvavhvF5TfL6sVVOfJA2+L+TnKFkuXnYI421WCnwh0hHyqiThLFOdFHrGiZJ60vTV9LL5+XGRXWfYry3S5L0EAnbCslsF9KHSRKpldsdbC1ZDZPfATt5qx582klLLOf2CuPt87WRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tA6m8V2XGjhWTCNANeAbOcrTRc3saJA7t64qwnF1oM=;
 b=msuqCx5b63WpsM+XpEBpN2IdPqagPs5OenXEQK7WIHl4pq6XOPZX91Vi24ty+YydWdz6saIrS1C18RzCHBmQ4Lm4W8sqlS1DLxS8Ifq0EB3W/0vSPhmZO+WISKW9k516jmC+mdaxkvL0n/SkwzdfLUAHGipkBif7G2yAYIAtf3kBnrCcFH1gYPNYo6DsUeg9Kv+6q6Ur9Gyg14dTQx5+ykmMRXvna/AgZp7Z+s0y7CFgmkdPz1o/Wx04PvobOQDY2hoaTytG+O48Z4R73UxfMOSqkwQhh0CO+Yqzos+q2FTl6KNyeFCBY5KIeVNKvb4LTc3fL0CuN1h8muZDIAexGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:02:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:02:46 +0000
Message-ID: <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
Date: Thu, 7 May 2026 16:02:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20260507122357.2463483-1-richard@nod.at>
 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
 <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 820cba35-9ec8-4b9a-48b2-08deac4150ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	GdHe+YidSaupyANYomBVOHieTbz6buzMLrcDuE4bi5ps9YS2cI8KZSbO6BvYFNU4BlLPxVYFjtK8cj6cyG4rc1ulLCFIPPSxMjWAQZV+IcRAk0TQPel5y37m6vPANz0bWWS5+XWfOkxIBIQ/ksB52sPCR0YHTTjwHyr+7ok8fqgob23nvd1vlXTOn+PRs6v/8F/VpCVH2IUbuNdftUotBGtCjHsty0IylUpZQdyPsfQyJj6DBRrbz75r/LHZ8tisBoI/lAjqMBQhO5Xrue+iEFRHuqxxUqvXOW3l2R4FljPy60ZkrQ52HzNO34ebniEnDgCufzL98dSxCSdaEHZqTKk+IPu68SrkPzWmB5b+Wy6xy6WVLCTmlcg3YNeqTo4flkzrQGZyzOzKH+zRZwYfr7Eu6zy4Y7WGBAmQKEltTdou/wq4RQGpp2vOm0vq8Kfrzq6YV+AW6EC0nN5ylXONaoITPuitpUgta933X0dndiclGQcf9Lmn/kfVIJ/MNmHG1OafwnfkIRo40OK1YZ6I3dVykeKWL4f7zHF0nK/0mJCayTqFcbHA/ei9Aa0JJN7yCWjejvRqoMUja1MPdYo9hpogDF97hpjDa961WEjMC2esN6C4/n63QBeD0mNpbiPerzVBSCuNCfhnKdBsM5wW2O1pK/HEmJAzNYg1ISoZlkES0He3JbmGnvFoT+3MuM57
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlQ5OGl5TFZ1QUdtaGZRdjFXV09UM1Vram1sa0VFc291WW1mZE5zb0JvRmxn?=
 =?utf-8?B?WWpuMzhJeXZnOHNHMnlYOFJ2TDlEQ2ZjZXRnd1JXa0IyazRyeWcyZmdJNTRt?=
 =?utf-8?B?TGVoYW5nQVlHUEJ6ejljNytRRlVNK0ZrQmkrNXIySGdkbUN2UGdpYThhU0xx?=
 =?utf-8?B?N0RFOW1wajZNSDJvSFdUdjlmc3J5VlM4Z0lkb2c3dVljWnZTcEN5OXB6YVpO?=
 =?utf-8?B?c2RCUWptU2M4NVh5b3dHWUZFNFhkWUFudE96NlNtUThDa2tidjRrQS9nZjFh?=
 =?utf-8?B?N0MyenNoZ0h0UlpPQUhlTytmUnhWVHpWbGlCRTRNRkxjcis1WHhtQm45RzdP?=
 =?utf-8?B?MkYvUjlGa2tlTC9nQ1JEVVVySnNMU2lIaFFnL1lQZWJPQkUyTzJXa1RNb1JL?=
 =?utf-8?B?a0JEcEwxWUo4cEFhTE1vUGRlbnNkUkJLVDRET29iclV4VTdDSEhCaVBZWlMr?=
 =?utf-8?B?K0lFbU9yUkU1Y3FKb0NQRnBCOHhidFhWblh3MWdmTnNZNFJRSGs1TzZvaXNG?=
 =?utf-8?B?N0l2SlY5SjJEb1hhbGM2bi90SkdDVmhTMy9lZUZjVlpQeVl6V3VIQ0tqemdR?=
 =?utf-8?B?SWtsSkNadzRjK3g1V05rU0JtTUVJRFJVVVFENHJTaU4yeTBrTzJsUy9qRE9X?=
 =?utf-8?B?VW41RXpvK2dXbmVGaVdiZFkrZ1ZEYnU5cU5KZFl1WlFJMFNYbGdET3BiZ01m?=
 =?utf-8?B?V3kyQjJ2Q3JWSFBoakxiVmVTd1ZGOTZUTkdaSXRrUXdCbzRQVy9pWFBOZis0?=
 =?utf-8?B?WDU2cDZjQWlxTXBaMzlaM3RPTFg4L2czeU40OVA2UFRQeTZNaXA1NlJ3OXJj?=
 =?utf-8?B?UFNjVUIrUDJsSXEycURsZnhrV1E1QUFWQkNnTUQrcVNmMGc1SEh5eU0zK1gv?=
 =?utf-8?B?Z1hjM0pDZnZxc1lWZ3BpWVZGY0lvN1Z4TUFoSHljTVZLZlJraGM2N2c1QkdV?=
 =?utf-8?B?Rnh5T0JjQUJZazZkdnRaVWRmR2l5NTBxZHZKdDBJaHlPM0c1b3BtVUx1WjNQ?=
 =?utf-8?B?dU5nSnBaODVrNTZiSGRvVUMxNFJ1VVlSa2M4ZUd1SFk4UDk2dkl0V0dEbmc5?=
 =?utf-8?B?cFRLSkduVEVmM0pWTGJqV2ZwTHBiUjNwL1YzRXdmSGZlSFlvelk5aEhSVWhD?=
 =?utf-8?B?eHpSeHlzQ2I3Qm90L2JNM1VKYUROY0FyQm53UVRNUWpDZ050cE9YMXA3UG44?=
 =?utf-8?B?cjJiSmZXYWdZc3hIdWxzSkp6U0ErZ0Nmc2hqSVR2Vm1FWTdlbEhReEJiQVZF?=
 =?utf-8?B?a0VIL3ExNnk3M3FqQXRMUFZkb09kYmt3NjFXbFVqdjE2RUtrT1MrTURTVnIy?=
 =?utf-8?B?Ky9WU3hIbFZQMUxDdXlHNExXWFV2MDRlMEFHYVdJNzZwY3dQRFdINllRNFI0?=
 =?utf-8?B?c09aWjJ6K0JDc05yQ0pVRllWbDlzS1VnSWdHRm1BK0l6c0YyZ1laTXo3OGlk?=
 =?utf-8?B?c3RFeEdnM1oxTjY3RDRwV3dWanp5dVQ1ZC9ZaHdycWtJMWJhQ2JGU2l3NVM1?=
 =?utf-8?B?QksyYThmM1VMdEJGOHhMYlNVYk52RnFjYTFJRlh6QzBnbUdIZUlxU1ltSEMy?=
 =?utf-8?B?Q2laNFljUUdSNjUzRk5DazVFaFlSa2ZPS2FYajRZK1lZRUcyTGRVbDRvTGVF?=
 =?utf-8?B?bHFpU2J1Y3QvVGFURDhtVU5wUmttT1Q1WWd3UjFsK0szcjJ6VEF6Zy9QNXhM?=
 =?utf-8?B?MUQvRFZEbERPNWVET0J1dXE5akVjY1o2djRMTWRDOUliV2xVSDZQL3FjdFdL?=
 =?utf-8?B?cUhhRE9DR0R4dVpodHpXdnluWnR3N2VlbHl1VjVoaVBKK3JCUzlnRjF3YVBR?=
 =?utf-8?B?bytiSStnQmFzOGFNL3JnYkhnOXBCdk9wODBaeGQzb25GdWpiZGJNcjU1T3V0?=
 =?utf-8?B?TlFlQ1REUXZpWXJXbWQ0YktnOUJLWHRIY3Z6L1ppWDdEQUp0V2hnTW1IL1BU?=
 =?utf-8?B?UlcxdmxFbHBUVCttb1hhYU9wazFNeW85aDN0U3dLVjk2MElUZTc5c0hMMHRq?=
 =?utf-8?B?VlVOdTJmN1U1aW1MQkxYWU5BWWNIck8waDk5Z2JCNS9jeGpoczJjaFE4VnF0?=
 =?utf-8?B?ZnNYTGgvWFQzRmFoS2QrL0FCNFF3eCsvOGc0aUlvL1lJUzc1TldxbXBhNzZS?=
 =?utf-8?B?L0lBb1NibnZhM2l3TnNTdFVXbnlCRUpveHVVaTljckRGOUNUK2ZJQTMvZTRG?=
 =?utf-8?B?Y2J4N1l4RGhaRDBpSmFuTVQzSElMU1lCSFlpeC9uQytuZDJZQU1sZnRQVC9Q?=
 =?utf-8?B?V1JQbzBKbUlNbXlxckZKU3l2b2RpTE8zMHlDNmJ3UXhNbHVKQ0Z6RisyYmdL?=
 =?utf-8?B?eHZ6V3BLejNZUGRHSElQTmNXWVlUK045WXpxQ2xWTThZQlRzNzVQQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820cba35-9ec8-4b9a-48b2-08deac4150ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:02:46.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwg2tJvZ9usncml3uUpX0QkZY65g60+4xp+hfueGw+/cuQR+w7csxgyeX3JwdtFhQ1AW19ly87hS0zhga3Yh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8605

On 07.05.26 14:55, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> In my case it was just mmap(). But wouldn't it hurt at any function
>>> or data structure exposed by Xenomai which uses off_t?
>>>
>>> So, I suggest applying my change as safeguard mechanism.
>>>
>>
>> mmap is supposed to be fine by now. So we need to understand why it is
>> not and resolve the issue - or my other patch would be pointless.
> 
> Ah, sorry for not being clear.
> Your fix is in next and not part of a release, and the application in
> question uses Xenomai 3.2.6...

But 3.2.x is not affected by the mmap off_t issue?! Still confused.

Yes, I decided against backport my fix to 3.3.x, so your change could be
an alternative for that branch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
