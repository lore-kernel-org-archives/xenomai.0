Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786403E0241
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180496; cv=fail; b=Kh215ToHr19WVNPr9GwOgaquHdvlZAcFb2HEer+OhxvPqsjbMdEVxkYKhzJUWaO17/8MHJPP4zLlkeQbcSmvEOu36Ax30ZfPCCNbUZUfZD/mMX08nN2W2YboK6bON5jneN/LSKW4gG5eApJWU8Ho8oAzf0U+f4+6YXkOHPnPba8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180496; c=relaxed/simple;
	bh=Ze36HWCFCMhHNHJVw0r3/jC1lFjuEWWUhkAASH/0+AE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=uPfV2z1JIn0fOnjZhfGjM5VV94HhNfBcjVGZK/aQZq/QmSWdl1q+6rQrE7upmxEN+5nDDX+S0FG4+nXo03wjlqjotJjMSTHBWwhkGPceTh1Rg6oPE6vjR39JJbfqd8FxsDGMQ+8Sit3kO466tZFnSY14xKjOmvUHKeVNXNFFeu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bnIGSlWS; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bnIGSlWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8cb/XoSOoF+XJmXD7SKlMwb1fE53PoPIOOYk+pmQfxf1BXpzR137NBcaGtbQTiiq1vUEiAvW56hGDS8k/SMPYQ8OMtWr/QAB1LpcJoZmMRYnlUBXJNMbjtGfL2Bhezpqoa+L7XocSUbcNugyNzXs7EgdW24Y1Vjo+SA30KVqQ3Wf787MCJNeVptasyQaDNOLseuWKiHjdXhqwa6xcTq4rCI1QO6hTQSDZorCHUBTs7fNz9or538fgnBKxCGay0939HPmPoEEXNRqbfrECkIaQd6EYY/f6ZVfoVVfuzoMjIwYDeEe31V+AOSUnC4/wd9IfRk0fng5gXrx9/QsOtrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AscDxzY7j9vtix3QG7g7RlpmEjdq+ZftIrAq3ktmzvY=;
 b=nO1ZtYS5Ey+vzlfPAn2VC9jQD0c5fi62aB83pjfxk7Vaeq4l48zlvNgzq/S4DjBH/t9/7Wm5rZb98azTMDFhyKNW1OBz8BzYvM1TaoV6+4WuwwkfpeETgGRinV7cVLjJQM/l3BwokHFzVX78pMSxTgq3bQbmStllf9EQLSipVB1UJoJHkiDMstyikw+xtA85dkZINcffSghgSrfGSOWifyq0V8tNnJ+oWnMpb0JK+y3wmTegL3jqnlYNNVSyinC+cIM37QVXA+wNqPvODFONygVuhEOM9l8cnDIW81vCT46BntOJADotogtM1POEkasQXdSulSHAriSmOuWM2fyVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AscDxzY7j9vtix3QG7g7RlpmEjdq+ZftIrAq3ktmzvY=;
 b=bnIGSlWSeD8SH0MT4v8ouVxFRhsoK9AP8xBo/YTFX80GSdWvAykEBhv9kJCzthoDNY7OHbNjh8/0hm2bikKdNqEqV8KlClXkMPNeL446Wy+EmluZBdFo9U5kwP5/XzrWjod/IBJKxAKYUglGzjyVYjR5aCoy0ck/dkKIrgma4HOa4eapvghFjYSVQfUGnW2rJR6OcFbNcp0VSQ/aCUEw+Rv0aDuYxXqcH5m1MgvcG3jRTZeT9tU3z93fxfBQiZL8cff+9vpaTBMn6grufyjC/EBkzQ7jnhEr3v+pYnAQrOTsXR6OOLkPLbvsYc6iLiSD/RdQns3iUAhIDNbYtt76cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:48:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:48:03 +0000
Message-ID: <86d6990a-349c-42f3-a054-494422298386@siemens.com>
Date: Mon, 31 Aug 2026 14:48:01 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: libevl: sched-quota test lacks success check
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 82df817e-f49b-419f-49af-08df075e18a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|6133799003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	H0Syx2kvoWov3gI9klduRQgH16iz581JGSyqkPAiZAxSJzvNJXU02uohJu+Xl8TErJF65Lu/ZL8ehWwq5BMc9+2TGjM7+MBNSkA1MENUZ2+XlXvpbgdQODu9uQScacy1VxKZfqz3j+Vkd7VoRJN6yUY/tIMpg6mQ8gG3Gx/SAHom9fJmJ+F0gx8/IsLc1+IzHNWsOSJGE6/Kx0cmcLSojVbyl12BGN8eUeHK+jejo7uX8vlLbk+LTTsPigejuOtqbSkrSMXDGj2tuVLLcWPb8UZ+LdLs8qalxwZrkX+Ert0SVMYu20rbSE6xxr77iVPRltoBe/YDPczx0lsVuh23F3Ak8Jf6B2p5fXpJKIXVHTmG+zNdDBBVF4KpgOe9i8x6NJ5tQ33ddfElZ7ijtYFv2/M/Utz7DX9a/7qJ6qK08alC8y6euI07FPgnMKldKfdd04cwbNo+7O1mr+xIb8TV3EoYxOfuksvM+RJD1P1ztEH9Q3n1R1qPrTVq7I5OB2DRGmVVPmA03nIvHPQPdYATq1OQg7KkLiH6UsxKZIy6XWvO1vNQHMXOT3A6krR8yIWBBJBG+dc/l+kiZQD8YMEGTft+Jo9vw+Wvk9CwQsWqpr9v2WFdnqn1YkVzvx1QN1qmG1qp1q8MbJJuwp8XxOPKgWi3iZnzL7BZc2VdHbXSJyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0UyNVhaVnpyQmdndDMwSWdGZCt0Zks5S3lVcTFpN0Q3aTUwMTdmaGhIempl?=
 =?utf-8?B?M1hJMHVJOWJ1ZXpoQ0NjOG93TDkrNVh5b3dWa0pOanhqSy9WM1g2SnYwN1U4?=
 =?utf-8?B?cCs2ZXBvYjRENjdtZm5MV2xzS25uWWhoL21kMDlGak1kT3lvdWNlTTdzbHpm?=
 =?utf-8?B?M25BbDdZSGdhZFF5eDkxNHZSd2k5dUg5NEVrc25qa2tYcGFoKy94Q1pxVWpR?=
 =?utf-8?B?QmREWFVtVUJrb2dkNjBvS25Cc1hQb0RjdE1XZVFIV2hscWRFNjI5SGh1c3NS?=
 =?utf-8?B?MjM0SDRySm9zV01xWWpRTUNMY2E2R0M0MEFrbDRqOHMySnpuWWc3eG5aVGE0?=
 =?utf-8?B?b2E1MnFxTlNIYk1lM1EvM3piYlJhczYveXAvWVVEVDdtTmNUQXZEdEtDWmpM?=
 =?utf-8?B?VHpRU0JkajlHOU00eUNkVWtWSUtKRmg5RzBENWwvcHMzS0FzNzcvbWlDUDl5?=
 =?utf-8?B?Y2JDQ2ovTHlNRWk0VjZYcExaRFk2Q0xmb01BRExBQ1orRDJ6Y1BrTk1IdTJM?=
 =?utf-8?B?WkQzOS9lWk14aVUxMGU4OTFOODk2OEtLUCtmcXVKMHJsVWlnaFZpMENKc1Ru?=
 =?utf-8?B?THFnRHF4UStGemZqVGZxTHZzWGM4dmRuaWlWS3BJRjRpR1EreXlhLzVyOHR2?=
 =?utf-8?B?OTBIRU50L2ZzZnVaQ3E4d1JpS1gvMEJBaXJoOFUyKzMwY1pDeDlTbWlJaGhn?=
 =?utf-8?B?S1o0VVoraVUyVmdjdXRSM1lGQmlPUFUrNlBJSHFxOUEyN0xqYnBwNUlYRXcx?=
 =?utf-8?B?VUpWUVZabXVlTVNSM0ZKZWZPZ2Y5UXlSMXgxcVJ3TytmaXByL3hVbjNaNUtt?=
 =?utf-8?B?dGxXV3pGWmtVQzRISkU2bFFmYTl5TXdzOG5mdWVrVGFMTG9TQUpvajFPSkZY?=
 =?utf-8?B?WElEbUFGWEo5NXhNdi9NdHk3VUw4NEdSN2s1TXI3Z0VBbThrSDZUZjN6QitC?=
 =?utf-8?B?L1luUUU1dnh0WG9mQUZocVpGV2p3SXlhS0N5bTl3bXVqYlBXRVp6SExYc0F3?=
 =?utf-8?B?SjdudW5VMmxFM0ZkTFZVd1FiRXpVRGVtNExMWDdDd29HTUpPSkQxeS9MTWtn?=
 =?utf-8?B?Mlh6U2F2STdPVld1anZPNk1WNWUzczNkM3ovbkI3R3grd1A4R2xKU3U2Tkti?=
 =?utf-8?B?TExVRGdDNHhDTEhnL3dKdWhpY2V0b1JoenFOM2NuVHlVTjJwalRBZUxSVzdh?=
 =?utf-8?B?WTZzbUFteCtyU0ZEWVN5ZGJ2NXNXRVNJbCtzOE9VTXhJSDlMZCtQRjlyaS9Y?=
 =?utf-8?B?Um9oV2tiTHVEVDhJamcyTTQ3MXFrdjJTOGs2VE81dzdrOE90UnZ4bGZwSkpF?=
 =?utf-8?B?enRwZCtQMXdLcUkzRHVJbFlGYjlJZjA3UUFXSk9nMWh5RnNIZ0JjZlpaWDlV?=
 =?utf-8?B?U1krbU10UElETGdIa0hjSm1IWEJ3N2hsZDcydlJYeGVJWVdXQXBDZ1g3ZEJq?=
 =?utf-8?B?Q2c1Nk5KWlF5cjFjVlliREppQS9VT0x2L1FFT29Ib1I2TFhSNHFaT01kTHVx?=
 =?utf-8?B?Q3NkV29pY00wS3I4RU9WSStBcW1qc3JDTktjczloS0xrVlBlUlk2cmYxSDh1?=
 =?utf-8?B?R2tGc2JVUldBc3ZaUFFTdWhBTWxmL2ZOSko4Mm9QVGlxWGp0QXhod1hGMnla?=
 =?utf-8?B?NFdPNTQxTkRHSERsb2NCcHY4REU3cDAzSzlnVUNVbU5PMG8xNGRTSVd6Uy84?=
 =?utf-8?B?UzhoR1Q1T1haU051Ni91Wk92NmxLNjVLOGx0MkRwbjBvM2FSM1pjTTJkYnh2?=
 =?utf-8?B?TkQ2Yks0b2tBdmxUc013QWJ3SkRaS2tlQXMyNkE5eDhUUW9VMlBNR2kxTlV3?=
 =?utf-8?B?Y25wa3lqQm84b05qUzhPd1dEWEU0a1czVnZheGdlV3k3UFF5NUl3ckdNU2Uw?=
 =?utf-8?B?KzV2bXVCR0pwWm9lTmJYODZwSjNhRFQxazluVXZTak9sMkY4QkxOVkxmSmxj?=
 =?utf-8?B?WnpzRjdsaVlpd1FudzhwaDRSSnUvdXMydUp1ZHJReFJxQmF4V1lDNGlQdDRZ?=
 =?utf-8?B?bWJITVdUV0VvaTVWenlvekpIM2EyQnYyYU1uR3lEUGlEcFliOEFoc1RaYSt6?=
 =?utf-8?B?U05wMm1ZaThlUjBJV0JEd2plR0dGcjA4cjIyTkZjNHl2V1VRUy85RjlIbzhk?=
 =?utf-8?B?WSttMDFqRU1uc2ZzbGk5R0ZHSWhWeEFvVWZmcUhSVVVpamFHV0lXb0VzSDF4?=
 =?utf-8?B?MWVuTEtralNyZnVBelpnN0ZnK1h4azlNMkZ3Ry9kaTJhVDdRc0d3ZDduTno3?=
 =?utf-8?B?cjhNNzQ0eFFJUm4xRERjZHRyZEJsS05ESEwrY0ZpeS94M1U5L1BVOTFRbVgx?=
 =?utf-8?B?QXpzNTJ1V3JQUzh1NTl1aWx5YzJ2dU5ZcnBIaW5rd0FFUDNGaVU1MXdQVTdD?=
 =?utf-8?Q?5J8t5JaCbI6EBzUM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82df817e-f49b-419f-49af-08df075e18a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:48:03.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm2yv0Yo7EOYZqShRSQrHcNMUjlDXyzD39eshrsIQ9XhYoLQPYMz8mvqq5fDwplqokX8P5UK5WO++Tl2wwHQyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6871

Hi Philippe,

trying to port the sched-quota fixes back to xenomai 3, I had a look at
again at the libevl test. And since [1], it always succeeds (unless some
function returns an error), no more checking of percentage boundaries.
That's not helpful for CI, though. Would it make sense to re-introduce
this, just with an exception for VM hosts? That what we do in xenomai3.

Jan

[1]
https://gitlab.com/Xenomai/xenomai4/libevl/-/commit/22ed65d951dd49b159e52c498dda49b2492138f7

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

