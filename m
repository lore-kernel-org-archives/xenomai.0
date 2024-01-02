Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F921549F
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iXlXmIac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNbzz4GsXUA4PAdoDQPiP5iFK3EsCnEcFQoCpKFv6F9f1h9kk5uFN+yazAMrTM2+azFG/zN3N6vor/+dpgPdnOgU2ghWGmYuQS2F56FzbF5AnzCDmr63FND3aoZxxssaQ9+YF4aJ3AMP4kHTqdLVvfI7drBuKnuQlkfy8glG9lqSW6RjTHO77otldIg0kLUvHYICFx7m+6ryAfHijd99WO/PjIFNhB0Ckvzdlu6tak6BVxTU5py1NOtOLZT8nQXWahCGYQuwWlfjRIEH5Mv65QXfy3n/w08yvUtGP9BFNw9OTUqOSAHdlWiUKPx1Y6IIOtDIDzB5gT1x1EM9WLfmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUxdwRd3ja+iK2mtGSp99YnvDhM3dV/ye9JeoiUPNZU=;
 b=TnW+mtxLYkYR7sAmCozMwC6kXcA5rQw4ITjC5UG1mbcE1sr/7OPJ0pc4tNYRVV9RSY4ArABqydqjCoxg/CRwswHxv0ff6HJH1/xYoyEZQiem4rWPUEUxeHBSuSM9vN7d0OG4+kfcRLWBpMO4BB8Pn0FmHAwMG41eo3Y8M84O6tCKbbY8RWsPWz1NYpRU1xvhJZYtogJJDPNgVFh8qY+LVGDClKHjHx0InchsxiwnMLl5l56uDWQXnwuVkyI6k3ZhFNiSOvzm0G3lcM3iq3zYObIMNryz+NlJwB1QFwgx54oUzsvAiYmHRQDH1lr3y0ef5gBW13Yk6HEgDV1vdPwn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUxdwRd3ja+iK2mtGSp99YnvDhM3dV/ye9JeoiUPNZU=;
 b=iXlXmIacxlP4pDzaaOkmwEeQPeeWTI4cLinqOHVl4nxEEFssF7btkhFSQ42FTuNzeGAMeKtR1daprruoHCcsYKK1HdhKTJVl6ZAXCGY90oH8Mtw10TcX3YktmhKluYedpdL8vjrnKG6g8LfAo22zGzJo5b1bSQDVPAuOnBPDyiRBEMQmrVttXDIeLNeJVfxggOgxLpY2Pa6T+2xnnlwKP4H4JNBvmxDwHHQ/PWkFn4ENVM+0CaEsj9meAvX6toXpBJHJwiwr8Diy1XCPxj8PgRCung7pJ9AnnamuwqDbT3A+VcLtFMFTcxMtqDmjoqXPriUonhDcQh/PsWkhwHvbkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 17:21:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:21:50 +0000
Message-ID: <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
Date: Tue, 2 Jan 2024 18:21:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: The linux-evl and libevl stable version
Content-Language: en-US
To: Yao Yongxian <yxianyao@126.com>, xenomai@lists.linux.dev
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc35b51-fe68-48b2-09a9-08dc0bb74e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2bc1U8yfZNN5jlzcqy6sQ3QrIhtSTLKUv33HCktnpt1a8zOlFzKfYvVWcc0LHUYIYCrV5G/ELhdvG5vDPTCdc1UfBW/23LFW55LW239YGzgkHNEgYOlh2slInpKB0AdXHMt2mwSXJsMLCWaZxqYGK5h6kD8+tImKwO7WEq5MK8ma2lq0Kx8BNBiPyqC3kU0VdXYAKI5dfaCkaHNy+czfyRJQyFR3wwhFnuznLgXqeWeexUyqs1sBtuBpt0O1jybTfAgxIdtvALyhb+UrZFz/mayudxRtjfDosuCcFwNdtaoyO2oFEYTHHZly50gLkKtoJPW6nJsbIuR44LQFDwxsqVBhumD5/VgG+kMdytW3MFEwraHDG3sctKOi9sskbfbCglHqESMFkbxW6xUMzG1fiLbJK4DK1aNJZaAFT308Im2PEtQLI2ENvFMDOjQwxHFzKqAUojuCj3uyRdo3Jb9HV2HsBcZpgf6dUTGFcmDbNMGKU5+APEEPL7EDLLtLZmllVZt0XWUVWJXko2sgLfSb7gbxPMpZClVvRxRbDQm0ZT21SrzBFotWSCEkQlquKC2g0hHgjNxQx8950O0voYiOdW3iQkaoqeB++nd0S7XIDyo2iPi8CEgdFypPT6FFI6Ub
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(53546011)(6512007)(6506007)(966005)(478600001)(6486002)(41300700001)(66476007)(316002)(4326008)(66556008)(66946007)(36756003)(44832011)(8936002)(8676002)(31696002)(82960400001)(86362001)(31686004)(38100700002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDQrU0JlYm1ydEdhd1VueE1qUGQwakVYYVZWbWxvSlR6QUgrcmZzSWRUeUVS?=
 =?utf-8?B?bnQ1ODdqUTJ0bkJldWlpV2xVWGRMd0pVMGxVT0ovaEtLUkFyZUlzZUg2WW5u?=
 =?utf-8?B?REYyU2FyN2JFVjlZcm16cXdDMElNK3piUHFydXV2dzdkeFpBNzQ0amVRUXY0?=
 =?utf-8?B?NVovWnZXaC9odHRUNW5USS9uMm5MaDJFRDNGeG5pRVVJT2hjVERNTFFEeUtF?=
 =?utf-8?B?K0J3RCtxcjZGOEdWbXV5MUNUNXRWUHdicENVZ0w5MkNTZkdFQzRrSzEzRktM?=
 =?utf-8?B?NnN6YnJpdkF4Q0lIbWpOa2Zvb2REd1VWb3R2NXArTExwTmhWR2k2c0JNb3VW?=
 =?utf-8?B?OExtNUttQkdvaVpIT2lDR3gzOG1OYXNMMm9SdC96VUF2dEJ5bDFnM2Y4a1dR?=
 =?utf-8?B?RisvSUkyclJTWDBNeFpVVmRMVlJ6WXlBdDlDcDFpUWplUDVpdUxUMFZuTGRn?=
 =?utf-8?B?Wk5tY3JWMW1Ia05HL3dmUzR0RTYwOTc3RW9vWWE1Y2JFdWV4Q205U1JjcVpN?=
 =?utf-8?B?UThaeHlLMERSNlEwQUdmSlpjWTF4dEhxK1BJVi9xYkJXWmdsNnQvM2dpd2Jt?=
 =?utf-8?B?M0dDbEc1akxnSDlZeVQ2cXlXWGJ4RVhNa0tEdnBhd291ZzFSWVFFWk9PUHMy?=
 =?utf-8?B?c1drb0dUUXFBUVY3TGQ4VmlOY0hhZ0JwaCtvR2lxVVg3Q0hkajVPcHU1bENJ?=
 =?utf-8?B?RnpWaFFWeDFJMzhCZjI0MmI3cmRjMEMwTThXK21nVTAza2RoTTBGakpuTU5D?=
 =?utf-8?B?T0NkVmJUUFZJNEpud1c0c3NHeFlnK3o2cm5HYTNhZEtIcEF6ZzY1K0R5TCt2?=
 =?utf-8?B?Q1pXdVVXeHJlczJnZC9SWVR6ZGU3bUtBYmdXTi9jUkxXRlhEcjFGSjNUZHFW?=
 =?utf-8?B?UlJLTjdSLytZcDQvVlloZDlGeWJZc0Vpa1NDS3FLY2VjN01pT2M1YmRFU0RT?=
 =?utf-8?B?NENSNEIvZ1B0UERCamwxdjhzYUc2a29JWXpUYTh6RUxhWFZTbkMwQ1hKcGFX?=
 =?utf-8?B?UDM1Zk5DcllWVEx6dDI1NFR0RUxGU1RKZ0VsbEFscWNnY1A3VC9WaDlzYjE1?=
 =?utf-8?B?ay9UQ1FOaGVMa1J6WnVxSG0vWTltVUpVRkRsS1Q2dUxLaGhadFdvNXJRRWdj?=
 =?utf-8?B?N0xHbW81M0V0UGlWSFF2eGFCR1BKNmxWR2hwcVFzYnJpc2dHYmJML0dGQlMr?=
 =?utf-8?B?ZTVNcnRSSGNSS0VnSTZRM09hUmIrRUFMK3JFMm9PWERyM0w5R2RMaGZlVG1q?=
 =?utf-8?B?YmJGYTd3aTJ3UVpodGE2UHlYVElCZEFxWnZZWGZLT0k3WEJ5YmpaL3EzSDNQ?=
 =?utf-8?B?MWxURnR1TXhiYXMyUGlDUTkwV3lucUZ2UlJxdVdIRisyRk1WRFR6Mlk0WjMw?=
 =?utf-8?B?S0JpT0h4RXNnUWt2dUovaFV6VVZDWERGd3FpVWJ4K2prTUVYK1Exd3VLbndC?=
 =?utf-8?B?SWdBbm5GZURDdll3bTFUZ3YrREdRdlcxcEdhRlpCZlU2YWkwSnMvd2FVSnd5?=
 =?utf-8?B?ci9YZGdUakZXV29BWFdwbGsyRTVIWk03M25mMHhDbzZDV0VtbkNRbGU2TlpZ?=
 =?utf-8?B?YW91SVJGWDdqbmtkaHZXNG4rekJmRzhsaC9yTERxUWtpdHJubXdZVnY2aGxs?=
 =?utf-8?B?SWFqYlRyb3hWSmZGWkRLdGlVVEhmZUZhVkM1RkV3djNyZVh6STBpOE05STJQ?=
 =?utf-8?B?czQvRTJyNlR4VzViODVIWlRDVFI4blN0QjVDcTdJckQxKzg2Q29SUXhqNmlE?=
 =?utf-8?B?ZDdsdytPdjdTeVNCNHduVDRMNFZUZ1J1KzlMZkN3cUs0cUF1cHNNVTc1Q3FY?=
 =?utf-8?B?S0dFSXRIOUdMZy9iQ0lMZE9yQzBiV1Fndk1EWDFwRU1NakI3aEo1ekQ1YXJJ?=
 =?utf-8?B?ZGpFc202eWtjVG1CZDBoQi9iU2F4VklCb3FGRVdWL295OVo2c2N5Mnl1K21K?=
 =?utf-8?B?NjZ2S3BadUhhUnNtV1UzTHRKUGxaV3ZSaEFNck9vQlp3SmtRVUJzc0tERmM0?=
 =?utf-8?B?VERHaWZFK0kwS3JEOHdNRldKMlVaYkw0aWNXS08rcVVjNXgvaEdIc254Tmdh?=
 =?utf-8?B?cllpMlE3eXRsMllGSHJTclJEcDQvcXlzNFBBK21iV0Z3SlJ0MW9GdzZYQnJi?=
 =?utf-8?B?MnhwdkJ3N0tnVERHdTFMYXZWUW8vQWc1RWVneS9hTDBhRUFkNXY4Rml4Rmtr?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc35b51-fe68-48b2-09a9-08dc0bb74e7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:21:50.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jipuh+EqZJYXoSni3bPGFCkJ6+9mCwvLEdV6/xVPhNhLKa7S/1dzKW9Dw/psdlkpCY6Bj2RDBbFvPoo7O5EVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5662

On 22.12.23 04:05, Yao Yongxian wrote:
> Hi All，
> 
> Have the stable versions of the linux-evl and libevl, which can be used in the product been officially released?
> 

linux-evl is provided in three active branches:
 - 2 based on latest LTS kernels (currently 6.1 and 6.6)
 - 1 tracking the latest development kernel (currently 6.7-rc)

So, you likely want 6.6 when starting a new product development today,
and you will have 2 years of support for that baseline.

libevl is single-branched and does not fork-off specific stable branches
so far. You can follow the API revision history at
https://v4.xenomai.org/core/user-api/api-revs/, and you will see that
this is fairly stable already, primarily adding APIs, not changing or
removing much anymore.

Regarding the management and stability of the interface between
linux-evl and libevl (i.e. the ABI), see
https://v4.xenomai.org/core/under-the-hood/abi/.

For more details (or to correct me), Philippe may help.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

