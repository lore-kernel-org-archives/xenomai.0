Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FD334C0D
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050097; cv=fail; b=W7gMTntgVLJ1xcCrsqpM/R1imWNvlMcva5PeTWAmRW6ivRfYl3cIoPHJK7MRq31OFLHw3rZWjpGj1RfE1NUshXb5UEcZ+kiBXQk49sIYT9+79Q2tsO4pJQQ5UZNqQOziFZQbZy/Hnn79pn9AuRpoAc7ajEWi+41lB4j7oSOQ328=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050097; c=relaxed/simple;
	bh=M2n4Rmjy1MBlzqljEPW0eP9yiqdtXeNJ268zsSohifs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqsR/DY1HzNBD5lNUG8OjMbq1or/0nnn1Epz/44R3SPJlKz3Zchnp3qOJmbTzn4onLF3efJ9OjLn+jNTa0kKkkTkSlUcWk0qqD0kKSkUMh0rKNrlqCoubB1cRNcEVxi+7HLjuKJK5g+cMzja8rXXe+cN1MCoii4DW7UfwPynWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FziRFsfp; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FziRFsfp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTbjgmKMycjDONcN+r+XJ97gjuxM6FDHj2Tt1UxXwmaTDwq04RhH0lmwPwc3uo+ocPHTvLGLEMwWn/7KhLRL3gxBJUw5mW4nJOE7vzXLc+9Ni4lvRvEUapGaOSRFJVQ+ivakVY+TwuQSgVZav2QrSytoGykP7Sj3zCKa3l7lc8mlTulDdlqMqE36ccYNT3/ZbsuUq4ISVWnACC5+QpTUTXcI88qaXnfBLVf0WZ55pRF+WItme4lxct/bEGVL6VhsU5O9gN8dv/UgChgyILHOM43lnQzHmNY/IuDMWwF8T8u+2Tp/c2nNP/mxqJZrGL7uq5Us4flpYrctebWAiORq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D1COhd+8hy2a3Nbr6aPEgkUylwsuJ38NlFfB6XHF2A=;
 b=GWH1Vv0x8r9MpsOmKEvtBk2Edd0vJP9MgEnmD0GWWNl6VadvsfSrtIxyiLgXcc0LkgX2vj9Ud/2sZ2EsNVbjuCYvJYCK0UAP6Cyqx8DtDeN+FuaZWP512/GyKS48Glms3i768RZOn0TkPgr5s85Y1fjKMl/4c1y4APRa53WkEIJNFlkpET3djNtH0btHDF9HCqnz+SZ0Y2U9g/Orri645dMR7ksM3Dh2uBfYMckLJ9wEZiQdWm4T79+HBDHw1Qm0pObVzmJETVgxUb2HgaHjiDss5JhAQtjH4FWJuMuB04aGZnN7eHuiobRaP4oaEI6BYQQ2jDZ/zcHQnKIRjMBOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D1COhd+8hy2a3Nbr6aPEgkUylwsuJ38NlFfB6XHF2A=;
 b=FziRFsfpMT2F1pSoZf++xTubdrGWewbbI31BQEP+NxxvnGlijgDu8k+nlpL4eq7W6HvABUCnYkRFSeuV3EYDi99BEfHZs8lFOuVrVbLUqISHabfM8WIuloWiL/Pf1z7AIFPXP8T3+PHGe4hw3m3G3LfrTOQd7crndIbo8CKpcyQlrV28N9s9kWdhzhG1FIXNNokC8CHUf/dEuopxr0vCM3cGQ7i0//9OX2ap+8K+ebCNYCXCMxzMBtLZhDn76ldMElcIdLlt94wOsbp7DH4YvTxiHubV2CFDJMDK2FnLYpcG2b4Se7o0B7DrvYLr5wQaMeykft995tTaN1TUBawdEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:645::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 10:21:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 10:21:33 +0000
Message-ID: <030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
Date: Fri, 29 May 2026 12:21:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
 <87bjdyil4u.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87bjdyil4u.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3c67f0-13c8-40ec-5db5-08debd6c0e7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eoUuGAv/Elkrz0b1dOZ811v+gPSWRgHNuRCtiyLUoCdWkXC+BrtRmUBSAz6f0nDeJ5TaIDbUQpRr33FGHDIxdVxjRgc+AEUZ/pZj2A7wZqEoUlC8QHMS2lcr46fMjyRThk0P6Z5LR7GFoqUzVGSUbYT0WkDZtDFqwweuTBFyiYOPA/OZF6ym5Nu6zM2JeciTKvd2BE3JaC3N/hFE2CZAaId6JUChKeXfGwmltXWDqTcADSUjRMMJKcAVYznnXF3cVddBJ6dDWKYlh/w05Bc6DHNXIGlFbAezOlnRVQQyiqIImuVemojl53FTMhy0R1Xwp2xwg11G7QGeo8bkXRGta5fzdv2Zmfx7bIINSfDivWY7cvi/1y278kQRcs3VH/SjUwS9xeHbFGicsoXDylk/A3328pLeT9JK8g19WrLwiQeh5V7/ThxgVWbAjuwWaHoBAWEIudjg3JjlGYoyI1agAZX1/mc5CD9L1f6PYRA10a9vwU2bZbaYrg3pR92KixyQsI/k0D4wNsUnblZ+CoFt5ToCVtnLLnfMMslAU1orOjbtk4dbxNs0MoDV57DrJvH9pk54VuFuSEx8ILRI8x7CAtC54aLLNFgyP8usQ6CoaGmILN8p/wEtJlsFttrV6gZi3Uv42wtmsd/yyuJgiMkPyvl8umkb8Lp03fxSoDrp1g6Fiac25rsVmUfgC9+sGT5BuNy3lKolR//7TRCIBlSsbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czREOGFSaEZBR2NXTG5RRThjdk1tVXR0U1o0cDlhYnZSTm0zcTNveExlL21F?=
 =?utf-8?B?bUUrMk5PWm8yVzBvNjhuc2pvcmtNUEgrZ3hjUWF1R0dWakJjZjJ0WTZEUTFt?=
 =?utf-8?B?UUNmOUowV2FockFUL2ZPQjg2WUlNWGt4bHYzRmpOUWlSVFpDRzliaDlZVUpX?=
 =?utf-8?B?SmRoSkpsMWZWcGtqN25jMUliUGtva0syeFNvbFRKTkhOWEdhQmNFczNSNzNW?=
 =?utf-8?B?YTE5TFhOZEtSdUtMT2FhOTd6QXVzaGsvckZ4UFJrQ3pkd2h4b1lZMCt6Mlda?=
 =?utf-8?B?ZVBmRklUcGFLb2RDd0FlRHdySkt2aitnSzBMUW9BcG1WL0lydEplRkVla09z?=
 =?utf-8?B?MEtIaXB6NHJjQVZGMFA2RGxOeHZLMHpsSmNyYk56dElUVE1HRVo3ejJiL3ZQ?=
 =?utf-8?B?bTcxcXRmMktENmhhQ3ZXQjFWTnlobjkwUER3Uyt0RXkvdnNjUm9acExKY2ts?=
 =?utf-8?B?NFZUZ2h6VlVsbzZ5dm5NL1kxeDliVVdJTEJvSVY2SDFEaEpWQVl1am1lSHZM?=
 =?utf-8?B?YWRrMVVmWmRXay90cEFCTlE3L1hMQ0paMzlNdFdZNys0Rm1kc2d2VHVGMjFO?=
 =?utf-8?B?dHQrRjNqbko5VERqZmlGNVlwZlRmRlM1WlJMSFVqbnE4MG04TVRxZVRqOHhk?=
 =?utf-8?B?d1UreExZNk1Ba3kwN2hXbC9nSy9KTXA2VXBqemtxK1VpOXpEbG9yU3FJSWxT?=
 =?utf-8?B?QWVHc3NqNjlnVGU2SHNzVUNUMlFvTjAyNGVaeUJFanVpcjFOd21QKzVxL0VJ?=
 =?utf-8?B?TytsbnBJajg5aWpjRnpRcXJLckJteU03U2JFQ3FJVGlNWTlLckUvL0xkNXJK?=
 =?utf-8?B?RWcvdnljdUNEaG8zWU5OZGNQVU0wOGlmWFFIT1Fwd2ZGVXdSTTRXN0tLam1Q?=
 =?utf-8?B?R3BtRGN6Tkt4UmhnLzFNZmhWS2lGTXlwVndqVU5UenlPUW5FcXZ4WmYrMEY0?=
 =?utf-8?B?akUvcGFyWElVVDlxem4xekkyZGxGQXZIVi9vVnRDNjdCWE1yZzhNbWlvYktC?=
 =?utf-8?B?UG5SYTlzOE9ocDJxNGplUnNiSDBsbkV0cVdNWnR6Y3VYTnJkdmE5U3FNWDNX?=
 =?utf-8?B?bTFaNjJ1ME9PV2FvVzY2OWpxMDM1QWc4K2RRNmxSRW9lWGFrWG1hc2w5L0N5?=
 =?utf-8?B?NjVjaXd5VWFweHNiR0t5UEZDdHVOUWFSOWVGaEV3YjhKY0lPUGxGa3Q1UHRj?=
 =?utf-8?B?a1RCTHY1T0h3c0dURWhzbncvQTdURmJzcFRqTExvazJ2eWQ5ZkMvbnF5UGNj?=
 =?utf-8?B?VW5ZMnhBUllDMjdQSjZ2dWRzRUs5QldxVFZoQkJRN0hyZjF4ekovTExGU0t4?=
 =?utf-8?B?VjZGT0FrbVJMYlk5NnVsU2Z0YlJEVUJ6akJ4ckliZ080VHZHWGxnWEFkVHJC?=
 =?utf-8?B?dlNVeHNQUFU4ekI2YTRybUVyK0FZYUFjNkVxNlBvWnQ5OHFxRUFUd0hyUnBL?=
 =?utf-8?B?Lyt0K1I3ZzkwakZxc0VHZSsxR0dyVXNOSWlOaXNYTUV5cjgxUk5LRFhrNFI2?=
 =?utf-8?B?NThZdzZ4K0dYQjdTRlJHTHJyTjZlOXVHd1h0TTdMc3plSTZ4d0lpbWMwYUYr?=
 =?utf-8?B?eUZGU1Zsb21HTGxjVnVuMXBlVkV2am9YWFFGYWtYUnlNdVpCSVRLUW5NVkdJ?=
 =?utf-8?B?UEFxVjM1V2NvVU53WlhHbEZESDV1L29SczcvQmxGL1ZnOW1KNHJZekxqWTVK?=
 =?utf-8?B?Z05DWVZwT0FGSzBRd010aksyY0ZwL1pWY0NtOXh2cElQY1dURU5qWSsrSmlJ?=
 =?utf-8?B?YlBwSm96R0hVSEx6dVRRcFY5K3JQOHpyazRoOVc2Tk9CQTFVOTNuTHkycHBa?=
 =?utf-8?B?MUVBV202VEFTR0V2R1NLSmRoUnlkakxSQkU5T3VLMFNZby9NaHNRdTAraVhJ?=
 =?utf-8?B?enVDcUo4TGR0SDBYeE5Ec3VmZ0JpVmFNb1locWxWSS94dlFobmgyVHdJWmVG?=
 =?utf-8?B?MHNIOWs5bUZkOWp0Y29KMCtUTS9QZFJ2SjVPRHVrcEpQY1paenBDTGNqRDdW?=
 =?utf-8?B?SHprc1ZEc1pEak1OUWlwY1dRR0NVVTF6VXZaWkloZ2ZIUXdNL0VQWndaVEF0?=
 =?utf-8?B?SXdVcnFjb0FTbkcwd1pkVkdVSFhpYmFBVUZKMXpGZWJoSEkxNlEwZTZDbDRR?=
 =?utf-8?B?MTVjUkR1Q0dpMDhJbFZSd0l3MWRiMk9ZTkprQ3VxdnlRZ2d1S2tIMnUvRDM2?=
 =?utf-8?B?bHptY3Y3dGl5dG5FM0VteDA2SEUwSmk2U25kd00yNm15VWZiK3RybSs1TTVD?=
 =?utf-8?B?dDZlVk50OVZXK2NYUU1ISC9NMUZQWSt4ZjMzdXdyRXVXSC9PdkEvaWtBdVVU?=
 =?utf-8?B?b2JTYXE1V3JXajF5ZnBkQTJ4STJtUjZpTS9MeURTRE1PUVZobm5IQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3c67f0-13c8-40ec-5db5-08debd6c0e7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 10:21:33.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct81+2e2UEyrw7ucpvi/+d8Jo0H736Fyvyzc8WZk+sFph/xcrktsd8lDnj22WnnWtc0gab1gyJ/3wZChH5ou+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9640

On 29.05.26 12:08, Philippe Gerum wrote:
> 
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> I'm currently waiting for a v8 of Tobias' risc-v implementation. A
>> couple of minor things still need fixing, but overall I would say that
>> we are looking good - ready for merging - assuming that currently
>> running tests are successful.
>>
> 
> Really nice stuff, thanks to anyone involved.
> 
>> From my point of view there is one issue left, that needs a discussion:
>> Testing and forward porting in the future.
>>
>> Up to now I was able to test all architectures using cobalt / x3. That
>> will change now, as we don't have risc-v support in x3.
>>
>> I see the following options:
>>
>> 1: Additionally forward port linux-evl in the future, so that we can run
>> tests against risc-v using x4. Additional effort for me, especially
>> because we don't have an in-house user for that. Can you estimate how
>> much time it takes you to forward port linux-evl in comparison to linux-
>> dovetail?
>>
> 
> Porting evl to a new arch kernel-wise is fundamentally trivial, the real
> work is done by Dovetail. For every currently supported arch, the amount
> of arch-specific evl code is 60 lines of C, merely wrappers in headers
> (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
> libevl needs to support risc-v.
> 
>> 2: Add risc-v support to x3 as well. To my understanding there were no
>> plans yet, but it might be worth it to limit forward porting efforts. I
>> could focus on x3 for testing. This might also help to compare risc-v
>> against the other architectures.
>>
> 
> Although this may require a little more effort compared to x4, such port
> would still be tractable since Dovetail does most of the work here as
> well. Adding risc-v support to x3 is Jan's call.
> 
>> 3: Ignore risc-v during forward porting. Yes, this option exists, but I
>> don't consider it as a real / valid option.
>>
> 
> Neither do I. Merged implies maintained.
> 
>> 4: Merge the risc-v support into linux-evl. That would make risc-v
>> support exclusive to evl, where we could already test it. Would that be
>> an valid option for the evl side?
>>
> 
> No, I believe that we can deal with one arch more such as risc-v in the
> Dovetail maintenance process. Besides, we really want the generic
> Dovetail code to be shared by all architectures, otherwise this would
> become a maintenance nightmare for the risc-v port.
> 
>> Any additional option available, that I missed?
>>
> 
> I'd say, the simpler the better. Today, enabling risc-v for x4 would be
> straightforward while keeping the current maintenance model for Dovetail
> mostly unaffected.  Granted, forward porting to the latest kernel
> release may require a bit more work in order to maintain the risc-v part
> too, but my understanding is that Tobias is willing to help with this in
> the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
> fairly reasonable in size as well.
> 
> So, first step would be to merge the Dovetail risc-v support into
> linux-dovetail like other supported archs, enabling it for x4/evl in the
> same move. It could be enabled for x3 next, when time allows on your end
> if desired.
> 

To my understanding, Florian's concerns are not about the first-time
enabling or risc-v but its future testing when going to a new kernel
version. While arch-wise, most work is done in dovetail, testing would
only be possible once linux-evl is ported to a new kernel as well. And
that porting is widely arch-agnostic but for other reasons (drivers
e.g.) quite some generic effort.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
