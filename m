Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E410E0
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 13:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzvRbBxFze8UJPVnLKREYVYqpIS8xMv6YPcOGK+zxUeNOKjWd7VS006lKAQ3KuwH+wZZNDjTEVDaez5LLbXsi6PM+vnw2ydOLeAsrtVlrT4Ojx9J/N7dRV7a9v1JWeKklnhkUtrgIi4ZnbiZC896Is+EdKdYk4hJBGoyEEVCcfV6+/K9+PUZSj3QsotfZBkreJLaSq72TZm5lQxj2BWMd38Yl3BcK8iuLlFoc1ahLdHFElhRUR4psoyj+BS+vSgiO/yBeviYotZzjBqYaFmRFADYx8pCD3Nb8t9xhUBlILMZvqfygEciojrORxNKs4wZ9tNCOzoYA2vDTyNbW8LfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ox+10V2V9VDZWMXzubw6SXm1UldpID+1mXnHzkACvk=;
 b=jp0gm3x8nyiP+zQ5YgEyii1mJsOQkWWb1lG7N0crKZjg0BtPiZCvG8XqwN+Tkk1ePNHHunz+dAfmejpNhFjp0Ln2Y27yA1kXQCrSjzBZ+9p2m8QrmQP1DmiSH42W1E9moUeynEcPHePSWFGwuKrhs8bgTcXOw82gls8qfHRGps+ECsC1s+njIA6OPPfmHJWO+4V+cjZcOmiJsA5qnhxWQMizDRan5L570yT+A0DNyKqOtwo5jTFXioEMXzvlIvv9Uy4LzOvEgOOkdZKAUhdJ44+7OYfkl69mN16Wf+JOMjQkrUnwEqmzHSQ7jLP45Z145mwhWU1hqKuCCiW1HenicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ox+10V2V9VDZWMXzubw6SXm1UldpID+1mXnHzkACvk=;
 b=syvUm5YemmU9OXTC7eg8gsB7fICsOfRlaRi79jzZAfUfFD3NZoXX79flSgqFGG++ij9B5VqGG4QStlP8TSWv4DvcljsZ0JYl8//ATNIy7SdsoYMz9XgMU9WeKzxOucWa6+4MhHd7kd+MddPXyfN2wv0b3Da83P05jTtJxigEmo1Jr5FpY+cIQC96HS6vZEfKTXemCN0EF4hQQeTURsgn98mJImLgXGVhfJDz60CZVPhpPyHp0lOVt+vwYccjv9Iys7UKy0NMRMpEOb9uYCUvyuoWwyx/GiGoUgjJs6PiNLeQuNk9pV2BRJO9K2kJZgLpgZ+D2uDG6efI4jZSRRoMSg==
Received: from GV3P280CA0034.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::31) by
 AM7PR10MB3639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 13:45:13 +0000
Received: from HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::47) by GV3P280CA0034.outlook.office365.com
 (2603:10a6:150:9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 13:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT076.mail.protection.outlook.com (10.152.0.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 13:45:13 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 5 Aug 2022 15:45:12 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 5 Aug 2022
 15:45:12 +0200
Message-ID: <2e3d458a-65ff-6465-9f9c-7fa4ae44c5e8@siemens.com>
Date: Fri, 5 Aug 2022 15:45:11 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] fix build with clang
Content-Language: en-US
To: Norbert Lange <nolange79@gmail.com>
CC: <xenomai@lists.linux.dev>, Norbert Lange <norbert.lange@andritz.com>
References: <20220725084231.8584-1-norbert.lange@andritz.com>
 <17cb9146-1ee7-ff17-c7d9-ba59cad6e292@siemens.com>
 <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CADYdroNMD5WwO3ZAVZ3UZ0=fbg0hnR7Xzbbjh2qP-VOUS8Cn-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--24.070100-8.000000
X-TMASE-MatchedRID: 72nS2hokiaQepAyha3ctZsU8jBVxKY1xPg9yfk4YC0YHg/3jhUF469dJ
	Rhy28lIuLX3qyf3ewG9N6CjTVr8dyrwXBELJxfx3j0IvV7jlqDhyPzMTUSO1JPzTlJK+gA836Hi
	gDLMyLuaFTK6KCpk+DNI9YVIwAnUKeeD0uelq9duuyvagOo6URo5dVuh2ywvhXmFVlObh0PxBfk
	JWKY0KaWOMyb1Ixq8Vg4daSG/gsBQXxDANc7MuDiFvIo822GyY2mNWQRnjOjo4hD0Y/Y/a730tC
	KdnhB58vqq8s2MNhPCy5/tFZu9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.070100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 6846698BBA2D2120FB0DA9898E0973B382C002AFFD241E8A342F55224C2B76B62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1d8b89-7a01-4ce8-14d8-08da76e8b8c7
X-MS-TrafficTypeDiagnostic: AM7PR10MB3639:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gO/BbEsdfPPZYjBz8U9jfWuAlWD7cc64CCeaOtBaZdDg25UbsKEbrcFS+KFYzab9JwRfshH6JldpHxpfHlCliV9qf3VG0vnHHB7wGG1kzB+Q8IqfLqPnnyq0Mbb0KPsaTm0I9BLH4r6INglTFETyCMU1r7au3/Q4i452GjuA7ZO+jt+MLh0yTP1h/vnn2ye4DbjBmHDnreLEbJxE3cv/SIm65+05XaiNwJ8YvZpj6HouewDjOlLGyHcIokvC7n6+jdjgH6cSO1SCTMtnpivHxxXsunONt5RqHttmly51938+iRyv4I+fWDI0t5L+FSdLqCXkXhQfpuYJ/s/sJQ5v1a+4Tme6T5ydJVGUmGiZQ6BFuMHiv0fqXxyJjbWo3eMBBmLOIcuylcysV2nsUqgaNM25J/d1NbFlmIExGrDlkCSguqPQbJU2lpgfXm8gItELJ8uI5UM7UohCEL/Do7PcFvuCaH5HBCTFQDolsiJdje9KZk6p9SnTEdbjD6FB+Q+QUR1Avc8uNr2m9v6dLss9yQVIqhAyNRK3gbXvmNOycDX/l8w2VZLebFbBzaQoMMkhRjRS/T0LUhwxwknbFo0eslhSbSCn4+zljJ4abO7tzBNftT/JexyytNk+KysV/3NQhgW7jnbnlhdRxUYpImwk4i9wDZ5rPRufPR1RS3sedCGkl/bJxpZ9GjUqvots2CAFg8cMbuPGrqEN+6zVYahpPKqhv6BS1Rj4H0xtGkm+LhhBiPZyeOK3onHphVppw0l4PtOzBw5m1inpMYKTdQhbkzE83I3XopGe94x4WHWy4MprCHY6c/9uzLLykRCq4rMKxK4muBLEl9cDna1FddHqgw9dIRLCfVNdXL9lOtxt2RHGZrRFW9GS66lq7SfAA+KeqEiClV0paZ/2L39r+GHivw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(41300700001)(86362001)(31696002)(26005)(53546011)(81166007)(82960400001)(336012)(186003)(82740400003)(40460700003)(83380400001)(47076005)(956004)(2616005)(16526019)(36860700001)(31686004)(8936002)(5660300002)(44832011)(70586007)(356005)(70206006)(8676002)(36756003)(40480700001)(4326008)(82310400005)(2906002)(54906003)(6916009)(6706004)(478600001)(316002)(16576012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 13:45:13.0110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1d8b89-7a01-4ce8-14d8-08da76e8b8c7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3639

On 05.08.22 15:42, Norbert Lange wrote:
> Am Mo., 25. Juli 2022 um 19:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 25.07.22 10:42, Norbert Lange wrote:
>>> clang will never support 'variable length array in structure',
>>> and there does not seem to be a reason for this weird construct.
>>>
>>> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
>>> ---
>>> v1->v2:
>>> *   fix algorithm
>>> ---
>>>  testsuite/smokey/memcheck/memcheck.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
>>> index a33700f49..b11d2babd 100644
>>> --- a/testsuite/smokey/memcheck/memcheck.c
>>> +++ b/testsuite/smokey/memcheck/memcheck.c
>>> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
>>>
>>>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>>>  {
>>> -     struct {
>>> -             char x[size];
>>> -     } __attribute__((packed)) *base = vbase;
>>> +     char *base = (char *)vbase;
>>>       unsigned int j, k;
>>>       double u;
>>>
>>> @@ -92,7 +90,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>>>               k = (unsigned int)(j * u) + 1;
>>>               if (j == k)
>>>                       continue;
>>> -             swap(&base[j - 1], &base[k - 1], size);
>>> +             swap(base + (j - 1) * size, base + (k - 1) * size, size);
>>>       }
>>>  }
>>>
>>
>> Thanks, applied.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
> 
> Could you cherry-pick this commit to 3.0.x and 3.1.x aswell please?
> 

I can. I was just not expecting someone starting something new with
clang on these old versions now. If you change something as fundamental
as the compiler, why sticking with that versions?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
