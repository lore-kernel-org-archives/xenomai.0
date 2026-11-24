Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534709;
	b=iitA2k/rQKUCLXtEv/Ar3j+mdCci9+J8sURfUsx+hkd+BJ7z9nFig1fshbaxspomat3u
	 S7iFCxjFCodS7kXMXumgermvFragOPluGiJTdPn4a26K1mNg/18mJCibXyFM9KCGNEXoS
	 TSurOhcDmojzGGszYZxAceHVrHoSbbP7MspVx14EcS/FHcVn+cd0HHUmOGJsRgS6mrOSA
	 4/6GJeFonFQN5lBjgrlHuLa2oTZNcq+jn5c4Mk11y64wnsyP5MoIcpgNoquRlFvSxHeHY
	 Kd/gmBHCOcTJH7zq85lBqc3nj37tmQCPzj5aGahKIfCoYAn5by0ePP8fRBDOpnHpIAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534709;
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
	bh=E9yVUjnn9TLi0isYTMoGTQYsR/RLJv11BDmQphvkX/U=;
	b=E4SFqPbgqZJ1P4PHxuqAd4BJQeXKjFXrlFHcVnYVfvcw5eZHc7bQOKNkO+B+yX51OIFm
	 CLK7imwdiwOLm97V02tYgHcI9TrLxX+nvq7IAyg1SqGWbIML5sf/un49zow/qZn8qKNKS
	 gm8XqWExO9XN/9nwvLZBESOSnsoCwcg3BVglvEXUx2mWCvmJTOCXwAXS+z/kergJTJFkt
	 JIrC7hZ7M60DG+JP/5DwKBkEgY3JlziIdBbTepW/Z3B8wziJBdA8n6MR6Iqu6299sqvdC
	 dGaw0auph6DzEomvPk56wVXszccR87erhHvHcGARamR0JVVt7HqLcpv4d2CLuTvU/5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZYxZ09M5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.29
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC1606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 15:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZYxZ09M5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whN5Wd/1TzoSdTb5TiYV+JzmEufPYq2o73My0Go0XFW6NezHEbyyVXFdLdq2uYSiQLv08AfE0cAIz1O5gd7vEg2+OLA++7KGaWXxpy+phV7VyO6L9bD34NoZyOaeCEJCPcqpumgGM1uHr2kDH6M/BEuf/F6Fky71usgOuzdjvkoyurKFK8mwpihZ9H69jFeJ+WeCLd6pLCo6LLDG0cjctdQmtRKZ7RhkelAjeOZ5+epgXypazM+zC3jN2ICNMV7Jb5F4Jd7HdtPobWUEOI5wziLhvLWFCjxspsHbHym83fkVOEZpEKVBxqpqAHdi6zib232q4N/OlDHK60xABVQCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9yVUjnn9TLi0isYTMoGTQYsR/RLJv11BDmQphvkX/U=;
 b=aEEtJ7/q0PuwjJwdwTdsbH97TT2hLJeqaTx14sQXAZyKxZCC9zxUv9pan/qSco/bf0AoGCRb1G5uDLz03C780yar4SrKUrMWeXUuIWKfgqUrf2YNr2dbxj+2MxBU5A0eCWuhGxNqvu3OkNjGR47A5iQV2LwcTC7BI0kvrfGwEjeicufNDrZbvRf8IyNQbqnhWwUoPBBW+6/h2WaHz/N7a5Nia0TJoROCV8/Vht4BTjlDUSkk0zCYbw7EfNnCdwvz4d3WzigLP/m4IMprt/8PPUVUG1OBWns676ol1M+TDK3/FpEtyRj5UcHlJ6XxeMZxNxi8v1NVoVJvogNTFSkDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9yVUjnn9TLi0isYTMoGTQYsR/RLJv11BDmQphvkX/U=;
 b=ZYxZ09M5zmhNy/adVWYYmaO+dutsnf7dqlJ/mp52QNTUNMWf11pLgdasX774CSfUqW0Xv+GFJPAnEXh3/bqTDDh9YMlTTMKjprMndpICdSzFVX/SQ0RAJiBeantRw3T5xkcgjbwhz1da1adIv5Sn5Z84c2jcanUKqWNLPcs44Dn1hMF5OYdsHKUs1fWbWnPW+N3M47l++GuNo8NLnwm++yJHMP5aM+TyheO3tSaAIuEGGCp+K+rC3Y6nb5KRHEAV1coWvoRLb9JXVuHhkQFtlujMtvrgiSosf875Ft+h4OeQeSN3vqdsRmiE7mNuAdPnMubt2zIqjMKD7fIGCMMHiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB7754.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 15:38:23 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 15:38:23 +0000
Message-ID: <60924e31-7fd5-4edf-96df-e2a8d5b12de6@siemens.com>
Date: Tue, 24 Nov 2026 16:38:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: Let __STD() and __RT() of mmap follow the
 off_t redirection
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <1207-6b05a780-75-3e404bc0@80415301>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1207-6b05a780-75-3e404bc0@80415301>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c461b6-6dc3-49c8-4367-08df4a40f93b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|18002099003|22082099003|55112099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	PIg8TuPZH5byuj07uoFgMRelBD8fEIzq45ZMVcLoRs9S3fcJx2AxHBWfRN1gReaMByUYVHwg8W6D/0VhQYbcjJeAn5/Y3N/GM99CsyKs8DcKKayXOxUh2VBjSZYS6/6axqqz1Iog+24jjLFH7N90vApuRbAZvFBIUtJmduIvJDx2M+JFh4VsNCkrn7Z2V+aEmDZraZ3BnYji4zx6NOE51tEjxirUQoPyg+RmlMwmMSB1kcwEeMF7kLnbUh188LaXDLEr3wf/fms4cSzLg7G1E40LsyT8osDV3f/yG0g+iT2/17e1+VJ/z/N3lpcNDV8PDlrgbb44czXurYUYZbQdvFWvNgEQk6bT/nr7da4cxBqKskAAzOntolIMzX71Wj2irXfdocfg2vsdeyoDZ/TuDL7ufBLmI4WxeGFBWlRJuRyAQwB2m8LAVi6qi6Qg6hba3OIrrHfA736hTWyZ9cbD6jC2dt9zacLdEOVt3cSYwpbgz4H3A0islaGmlfH1tsbmxV7UJlfoq5ZEvJUFfMmJ99AIleXZrpv6bFnLhXI2NxnHf4YomzDTp+ETwIhCCrXWa97nucPcGm3JFNVe2N2gL58zy4IUVrIEJlpApyH2zzDC1Kn02eGoQDYHSpX3WleRXft3H1paUNFGUgnP7d48f2Na5k6tcMnihqBnMUoNdB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUx3YUJQdnp2ZzNuQWxWdVFvMW82T2R4UmxXMkhadEdUOEFnRCtPbmhvQmo1?=
 =?utf-8?B?THpyejI0REY4MVFpZ0xJaUNySkpianVmQ2pqbkxucGNBeTZ0c1hManFCMXpT?=
 =?utf-8?B?WWhYWnNCV2YzVTBYNFo1eGVnUHNUNldhVms3c1UwK0RMN3JjUWtDcnhiKytu?=
 =?utf-8?B?QjdQY3NZL3NxS2Y0YVphR2p1K3RRM3Bzb1BOelJnYWJYZWwyWnpibmVVQVBV?=
 =?utf-8?B?cWY1RHdDbWRiWXJvNHhOMUJFZy90VG1URWFLWEN3QlVCRlZaOVE0SWNEMmJP?=
 =?utf-8?B?QU5BTHNaNTdCOTFXbnRTSHl2RTc0L001RDJKNTVxbmVXaXpRR3FZZVMzK2h5?=
 =?utf-8?B?OEFTU1p2SkdsYW1HMGptSzhpVzZxVlVPMUNzdnQ4T3hHbjdjdmc3ejJwSkNu?=
 =?utf-8?B?and5VkRXTnliQzhDdlQrRGlBejU5ZHB6c0pTVkJvRVlSVk9nSTE3c1Eva3NW?=
 =?utf-8?B?enhScVRyTmlJVmZJTXZvU1ZoRXF4RUs4Q3l3aGtsTmNIYzRSQlQxWFpBUkM1?=
 =?utf-8?B?YUhNTEx1SWJMZE13MmZLbEdhc01oZXcvSi9jaDNlY2xQaEJoRVBaeHRVdE5j?=
 =?utf-8?B?K0tlMTEvUlRpZFZKMWNFYTA1VWdOOUthUTJtV1ZvdWNrRXA4N2pFRGRtT1lL?=
 =?utf-8?B?ODdsNWs1UE1PcTdyaVdPelpOTjlPNnlIMERGRXlsT0pmcG9LeTFqcFJsMEY2?=
 =?utf-8?B?bVJvMlFEanZXdys4ek9rMHRQdlZzWVV5Z0FabXBzN1lHdk0vNEIxWXdJUE1F?=
 =?utf-8?B?R3MwVnVFbFpHK3o5OUE0U1lCNy9odHdscU1rejlhYkZyY09ZajlJZ1dOS3c4?=
 =?utf-8?B?dXZnS3J4OE4rSXNHTzlKZHg3Z1hwT3JSM3BjQXBhendDSi8xRnY2bE5GV01p?=
 =?utf-8?B?R1dGYVFYNWNzK284Rmx2YklkNy8wcWVrQ3IzMkE5TzVrdUtpQUNUY1diYjNr?=
 =?utf-8?B?NVl2R2xKSDJzMnFaMVVrQXg1SEl0M2VnNldJaitXTGFTUGZFQ2xzb2RUY2JU?=
 =?utf-8?B?cGNEQ1hCTjBnZkxEQnVGd2ZrUTM5VzArYmFrRUUzcmpvU0tBa1lNYUdFeG56?=
 =?utf-8?B?eFNoR1ZvWlI0OElMRDF4QTZyTzV2aXp6a0NIS0ZoY1JtNkd5cGtyaWpmSzRU?=
 =?utf-8?B?MWZyTFJ3M0NwSVY4UWtIT0xHZmtkK3BqYUh5TGFhait1MGdqYkxzc2JhZk4v?=
 =?utf-8?B?Y0Z4ZVhMQ3ZMRFVMb2VJNnVsVmJHTWRBbkh0VVlsaVVjUWo3Q2YwbDkxb3NM?=
 =?utf-8?B?NVpLS05palozU0Vlc1VhaEhBbmhwWWFWZ2FnbUlNN1lEa1hQZHQyTkt0a2Ju?=
 =?utf-8?B?OGJZY0VHT2hod284R2diQldseTAyZkxxaFl6K3oxdmVjdStHR09BYW5rdy9i?=
 =?utf-8?B?azF4TFIweXd0MWgvdG9NUkIwRkRGcXpoQXlEQjJFbm9UU2V3OVRDeXRqampU?=
 =?utf-8?B?TXhzMFhLSHRHeHcwWG83emtqVldnamk0d0ZLNjFnaFkxTHI2WmtBVDRSWjNI?=
 =?utf-8?B?Y2J5OFNpN2FHR0dJMDMxcndkSlRQM3Azcjg0VmtkV094SjdkeFowWGlLWXUx?=
 =?utf-8?B?NTJoUEFzN2VuQnRkay95TUx5RkxXSENza1RJUllGOHIyQU1kbnVwbGRWYmR4?=
 =?utf-8?B?YWdqM2EzN2U3QW1rL2E1b0daY3ZIeG93NGdvTjJ5d1hLcnB5NXQ2M0JYQ3dL?=
 =?utf-8?B?aUwzb2JQaGhheWdsWi91OEcxcmoyeE5oc2NLOGR0clFlOGxlb3RSL1Q5VkVm?=
 =?utf-8?B?bG9ncnVrS1d4OEZRYmQwN2IwbGdPNVJDcnlYVkxkT0dDem4xbFF4OWlXK01j?=
 =?utf-8?B?K0dqdms0Tkl2MGcxRUtySzBOa2E3ZlBncURMMXdNOEtEdjdHRFVZV0FMdjBH?=
 =?utf-8?B?em1KQUZlTHduOU53WW1Gbld3RC9kUnVvR05YVjQ4Y085NG02OCsxSWhBMUwy?=
 =?utf-8?B?NllBTkJzRTFDemUzckZ2dHpiSkJDZTFjV3BUTmlVaUwxZUFpdXlQYTRjYW9X?=
 =?utf-8?B?bDJaTDRuQ1lYWUZqOThGbEY3akpYMVpzT29hdmFaRFFZcWZUM29lNEFhWTJJ?=
 =?utf-8?B?YmpKT3d2VlN5VzFZSjIrUHU5ek9RNXJlOGZLZ3dyQ1FHQzY5dFR6UnVpNFZW?=
 =?utf-8?B?WkdiMGdHM0wvU3lIbFFIUVZjdSsvWEkvOHhvbTFERTQ0dXVXTFA1bWtWenB2?=
 =?utf-8?B?YXdEK2ExbGlhUkZBQ09wYUdXck45d3FRc3diSHY3UmJxSEYvaTROaG43dzRu?=
 =?utf-8?B?dXBOd1E1S0M0VmM1dFF0RFR5YWtTWVJoN3ZEekZNNVZHTmVwNmJ6b1NaQ25n?=
 =?utf-8?B?L3ZWMExNbDhSOXRtV3NMeStteWZSYjZ0cVlCOUhFbmpsYnhoM1I4NTNyN0lm?=
 =?utf-8?Q?rzHnn/S7KJS4JL1k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c461b6-6dc3-49c8-4367-08df4a40f93b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:38:23.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xP4kFgc7/FcEBDjMlsUffUtaRjHGAUN2K76omD5tqDi3AgazIzBfbi/yrA0cZFzTZ21c3agnLjg0HdCIfNC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7754

On 24.11.26 16:05, François Legal wrote:
> Le Mardi, Novembre 24, 2026 13:59 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> With _FILE_OFFSET_BITS=64, glibc redirects mmap() to mmap64() on 32-bit
>> archs. Applications get this setting by default since y2038 support was
>> added, as xeno-config passes it along with _TIME_BITS=64, and some
>> toolchains even predefine both (e.g. Debian armhf). uClibc-ng enforces
>> 64-bit file offsets unconditionally since release 1.0.58.
>>
>> __STD(mmap()) and __RT(mmap()) do not follow this redirection: they
>> expand to __real_mmap() and __cobalt_mmap(), declared with the 64-bit
>> off_t of the caller. But with the Cobalt wrappers, __real_mmap() binds
>> to the libc's mmap(), and __cobalt_mmap() is built with native off_t,
>> so both take a 32-bit offset. They read it from the padding word in
>> front of the 64-bit argument and fail with EINVAL or map the wrong
>> page.
>>
>> Internal users built with 64-bit off_t are affected as well:
>> cobalt_unmap_umm(), the pshared heap of copperplate and the TLSF pool
>> of boilerplate all bind to the native-off_t __real_mmap() of libcobalt.
>>
>> Add COBALT_DECL_OFF64(), which redirects the __STD(), __RT() and
>> __WRAP() symbols of a service to its 64-bit variant whenever the libc
>> does so, and use it for mmap(). This relies on libcobalt providing
>> __real_mmap64(). lib/cobalt/mmap.c implements both variants and opts
>> out via __COBALT_NO_OFF64_REDIRECT__: building it with native off_t is
>> not sufficient if the libc enforces 64-bit file offsets.
>>
>> Reported-by: François Legal <francois.legal@eventlab.fr>
>> Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
>> Assisted-by: opencode:Opus-5.5
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  include/cobalt/sys/mman.h |  6 +++---
>>  include/cobalt/wrappers.h | 15 +++++++++++++++
>>  lib/cobalt/mmap.c         |  6 ++++++
>>  3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
>> index e291f50ef..54c028ad9 100644
>> --- a/include/cobalt/sys/mman.h
>> +++ b/include/cobalt/sys/mman.h
>> @@ -28,9 +28,9 @@
>>  extern "C" {
>>  #endif
>>  
>> -COBALT_DECL(void *, mmap,
>> -	    (void *addr, size_t length, int prot, int flags, int fd,
>> -	     off_t offset));
>> +COBALT_DECL_OFF64(void *, mmap, mmap64,
>> +		  (void *addr, size_t length, int prot, int flags, int fd,
>> +		   off_t offset));
>>  
>>  #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>  COBALT_DECL(void *, mmap64,
>> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
>> index 6d826eedf..9dd022a75 100644
>> --- a/include/cobalt/wrappers.h
>> +++ b/include/cobalt/wrappers.h
>> @@ -45,6 +45,21 @@
>>  #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>>  #endif
>>  
>> +#if defined(__USE_FILE_OFFSET64) && !defined(__COBALT_NO_OFF64_REDIRECT__)
>> +/*
>> + * Make __RT() and __STD() usable in combination with off_t related
>> + * services: the libc redirects them to their 64-bit variants in this
>> + * case, follow suit. Code implementing the native variants opts out,
>> + * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
>> + */
>> +#define COBALT_DECL_OFF64(T, FN, FN_64, I)                                     \
>> +	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
>> +	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
>> +	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
>> +#else
>> +#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>> +#endif
>> +
>>  /*
>>   * 
>>   * Each "foo" Cobalt routine shadowing a POSIX service may be
>> diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
>> index d30b1722d..bf8772f6a 100644
>> --- a/lib/cobalt/mmap.c
>> +++ b/lib/cobalt/mmap.c
>> @@ -18,6 +18,12 @@
>>    USA.
>>   */
>>  
>> +/*
>> + * We implement mmap() for the native off_t next to mmap64(): keep their
>> + * names apart, even if the libc enforces 64-bit file offsets.
>> + */
>> +#define __COBALT_NO_OFF64_REDIRECT__
>> +
>>  #include <sys/mman.h>
>>  #include <rtdm/rtdm.h>
>>  #include <cobalt/uapi/syscall.h>
>> -- 
>> 2.47.3
>  
> Hi Jan,
> 
> I think this patch needs to fix [1], as it is not linking correctly (at least here for my arm target), because at some point, __real_mmap64 goes missing while it should not, because of the #if mmap64 != mmap :
> 
> #if mmap64 != mmap
> __weak
> void *__real_mmap64(void *addr, size_t length, int prot, int flags,
> 		  int fd, off64_t offset)
> {
> 	return mmap64(addr, length, prot, flags, fd, offset);
> }
> #endif
> 
> François
> 
> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa712
> 

This is on top of next, thus includes [2]. When backporting to stable, I
will include that as well.

Jan

[2]
https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/c3aff1938e31cfe81045decbf40dfe6d6e1b2207

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
