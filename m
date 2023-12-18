Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB354FF7B
	for <xenomai@lists.linux.dev>; Mon, 18 Dec 2023 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pr1j9Ia1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmq/q5wRYG4Gn6gz+KHekfro35jx6puh8DyLcnpsRLZGjuj4U4+Zp6ZKk4jj5jbEhIb4rLTZPUMiVk15u5yc0KBnBfsTCZVwtx9Si+TRTFhQ2FQ445UU7pVZJIdUfWbkYdHL7mTb8zHwQ6Y2d4EAY1JNLUQvbottGjq9qHssEaBBno/CrmSVZYiOvwO3mCmkSXVD9Qywq7xG/h6NenBQCnph6y58l1RpwMCQ8ReAXGImrkk0czwFmrWBN9fAm2Dr/veoHfHFaDGqDnUDgGJOtZ3sY7/9kRM6RoPNBbvoy0UD8e3eDm24mqFLBBeevhLnh63z8ESM8IsShodG/FKXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkgdej9ScN/HQp9cSWWW+vbGXPOphFFaF9qUmkgodkc=;
 b=JrIIUIGMjePQaui8t9JtXJR5j3Fs7pyXgdBaZRjcbUOdh/4dbl9mXPRTBxdorDRDeDMHoPTPHHD31iE5C4JppzDwpFwGAN7pFC2B2z15mX3C55pmKXlR/3cnukd/nKTm8X2dxI9MftMrBIMKlzJQFhq6N0142rLWUcJtoQfvOtCF3hUT8GwAOv4vuWJJ/FexSZvd2jxVu3csuw1uH1/rKrXTJ2eghNyk34vbTweSJ0KwF/lY76Z7jvtx71zQcvAglv2B939XMRX4taGsCx+njLDmuh4P6S0S+/1hduLdJFOkY6xbAVxourYasU83yyYsgOkdgZ73rA/ktRnsbXviEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkgdej9ScN/HQp9cSWWW+vbGXPOphFFaF9qUmkgodkc=;
 b=pr1j9Ia1rGQtl8DNs99I8mgf7NESflHTMzz7vfAFTK8T0qKnbkKyKlbuTfTsFEyKjV4zm84O3D0iTJCOux2ehYm8CYYpcbCdZ6GMNtusxpy5wvdkpPGOOI3y67ztWdnykpcZuCAAcwPs7piqKKSalitm6O7L/+QcI+AFtV5natlFSEBcdnon3OHQuSETdI9ygDCFNxqmREQj7zjc2EMHNZLXfPQRaHhvS3WUAYzM18Z+jVmuNAFYvmp9QFxTIuQOfROpR0QCSt2KTUJjQGOvRGaTCz1g8PA7CLT108fRoDFKB1+CTeTzbRwlyqfGcSh2AuLM/4dP7uyM2H0PF6cODA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:49:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:49:44 +0000
Message-ID: <e7624208-3436-44ce-b46e-eeb8e73d9f27@siemens.com>
Date: Mon, 18 Dec 2023 17:49:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_e1000e and Intel i219
Content-Language: en-US
To: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>, xenomai@lists.linux.dev
References: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 871c1381-9691-42c6-0b59-08dbffe95649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcHglalEsphDSX3yOV+FfLoyZLb8jNoJuWLjIwe2EtJh81pFaL/SfW7qhbEUIMns4qXnqmO+tQyqg+ylcQfeXNxIJlecXDHWB1/raozqFDhDke9+xcd24Oi6Osow4R2jo1YqrhepTtn7jh2OesYErIYTXTq65amfDw7jB0b73hXNMwS9TspBgSknh10VRy2rm9thF1zOZe0TBgpm+h9fSE9LxFDcnOkxGHC3vHCfANN0JSOJFdheagxTkP94G88oG2BLLdxAL1NwoeMwxuRfvKVu+SmzUwvN2whSx4KzODIUWUQDU9EaoRmrh+5tfkMal/N9nF5754A+OxrTQKlx5fpOeKzwOahJj2rfLivy9ZmxJE/EFp+yI61Ai+Jp2sKI+sKZMqF2GvrloUNs30d4M43y3cfhkRaohITrICqbBEM3/h70NNOvt7jscA332yVrC+1U2upiP1JcE1UU04ZAX7bk0XcuIK5T81f/9oz1eF6xzuhqHsydpIr8/T9TVt+m/vMCAjtyNePAPfv0A9lhaRSKbG3Q5aYuzInerSNyoH7Wv8PErUa0sP7SLaovIu9NmGcju5qlBU0qEpWQyTa5g0GMQRMyAL4w6c2MoxbKt21m2XaeIf1BAMlx/EFvHMzA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2616005)(6666004)(6512007)(53546011)(6506007)(26005)(38100700002)(82960400001)(44832011)(36756003)(86362001)(31696002)(8936002)(8676002)(5660300002)(478600001)(4744005)(2906002)(41300700001)(83380400001)(966005)(6486002)(316002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1dMRThVTzM1aHQycVRxVlhJeVA3MXMrRlJZeEJ3cWJPREU5enhrZEdMb1U4?=
 =?utf-8?B?RlZiWWt2cDFRUEo4MXlSRmVJVVFDVnhlcmhUQVMxUWRDYnBNSS9Zb3Q1cEFJ?=
 =?utf-8?B?UEg2aVFyL2FjSHJqTDZoMXlHMGpaaHpocmRvTmVjVFNYcTVtMFR5b0xiL2RB?=
 =?utf-8?B?dFgrdVpYclA4ZnlubjA2emF1YmRWQ1V2N1l4eEdBUFM0a01BNkxHUldSZDZG?=
 =?utf-8?B?YlgrYmxvM2s4eXU5VFd6QzJjYjZRMHpJeWtQeHpwVzlESkRISHNPZEh4MFpH?=
 =?utf-8?B?YkhiakZSZW9pWjFyRGd1UG1VZ0xLbUloZ0xqU29GMC9tT0dSKzJHUG9Id2Ny?=
 =?utf-8?B?RkpNdW8raDhvSDRDTzdMSHIwT0JtOExpeFNsMlNmV25pUUh2N0FmbE1BeGt4?=
 =?utf-8?B?QVB6QzQwRDIwWXZ1a1FsNGg5b0dBaGw3bVArT0tTWS9YdXJrNWRwU1BTOTYr?=
 =?utf-8?B?STBITGh6VWJWTjBSejZ4OFNBdjZGZFZrWWFtNnhaWHBLd2xpdHc2MHU3S2NC?=
 =?utf-8?B?R2VwYWw3SVlTTkh2bTNVR0hzTEZSMkloMXQrUXNScHVqQUNBOFJQeVB6RGxP?=
 =?utf-8?B?SGIvZVRBYnRqMFNGUk1EMVYyQ1NrSUtVVHNkQzM4YUVnMHRVcUxseU11a25N?=
 =?utf-8?B?cGNMRkpNQ1V3NkFWNGJSbmp2cnRvVnB4dHFTdlBTT2VJaUppOTFtRVFQYi9n?=
 =?utf-8?B?SCtDeDVUYkhEMHdUUTZ3d012dG1VQTlRN3I5bXREQXVjS2hhKzdBY3RXM1Nl?=
 =?utf-8?B?WkwxYmE1ZUNxS0UzU3lTUitqMFZpQ1V1ZFRMdDE3Ui94cnVLMUdmMnBzcGcy?=
 =?utf-8?B?dkduMTFENWZDZXI0ckJqSFV4NklhVlUrT3c0aVN6alg2OWh0RXVTTWg1UmU2?=
 =?utf-8?B?blRWSzY3cTNzYjArLzhyQkNGRjlSandKVEZLKytjMzVUM3F0alhtZG9KQ0wy?=
 =?utf-8?B?MFpvNlQrSDN1UlFCdW93NG1LeUFNd3RWbm05MFpENlZybDQ3VjhyZXFiL0hN?=
 =?utf-8?B?SnJ2Vmh2Y3dML0lhNTJSY2tQR1FTbUM4Ull2TklkMFlrbG1pSlJYTEx2VVVZ?=
 =?utf-8?B?cUZ3OFFMVHhNa0haQW9qVkFUS3kwTEwxL3JpdnAzRkQ2TklyY1dpTEQ2VjJk?=
 =?utf-8?B?VnUwWS9hUXRoZHJuNE9jZE81NDJmeDEwa21UUjFBbkFTbzR1QjBBeHQ2NnUr?=
 =?utf-8?B?c2d2YUxTdmh1REVidXFTcnR5Vjd5WCtYR0V3RERmRFdqU2g1OFlvcTdCR1dw?=
 =?utf-8?B?cGU5dGt4VXBjazg5SU9kL1NIMmQzWTlkUG5TeVVyQ2pVM3J3ZWdaNnkzZE1h?=
 =?utf-8?B?RHdBVGxqN09HVWRZZG9neU0vRWxROGxkTnNvSzVOc09jNHJ5dTdKeGZ5K2dO?=
 =?utf-8?B?Z2ZadmFYaUJIV3ZTTjRteXBvTC9tc0RON2NVaDdMWXVVc0xKM2QwN01sMWZl?=
 =?utf-8?B?YzFEbVM1TWZzTGZrQXduRlExbktUV29RUmFUVjJrTDd6OHFEQlVFMzJjWndq?=
 =?utf-8?B?dHNMS3gvVXRyMlVQWEZxTU5LcTdpKyt1ZE8zL29sdUp2YVhJRGUwbFlFWTV4?=
 =?utf-8?B?TVI5T2dYNVNFMWFIQUdMYWU3M0xVMkY4RTR1SG5kQkU2VitFKzlPdDV2YzUx?=
 =?utf-8?B?QnRVSStCUHR5TkdxQWUybWtORWcrUHd1bjlwQlFRMFJuQ1NKWmdYSnFHUGtD?=
 =?utf-8?B?WnVxT1c1aFZPdDNvNGluS2dnenQzdGF3Y2hoS0Y2aGFiOXFwbHRBWXNKUjRk?=
 =?utf-8?B?dkFHUkRXMk1PYUpEcnJqWkZvN1l0WVVYVEtQQWhXOGthZnNQT1J2U1BmdGt0?=
 =?utf-8?B?RVZzY3MwZjByYUdBeE1FT0lEZDN2bXpVaWI4a3pJckxQM3g5ZGJsMWQ2bnBB?=
 =?utf-8?B?OHZxKzhDQUFQcDRER0NGdHo2cDlRVCtXK01PSUFSMWt5WFFuQ09selRtR3FN?=
 =?utf-8?B?aGF6K3dJZWJUVWNoOXdxMGRJUndReWw2NFpGVVNnZ0JXQ0xmQmJiSndIWVd3?=
 =?utf-8?B?cHFJdlh5bE5RZzVZeVB1Z2dvYWZEK0NPdkVpYzIwMm9xMVNMTWhCTTd1SmtI?=
 =?utf-8?B?N1p1UGl1dVNMK09iTWlwYjYzOXd0OHQzOElzRDc4YXhjdzc3Q2JUZHRvbkxU?=
 =?utf-8?Q?ukf+JgyV9gJvonQwS+CSxqnJ7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871c1381-9691-42c6-0b59-08dbffe95649
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:49:44.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXYwJAPKqxgDrcV86tFRpw85FwPAJTXAdYWTm0U74IADs5GRUlMVtreFDuvnOz5wG3pdMiQg09oX1R/3go5G8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7810

On 18.12.23 13:33, Tamás Paál wrote:
> Dear All,
> 
> The current version of the rt_e1000e driver does not support any Intel
> i219 network device. I found a mailing about this from 2019. This one:
> 
> https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html
> 
> The "unofficial" patches (created by Gino Strobbe), that upgrades the
> rt_e1000e driver should be there as attachement, but I could not
> download it. Probably when the mailing list had been moved to the
> archive server, something happened with those attachements.
> 
> Does anybody has those patches? If yes, could you please them send me.
> 

I'm afraid, those are lost in the unfortunate settings of the old
mailing list.

But given their age and the source kernel, it would be better to resync
the driver against a recent version anyway.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

