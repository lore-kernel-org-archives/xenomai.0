Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60930F9E
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aLtQ5u/m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA4wO0CVGA41+7qpsmvxKE+lRSBxR4pvXzt+zOh+xs1Oe3TDrSHWLRvnIQSbkaTAhgEmlXre/w6yOWMIeuesSH1pwTqDITKATFt8aBRv95VFBOTqP1HQ0P479aESTEluM1oNVOka17LZHKdIKdRsJX71/hSiuOJ/s+/LGwmaCBP4hEeGrMs6JwNKXGx9WdoqUwp2MCQaDiJ+U2gpXxyf67OooYUblspnod4y102u9Bz5VPvHeItu9DOqqgK2QJwW4QB2AvrXiCXscWNWdwIlC3UyjlW3Lryz9+HlQyPg+V9RAv60CjrzntmOrXow2MjrayDdwwNQnTJGQc9nE/O38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLYWDB4siah9M8QKDRMOcUz8zLJqhvkOUZLx0rDSRQA=;
 b=lFTuluixtxWr153iRRXF0PUoZooofWh3vVymPweAYQI7x/YFWXqYB50jhuQY85KYKr8/RJs+zxWP9e/ehlffYX9AsuwTquwcan4ROibV0cPjFmxp/fnU/USSLFRqDUYr9udONWdze7/1SEuEVsnDp96CZVocn1+NXxwZz94MCnWT0rXB8x6Mz9bBObHcp0UOzjieVTzROjO+B7krKnBfW+y5wR7cT2ArdfWv+0EjmPCi1YIo2J6HR8dTL3/+2IgexxFbFvDA8dOymnYFsDl2ONgsC2o6EGuUlSEC2gFmwvoSAux+wtNFbGjBX4FPQ54VxVvFrkoiQZBdb75UdrL3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLYWDB4siah9M8QKDRMOcUz8zLJqhvkOUZLx0rDSRQA=;
 b=aLtQ5u/mSJekf+JxMtRKznrkROr+yg0fEqbJ2stNOuyTuvRwZuQnsHJratroYTpLywjyJM4BrKQvYHpqphD4SFZTC3Kbnwp4IY+wWleAq1800sJA1UgcHbfum1xGTDxfecgjp1qTDVVHJbkH0PtlntxYFAQRVaw+ij4snkZjIpIGcQchCLMU4NqQqUhziUWMZg/WtVNj1mmdXUTBPYOthAqfVyMFhzxCGoS14IXuC5GJR6iP/zzlG+Jl9Nw2VDv+qRus4nOrxFVHW0Lwm3f9ccjqIqEPPFwPdCMWypuLSHjmbfjzgFV46l8wjusJIPyBY1S929LXmKLg3MGo47+Vkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 17:27:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:27:33 +0000
Message-ID: <12213afe-70f1-418f-9997-1f9416933f50@siemens.com>
Date: Fri, 6 Oct 2023 19:27:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use Debian bookworm for CI build jobs
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
 <91c0fafe-7c43-4555-9004-fbe5eb43605a@siemens.com>
In-Reply-To: <91c0fafe-7c43-4555-9004-fbe5eb43605a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0c4c97-bab4-41c9-1cf1-08dbc69186ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEUJ7YqVjidBgJHoHwelyJXXrbGp9PnyzEEmetTuNqFhuXuXdFzX6HI1caLTbTAQMjOUvTP7k3wTP9OV9hIzxFvG9FD+cdcw//tjbbfAiOVLiBQTtgSGf4/BOdQ/tbuc928JCQ3Uw5jJ58VNOiW+IFVzw8l/PdEfgAJzr/xhUSM479MlH3EggGGdofhbOX/1MGC4k7TJwjuHXourx6hsesi4GWZdHgMcfp4WVKAV2+RpIJ04CS1ER7rQp6vO2na9WsKhMhAMbSQC3iQLOTBd5JD5HZsxqYFWPaxFZ7YuWYPytfxOKCm1x1RMcZaGZIcTfg5XZ3hF0vOlOBFOQ4V6L49PqDM9kbW7uLaByckVXr29AK6GUtZG2DbrXyv/r+Ji2WOdXNi6Lr+uMDCdUH8BbFTzD2/hL3MtM7fhTaOLEf9WLe/uC3q1QgPTWWnH3QAHP1leAjKjPdXyJ6Cr0caSmKRH90LXMCMgOG5gXMIYxlIlYKCLj3kziurSJmFMYQoK7Fq8fUJrjs2xG6ZYhZwhEVTbX5X6gKnEp/pwmFdFeVEr7HQsoIO+OvhX+sqNZUH5/ykqkd7jmBOkv3O8vvZFuuFRmTSarulMle/kfia1q1+6EZgx9IS1qPEDcvX1hPqyf1SndZL/8vwmdJILWRzd/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(478600001)(6486002)(6506007)(6512007)(83380400001)(2616005)(316002)(66946007)(8676002)(36756003)(8936002)(5660300002)(41300700001)(66476007)(44832011)(66556008)(38100700002)(31696002)(86362001)(82960400001)(2906002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk9GbjB6WUc4cHNUVXV5Q3Zsdm9KNzByVHRSWUdzdGIyaVVDK2dHdmh4V0hM?=
 =?utf-8?B?TDRDaUFKWUZwRytqbkRGamozUUxtQzFBekRGT3k1MGtpcG5KVitGd01DZE9F?=
 =?utf-8?B?bG1uNUgrYmpKQzVFOS9LWTF1TUt4Zm4xRWswWFZzM0xGTjNlVXlqWmliODVZ?=
 =?utf-8?B?SUx6a3pPblZEamRZNzdFNzdEdXhZSnZtLzhIczZ4QmphOHhrVHFhbmZ1SkUz?=
 =?utf-8?B?Z0Y4ZGx2RCtLVThveHNqUXREVGRUTlBVYkQyS3p5ZzFqY0cvMURnRHhMY3VJ?=
 =?utf-8?B?R3VsMHpNTmo5aVl2NW12SE5jWml4YnRjbzhvcGZXYTlJbDNXWEVwNzZVRmRu?=
 =?utf-8?B?ZkhnV0h2ZWIzWllkSG1kWENEckp1c3l3cURaNWdTRzN2MEk2SkJNL2hMeDdW?=
 =?utf-8?B?cEpJaVhlL0tlQ2NTZGlva2d1ZlpHbGVjOVh4WnEwVzZGMEJ5eXhTOEpGRU05?=
 =?utf-8?B?NUJ5bTJCcUN4ZlFpVXZ1Z1htR2NsOGowQW1XdzdVUFBWVTJFcGtCcEFVRExR?=
 =?utf-8?B?WGQ3dzhtZ0Zxb2xiV0oxQWRtak00YWVPVkNlR2tPemdDMXpldExRWm9oMnkr?=
 =?utf-8?B?bnhJR2crdS9qdXhsSGZXVGY2WkViTzJYNG5YaTg5N0VwMmlickxLWXFuTVpJ?=
 =?utf-8?B?b01GcFgxMUJEd3VGRGdSdXVYa1Flbkg0K1pZaUpmR0xBeml3bTRFWXVEcFZq?=
 =?utf-8?B?REhQczVNdEtPcE02M0s5VzJDNnUwbENrL1RISDM0RGtGS2RKSDY1SXZRNkE4?=
 =?utf-8?B?SkNmdTJVUGdwTHN4MmpLSEx0UHN1eUIvZHJGRVo0ZUk0YlRjU3BYM1hwUkhL?=
 =?utf-8?B?ZmhZTzVqRHVtSFNBVnRSM2dhUkNDWlZ4WW1sQ2haeHRaejNabDRGRGdhZEZB?=
 =?utf-8?B?aVhSYlhwRXFYTUpVeWRYVUJCbk53VzYzd0F6cnpnWE5tYjY2VXQ1Z1V5eCta?=
 =?utf-8?B?SDZQL0ZlR2Z2amJHWVR2cU5pVmZVSmpDQVViQkhrSk9GQkdrTXl2SXV2Tk9Y?=
 =?utf-8?B?dklob1AzTkpvdXhFVkI4TkpOVVZIUXByUUpJVTErVlNzbFFzQWxFeXNxSkNo?=
 =?utf-8?B?d1ZLeVo5dUNSZWRGQXI1ZldWQU9BYi9lbEQzSURLKzlzUzhtbUdKZ00zckk3?=
 =?utf-8?B?eEtmdDVubXE3dWpLcVhoRWxmdkRVWDd4OUdYbG02MTR4NWwrL3ZKNzNweXRZ?=
 =?utf-8?B?ZkRDd0MyUmRTbGlkUDl6U1I1UEsvN3M4blJlMnFBZlY2cEZ5L1d3RWxPbnFI?=
 =?utf-8?B?Yjk0R1JYWGtna2FIMkVXMEdDNi83UERVbjFKTDVEcmNPT1NRU2I3OWgzYnRT?=
 =?utf-8?B?TlNacXdHMjJYNWhyZFlWWHd4NVdLR3hHK3pYeE1VQXAyRlFQS2R2K1VpTUJW?=
 =?utf-8?B?alJOcUVPYTdoZ25BZnVqNWJhbWM2Y2VKa1FpZi9mK0NKU2VVbm5tY1BLalJ1?=
 =?utf-8?B?MjhPV1VoQ3JrSndTS0VKOG4xU3JNbVBXTWZWU1NWcmdEQU1FK0k2K1NsZ29q?=
 =?utf-8?B?NHh2OEFlK1ZBRytwZ0VIVHdOeU0zQWJ1RFo1cDJuSFpVc29HWE9VRG5LQWov?=
 =?utf-8?B?T2YvL0JxRzAyMjR2SDdIL2xRYnhBV2xNZ1hXUHNHRDQvU1k3cWdYNHp2U2hB?=
 =?utf-8?B?UjI5ekV0b1lmc2RXN0puOHpqZFFreVBFMlMzVXhmYm9PR1JJSVR2akV0TGll?=
 =?utf-8?B?WWhpK3haT3FiTmd1cmdRbWRxTGVETFcrMzRuVTY2OXRwWVp4VjZoajNYTnVE?=
 =?utf-8?B?c3VSaUNQS2NTc3ZQbXhoMUNEbnJGMlE3YmlJMjA0T0FJZ1VFajZQL0pZYngr?=
 =?utf-8?B?NGc0Wk82eWt2ZTV5cnl2bEc4ZHEyek5HTkdnQWFPQ0llQ0xidytOVnE0YjVP?=
 =?utf-8?B?emJWOWZqUlhkKzNTdE5mZWtJTGFEYUN1b3IzSEErTDVpSWZBMGdXdnYrTk1a?=
 =?utf-8?B?K2U2aEh5aWZzbFhpQ2I1anZOSXhHS1I2WW9GQzFBb0dyaXVoMU5keXhhdm1j?=
 =?utf-8?B?UC83Y0YydkJndTFBc3BHalYrVXJveUpWUlV3WENJVlF4OVNtSjNuckhtcWRJ?=
 =?utf-8?B?L0J3cjRLcUJDQWt4MUJsaiszWmVhYzBya09NZ0FTQm9HckpLVlJKUTNubTF4?=
 =?utf-8?B?M2kwOHlKRnZEakZIK0RhU092eDlFakRsRk5BTnpPd2FnUlVGU3pHcG01bmI2?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0c4c97-bab4-41c9-1cf1-08dbc69186ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:27:33.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJVQDm2V4TpTbqRoJvGog/dj+A4P+yfpoLtFT9O9fIVNWtRTfvEzrx/OQv6q3ll9qmCoyym6hdmcqYr70MeQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6653

On 06.10.23 18:50, Jan Kiszka wrote:
> On 05.10.23 10:50, Florian Bezdeka wrote:
>> Hi all,
>>
>> Disclaimer: This series is completely untested. I have no infrastructure
>> at hand to test modifications to .gitlab-ci.yml. The Xenomai
>> hackerspace hosted on gitlab.com is unable to execute CI jobs
>> (currently).
>>
>> The series does two things:
>>   - Move from Debian bullseye to Debian bookworm for all build jobs
>>   - Add one more build job to still cover building against libc versions 
>>     that do not provide y2038 support for 32 bit applications.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> Florian Bezdeka (2):
>>       ci: Switch to Debian bookworm
>>       ci: Add build test for older glibc where y2038 support is not available
>>
>>  .gitlab-ci.yml | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> ---
>> base-commit: aaea684b95331336f0a04b9d15f8f24552e64d7d
>> change-id: 20231005-flo-ci-to-bookworm-9d7672d6f642
>>
>> Best regards,
> 
> Thanks, applied. Means, it's being tested now...
> 

I had to set GCC_VERSION as well, but now it seems to run.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

