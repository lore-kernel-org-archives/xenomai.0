Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936507;
	b=L6IzVmxo8Guh0SC4iSgKK2sL60S3fzEeojOJgg5pwkVKekiY1st3JpuuGPRx2mRZMPxZ
	 6fpD77tb0thwDS+6zAgKPIW0XVil1Q/yzeZQ4fb9ca+/OeBohcOVg402NbmKdEUC8sBDc
	 4hR1Dxy/N/LlBJ0qbv5J8cFKiiMX8oGrvqs/6rg/o5nJ7W8KQLGJuG5LDCsZpS4EvUv8A
	 jAaiELAjjP5BBa1GbDC982YV4ayjZBS2yz3VXrjrsNapaEVwAOffmaeXf1mkkQ6FmGufN
	 xjeJqaVK0v9arT0uF+IHuoDRM+No1AyXmk1hqHkPsUqcSnjiBEVhZ9TlzRXJmY2djzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936507;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vKV4VJWgUVh6XHUa47Ja64qbpkiipo4OvFJNV2i8Eyc=;
	b=emwKP0U+0PMIgksD3QhykQ5B010FLi3MaXV+M9HsJP5uOQNA7A5+yJNgurSd5YXHhW6v
	 2H+kvarViNSoO7SF88WaL6EADBMtVaEf8sGDtTl73S/n70qICfareCsd9m3kJReIgegv/
	 Xag0LK3ZFt7+I56yS4oZOw8ALNF5FWLbxyL85hUQsdSjI/eGt+LMgJlnPhZhjIn5AUY7r
	 VkyTFGk8ZodrS+JMyD3HSlK/UWxfeH7w8sr1+1unJ15haoYVtdKFDrnnhGyGzAHt8/ngy
	 MNt9AhoBRoUaWZMrvHc0eG7xcnQxiAKRC8BSb9fgPGz82AqoqIc037Z779cny0q7O9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=U9vk+Fr1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.9
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E778606A32C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 17:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E778606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=U9vk+Fr1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViM2hPdR4bbroFwYgAu4apAieHvVjlnDkpQ8W1MSJy9J9Eeor5t9EgIgUsDfK2jW2IudQzDfLoQj9w+vxCAs9tY4j11BEZHpQLTA2q63bZBuCBM88pOR/wDw5ASW/3FAKEWjIsj7twmUP4Pl8ytKa1FWTA0jZDkOOjLxBmMwKLWc+ptWMj6iHACl37EG+EBdvUd7qA+BQhhpE8Hpb9kr0S6zf/hrqdihvBp+ex5uwPvbO3QXBeUXTGR5d2QmLupQgs07y981jBP4o2chv5dNrtALE0NurmoWTvOYMczRp0tKMh5C5RX2473EJrvBZfAhLf8QeUVOmRu3MLLUMrAYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKV4VJWgUVh6XHUa47Ja64qbpkiipo4OvFJNV2i8Eyc=;
 b=TtvhoMnuN4VnHo5GmokMfc1VfGFKEfDE/1cf2vW7guVGKYNAGJ98T86z+7M3CuaB4+GU9yzwSz0zhR7u0Gxq1hYHv19nZesmOwjoXYGQvxZmwZN69n/3/zc/shbjee5YDLJGPTSIibqWB7dGjTv8syDwKp9gWEuNXbCjq/KfIWt9PLF5GTdqzLClrNkY1oD65zT/z0qNpVpktLVgjGTobVnsVOO5xbOkiJ4rFc/o+TfXfaRex734NSYEN8DdRTMFY6vUmHNUqIndzLDDz7SFYUINicgvsvK5iO6gP+X+EG5htt+7XskTPCthMBQDDRfOwP88avrDk2wOL9TsEMvu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKV4VJWgUVh6XHUa47Ja64qbpkiipo4OvFJNV2i8Eyc=;
 b=U9vk+Fr1sjBH/CGAbYOhi3xI3ylQBT+nifBJ+VQKG4Q1YkMGQP6ujxdvFO3PW7XF6OClZkoEMDXU6g+o1dFT1POrTMRSO0adC/AtQ3VZttZW1zK2Xoip8/ouFNS54RdCC6X3kajhDMHxxfaQXKdJ1ic185Z56Ut5aPovTc51mq7sUD5Sf9zFmr/009MCvTJEVTL4omuQsR5psoFDwIRDpzoIUX0eN0EVwv0YZ9gzz9w3VrjlhiJBsSaYGo0iPDlLkUWToHo33y+DFhcoS53kuU873W4Swbd3KdKh/e7BtbgRc3r4dvIgsu6NWF/69gzL7hIezHrIM8w8DaLNAXoJ5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB7086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:610::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 17:28:21 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 17:28:21 +0000
Message-ID: <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
Date: Tue, 17 Nov 2026 18:28:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca908db-8781-47cc-8c75-08df44d02d81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|261009223027099003|55112099003|3023799007|56012099006|4143699003|11063799006|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261021130227099003|261021121427099003|261022113327099003|261022105027099003|261026121527099003|261021123027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YvKBUvkyAtYnFQHFDWPnuscKorLjFArDua8m4Yv7SA7QeYJcr+aGqJMSNWuTd+pPepG34NwBJ/Nkv/XvcZa9KesiF9GsyYa3YrA8YyRF5WuFszQ9SKGJsApGw3hY5wv5Xm92IW/XKXgavjATHujIeRpKS9PfJuxinQsNQA2XLUzn4ULja3T0oDbKDnOeIU6VS6ll62PAnqQGrt0xOYlr/XF+1GsysvVGAzRLy/T1dL/iq9gjwunUU+TACgzo9mk0s44cyrLykbBoTaSmMA1CpLds8mLPUtF0yBFiRb0A09NhE/EF4SypQQ2eQCqApWDJ0g280pbtecJ1sr+1nlz6B97vtgpq+rB3h6NjrIN5L94RTjECNE+mQtNlR4hpRPXT6doZYspwMr+kMpGcIJT7cwNNym9g1Nd3WC2CeiqpAij3sG6oxmqQVntd9sus7CygOvLi3yQPpQvlUpSbLvhEY/fs7OjQwkh0Qo9cAeNwXEQg6qemWieTwat8soJ9HgYJe3nAcIMGEsNo0XUmgkt/lJu/zbumW+U5FZSE0wahayi5sc/PkQrwRjJmz6O0hhzM8sq3kk7CKylZfT6QoI6qPU+u4/jIzpRz9i+f0/4G/TZzKm918H+fGjaUNdWGoQfE9bdLiWzwog9aGCvXgNjM00ngYdqTNLRTnyPpOhfsjj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(261009223027099003)(55112099003)(3023799007)(56012099006)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021130227099003)(261021121427099003)(261022113327099003)(261022105027099003)(261026121527099003)(261021123027099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEJNRUVPaW5LSzBSTUZvVEdROHZPNWcwR3BsNmxWd2FTV1ZRd2tlL3Q0MHc5?=
 =?utf-8?B?Vk1lNkVJU3k1cVJGOWppNW01cVVCV1hkNDJ5dVhoZXFaeWw2RUowYXNsTWVO?=
 =?utf-8?B?UklYd0hNWHJTNzZhRFJqNVJkMUp2MWlJWWR5RVRuYnp0ajI2b2RuNHRIbmdr?=
 =?utf-8?B?Ty9SUUd1MitEazhXUk1xenBTQlZmZ1lITDZBbTU4T1ZqbG1UdktEQjkyN2hn?=
 =?utf-8?B?UTJSRXNQYm1UWTVCM2VVd1VVQ0hQUzFrQmpEdEROYzNDNCtpWGV2Qng0Y09E?=
 =?utf-8?B?bDdSMk1ZektVUnBmRHZyRHlVVzhwUmgxb1pad1ZNeGtGQWpWQWFoS0RRRjBO?=
 =?utf-8?B?MUcyUlQ1b1RYT1B1SUVhNURaeHZUaCtRMVQ0Zko3c2dxem9GY3ZWaE9WNEFD?=
 =?utf-8?B?eG9FTkhNTmVGV1ZCazg2SkZnU1I5VkZHOGhWcW4vRlVwcDZlTkZyby9RalJs?=
 =?utf-8?B?RjgxYXFlbU1pd2IySmw2b3lEcDlSaVVLNXFJMHF5YjFqalFDeUVYcUk1amQ5?=
 =?utf-8?B?OUloNE11Ti96WFg5UVlHSnRXTmc0RzdxRldWMUFTTGdBVVJVdkJ6QU5zT0dL?=
 =?utf-8?B?MEYrekFrVXRRSHhkdk1YR29FazV4V2hOZ1dmK2ZDNldkeWVaaG1RUytjTnEr?=
 =?utf-8?B?dTlJVVliSWN6WnVCeGorc2M1OXZPb01EZENzMHVOWHlmanBXMXduQzhjUDVY?=
 =?utf-8?B?YzJ3VDZ4NXFSQ2ZUK1dZZzF1bU1FS0JSWEVCVjZlNnBaM2pZUnF5Q0pOWjlT?=
 =?utf-8?B?czVMUjErV1BkeFExZDhOUmNHK3I5Y3Z2RUl3UTUwVEZHZVFmZCtSWU9qbEcr?=
 =?utf-8?B?b0I4c1UzU2hDbUs0NFUxaTVFajBoalo0b2JLVSt4UGU0L1FzbFpSVlduTVVX?=
 =?utf-8?B?ZEVyUFdjd1lDZnN6NGRlTDVVZVc1aXhIREpjOThYbE5VajNiK3JwUUxqV1dV?=
 =?utf-8?B?bXE3UE01YXlYR2tSSnRxTm92NHZJaFFHQWpzc1YxVnBYalB5TlpmeFlTYnAy?=
 =?utf-8?B?OExicEtwQmhrS3YwWFRoeXVzZkJ3UDR1WHZPYWQ0RXRIK1BEbEpGeXlsanlt?=
 =?utf-8?B?Zk14NVRVb2E3R1pyNVpnaU9QN1dJOGVVQVZZOHRoVmcrVlViT1N6MFF0MFAz?=
 =?utf-8?B?VFRzbE1ZSy9MMjlHMHVUUkZvaHlwNjVKWXBBWXdsU1N3TUV4bmVGVUVZbGRN?=
 =?utf-8?B?dFJCTGM3ZzJFNEJaWW9vOG03b0UraGkzc1BKWVJqUmRxVXU4ZkYvb0hxaTgx?=
 =?utf-8?B?K3B1ZVlCZno1TGxzK2pOR29zb0ZUc1dvM0x0RmkxeS9XYUpSaFJWSk9lQ1RH?=
 =?utf-8?B?MmxjTGdjaWxqOCtVTi9pTmNTNHAyWjY1Tzg4ZlFpMkxWKzRkTnF6blp4MENa?=
 =?utf-8?B?NUxVS3o2WXRzMi9iY0NudkoxZSs3L2Q2Q002VG1hWjlxTkVNVVhiQXRHN0lt?=
 =?utf-8?B?K3k0OUFlWU5aMmx1ZGV5L0ZDZlM0ZHdHQXRHdWhzeDVWOG9iS2c5cyt4TElw?=
 =?utf-8?B?L1g4Y2NCV0U3SUc0UnZLRTRtYzNpYW4xNktBWEJLV1JDM3Uyai82Y0NNV0dO?=
 =?utf-8?B?SXJLeCtCOUZEell3ZGVHNW9FWXorZFI4R2tWK01wQm9RV09EbnNnUUNZZjdz?=
 =?utf-8?B?dVlNMXFKbmMwVURCaEZNWVZDcUYvZzRlVFhMcVRkN0pCNWF1M0hvVll4R0VH?=
 =?utf-8?B?OENJdTByaHIxQ285bVhONDRuSTFrMDB3SVA4QXZnU3kxbG1Ed3EwVC9aSWR5?=
 =?utf-8?B?amtsTUFQMUlYMklaNUtqWkx1QlhFa3FYakppNmc0Sm5DTzRRUkwrSy9JUXNk?=
 =?utf-8?B?aEh4WG5sNW1pUHZZWnR0K29IWEsyZ3drTG1yeEhRKzM2RG01YjNUZUpKZ0NX?=
 =?utf-8?B?QlE3WEJnQWc5eVRsa01GTDYwL2l3dVpEZWlZZ2V0V1IzKzVUNXFsZHFlTTBt?=
 =?utf-8?B?MWkrMjhMaE85VXlaNUZPK0ZBaVcrTHBrNDhNRGRFb3NJeE15cUpzUEhrV2d0?=
 =?utf-8?B?YXV5c0ZQNEVKZXJWOWozZEpsS1d6NTdmQzV5dWIwWTNsTGRpNXF5YWh5YSs3?=
 =?utf-8?B?NEIxdXlINFZpcm14b2N5TkF6Mm41ZVhieWhFenl6eXB1elIyZ0xJVm92Tm1R?=
 =?utf-8?B?a2ZwS3lHNmJuVjJVc3VkUmNTVlRRVVRZQWtSbjZUQmRBRHJTamFLT0lCYW5s?=
 =?utf-8?B?ZVhKSTZJQjJpUlJBak5URTBJY0dLRmRSNGFDUDdoYlVKckNFZlR0TEdHSlRG?=
 =?utf-8?B?aHlGZ3ZWNFliOHk4WTQ5R0cxSEFOMFFCQXdXakIyd25KWVB4OENnSmJ4enBD?=
 =?utf-8?B?dnMxWVdOeHFEdkxTalJhNHQ5S0lITnNwN05GZTBZbFZQV3lvOWk3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca908db-8781-47cc-8c75-08df44d02d81
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:28:21.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bzj+Wkei1uUApYTMngEvVOAHTR8fpdRdcJ9avX0Na8dvXIsxuwNAZlGyDPbUZjuEWjr3MVKE/N9y9qi3kGysqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7086

On 17.11.26 10:27, Tobias Schaffner wrote:
> On 11/12/26 18:44, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> A thread running in primary mode which takes a synchronous exception must
>> be reported to the Cobalt core by the Dovetail layer exactly once per
>> trap, before the in-band kernel applies its fixup. Cobalt then relaxes
>> the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT when
>> asked for. Only the page fault flavor of this was covered so far, by
>> the sigdebug test.
>>
>> Add a test which triggers one specific trap per case from a primary mode
>> thread and checks that the expected in-band fixup happened. Most traps
>> for x86, arm, and arm64 are covered here. Left out are those that are
>> practically irrelevant: AC for unaligned accesses on x86 and VFP
>> exceptions
>> on ARM. Not yet covered is RISC-V, but it should be easy to add on
>> top.
>>
>> See extensive AI generated explanation at the top of traps.c for more
>> details.
>>
>> This test may become useful for checking future OBB trap reporting by
>> extending it only slightly.
>>
>> Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kiszka
>> <jan.kiszka@siemens.com> ---
>>
>> I know this is huge. Therefore, it is also something that we likely would
>> not have done without LLM support - way too much effort for testing
>> corner cases.
>>
>> I went through it, but not in all details. The tests fail when they
>> are expected to on unfixed kernels, they apparently pass on fixed
>> one, at least on our CI hardware. "Should be OK"...
>>
>> BTW, if we merge this, we implicitly document parts of our so far
>> unwritten
>> AI policy ("yes, we take generated code"). I still need to think
>> about which of the templates out there to use best, then I will propose
>> one.
> 
> Hi Jan,
> 
> Following your input, I spent some time last week on RISC-V trap
> handling in EVL. To verify the proposed patches, I ended up with a
> similar trap matrix test generated for EVL.
> 
> With the number of fixes we can now produce with AI support, I think it
> is right, and important, to put more time into test infrastructure.
> I think it makes sense to pin down in more detail how Dovetail and the
> co-kernels built on top are supposed to behave to make sure this is not
> changed by AI without us noticing when these tools are trusted more and
> more.
> 
> I am asking myself if we want to keep some kind of human readable
> source of truth that tells us how this is supposed to work. If we start
> generating both sides and both sides are hard to understand (at least
> for me, the kernel side still is) I feel like it will be hard to notice
> if the tools start to slowly change the design.
> 

Good point. I'm currently fairly impressed how much the models
understood about the current dovetail architecture by just reading the
kernel patches. Maybe they consumed some documents upfront, but
definitely not while answering prompts.

That said, we more guardrails, also for models that might be cheaper,
more sovereign (local open-weight...), but also less smart could be
useful. Question remains how to encode things best to have both side
understand the same.

> In addition, I feel like most of the tests are Dovetail functionality
> tests and not specific to cobalt/EVL. I think we should at least try to
> find a way to tackle this with joined forces for cobalt, EVL and what
> ever other co-kernel using the infrastructure.

Yeah, valid point. Maybe the availability of a POSIX interface for EVL
will once allow to write more portable test cases or even share the same
code base.

> 
> I think that RV can maybe help here. It would allow us to decouple some
> of the checks from the triggering of the test cases. Triggering could be
> in the co-kernel projects while most of the verification lives in
> Dovetail.
> 
> I created a POC of a more detailed trap monitor paired with a matrix
> test that solely triggers the traps from the different contexts in
> cobalt here:
> https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-monitor-
> rfc-proposal-nofixes/
> 
> Asking Opus 5.5 about a comparison to your proposed RFC it tells me:
> ```
> Not covered:
> - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Cobalt's
>   notification to the application, and we don't check it.
> - The counters in /proc/xenomai/faults: the right trap +1, all others
>   unchanged. That's Cobalt's accounting.
> - The exact mode-switch count (Cobalt's msw statistics).
> 
> On top of the RFC, it covers (checks no user-space test can see):
> - the handler level of the unwind, through the stack frame;
> - irqs off on trap exit;
> - demotion only from task context;
> - no IRQ in NMI context;
> - no sched-out during a kprobe;
> - the time limit.
> - more fault cases: read-null, write-ro, write-retry, exec-nx, bus-eof,
> fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
> ```
> 
> The output makes sense cause the POC has no cobalt API specific checks
> anymore while the monitor adds more kernel internal checks.
> 
> The hole approach Monitor + Triggering matrix is smaller than your test
> while the monitor part could be reused. A rendering of the monitor is
> attached.
> 
> Maybe you want to consider it or spend some tokens for further analysis
> if this can be valuable.
> 

"Smaller" triggers me for sure! Would be worth to see the outcome in
code. And we may still consider addressing potential gaps on top in the
userland. Key is that the userland test orchestrator and stimulus
generator and also read back the result of the RV monitor run.

But what might be more challenging: we would have to backport your
infrastructure to all kernels we are maintaining. Is that realistic? At
least down to 5.10?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
