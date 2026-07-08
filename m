Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717D2D7BF
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518609; cv=fail; b=OhwBwH1BDrRWZf6lDwV8UgeNshZBA7kBMkZP6L7AO8eQQ/7DXajgSWSk6EnDKEoEFOeF8GC9LPETf/8BqwTF4Ef9S9s+M11JMWaR0FfNc4YJdXo8MaGpG2+Djq3uGwcixyT+brl1xCwGDPK3nDxEJJbdGw+EeE/IXHEtgeczWgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518609; c=relaxed/simple;
	bh=relA07x9+zst/nSq01MDoAODY9xTboYAqdGyTuH9Nls=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=q+wFiZ91daVgJ4tiqckcELZvNZ3MPLn4JugXwTzrjxIZLbSw7U/oIlRIq/IJxQISoS3M6BoMG3gYytRiJaDcKq1CpaiTpQNjy1I8tN4McjtIfsxOLrM/s0RJOgiNg1uioZ2D9o6tZmFsQnBVG38h6gFFFw+22IGswXWg7QL04MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MTr9w4Gz; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MTr9w4Gz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBtAJ4CFKX+dciabvKsAA5qNV2DHYGAi29OqC+BGJItVAr3i+NESd56wWS2q3YhWJ4QUGMLLgXuZQJcedeLnF3QZvd33AcNs9YQzBXPBnum0V4+MnVwz/TieC/O7y6Rh79f5FgnWN2CHK4l2rQPClrZBn1d3cUU6d2+5UznHVz262lpnjtYgAOV+tE9ZIAp+PsIfTxz5FlCmQVQ5Y2F80Fuj6cOa1+VxV3vSoBngAftHy/ac2tFLubaPsy9Q1KCC+h6GeLIWyj0eQzHZXj11zBcu4c12WaUUIZqF6NMVEIl/VO/LD1x0eY8DCi+x3RIHmVzt83tbr/cW7RlNd7Fbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odalvUwPE3z7GZ5mJgIk4ae9bIRQny3nA/3tCTmKW8Q=;
 b=s5s1uwxoOtPIBL+chIOIUEmY6dSEHL8uO+J2wSlCPQUVL0OtG55LoEvbG0mZ+YIuIuXDQf/zfM1Pl+b1oELCip44eFzc7NnyGeW5r/ivkFAOO33ZIvOXRWzQNfewGo2WkcdrLWI/Xg2u/ISUFB0qNWpFrvoQbS3NKFGK7oHoeb8s015XKU4xozmDB7b9QsO8N20rsPM6PP+cxcN3fBXgbmo/y2WSavmRjFDLyqH46RjVp4pLt7doZ60ZePhBScS+Eg7pSX8frAPcKysqz0XvbvNTlhG12Q6T0HqU/5VJBU1ILey2iqpNsaRAk+7S/pv6UWHl+vaWE40152T78Lb85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odalvUwPE3z7GZ5mJgIk4ae9bIRQny3nA/3tCTmKW8Q=;
 b=MTr9w4GzCMrzlvnJ8k5vup0Gll28HAMG8eK2uiEWWNOqIeKzALDwR2O1ljrmZCvnwZaWVm9C2zZJyLDjpDJZncqCAz7xjgLhSfAs6LZ8w4OakDVX20D9KIgHEIrv/nD54QYMmmwC4Rb24AfTQ8UviJb2jAFwTivR+0ePBgCcmCAbRO3XYjOOABXNN0AnlhgHAU6jwE+eeRFA8oATl6lW2mquyBWobxTv17PFVeO9g4BAEQ3Nny/uZkayZWYt00XT2u8YObVnTGU5AAMuDGtrZC+AVEPkSEJFrrYreClSHbXM0ybYtHTTnkFU96TnOL4plqMcDFssK+werBfFr02mMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Wed, 8 Jul
 2026 13:50:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 13:50:03 +0000
Message-ID: <06a2c0f7-8e33-4f48-9f42-8a16dc887f8d@siemens.com>
Date: Wed, 8 Jul 2026 15:50:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] tests: Drop no longer existing option for
 qemu-system-aarch64
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d93a6c-8041-48e0-e6b4-08dedcf7cfd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	m1YNlyEOe2y0tbk+6YX15n97jZd7Xn/NW3K/HD4efUuSUGIIGLTD3SAXQpwXytl5IoA+Er3mbyRgZ4X17XOhVZEoToJiXp4HfkG4IJugq0906nQFExuclmv++Grt6gcePaTCS0LI/DJyRA9JJqq3RtRtv2hVuFPwM4ZI/vq4W1G3D4BEhid/v0rp634e8ai4+nAdpHRKi6xPQp/9AOkFmRdWxX/VxdJLnV6eb4IpExXmeejRhLZ5jJY3DDfHxzjBTvAokGqNftCddI46VHA3ys/1wPBzSq6pSEdkN/MQ+vwEx13GPqj8TrdOTda5PGHb+0ExyfNVajxEOrbDXPbH5S+XYQcrq3yb/Sk20AvBYCVdGYBJiOSJ9mk4TKB2tANA0bLlWGc7ybTYSlEswee+aE159x/EAeOo0TpGq/MxpECj0CzyHpc95cYIx4xUl9zed+Kww/lqeXGXXzgHkf9WErsHc1SdjBlCY/gfnAIh7IA2xlP2U803irmRHmW7fjR3tN0FG1CwETPDZm7QmJ+RS2//4rpMOmx0+DznqiT0jWgLIiT/tUwpGGepoTJ58Z7DA1K1j/o4Hy/Ug/LY+2WCKjrCsTuIoAn884b1gvfh1udzuZaYpyuUbJFYmsxX2Qwjf5jyOuK02BGfV45QsI6MtFAKr1C6UCOcRlwFGI74Jm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStsdHNPeG1wUG9zaktyaXBUdVd4Um91WjdxcVVtTHVtWm9VZzBCNCt0cEY2?=
 =?utf-8?B?bVovczBkdWZDYnpubDJyc3hmV2xJcGU1aXhORFJzVXJMczNtNEtyRldSRjFJ?=
 =?utf-8?B?RFI2a09RNEtyNG9sVCtNeUovaE81NlJKMUI5Y2VKaXFudkVzSnNnL0MySzFB?=
 =?utf-8?B?WUdCNTFHTEtvZDZmOUw2LzFMeGg2YmY3Z0ZDZWJTYXdaQnYxaEc0bzRFZzZt?=
 =?utf-8?B?K20xVWo4UU1vUCtmblpGdS9ycWo3R2Y3cDBQcTFVZTZOSjVnaWY5T1pMTWdj?=
 =?utf-8?B?UnVSS25LZEcyNHJpeGFYRjlPK0VqMWdMZ01jT2c1ODdBbTZtVFhQODZERU1F?=
 =?utf-8?B?dFY3VGVITTlray8xL1NvMFh0d05pWHhyZDVnNnpvVzF0Q0d1ZTI5T3BJQXdx?=
 =?utf-8?B?VTBpZXo4ZmMxL2hHT2RwZG1yMHV2K0U1THJLa2QyKzNLdUFMTlgrN2V2UTJD?=
 =?utf-8?B?T1d5N2VOQkN1ZWZYVFdIb0VZcXFhSitaMHZ4M1QxaXQ0V1RPRE04UUIwNlFu?=
 =?utf-8?B?RmVJVUFVK1A0WnZETWdlNkdxNFlvUnpTNGZveTI0ZEhrOXZzR0ZPSC9ZRjYv?=
 =?utf-8?B?R0xDUHJyUXdrQXhkbHgzMlJQdkpQblRSMHJudVFOQVpzcjJoTlI5TFBpZ2tQ?=
 =?utf-8?B?V0VUMnJtQnAxcTJKNHdERmkzMkZndWZ2dEpQZDQwZ0w5WVpWZU1ZZ29nd0F0?=
 =?utf-8?B?QXpZRk12Q0UybmcyU3pTSHE0VjFhdkQzQ01RM1lzckZVengyeVRTUVY1VlJU?=
 =?utf-8?B?ZWNXVTJlc2ZJMC9ja2RXS3U4Umk0UzlwL0dwZDFRTFBLbExtOUdaZTdoZlNu?=
 =?utf-8?B?WUNoU0lsc2w0UWd3ZE0rTVdxVU10UW5PMUZJcHRJREFPek5nblJBTHdoOG1y?=
 =?utf-8?B?U2thSWRDOGJJQUUySEg0YnRNQ0gxeFBsK3l5MGFIN0MxWFZkNjRiaDZRWjJk?=
 =?utf-8?B?ZCtHblYvUFZnVWRFaFoxcGtkQm9UTCtvVCtPTkVYdVVJM01TeEQwL0QwblAz?=
 =?utf-8?B?RkNHYlZ0cW5LSGc0WERObkQ1QXZvSzI3d0F5K21zbS9UQWowaTB1VG1Ka3o5?=
 =?utf-8?B?S3FlSVc4SFhXcEpUa0Nib011bnVEZ2hkamhJcHhxTk9mS2xIRHNSdGlOU0ty?=
 =?utf-8?B?TVJ6WmZIbmVFUTZoZE04T0wxV0RUcmxnMC9nZEk0bzJwK3U3Qys5NldtenVI?=
 =?utf-8?B?b3NXQW1wZDNodE5wazZzTkdiWjJlNWJ4SjkzRDZ1eU1PWU05eU1Hd09pSk1Z?=
 =?utf-8?B?Tyt5RUoxbUgvRmpPL2c3QXAzWGdNRXRJdERzNTNKZzJjbWc5RjJSSy9URTV5?=
 =?utf-8?B?QUhjaWd5SzFHV28wdEtmTXZTdHpYMC9jS3A2aittb3NWOG8yaWFvQ2ZBYk1O?=
 =?utf-8?B?QTZpanpxOXlab3RCNG1BTTBsMm9zSythVjRlNm56NFhDRWJlbEpjc0JUbGdy?=
 =?utf-8?B?NGF4cHc2am1kNFc3R0xXSjJhZXdUc0RJeGdza1hRZWJYblpvaTA5YzJoN2lo?=
 =?utf-8?B?b1hwZzVRYUozYkJGYitpUmprUVBIMVNEd2JyWFAzOWU3SGF5TEJPTEt5dGZk?=
 =?utf-8?B?VXdkT3cyNjc4UWNETm5UMitqNTNrOWE3UUV2VEVwVzUyU1V1Wm92ekd1WlNv?=
 =?utf-8?B?V0VOeHVaZTBycjFhMXBtaDRRTnBVa3FXbjBSc3lMMnoyUTlNV2hIaE9BbWFX?=
 =?utf-8?B?T09xUFhmZDZWOEZGS3VpWVI5M3Fua3RzTnBWYnpPWlp1WkNBSy9QUVBrVUJR?=
 =?utf-8?B?eDV1aFM0UEpQYkh6RWNpek43SWR2dmhzL25ZWW1zdHFURmdSSmJORzFrcHBR?=
 =?utf-8?B?MEFuSVk5MVkrcjc3THlxYklTYzlSZDc3WjVMSENqSzBhaXZ3MDNtRURHaTho?=
 =?utf-8?B?clRCRWlHcjBiYlV0OTJ3aGRUWnFCTFZ5WTk1TGFaK3hxTlQyMWtuRTFlNks5?=
 =?utf-8?B?blFoajNEb3o0VlNWNDZNSDM2NzAxa3R5OGY5bWFObnd1ZVhWYlhwTkFmT2dE?=
 =?utf-8?B?MGxyOVBqc3NpNFBYeHlzaFRKL2NIeDFodkJ3TktUZGVTdXlkNUJWOUorWllC?=
 =?utf-8?B?QU1FUUc2WUthWkRQS3VubVRBOTRlUThyZFd3WXI1cnBJWWNXK2NvM0trb0VH?=
 =?utf-8?B?NmFDZ09QeXdMUXFzSkxBZ3MxelBMajQ2Y0llbGxtY1lVMEEvQmdVQ0hlWVRR?=
 =?utf-8?B?dUVwNGs4TkZHazA0T1ZkS1lveDRoS2MralRLdW04ZFhFWk9kTzN1OFZwL29V?=
 =?utf-8?B?NXZsa3k0UXlEdWUxY2I1c1h4TURCQ24vUWtod3VZMzdtckNBbUVLa0RyeXBR?=
 =?utf-8?B?SmhaaC9kTXJ2a1pLbHBUaXlTL3dOK2hLMG91SERSVGFvdGpYODNUdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d93a6c-8041-48e0-e6b4-08dedcf7cfd4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:50:03.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di5zgNqP8sdRUGk+mstD+GbCpIN1ELxUrc+yT1vfW07U5+fiA/zfOcLQTu9yMVQhKASqPpnPLpPJALaU6VygZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7567

From: Jan Kiszka <jan.kiszka@siemens.com>

This was removed from the QEMU found in Debian trixie, the version we
no use in our lab for LAVA tests. But even in bookworm, it was already
redundant as this option was off by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/jobs/xenomai-qemu-arm64.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 2e9d1d4..50eb1ac 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -28,7 +28,6 @@ context:
   arch: arm64
   extra_options:
   - -cpu cortex-a57
-  - -global virtio-blk-device.scsi=off
   - -smp 2
   - -device virtio-serial-device
   - -device virtconsole,chardev=con
-- 
2.47.3
