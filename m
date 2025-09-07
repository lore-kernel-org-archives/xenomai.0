Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021079.outbound.protection.outlook.com [52.101.70.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EC315D35
	for <xenomai@lists.linux.dev>; Sun,  7 Sep 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279036; cv=fail; b=BAwZambgPcfEJBY13vZzXKyOWjtwKLe2vnBfZ18+eOaWDSxFAkiQe6GJNeQqrbYml6UUE7EGwo765ED9x0lh8bDwXUHXP8zekfdi/kyaLtgRm2FCGeGZ/3QRn/ZQuLFswORHep0BkHmNvJ4e+LOpsZRx01N/r+vcvKsql0UZOLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279036; c=relaxed/simple;
	bh=EhbI2ihAfPAImNkw/9bHqt7KTp8SdkuIw4i2qBtJYFQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLU06vW6yYSWUwhB5RB7mxUF0x1ZSibX71Rr6PEZ+/G+bkIGGAupTBJf8mh3O34i+MGGKpgPL6Cg4ZbfPzgK3k145uy89Iaf1oG6a0mE6o0xG3KEiWqJK/oVvHs835oXC5BtToImYFrBOPa0noYvcR8s49RGYYsytdNektxrXPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=FtTE8e21; arc=fail smtp.client-ip=52.101.70.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="FtTE8e21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn6866YSB18oePpdluJN2VJ4HenjLaoJ/UozbO3LDpFBq4AkRXDrjorkKgXk4NsuCznpSv/tZZnz1KQ4JbANAcD6ZyybGiXFugXxu+lZdg9u9P2CkcFBYzp2XLYSLAT+kcaSjhxUpgrbcXk+fSK23S/zem7vSVHrYP4A3yxh4GfQYR52+0WQIv0VO3bhTNOa1BLFNBe/wRXw21QqABFgjoSFrA71E9lfsr5M9i6yj6AKU4qOE2XbIUM50JY23nPpqaheWyn6IigWmgB3p2RKhosXywmkH6rzSEhd/FsuhhcuOP0GvcHr5TnAVrHzGRA0XhWmpXJOYM8Ih0yhipWYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SRoJkBeWDKfHH/otxoxpIq39BKz26X0h9kH6zJ4jqY=;
 b=EPk4FSkVBTs6E2EkCnAgS8fjgNXHas8e2Z08BAu2xluVhFwiAgDVhLghFf3JiqZ0/jIU7w+cocXLc+6WnNLgn7V8cOHYt2aTYd2lC91203Eus7p2IM8oGB1ikTDLhMkDjw+9L3Q2ZIHjj3xwumvRv+FmdSfVbOW/suMqvlIiwxe/CpKN0wWoaCSjBXvnDFc2CUGOG0bu+PZrMOSu/UV8cQifyFpy1C6NSThQj905nMqAHgMoAEpSoJxAErYA6Jo4N61T6A9Z98Q9/uSPHH5yfMmjdawzDOSy3FrtCUBNgguMUGcUqWFlbEHJXAZQnYLlsH38bLaHXAiuhHRE2jQc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SRoJkBeWDKfHH/otxoxpIq39BKz26X0h9kH6zJ4jqY=;
 b=FtTE8e21dCXzzM9zys9pVp3/IYZMfiqM9/BBAL2VFWhvyu0h0Jm5odQeejzS/X+tCOh4Z9829cJlFQAeJiaY2NLwjM6A6aLPlQ7Gc375TcpjmV58u9pRZMStwq52NDnp2zrD9/k9vPHysFW0cJy+mAdbEnL8lLwK69zpbF36yJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com (2603:10a6:10:428::14)
 by GVXPR08MB11212.eurprd08.prod.outlook.com (2603:10a6:150:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sun, 7 Sep
 2025 21:03:46 +0000
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348]) by DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348%4]) with mapi id 15.20.9094.016; Sun, 7 Sep 2025
 21:03:46 +0000
Message-ID: <f9092ebe-56e1-40d0-8802-82390a2d4919@sigmatek.at>
Date: Sun, 7 Sep 2025 23:03:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: buildpipeline for xenomai3 docs
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <7e7f370a-ac07-4a0b-bab4-deebb80c2569@sigmatek.at>
 <a25270be-8539-43eb-945d-40600f975971@siemens.com>
From: Markus Kurz <markus.kurz@sigmatek.at>
Content-Language: en-US
In-Reply-To: <a25270be-8539-43eb-945d-40600f975971@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::7) To DB3PR08MB8961.eurprd08.prod.outlook.com
 (2603:10a6:10:428::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR08MB8961:EE_|GVXPR08MB11212:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ec3572-7208-4431-d9f7-08ddee52091b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWVTQzZTelFVZ29nMmdxOGFaSjV5Wk15NEpDMk4vRTNSU2tyRnlVR29wRWlh?=
 =?utf-8?B?MDlNK2Q2K1hXc3lwNTZDSkNaaG5EcmlSM1BvTjczQnhKbElQRjMxZlQwQ0s2?=
 =?utf-8?B?UG1JOFV1Z3ZldTQyTWFRWHR0RTVpRjZ1Z3Q4UWZVUnV6bk9tTTFINVBiNGht?=
 =?utf-8?B?L3JGM0ZwYzcvaEtSSW9UQkdtNytQZGVrTURpeUFxUE5zVDNxRm9HNzRUenla?=
 =?utf-8?B?NXQ3ckJwTEtKbDlDbGtlZ0xKS3Vhb3oyUVN3ckdRTzhMcUN2OEFsWjRpOUZa?=
 =?utf-8?B?RHc3bnR1MW9rUWNwR0tOWkMrK01WVkdIUlpQVHp0OWE2Zk1malVKNXc1dEsz?=
 =?utf-8?B?dWEzZDBoSUNKZkdoR1hQVGNraFB4cjRlODhKcVY1NTBCSjJFemg1aUkvTEV4?=
 =?utf-8?B?NTVXVXZGcVJoM0RHd0RjcXdoaC9DMXFYZUtlMWNzYlphVmZIRW1xWFZaUUlm?=
 =?utf-8?B?ZVhsOEVSUkxqQTc4YjZ3NkM3eUloWVNnY0NRd1dWVGoxMURaUGVmWHBJRU5P?=
 =?utf-8?B?dnpUOWVZUUZzUy95N002Y2FxVktDKzlnYWVnMFZHcGVhSnZkMm1mcHM3S3VP?=
 =?utf-8?B?VUNCNkUxbVpGNDRCYnZnMktHRkZxa2czYVpSakczMm9wR2pRT1hLaFdWMCs0?=
 =?utf-8?B?VHVGaHJKbG8zZjFHc1h5UllwQ2Fsd2svbDdQQVUxK214Sk9kRUFEbHRiM0xl?=
 =?utf-8?B?Y1JZdzd6SkVDcGtKM05KLzYvUjhpZGd0dFlzTkloK3pEWkZFalNyeGxxQ2Y3?=
 =?utf-8?B?VUpMR3ZsRitNK2RoU3FaQkdaaUczSlZsUjgrUlRsMVF1cGlmNmZ5L1ZFbWwv?=
 =?utf-8?B?V0Zrd0pqRld6YnFQWUdnMTd5ckkwczF0ZGltdHYydkxjdXJCQTBxbFoxMTQ4?=
 =?utf-8?B?Rmp5Y0FZcjd3YTFzTVhKY3gxVjc4cnBPUDdiMGcyRVM3aTNzakxnM2luQ1dY?=
 =?utf-8?B?WHl5ZUo5aVA0cko5UXB0aElodVI1MEM4SjdiQ2I5dVVibU9ZSDc0ZXNkRFZ4?=
 =?utf-8?B?MHRCUE5YKzZERHUwQTFmR2hZUWtuYUJCb2NXM2xFa0s2bEU3dTBaNFJNZ2pt?=
 =?utf-8?B?YnMzM1M0RWRHdU1qeUNNakhxQ2dselRoOG4rS2NockVhOGdualloODkraVh4?=
 =?utf-8?B?amtCbFpXbDFNUjhlUVc1Ri9jeDdZaGxlMi91V2pSc25pUnIrMzBqVFBhdnVa?=
 =?utf-8?B?UlZkcmpJMXpRQ0o0K282d0pVYzl3YWdHRlEzUW5UeXg0ZHpXbkQvZUd5bCsw?=
 =?utf-8?B?TTJKcWZ1SHVXN0daRnhJOGcxc2F2b25hTjc4WEloeWlXQk5mNHVESHFxcVNw?=
 =?utf-8?B?MllZQXA0RUR0Mkp6cU1MaUpPdno5aXQ4aWIrbndHMkl4cEw2Y0ZySEkrSGcx?=
 =?utf-8?B?aFp0TGFFSndjZC9NcFA2dktPbFpuRU1MQlFTR3F0bWN4Zm9BbnhxZ2d4eWFD?=
 =?utf-8?B?UFVZL0tTWTJpSFhMWHlneWNSY1hkK3Q2L0d3aU04alE4UHMxNC9hWTArTmRa?=
 =?utf-8?B?dXhndjNmKy9ZazZsSGlaNXN5WldJODJvSURZK3pJMUk1enVjK0k1TlhhWXFN?=
 =?utf-8?B?YXZYLzN5N1ByWWtYT08wTlMxNVlWNFFKWEhjL0Q2c25jNDBqamFJUXY5Rm1R?=
 =?utf-8?B?OWdyOGlVK0x5VVpBUEdFNkRUaEtMV1kzTWc2NllsRmVTOFJHWjc3L29RWklz?=
 =?utf-8?B?ZGtEbVdLZzRJZWExcXNEY1RneVFWWW1USnRGd0YxV01jT1VVbThNWXdlY3px?=
 =?utf-8?B?RzRYTC9GTHRLQS9LOVp6T3hWTkpmSkJKVllzRlVBU1ZPZnJ1cFBjNmoybk5O?=
 =?utf-8?B?blRsdExIZTUxeU96Sno1WXpqSVlNakh4cWovWmRzZkhsL2hnVi9ZR1hwN1Vz?=
 =?utf-8?B?WkI3ek54Mzd0dTRod2RwT1FQTHRVMzdxZlZXN0ZqNnF5eFNNbmpzbWE2TjB0?=
 =?utf-8?Q?Pr2vEVstS/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR08MB8961.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJ4Z0ZNQVZ0dGlFTGx0QjB1UTl5elV2UWM3MkY1RGFKVEhNaFIwWWpoVzky?=
 =?utf-8?B?T09jMit0cjQ2UmxsbTdPWmxHYjlpbUJybXBjSmZXM01kVVZpOE52V1Nib3pU?=
 =?utf-8?B?RnhNTElXRzdtK2djSlVPR2x4WlUxTFBsSXAyeHNtMXc0M0pnaEFLc091bWRv?=
 =?utf-8?B?dG5YNkJ6RlNuWUNwQnkxaENvTVNFUUErTlRuaGk4d3FJSmxTdXIrSE5Kc1JM?=
 =?utf-8?B?cms5MjJZbmJCSDEzV04rbHdzcEUzbmhncG5LSHZyQVhNTGNLc0VITjk5Mncv?=
 =?utf-8?B?NFdtT0NjQW4yWFpZcyt5MnZEeFAxaDc4anViMXM2cXlwT2szQW4yTStud3o0?=
 =?utf-8?B?ZjltdmJQVVpPU1d1MUpVMU8xYlNUS3hFaHJlYklDMnR6OFlrNjZVSVJHL3N1?=
 =?utf-8?B?ZU96OGRMNHFvZmg2Y3JFNTZjdFI3eDZkVnlHWXdpNkhuSVJNREFObWg0V0J5?=
 =?utf-8?B?YTlWNVRzZEV6Z3JZVGpvRno5aC92RUJSU1RBNndNOVRKakNUWEZnc09wcFRv?=
 =?utf-8?B?cWV2OVBhYUFuS1ZYOUV2VllsbTVwQ3FyVkVvaFJsanlmeEFValVpUTZEdDJ3?=
 =?utf-8?B?ZGx3M2JhOURKSDZEMFZKeXZJQVkrdE12M1l1QTNwQnhzcjE3M1NqYk4reDM0?=
 =?utf-8?B?K2RjVG9tYnlhVTdMQ21kSzZLKzVNaWtwRFNMakl0azZHc2tJTVp1ZHlMdUpa?=
 =?utf-8?B?WWtUN0NFRTlHYUtvZnZrbHRmQW5PYklaeC8rd1lELzFTVnp0Ym5qM3dKM1kr?=
 =?utf-8?B?Y09iNHM3YktNTEpqaTkyUC9PdFlBeDQ2YjlOcDlCTU1ZQlNqZldpaEFiMHkv?=
 =?utf-8?B?RStzSmdxR2ZPOTVwYnVrMFFiaTdPbUtMM3l0eVNQMGxrMlFweGplUlhhY1Y3?=
 =?utf-8?B?NnRhRXRoeWtEODZIaFIwazRQK0k4d1lROHVucnJkVU4wQWxoUTY4clBJbG44?=
 =?utf-8?B?VHh2VSsyT1Q2SFZ6ckdJdFhZQXFmTGtoU24zU0xTOEErRlByZDRSMFpBUGR3?=
 =?utf-8?B?ZFU5bmg4RnVxMktZOFB5SFB6YmxDV0pNdTlmdHpxNERDSDZhcmh3cmIzRkRJ?=
 =?utf-8?B?Y3NHMGcrUnF1Um5QZm04L3NEUWNjQlIzcWUxcXhJdlhia3BkN09oQW5NU2Fn?=
 =?utf-8?B?eWRiY2VrelpOUU1lUDB6Y0FYMkgvdHpKZU92REhJRFE4Ui9GSW1OZUJzbXRG?=
 =?utf-8?B?ZGU0WTdsOHQ4UVJUQTBMWFF3d3ZyRGJsNEg3Q1o1ZXVwMVlQSFdIdVhJT3g2?=
 =?utf-8?B?QUNyWDRabHpocnBDSFJ1Ykw3OWFnSlZVS0c3NWEzVjUwZHNPS1BGa2FZZTRD?=
 =?utf-8?B?Ymp2TEVjNjk3T29ZMWhaMENnR2lHM05nclVjdTVwc3NEeWRIcTY0S0FYeEw0?=
 =?utf-8?B?OW0vblV5eWRrK1hiOVB1ajZQS0lENDBXN3VlbzI2VWdPVkpkdytBeThFWFZa?=
 =?utf-8?B?SmRXdHVOSnhScGdwZ2ZJeDJoU010RTdobnZlaHZNVFdFYzZFK1FCQW9HUkJu?=
 =?utf-8?B?azg3VTRNem1TbTdXaFFQOWFXbEplbXFnMzIxSVdhd2hsMWtVSGVBMXBPY2sv?=
 =?utf-8?B?aWU4WU1FUDc2cFJLY0NFbHlWUHNkUXZaUTVQZWlaWmRtL2pZVlV0KzJQVHpv?=
 =?utf-8?B?RHlYc3Y0cytkcWVmbGxxbHpCODNNQjRkSjNWUk9hd0JLL09VV0ZLZDJEUWsx?=
 =?utf-8?B?YzErN29GaDdSVGg0YjU2LzFobFZhQ0pwMUZoMWNYM0xRYThLT1NQMk1nOVpZ?=
 =?utf-8?B?Um1aK3lYQTJSZDVxYWdsdzB1NitxSjk3N3JFUitZUVVidnZvaHNOYUdkTmtS?=
 =?utf-8?B?Z0lyYzEvRFhSSTFobVU2MG4xTXRVZmJOekZVMEROb2tvOXlQWkQ3ZTMralNx?=
 =?utf-8?B?MDdGMnBTRnk4TWRSWGFVQVFxM1prRVBTVHlZY2RNcDdlWlBHWkhySFg3RDB5?=
 =?utf-8?B?VzUwUndMdFNSMW5PTmFaZ2JZbXQrVi9Db01SbnluNHRxQnJxTVVqeFk2c2g3?=
 =?utf-8?B?eFRXdmZ3emtKSkZmbW1ldDU0am1ybEwyaHArMElBSE1rQ1pXTnUrZ2hJS3F6?=
 =?utf-8?B?OGdtSHJxNUwvcTZ5NzhoTjhlL3Z6WjlYOHFWVlEzSHBveWx2VlpMT1pkN3ov?=
 =?utf-8?B?TTZnek8rNFpDeFlIVlpHQ2RpV2RpZlI2OE9ZQjVneVlTWElqSDQ3bisyTlBt?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ec3572-7208-4431-d9f7-08ddee52091b
X-MS-Exchange-CrossTenant-AuthSource: DB3PR08MB8961.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 21:03:46.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IR9N6MDc+trhe9TsPQBgWrSaitO8Kr0kfdHmnjE+SNGRPKoX8KLFDF/GL45pWDFlDSbZdaluJ202+oVYHnlNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11212

Hej Jan,

On 9/3/2025 12:28 PM, Jan Kiszka wrote:
> CAUTION: External E-Mail !
> 
> On 03.09.25 11:59, Markus Kurz wrote:
>> Hej,
>>
>> as discussed today, I'm currently looking into fixing the warnings
>> during the build of the Xenomai docs. Could you provide me a link to the
>> build pipeline, in order for me to check how exactly the docs are being
>> built. Then I could correctly check the errors and fix them accordingly :)
>>
> 
> Here it is:
> 
> https://gitlab.com/Xenomai/xenomai3/xenomai-doc/-/blob/main/README.md :)

Alright! Thanks for the reply. Then I know what to do in terms of 
building the docs :)

> There is no pipeline for building the content, only for deploying what
> has been built as described above and then checked-in into xenomai-doc.
> I think I was using a debian:bookworm container last time I ran those
> steps manually. But it might indeed be worth to create an automated
> pipeline for that in xenomai-doc...

Then I will just use a debian:trixie container with doxygen 1.8.9 
(current version there) to build the documents and fix the warnings 
according to the ones I get there.

> Jan
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

//Markus

-- 
SIGMATEK GmbH & Co KG | Sigmatekstraße 1, 5112 Lamprechtshausen, AUT

