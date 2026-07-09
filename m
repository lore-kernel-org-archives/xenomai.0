Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E94DA53A
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619583; cv=fail; b=fF+i2Oa8MkR5ZyBLcEQunzniFmKvSbRjrIEoG4ohkhMF/J4qECM4sj/RQ1nVt4GjRTDRpYjTSixrkyCpO/BPf85IJzQqIfnws3AVXYo3InLJqyW2lzLKQ5ec2V3Vsl1iD/LZoUGgK1v3PlkTgZtwnBAvWWWDq5QnAg2QilNAVTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619583; c=relaxed/simple;
	bh=2p/dE00BiJ93yeRozqb1kIn2Xg1KCK98pCRGXRbwPxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YvSTTR5AxShodMUAq3cesWPxTephQprEi13HkviuvU2fH6qzzP4pwIBabpILDv5y3b2Qoafk+w0JjtJva2orxfq8lzdS7XdNy0JgYYfmeJ5yYEqyRp7tblsfVc9EJuKlmhXUytFyOTIsgGnfpCAsAk2PyeGbD80BAUDUnsKCuXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PNrxhycY; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PNrxhycY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Hg0fVJQ5bajErHLBH1JJLD/kmaK+dl5SJHZ5OI694ty4j0jY8EMCVGL1FN+uhsE5cSKFG8tA5vyGc3AIWtVgQqZPdNhsbs7NRje69bz1ZY7SDMTRzae/r5FvnbEuESK7gRLMzTBSvEmcptTV01RSTSpEqU2QZ5e5QmpFaFfbjFFQcrSwAFhOxPBZGhD+MHgCs6R1esOqxfmyTLYdAiWdHASu3bkarXhBx4HLxTZs7YJpgfOmw0IJ/u/XuIMxvGCyOhuH2ov/7WvYjg/9W4q2zA08AjQRP0rRzQHeXHelT6JOrEf8F2k2plc+ax6DRh+AP5Z0E0Nrn9ML8L36o66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRo5Jv5jfZPlaAgnBl8rMjJRqE6JVg0WKJS0OnQ6wFU=;
 b=i+l0K2CwA7SJFrdZnujw87LD25jQjlF7LDH04UWpWgpHKwSIWCiuqrFBfKfLrQAHY6yW1cVt8DggpCg2joPHZVdmtg5ut6u5hlDvC+KrDP6ohRlUmb6zH1NG3sG39k3Ei1ovPcz5YAuFo0ib0CnkfqJx+j9g+qO9Znu1HgXxe3ou1VJnLicDA0wBVeViUKbXUxkNB8hU1DSUmdrpxzZsDBBUaCXK431GTxVtSYOkntJ8RxRY2pOvcFZDPipWNaQ59LWmSWIzjHM9PWCxw7K5TT+7D322vWmkCpv0Zpu4Xj5mY9XprfUBnWt3RDKURKHRuaO1JU+6W9GOrifk8VdqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRo5Jv5jfZPlaAgnBl8rMjJRqE6JVg0WKJS0OnQ6wFU=;
 b=PNrxhycYhiLgyhXL6e/d7YZ7BmnnUIiEvYW6hN4xw37+4VeJdr0Fr5R2yGyeOOC8W+IyPxqn5abbKhOXq2Bolo3hXVh8UKglUVp1Ia1A/6ceIigYYp0ZC1bjFxxF8fkg4sHQiza4zgE6aHi6mr5Cy8oTQiVpw/HnKboq2hjexQwrLCdCSZwi/U0zkMwUMuC3K2/IQ06FU8gYbLfwQq9iZ7jpTJmr6Hf+2IHt59p+Snar/vUkREXlFzr4uF5aa6Ux8EynrRHjbhxrV3rr+0xT6lE4wxJ/9M6dbTe8D/KvWwXXr7djVZp4zpa2EZRhV5s88nZPY5npPuHmY0zEWePPlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 17:52:58 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:52:57 +0000
Message-ID: <24505584-915d-4c4e-8b08-734a22087aee@siemens.com>
Date: Thu, 9 Jul 2026 19:52:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH website v1 3/5] doc: mark old PowerPC and ARM build
 examples as historical
To: guang_feng_wang@163.com, rpm@xenomai.org, florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev
References: <cover.1782585785.git.guang_feng_wang@163.com>
 <0894b60dfc629b724142f57eff07d8d01285c3ef.1782585785.git.guang_feng_wang@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0894b60dfc629b724142f57eff07d8d01285c3ef.1782585785.git.guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8c6aed-4a64-485b-e649-08dedde2e900
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KhUgybfjoCJNn8QQUO0C3koWYOL4WMGZQOr19dtzRQd5uBPZsKOF0sSQjq2DTA+UdFmke5M2Myly5X56tAahJ8MtpW6IXES99FiHwVSdcwxlZnz5CgPgpUU5qWRQ8ECl06AsosG1wVt2scw63Y2mMHDgyg5tBFoqnLaAQnNQ9KzQGe164NIuLo8S7KLguonzc1ux4/DJkNx/kzKJBMkcT+65rZg1gvLvDsq328yHIwjVH7ifQVX3U2pIUpyG7a/EQjPTZUfXifla40Xnpz3V6niknt1nD094lRQtGh04b9tBLDVmOCx2XeFtcBYafruY9q37LoemQhaPXBU984lGNZlkHHF9PUOUwPQHnz2zcBqA6KFTBnqpy3Tvo/zx40B5o/wX5e2Wz0M9uFzB761xvO7hQwyY+N/pBEKP10x6nLIj6z1OEQKT4R4SEfXbdNH8APfaoxriX5FroFXNRRkU8vWWWM7UUstnBDeLKt7ynkhw8wFrYHagEJX8elEvyHBZ8shk9sjTHWv2PErb+ikP3x848MCFfNsP0Fvx/XtA8ySnLXwFKV9CjgJoQ+38BCyCZYDc8M4ikmAdt8txn51z6rWnr+hVN9inWnpOtxn8ML2OxhhjfExhv8iV7tb7ZOLsmyuB26qqTlFOrFmK7yQLO3TSnHwiMsSFK4aHoQzJ0VI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUpHcWtqeW9mTDAzc3laOWNvRjUzaTkwQWNielF5VGdVUEVjNFhwWm13dnY4?=
 =?utf-8?B?VFZGczBOcjU3V29ERXJvUGtOOWJWd2RhMy9pWGJmUTU2NUxTTXlYNTFoTlNs?=
 =?utf-8?B?cnVJb3RXTCtoVlN0N0w0QnQ0cHJMNmJodnpmM3VGNmFtNEhLVTE0UXk1QVVB?=
 =?utf-8?B?ODNSci8zenJrNVM1bDZxVkJ4TVNjR1NJVFFKVFFGZ0tCbmRySWlCSDQ5VmxH?=
 =?utf-8?B?bXR6ZDZaN1AvZVZmalk0dmw2c2hjR1hkckVRdHk4akliTnBQSGdYdkxrR2Nl?=
 =?utf-8?B?WS9TK1k2OVk5L1ErSEtsZzVBM1RJTHFURFlPQTI5MHJST1NIQkFKTW1IQVVZ?=
 =?utf-8?B?eHVQUk5BbU5NWXQvNnUvQno0N1JKV0lXQzVjZlVXUUd4R2k0V1pXK3ZaOWlD?=
 =?utf-8?B?TFVxVE9oNFdSYnArTVE4TXc2OHN2NUpxZWpBL29zMkx4S2NVUmpVZzB1ejZF?=
 =?utf-8?B?Nk93TkVXOTI0VTBLTzNmWXZGSG9jUnRPOFR4VmI3UGpPK0t1bzVSUXJMV21n?=
 =?utf-8?B?RThtUmxONk1TL1dpZjlMbmZmZTM2VmxpZ1ZvaHdKcisyaWxQS2ducUtEVThp?=
 =?utf-8?B?NnZNVytUaFFMS012SHpjV1I1UFRXWUg0aTkwOFJDSitzTWFMYnlrQzk4Yzhw?=
 =?utf-8?B?dmtnK0VVMG9RbzVqejExRmpvRkFkVFZNeGViL1cvc1pySWVJNmtWRTUxQkRo?=
 =?utf-8?B?Y1NJaUdlRzhEeW5aSXEzNmZla2RPaENVbkZoelUvcjVRTGVKdWVuNkZmZ2FS?=
 =?utf-8?B?VUlhdDY4S1gvYytlT2M1V2dxbjR5M04rcHhabTJyQWwvVGl0eDVEOXk0SXBW?=
 =?utf-8?B?aUlRd2cvbTB4OVgrMnlndDhGa3o3V2ZqbmdBZXJmZlpkYTNvdzRoV0l5ZFp2?=
 =?utf-8?B?bVBYbVNsVWg1U2tyNG1RbVpqZFNUcCtwZ3JCN3lFY0xQZW5EWHhUdjhZRTJF?=
 =?utf-8?B?VEtKclZlOVI2MW4wSnBpVmp2YjVPMkUzTmhrOTZqdWQvcDFta0pqd09ORFNl?=
 =?utf-8?B?a056R1Z6NlZqUmtJbXNmRFN3d2hHUFZkQWduaWhHMWJsa2ZmUzNxNjNEZTFW?=
 =?utf-8?B?dGxnbHNXaGtvSTdlSThUMnJBcFh6TDYySHE1dGw3REQ3Qk91eUlNR3FSVzRU?=
 =?utf-8?B?bnc3RmFPMjcvNHgvNERibU4rdkRLM2k2VCtsbVdUaUs0YjVpdXNWSXJlSmJi?=
 =?utf-8?B?M2dNOThPcHptUWxaV2g1NkYxRUhvNHlWdWUvTlhMWTZPcWVsRDRhR2ptRHR3?=
 =?utf-8?B?L2VtM2ZnTVJ6aWJkTTQrc0QrUVo1N21KQ3daaEMyMFAyRWwzL3FuNkFrYUpq?=
 =?utf-8?B?UEo5ZUJRaHZpeHNPYW16SVV2Y2hpRXdFa3JzY1Jlemw4R0kxamFKQkJWS0J2?=
 =?utf-8?B?b1djcUdYMEpKSEtOUzhkQ1B5QnVNcnRiSHhFNnUvQStEd2w2VU1Ub3hERVMx?=
 =?utf-8?B?NEZjL2NZR0p5WHpidU1pNklMOFJYeEMxWWU2UFUySEwyM1lGdDRnRjVKcXB5?=
 =?utf-8?B?V21BbVpTQzlITXRKbXRuV1JHTXgrUWlqWWprbmxDcXh0NjNSUThaVmtYT2cv?=
 =?utf-8?B?cEZKUEdzM2Q3K3Z3ekFqclhkMnlMWmFIWFNPZWlsRGVET2lEOTNXU0syQUhq?=
 =?utf-8?B?YmgrNHVHTFE0UkhFNG1YVmpsRDhncWEyYlhIV1VTYTV6VFlJV1hBQU5FRHh2?=
 =?utf-8?B?VnBZdkVMc1NkNlVVREg2VGo1eVJFTlI5QXo1VTlHLzkxN29DKzhGV1Z5Wndx?=
 =?utf-8?B?ekd1bis2TFFnSC9mQkhkSUFubTYxMW5pRHZFYm11MVlWTmVPL3dZWVYzQmcz?=
 =?utf-8?B?TVhjSkl2T05uOVBxRUNIYTJ6cWNYQTNZTlNSQlVyZ1NaOU5UTDdaQlJyelRH?=
 =?utf-8?B?WElaKytya2w0SVdORDFqaDhCZmYvYjRLcm1iaXlHS2FoQjVwclFpM0NRT0ZR?=
 =?utf-8?B?dGxXSE5vNndmcklmQ3VONGVreVdXYmtmT1UrVklvdnNkVE5BcitlQ096L0dy?=
 =?utf-8?B?K0oyRkV1Z3g0MXg4Q3QyRm1tYlI1TGI1SG9KdVppUnQ0OVFNNWMwME8zYnZW?=
 =?utf-8?B?R2ZSSGFTMi9mVjZXSys1Z04yVFNZSU5jSWxGVDBDWStZbzNoMEdibmlTNFg2?=
 =?utf-8?B?NU9Tem1FM21ZckVqM3lVVWJVSG5LR1M0Qy9saDRJdXlnekVhRjFWODhkMVph?=
 =?utf-8?B?bi90b1FNUGZzN1JFenJmS0FuNzBWUnlJRTNLc1RuMEl3K3pwakdKZVR3bXdn?=
 =?utf-8?B?ZzYxL3B2Yi9WTE5NK2pqNStYWURVSldxWlpWcVdQaTU3OC9ySW9oanFqMWJq?=
 =?utf-8?B?TXdDZXZaYkN4dGFXME90aElycUgwejZZTTZ2VUlKSmpGaUx3RVUxdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8c6aed-4a64-485b-e649-08dedde2e900
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:52:57.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQbBKK2OlR4vDnzQQfqAB/biLLWiOpkYJPge3tJA2MDKcYgf5hNO84H0SkpLrr9ny/2hS6NkK0Wte9+J3rfPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6728

On 28.06.26 06:50, guang_feng_wang@163.com wrote:
> From: guang feng wang <guang_feng_wang@163.com>
> 
> Some architecture-specific build examples still describe old boards,
> toolchains and kernel versions.
> 
> Keep these examples as historical references, but make it clear that new
> Cobalt setups should follow the current Dovetail-based installation flow.
> 
> Signed-off-by: guang feng wang <guang_feng_wang@163.com>
> ---
>  content/installation/_index.md | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/content/installation/_index.md b/content/installation/_index.md
> index 265cb5a..4eaafcb 100644
> --- a/content/installation/_index.md
> +++ b/content/installation/_index.md
> @@ -737,6 +737,11 @@ The remaining examples illustrate how to cross-compile Xenomai for
>  various architectures. Of course, you would have to install the proper
>  cross-compilation toolchain for the target system first.
>  
> +Some of the architecture-specific examples below are kept as historical
> +references for older boards, toolchains and kernel versions. For new
> +Cobalt setups, use the current Dovetail-based installation flow and
> +adjust the toolchain and configuration to the target platform.
> +

Actually, it would be better to drop those old refs. All PPC is dead,
e.g., in the latest stable version. What else did you notice?

Jan

>  ### Building the PPC32 libraries
>  
>  A typical cross-compilation setup, in order to build the Cobalt


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
