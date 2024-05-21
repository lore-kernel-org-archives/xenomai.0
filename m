Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A11482F3
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310112; cv=fail; b=K5z8uEdGVLCgWIkfA0tpSKLLJAHIGSgWZLZifBD/hMSMH3GW46M5Wb/DY5ctaL1VsTQXkcU0dL7GyCq4vBeH7sOLkeBvE3EueBqJ9plhWxzEPcRglKpb+lcRkEH86+QPB4/Ib2Uodefr5XEkdgm4xJB593xhtiCweRF38SXwrnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310112; c=relaxed/simple;
	bh=E8BOJNK++jjLgmJ89gA61kWZv68lo6NhhwrOyF2N2p4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ao8eooDKPjLP/o9hU6ZwyH/+DXMAmWn+mtVg6X8j7r2hXPqY0kocK+Zv0hINpzPiFVCtl9G7/OJz/PLayfBRGu+8NPk2WZ2nwM47DAfuqrvCXQWNBvFB5RRiDsWvjtzqx7TJuM+DQSc5KFcrEUY2DE2GzMN2XtOQCw/KHnHswwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fStDuQRe; arc=fail smtp.client-ip=40.107.14.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fStDuQRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPoZQ3ZMPl+5T5c5LIArjkc7/v3eRo81JE82xeUKLqrDp8rdASAPrQpO/PKdn8SsE5S8RP9JEHOABki73RxPpCh0kvE0s1vQo48LyONobAkdZq9pftIw2SqLxxpatdiwSQHV8kxgcPEH4+Pcwk1w+qUlUVT9kYMxrGweGmT9tC0Nm98ysNAppXVBZEGrMHK1MHsUpPy60d1KI5OmuDqSg6o9gl1ZEf+wrUvmrLjxXhxe7qSKenPa0x/CYlKnjhdO2rx2S7r/wUZYrYy6XxYsvuxWcbWA/V4e9U5fLCD41ZXqLIRdspP6rk0VWbtG8g1KKGJ3GNcSpj6Sun2+XEhvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/haijsnM67SRE6W9kuqT8TA53zNwRuFfFVJ4t3IQxYk=;
 b=K3MD2OvYHyFPUfvqUvq5UnFE6xnSlBMpSOvfH221Nw7JsquGMi1NJ7PyMbJjdI+Z6BBpCNYwO/kU4evYG3daromcb7Bua7fRg5I63Hk97uIpXJkme/Dwd6X75/MK61ybEXBB4VQXwBwnJnE99rSi5OOvJ5boCjdhawMvOIs44HESZCgZwmqqn/oe1J82BDSoKtTzvfebdhTJo3XTQj2k8dI+ckA5Scjw3yu5qY98Z4feN3xMnXK75yp/nUVreuX3HeAHvwOMlkOW9VD9lQw9PoABKUeo8Ggz990PnLHBlMUhzrfiV/883LTTkKql85MUatvSGHfouE/LekUgMLZwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/haijsnM67SRE6W9kuqT8TA53zNwRuFfFVJ4t3IQxYk=;
 b=fStDuQResOOsNXYvSAhF3gKitp59qSieNeDixbwqY36yUjlnsnWxIUliKKQLdTudkAqs5JzhAIurXc+9SHX3QE3f94Pl0U8XC2nVCINwRC1qNnAyjARHRXvrk34BpcWoGhgrBqYooAl3LwIb+olkD6n4dCJ8EfQPRQ6XtONPdSNGxnQUaiCN0cmORd5CYAb2ND6sOIYLBlOUUnEBSHK1qisE8hXp21LbxiZ1A2YS97O0QY2UwsuKYWCH6B7kH0ScZCG5oUGhVJn96dd/7MAXF6j9u1OeEmn2/ysWhKnaLNiaPB8zenv5cHi73B0T0CsmCDHMrzZjuHeydVaHEPnmLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:48:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:48:25 +0000
Message-ID: <01878c51-a76c-4170-bc18-51f631d0c938@siemens.com>
Date: Tue, 21 May 2024 18:48:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] testsuite/gpiobench: Toggle output pin in react mode
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-3-clara.kowalsky@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240416085911.62073-3-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 55485ed9-9075-4903-080b-08dc79b5d568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnQ3N043UytreUpNTTlrMS92WkZnVmhsajlBdDVtcmh4aU9BK0NqWXJlSzJ3?=
 =?utf-8?B?RzQ2UlQxQ1IrYk9yRFFpWTBFbEJwNTROeTFLVkptRHBRZThKS09iK0ljSTFy?=
 =?utf-8?B?K0RNckRlTHdnalRsL3RqSmFUa0hERkszVE1raFl0b05YT2YxWWNNVUlIZHlY?=
 =?utf-8?B?elkxdnhzSlNMbnMyeFlLRHJJRGJQV3hlUzBTUjI0SElmS0ZiMVhkQjVoMVBr?=
 =?utf-8?B?bTdDRXVGdGlEV2tsODBqSEZVU3ZmZUlLci82bGx4UHJ1dHo2OGU5RzZ5cjhj?=
 =?utf-8?B?dEZ1M1YwUVN4U2g4ZS9ibU9ENXZMZVVVUlNnazhzd25mWGpZMk43T1NTbEhi?=
 =?utf-8?B?bkhaNngvcERJaEFTV3NmUkhZdUpKenpOVlcvWGlkdWNla0g3U2pxWWJIbGxZ?=
 =?utf-8?B?cFRBSndKTElUV2kwaFdSQy9ZblV0eDlFQjhBalczcEpaZGxSVU9tOEV5ZXlL?=
 =?utf-8?B?cDhVL01tUnBLOE5JREZmZ1RZMk0vRGxqbGJGL3ZNOGtOdGhFelRSVmhBajJI?=
 =?utf-8?B?cHFBbEFBNFJ3S0U5Z2xNa0dSYzJkTkdqNWlDTCtMR3pkRkdWem9WUFFKck9S?=
 =?utf-8?B?eE9WdEpjamFCR0wvcy9janVhZ3RzREhHcTR0WXcxdm9lTXM1U2dIdVdMMytm?=
 =?utf-8?B?T092dTJ0SlNoZ3VxcnJnNkRJM3pvR3AyOFBKYVNGYWhkc0tHc0sweVBReDQ5?=
 =?utf-8?B?aEtxUC8vNGZZL1dIVjBIQXgyV2F5V1UyZ2E4eXJxVWVGOGxiKzZIemVEYjhr?=
 =?utf-8?B?RWx5R01YNTNhVkhqY1FxMncrNm1leFA4M3piYmxwWjFUU3lqRGRIbHZKbGls?=
 =?utf-8?B?bG1kVGx1T0lMcVFxVDlXVzgySVlydklUSDhDdm5BR3FCVmd3V204N0xJdVA1?=
 =?utf-8?B?djBlS3ZKMnlkRmNhVlo3azUxcUtwK0VvOE1COXdOQUNBREV0NzBINjdRUlEv?=
 =?utf-8?B?aElFZmVyRkRyaE9MQnNIUVF3ZzZ3UEtQNkdMZ2NTL2lNNWRURDF3U29ETVda?=
 =?utf-8?B?MU91a0x4cHhXalprK0JPWTgyM0NYazdyNUxDR1IxcThldktjNHVZNnAyUzhz?=
 =?utf-8?B?R0c0WWlYb01hOFZzMVE0WDZtWlNtbkNEcGZMZXYrVHVnNDFxanVaaWd1RENa?=
 =?utf-8?B?cGlkcDhDaG14dlhhOXNFYldhckk3ZnJMdG5vT3ZuM1FMVktTTTBMbE5sb3Vp?=
 =?utf-8?B?NkVTM2w2dUg1dmt2dkxRcWlwSHRMOTErTjlMOUd5SzlscXk4di9PVHAvQ1hZ?=
 =?utf-8?B?NDdhUHIzak5jbVlQcFdWb0t4RHc0eUFncTRpcVRwVm9yamhHcFVXNWNGOGNE?=
 =?utf-8?B?bXZLQUU3MktkbTd1eG9UWVE2ODRDRXVUQ3V3UWM2ZUNsdG1PZFJjMUc0YUMy?=
 =?utf-8?B?d0RFSENPYkI0cDZyaVdDQ0lOY3FtNXZCcUJKVVp6RDg1NUZZWFpxYnd6cVdU?=
 =?utf-8?B?aG9lcjk5TVlRSWtGSlNERytKckN6ejJuWmVkdEVDU0FlU2Z2RWhpYUlNek9h?=
 =?utf-8?B?Q2gybm1STEk5aVptanhRZWk0dnd6L1d6WnZEOXUzeXhhWERNblJSY2dNQmVq?=
 =?utf-8?B?NXo2dGdvV0wzR2VLY0dOdmYvKzhSbFBsM05RUkxrUERVZmdaaEJwNTd6a0hp?=
 =?utf-8?B?RUlWNUVpb01vU3ZVWndKSG9vZFB2aFBqL0VEYWtYakVodjM5L21QUGpBOVk2?=
 =?utf-8?B?eENzWmZpa0g1dVd1S3JjUFF0cDhTSS9OdHE5ZzBibTZ2SFdwYm5hSXpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjdLMFdvcWRKRnRDbmtub2F3cFJEd0xlL1ZQdkVJeVFrYjhQVmNlbEkwVFZG?=
 =?utf-8?B?WldpbmhZSm1xcVpYckNXbG1qMHZrNU9JcWVXaXNLNTRTdEhZWndrb2dkdVRt?=
 =?utf-8?B?L3F1RUcvbkNINlFFa2NZd1B0SUVCcFJ1K05WdWxIdWg2SzZHKzgwcU9ZYzdz?=
 =?utf-8?B?RElnd2piN0ovSjB5QTErdjZsUDF2TDh1VVdmb0RQbk1MM1g4S2c1MmV5Wk5n?=
 =?utf-8?B?bEo1bEh5bUFIM1ZoMGFKWXBjQ09BK1lGUER6TjlXV3JFSHcxd3VkYnNnSHNP?=
 =?utf-8?B?eEx3MXFNSXh6R0ZqS2VjcHBHZE42OFEvNUxYQi9aeXBnbmhTNFVwTm1wT0JB?=
 =?utf-8?B?enNQL0R1VVVjcWdkMTBtdmlYLzFiOW9lM29uTWxXL2VEMDZLUzFuY2paVWJ5?=
 =?utf-8?B?cTdNTjYwSzZ1T2Y2dmVINzB5bTc4L0xpOXF6bVR4SjZEVEZPc2xpditEN3J5?=
 =?utf-8?B?SGdiNlRXNU1rNThuV3pzRkU5K2FVVDdHNUZHeUhuWDdZekhkelRublJPakZQ?=
 =?utf-8?B?RytXOExEWHR0dWlMUlE4eTl3dzBKc1pRQUNtQUhJTVlxMzErMkx0SHdtSGtz?=
 =?utf-8?B?RWVFckJ0SGtDR3RvTHdhODA1QzU0SEM2L3FQVzlKd2I2MkNLdGVudDFiT0Ja?=
 =?utf-8?B?MVNaaEFjTTRxd3BFTHczR1lqZngrTXZXRWRQN3c1STZzZi85TFpQd2h1SlRJ?=
 =?utf-8?B?ZUcwR1pGYXZWN2w3aXVmVkhmRmY5dlUwM2pOQ2VPWHJ1QnRXdDU0aUxqTGRD?=
 =?utf-8?B?eG9oUmlGTFJmV0oxUTNOVnRXZ2dFVGpDS0FmdEhFQi9hTEdQSDFMSE9wcncx?=
 =?utf-8?B?RUpsNEhJWC9iUG5GcGcwbTlOV0QzT1pEYUhGWVdtdGZIaXE5cW8vUGp6MWRE?=
 =?utf-8?B?ZnI1Q0thNEhkbGZMYUN4Y3JQcitrcGRnSXVLcG13dXRJMzhhbUZQNjJZM0JX?=
 =?utf-8?B?L3h2VkZaVGszYXNIaCttM2hGcHJCTHdGZ2JEbjlZWWIwVHA1VkhHc1AzZEJ3?=
 =?utf-8?B?cFF4MWMzSHFHTm5CS2IvSlBBWlNjWFZhWXlRKy96N1RVVVZrT1pVVTNRSGgw?=
 =?utf-8?B?eS84dDdhckUrcUVJZFlXY25qa0VOZmk5RG5OcDhvc2VVeFdidmlwM3FxYlho?=
 =?utf-8?B?a3kwTjJiUHBrTVZvWC9UWitqY1RoK3RpNDFWc3Q0UzVZRkwyQ2JRRUo5eEwx?=
 =?utf-8?B?MzdsVjB4cFQyVWI5SFNCWjJaK05HV1ZFMlh3MGlPeHZTUzRoK2tMVnpnQlJC?=
 =?utf-8?B?bGpERGtrVkplVzA5dUU4M3BNMFppSlE4OWZIbFRJYkREcng5Zlo1elRhQnI4?=
 =?utf-8?B?RnE3UVlrUmlZOWtlSHFYZE96R2FtRUQrNDFUOU56Rll1ZER3UWs3TmdqdGR3?=
 =?utf-8?B?OXJNaTV6eWJyamQzUC9ZQ1RmTHltNkNGTjQ4ODA2cHBNdXB3RW5MaFg0REgy?=
 =?utf-8?B?V255ZFJIS2xRalJzdnlkaWZ6dlRINHNlYjNkTSt0ZlUwRFIvdklLVVdxaW1o?=
 =?utf-8?B?QldhMTZ0TjF5Z0I0UzZDbDM0Qjk3dW55b09xUmN3OWVETjFRQ0Z1NC95RS9I?=
 =?utf-8?B?REYvNmlyUkVDalZDYkFqL1ZWalVpOFl4d0lOYWV2TjNKMEdZdjhMd0pjcC9O?=
 =?utf-8?B?clBBdFFSb3BRVnNTSDZKNmF3a0x4cTk2eGJybmRPcUVEeVZlYzRqdVh1SWRu?=
 =?utf-8?B?VXh4K0svQlJYY2ZpUU5leFhyNUVzbXFCVzNhd21pS05FN1VJeUEzSndibTI2?=
 =?utf-8?B?N0pPUVZNc1NvN1cyQjRZQ09BNGF3VUF6SHpBUk50dW9haXM5N3QzSjFlanN0?=
 =?utf-8?B?YWRpdWhGRjR2VUZ1YTFIdmIwalA4RmoxZ1pzZHJFalNFOWVxaVA0Z2lqalJO?=
 =?utf-8?B?QWZSbUJMbFI2T0tLWEU0bjBuSnJjZW1HRFRvYnJQL1BVSmtGYytGR2pHNnR5?=
 =?utf-8?B?aTlHTUlLeUlaaS9JYktvSFI5VXEzTXVMbDVCWEowanhySzA4QnlRbjI3bHh1?=
 =?utf-8?B?TkFNeTBKNlEzU1ZyaXlUZm9ENXJzUWVkNjlrM3JmVlJEbXFJbmhiVXhkLy9V?=
 =?utf-8?B?UWNpUTlHSUEzd0NpcEhyUEVLeWMzM3hCVXM0dTJPYzlleXZUZk5SU2EybG9Z?=
 =?utf-8?Q?sSGVWL6waa++l0vyuJj3cMwE5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55485ed9-9075-4903-080b-08dc79b5d568
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:48:25.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNbeKKrQAW9kwhG3Kni8Oci0/ifR2BJTflLT9gunHNJvRGg7ciyvjunLHqeIwaYKBj+qzWMneVo95q8IG0AACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7645

On 16.04.24 10:59, Clara Kowalsky wrote:
> The gpiobench was tested with one device in loopback mode and another
> device in react mode. The former sends an asynchronous event to the
> react device by toggling its output pin. In this test state, however,
> the react device always responds with a high signal on its output pin.
> Yet the input pin of the loopback device is set to edge-triggered, which
> is why the test hangs in read() on both sides after one loop.
> 
> For the test to work, the output pin of the react device must toggle
> between high and low in order for the loopback device to successfully
> read a change on the input pin.
> 

So, this is not a feature addition, it is actually a fix, right?

> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  testsuite/gpiobench/gpiobench.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
> index 04c694639..707f35ae9 100644
> --- a/testsuite/gpiobench/gpiobench.c
> +++ b/testsuite/gpiobench/gpiobench.c
> @@ -424,7 +424,11 @@ static void *run_gpiobench_react(void *cookie)
>  		 * latency box will measure the time elapsed
>  		 * between the two events
>  		 */
> -		value = GPIO_HIGH;
> +		if((i & 1) == 0)
                 ^^
style ("if" is not a function)

> +			value = GPIO_HIGH;
> +		else
> +			value = GPIO_LOW;
> +
>  		ret = write(ti.fd_dev_out, &value, sizeof(value));
>  		if (ret < 0) {
>  			printf("RW GPIO write, failed\n");

Jan

-- 
Siemens AG, Technology
Linux Expert Center

