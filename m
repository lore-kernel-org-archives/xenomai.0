Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2534886B
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446680; cv=fail; b=qcwEnnCH8dE/aUhlB5+Mc01gnsxU0nX986HJo9ztulnak4e//WDs62FDl73WE75W2O1YRC01IBq5Ds+jsc7myK45qWn4dZ5LKISKkoIdlscoM507v9e+DcDcTjCywEpf+3mNp2peoz5t1bw6Y4aTEwL+c+ycAmWQmIvpxm5PF3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446680; c=relaxed/simple;
	bh=9vDhqo2nIsGAwF8DCe7A6MkXXCKu8P96vqvh2I+lR7c=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=gPdGU+aab258yiZpTi67ZplfKUn1KXOSWBWwrJwYY2C6OvoiZeZgSSRNJLm08Q3s6BGf++bNTNM5T8Ldj6c7uBuDtWuAcPYMIbGkd6QE8ObxuZV3DqeezxMOzkH9eF9QOG/urpkNT7ZJBSs1B3uwQE34KNEykKUGcvotxs/P83Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RXc2/7wr; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RXc2/7wr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMqLwpIOlAO4C/0GvLbSAY6AfmdFgooEcgvd88UuAkk32yYqfJqQhpK82g5MtpMybvP7lKVXe9DhW/UyQijDglA5LIXISSKCKKaoQsHaSfjw3c/xYWLAFHmcDBP3waLR/3DCqwEJ3gR60xObtFe0tRXEIN0D2ixRJ0rPaa1mEi2NeMtSBYRyI6VYpdHjMv9AF/NuZCiKo5s6NYuD20a6MHhiN6kFE7H/nO2OBfECW0SiOTqgfsK1tHANHwHTedXoVcVHiRCPRstARJ4b2sus+ktSi6bQlvPXN0Xpg//pg97pd0Hv01xYJHah50R++52aUYzVwcQj7djVamVoUcGM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwyZnQVNbmEDd/CEg5tI7uQk9Jjrp2ISZX4Am6/GkkU=;
 b=gGSBPwXK6KpLiqILPIYpoD18uFbUgQsnz+GPBgGks9dnRqpRrR3oxRjE5cbyNdcWbRZqfsduSR+/PlFbJyGnwVT9lT3iQa0L+LZ3BPn/URn89IabKJv+TnrJjtiPB/xJcBBVsfY/t5btn3CuM9JSE+8PS9HVq4GA05gEYxz8YkQUKyr/PoV7IVbLOjNV73ljIkNopwq/PA9aQ1P1QHy5jWRSe2iuAuCNUAUULQORJsKPbC4uelft/Rz+LCYmChGoAbVRd/GFi7AKX4RmLQARSM0vzZnbAohhhXKJuX3ZblDUvTlhWfc87ySJASR6XIGDd99hC61hu2fjtd0K2Ly3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwyZnQVNbmEDd/CEg5tI7uQk9Jjrp2ISZX4Am6/GkkU=;
 b=RXc2/7wrqy/iqCnbCX2zhv3YBJ+zYY31MuZ5FSt35SlCukToDAeZpscZvT3h+qyBAJ7PaYEm9U4VLkQs5u7OEU+cYLyf1c1xl4+I5I7eGUav6MiLb2gV7ha3hr/1UkZHrANwXeDVZf28eDluimVRN2Ex83a5Aw8Ny6OlwANbcjuUojCJ/J09BwXHzoNc49XM6LpFZ696XgWn6n7sY0skgaii1laTOlnnZQN0mefPCJMaD5IGitZi+laoT19Pnw2LejPT00MLMr/JpikdsNg0TCGxsm6ZsMoz/iV2gRNQjIlNb8Aln/gdhUd2oUweulA95mkVnLdniNEy2oV30OqXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:57:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:57:55 +0000
Message-ID: <cb6e69ea-d04e-46ed-95c1-ecf78ccddf36@siemens.com>
Date: Mon, 26 Jan 2026 17:57:54 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Add kernel head jobs to Xenomai 3 next
 pipeline
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: b86e80ad-e6fd-454e-79e1-08de5cfc0d21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWNRdE1ueHZRRkhCa1UySU44N0hkeEFNc3NMQUVERzlDSnZnaHg3VDFxL21j?=
 =?utf-8?B?WC9ja29SZXZYbXovUzJ2M3ZWZ1FjWFFmUXJINFJYNkNmZVRVMlc1UDhoc3ZJ?=
 =?utf-8?B?R1RPV0NVTzNMSXpYeWpSenBnWm54VnFSSjJtOUdxU204a2RVc3VoSElzK0lR?=
 =?utf-8?B?akFNeFdQTHJ2NWdVWWlRRGNGK1p4SUV0c3c4bUpLNDdUSjUxUW1CUGFzVVBa?=
 =?utf-8?B?SWNrWFk5T0VJdWs0MllGOW91VDR2Y09MWGkrWk1jU2g2ZVd1NkZxQk5Gektk?=
 =?utf-8?B?ck1rNUZZUDBjT25hMU9vbUtKK1FMN3lTS0xqc2k2anI3OVl1WVdXYnNvOVNE?=
 =?utf-8?B?TlBEUUdZS3ZXa2E0bGxBUFdQOGdJdDBMSWQzRno0MGZNL2pNZUFaSGtyMWxU?=
 =?utf-8?B?VjJjbjRUelFCMm56M2pjSk13azUrZ3VNcHJnVUo5cHpVNnROTkkrdmE1NU9W?=
 =?utf-8?B?R0Y5ZVVGSzgrUzhDUjdGQjBLRTV2VnliVHpZQmpzcHBrR00wWkovUWRtSnNo?=
 =?utf-8?B?N3R2bVRkVU9qbGpUQlVtQ3A5Y2t5Y3o2RXk0TndhYkVNMThsUHVGSWFrWlZz?=
 =?utf-8?B?UzFZZ1d4NGtQRE5KcU1XY2RrZVk3Zmt6bTBmdFJGdnczTU5KVEdEMnBVUndV?=
 =?utf-8?B?VE5ZYUVTbjc5c0tmdWQzK2pNMFlDNlBsUXNKOTFJZnluejR5VnBqK0w4a3pz?=
 =?utf-8?B?blV2U253bG1nNWM5OUF1WWM0Nm9CczU1eXRQd3NUbTR3UjZCK0lBaHIweXRx?=
 =?utf-8?B?WkMwcnp3M1pzclp5ZmNCc3hxWkRQRXdhYWZia09pWmVkSE4rVGpnNDZQYzVJ?=
 =?utf-8?B?ZkFYdUh2bWlMeE5jTDNROUNSZEhOTzhQSVVPaks2a1JDMHlRTXNDSFBXUTdk?=
 =?utf-8?B?aTFuS2MwSWc0dXk4ZnpDVFpoS0Y3NGt4MFBVSG4rSlRqcnRnQmdOQmdFMnVB?=
 =?utf-8?B?WlAxZUdQdWFQaFdzZ1ZJMDVSa0pRQ3NlT2YyYTlLK01YV0RNQ0NOazZKVjNC?=
 =?utf-8?B?cDAxLzhCNlJ5QUdTbVBkVWtLZTgyREdUeFRUVFhxbC9lVlpnQXArRFpUY0ZC?=
 =?utf-8?B?bkV1eDRqd0JUbXpJNm5icmtzWENCQStSS2d1T1JqRHBhdHlIUlB6NlFtS3dN?=
 =?utf-8?B?T05raTRwN2NhcHpldzJRdUpPcmRDdGtjQnBvUlA5dFkrUk1vSmF1SWVBc1lp?=
 =?utf-8?B?b2NDVE1mSG5Fdno3Rmh1TnBSNGVQK3lmeFdpYWlPMTRlNlVOVHpBZ2tkUUNT?=
 =?utf-8?B?UklOdUZFRDRHOUZIYit3Rm9jeGQ4SzdvT1FBUmloNEtSY3hHcUVLWEtWblNl?=
 =?utf-8?B?NkV1NmpWTHVabHBRTGZNcmM1U2NRN0NCQXQyZ29Ccy9MZWlOYUUxaGVQc0xk?=
 =?utf-8?B?NFJwVDNyempRaFY5RU1kVmVmNjdSREdRZ3dIQWJRTDNmOWNRcnZYVGRrMzhs?=
 =?utf-8?B?dE9rTGd3aXFEWjdZWjhVMXM2bDV5MDBYT2RSbzEzQ1BKUlBGdTFJVDBUZmhS?=
 =?utf-8?B?QVVaNWc3emovdTBya0lLaXdybmNGTW4zUjYvQmlMSFY5Z1pjKzBGa2E4dWNE?=
 =?utf-8?B?K3ZsTFgyNDlNRC92YXNuL3NiVEp6K1BhVmtsZExhRW1Bclg5eFI3NzB5cFpz?=
 =?utf-8?B?MXdDb2pmdk50SEJST3hGSzZvUEloZlUvSzYzR3dobWRMVElldmp3Tm13MnZC?=
 =?utf-8?B?d0hZSmQ1a3g1NGNHdjNUdnFmeWRPc2xXUzU3dWp4SVh5emM4ZlR5Q1pFVTdZ?=
 =?utf-8?B?aFN4dzBjODhVWmJYbW5qOGY2YjdTOVU5SE00NjhITG1kaGJQNVhzZTdFcmdQ?=
 =?utf-8?B?Y28wUE5rUzZod3hDbm43Y1ZRcTZZdVV3Rm83OXpnWW54MGRhQTJVSk1TQ0Uv?=
 =?utf-8?B?VlgrNnVYaU1peSs1VVEwZy9HOXJGOXVsSzJaeUk5VFUrNXRyUVZNUmdBaWpq?=
 =?utf-8?B?M2pReDZFUDBwM3o3OUc5Y1hnOEJnUDdITDVZeEN1eFVTLzNUTldQRFkzZWNK?=
 =?utf-8?B?SEhYVkZERnVGVlIzVG12UWRpUlV5UXpaQ0M0ZEdFVSthRjZkam43RENOcVlW?=
 =?utf-8?B?Z01DbFlDMlVrVzAxTW5nT25ZU0YvZkxjK0pScWxKemlXcnNBV05jV0VUUndY?=
 =?utf-8?Q?l0W4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3FVbGhuZm9MblBMNjJxUGtIV2ZsZGRIMHhVLys1WnExRXd5djVYcXliNEJF?=
 =?utf-8?B?dXRuNmVXZnN6SnhNUFNTUWczcHE5VDRZMHkrTU5GZDRKcFE3LzhBNFdOd0dj?=
 =?utf-8?B?VVE5ZGcvYk9iVUJQWGJib2NFUWI5QmRuZER0bHJ0SlVCSlNNV2w1bmVQY0hQ?=
 =?utf-8?B?bFpwWUlneENLOVV0Um5DcWhnU21aM3V1ZnZPRTByeURpUnZQM1AzVHpHWWFN?=
 =?utf-8?B?U00wcXNmMnFzNFJJYis3OXBNYkliZGZPSGp5RjBOeXpNalhnQk1yWTR6SGdv?=
 =?utf-8?B?aXFZT2J4WkNRNlpweE9jSU9QOWVadW5GZ3Fqb296WkZTZFk4eDQvVHBSM3Fp?=
 =?utf-8?B?WmI2Y3U2c3A3TXR3cXMvWkFsZ0puZHRCT2dwckpiWnJrUjd2OXVZdHZoOHRx?=
 =?utf-8?B?M2dOY3VoM05pUFRDR2lqdzBsQ2ZQNnFyMTYzRUhaMkw3ck1mR1RqMVl2bm1D?=
 =?utf-8?B?anpLc0lkM0xmSUw0d2pQRUVXM3hsOWI5czBWUWhJZjlIK29zYy9OaDRaSDZW?=
 =?utf-8?B?Vkh5OTdGbTV3by9yY3NzYTdjUHhKeDRPTU5ybTkyTnZJLzFBNkZXRStXZjZu?=
 =?utf-8?B?Z2l6bnRuc2JIMjd4Wm1iOEhaYjRzTW9ZbmtReHBHZ21mUjFCM1dyR091U1E0?=
 =?utf-8?B?NVRIc3pQVFNqMG0wa2I1bHJ1YWhiOWZFekhjb2VuRGlwZURtZkhRazQvL1Uw?=
 =?utf-8?B?MExQTFRXWjEvNFl0Z2tINmlqRWhtQ0ZadXRmR0hvRTlFNkVSUEhMSmFEUTJw?=
 =?utf-8?B?TURpVzZ5QUxaRUdvcVk0RGVpL0lwdUxTd05uVnhrOHZMM2FCUnVvamVUcU5U?=
 =?utf-8?B?cTdjQ1ZmZ0Z4bk1vaGhjS0VNOHZiUTA4LytSb25OSC9DejltRFFneTI4WWw2?=
 =?utf-8?B?UUJSMGtOL1NZaWhTUDkycFd4Q2RiM05ZSEpxcGhCeDYyRVdqa1pWT3ZzY0Rw?=
 =?utf-8?B?UXVhR1NLRUV5Q3RjV1E2MU9hQ0Q4TmxTTHlQUkd6M0MxMXR0TFlrWSszUjBQ?=
 =?utf-8?B?cFhjdXpucFRXL0VEeEp2VWZBLzBCTTExQ3d5R29ybmZYK0dIaGY5MDZPMHhz?=
 =?utf-8?B?QUs2Q0dGQnNGVUxSYnpEL3JVbW9pODg3NTd5OWQ4aWJyZldjUDFlZEFpeGJB?=
 =?utf-8?B?ME5hdndidDN3NDV4OWQ4YVdicTdmK3hJdzIwaVFFMGZlZGlnd0hhakxIYnFr?=
 =?utf-8?B?U0RGaWFwMnRtZXd4MnBCQTB3cnorTnJpNnJESFd5b1FFOXpkek5zV1llTjEr?=
 =?utf-8?B?WVFtQVdqQXFnQlBEMGlWUjIrU3NrUWpTQ3JPdEx4Q0theEdsMHVLQUxPWVl2?=
 =?utf-8?B?K3RQbjU5Z29vYktxUFBWMkoxTnNzQkpQZVFEWUY4MnA5OG83Q0VzMW9EaFNo?=
 =?utf-8?B?TUp3QnkrR21ZVWNZOVVmN0xOR1NYSFQzRDlJYWh2ZzI0UE9hWmVqYW40TWhK?=
 =?utf-8?B?ZGZidW91dEQ5S2hPWWF4K2tjZUxMZ3h6U0ZIQXRnUkJyUW5vODZMYlViTVZt?=
 =?utf-8?B?Vm0zTk1HQU9FYy9rU0JzZTVQTDcxdzNJTXA1aXI1Vy9EdzZNT3BPT1BzVjJn?=
 =?utf-8?B?Tm5kaXFjKzFnVUNEc2JreTR0My9ILzZ4ZXZ2d2MxSEVWb2JNUi8xUXk4ZHY1?=
 =?utf-8?B?K212WG1TcVdVa1FFYkZPaENMMmFQcVhoZjM0bWpTUlMrOE1DdzFaRGVxZFAv?=
 =?utf-8?B?ZzkvTXY2c3N6RDU4STRtbk1Mb0IxSjJDZElleFl4enRnR3MvRXd1Mks3N1lK?=
 =?utf-8?B?VVpudkRVd3FvSTZodS9KTlNhS3VKNzZOUUdPVVBLcS9PaXZrM0tlcjc2NzF1?=
 =?utf-8?B?VkxiSzVSZ0RpMmVOZEtRMVk2Wm1oSmlTWEg3bXZKMlh6Smh6cHNsaHUvVzR3?=
 =?utf-8?B?V1k2KzJNNHVMN1BFSk9OMlcyQjVLQmhlZmxWRjcxa1ZDNkV6NmthYXE2RXhm?=
 =?utf-8?B?ajhYaXhDV0crR0tkdGYrTXkvRlJTaHFQY1ZKYy94OGxtenc1UXhSMEhKZ1FY?=
 =?utf-8?B?cFZHcDhNeDk0UlZzekkyQ3pXV0ZOVndLWi9hbHVTQk4wUEFod1ZuZ3J5VWFh?=
 =?utf-8?B?Tit6TTA0MjFwWHhrQzkvb0tTbnVWdmhhblpLVXRxV1JWZlZUYlNwdHkrdS9H?=
 =?utf-8?B?Z1lIc09TVUUwVkNhUkMvYkN3YXkxdk5vOVRIT00rZVVyT0IyUWFSZkZnQXU3?=
 =?utf-8?B?a0NlK2srVEF1dDl1d1h1bUNuMFlOQVFPMUdMOWVCMTNBUm1SQXkvWm1HcEJ5?=
 =?utf-8?B?TkVZeEswdnJ4ay9iUGhaMGd4ejVuMXVlaFEydTZxWFI5QVUvRXdyMHc4amxC?=
 =?utf-8?B?eERFaHdyUGI1aWRNNkEzZDZBNnN1QVhidGZ1V29uNUNrNkRKcjR4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86e80ad-e6fd-454e-79e1-08de5cfc0d21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:57:55.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHy+SSMtPoyqCnbyepgT42GtXACeQnC8jJE7AwsA/Zr7coOVraNjek3sLlvo70axRI7PHsXc6NDitqEco9a+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8383

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that we are testing the latest dovetail kernel earlier also
with Xenomai 3.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_3_next.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 837b121..5d8967e 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,9 +13,10 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_6_1.yml'
   - local: '/ci/kernel_6_12.yml'
+  - local: '/ci/kernel_head.yml'
   - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3-next"
-  KERNEL_VERSION_WITH_QEMU: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "head"
-- 
2.51.0
