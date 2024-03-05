Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9B14AA7
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657915; cv=fail; b=TY8zBQSDQGLkbeIcmp67tLdUmlieP/TW76YXovoIUy6tk1TIijhhjUlTGXGu/LiN0bwcrvDOLOjTg1LjZwVtghAPY4vP9HOxJASn5uxVb81wmt7TXv8iJrcuzPuRLMWuS6p8YmfQV1pSH3qh+l/jz0uKusblXzZIwTeiukZ82VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657915; c=relaxed/simple;
	bh=3cB9F0w6cFURUnEJPaV1i4BusPNr4Lx4Go/hDE3c3h0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBQ/WmA+4HHiHnCZpco4KoWj6oOBB3qbBGuJQePYCkEJ/dOHnNZlnwuT9pg9e3sCX6lnVQcAnbhkKUui88s/CC6NQVK+eS5r/w3QSNOCIa19yHTmezr3+PM0ZfIb8w0m3pu2zpbN9lXIShUBtk3ZpqmvzCam/w0xOrVZAaZq9Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A/Rx2XY5; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A/Rx2XY5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivByLtuDTppPJQU5TVQaYFP3ASTSlI8vXX6OktiWzvBCz9a1I7z94pZpJ08N8drP3HnZJGGCwA/sFRrejnvAti24pwNtPyVmptoPpr6fGDOthUykQNwG41Hu43aboEF3oIc9w3vRS27BbrOTGPbLJTUlJHhdjJQikrVsCgq8nEDeji2PGDxN/e87nZwMOqdIvQ5Wxa9ZMOXtX2kkuOLSXyFElbjkk9+nSayxh1Q631ZfqXyxl2zJ9FHBGX3qiG4rOGy/xlGyc9AoXyBJDmmdTlBiLVgqF8dAA+wk76whTlBXVtu9kD9eqPgTwSHHYQzWqcsuvO/cafUSFx0itZFVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys4e/hDg9myQ+VknBf6WVGMBAOfyqC1U+zKZdqVVr1Q=;
 b=RAXYEMe9WzJmPdWY+Lts+PxkHrIw8qG+56zzAgGWircKDqc6/wAauHiirmf9bQxf65W1mPcsliigfQs51/B3o9uRPr0rT1udLfxKWLsHg0W9vTeNbnGXNXMQlghrgN6ikr1aiIbtS2ZfxYqQt8vOf/K2S1duND5eLHoO9Iy08Qzbb7R5UVy5G53RZGRuJHn6irosY+8ocPgDIQJEsRvbMwE2rVYuht7+zINcY2Bl+fjXHZu/ugaj7miPB6b6Gm8RWyHlP3hsz0WciBVGq4rJr93ble9Jd6oSZi9Yf4eyo6KIaM/Wk6eNr7wYxMKbMCWZ8AUuBI/15AuqbG9grS5Y6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys4e/hDg9myQ+VknBf6WVGMBAOfyqC1U+zKZdqVVr1Q=;
 b=A/Rx2XY5PeCngCjYQKe1XK8Isn36rNZYOE5imNwxaTMl6uXFNz9rPty7kmRkpvjNADzFHfSjJk3QsZ7mYeLCcAjMCO0JRcQtYXaJTARrOh9GCGJsER0PYRT+mSt1MEKN3/G4WSV8SAnKYSFH+3VMUr2EHxy7qTCBMy+m6tyKqSypeTOz02sMBi8SjuffolJgCyc8w1zGBm/GfDlmfVMVhDF+mD/c0xgvL6otpFs3MfWADS5v1eFVJx37u0IofFM8Gj4QXgk4VuBNR0KSqGpCVdAU3SfY5yje6tDXl2BzOrSbSbHLpkg/0xMZPOvv+wDM/oNs9ehvg5o5cnKUv5HYjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 16:58:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:58:28 +0000
Message-ID: <a635b867-7224-4dd7-84ad-e2c2630d14cc@siemens.com>
Date: Tue, 5 Mar 2024 17:58:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: ARM64 prefault weirdness
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
References: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
 <CAFLxGvwE76ud4K9iE-Vh8XOdsePWC7JPuearPxZu0omGTFE=ww@mail.gmail.com>
 <5501876e-57cb-4b24-b83f-815f3ee1cf61@siemens.com>
 <CAFLxGvxaEf-XBAo=NMEt5jpAnnDCA_YQV1Cq_Nd5J4Bd26LY-w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvxaEf-XBAo=NMEt5jpAnnDCA_YQV1Cq_Nd5J4Bd26LY-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 3232f664-b628-4780-02ff-08dc3d357ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	62QpKkFfyjvDE99xa1R+NmRG45spM5EV1EHYwqnPqPdTnFuthWQR33KHeSfaUoZMQPlh0F2vZHuqzq7ulHMc3HudMO09xJdSvWFd6bGqko+IjwqSTtIgw0tDyEVYl1n/xynqTuAza0P4h0fXqPgz1AldvPBMyb3BFcro3Axli66ngOt94VB5XwL1vnHquhCNkRRWc40HqqQGme9QMmI7NN4oPj5XO83n+RbTPXOGVpw214loE0HOOH4iU6yHgQfRsQIEVLiJQJOG43Up0bgKgLeWga/bLVLBFfkrKmAP7WI1+29p1N6reE2rmPysznncLTMr5dan3qzFDAn7PCZsC41qxQjMTopEGbvPTHXBgACiYL6mFd6IV6i35DIKq75Gp29y6mfqR1R+z4FhACsIr9v1tzOjbe/Hz2w1jtBIX7JBMOsmHYPLkk/Ee4O0iuZWYzMJoFi6o4NHq6JbOmOBH1dYSYewLC3UHuKtcuufAtAvS+/1qKSzyYsscY5FSOB9fz94LFZcIvwmAjeiPKmD7pEtY7gbAfuLssANq7DjVODLyYDvrF1z7oBpe14oklTl9n5UVCeZwQIaXnWbCTl/9PtAQzVk+e8mY4F0OzFXPhaq4INKePAW9GNwKA3EskE7dyyej+GbaCFJglOIStxcdcfa+ekjoL2LCrNueToFul8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFk3TjVaRFFBbzA3dmx5VjZ4ckNIeWRwTzNMV1lJaW1GNE54WnBrT2RLSzVi?=
 =?utf-8?B?Um11MldRcmMyeVdWQ3UrUEFEVnl1emhQYldEclYwUkc2S1VrbHQxVjlUM1Vr?=
 =?utf-8?B?ek1kamJwNWVlR2d6Wkd2SDZPbVgrOWFmaW8vcDVxLzJxYzJjOEd4c2MwcS9s?=
 =?utf-8?B?djVGVmlpbjIxQUdWcFB6eTJMWUxpUTYzNEcvRmhLOVhlWGoyODB3ekVBS1h6?=
 =?utf-8?B?TlFDMkN2bnE5OEpQTFFaQWltOFYwZVllN3ZwYUlJVmNsSTZDcktJYkQ4TkV4?=
 =?utf-8?B?RGNiUTA1Mmg5OWhsR0Qyc2g4TlNaMDl6ek1mUmVhbFp0blhqSWRBR1V1WGRO?=
 =?utf-8?B?bTZFckV3NmpadXBCc0JBL2FTV0hZYkxjRG4wK2phb3BYQWwvWE9jYUJ6cHhS?=
 =?utf-8?B?d053MWlLNGViY3AwODg0d1huN2tvemduRnBqV1BFc2oreCthOGtCZ3hwM2FO?=
 =?utf-8?B?R1hOVVBMb2U5K0JIY2Yra24vZWMrNGpNaGh4ZXhTTlFZTEhqNlF4QzNlSStE?=
 =?utf-8?B?bnFoYkJuaXk1Y0cvc0s5T1grcUVKcDdrVXM2K1J4dldpWkY3RE9Yd2JoeE5Y?=
 =?utf-8?B?U3A3MWlkWkVSR0U5ZnRaYXlISGxIbHRSNDFKeUZyam9Lb2NoSWUxaEx4NFMz?=
 =?utf-8?B?SmREYVNYYXZkVlJ3c01nQmVrN0NTREUybXBzaDBsUlZkSURHOWVpRkltL3dS?=
 =?utf-8?B?OXdCcWJsWlcyVjIwamJaNWg2QzJIVzVRcmd3dm11elpJWXNqaUVEakZYMGFq?=
 =?utf-8?B?V0RMRmlvREVGdzJjZkFCb1ZFbEU3cXVMR3ZMMFpJUUdZTWlOTGs4T1hubXlj?=
 =?utf-8?B?TU1aNkx4ZDQ1bmpMZGJKNTFPSEhqMDJjN3JDYVFMWEdnZE1GampVWCtFTnVr?=
 =?utf-8?B?RW5CN2NKZm9KNmFRNzU4THZCc3M4cTN3MWEyUHcvWklUSTZEMkpIbVltZTNZ?=
 =?utf-8?B?WSs1OHFXQWw3dTFveUxHcGNQRWVBZ01iWmZvQVhzMUF5YnRwVEg1TUkwSlRV?=
 =?utf-8?B?aDQ0WVB3d2lrM1VBdFlHOEpsNURLb1NjWUpVK0lSNkUzUEZxVW91UURqWHFX?=
 =?utf-8?B?RGNJRGpJaHNKL0hPNVpKL3lGSEVEcU4vaUwxSEVXYW1DS3IvaHY4c2o4UjNr?=
 =?utf-8?B?eHVPK2M4M2ZMc1R3V1BKcWpxbjE2blZnb1Z3dmxoa21oaGNPejF3algwVGd5?=
 =?utf-8?B?UWxITTNnaFFHV0trRGpmVTRKMG1yT1NUVHFDQnFRVnBxSjVVeDUzamZrZkVO?=
 =?utf-8?B?RWpBWWFmaE5TQnUzVGlacXMrS2k4TWxRcGZYU3BONVNHV2t1WHZqSzhiSlBK?=
 =?utf-8?B?WHFuZE1oNHdiN2JDSGtHcUpqT0V2eEl5c1FJRTAzRUIrY3BPdU9XSVc2clZF?=
 =?utf-8?B?QVNjYmJiK3M1Ly9kdXpTUVRqNVI1Q3dGNTFTcmlHVEJna0h4Znl0WUNMNzJV?=
 =?utf-8?B?L2dWSDdLMkV2ZkYyb0pwK1I5OXppS0habHg3eW1FSU96R0ZuZHlYVFhVeTFD?=
 =?utf-8?B?OXN2cWJJd2t1RlFlTStPNEdFWVlRaE4ydDlVU0RKc0trSkJqN05CMUpGdFRN?=
 =?utf-8?B?bWxWNllpRUF5VnNrSFp0U3NUenIwRHZtamwvL3dJdU5FZmtkUEhFMnBpT0dX?=
 =?utf-8?B?WjUyZGpOeGovaWE3Z0U0amhPeklFUGI3VDhMTDZiSGFzTjNzV0Mxam10aDhY?=
 =?utf-8?B?U1ZYNEVVQnp6L2x5N0tlVVlGRmc4SHVrWklLRFcwTFJFUi9WU3pkeXdGd1ZG?=
 =?utf-8?B?bFFmSzVpWXF4KzRUUU9wN0swTWxlcnpxb3VPUGt5K0ZBd21yTmVOdGc5Nmpi?=
 =?utf-8?B?YjN5aFpvRXdOS2ROSmk4c2JaT3E3Y1JQTTNyeS80czdZMlpOd1Q0azBlenRZ?=
 =?utf-8?B?M09yUEh5bkx5ZFJONlpWSWhndnlsMTBIUHR0emg2Lys5WFV6Q1hwOE9BSHMv?=
 =?utf-8?B?VEw3WTQvbjdhV3B3cUJjcjhkNE1TR09RMzIrOElUUitLQmZiRHlRRHBISEtW?=
 =?utf-8?B?SjlaRU1HeUNXS3B2SlJRc1hVZGM1bGdtZmszNnVMbytFbnF3Umd3aDNrbG1C?=
 =?utf-8?B?Vmg0NG0yTEVjTzFWTDh2Q3RCUjUvbVpNQ0pTclhtdDV2RDBzaUZMamVMYkxO?=
 =?utf-8?B?TC9OMnVpcHVHbWd6UE5Pd3JTV0JOcmowYlF2emNHdjBoSWo2bzc2dEdsbElK?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3232f664-b628-4780-02ff-08dc3d357ade
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:58:28.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJ7Y9kC8NGPoQqirtzZBoUuaNuA2hK17D4FKjRtpbrJKUr3kEiKsLR0HvZXvmkijHPu/NzcQpi238gM4BYkkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5538

On 05.03.24 16:39, Richard Weinberger wrote:
> On Tue, Mar 5, 2024 at 4:00 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 28.02.24 14:44, Richard Weinberger wrote:
>>> On Tue, Feb 27, 2024 at 10:24 AM Richard Weinberger
>> If prefault was only about breaking copy-on-write early, this would be
>> fine. But we just readded it to iomem mapping helper. Something still
>> does not fit together for me.
> 
> Well, this is not iomem. It's vmalloc memory.
> But I agree, still many lose ends...
> 

Yes, my point is why should it by safe to skip prefaulting completely
when a vmalloc'ed region is just readable. What should make this safe?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

