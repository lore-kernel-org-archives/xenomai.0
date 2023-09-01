Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D08BEA
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6P8525rGjIqN4Z1BoliMUHBi8MRtj+GexHoG4o0s21zGcdXAipqtHiZALlx+8CqCjf4RY0MUcbOwTp/nGQw8QDMssR++XObpZ6C6lEfVoomeT7f0ihC1TstMoKb53Q7DbUkLH7itHy2fGhYZrYEM8hsh2Zvqg0uR3TDEwTCrWxslLMoj6M1sX9uwWvxgaRcKjsKAF2JuWgP8nEt9Tf0Z7rj3ojI1tONEQtL7sMDUtawSRxrKQCS3OEL2WZ926poMLDXiFFO1bqvlpoMq0valCkskWcpYakGkIvp/uyv1EP6XWwSakyFUllLozOjmoQQcmbJqCiI10R2R17aa0N9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0w3wJm3OM4CKBkhWrnZN7N+DOSU+cbWj05tYwdupf4=;
 b=O4E77FX0Uvpl4QOr7BOw8knNBhny/4a9DKMS+HcLqjJS26VfPZ+XzWoYTJ0fLussLl2Be4Nujz6iEh+w5LQL/OaLEK5zbIt2wyOxUOIhehrtouItDjc/qOJvyTsqTVpVpGxi/D0A6ehxU4HX+NLfOCPHl1TOPtT3Ita+hme+MFWOLKKMgZhCAWOJ77D15+43EMtM+3VB6THKAzODb7dyZHUohtqaxAxEMFSiuLWzRyQ9c3hyEsyrzt63VqiNWQBDvXVhUZFncPJlCzly2/Cchln658E3SvfJbaW10goPMHCw6mCaZsqJcKJKKSiJDsPW9cmWuI/vtXfGSaz88jpTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0w3wJm3OM4CKBkhWrnZN7N+DOSU+cbWj05tYwdupf4=;
 b=i3JBbTlAQbHlLP8baeFLU8zpQ2/NGWJp1ljrAQmSXta2byW1YYp8xxpd1/JGnJ61g8clby/g1FLGMgtW8zQENJ0XEwaEuPYaYMBql1cY2Jqj173iJVHuAgBwy7rHRfWFbz9Nr33WW5+0pKQ+Qzrm5BXk5WsGy/WEXFJNmE1SUTlBlEoaGal6PopUes6xayaEC6XzeIB+Tu9xCS7lUWoJy+O6jat6GSyBEWov10KxF362312/5KgKjS01SJQw7Jua1jdzFQgm+xJ1qYhYPQVwS8s2a/t4sYsVrGa1TVmTNrpSDXcYW0zEy6Yz6cWtXFPgeobrQkqeCXzy7DdloK3J8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Fri, 1 Sep
 2023 08:25:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 08:25:57 +0000
Message-ID: <6c60f253-966b-430e-bcca-692f4afc5dc6@siemens.com>
Date: Fri, 1 Sep 2023 10:25:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Enable stable/v3.2.x branch to be buildable with
 6.1 kernels
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
 <de7595fc-5ec0-408d-96fd-1e7bdd161a02@siemens.com>
 <56da2a8495504464611c37de708c4c09222925d5.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <56da2a8495504464611c37de708c4c09222925d5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3248:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e4e6da-b6ff-4d65-1190-08dbaac5113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b3x2CgvKsWUsuiXV4kTHoCWqAoaUSKnTh7aLtTXwoBYPh9tBClbl7MoX+6KK4luLzRS25xR9XshjicwBIc0+/QXP6SzT3my+AP82dvdkMqLfd3eAgbj/X0UN0cZYZHyW1UMbtupbhA77sabvF7qaXcTSnreGxVkaPD942nLYgzRIIuSFyqZIlzkoDAZsLb64ZM167poxwDa+dJ/PL6xEQUiGBmxzYik7yuPIjIu5qHG739ittxNxwTUa/691tUobjdALlNmE/2zze4k+V0gc9dy1M3Pq5deSijGOXobYcCJTEmMvIGVK+ZYzqZAI4ffeJl+rWxxsfiTFeeKr1G0Bx3ojke/SlUnlw4pRokl846Y1PIeGA4Mfa0soCy0kdfpDtDoQZmtt4zdbMf5kI00DltpxbxaUX3kz8wLE8uyaHiIvjxu8sD2fviN9Fine1jWyP6QchEZUzgz+YUwL8eyTFMHnQfuG3uRuKV/H8qW0Ctn4M9T+vpzdcYUoYEz81I3TkBpQ5J0g1WcpbenO9PFfYY6unNOPpTvDKUo4mO2Ro8WPvFIRrnzKTop8lnfFR0845uUXlSGmorS+DBUlqXz610SdGuvAafxJjdlTD5piWMRyySDVh9EOEFufLbM113wX+UEcxi3VLpDlGawNFnx70A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(44832011)(66476007)(31686004)(478600001)(6486002)(38100700002)(2616005)(36756003)(8936002)(53546011)(2906002)(316002)(5660300002)(6506007)(8676002)(26005)(6512007)(31696002)(66946007)(82960400001)(41300700001)(66556008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejJIRmorKzFOTUpLaTJRVExwYWtDZmZsWGRnSm80SC93aGx3UWcwTFNHS0JW?=
 =?utf-8?B?VjlyTlNYaXVML0lZbGZ3emRqRllZa0pyNWtrZEtJVW52eEJiOGxsa2RkelFO?=
 =?utf-8?B?dEJOaUNOWmRXVjlPK2RWUlhsTnJ0V1o3MExKODlXcVBISi9wZHVkSDNPenVs?=
 =?utf-8?B?anI3OXc1cXRkSWYxSW8yeGFIUGtraDdXU0VxTC8xOVdPRXZVdnUwVnlwZUt4?=
 =?utf-8?B?eVVpZXNjcnFLUFBOTU9uWFNzWUJUbWQ3VmNKa2Z0U3M0YjkvUVdPZ29BOWYz?=
 =?utf-8?B?WlRxOTlPQmd2R0wxN1VIcnZPVDBwYVN1emlkNU1aZE5ZRklmcUdBY2xMRTVj?=
 =?utf-8?B?T0xHSnYzSElSK210MFV3b1RBdEg0eWRXUHpmTEtCNmltVjEyUXhyNjRnTUlP?=
 =?utf-8?B?ZkYrVUtqL3dUVUwybjVRVFl3U2ViYTk3TytYV00xQlJVUnhuK0lsaUxnU05S?=
 =?utf-8?B?QTVGNnpCZXBXUFFFdTB4Y05kZ3g0ckF5a2IvVWRnTUIrcmIveFZOalpHRE9i?=
 =?utf-8?B?TWFyNTBRdHYwb2JJMWpxbzJOaGhiYzZZcVYvditIUUFTNkRWMHhhakxGdEZ6?=
 =?utf-8?B?SDhEeGpPWC9ZMC90a0oray94NDZ6ejdBTnI5L0MzSWFXZ1kxNEhVNVp1bXJU?=
 =?utf-8?B?aWw3RWtTZ3MvOThyQXd3ZDEvY0UzdVRxaHJHOHppb3NIUzk0b2ExNnVvU295?=
 =?utf-8?B?U2VLaWhqd3E0MW0reUZjWjdnRDk1cW5zRGpHTSttQVAzblpoZSt4MGkwVnlp?=
 =?utf-8?B?a2ZjNUhjWXUvaFdNbjFZU3Y4eVFjWU5LU0huK0hOVkNjb0xyeWZNV3J4QTlp?=
 =?utf-8?B?dXNwNGMwa0Y4dFlZYVc1WlhJZEs5ZWg3ZVZTSTBNVUpram81UmdLd3RGNmVG?=
 =?utf-8?B?WU5wL2JMVm9JY1lqWnlpVDZvMmsvTW5sY1NHNjkrbndqRGZHbi9HUmY3MWtL?=
 =?utf-8?B?MS9YMDlncjVjMnE4VmRqVXprdnFoMm43cXI0L1NuYjFKeU9Qbitsd0RMQUFt?=
 =?utf-8?B?VEdSNFNUc0RBdDcwSzVzMTlGNzRPODlkUWFvNFY4WUx2c3FWOTc3aHdqTGhF?=
 =?utf-8?B?cld3cUVtd3RoaFh6eHdiek9CSjhJZjg2U1dDOGk3aHVNUGR3NnJzS0g3aXdr?=
 =?utf-8?B?cGV3cDc5NnQ0MHJ0NmVTUHYzTk9ocmwrRmpTd3NYSTJ6SjBEOUFFWHhBd1E0?=
 =?utf-8?B?dHJDTzByQVMxZzFJUkNnYi9YT2ZEbms4MGVUSG1TTWVBcW1rbm1NdW02bThM?=
 =?utf-8?B?N09zUWJaaGRudXhCR3lEZ0xYL3lQSWtmdyt3d1B0ZWVrY1R5aGYzMUFsRDFQ?=
 =?utf-8?B?SmcyeEJrNm0zR2EwRXZoTVpWbjdqbk9ORWZpN3hhdU51TnkwN2hpL3FZQ1Fk?=
 =?utf-8?B?ZWY3bFFBNTVkUWxSVW1aTHU3d29hN3U1UnFZc3ZvSEUrb1BLdnYzUlhwc1Zx?=
 =?utf-8?B?S2pRdWVRRjVidll0WG9KbSt5b1k1TXpTSEF6cFh2MitOTFpsRmJHeE8xT1U1?=
 =?utf-8?B?cGZWSHpxblFiWTRMN1FJcDk1cmY0Q1NRR2NLZzNqUnBQTndPdFBTSEl3SEs1?=
 =?utf-8?B?dkxZUmtXNEpxWVd2NDBHMjJDQnJaT2M5V01CTXkxODR1TDJ5VkpBNzBvUEI0?=
 =?utf-8?B?cnIwUitKRDhPU0JYQXMvMzQxWVo4cThZSGZwN29OZWN2bld0QlA3c0FReUFF?=
 =?utf-8?B?eVFBSWx5SC9hQTYwdWI4QnhqNWgxYnYxaXRIVXFjcEIvaU5JcUdNU1NpQlNE?=
 =?utf-8?B?c3FiR0p0WHZ4cC9DOGt4RnU2bXZzaEwxaU5MMCtTd0k0TFo5RHZCWFdxM3ln?=
 =?utf-8?B?RncwNnU5MmJXMXdhVW9yYTZPVlN4OGVoWFRjdGZjMWlOODgySWd6eFd5S21i?=
 =?utf-8?B?QmxjMUpRN2RVNDQ0RTlGdUNMcGdCUEt0dEtJWnZaMzVKR3A3STNGd2tETFZ1?=
 =?utf-8?B?eXVGN2RISXEwbS9kU1FSNXl0YUcyVndmU0w2VVB2R3l2QzFiczY0bmQ1d0tt?=
 =?utf-8?B?UEdkWlFIdXFDYmk5VlBwdW9zMUdXMWlTYmZwS2RraVR0YnJOSW5YcUQyMDNI?=
 =?utf-8?B?S3c0bHNjY3F2ZFF2UG0vdkpKUjR6UitYdS93cGpYWEZnNy9xMkRnOGRncjdW?=
 =?utf-8?B?ajFOb2dFMm5RYzN1UnZwdlJlL1FVZUcrS3BpSHRMSlNaa3VxUDNxWGlBOGo5?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e4e6da-b6ff-4d65-1190-08dbaac5113d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:25:57.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzONgEUCjAn2dlxZyp3DCnM/7xx/aiZSnoIYKpFcyNewPkwb+NUEPwztfCbzBJJcmJ1qTPchfMdrKcX5i9pskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3248

On 01.09.23 10:08, Florian Bezdeka wrote:
> On Fri, 2023-09-01 at 09:12 +0200, Jan Kiszka wrote:
>> On 31.08.23 22:37, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> with this series applied the stable/3.2.x branch gets buildable with
>>> the 6.1 LTS series of Linux / dovetail.
>>>
>>> Most of the patches were taken 1:1 from the master branch. The commit id
>>> on the master branch is mentioned in each patch / commit.
>>>
>>> The last patch is a manual backport to support 4.19 kernels. The
>>> referenced commit in master did not have to care about such old kernels.
>>> We already stopped supporting them in master. Please review carefully!
>>>
>>
>> Yes, this needs careful checking and a second thought. In the one side,
>> some driver changes are more invasive than I normally take into stable.
>> On the other, most have lived in master now for quite a while.
>>
>> If we take all this, the series should be reworked to avoid obvious
>> build breakages during potential bisections. That means folding the
>> fixups for kernels <5.10 into the patches that require them.
> 
> Folding should be easy, but I think we cannot avoid build breakages.
> Each patch is basically fixing one or more build problems.

I'm referring to build breakages for currently supported kernels, ie. up
to 5.15. Having 6.1 only working at the end of the series is no issue,
but patch 4, e.g., breaks <5.10 first, and only patch 16 fixes this again.

Jan

> 
> I separated the necessary backport (we're talking about the last patch
> only) to keep as much as possible identical/unmodified to the master
> commits. Maybe we should move it next to the patch that it enables for
> 4.19 instead of folding?
> 
> Florian
>  
>>
>> Jan
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center
> 

-- 
Siemens AG, Technology
Linux Expert Center

