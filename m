Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EF40C0B
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IuEAoBe3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHvdJEwqLzlnyY8oE0K9vnokZEwIK7s0WhEhEdejUTwVgaVgzpFogImBgOSnmg/QJtRphhTfW0Bk+/sLASqZE8Lp5yb8Bni6l9N9VWVeAW0CygptFO9QpGCkVUTECs3mtqiV8qTw161DtXf7GlKSP3pEFAGr9jqVijcJ8gqTzUdf3qL2Ews/nBB591Uh9HzoBGOzvbn56KDhcm+iKv3Ypu+/yc/aS6kVfeQ7UApvXyvCPOkqsm+4CRWEWQWmSi3cJI8nxxE6fx3bdZeZKQZQCdOohfn+XMZp70TRiO2+DUHjGKwKOfs9Cvl51/QiZavHqrdzajMVBtNk0PjopnOGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95m7hdKnyHzwyOCWEyA7H8oOICRl5PohHwGR84OIavc=;
 b=WENBDYRHKpsubVgtcg4CN8HTCP13LojIMcz/JD4bbqujNWdnBpltI8n3r/U7qZBaH6SVcnORxQ+vy3T9F+uzSj+kD9UHWcGbzJmsoZin6gFhrnYEKKIXQEkkswSEjahoqRUGi2y3603K9p0ZsQj6DxFFVjPxX/QfOdUUbmT3bYnwGrNKT4mSe8TPmZkAuOeeQ2Cy4g7C4oBlAZDc017RG3tYerQb6IPTvg/p2gV9uXSsrWMop+BaP/wu9tsRt81tvX/KyXJNmDRAMi9D2pXid8VbZEgoVluxHL88nvok7HnnrCIwkBwWnxAIzOHi9R4NF1a9/vWASPGDGJzFIORO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95m7hdKnyHzwyOCWEyA7H8oOICRl5PohHwGR84OIavc=;
 b=IuEAoBe39HvvEOVUV5+nL8f1r8fjPlSFS1qdUDyC1JUYeSKrvDKEyLn8ol8ZRdtqjniQ2Vfk8zpDfp9DLJha2EpHgTh0IjeKtF/tmPAkMXzQEwFM5M2Iwk3UbK197MEuRAWCOmOPbkYnWdim1sTat6qxLUuckkFUP0EYXx6xtLU7lakbxFN1I86oV0vBagiiWxl7z/BcURBhg1f1/Zv49TX7Fh8oGXuFhPfNP0TB2lRZYKPWc3sCiXDCA3V3MHDWUJZpBE1rN/jA0cfsYvy+CzlcbxGARvaAuBjhvQcFpjER2k7VQfO6W8BpwR85wy4OQQPol7+QHVh+SejIW+rC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB7943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 10:43:37 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 10:43:36 +0000
Message-ID: <8842c65f-3932-45fa-8361-9ebc119f2882@siemens.com>
Date: Wed, 10 Jan 2024 11:43:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 07/10] xenomai-4: Add evl userspace
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1704861962.git.jan.kiszka@siemens.com>
 <4308209312d585ddeb399ced286f216e267b6284.1704861962.git.jan.kiszka@siemens.com>
 <ecf1a4f2e7e2c73c68bba8734cb994d6f2d66971.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ecf1a4f2e7e2c73c68bba8734cb994d6f2d66971.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: b34db04f-22a7-49e6-8100-08dc11c8ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H52+XKlm2I4jxIT7zUWsZfQy9ivyxJK7apM+0mxQX/dDOWcOkFABcgR1kokhAaNzVLS7zilk4I1G29lbKn/4Pi51F8gnsEFwUfIxuRnR/sA0+Symo5RD3pXf3k2wRuDQR8kvG5p2DXIGjWwMZAWgH+YBJZ2XAPrMfW/2Nrab2Ih+dirM706mgV2BQc5OQjiHWiriWp/i32lsX1otrDDy9wjxV92rVpC8dkVhwX2pI7FTZGAcAs+QbFHucrsIuRR59bDW16T6+Af7M+aRPfYbVJBScAVK+MsJPmq0RNXDyC5BCs/7K8e0VuLm2x81hLtrXg7cIOfvUaZ+4zPWwELO1H1IGPvJFIGK3QzdrGVHMH8H/duRg1fU4McRCpI2udIq+7HaeuypvFil4K0I1woITYgp25DztTroxWn9l7siVfEnwpKfUWfVa1I/wXhtb/EaQuRVpKgle+w+Cgz4QTGb3sTVmXd/jq1uHTYbgp6y2nzp4msJSx7S3K7hfYnwnwgckwg7hHYdMsIhA2OC6M4b3kZygV1tB6+xNWYNBLCdZHrb+ZIbsF4i5+FQ5ufEhm7PZ/i3M/8UhVMVw0N4BqFlDDlW9iwGGv0y9vBIBtC1I/OeU2ZHeMmhS2rGfYQR0GW9G+AG8rMOAgApo1wdCzPARQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(83380400001)(6512007)(53546011)(6506007)(2616005)(5660300002)(44832011)(2906002)(41300700001)(478600001)(6486002)(316002)(8676002)(8936002)(66556008)(66476007)(66946007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkxZLzZFUCt3V0l3L3ZrbytlaTdHZCtKSjVYTnNXVngxNExDNzRtZTFJUkVI?=
 =?utf-8?B?Z09MUGREcVU2QStLb0RIZlpJODZVa1hCK3BBQ0pISWpjbzF4OUludktxK2c1?=
 =?utf-8?B?R3pJRXFYMUtOUEMvZFdCMSs1eDBCZGRvVU41ZUc4dDJOZit5WVFNdXlxd2ZJ?=
 =?utf-8?B?eWNRekhBMXQzMUpyaVZXTkZnOTBDdzRuTnVIMzQrRVhQSlpKZUxwbmFDR21T?=
 =?utf-8?B?dDluVXowSUE4RnN4T1ZLTGtnQWh1OUdrcHBNR0RxR1E3VlQwa2huNWQvZS91?=
 =?utf-8?B?elJPalBObmxpdnltWm1RM1hPKzBiVEhNcnQ1WjZxOUsycktwdkNWaG5rTzd4?=
 =?utf-8?B?cUZCUDVtdjBHb3VUNHY5WDJ2dDF6dnN5NC9rS1U5cTBjVlpKNUM0TDJOSFNU?=
 =?utf-8?B?YlZ5V0FmbkhUSEF2WkhrZmNaS0lsWDdqdHZ4TDRUQ2pyaVJQNXN0am9FNGE2?=
 =?utf-8?B?RVBWWkVZejVhc3ZIOE4vM1c1aThlRkF4dGtna0lQaFBLMVcyNTQxWUo5ZFFQ?=
 =?utf-8?B?VTkvS2FzMEk0dU5TS2EycDFpeDJXUVFpS2dNSHdCbitHMjIzRk0rMEUzNXFH?=
 =?utf-8?B?RC9DMEFHZE9UVHUvQWpHcFBYWW5JZDBURWVUc1pxeHBYOVZ1OERldlltR21O?=
 =?utf-8?B?SUpMbi9uTTdYZDFGREJsd3JxSWtSdjVOK3hOYjZJa2luSlVEazlwMWNQVWlp?=
 =?utf-8?B?dk1EOWlPaHJGWmN1THF4S1libmxndUVvZWx0NHljKzE3UVJaMklCRit6Y25Y?=
 =?utf-8?B?b3ZVZkpBcjd1Y0gyZm9YTjc1SmdhajRXMHp0Q09GSkNFdGl1Wk4yVjBDRVZq?=
 =?utf-8?B?elZ2YS9STW4xc09BbDlUMEQ4L2JCbXVhOEUrazdEY1l1dUREWVFCTXZVSVpM?=
 =?utf-8?B?ZHp2L1h6OHlSMy94Y1FtM3BsQXdCekE4SG1NUTFlYW4xdGk0VW1va3NKa3JL?=
 =?utf-8?B?WHZwT1UxVjdZeHBjZ3RVRVNldWZ6NmFkL3k3UThGeTAzZUdTR2l1OVZZL2ZC?=
 =?utf-8?B?L0x0dHRYbkdmdXFEKzRJcmgxZDZhLzhIUERTbmFXRklCZ04ybDNwS0JzeC84?=
 =?utf-8?B?dzhMYkN0NWFhTGJOaTVmKzVMeEg0a3d4S2RrWEMybHkzMkh5d1lyUHEyV0RQ?=
 =?utf-8?B?d09hb0xSSWl2dTdDdk1rSk5DVURmdjMwR21nT3pEOTVQRVlNS2QvaUZvL2VP?=
 =?utf-8?B?bVpEMDFtaVp1WHFXNUNjaUk0TlV5NHVFN1dmMVVTQXJHVlZVS2Q5L0crNk51?=
 =?utf-8?B?Uk9TSEVtb3lVK0UzdVpNTmx0TEdiMGJRMEwycWJXQkdWS0dLZWx4Qk1uNDlY?=
 =?utf-8?B?eTZwWVphQzBhNThQVDFEbWl3eFkrWk1HOWRTK1cyRWp3akNIRnkyRVNlMnVr?=
 =?utf-8?B?cjNFWFp3Z3FWTGd1S1NVcW5tYXZ0dUEzRFE5RktHUzZReC9qQ01SWjE4ZkxH?=
 =?utf-8?B?RVhqalp6ZUR2ei9WclJHaGluODRuSG5oUTNaRnhqd1JnTjU0VXN1bXlwUisr?=
 =?utf-8?B?RG45bzNpTXVTRWsrMDJrZS9WbEE5WDhTUWZnZzFpU3ZhLzR4WVZLWDBWd3Vm?=
 =?utf-8?B?SWszQllBQmU0bEpVL21scXh4RDNCdlBielYxbjd2bUsxZ01nSGhxeVlobmVr?=
 =?utf-8?B?Ky91T0FjYk53OTZFeWhIQ3lxU2FuUmtTUHE3Wktqdk9wSlZlZ0gxT0NLNkg2?=
 =?utf-8?B?TTJ6a1B4cnd1V20vWVd4UVFlRHdqWUNmRHAzOE5ZM0VrU1YxK1NWeXBtdHh4?=
 =?utf-8?B?eDlwL1lQYmNMTXZFYmFyZU1LUTdSMDNVc1ZGY09qTTZ2am05RjZ6SHhvcnU5?=
 =?utf-8?B?ZVozbldjeVNHQUlDb1FWNUhNaTlCeWhDSUZjYVExcGpwWHMvNWZiN2dYWUM0?=
 =?utf-8?B?RVRnOW5Ma09NNThDRFNtNDRteVRsTUZhbENUMWQ0T1FSbzNFc3Y1VGJ5b2li?=
 =?utf-8?B?M2R6MjdzNXFNcUk2VjAvWjJMbEVzdEdmc25rRW9uWW94ZTl1cXgwUXhNNS9y?=
 =?utf-8?B?WW5KZmpsczBZZWQrZnc3emdBb2E3dmxxY1pIT1Uxa254cFk0RTMrVGxzSHZh?=
 =?utf-8?B?M3JZT1o3ZWVoRTZKYkpZSFd1cExxeG04MjE0cUVMcmpHVWtPcWluSkEyUXZZ?=
 =?utf-8?Q?elyJdNeIdfHXJ6zQ4EyO9vUOf?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34db04f-22a7-49e6-8100-08dc11c8ffb0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 10:43:36.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmaKq9R9qDN3/vfe0Do1Z+FiuUqeQ2aUi+y88Od8csOHBH+adVoQOmkYvQBV/Sj6yxhsb7Jom4BVI8Ujbb4wBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7943

On 10.01.24 10:03, Florian Bezdeka wrote:
> On Wed, 2024-01-10 at 05:45 +0100, Jan Kiszka wrote:
>> @@ -0,0 +1,40 @@
>> +From b4447250c7fff6940c1bb6f0308da617bebaa643 Mon Sep 17 00:00:00 2001
>> +From: Jan Kiszka <jan.kiszka@siemens.com>
>> +Date: Tue, 2 Jan 2024 14:01:19 +0100
>> +Subject: [PATCH] meson: setup-uapi: Take Debian multiarch into account
>> +
>> +Check also the Debian multiarch include path for the chosen architecture
>> +so that we can support (self-built) linux-libc-dev packages that contain
>> +the evl headers.
>> +
>> +Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> +---
>> + meson/setup-uapi.sh | 12 +++++++++++-
>> + 1 file changed, 11 insertions(+), 1 deletion(-)
>> +
>> +diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
>> +index f2d0774..633c5ed 100644
>> +--- a/meson/setup-uapi.sh
>> ++++ b/meson/setup-uapi.sh
>> +@@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
>> +     link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
>> +     link_dir $UAPI/include/uapi/asm-generic .
>> + else
>> ++    DEB_HOST_ARCH=$ARCH
>> ++    if [ "$DEB_HOST_ARCH" = "x86" ]; then
>> ++        DEB_HOST_ARCH=amd64
>> ++    fi
>> ++    DEB_HOST_MULTIARCH=$( \
>> ++        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/dev/null)
>> +     link_dir $UAPI/evl .
>> +-    link_dir $UAPI/asm/evl asm
>> ++    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
>> ++        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
>> ++    else
>> ++        link_dir $UAPI/asm/evl asm
>> ++    fi
>> +     link_dir $UAPI/asm-generic .
>> + fi
>> +-- 
>> +2.35.3
>> +
>> diff --git a/recipes-xenomai/libevl/files/debian/compat b/recipes-xenomai/libevl/files/debian/compat
>> new file mode 100644
>> index 0000000..f599e28
>> --- /dev/null
>> +++ b/recipes-xenomai/libevl/files/debian/compat
>> @@ -0,0 +1 @@
>> +10
>> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
>> new file mode 100644
>> index 0000000..36eb68c
>> --- /dev/null
>> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
>> @@ -0,0 +1,11 @@
>> +Source: ${PN}
>> +Section: misc
>> +Priority: optional
>> +Standards-Version: 3.9.6
>> +Maintainer: Xenomai project <xenomai@lists.linux.dev>
>> +Build-Depends: ${DEBIAN_BUILD_DEPENDS}
>> +
>> +Package: libevl
>> +Architecture: ${DISTRO_ARCH}
>> +Description: ${DESCRIPTION}
>> +Depends: ${shlibs:Depends}
>> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
>> new file mode 100755
>> index 0000000..9c9148f
>> --- /dev/null
>> +++ b/recipes-xenomai/libevl/files/debian/rules
> 
> Wouldn't it make sense to move the debianization into evl like we have
> it for Xenomai as well? In addition it would follow the "upstream
> first" again.
> 
> I think it has some value if someone can run dpkg-buildpackage on evl
> and doesn't have to use xenomai-images for building packages.
> 

Yes, may be worth it. This one here is likely not yet complete. E.g., it
lacks a proper split-up into multiple binary packages (lib, tools,
testing etc.).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

