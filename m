Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C761C13
	for <xenomai@lists.linux.dev>; Thu, 14 Sep 2023 07:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG8dJkQXLWWK/YKvG7zrRejTMGRtyNHs3Q+caW5dZFzgJ26xso1JUu+ZzeseAPHx5o1AP99QlZvUt0MeepvgM9oPws+rTL1/8+PV8uil9AMkLS4X0ugA6/8Q5HbEj7EuraMPxtzEQfl+yS7qlluflCGHslPZhdHQJ4xkPqBNNY85U24Prbjk+M3sG0MP8I6JxhlNVrPX1EPv2Qx2Q2PvxIc14OAKwtz0HP2RS0x7kg/fwhCmHLVfhQ2wioJfV2EUPoSypNbN60I8lxE0nKLh9tCq1tjxCu3JCrHjpEDfTpGV8cI7DzHCUuZll7E/hzv71iJDrpnARMo8DPVlf216jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K8SLS8nrclxwR+V0SebBoMb/+QC+/5Sknvvr8E+vsU=;
 b=jrVt2Aeo82tSnbS+9TBHntihiKC2lixuMD7V/2NXK1aZclu/IxsXi6D1K5OTJqeYhqG0uCHySfeN8AlgWlU+xbT2sqVLfTEAhjeW/n0KWSYNkFdIDRJPYi64H7zD2vz/tnJ5sta89ZnXrJVMXGu9Y4Hsb6eYk6I8wj96Cvo4HvlHkMEmv+96XXnuTfFRVK92+xGyrTyfbAFymAk8qohO0a0OzszeyhK3YhjBETVIAuH9DHVi+dL7yjp4cEoMKi53VMEY2LVXDN/qJolxrtLuCXQ3nV79zSW5GLU4KTVB9fvfRxkpXlOMhcBPwMe0zvGgmh/5mMgSighR0jPedaqk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K8SLS8nrclxwR+V0SebBoMb/+QC+/5Sknvvr8E+vsU=;
 b=IZvgxgqs5f/r44/cvBm2nYv3N8boCFHjaVuvHyf97NpxTFcAMEWODiWBPrWM5JeGylxwt8ulpxYxCcZ1mpWhsvho8mexWdzx9soea2yLikWOZRBdjhjkIRevJ0ksFA4CKAtsT1teiQV1EjIDHmOsUfBUKD/B6hBeQIpZ98TriAADbuEuuUBII+7/YPv+R6qfeee45t5pi2fbqTSnkdKVkQ1ueK1H0RZB6JrPZiAuYaC/hvvX1+MhkeZGCfySFF2dtDm0aP6ThntZlMVWuyA9PVvokAc6Qz+xH8d5YH9fobr0124YNeGg5Yp9btkqBCWRhoeOQJyWLQXxkcxLt8T6Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 07:41:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:41:12 +0000
Message-ID: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
Date: Thu, 14 Sep 2023 13:11:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 richard@nod.at
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
 <1befb87a-cc47-460b-9615-10a04f752062@siemens.com>
 <20230816124344.oq7n42fmkuxlswck@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816124344.oq7n42fmkuxlswck@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:610:118::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 047cc87e-1daf-4471-659c-08dbb4f5f80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	51RcdCIW63K8ugR9peSz66hodarjlDYinKdRio3btkAf2rW/lVkAQr7FJTsrnpodnLwD2HExesW8n1nNoPTU23l06bqTD7Sa/a1iZ7bcfmGgnJL7N5MiDiMg1fduLPgHzteGUk6n5VSBEkGsJtlIMsiMvc9jB733Xx3cvtf+Y4zQChCs+uG4PzoMR0zAmsIUnnoVSsMGklEMDHnLoFxBoz7UZOxu5g8pFzcZt/hKZ+APBltxbkG12W7monXK8j9KWt1VrqxLUvuP7M1BpvyWgx5hw4gjlm5r0mB70fOhZUfEeLI+rp5qkcSk+dBap9L921XzdTUzJmPIG7VWp2zzJHiTY9IYO+Mz/k8720wOv8m+SuoPUgZaKXNENrIdQJIAY+QKl1nTV1mlI1kkJ6K9KGdUkNrvFKfp/8cYzYjmLbuGzYNGTVweRlQlimSgLM/VgIAB0PiOIF0O4yo/I72RPwIQ/A0I6NiqEPpup+I9t5/sAIhBe+Gs2jjDCiPs/kKvMZPpIyJPszm/2XPpnadP/2ERlwGyYG3THV8jJLAKcmNjlPnN/TGOxv2jRkSGF9mj0xkLynQDMnRCHrwv8w6P+pYJ029hG4KzsjUmcBtZQsXUsl/zqjCkoc+Busy8G/8oFPpNc/OIY94QpdIt5tgbGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(451199024)(186009)(478600001)(86362001)(6486002)(6506007)(31696002)(41300700001)(316002)(4744005)(82960400001)(66946007)(38100700002)(66556008)(36756003)(2906002)(110136005)(53546011)(66476007)(6666004)(8676002)(6512007)(44832011)(5660300002)(31686004)(8936002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2RkSFpHTmtDempwVzA5RWJEMUFHdjNtc2Q3MDl4RC93eDNxa2RUZHhWbEl4?=
 =?utf-8?B?UXhoU2ZsQUFBN25STEVTbzliSFE5bnQwUXFTbXkrOVR6OE1lZmNVVUFJdmli?=
 =?utf-8?B?Wk9Zek12QWxrZkROMDlTYTZZa2J2ZEtNR2F4S015VUdSWW1WZW55WEprUk1v?=
 =?utf-8?B?VFRWbGRSbkJRTXBvZm5aZXJLTnp4OXFCVGFlQXBOd0ZJR01pdlpKUGpZS1Nl?=
 =?utf-8?B?OU5nYnRGemVjOVhyeVJYOVZ4MC9pSFN5NnlzWThMMUhNY2hMTUEvZVY1MHNI?=
 =?utf-8?B?UnVFQm9sdE5pcmJYL092V0tYaUJ4NXRISWc2dmxHMjNTQ3JYaGdHdnVpaEhX?=
 =?utf-8?B?VmRHaEJHVXZyVkVrbk5pVXFoVXBQbWxFajErSWVDenVmWmhxbWRpbVlYVzdm?=
 =?utf-8?B?djhRWXgxQVFrc24rSGhiR1dya211ZFdyajFVRnNtODE5d3JVS2NBR0hQMmF4?=
 =?utf-8?B?bGpvd1JIaGxFTk1rT2ZFdnhZQys0eHNuZ0lFNVRQeFdyaTJ1dmR5ZGJLb0Vp?=
 =?utf-8?B?TDJibDlxbndBTmwwOU04SVhXVjFEK0xyUGZJS3g1Ynd5ZzRSRUt2WnJjS2dI?=
 =?utf-8?B?YlJIQzlmMSs1Qjl5MmtHWXBKa2luQVU3TXRUTTJOY2phSEpDQ09UQ3RWVVFX?=
 =?utf-8?B?ZUJpRlZqOEpQZHdVSDdPZFVKMmFUeEphMWFCVFptMFRuTTJWNWhPVXZtYjQ2?=
 =?utf-8?B?TVJxcGtOd1RIUndzemcwZmVIbGZzSE5GY292TFdpNkRoOUE2TElUUnAzYzNH?=
 =?utf-8?B?TDg4ZHFsTlpPK3RRMlRtWGMwaDNKdzVESExySklmelZDa1FuaVlnMzBmYmNQ?=
 =?utf-8?B?aXZxSmxGS2piRFh2YzZTaHFVT05kS2p4UEk5WGZZazFHdmpSNXVwMFU1cFpy?=
 =?utf-8?B?aldiWnFJU29GWnBaZy80S3RxUHd4RWJMcVRXVjlaZ1FyUGtIYkcycm9LdnU4?=
 =?utf-8?B?czBSVFQrQU1yTVZxWVIveDhucGlBVmpHQjJHK1VRZUJTejE5OG4rSW4xNTBG?=
 =?utf-8?B?dVNQVGM2UUNpaGxML1FKck5yZzViMmdLMUZaNVZwWlZUSlVDcHV1N2dJUTRB?=
 =?utf-8?B?anBnV3hRbTNKVUxNbHA4YVF1d2VhRmI1Wk1qUEdmQ1N0VnNlSkpDa01EaTdh?=
 =?utf-8?B?TTNnKzk4Y1FXOSt2VnVXdlE0TjN4SmpPMlZYdUNxejFkZkFrZWtmWWFudjNu?=
 =?utf-8?B?VXQ4c2JIUDlHRDZ4UzNMSlNSc2pOa1BXUXVUN0JZdGhQa1VGaEE2NXNTYVpJ?=
 =?utf-8?B?WFNZNmJKZjBKaHc1VVEzd0ZDYXBHaDEwT0FjN2hNRHBpc2dLdVdBQ2pqLzVu?=
 =?utf-8?B?UmYyaFp6Wk1sbXR4MmxmSGlnczJNb1NnT3VXNjJWZnh1akw2bVNRblU2dStX?=
 =?utf-8?B?OFVubzQxWGFHRVN6b1FkTDZBbEFtemJBNXFyZHM1d2k1N2EyWXNPQndjZzFm?=
 =?utf-8?B?OEJCdWVKcFZGUVdMclRBakhZS3lrS01HNHpadXdQb1RYbVJZTEdTbTFwdmh4?=
 =?utf-8?B?dDFKUkwxbVMwdjVwanh5RWVjcGhzV3k1WEh6RzBqSVRUME81TnNKQkxsYndT?=
 =?utf-8?B?YkthVUUzMHFZanBPRmZHdFlQd284em1qRTM5OHBsQzJzdmZqMkZ2bjBWNFdx?=
 =?utf-8?B?U21jUzc0UzFKR2xxVkRmQmVPbjQ2blhpMS80dXQ0azZQczVaeE04UVNwNlN0?=
 =?utf-8?B?ZTVXai96S2cyaHJUT0taUHZkVFJhQ0RBNldKNzdWaDUxSzg3Ky9Ec0tyRzhZ?=
 =?utf-8?B?RzA3TDhmcGxCdUFRUGtyVm1NQk92WndVNDlKYUprT2ltcWJQNTJvcUtORW85?=
 =?utf-8?B?N01MTUJCN0VTd0dRRXhlSUI3c3pQUFc1VkpMYUZ2a2E5Z09CTWp3VzR1VUpF?=
 =?utf-8?B?aGFQMmVsTlZ4M0dyaGpsOGJvdTA4UHc4dHppYjM5a2IyVXRFVlJGUmkyUFM2?=
 =?utf-8?B?YnpxekZINnhkZENCSDVnSWw3aHBOVmpOeURUVGdENkh4czVwcUlsY3Y1dG9Y?=
 =?utf-8?B?cGJhbFRPNnd4VEhoZm5zUW5uVFpmbi93RmZKMnBaWE5SN0FTaTlldHJiZXk2?=
 =?utf-8?B?eGdDQ3hjTGVRdEl5U1BnL1dKYVJxd3BhbG0xdUNmQzFPSk9CSkJJZ1JNMVFE?=
 =?utf-8?B?Z0VSa1NzcHJBbk1sQWVoakJUekNvc1hPUFBpTm4wdHIxU1hBbVNxU0tJMXls?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047cc87e-1daf-4471-659c-08dbb4f5f80f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:41:12.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8XcsFROIO+5kLFzmqN88oPqa9x40hi9A5ouDJGYWWBNqhxGehHoTF8ahoaksZNFryxfbNJp5VyqjIji2M/aNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7842

Hi Aaron,

On 16.08.23 18:13, Aaron Marcher wrote:
> Hi,
> 
>> Looking at smokey --list, I agree with this: too many test cases to
>> browse now. Please rework this on top of 'next'.
> 
> As already described in the previous mail, I will have a look what can
> be improved. Generally I totally agree that the number of tests is a
> little overwhelming atm.
> 

Any news on this?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

