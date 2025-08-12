Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A172EE5EC
	for <xenomai@lists.linux.dev>; Tue, 12 Aug 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999841; cv=fail; b=Uyo9auO27Guf/ees7twyfWvGGdL0dLXIKhs4+o0Nal4Oy32CYd/bIayMWND6YELuJk3GJhULXUm9zmz9GM6xlihUNO6xhv014GxjHlQA+jL3m/VaT4PXWzdyEoxeOoLk1mJuuLSNGVLswdzJhiQNzJum8tGy+zrB2nY5gH1ur0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999841; c=relaxed/simple;
	bh=cLj7FuI1QWy4G1pTlkexnTZjkuUrBZC9iRpplET0Tl8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=TrDPfGIKEE6K7JBb79nAJ9FcsRERnT31mvTt/AqtE7FUlP1IZVKesTMWZ5dlfWVPwCOw6boCNJIwNJYOyGEQ947HwiHlqaMnpMVKfF8Uaa2l6AuGBgptCZWch6dD2X+bkz77s57h4zTKSKZveHJDF5tKNDVS0XXgqO34+Atkjj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YyBAXx/M; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YyBAXx/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZDjej1PAYeh5q3uMctvX/CWMLnrssQKiGMKr6H32ioMX3uKmMh5uSNRLw3BuQ1Pnoo7K9qHn41apRCRHLZRMhgszZEvTBo7w0j2b+6UmBe4eS0Uf+7rysGU08dCKHtDLmEXHLCsB2Xso7EFnf9h4qOQ4Rk2aHTigcGarFiZI0JQtvxbqO+UddcXPdMvJs155Q6Xfj/C20UD4Ju2+bnnorJ8bkVL581XmXqGus0FsHYP3rxxedo7kSMYn4JcyB1kKvveN8uxWm3lxSjS0YRBNdPI4+qLu5avAo0OY7YBr5lV35QmPEUvtzaZUJl+ICvP3XbaK1Qbp9lIgsEDPJxZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPMluqrCG/5Eio4IV91tcq8Vk/1hzIdx6MlI6qWuNfg=;
 b=lM/l5c08VIB8LZN5szj1tcBV7UrsKPvW9vlg20evubaEy+qWzOQAwSvD6Aepgzf0Zrg9iTSGgbZS7LD+iVkFbEHwjcx77CY328QwozoSEoH7pbTAbwy/NydYM1YbaKuEJJ4z0Ffi+qxoLa3CVwB0J0HXuzriRSBllvd/YUgbF5t3FeQTlG0HdQjo0P2WWUnqZPylzjn5bD784qPxVj7Uy2PfEFJJG8wqyxwiaV7Qc8y2hNmsDiR7Zw03hTftgIvWJrsE1NG2MMebNaA0R0VH0W3wQxJ0A90wAUGU0S8xSDtTqCd7FnZhZ8S+WBs0cSpHW9XqWJGySyuro+vWdlksog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPMluqrCG/5Eio4IV91tcq8Vk/1hzIdx6MlI6qWuNfg=;
 b=YyBAXx/MHn/YkyPzJoDF/igzC27+GEBMQZt9yegiziQdMlIPLIj0sRJtKcsqCj7YFk5O/vApQ2jhCjNC9SNsq0IjMuueE4T80LG37eKIVuuhAf3IRlPx8hDCbSR66lWHGYKnCcLFRTl6u98yfpA5IMtthyh4Fa9UwCxGH0p4x7mM+CaWWh+fAH6izr8cNOUPRufEI4S3hrAgUw6XPbZko6gmpaIXwqYhz9KzyILIemU4n+pR8qQ83KVYN9Li+7EZhi0pnJgqSOUxjg2orHc/OEH6xwONPp61qt/Awfonp5zlwkG0daG3nIugXrvOKhGeB62W02Sgm4IzpmukK2h/fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 11:57:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:57:15 +0000
Message-ID: <b90d3598-8a77-4b13-b90b-efff08900522@siemens.com>
Date: Tue, 12 Aug 2025 13:57:11 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update to kas 4.8.2
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 152992b4-d5ce-4ba2-a217-08ddd99760f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGFQYWI1blBBenZtYWdSQlFENTVWM1ZkYTc0U3VuRmlhQ2pwL0lncEdkSldn?=
 =?utf-8?B?TXViWG1HcEpOcVEvZ29Rc0MyWVcrWUp2OFAyWkgyRndMVlNzR2lsQ2tBVFdF?=
 =?utf-8?B?Rm5xSFQ1eGxpbE5oUlFwdEJPbGo5ZlJLNGZsY2lveTgwUU1NVDZUU2JBNlZO?=
 =?utf-8?B?YWQ3dWkwRjlKMEwwUFNxYWQwSlZETFMrNzI2Tlc4ekE3U281ZVphWWZneE1P?=
 =?utf-8?B?aVFBNkFDSnlYRldpWlJaYWxOc1Y4S0c4YU9Gb01FZ2V1dzEvUkJQN0dFcm0z?=
 =?utf-8?B?b2VDU2RTZ1pGRXJsWGo1RlFBU1IxUzN6bE83SDlWZmVKMG0zMmxob3RsbU1l?=
 =?utf-8?B?QkRRQzhHMXJRdzYycmR0bjJiNENjeHFrbWtVMW9acGVZbG85R1l0dGRCaWpC?=
 =?utf-8?B?cm8rY1lwOFpVL0h2Y0hPZVBGUnhVdkFhZGoraWRlMmpLZmYxaVY3SE1TRzBz?=
 =?utf-8?B?THM3R0xUNndzc3lJMnVxNGp0L0NpQlFMQm9uOHFLVHRYMzNsVStVRUg0Y1pW?=
 =?utf-8?B?VENtU2NWN0lDOW5zL2hiNUZDN25lTVlFLytWVzJOV1pOTmE5YWNSTzJrbmV3?=
 =?utf-8?B?VGJzbFlvRmN3OXZyZHdqRVRWbVNPeDM0NjZOOWlOeFdacEhSMUVxNG1YaFFS?=
 =?utf-8?B?cnVldTZjbjJoMkVNcmM5SjJldmJEcjhxK3ZSVVQ3ZjZYNG15YU5iQzgrUWx0?=
 =?utf-8?B?dnlWWFNMODZ2eGtwa05Ub2pWUzErZFBveE5La1VXMXRaU0dHd1ozWC9qb0xJ?=
 =?utf-8?B?RUtsYlZ5eFZDNmhWaDRLZFhNWFgrcE9TQ2JVV1cycHZaa3d4TkxZZS82ZlFM?=
 =?utf-8?B?M1ZTbUVPZGVEN2VCNHhPbUZTN2NmSzN3ZU1iaFliQ01pV1luR0hFSXo3MmtF?=
 =?utf-8?B?NkM4QmxDTkkzWk1SZWZWU25wL0wxQWtNSXBCMEVveGxtZlg2Q0dpTmV3Sk0v?=
 =?utf-8?B?NExrR2llRGlIOUZXaTlSa1VMWWt1M0g3TWZKdlk3Q1ZzaXFaTm05N1NTbVhj?=
 =?utf-8?B?Y0R6UUw5eE9TbDR1QlgvNlZGZUwrMkxYYk5KT3E2WXRvTURMVDhsbXBtQnlw?=
 =?utf-8?B?WDRHMnZManRwK0EyYnE3aU1hYzlEdWExMDlvQzRmbzhIZVVEYTdsYUlNV1N1?=
 =?utf-8?B?OTZ1Rkp4YXBDZGMrQ0xib1hIbXdadlZlbTRiZEVndXhRZE1CMVFHa1c4VEM1?=
 =?utf-8?B?a2NDaG03aXJpWmQ3aURGWEZGZGtJVXNkanhONzhxQUh4MTZNSldMdDZrZ0RO?=
 =?utf-8?B?cis5cFpNQTdKZFJidDFsSUx3eFJsZlB0Q0k5dmRYSEZNOWFzSHVTcVpRQUw3?=
 =?utf-8?B?UFBKRkE0dGt5S1NrZG9TU2k3ektNRHZHWEpRTC9PYTdYTVJNZkpKcDF5Mkkx?=
 =?utf-8?B?N0k4enkzNW9lUDR0bEl2ZXJSeUE3MWdqd2RZZXZhUXFsQXowcEgyb3lEWGQ1?=
 =?utf-8?B?bXk1WWpEamlrZHRzZnlRdVVjcTUyT3dtTUY0MldJdnp4ZXE2N0M4bVBWQmJ4?=
 =?utf-8?B?ak9WcjFwUUw4aEQwWjdES1RaWEtJVVpkNXRWa2NkU3N1cmhvRDlnTDlSdGlw?=
 =?utf-8?B?ZTY2eHhFTkpFM2ZOVFE3RHAycVo5OU5iWllYSEVPN2tDQWhFcS93cysrWHVH?=
 =?utf-8?B?cWVvV0lWR004d3BZWkpJTWpjQkwxb3FGZ1NpcXFQTm54ZGxYVkhGblFucmNV?=
 =?utf-8?B?Qm9HMUNxVkZNSXhkWVR4aTBQY3d4cEFYVEhIQ3pUaU56eXNVYU1YWUpVSUxG?=
 =?utf-8?B?emM0QWFDcmZKa2QweStaSU1ZUERhdSsvWk1qZjhmdVBhY1lmOVlIeXdMa1ZU?=
 =?utf-8?Q?VajPiVfikJHHLiz3Lhz7+jjljaRti1+VKA7vI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3MyTXVONzRmRDRFczVhQ1pPc0tYN21QUVE1b0Ivem53MjJoVnVUdEVWUGty?=
 =?utf-8?B?NW1sVzBBNjVzSEt5bUxTcUZ0SVNMRTFuQk1PTHdSUHgyQXdhOGphWC82eTRJ?=
 =?utf-8?B?Ry9YcHdQa0FmM3dLS01SZXN4Qy81NnY4a0R0anR6T1JEL2xJU0IzWnhrZnZo?=
 =?utf-8?B?OEVUQU52SktGU0ZwcCtyVFFmL3JzMXFlcjZsQTc5bWNLZGhnOVFiZWJwYm9U?=
 =?utf-8?B?dWtiSnJqTkMrS2NWWXFFdkFiOE5NTFRvV0FlNm10RlBDRkQ5OHl6WEE0M0VP?=
 =?utf-8?B?RGRsWlVCWDcyaTN0WTdLYXI0TFVrdjZ4aXdjQlpRejU4K0hrc0dYVUlCK2Vi?=
 =?utf-8?B?NVBjcFF2ZGxHckVTbkRWSjhXYXBqZmNqc2N6WEpkcXVwSnV4a1B6eXRTSEN1?=
 =?utf-8?B?Y0RuU1crMG1WZ3ZpNmhJQXVET3BuUnJINWdDQVF6SDRHYXJMNjVUZ2xNVWJp?=
 =?utf-8?B?alR0ay9ka0YvelB0VHdnWkFvcGVPemdoL3haSGhGM2tpSWpER1RuRHhXSk5s?=
 =?utf-8?B?ck1BbHlLdWdFVVRYd05qOHJhMmswcENzeFoxcHVENCt3Tk5TSXF0SWZhMmdR?=
 =?utf-8?B?U1hkQkgxSVkrNnJhSkpCU0dtNlU2T1FyQVdJOXFSNTFXYmlXQXdTSERrcVhI?=
 =?utf-8?B?OStGTTEySjBkL3ZVY2JlMEJ6WFpqN1FlTnloRHU4MGVwblpsVUp5eHRodVZl?=
 =?utf-8?B?KzFWcHhlSkhGclJmRFNsZm40ZU1JVGRTam5NZFplVk1mV1h5WEp0Y2YrcWVZ?=
 =?utf-8?B?THJPbFcyV0NXZTZOLzQ3NXNoVFhrUU9XM3dZSXFDQ3oyYmFvN3BIWVJyVUt3?=
 =?utf-8?B?Vm1KNFoyZnJxbnMzcTJSQ2NxN2IvUHVheUJwV1hEUjlhN0YzMnVZUUFvZ2RR?=
 =?utf-8?B?ODdKQUV1enEvb2lVd1IvdGxNOENKVjdWemtHeFlmWFNZcTZSRzQzZ3R5cldi?=
 =?utf-8?B?M3ZmLy81ZXhNQ1RKZXAxOFBHTFU1amNXR0FpaGVQRm4rdFM5SE84ZTNGdXk4?=
 =?utf-8?B?Z2VqT01UNHoyclJub3FxQmpzSnk3M1h4WmhNZHFRZFM3ci9BeWk1SEFkVzU0?=
 =?utf-8?B?bGV2R0QvSnNkUUlnMTZMTmVQaGJOdE5HS0VPajREYzlUTXlNclA2KzVrbm51?=
 =?utf-8?B?U0pZbFlJUXppRzY1RG1FSHBZN2syKzBmSWZoRzRlVnVZbit3ZG1uNzk0RUw3?=
 =?utf-8?B?bHl5RnkyZjloQ3N3NVJmb1IyZXFsanNnWTF2dVFYQ0QvSVU0RWdySnJuV0tF?=
 =?utf-8?B?UFJMUW94cWgyR2hKSmkyWnhnNG43NUgySGx4VmFzQ0NHQXRtNVlhWWJoMWZh?=
 =?utf-8?B?MUREZnFzSXJEa2RjbURoaUpiek1vNXE1VlRrUHhnbkN3MVBlK3lWYU1SR2VM?=
 =?utf-8?B?WHcwcGRJanFwRFcyOXVpRkIzaGlLNnpXMlFVQ0NLSWlJUmhuaVVvS1pRajBF?=
 =?utf-8?B?WUJXa2hCOC8xckd6TCtqeFYyeE8vai80dUxUZ2w1QjZCVlhONXJrOVVSa2tm?=
 =?utf-8?B?RDFVMjZEZUhzNjlZd0E5a3IyWEdnUFdRUStObTJYb3F4WnJiU202dEtTUVpp?=
 =?utf-8?B?MEdDTmNzOWtLYmV4MjVYQkxReTNFN0FzVnB3eXFKL25UTjJxRTdCanIzY09j?=
 =?utf-8?B?MExzWjRlaTVYNE5CRmlScFRoKy91NTFQb2xJeEVTOXprNDZMVXluODhYcm93?=
 =?utf-8?B?RFcvRHZFTjluUzRmcHJtNnloeU9vbGp5WnA1bHdiNkp5MFhXWml1MHptd1lx?=
 =?utf-8?B?YmVoVXg2d210YTRVRy9HelQ5Q3dNdEtIM1N3N1UzMlVnOFpzNFNNbmhFLzYr?=
 =?utf-8?B?OWcvaG50VjhjR1FybkVYeFlyR3dUeGdKT0YwRWdOK05xVDdTaUNsVGJDVlE2?=
 =?utf-8?B?dUg3d0lTQmNjbWpKQ3NRNjlZN0V3OVljM0tGNUJ0TGJLWExWQ2hmY05aSmsw?=
 =?utf-8?B?UnZKRjJWT2dscWg3OTdXTkgvZks0NXViYVJ5amh4M0N3dFYzWEc3TkRFV05B?=
 =?utf-8?B?MmVUTTg3QkVDQS9vYWlTVzVPMzY2TVpLL1dOaE5kekNDa3MxNWdudTRUMUdj?=
 =?utf-8?B?V3NrcUFTeEpJOW9QbVZiR0gxbVF6ajUrV2V0Tmg5cDE4VTQzZXdiSHIvb0xK?=
 =?utf-8?B?U3IxY0ZsZGpidHhlV0g5K3NoeEJUUXV0YTdhdytZUG13dzlXN0Y5STNHNEE2?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152992b4-d5ce-4ba2-a217-08ddd99760f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:57:15.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KG1aCruw/cTn/oKaM6aoQjgX7nZ3HCJ8ibexQdXUp39SaICchEkknqyoA5L2kiUO3m50TCzGZkbjYx24bTTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6828

From: Jan Kiszka <jan.kiszka@siemens.com>

Just housekeeping. Should also avoid surprises when eventually updating
the Debian release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml |   2 +-
 kas-container         | 354 +++++++++++++++++++++++++++++-------------
 2 files changed, 245 insertions(+), 111 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 6b31381..25a18d3 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -30,7 +30,7 @@ variables:
   SSTATE_MAX_AGE: 14d
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.6
+  image: ghcr.io/siemens/kas/kas-isar:4.8.2
 
 .sstate-prepare:
   script:
diff --git a/kas-container b/kas-container
index 0437381..476724c 100755
--- a/kas-container
+++ b/kas-container
@@ -2,7 +2,7 @@
 #
 # kas - setup tool for bitbake based projects
 #
-# Copyright (c) Siemens AG, 2018-2024
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -27,7 +27,8 @@
 
 set -e
 
-KAS_IMAGE_VERSION_DEFAULT="4.6"
+KAS_CONTAINER_SCRIPT_VERSION="4.8.2"
+KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -40,8 +41,9 @@ usage()
 
 	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump | lock } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { diff } [KASOPTIONS] config1 config2\n"
 	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
-	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall } [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall | purge} [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
@@ -57,6 +59,8 @@ usage()
 		    "keep downloads.\n"
 	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
 		    "downloads.\n"
+	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
+	printf "%b" "     \t\t\tto check what would be removed\n"
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
@@ -80,7 +84,7 @@ usage()
 		    "environment.\n"
 	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
 		    "\t\t\t(default for build command)\n"
-	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
+	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
 		    "\t\t\t(default for shell command)\n"
 	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
@@ -90,22 +94,31 @@ usage()
 	exit "${EXIT_CODE:-1}"
 }
 
-fatal_error(){
+fatal_error()
+{
 	echo "${KAS_CONTAINER_SELF_NAME}: Error: $*" >&2
 	exit 1
 }
 
-warning(){
+warning()
+{
 	echo "${KAS_CONTAINER_SELF_NAME}: Warning: $*" >&2
 }
 
+debug(){
+	if [ -n "${KAS_VERBOSE}" ]; then
+		echo "${KAS_CONTAINER_SELF_NAME}: Debug: $*" >&2
+	fi
+}
+
 trace()
 {
 	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
 	"$@"
 }
 
-enable_isar_mode() {
+enable_isar_mode()
+{
 	if [ -n "${ISAR_MODE}" ]; then
 		return
 	fi
@@ -119,10 +132,17 @@ enable_isar_mode() {
 		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
 		# preserved user PATH may lack sbin needed by privileged podman
 		export PATH="${PATH}:/usr/sbin"
+	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
+		debug "kas-isar does not support rootless docker. Using system docker"
+		# force use of well-known system docker socket
+		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_DOCKER_ROOTLESS=0
 	fi
 }
 
-enable_oe_mode() {
+enable_oe_mode()
+{
 	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
 		# The container entry point expects that the current userid
 		# calling "podman run" has a 1:1 mapping
@@ -130,30 +150,122 @@ enable_oe_mode() {
 	fi
 }
 
-run_clean() {
-	if [ -n "${KAS_ISAR_ARGS}" ]; then
-		# SC2086: Double quote to prevent globbing and word splitting.
-		# shellcheck disable=2086
-		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
-				--workdir=/build --rm ${KAS_ISAR_ARGS} \
-				${KAS_CONTAINER_IMAGE} \
-				sudo rm -rf tmp
-	else
-		trace rm -rf "${KAS_BUILD_DIR}"/tmp*
+enable_unpriv_userns_docker()
+{
+	if [ -f /etc/os-release ] && grep -q 'NAME="Ubuntu"' /etc/os-release &&
+	   [ -f /proc/sys/kernel/apparmor_restrict_unprivileged_userns ] &&
+	   [ "$(cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns)" = "1" ]; then
+		if [ -f /etc/apparmor.d/rootlesskit ]; then
+			debug "AppArmor restricts unprivileged userns, using \"rootlesskit\" profile"
+			KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt apparmor=rootlesskit"
+		else
+			warning "AppArmor restricts unprivileged userns but no suitable apparmor " \
+			        "profile found. Consider setting apparmor_restrict_unprivileged_userns=0"
+		fi
 	fi
+}
+
+# Params: NAME CREATE_MODE
+check_and_expand()
+{
+	eval _varval=\"\$"$1"\"
+	[ -z "$_varval" ] && return
+	case "$2" in
+	required)
+		[ ! -d "$_varval" ] && fatal_error "Variable $1 set, but \"$_varval\" is not a directory."
+		;;
+	create)
+		[ ! -d "$_varval" ] && trace mkdir "$_varval"
+		;;
+	createrec)
+		trace mkdir -p "$_varval"
+		;;
+	esac
+	realpath -e "$_varval"
+}
 
-	if [ "$1" != "clean" ]; then
-		SSTATE_DIR=${SSTATE_DIR:-${KAS_BUILD_DIR}/sstate-cache}
-		trace rm -rf "${SSTATE_DIR}"
+# Params: FILE
+# Returns: root repo dir of file
+repo_path_of_file()
+{
+	_DIR="$(dirname "$1")"
+	_REPO_DIR=$(git -C "${_DIR}" rev-parse --show-toplevel 2>/dev/null) \
+		|| _REPO_DIR=$(hg --cwd "${_DIR}" root 2>/dev/null) \
+		|| _REPO_DIR=${_DIR}
+	echo "$_REPO_DIR"
+}
 
-		if [ "$1" = "cleanall" ]; then
-			DL_DIR=${DL_DIR:-${KAS_BUILD_DIR}/downloads}
-			trace rm -rf "${DL_DIR}"
+# Params: ARG
+process_file_arg()
+{
+	_KAS_FILES=
+	_KAS_FIRST_FILE=
+	_KAS_REPO_DIR=
+	# SC2086: Double quote to prevent globbing and word splitting.
+	# shellcheck disable=2086
+	for FILE in $(IFS=':'; echo $ARG); do
+		if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
+			fatal_error "configuration file '${FILE}' not found"
+		fi
+		if [ -z "${_KAS_FILES}" ]; then
+			_KAS_FIRST_FILE="${KAS_REAL_FILE}"
+			_KAS_FILES="${KAS_REAL_FILE}"
+			_KAS_REPO_DIR=$(repo_path_of_file "${_KAS_FIRST_FILE}")
+		else
+			_KAS_FILES="${_KAS_FILES}:${KAS_REAL_FILE}"
 		fi
+	done
+	KAS_FILES="${KAS_FILES} ${_KAS_FILES}"
+	KAS_FIRST_FILES="${KAS_FIRST_FILES} ${_KAS_FIRST_FILE}"
+	KAS_REPO_DIRS="${KAS_REPO_DIRS} ${_KAS_REPO_DIR}"
+}
+
+# Params: NAME CONTAINER_PATH MODE
+# If the dir is not below KAS_WORK_DIR, the dir is mounted into the container.
+forward_dir()
+{
+	eval _varval=\"\$"$1"\"
+	[ -z "$_varval" ] && return
+	FW_DIR_REL=$(realpath -q --relative-base="${KAS_WORK_DIR}" "$_varval")
+	if [ "${FW_DIR_REL}" = "$_varval" ]; then
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -v ${FW_DIR_REL}:$2:$3 -e $1=$2"
+	else
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e $1=/work/${FW_DIR_REL}"
+	fi
+}
+
+check_docker_rootless()
+{
+	KAS_DOCKER_ROOTLESS=0
+	if [ "$(docker context show)" = "rootless" ]; then
+		KAS_DOCKER_ROOTLESS=1
+	fi
+}
+
+enable_docker_rootless()
+{
+	warning "Rootless docker used, only limited functionality available."
+	if [ "${KAS_WORK_DIR}" = "${KAS_REPO_DIR}" ]; then
+		warning "On docker rootless a exclusive KAS_WORK_DIR should be used" \
+		        "as kas temporarily changes the ownership of this directory."
+	fi
+	if [ "${KAS_REPO_MOUNT_OPT}" = "rw" ]; then
+		fatal_error "Docker rootless requires read-only repo."
+	fi
+	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
+}
+
+KAS_GIT_OVERLAY_FILE=""
+kas_container_cleanup()
+{
+	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
+		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
 	fi
 }
+trap kas_container_cleanup EXIT INT TERM
 
-set_container_image_var() {
+set_container_image_var()
+{
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
@@ -161,11 +273,18 @@ set_container_image_var() {
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
 }
 
-KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
-# KAS_WORK_DIR needs to exist for the subsequent code
-trace mkdir -p "${KAS_WORK_DIR}"
-KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
-trace mkdir -p "${KAS_BUILD_DIR}"
+# SC2034: DIR appears unused (ignore, as they are used inside eval)
+# shellcheck disable=2034
+setup_kas_dirs()
+{
+	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
+	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
+	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
+	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
+	DL_DIR="$(check_and_expand DL_DIR createrec)"
+	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
+}
+setup_kas_dirs
 
 KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
 if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
@@ -196,6 +315,8 @@ KAS_RUNTIME_ARGS="--log-driver=none --user=root"
 case "${KAS_CONTAINER_ENGINE}" in
 docker)
 	KAS_CONTAINER_COMMAND="docker"
+	enable_unpriv_userns_docker
+	check_docker_rootless
 	;;
 podman)
 	KAS_CONTAINER_COMMAND="podman"
@@ -248,7 +369,7 @@ while [ $# -gt 0 ]; do
 		if [ -z "${SSH_AUTH_SOCK}" ]; then
 			fatal_error "no SSH agent running"
 		fi
-		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
+		KAS_SSH_AUTH_SOCK=$(realpath -e "$SSH_AUTH_SOCK")
 		shift 1
 		;;
 	--aws-dir)
@@ -290,7 +411,8 @@ while [ $# -gt 0 ]; do
 	--*)
 		usage
 		;;
-	clean|cleansstate|cleanall)
+	clean|cleansstate|cleanall|purge)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 		KAS_CMD=$1
 		shift 1
 		break
@@ -307,6 +429,12 @@ while [ $# -gt 0 ]; do
 		shift 1
 		break
 		;;
+	diff)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
 	dump)
 		if printf '%s\0' "$@" | grep -xqz -- '--inplace\|-i'; then
 			KAS_REPO_MOUNT_OPT_DEFAULT="rw"
@@ -326,11 +454,12 @@ done
 [ -n "${KAS_CMD}" ] || usage
 
 KAS_EXTRA_BITBAKE_ARGS=0
+KAS_FILES=
 
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
-	--skip|--target|--task)
+	--format|--indent|--provenance|--skip|--target|--task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
 		shift 1
 		shift 1 || KAS_OPTIONS="--help"
@@ -343,11 +472,6 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	-E|--preserve-env)
 		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
-	--provenance)
-		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
-		shift 1
-		shift 1 || KAS_OPTIONS="--help"
-		;;
 	--)
 		KAS_EXTRA_BITBAKE_ARGS=$#
 		;;
@@ -367,29 +491,13 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 				unset ARG
 			fi
 		fi
-		KAS_FILES=
-		# SC2086: Double quote to prevent globbing and word splitting.
-		# shellcheck disable=2086
-		for FILE in $(IFS=':'; echo $ARG); do
-			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
-				fatal_error "configuration file '${FILE}' not found"
-			fi
-			if [ -z "${KAS_FILES}" ]; then
-				KAS_FIRST_FILE="${KAS_REAL_FILE}"
-				KAS_FILES="${KAS_REAL_FILE}"
-			else
-				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
-			fi
-		done
+		process_file_arg "$ARG"
 		;;
 	esac
 done
 
-if [ -n "${KAS_FIRST_FILE}" ]; then
-	KAS_FILE_DIR="$(dirname "${KAS_FIRST_FILE}")"
-	KAS_REPO_DIR=$(git -C "${KAS_FILE_DIR}" rev-parse --show-toplevel 2>/dev/null) \
-		|| KAS_REPO_DIR=$(hg --cwd "${KAS_FILE_DIR}" root 2>/dev/null) \
-		|| KAS_REPO_DIR=${KAS_FILE_DIR}
+if [ -n "${KAS_FIRST_FILES}" ]; then
+	KAS_REPO_DIR=$(echo "${KAS_REPO_DIRS}" | awk '{print $1}')
 else
 	KAS_REPO_DIR=$(pwd)
 fi
@@ -402,8 +510,8 @@ if [ -n "${SOURCE_DIR_HOST}" ]; then
 fi
 
 if [ "${KAS_CMD}" = "menu" ]; then
-	if [ -z "${KAS_FIRST_FILE}" ]; then
-		KAS_FIRST_FILE="Kconfig"
+	if [ -z "${KAS_FIRST_FILES}" ]; then
+		KAS_FIRST_FILES="Kconfig"
 	fi
 
 	# When using the menu plugin, we need to track the KAS_REPO_DIR outside
@@ -412,20 +520,26 @@ if [ "${KAS_CMD}" = "menu" ]; then
 	# on the host. This data is then added to the .config.yaml where it can
 	# be evaluated by the next invocation of kas-container.
 
-	if ! [ "$(realpath -qe "${KAS_REPO_DIR}")" = "$(realpath -qe "${KAS_WORK_DIR}")" ]; then
-		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
+	KAS_REPO_DIR=$(check_and_expand KAS_REPO_DIR required)
+	if ! [ "${KAS_REPO_DIR}" = "${KAS_WORK_DIR}" ]; then
+		set -- "$@" -e _KAS_REPO_DIR_HOST="${KAS_REPO_DIR}"
 	fi
 
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILE}" | \
+	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
+		fatal_error "menu plugin only supports a single Kconfig file"
+	fi
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
 		    -e 's/.*default \"\(.*\)\".*/\1/')
 else
-	if [ -z "${KAS_FIRST_FILE}" ]; then
-		KAS_FIRST_FILE="${KAS_WORK_DIR}/.config.yaml"
+	if [ -z "${KAS_FIRST_FILES}" ]; then
+		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
 	fi
 
-	BUILD_SYSTEM=$(grep -e "^build_system: " "${KAS_FIRST_FILE}" 2>/dev/null | \
+	# We only get the first build system and let kas check if mixed
+	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
+	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
 		sed 's/build_system:[ ]\+//')
 fi
 
@@ -435,37 +549,70 @@ elif [ -z "${ISAR_MODE}" ]; then
 	enable_oe_mode
 fi
 
+# clean can be executed without config, hence manually forward the build system
+if [ "${ISAR_MODE}" = "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
+	KAS_OPTIONS="${KAS_OPTIONS} --isar"
+fi
+
 set_container_image_var
 
-# short circuit for clean* commands. We just need
-# the build-system information, but no repo mounts, etc...
-if echo "${KAS_CMD}" | grep -qe "^clean"; then
-	run_clean "${KAS_CMD}"
-	exit 0
+if [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+	KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 fi
-
 KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
 
-KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
-
 if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
 	fatal_error "Running as root - may break certain recipes." \
 	            "Better give a regular user docker access. Set" \
 	            "KAS_ALLOW_ROOT=yes to override."
 fi
 
+if [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+	enable_docker_rootless
+fi
+
+if [ "${KAS_CMD}" = "diff" ]; then
+	if [ "$(echo "${KAS_FILES}" | wc -w)" -eq "2" ]; then
+		_KAS_REPO_DIR1="$(echo "${KAS_REPO_DIRS}" | awk '{print $1}')"
+		_KAS_REPO_DIR2="$(echo "${KAS_REPO_DIRS}" | awk '{print $2}')"
+		_KAS_FILES1="$(echo "${KAS_FILES}" | awk '{print $1}' | sed 's|'"${_KAS_REPO_DIR1}"'/|/repo/|g')"
+		_KAS_FILES2="$(echo "${KAS_FILES}" | awk '{print $2}' | sed 's|'"${_KAS_REPO_DIR2}"'/|/repo2/|g')"
+		KAS_FILES="${_KAS_FILES1} ${_KAS_FILES2}"
+		set -- "$@" -v "${_KAS_REPO_DIR2}:/repo2:${KAS_REPO_MOUNT_OPT}"
+	fi
+else
+	KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
+fi
 set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT_OPT}" \
 	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
-	-v "${KAS_BUILD_DIR}":/build:rw \
 	--workdir=/repo \
-	-e KAS_BUILD_DIR=/build \
+	-e KAS_CONTAINER_SCRIPT_VERSION="${KAS_CONTAINER_SCRIPT_VERSION}" \
 	-e USER_ID="$(id -u)" -e GROUP_ID="$(id -g)" --rm --init
 
-if [ -n "${KAS_SSH_DIR}" ] ; then
-	if [ ! -d "${KAS_SSH_DIR}" ]; then
-		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
+forward_dir KAS_BUILD_DIR "/build" "rw"
+forward_dir DL_DIR "/downloads" "rw"
+forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
+forward_dir SSTATE_DIR "/sstate" "rw"
+
+if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
+	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
+	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
+	# we have to mount the common dir in the container to make git work
+	# The mount path inside the container is different from the host path. Hence, we over-mount
+	# the .git file to point to the correct path.
+	KAS_GIT_OVERLAY_FILE=$(mktemp)
+	sed "s|gitdir: ${git_com_dir}/|gitdir: /repo-common/|" "${KAS_REPO_DIR}/.git" > "${KAS_GIT_OVERLAY_FILE}"
+	set -- "$@" -v "${git_com_dir}:/repo-common:${KAS_REPO_MOUNT_OPT}" \
+		-v "${KAS_GIT_OVERLAY_FILE}:/repo/.git:ro"
+	# if the workdir is the same as the repo dir, it is the same shared worktree
+	if [ "${KAS_WORK_DIR}" = "${KAS_REPO_DIR}" ]; then
+		set -- "$@" -v "${KAS_GIT_OVERLAY_FILE}:/work/.git:ro"
 	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
+fi
+
+KAS_SSH_DIR="$(check_and_expand KAS_SSH_DIR required)"
+if [ -n "${KAS_SSH_DIR}" ] ; then
+	set -- "$@" -v "${KAS_SSH_DIR}":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
@@ -476,20 +623,18 @@ if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
 		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
 fi
 
+KAS_AWS_DIR="$(check_and_expand KAS_AWS_DIR required)"
 if [ -n "${KAS_AWS_DIR}" ] ; then
-	if [ ! -d "${KAS_AWS_DIR}" ]; then
-		fatal_error "passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
-	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+	set -- "$@" -v "${KAS_AWS_DIR}":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
 if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
 	if [ ! -f "${AWS_WEB_IDENTITY_TOKEN_FILE}" ]; then
-		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a directory"
+		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a file"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
+	set -- "$@" -v "$(realpath -e "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
 		-e AWS_WEB_IDENTITY_TOKEN_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/web_identity_token}" \
 		-e AWS_ROLE_ARN="${AWS_ROLE_ARN}"
 fi
@@ -501,7 +646,7 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 		fatal_error "passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
-	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
+	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
@@ -511,17 +656,22 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
 fi
 
 if [ -f "${NETRC_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+	set -- "$@" -v "$(realpath -e "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
+if [ -f "${NPMRC_FILE}" ]; then
+	set -- "$@" -v "$(realpath -e "${NPMRC_FILE}")":/var/kas/userdata/.npmrc:ro \
+		-e NPMRC_FILE="/var/kas/userdata/.npmrc"
+fi
+
 if [ -f "${GITCONFIG_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
+	set -- "$@" -v "$(realpath -e "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
 		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
 fi
 
 if [ -f "${REGISTRY_AUTH_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
+	set -- "$@" -v "$(realpath -e "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
 		-e REGISTRY_AUTH_FILE="/var/kas/userdata/.docker/config.json"
 fi
 
@@ -529,19 +679,6 @@ if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
 
-if [ -n "${DL_DIR}" ]; then
-	trace mkdir -p "${DL_DIR}"
-	set -- "$@" \
-		-v "$(readlink -fv "${DL_DIR}")":/downloads:rw \
-		-e DL_DIR=/downloads
-fi
-
-if [ -n "${SSTATE_DIR}" ]; then
-	trace mkdir -p "${SSTATE_DIR}"
-	set -- "$@" \
-		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
-		-e SSTATE_DIR=/sstate
-fi
 if [ -n "${SSTATE_MIRRORS}" ]; then
 	if echo "${SSTATE_MIRRORS}" | grep -q "file:///"; then
 		warning "SSTATE_MIRRORS contains a local path." \
@@ -550,18 +687,15 @@ if [ -n "${SSTATE_MIRRORS}" ]; then
 	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
 fi
 
-if [ -n "${KAS_REPO_REF_DIR}" ]; then
-	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
-		fatal_error "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
-	fi
-	set -- "$@" \
-		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
-		-e KAS_REPO_REF_DIR=/repo-ref
+# propagate timezone information to entrypoint (requires systemd 239)
+if command -v timedatectl >/dev/null; then
+	set -- "$@" -e "KAS_HOST_TZ=$(timedatectl show -p Timezone --value 2>/dev/null)"
 fi
 
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
-           GIT_CREDENTIAL_USEHTTPPATH; do
+           GIT_CREDENTIAL_USEHTTPPATH \
+           TZ; do
 	if [ -n "$(eval echo \$${var})" ]; then
 		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
 	fi
-- 
2.43.0
