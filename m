Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA21FB5
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 07:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwakwnh/uKjCuMRcRByP8anzRDo76igHHWSstVnFyzx6CtiNowBhZJO2+yfCjs1otXp7V7Jzvkh8cAtwWHFVw110ejkV9tKPdyBoKKeOvCGipO3NuyfYfrq74BRhMYAalAat7W3eDPOPFajrrz5C2encx4xcKKnVu7mb+zGm13KyLOgZsERrf4TjcSF8E9IoiCKcRZhRlwHEkwQwe8brjMe6lmDTbDPWyCWX3XaeS54Ig0u/l02E5PCyvxKwhAEiXfkq/7npjvbz2bHL6ji8W9Ma/Hj7LVBkTt1ZStWiGE+f0WD+xOqLTaNM6SOXEUNRncZQgmGTMTxvqZDd4UVqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3MA48nggg0mGF0NEt1RpPJ255MsEzeUa+47vrCRpiI=;
 b=OmKScRuwEzqAZemSAGrwXdUTJREVjNHC6PopXiyFrcaYSLzI9PBa207pWQBzZVflWJBqFdIo3C8S6zXOiRqLpGeSE37ve+lPGzHcuR7iCiw0SpE6IlHu3RQbCesuuETvGDk5LVr2SSH1ghgGwS+CFm9AY9z4lL4FToWi91zuxFlUsCmIaFvmb0xPV9r9VB5GhH4FIgT48WljGrO11Hi38jt1jhJmYuvzYqS/WirIZj98LDrw328b3iF+FASCmMPlWSml7a+OREJOG9eFKnOR5feqpK0Cy36pcx5pTjNQuhVqAVWJLHLkHdkUeN4658XXIKLIL88goplinm4Eu9Ni9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3MA48nggg0mGF0NEt1RpPJ255MsEzeUa+47vrCRpiI=;
 b=rBVvSyTsMcW+0nHzx75iIGm15er1x23Eg7KIpMI5Ma33LUFtL1w/oDSbLbo/7MXyPCR35jwdzqEvcsaU1SlBo+N7BaICr/B8kQSpHmZdVd93mMGQbIxPWqoIFsIZM3CQfQTUqEJZ12XMbA1XDSR85UmixiL1Ssyxje80GtaJAdtNdEa/AUJVxTJ1TerVgrONrbSiBinj1OsI2lFCP0HTWjCvnmeWuxH+oo4pGBGnxU2VnWVLxvHM9R1kXMeaI2yg+RgN/JicqAReVjtdhI6UodeH6ZWjbI1LlulWcIM420DBK10wt5BLHTvk4/v8JwtFLQKOwDbJJYAXxT3lWzBFAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:539::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Wed, 22 Feb
 2023 07:32:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 07:32:56 +0000
Message-ID: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
Date: Wed, 22 Feb 2023 08:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Meet-up around EOSS (Prague, end of June)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b1f415-2b98-4b2a-147c-08db14a70442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UKnftdEXCiaspZlgIUkQN+u+3SwhkCjerxVCjN48fFBk9QM8FMaGS0RDUmRUPIksVVo38vZiQ//HiRx9C3wt+NzvrSkSa+JwoMsEnmqHkSBBFWSmn7gyxX1GNKkL7GWPTBmbUgIghErzvQnbP5TWDG54FgOa2/a1URzJjYZZnOCdR1YsXB2DGPE4EMMW33f0g1r/vXLZhsI4SZwgBPFkwfhOZiSaBWlh7971+jsyzlz+K9lP2b7jotUTFeZxyrp7sltcU7SjPEOHp7uh1Z+R+PSOO8AGUAkU82GUmIvlSKppHo3z0j4fmQ5JzTls4CsT+qJb5iqQMzc751cbutCMV4FiYDYEPRGUfo+acvlaOvB7/rbPBJ+tqoNireHIbvWKAcg68aweOcpIXKYX6W6DPtrPIhRYWfhSdhEvRyQsJ9C0riLM3Jzl6WkKhMa+MgSxG/KYxTtzsIyYT+HJDLsBhiv0/khkEdpJBoD4p9Yw+hT9ZaOux8z7mhD3x4yT7vzndQIzRm4O55s6bQQHclMw7sPmFQqxZGjv6Eq2+sWgoHqZloD6O8lwIE9OxQ4g3zdz7mZsOPJbn7d/TtfHxM0yvMgdoryddpahfuKGJ8nR3dDHZHyiCamT3XkCxzANcHlssVAkmnboXm38uiINPwkKhrVTAKTwJM4zg/SyzrE7mW+/pXF5OWkMEjvUofEcG6uPTTP3DDQ3jGx2e7GGdSJ8xni6jCgFtoJMMFy58mdN25w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(478600001)(31696002)(82960400001)(86362001)(4744005)(38100700002)(2906002)(44832011)(316002)(41300700001)(36756003)(5660300002)(8936002)(66946007)(66476007)(8676002)(6916009)(66556008)(966005)(31686004)(26005)(6486002)(186003)(6512007)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elh5bVlRUmMvMitOcmgyako0YkVkRnZzb2djY2p6NXcwVWFxVzRaT1loenBN?=
 =?utf-8?B?Z0w2YUw3dkRSaThjenhsWnVQVWtWbms1bURLT1loWVAzQzdnWWVJUFhlNlRa?=
 =?utf-8?B?cFU1bEpycWlSOXJDeGVWSmNKRUxoenVabWdpMmpkZXE1dHcwSmE1QXpPUys4?=
 =?utf-8?B?YjdmWENBYXRCLzQzU1BKUFA4ZWFuU3NCSS9IK0FZYnkvSmFjcFgxMStlVm45?=
 =?utf-8?B?S1NlNHZJaU54eU1jZ0NLWXdwdGZ5c0JJTkhmVnphSnY1NTRDSTJxcTVOQmZz?=
 =?utf-8?B?RzZjYTE3eXZlTDQvQzNEUTNPSi82bGZRT0ovWXMwNVVRMHg2cGtDL2x0b2Z1?=
 =?utf-8?B?UzdrZE0yRU1qUGlHVW1TdUNwVjkrTUpQdlZwaGswY3E5b3dBQlVjbUVZdGNI?=
 =?utf-8?B?SGp6N0J6RGVGZ1BIbHVheTZRZmVkdlJTbjN6czVzUlRzeTUxQ2M0SDJmcVdK?=
 =?utf-8?B?a0FNd0FtOUJWTFFOU0liZWE2Rm10clVuS256Zks5d0NWTG5uNzQ0MkVoeXNO?=
 =?utf-8?B?UjlZaVlOeXdvcHNkZW4reDlTWFBacHV2SzIwL29WRkkweHZCdS95d0RTNWty?=
 =?utf-8?B?YjI0ZDZUcG9jOHJCRVo0eHFLNjFucDNWUm12RENtOTd1N3JyYVRvMGxiakh2?=
 =?utf-8?B?MGl0SU1rcEQrRDBCMUFsTlJQWGdXNGFZWWRXQStFM1dDdGN6QjEzanY4SHlL?=
 =?utf-8?B?QkZ3aGdyWUdIZHYyZmVLSWNPWmhuQSs1VTg0OUFNZDd5bkJaUlJVZnZ1aHJM?=
 =?utf-8?B?aVNoSU1ZQktPdXdmaTN0di9RaFdYQi9MYmpibmZIaUZLd0t3NXBvSzc1cXBE?=
 =?utf-8?B?L2ZzZktyTjNLNG51b1NScm05M1dPT1RKUGNRTEIva0JEc0ZURW12S2sraHZ5?=
 =?utf-8?B?RlRZM0oraHF1YXJwTW1lUnRYRklvTU9Wdm16R2xXRTYvcDdUamswMmx3a1Ji?=
 =?utf-8?B?Ym5HYU1ZNFhaWjJTdmVNL1E2Zk5vM2lGVFZtZlk0Rjl4NTV5dTYvSVYzQVNx?=
 =?utf-8?B?a09JRDZMcVByeitwcVlsT21yd20vbXB0Yjc5c25UaTZvM0FMV1JvZzhtNTZY?=
 =?utf-8?B?MENlZi82SXVMR3RZZXFaeFRWTk9kbEZHRjA4Mmc1emNQSlZITFl1YzNJTU00?=
 =?utf-8?B?anI1YURycDhqSTdqTU5TZEVKbkJxRXlORmJLRmJsQ1pjMnkxekJxQk0rTFpB?=
 =?utf-8?B?ZXIxandsQkEwUmVXd3dwbHZNYVhlQ3NxTWt5TlEvaEZMK0xPVTQ4dmd5LzJI?=
 =?utf-8?B?WXNxc2VaS2Yzc0FmYjU2L1J1Y2VBNUNkSVhpZElQRzk2ZzlxdElPWVU2RVgr?=
 =?utf-8?B?cDdCYmhWUitwOGFlMU9BNERKdS82NnVvM2lRd1hJcFNmUExXdldNZVNnUU1k?=
 =?utf-8?B?c0hVK0J2ak4xclp2S0Q3anV3OVkva1pVaXVwMW5iT2VEa2xhdVg0NEg0TGlN?=
 =?utf-8?B?Wkx4Z3lYU1UwQ0xxbzQrQVh2SmlQYmhGM1JFQ05KNVRYSVpEeHFpNDduNWNJ?=
 =?utf-8?B?bjgzWitVN1J3YXIzeDJ2dktqTTcvaFpGbGJOS2hIQUVxRFVBR09rVzRWbDRS?=
 =?utf-8?B?MU95YWgyRzNBcFVjOTFWeVhtQjJLdzBKekFTZ092VC96Z0pFMHc4VVJhbVZk?=
 =?utf-8?B?UmRCM3VNNXh2MlBjL2lVOTQyWG9TZFovTkxkazNVSFRmNnVEcExZRmwreUU5?=
 =?utf-8?B?YzMyVWlZM0p5M0poeUFTeW1nci9YR1pHVlRGN0pNL2FpTGFVSlYrSDZxUFly?=
 =?utf-8?B?K25ieGF4T0dYUTJQQUdXUlJOM1dhZis0UlhzcGF5YTVTbTcyYnoxRFJSU2hh?=
 =?utf-8?B?VEFTNjRtVHpEaDdRZUhhdzAxamNMQ0J1aUdUTVVWRzJGWW1PYkRsRVIwUDRY?=
 =?utf-8?B?M01iM2M3OWRra2VZYXEwQ3FGbmRzZGh0WGk2cHEwQXo1OU9mRmZtT1RiU2VF?=
 =?utf-8?B?Nm9IUDh2ckhaRVNJOXZuSE1lajZTb2Q3OTNMOVZxc1N0ZE1KWVZ4NWp2TlpS?=
 =?utf-8?B?QTlWWjk0SGlMbFlrS3o4dFBycmxZY2dRNXU4SHg1NXdPYXNJZE9OYnYzNCtG?=
 =?utf-8?B?QXliMHBKMUNNTGI2dFV2SmdyamxCUjNYemtqcktEYWZqbVVHcnRHa1dRcVhT?=
 =?utf-8?B?R0dMTjlzR2FkRzlHaUVXeFgvbW5QZGNRcDA1WWkzQ0FOdEk1TmkramlZS25p?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b1f415-2b98-4b2a-147c-08db14a70442
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 07:32:56.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BK1WYXJUGXZi3bOZrBzlcG/uESWDDfOEvqfvBvy5odTCWkcqgPzTU8RqYuhSFYdgnEVK8d5uMdHJ6TnAwy3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6030

Hi all,

as just discussed in the community call, I'd like to propose having a
Xenomai meet-up at or around the Embedded Open Source Summit in Prague
this year [1]. If you plan to go there - I do - and are interested in
chatting about Xenomai topics face-to-face, please let us know.
Depending on the feedback, we would make this more or less formal, from
looking for a real meeting room to defining a time and place to have
dinner and beer together.

BTW, the CFP for EOSS is still open for a few more days in case you want
to talk about your latest great Xenomai project at this event.

Jan

[1] https://events.linuxfoundation.org/embedded-open-source-summit/

-- 
Siemens AG, Technology
Competence Center Embedded Linux
