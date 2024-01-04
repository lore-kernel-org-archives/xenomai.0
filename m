Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138622EEE
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fulQj+KL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdO7bSql4HcMKqnM42AOtpdJUo+ZwDvHQHtyea28F/Lf0bgvF7P/e2PLPaeHhRrPCaw4wPtrMMmhbqZKUmTU9okQBNbWPAaU64jsJdd/q6K98eqUamkBot5mTGld20wHnqO+fnUgiAO++IqPetsja+YXGz4O8VfMJJ98+GqU33lzNQ1yhC9VaM4TzPYgYpo8nm/pii/pjpoNXU70ujtKW5db2ilOuRr2kw0CL64He92uVnMs7qNCEt3ZBAOa0zux23i0v/6Au5KfGWiBA22YRGlvvpD0na/SQKu6QZsU/53fGO5GQxh93vxjz/IF1lzzJm3A5AefEXAV2HObQjTvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KEE4y5S45hZpgY4JDA+cqvnsN1HR3xP3K7pZPn1Ae8=;
 b=Mi3NNj8VQAgdymlm7+KXAoj1Z5xUSZcHquThppdOy5gP+aQU67fZrZu6U/uQoXVKhJNLIfsOi5Q6l6+1maV/To0kTiFlGghLuWGAdLwwdzsrVQL6l63HCd8s2CZ8LV4BcGlj/H4OxykjOGTcmZDNs9ugEbR9oZa8RyGakOrfLQbK4YdnZ2DUNFDg16bVHQc4U0t0y6dcK86WwNeMd9mQIU1U7NwvRQKKXbzR8PG4DC7rn+jIh3d5kHWBKrtGZTQxz06B+NZSsMidsu2qUIe6KXB4v4xBeVdE3sT0r9zDj7L1aSgvv2TqUlgVrGEfGPQJ4mXrlviol8HQ+ftDw0egQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KEE4y5S45hZpgY4JDA+cqvnsN1HR3xP3K7pZPn1Ae8=;
 b=fulQj+KLXjZoBhJ/H7kcoXpynyaK50VQ9i5CjTngIPpZBiafXsCy8TPUQA6STtooVbW7JiXJvWxPF9D9Fjw/tdN4sNjEQRj8AcIsx4fY1f3B+zyiyVifDSz/NTB+E8GGm7Ei2Z+N5tjvLmntx73v1QTZciY0IvY2D4EYLwt1LogUw+D43X5g6+5yWEqMUbbhv0ldYo9ykM6GPYrXqo7I3kN6LoEvD1bmjdh2R96vj/GOobesfCBhoEGZopsKS6daHOojfbAMhaWqVwfl9+eVjU4G3sf/ol2o3sv/PFUotOnGZHy09Ip+HtquN5htXO43Z6l2Ei2EZcJTJBAbLs5tqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8160.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:57:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:57:19 +0000
Message-ID: <37d7878e-aca6-47be-9ee8-c934c672f397@siemens.com>
Date: Thu, 4 Jan 2024 15:57:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 4/7] xenomai-4: Add evl userspace
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
 <20231221163743.2923801-5-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221163743.2923801-5-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: cea49148-cf68-459e-8cfc-08dc0d35731c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7yyETghucFXraT0KdTayBZJHfqRZZUH5lMQU/3HSpMOKjU2NQ5LPIJ7AECqJf/NPINEYADIc7noDCWYXGft58qJG+6Qs4CbwDjxwxWXc5ayuWjCOvVtc7IZXeX7j/52a0Zb3wnlOs42kyxkvNhLpn4CM9ex6C7SEDgW9afGuwUTgcgGexkHaXdUC1NcmEj0WKMqJNlukQyNXE9GOpczziA41pTynnTe4aKWoLKoxKdYRuCT7cM9bPYMnfmqbORhyvqbMsxgNf8Rf1o+KpP2OE7Rva6HHVueCTsx33Ftzj4SB0TfAT5ODkwbbx0Z3eLHXEqiJiQuX26AX6tdCFTEBQ4axEnjxS0Me0VxSXstPTDBit83UHzIqUWI3pWoP2VB39iVySr8bugTLfFveahNueW43FSF1qmXIuGUedtfjzkPbvVK7+rJZRnNYluOkyTMyun800iuBlIU50sk1VNiTC7WMjph+c0+lHgOBPNvfFzqbZRd/8FPQ4/Lrd8kqYDxIGYSTC1bR0Wca8xJ0Y/913lsBSFP1VqYopEA1WbyofIrXrC9vRJEbIB4QvFhxf+7MV0DQMrBrw/rKkLAT7R2dADYDaJpvwu78v+84b9jvBbRjLGcgQrTRokiTk8G4USGS1phjMnx9vfqFOF9jIlk0cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82960400001)(38100700002)(36756003)(31686004)(86362001)(31696002)(53546011)(6512007)(478600001)(6506007)(44832011)(6486002)(26005)(83380400001)(2616005)(8676002)(316002)(66476007)(66946007)(66556008)(8936002)(5660300002)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkh5dnNpeGVtbVVSZGltTFZjcjJsWGd0Z0dMRTFMVXNjZFN0dklvTXJ5N3F3?=
 =?utf-8?B?djRaSmRCVjBrS3BIU3VQbytObGpJeVJuN2tBUnpvaGNuUnJTSlA2eEFRb3RL?=
 =?utf-8?B?bG1hS0pHdzlhbllDQVBYRytnTXkwVGZqM3Q5bS9NUnBmdnVNbmhBR0N5TnNT?=
 =?utf-8?B?dUo3R05VVG42WDNMb21XRkxJNTBtMDNidURubVFVdVBaS3pBUG51VjZJSGFU?=
 =?utf-8?B?d2NOZzZSVnJSNmRYYTJGZDYvOEZ1WW1PeVRKcEk1U3RUcnhhb2lJMlhHS3hK?=
 =?utf-8?B?NVV0Z2NjSGwxNWQ2Y1JrTndRNmdDYUFkbjF4RXJMVXpCVStqTzhoWXNvNFk0?=
 =?utf-8?B?OWlKY1RVY01sTmxKL1gvRmtSRnhrWng1V3RKcThtaHo5eHpFcStkLzViSklv?=
 =?utf-8?B?bzJ4SnJVd1RrbEV2dVlteXMwWEY5eVhtUmZYRXZlNWRuYS95dmQwZFFKN2VT?=
 =?utf-8?B?ZUZCdWgzYkRZVGNRQlVJYm1DanUyTHFHTmpVMWlhY1NSVUZ0YXhyWE5LTGtN?=
 =?utf-8?B?bUxGcGxIUTJlY1djdGZ0UnphSXBpVkdLdWJBcjMrSFhxRGpBVGdwZ01GK2lK?=
 =?utf-8?B?eDMxQVBpS0VPQmM5dUpPVXR5c3EyTEVRQjFFZ0t2Y05hbm41NGZ3Uk91Qy9I?=
 =?utf-8?B?WTdKN2MxY0RZaXhVWnlENFpHVzhpWUdYU21iTkFuZWR4R2d5Qm5vQjl5aEMw?=
 =?utf-8?B?YVhLZlZFQVRGUCtHanE1NUhCb21VSE9ISHBObUdwSDlXNVVFYWRPTTBNMjRT?=
 =?utf-8?B?MzlBTmt3SUxXTWpoL3pyMGVqekc2SXdjQlNkQ2RoVnloQ1dxdnhCTjEwcnk0?=
 =?utf-8?B?bUMxQWFzOG1pU0dScE8raWJzWTFVS0FlL1F6Zmdsd1FVNE5uaG8yeWEyV1Az?=
 =?utf-8?B?UUxLMGRVMXNtZ2VrKyswWDB0bEtXSm51dkJZVEppV1lSQU1sUjJBNExxRDN4?=
 =?utf-8?B?VU9RcEEwK0g5amFYQkpqTTJWaWRqZTAveTZISnpLMVRCRXQwOTREeFd2WUMv?=
 =?utf-8?B?UGRFWE5ma1lJdGhpRnpaYmJZUUJKQk9GV2lBUSs2a1ErTXFEcUd1Z01LOUVM?=
 =?utf-8?B?cE4xUEJmV3JuV3FHaDZYQUZISFZKU1FVMXBDVlFHQnZ1ZnBnRVUzdE9CRmhS?=
 =?utf-8?B?dTQvdlc0dUhaSEtSbCtqcDN0YmlLeUkwMVYrOG9MaGhYU2RXRXZLS2NPeW1N?=
 =?utf-8?B?VzU2VEJ3cEFJWGFHc0d3bVJkZ1JNSVNEY0lDaWo2V0lkUHgveTl0SEw5eTVh?=
 =?utf-8?B?TFBpc0JrREFkbVdVbmlFblpWL2NPVmVKa0ZDOGt6WFVxcjNCNnkzWTdLcm9j?=
 =?utf-8?B?Mmtha0F2Ky9HazlsRXdpck9iWVBJT0FpeURRenZnMC9iaDZ1ZmJrVUd6NGpC?=
 =?utf-8?B?bDM5amEyM010S21uQy84WFJxa1lTK3o0aUd6MXRYNkkzbWkrVm42bHRPcmVO?=
 =?utf-8?B?dytKemQ3QWdtdDQ2S0F4ejdnSFlmdXhyS3JTSHAzbjJrb1lzZ1NMdGViM2FS?=
 =?utf-8?B?ZTNBTmFiMjhtclNqZXcxTFpYZEV2WGd6WFpQRWlaQ3JJaCtjdElLQXZreDBE?=
 =?utf-8?B?MW5BQ1NVNUlBeU95c1duQUZjeDI2VFM5bStTMFJjNS96SXVrL0psSjJRdnBV?=
 =?utf-8?B?RCs3NVZxY09Sa0diQnpERlpyVFppbEFKRldENmpaODN2dHhQUHFENWtGYnMy?=
 =?utf-8?B?b3g0ZkpRdEdHM2FYT0M0SDFIREdXa2h2aGR5ZTNxdmdDdkkrcTlKbmdZZ0kx?=
 =?utf-8?B?cmlqcU5raFZiK1dFamVOc0NOUkg4TGFJcmt5WFZQUFN2Qmg4cDRmeVdWbU5Q?=
 =?utf-8?B?VUNNeUJNRGU2SStRTDV4WGNLVHpaNzdETkJGYWJmR1g4OGwrSEFjUUIyZHdz?=
 =?utf-8?B?M0lucC9aNFZTdWY4VEdoZWFuN2lLY0FvRzlJUHhLT2Y1Q1NxY29Lay8vRDVt?=
 =?utf-8?B?Yk5hMUE1RCtERUhKamZpbHZIQzU0Ym9rMEhsaS8yeVRFVTU1K1lwNTVTUGVO?=
 =?utf-8?B?eE5uZGlqcFpKNzIwZUs4OGxvM3gwTmltMTkyalgzL25rYWc3WjEzdjFZdFFt?=
 =?utf-8?B?ajBQSDdvWXdqTWE2bWZFQnNJdmppSndoNXVKRWgzMTh3bTVmSWVHVzl6dm9W?=
 =?utf-8?B?czZlNnZxbXloNnNyTDQzcWlqUHZ5ZW9RVjlxWlhzMFZEaWpZUXRxbkx1emdU?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea49148-cf68-459e-8cfc-08dc0d35731c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:57:19.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhTBgGrqiJfct4rM7jHKZ9XAnAaAR2Uvbtmpiu3U6QM/a6iQgA/mDM+iXSS1YP6xDJgzeg/PI74F/D4yKIgSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8160

On 21.12.23 17:37, Clara Kowalsky wrote:
> The libevl recipe allows building the evl userspace.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  opt-libevl-master.yml                         | 19 ++++++++
>  opt-libevl-next.yml                           | 20 ++++++++
>  opt-libevl-r46.yml                            | 19 ++++++++
>  opt-libevl-stable.yml                         | 19 ++++++++
>  recipes-core/images/demo-image.bb             |  2 +
>  recipes-xenomai/libevl/files/debian/compat    |  1 +
>  .../libevl/files/debian/control.tmpl          | 10 ++++
>  recipes-xenomai/libevl/files/debian/rules     |  7 +++
>  recipes-xenomai/libevl/libevl_master.bb       | 47 +++++++++++++++++++
>  recipes-xenomai/libevl/libevl_next.bb         |  1 +
>  recipes-xenomai/libevl/libevl_r46.bb          | 46 ++++++++++++++++++
>  recipes-xenomai/libevl/libevl_r47.bb          |  1 +

I think there is still some duplication here, given this diff:

--- recipes-xenomai/libevl/libevl_master.bb	2024-01-04 14:51:22.575483937 +0100
+++ recipes-xenomai/libevl/libevl_r46.bb	2024-01-04 14:51:22.579483931 +0100
@@ -12,10 +12,9 @@
 inherit dpkg
 
 CHANGELOG_V = "9999-${PV}"
-SRCREV = "${AUTOREV}"
 
 SRC_URI = " \
-        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV} \
+        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${PV} \
         file://debian \
         "
 
Jan

-- 
Siemens AG, Technology
Linux Expert Center

