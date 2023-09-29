Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23D3C1D
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 12:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGZKo5sPXknddLdXqB15jg1mNdMehXV+s9Km444M2D7tW19SimieU++U651NS2yjqiwIhEFciezNLXglwKWnNdVt2YERab4UvQmOfRzUo+6KzNAICQO1ov6jT4R7O5egTvjANmuzuJ/Mwucy0LL2vYMm7ti+E9LWXEEmeBR2ka+hIJRhafVbt4jzRDlBS+lhHi7V8M7DYwGvt5N+Kc0Jtf/NPxH1lUShvKFtMdo+7oupclnRghlloN7pXK06sLGotyi+f6qPScA2ANKSFDwbC4Yqp6rAW0f2Qhc6Yw8/85tUS0ZxTUXZEL3msj6O8QeVfaYxQ2KyJvbGgP2pJRZvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q1Ld8dB0MQnNIi+K1YX4JiCECpVv35QEwRtOLNEcOM=;
 b=diri245V4p2g7wkrK39GwAeAqEs3DOIkK/wGW0MtcUYiJnS75Pr7R8I+ds4mqDExgcD7r8+TmSlOwRlDLfBtRqrcdjx1ef3E5w1dzKwnViiVWG32Yssb9r/eE1euJ5d2XFfGDN03+XSKhidt1HD/EBfFUz3kSnZTbMA26GvJziAnHgmNHiFjtzJdAOWyZwwhpXXyUrXOgGO8V+T7pAyhiNOVn744Yuvxx4yHvqVOu+fs92Z8ge1tbOZFtX23WYo8LYGZ+XQ2yJjRAx2QcogISTWC0WS7PQHdolvg69dL3yR/v5jO+FVHfkCuF9g/snQElWj88Rt9KyLS93m804dBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q1Ld8dB0MQnNIi+K1YX4JiCECpVv35QEwRtOLNEcOM=;
 b=ZmTUXlwAqnq1G3FV9thL4LJeSfVgrPDrcG7ZxZZXFwbIB0graTkHWNGclGxITcb+cSAEaO/+Zxu+65wz03JP36wdYCweGq0XTSctiRDBJaelngq1WFn9sFUAeAny+cKVZVOIqoLR9GRw1FQ8Jk3Rog4nNS0Zhi/UO+1mky7AG8wNGmXo9qTvMctNOE7TovJ4BAIUyUqpKPpMNyq2zEAxtgNksRaHQhVgiSxRPqqCPPzNe2BeK8uY4jgqf7BNpWPOSpcVYO8WtSuQkDqg6Qelc6AFnCyvm1BlJtUvAsioHMTtAKV2xcE0Blm9uxi+9K1CJZvT0AmyyIZANVZ0/eZ4bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Fri, 29 Sep
 2023 12:34:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 12:34:34 +0000
Message-ID: <b9f20d0d-035d-4a13-bce3-899bacb05603@siemens.com>
Date: Fri, 29 Sep 2023 14:34:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib: Drop cpu-affinity=0 from skin-tests helper
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
References: <20230925130311.17757-1-aaron@sigma-star.at>
 <20230925151256.22161-1-aaron@sigma-star.at>
 <20230925151256.22161-2-aaron@sigma-star.at>
 <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>
 <20230929121243.vyurasjmnhsbzxyq@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230929121243.vyurasjmnhsbzxyq@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:59::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: d89d6cf1-23b9-42ab-f8f5-08dbc0e86ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	99hlQOeZpAR1/uppbSQJ28ZYaDnNaWvrxne8qzInqRRXUEBDIBOM8U8Dy2yEdmsEAachBOhMfujFX7jiRktP5MbZaog/c2seBGLhs9+QGkQnYBIHCeh3S62q6lczt1b41oUUpUceBl8AdBHREJjv94WPS724PNQuZlGAOttmQqA1bJ13AVTN1/xhkAgi1DJyPH82VC8Hbg7AUapHxjur82VdFrl0IfTk9eX3c57+sKPFhs1A3KuM722RBKElvVg0jxjwFodwfDX1JqAQ918XK9U8uJKY38DwqeamxE3AAgxquvR673WJOZCjr99lPVrQDP8nFFYlXW/T9hRI5hyHIINtCyeKM3Fa8WVTRXTYMurjH12O2imqOWR3WAtDAee6B4ouYLWFf0xGw8CFJKVOMLXX6YEGFLok5XyT1K5kqvWx9M1Po3GmfarIfE1OVzbR6q8KeevWA98AAjBeaPHua/vrHfI6ICeheRMcduKmSefULOFB20mC1w/AOk0C/kNKwBlS4wyafEpAo4OeN7acgqgkPcdTsvpyad+JWLHqRyHV7AZOrcS9AvzsCk2byn+P+lg+w2JugQO3RlBQyaVZ9DrSj1jySpxVHXSM3KrdRM9z+W8ebo4qv21UkmyfQlD+Y1347/Zu2xVUCv/DsS2OUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(316002)(66946007)(2906002)(41300700001)(8936002)(4744005)(66556008)(66476007)(31686004)(8676002)(44832011)(6512007)(478600001)(6666004)(26005)(6486002)(5660300002)(38100700002)(6506007)(53546011)(2616005)(31696002)(82960400001)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JNWVgwZWF5bHpDa1hzNjdmSWlqMGRYYlhuUkpCUG1xWXUrMmFvWEhqWHZL?=
 =?utf-8?B?b0t3eVVZWVlvZ1ltYTJYbGk5bkdPZTdJd3VJSzNKN1BMY3dVR1gzSmdsbyto?=
 =?utf-8?B?NTAzN0ZvQkhTaUowSTZYWThvWkxVcWlxamgzbHB3TFU0R0RvcEM0U3R5Y3dZ?=
 =?utf-8?B?dmVMekcyU0hCT1MrSGVEdUNYK3YwaFRPTk9NWmRQOWhrUld6R3BmQllzblpq?=
 =?utf-8?B?dk5FaVBuRHlTRnFkSngxalhOUlE2TGs2MTZJaG1UZmtQM2RUVUxYUTFUbHJr?=
 =?utf-8?B?NVpRK1FwTjVUQXpJUENjeEpTRjNYRitINXVjUlpQdVF1UUlZZFVPU0hnbXA0?=
 =?utf-8?B?ckFQdHVNdnZrTnA0dEZTNndmOXpiUmZZbnVBYUoySS9XNDE2blVMTDZOdUZV?=
 =?utf-8?B?b0tDRzNMOFZBVGFsNllleG5LR0x3YmYwcEU2eE1RdWhpbHRaK2NFWmRhdnlW?=
 =?utf-8?B?Tklva0RzaWhiY2JNNERjb2lsMDllSzdqZDlKbkY4TWg1d0tleUNYa2ZUaksy?=
 =?utf-8?B?YVJEL3Rqb3QwNlQvWTJ5bm9lMkFVUW1iQmVOTm52SmZPOWFKYThMVGJud0FO?=
 =?utf-8?B?c2xITlpucDZ2VU1FeXpJcWVPWWIvNFRBdkR5N3A5dVNIRVFBRGJ5Yzl6S3d4?=
 =?utf-8?B?bExQNnI0V1ZlckR6aktqWmdock9mNDI4aExRbHpGbGM5UjhPUEp2VTJOeHdi?=
 =?utf-8?B?eS95QmREZ1kyNTRYTFhGTytZWHczN1ZiZlVUbEhXdVI2cSsrdFNpYmNidDIw?=
 =?utf-8?B?Um4rL2VDY3BqZzFpbmNCM2Q0a1o3MDdva2RwVW50M1Q0N3JoUFdkMm5pT1NQ?=
 =?utf-8?B?Wmxuak5WdFVPd1RqMXJsOGZyUEtwaUFBcEg5YlhvdSthWHBIMlpPdzY1blZa?=
 =?utf-8?B?amR2TVdrdmxrYVFqTmtFSjVxVFZ5WGV3aWMvZXlYMFduRit4RHBGd1ozR2Ft?=
 =?utf-8?B?a2hGcDdiRmp3OWRoUGM4VktNck4yMjNXb2U3bVpYZkxGWHpOenRJK1FaRmFj?=
 =?utf-8?B?V2Z6Sk1uTGdtSUhFczdEbW51SUJmdmRGeGQ0OVlFT0tSVVh4K3FtLzU4dGdm?=
 =?utf-8?B?dS9uODBzMENlL2FIcXlwSS9hWlFaNGw4NmxWVU50eCsyT0tVZ2w1dmNpMk9G?=
 =?utf-8?B?S0k0azcwWHJScnE1bCtKQVF6OUVjQ3dLbHpXYWJkeUFQQSs5TFBsMW41SC9D?=
 =?utf-8?B?L3pVM21nQlh0VTYzeDJzaWxEYjZRWGdCZmF4S2wzNjNJSnlsWnNpcHdqdWJq?=
 =?utf-8?B?WXVBb1R2anVwejRocStLWW9qM2pMV3VEUGNyUUw4eW9NTGk0WjhTTERhMW40?=
 =?utf-8?B?a05jR3RDUWg0WS9vNjJWaFZHc3A4NVFnMjNNSHlCbWVwMnNxVDNuSHBHNnJr?=
 =?utf-8?B?Wk5EQUlqZGs5cU95eFJZM0EvTWVBMVkydE50UXZ2Szl0ekhmVEFjQkJSOUtw?=
 =?utf-8?B?WWNuaXpkUlZwdXUxM1V2UTFKaG0rdU52Vy9WN1RXcCtWdDhPSURGbUNKbndv?=
 =?utf-8?B?d0ZoRFkwNlloMVVvbnpZUVg4cVU5U3BYblRpS2lhRlFVQ1RpV09IYTNIV2tj?=
 =?utf-8?B?WHlMd0NRdDFVMnpZTGVZYXdhZ0Z5eTBrNDZZUzJXUDNucU9KVVdWSm9DcU1T?=
 =?utf-8?B?L3dvREJWemgzN0NFSG9hTFJRWGNhZmFjaDNuRE5pbWtlT2pYbE1xWE5pY0l1?=
 =?utf-8?B?bW1ybXdubjFLWGdIQnlBV2tsTndpb1lqcDQybWRuNG9TeTJTN082TXd2T0hM?=
 =?utf-8?B?SHl5UGx1V281SHo0S2M5OU9wWnJKNVM2cjgxUi9OOXFIbFd5ZmVyV3BWWjNn?=
 =?utf-8?B?dzNKenlGZms5QjBjemZ5SUFNSzhXNVdYTFNXMG1QOGY3dVZrOHU4MFoyRG5a?=
 =?utf-8?B?Zm9IYXdlaUZZZURiMHcyMmFQUG1kNFBHT2FzcTVKRHY3cTFIc1Zxcjc4MDg1?=
 =?utf-8?B?N2tTZGJNU0s1SXFxc0wwS2pkWE9QVzNsREJRbEJPWUp1b1lZbGJ6UHZPeHJO?=
 =?utf-8?B?Yjd0cGlUdGQvd3NTcXNPUEJNWHNKZ0VNTFVaU0x5TXp6aGlYVmNURE1IcHdy?=
 =?utf-8?B?bnVXdmZKYXpJOExod3VWeHhHbjdLSlBHS0xkRDN4WWRJTklxVzJqNnVLQnE3?=
 =?utf-8?B?V25obFZwaVpIRWhnVWhMdnlYTWIrN3lsZjNnSGhjd29nZ2xjQ2NWZ09mQ3NK?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d6cf1-23b9-42ab-f8f5-08dbc0e86ffb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 12:34:34.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhUi+GM4snyMhJ50asiisVUSiBPvirQVCSEJWEYa39L+6SOHbtmyPkwl8PouclazQAvJLFtkSIgGJsSsCWowlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5952

On 29.09.23 14:12, Aaron Marcher wrote:
> Hi Jan,
> 
> should I still rebase the original series into clean commits we can
> re-apply to `next` then or do you want to keep it like that?
> 

Next should be clean now, but please cross check if you like to add
something.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

