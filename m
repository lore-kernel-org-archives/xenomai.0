Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD563B6
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 15:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC4JS8Ka9bA3Ekvdue9vzxF2lO5rX46i4au2tn7fIPcf4HCe7u8TVZ+gdHxEzgITHrhTvoNbe1+trfdBCHUpmG5zdECO8zx4TeXmD6XjrCFMuHhIC3raUCvFxVz2zU7lo5m3LUUqSijVlwPfifw2xyxA+GqDzadDEOFfei5Tmxi0Zvy2P0IVc5YZCgDWacLU9vbcqrPqADvyx4KJhXIzHnH13aAgHylTYb8mRgNn4NA4lJHKBdzeK0eHe7LBX8ptPPggJnvmVvWv7Kjt7r5LwstmBJp/PwVfdBYstW7NZdpZvuS7w1apprS09YiveiR4oR5ofhfx9Dz3DguQlIyejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xuI8EtpYAR+mHku823Mrlmd8+0EKo1RoCQU9cOFAtY=;
 b=XDJxrnKAYe4K/oAz/BAwxNNisjOLbVZypmIzdkiVgJEmwaerPZB17zO0nG9/O59KLX7RLhCDcXlMfoRFzppx8x0cCDodU9fjpZmx68dLAYirScVJJeNF9vogDXCTVJGJUTM8f+YY1neAzfijYA8DbQllvbfaofTNyZJ+I6q6qbBJyMilEXQiLbIqSZ5WCpcyukbHEqW2Fj/OziH+fVQLgR7mqbXtnQQjxa30viSmpCJS5YeoBp7Ejt2izPtlBrnrEpqUKwTJ5/8+fW7Om90LKPSK/o/mwnv3Aip2TMc1q9wY4j0lOA81SWDxcWJZSHmSphp5aR4fwoNzw3UYna+3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xuI8EtpYAR+mHku823Mrlmd8+0EKo1RoCQU9cOFAtY=;
 b=KcSL0LM0lu1C8i66i3DYOfVxFoCNowSyHEuumKvlDOvFx5fJZ9GbInngcybx0f5LIeLKgZqONAeG0AF5Az80PUsmPhVaY/GQ00DmIcWCRi7uSvl5Vz2Jk9P8AT19FZVBA3fHYa3YgV6CBFdSnQ3bJn5KEJ9Ye1yPQjC6uoxnEeGzX/Gka/zWpdVi6EE9Vk5GteMpgR0EpgIY5K7B7BGsIa4gwVrjGCjgCLLsZ0leuCqvSZu3hKtwsyG2vti9wYhVc/ppVcgkB0gMsmecs1l6TwfiGoBvZW+rhJ/dNhevOakpUM0yjMzNJIx5fjmJOPWCE5EMiu+ImojHJtun1JO7Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:06:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 15:06:17 +0000
Message-ID: <b59ea020-7426-4213-ac57-2f97c32bf5db@siemens.com>
Date: Fri, 11 Aug 2023 17:06:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] y2038: build: Introduce new build parameter
 --disable-y2038
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
 <20230809-florian-y2038-2-v1-4-d1cfe2f394a3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-4-d1cfe2f394a3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fba0988-20a0-42aa-3c67-08db9a7c8380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jUZZCgvTpgv8nq3B4LUcL2z0WNvuiUBt3hDMI6vqqnoxTFwKOT3pK+RVcRm1nn+K8OV2wp3DJz+JLhC0oOmLjOi6bGRFwifPYwgQEHl8MNDpeBYFn5uoYXqRa/0mp53Qw10kwa8fqou7mWdqBQYRQFGAqi/JOjh/OMiajrp6ykTlGQIZrG98kFdFbVF+/IER0JW+j4IHANKU0OsjTPDRBvmHKnG6qVm6+Rt609M/VsdXYmVWbrojiNuZUNDulwdKdfGJzmiwomt5QqFLRvRszASf/rJOyfONlT9iLYSUm+RpuAziZYyOMD16WcQVLZ+sC6Hrd7pOQ3KUlhHbMPXR0q2sx03AK1xGR53l0sJTaLeWBoS/dbL1i+ciOnpbu86k2dqzk6V+9RiXbkTCMEW1LiZb+YpsNZ+as2alrp9eqcPqE7LSA/j3R0lVMwz1Yqd1CvE/8XJoCK6nZAFo0X4OfATdv+LmEr48fz/Qtn1OOvLa/wgYNobjk6BHFVIXwjbDCGrHyRqfVT1uPJzV/HSabBHzXCPGDg1+Xd2V5dKbs6SlIl68chXP8O2UJcKYDJUMwNs6IUXZ/D/ANwgYQzEykVWxX6QDFwl3CHqV39l2U37QMeOtdU2g/fDM+R4XZQX2SCLgre76szeULUoVUv3Bng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(186006)(451199021)(1800799006)(31686004)(5660300002)(478600001)(6506007)(44832011)(26005)(8676002)(8936002)(53546011)(2616005)(41300700001)(83380400001)(2906002)(6486002)(31696002)(86362001)(38100700002)(66556008)(66476007)(66946007)(82960400001)(36756003)(6666004)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVRFNzU4VkF4VTROZ0NpUnJwUjlDSFk2UFdicUxWWFp0WjVYZEVLL2JEMjcx?=
 =?utf-8?B?WWVHZ2ZtZjEvSkdzazBWNEx5MHh5NDFPbGl6aWRHbi84ZEg3U1RzVS9XRDZi?=
 =?utf-8?B?dE5TempOcnB4Nmpqb2p0M1dvNFN3ZXROWTFEd215eUJFRFpBQklrVUlnT2d0?=
 =?utf-8?B?UGhid1lFWE9vTVRWSDFNU09ha3FkQzBWejBlNWMxblhHdjF0ZTltSkxLNjJF?=
 =?utf-8?B?OURqTUl5dFFIbFNZeUlVR2g0b3RGeFEyeWNsbWllNVh6MFpla3dhYVRvRTZ5?=
 =?utf-8?B?VDZkQlpUR1ZIWFJtdTRibGtnVXA2dytaRmVYTVVBWVRhbSt2Lys3RWczSWhu?=
 =?utf-8?B?UXhXeTFOaVNmY2grV3JxbW9Id0xFNlhWTml3R2phenhGeTd6L2RCVjdPcUhq?=
 =?utf-8?B?ZjVkYk5FUnJ3REVmZE41Uk9Danh3UWpIcGdmVUhSUWtpLzcwYWkvYkMvRDNS?=
 =?utf-8?B?Z29wSXZYUFNUKy9WOGFzNVhUdVZ6YUtlaXgzOHVkSUpsVkhIVkRUcTExS1ls?=
 =?utf-8?B?eEtMVjBKREZFZ1NkRkxjaWE2bFR4eFc2aUs2cWpJRjk5SUp4d01xR3Y3WS9o?=
 =?utf-8?B?MFFvdFlOcjVITU1MTjY1MzRMQ3dKaURoZVlHc0JBdmNIQkRXbkJWczNlcjYr?=
 =?utf-8?B?Wkc1NU5rOFRKbDc3R054b2ozTHNUZmpUeERJY1lHRnlEc3VMT0NsYkh1aVkz?=
 =?utf-8?B?NEtBdG1iVHNkUGoxcGtkbjJkN3JwTEtiRXZlZkRINFJYcHphM3hmblZ2cVJL?=
 =?utf-8?B?L1ZRZmFLQ1RBUE1XczYvNzBRSklGMzh4SmowMjIySlhXYTRzRDFtVm82T1lY?=
 =?utf-8?B?UXRqRWsxb0N6RmRxU0d0VlZlNzZEdlJhbmxWZVNqU0VYd2MyQ0lONVRSUlRL?=
 =?utf-8?B?cGdxTkU3MlI4VTZvYlJHQXdmZitzejVTTk5yVmhseU1IeG9kTzRNc0xIUzR5?=
 =?utf-8?B?WmpQMzlOMlBuWFlwMlZwSVd5SXVmWUV6Ymx1TmJLajZYL2JPbGVvcEUwc2FU?=
 =?utf-8?B?MnZCT2NjOUFzS3dQUVZaVDZ2dGc3T3JFN1B5Q05DT0VZL0RQQ1VVUjhKVFho?=
 =?utf-8?B?YVNjYlFPYzcxT1FyQ3RzVEE3eFVLNmpWSnNIYXFiQUhXSUNCZ1VYQmRyQTl6?=
 =?utf-8?B?azBEQUNIVUcvWVNUZ3BaYTJ1RUg4Q0JMTFc4YXRkbzRROENGdkxlZE4ydy9z?=
 =?utf-8?B?bDNhSmx1cXdTWnFYMGxOd29wcTArQ3o2RDRub0Fnek9yTEpZVWs0WDBPdFpG?=
 =?utf-8?B?WnV3WTh2YnV5SC9Gbmk1NEcrOGFYaXpoNmFvOHFSSjU1aEZPZmpsVEFWZHBk?=
 =?utf-8?B?S3hkVW42cDlxYkRFUWt0akt1YWhNNjBWeU1ZWWlMcTl3QWFWelNqenZpL2FW?=
 =?utf-8?B?V3pSU0VHMXdpbVArVVgvZkRUUjFPMlZPT21lbTRGRVNiNFQzeGtCMHJyck9R?=
 =?utf-8?B?VXZEUFBtYkZlT0llcXJHeXZ1dzRjekY5dGdwSHdYNmZVQXFQeVRybGFTbW1B?=
 =?utf-8?B?ci8rWVZ0NG1kWVNjVXRoUnRXZzZ5RUNmWkJmWmpVcjkwT0IweWxqYUVYWEhq?=
 =?utf-8?B?OGxoc3RYbG9pM0s2NEh0VzJjL3M4SnBtVE5QeTluRDdGUUl0Q0Z5dDNFdnhR?=
 =?utf-8?B?WWYwTUFJZHpXbmt3SmEyWUV3dXN3aS9UNGhwbFdENGV2WEpyTlVHeldBWm1H?=
 =?utf-8?B?NGViTmxSaFRjQUZhSkpuVjhGNzNMbm5iM2VvRzRMZk9mMklreU1qVlBsYlhH?=
 =?utf-8?B?UHI5aGdNZzdWTzZCQy9vRGZhM1lrWExZSmhjazh2SkFybmNtTE5BQUJ6NzJp?=
 =?utf-8?B?MEV4N1JMUnZHc0k4N2lOSWNxSU13eFpjTngxOWpETGZIOXlxS2cxT1FBaktt?=
 =?utf-8?B?R1dFNERiTVF5ZGUya1gyVEFqRFFiSWcvaG84U0w4eVJsMStZWmN4emZYeUdZ?=
 =?utf-8?B?dUNXSVNnc1RjbWRCSzhUbkhkYVhwdVhsdFU2akt3SGNINjhYQ0d3NURsbGZE?=
 =?utf-8?B?WTQrMVhYZytiUVZSYjlUNDBTN2JYS0hINDk3QlN5Z2FtTmFWcGJncnVsbUMx?=
 =?utf-8?B?ZDJONEQyaUVDK3JoeVRBNzdibTE5eHc5N3RhSTJONzVaMlZUZTlCMkZNVWRO?=
 =?utf-8?B?SVl1YUdjSENmalNLN0FObEFkNDA4NitERENIS0hXV3VIQXVENDYwWmNvamlh?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fba0988-20a0-42aa-3c67-08db9a7c8380
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:06:17.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOIfbDtRbFJWgyj7smEfquNzc6D5ows+U+2HM6TZmxUSFVCtC/FJSDxg3FoYizTfsVF+W8sxsWR/Gu3+d6olhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7651

On 11.08.23 09:37, Florian Bezdeka wrote:
> The new --disable-y2038 build parameter will be used to disable
> additional function wrapping when the architecture we build for is
> affected by the y2038 problem.
> 
> The default value is "no" so y2038 support is enabled by default.
> 
> If --disable-y2038 is given for an architecture that is not affected it
> will be ignored.
> 
> CONFIG_XENO_LIBS_Y2038 will be set to 1 if the following conditions
> are met:
>   - y2038 support was requested (default, no --disable-y2038 given)
>   - the target platform is affected by the y2038 problem
>   - glibc is used as libc
>   - glibc has y2038 support (glibc >= 2.34)
> 
> CONFIG_XENO_LIBS_Y2038 will be used later to add necessary glibc
> wrappers.
> 
> If y2038 support was requested and is available in glibc the CFLAGS
> -D_TIME_BITS=64 and -D_FILE_OFFSET_BITS=64 will be added to
> affect all compile units.

So, in contrast to glibc which will support both legacy and time64 ABIs
at runtime, Xenomai is selecting this at built-time for ALL Xenomai
applications on a target system. Right?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

