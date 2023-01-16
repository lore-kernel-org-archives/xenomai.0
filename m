Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B86257A
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 14:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUtCyn/oUvTzc+QqNof0vjs65pK7200gM9p0tdAigzg5nMjxg8rDnJAouPdBaca1I+L0QAUnx+K0lyn24ephplFuQMxfY5KOaSSayA3PkIzyZutkmuq2zhNijoXiskNBq945JZe0wFpFLyMceo/Mo1vEel5O18o8LgqA79KhzRxP1axtJvMr4QEcHdxeoC5gVbKgqIfKjbFhAZwOC25Qttu2BMkSOeMVS9KZy1U9kBI8FqS7kvsn+bJyLruhPhv1t2HEHo3pT7eQKhc62OV0rBy3NUurO1cD2P+KQ5LWH7EhtOgJMtEkpavwPfOvuuBQtoNKNC3aUzmeHDu9bG+fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44dH9RIP2oVRJIOPj8u+XPtNP/EdcfeHaXjlWCnxeY0=;
 b=aGafV/VT7/I0nuvYdNye1TAY1HczoFBGAqaN6dSZ8dbguc3ZdgFa2bCcKK/GiQvTGLrPrfPLCpIDaLk2A1EWJulDZbvbrQNHtE+mJj74caBqJ8VdwaFlgeKhyrN46GWlQVf9URUKRKGyAJmu4gU+ot8j1Uk5BQzF75kHS0j1vMj70m0Wm+5FMxKq0IuPGGwI/fUdi+u2huVp2MW2CElN7dOUKTawrlyjpc05XadDXxi3q1sflqMd4SZVyFohi5nR/GtXkIdJRqVF8Nt8kcUXYGmorEJslMSaZsLcGzCCwiOfsKjaGUrE9FQJHKELfu8MJANm5ndSFv71CcBPJwd+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44dH9RIP2oVRJIOPj8u+XPtNP/EdcfeHaXjlWCnxeY0=;
 b=fwTgzyJxKsIG0Ku7Ha58hgXRUPeO+i7W3qgjoYz9H8L0l22fGe+MrAe4uMqR4hQQkNzFnrUEBrCd2SYIp4XnEgaeIAV5104cNF/Aj7bTByLB4RbGiq4rdVzOhHlQQS4wS0l7Jr4op1UWpGSrofzq5znJq4ctDtcNWb4G4ycRhiDQaLfOUZV0uWREuhaIJ2EsQhaAHzpH6z+8xhlIf3s9BO5zruwGmiRLeJcqVaRsK1YilAJ5C0Dm1LqWiWqdE3Uz4cIE10KayQr1bb+PbK4ZDxhS2WIdQhiVizgw8fH0fAYoBLXrwuGFtWTFDH3Kpsd3RAqEmNIa5iOvwSVQAOKzsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 14:44:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 14:44:21 +0000
Message-ID: <dfa242d4-9ecd-0bb5-5de1-677128a90946@siemens.com>
Date: Mon, 16 Jan 2023 15:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: MSI NOT pipeline-safe & Internal error
Content-Language: en-US
To: "Yao,Yongxian" <yxianyao@126.com>, xenomai@lists.linux.dev
References: <54b46bc9.4a08.185b9bc9cc4.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <54b46bc9.4a08.185b9bc9cc4.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3802:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f28e99-e241-4496-2a01-08daf7d02727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6AJ6xjM5/dEMVUfLhywgsL0O+QowGOh/pgeO6yhMuCOEyZb95RfIL8y2HGhYeN7mES37XvoVVMU7rgqxf1CLNSU62DPgJuFqtFxNXF6NeI5MhFqrZqbY+oPrhIIB0Mbus9UrErqYTpIWWFCb0YVY8wLBsNL+E0lWguBxYBwYiILMQqffQVZ3bHsC9FO0CxdNuHH/RCbK5kMAVJXVGLPDF17eRlcpPbkDGoNcJVeUE9tczqpMHtd7Gvq+XbGyv+JyfamTHPOIG8vMDKq4TNV1zh/RiS7F3n5TfSV6gDaYpwRylUpycpc4ll5TmbKCBlCi4L7YuKW+4xP2HP5OrTYGWmkjlXBS3ipXNwmfxk8EMmtLqd9NbqPDauSZpm0V6kltl11YjAqEPbxqfYEMp8PWus3dhqEbJaFj78nTMYQ3tt5UKxxowb3GtAvlSJR9MIAY+2vOrVaay1Gsr/syPuTdB2rBwqACRfJpJb4Nggn05GhjSnEl2McpXEKp6C+fP+3UgjlrO+xdV+qjZabwTpyqCgkU8GMi6/erg9obdVPBzW1iWR859QMUr9acA1mtvfa4ideF0pO13uAzYBPvapvv64zJF+Swk6mhGOpmQJkPcL9i6DXmI4PaJuwST/Pz3p96Y/AMkkytdtikl3JEaQOMX240H6NawZsSB56wI/IMhB24KmlwgsiO0MxtQm2vtK8EgQEvRJy5ehb9C4YDPAOhe2/B9SQZWseSVbTqc18hKzjljHf3yGfnlzSH2Cxxe8gQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(8936002)(4744005)(966005)(6486002)(82960400001)(478600001)(5660300002)(31686004)(44832011)(41300700001)(66476007)(26005)(53546011)(36756003)(66556008)(8676002)(66946007)(2906002)(316002)(31696002)(86362001)(38100700002)(6506007)(6512007)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFl5U0txWkhqVTRFREtFVmRkWGpNY3ZtTnIyYUtxOTR5Z2pCZnN4cUZGN3Vl?=
 =?utf-8?B?SjNXZVpKMkNXQnJTZVpZYVZVN2ZXMllpVE5FcXBlRGI1SVNxdnFFWXYweC9L?=
 =?utf-8?B?NkZZc0gxMmdVQkxDdno3bXdHR1BaSGJFSVpmVXkzN1RCT0l1cnpLVlZ1cmxJ?=
 =?utf-8?B?N3pjdWpTT0VBb3Vzd3doVGI3SWNHb0xFTHNUak05S0VsVnhQVmVqdTg0QnNM?=
 =?utf-8?B?a1p1dDYzc3JEeUY5Y0pSejBGTUFYVHFoamFsVGNOZll5bkw3SUYyc0dkNmJU?=
 =?utf-8?B?V2IyU01TajJmNTlUQ1JDZS9rWDllWFZlQ1M5YjRHRlFONDNRZzZEeWdFcDhD?=
 =?utf-8?B?aW5aMzlNQ2hPZk9MR3M3b0VZSFU1OFI0RHBIaDc2NjVZeWd6eCtLK3MxRVRS?=
 =?utf-8?B?RTFRZWZUWGEvWnlzOHlzbXVveGlaNUl5MDQ0a0FMYjhRR1pqamVzMlJFU1Bx?=
 =?utf-8?B?cXZlckVvRFp5dlFQQXQzdVJQKzJ3WUEwSUJ5Y1BLbElIa01iRmI0enA0K0Y0?=
 =?utf-8?B?Q3JxMklmSVg3YnNUeWlwSzA2c3FlTGJpdlIrL3ZQdmsvRGFJNU1ZQ3UzV2xl?=
 =?utf-8?B?dCtNUDV2WjhjRmdDbGdFZEFwcWdVeWVhdXk2MXFENG9ReXJXR295L3hWRUow?=
 =?utf-8?B?ZitBbm9TY0EzamFRNkc2aFdDZEQxMDEwaStaVDRWSmVwYUlJMk8zUW1tNEQv?=
 =?utf-8?B?NSt4UlRudndtR0pvR2JTY1Zta2txYTRGT1ArZUs5dW9sVjJ0cVpaTUFlUmIy?=
 =?utf-8?B?RmNwRDFrVVVYc2ZPMjBEMHcyMjA2Mk1MSTNMMmNZWWliN1YzZ2o4YWdBNVlw?=
 =?utf-8?B?WUhrdmN4cWNIQjM2WTEySUdlVzhPWnZjNGhsTCs2VE41R3VoR09taGVMWmpB?=
 =?utf-8?B?bytmZXRqQ1l0QVpLTWdoSlB0VnpoaFozNmt6ZGROT0t6dVNUZmxZdU42N0xX?=
 =?utf-8?B?YjgveENGTEZNZi9xUW1GcGk2TXhsNDBsR0dJOUtaSlB3T1E0TUFyVUtpaG5M?=
 =?utf-8?B?NmRSQ2lIeFZWbGszVmxYZHhpZnJaRVQ4YjYxUW10V3Q2NVRTdXZjb1FBS3hj?=
 =?utf-8?B?VFNoSzNMSDFDZk8xK3o0Wjl6ZXU0d2h6ZHgwTUZ1WlAyU3lQS1BYMEtMNzJ6?=
 =?utf-8?B?UlQ4ZHFaUC8wSWl2YVJPeEZMSm1EekRLcXl2SWcrRGtTUTNyNzRkNE5TYkNs?=
 =?utf-8?B?R0k0TUtub1RVcXlwRmFmUngrQzNUbUx3UUtVbnBGZlRHSWJNc0lhWVJMNDF2?=
 =?utf-8?B?WXZSRHFSQkc3WGtjenlvaEVVa1lWZWZYNDFjVnluamxpSHVDV1plajVqbjd2?=
 =?utf-8?B?akIyZVhJR3ZvSEZVWXJ4VmllWVdnQUhMdHpLMzMxNzJCT2NMdHdiVENCcjh3?=
 =?utf-8?B?ZFVJS1A4dFRiVHNNOHBnc2FPZHJsc3plQ3FRRzhudjlzajVEZ29OdzZyS3do?=
 =?utf-8?B?TkNZbGJKRGN3OURVTldJRlRRZ3BEY0Rsc0pOVWM4RlNkMVJTcEI3SkV6d3By?=
 =?utf-8?B?WE1VV05kS3JmN2Zsb0NpbFpqcEg2RlVZekQvTVBXcTZxbEhNQmxUSk1JZE9F?=
 =?utf-8?B?QVRyREc2dmVaR2l5TnJYOEthdlpvSjRuL1YzUDVhNnFNRFdXamIvcm04T2RE?=
 =?utf-8?B?emtNVHlHUGtFUFM2UFhqQ1FiSkN1R2Z0SDBHRlNGTExRcCtSWjhSaXY5U3k5?=
 =?utf-8?B?NGRQSDFEWlNaMEZIRTJBZTlpWkxtbW9hZEdQZlNJYWkzNFM0aVJrVkJkejB1?=
 =?utf-8?B?RmNqcWUvc3BWSUM3dVBKMG5TeHhjWG9mOEY0VmQ4K3pUMXJTQ2pnZnkyWnBT?=
 =?utf-8?B?UlFoMFZkMjdKRVY5ZGpHWnpVVU9WTnZaTzY0Qk5MZjViMDZoR2VFaUt1eUVv?=
 =?utf-8?B?MXFuZ09MVDVSYUF6dVhKSHV2WE44aWZqLzlZNjh1MnBhYlJMaFRYR2cvamxO?=
 =?utf-8?B?WXl4dVpPaG9pWFBjNWd4LzBqKzFwbitRb0U0SWZ3RVZ2UVNacmZqclhaUG81?=
 =?utf-8?B?UHJNWjJkdEJDRnhSR1o5TUFjLzhSMFhudWdTalBsdXlZMi9FTDMzS1kzdXQr?=
 =?utf-8?B?ZzNad3hBSUJpa0gwQnEwUjM2MnpuM1VlN0ZjNmttT1FISVYvcldpMHliaEVW?=
 =?utf-8?B?alZpWG96WTRiL3kvZ2krQ1dKa1dvdWt6YmhnSlIxQlp4YWg1dW12dGIwQ3NI?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f28e99-e241-4496-2a01-08daf7d02727
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 14:44:21.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgOQGIr04QPffI54gc2/Bh8RAxDX3oHCXJW8/BfKDbbxDLfpdaJxdnWw6XvapgnKBKn9nb0kWQ4WC3fTgh05ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3802

On 16.01.23 09:40, Yao,Yongxian wrote:
> 
> Hi,
> 
> The following exception occurred when running the kernel(Linux-5.4.180, xenomai-3.2.2) on aarch64 computer. 
> Attachment is startup information and kernel configuration.
> 
> What caused the exception? Please give me some hints!

Maybe just something like we have in Dovetail already:

https://source.denx.de/Xenomai/linux-dovetail/-/commit/42f44cf859e3525eb26dc090fffa97bfc35e870c

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

