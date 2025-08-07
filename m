Received: from outbound.mail.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D6156228
	for <xenomai@lists.linux.dev>; Thu,  7 Aug 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561157; cv=fail; b=n0rmD9D/aLLpPu0+hm38K2b1u8D4zlLZ0RRz56/MKnDvYWnNP2b53L9g4rf7o/LDNObp1xPECe5EKE1ilVjwosytEkEC66AR4mClCHLkg4C2BIlEtAiNsXuxsgrIYijN6JFCaeAkCQl2KoW+Ond+R2SMJziLxQ9mGHODswogJRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561157; c=relaxed/simple;
	bh=DH/yCSjwWxZrBc3WnyARsc1UtwolYMaJXVJiCGOhfEQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=PsYtk1OgrGvcL0iEKxDv6WAAIik5GlYXHJ78yJWyMo9NK/Dcp4tWyz7PvmThsQRk1uWNwaTTUJbGzfqsXib/F9OcskFzlHVn8jV0XpaOziW59yO8Vm7ixpU+Z6rsN7KTy8FW7BqQhPT1DrhskS8PAskFwFa8VpA/jkuEbarotJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bG3Fv4Jf; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bG3Fv4Jf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpNKg8f1yjpVA9X+fudlOw2j6F/ifdhc8mPXZWm9fT+pgTUmapaPfYtFhzf6VpihAEfQ7cDrGpKjfQQzYts6SsFn+rPmr0kWbEOtWO62x+8pD7WOZhUSytPlGxMYft+jMoqvXck4F3UGBYz7wW5JURlRiEFHDGhCWbZ3oh9wUoQkVvwBg3KajhzmSVjmYJmyiiLr7Qy57oxTKfWXdoidWVUyy6KTT625G/DQjy+HzvGMaLJKAx/eCIezTzaQf1tBOHvgie/PTr1xow/QYBqa5aGlt1YTaXMKl+FdnqY9Kip7tk+VCfr1C1SAYUz6DN03+iw20VLB2sDswwN96acaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXDu7TQ9zHdgvbYvKRp+TwzfpIqINiNlBrMYQTv0uBs=;
 b=gvJ2x0U2tcpuasKUa+t6PZNksXEWQ/6UYCl5jpNugAeIZCD3LEUNz+lsAeli3qHseT2va5hLmUEfz82ZaczSMtIjePfF1rXvFq+4ubxIye2vthwnQhHzlnH+HlDy27u+9IjlszdPaCg0DcQSUIfCvpHRlI8ilKyc3j8LoWpYJ4sU0Ig2WXq73uH3/HTg7AhRJXMk6lZzLmODAv7hC5OCHfzbDARET2JXFttssci6Nq9huxRO6dELZtWoD+xpqB6tngUpQ4Cts34m8PAi2QrOX0bDspKUftRWuNsDAgeUO+gyMXDpjHZw47Ba1Tiun0A8zEIU6LH9rb0ENzthLDFfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDu7TQ9zHdgvbYvKRp+TwzfpIqINiNlBrMYQTv0uBs=;
 b=bG3Fv4JfVSRSiwWSAaSFem7GVLBTspR5ZSMVCiGkYlZ4o5AlJXsQov6KOMODBf4mUue0I4TcgEwMfkELOUThwwtcfrzyyBgcSgLkbgOt1/z86sU4hdos1Od9NDWVKCUl876ga0/qy1IG9/Z/hNi2l9FYLim4GawiZJbPI/fqL68Pl4eoXjsK7y2kS1D5I7U4XdiLN9IxzVkxYNz6cvEWWhl/YT/csXJNGD5hTgmNLz6OtDvS/dduv/itwnnLi77vsNXmbteuB9/zgt0SWIbNwR86kNJTjcCUIIoA0szlOBoXRqtTGsx+7Gul5RZloAHhsNvGucYi6NfGe0uE4zwlVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 10:05:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 10:05:52 +0000
Message-ID: <31c0f590-1ca2-4d49-aa9a-4112d99f6d94@siemens.com>
Date: Thu, 7 Aug 2025 12:05:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Switch hosting URLs to gitlab.com
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:610:e4::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e35040-0d68-4268-c9ef-08ddd599fddf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnR4WWE2NXVvNWZ6TVN4NFViMkFYQ0RUdk5hbkZVRnJXUk0zY09JTGhvWUw0?=
 =?utf-8?B?ZDBGYnB1MHI1ckRhdzVlZ0FqTmxjS1NOaEloQlBuRm4rQXFaa0pCQ3FMbGtB?=
 =?utf-8?B?cnJDL29TeUFjVjdtekoyKzBFODRrZEt1WVZqRTBRQnpicFh2dG1uZE02YStG?=
 =?utf-8?B?NmdVQ3Y2ZkJGclFkcTRoVUd1WGZObUljVXJPRHNtUGtLdGFCVmdSL1paamNz?=
 =?utf-8?B?azI4Ym42ZW91bVF1dWs0ODhySjgzTjd5Wm83dDJHeHZUQzFlZExrcjBmUkZm?=
 =?utf-8?B?a016SVQrK0UyNzA3OHRMV3hvc0hFZ1lRTlZsVHRKc05sSnVCSDNCenlxbThh?=
 =?utf-8?B?VmN6VVR5RzlXNnVNUDN5SnpXdnUrN0wwRDBEdkZCbUZuYXBYM1pOWnNIYjlE?=
 =?utf-8?B?SC9nT3RsR3BmL0Ruazhzazl2R0hyZjNVLzNyYzg3emh1MzZ4RWZzYmIxY0ls?=
 =?utf-8?B?Mlg3QXl6NDFGbHNuZkdmSUJJUEhlRWNJemdYRjdvWnVkWCt4TTgyZ1JUV1hZ?=
 =?utf-8?B?QTZlNEdkLzFQZGlWSUI3TkpnRWM5UTZTWWNNV0ZTR1hvNUh3Z2N0OCtKRXgz?=
 =?utf-8?B?NUcyaWhONjBydnQ0RVcrdXBLdEhzUDhUVTM0bVg0aUY3SG9iRUdJMHo4SElo?=
 =?utf-8?B?a1JFLzRxWmk4d1F4V05LUXFxelVWeTNwL2tQeGt0QXI0QXRYaE10NFYvL2t1?=
 =?utf-8?B?cUpOS2RONiszb1h5RGRKN0lKSWlYNm9RN2psRkNyallvOWRqSHhwRlRuVUhw?=
 =?utf-8?B?UktuTTVkMHZKTEJqZEZCYVRnMVZaMzlOb29TeFV6WmtWRzJoQmV5azZhd0lD?=
 =?utf-8?B?S2ZyWmQrS1JWUURDT1JoTGQ0eWFFODRkZ1lJR3lUbEp0dXhXUVVnT3FWb1h6?=
 =?utf-8?B?K3ZUazNlQ292Qjl1Y1orVDJqS1NaSnFpbW9YSTFVeFJheHJPYmU0amVKTVcz?=
 =?utf-8?B?VlU0amJTaUpLQ0llQ2FicTlUb2tsUEVtT3ZERWxES3VmTi9sVG05NEdEeHhv?=
 =?utf-8?B?b2FOMnNTYWtBeGlkUzRGYkRBVk5VR1dINE1RZWdNTFNkTlJGc01pNmVEUXp2?=
 =?utf-8?B?UGlQdWlhN2ZxM1ArNVlLNFpRTlBDelIvU2tUcnRkb3BOZEprVUNzRkk1Z1Q4?=
 =?utf-8?B?Um1rdjdncCtlYUR1bUNZV1VpRlBWYlVWQk5JeDEzWWNWQ0FvdXhJSUNOdTYr?=
 =?utf-8?B?L0FlQVc3M1VYTWlySUJNQjYvSDVNa0x3a0h4SGlOQkFLV0xyUzEyeVROWHhh?=
 =?utf-8?B?enMyUmNhNkpjZlYrVWZCQUxxZjZsTlk4RUl5RnIraUZXK0s4Q3I5TzR3Vkow?=
 =?utf-8?B?S2ZCS2xsbFZMKy96T3c3UkZ6TytONWJ2ZWtlS0o4YWRFZG9XNkZGZjAxdFJz?=
 =?utf-8?B?em1qWm1sNzViamJlaDU2cU1nZ1kwSFpXQnJhKzVBYmxrQzdvOXJLYWlVYitG?=
 =?utf-8?B?bVdBaHptYlJBbEEwZzFlK0Zia0N1bVBjeUIyK1g5ZzVNSDVzTHRtNEtWdUxm?=
 =?utf-8?B?YlBNRVJ0d2VqbzZhc2Y5SWJwQkUvbVZjZEo4QVQ0TG14Q2huWXpWVWVtdnND?=
 =?utf-8?B?RUtxbVNLbW5EM05NTkdBWGVxTWV0cXd0MTBHRDFrMHBPd2YvUWJ1OHFCbDA2?=
 =?utf-8?B?dWlENm1lYmJZTFplazVwRHBIOTlhR1pBSjUxNS9xNUNqaTJXTngxczBpMXQ4?=
 =?utf-8?B?TTRUR2dJOHV6K0RVcW5VU01qTkQ0ZjRsYkE3RUkzZXJKeDhmbXRNc2lnSFBV?=
 =?utf-8?B?TXVGa2pEOHZJNCtKeHJ1RlN1dGxCME9HZDRQejB6bzFMVUhIamRxSHh6UGQ2?=
 =?utf-8?Q?MM/B/yNnY4fzoN0fGnCFTXJmeKP/y2pU83fFE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUYyL3J0ZkVRNDEvaHp6OWtDQURGT0d6L2s5UFhXWDdhVXI1YTg0UmNNR3lp?=
 =?utf-8?B?Q00zMFJUVzRrWDBsNXptWEF4TVNKNzk2emRGMmZ1WjRrUnJQNnpJeDY4Qk5P?=
 =?utf-8?B?Z3FaQlVpMkV6Q1hLUjhTbE51OWUzYU5hK0E2ZGlkbW94TkFTSEwzZ3MvNHRN?=
 =?utf-8?B?V2d4NzEyeU4yUHBIbzd0UWtIdlkyYTN6YUtrYXJ3UFUrWFlNYmo2RFB6Ui9W?=
 =?utf-8?B?NWd2RjBWRHZkWU1vdFRWSDZmLzRIRm9yaG9iQy9mSVpEWTVlVHdVcmNpMngy?=
 =?utf-8?B?RTlTeWxZU0tUQmptQ0d1QklDTUQ4NmlLZXJPTUplU1c0aTlUc1NDMzJrcTdD?=
 =?utf-8?B?Uk16T0VUQTN0M1YzZlNVUmR5RVpMM1ZkMlVVSCszK3I3UmZHZ3Y0MkhleGxF?=
 =?utf-8?B?VEQxSUR6enNhUlQxU0hHT25kZDViNTRqTnV5ejIybUxZYWJqb29oWTIreStl?=
 =?utf-8?B?ZThMU2JkY3VHSzZFeFdKeFNDcXlYKzJTdGRnaHQxL3l4YndFczZHN3ZqU0Fl?=
 =?utf-8?B?emZwNzZHMnMxMGd0alFpNHNjSUVsaHgzUkp4TmtGaXc4TW9mcFZYc3MzRmho?=
 =?utf-8?B?aWtoTVJsOGMvcW9kQ3RGbHVuSXFldU1PclZjbXUrSHpWS1A5Qks5WDZBa1hT?=
 =?utf-8?B?WDY0SnlSQnZKdHNUMVl4d1g4SDNJc043RUlPUjFSanpWSUpOQWZyQlBkZTVQ?=
 =?utf-8?B?aEdHaHo3ektHeVJ5b0lOUmxlVmxVUDhqa3VHTUxnUlZpQU1oY0F3VVg2OU0v?=
 =?utf-8?B?WC83b2s2cWJVYnBBQWtHaGovMFJTRktXeFY3M1NkQUd5U2FydlJlWmdLWHk4?=
 =?utf-8?B?eTE0RFV2RWUxY3VteEUyV2owR0xzWnA1YzJWRm1WdE1WZXRqSHhjaDVXa21h?=
 =?utf-8?B?S3dYUlkyRGdsdE5UcEt0WFhZMExxMjIyelNRUUdTWkxUQlgxVXJaMC9OOFhR?=
 =?utf-8?B?RjJwZXkycVB5b3NmMVh0M0Vkdnc3czBRRzVkTVhyZWhHZHJ4WkswaWdiNWpo?=
 =?utf-8?B?TkxxNittNDlhQ2hQNGJXaDl0TDVxQkt6YjN3UXROcC9qYU5DQUQ5bU5ZbEFq?=
 =?utf-8?B?UjQ4cXVuVHBpUHk4bWpEallSVnZzZmZ6QU1GZFFtbEpkWVdsVDB1WFI0SnFB?=
 =?utf-8?B?eGwwQzk4VXc3azlhdU5zRlN4WnAzYXlWTW9SWkJ2WkN1TmFSVUlUc2tFZlRY?=
 =?utf-8?B?a2pvT1Y3MmVEY24xQ25JMGtGWTBHOHQ4MmMwTysvSXI3TzRsSVpBcWtaSklL?=
 =?utf-8?B?VVdITXRzbzliaG1nbjEyNy9FTnR6dnR3ZGZtS2ZmeVFYWFBad0JTUnovTFcz?=
 =?utf-8?B?Z2VIYnErVzBGRDJYaTBnVXN4QVptUDV4SjdPbTA5OGlMOGVMRDM2VEt3S3hW?=
 =?utf-8?B?Ky9jK3dwVzhvMGp2QXM1TWNhcnBNQmFidmVEVVJXZWFzVW1CRG5UaDIzSXNT?=
 =?utf-8?B?RDdoN1FxNEwxc1EyRW10aWtmTWdlaXpva3pCMXB2ZDM5TmlMNU5SdWFpU1R5?=
 =?utf-8?B?bDZMNFlpMldvRDZNTWFhY2NMcE5mUGdvaFAyZDNtQ3ZXK1BkcUQ2VGxWSXBJ?=
 =?utf-8?B?VHI5SkdEcVNReERBK1pYRk1EZm55S1A5WHhCSnA3KzFtTk1RQzlsb3Z3cWxL?=
 =?utf-8?B?OHZneWNhdlBZaEYzdUQwRG01bTB1alRQYlFDNkkzVXRXVHZZQVFJMTRvZVVN?=
 =?utf-8?B?S21JVEtKMTVCcmpsYlRFT05KWDBrREZ4NzR4Q2RoNzNNSEhxN2FvTnpVRURP?=
 =?utf-8?B?clBsNyt2ZG15Ni9RU3dKMFhPV0FUZ01QUmppN29sVkZJTDhDUGtCckdIamNT?=
 =?utf-8?B?ZERkKzZpNXJlNFpxS0huT1lvT3ZkdlJBRkVYbjhJRFhDSGxNYzcxOS9aVUJk?=
 =?utf-8?B?bzM4UGxHVUE3RTN4T3hsMDY3bUFOTFM3cjBQb25NaWRuUCtOaXNHak5scEh6?=
 =?utf-8?B?TGNzTHVTZ1lyNElubEJyM0VidnhQMmFXUUFOa2NCT2JLOGVocXMwU1k3M1hT?=
 =?utf-8?B?aFh5S3dUVHVQejFQS1BOQnRBMW9rWDJvcENpYzByM3lHZGdXeTl4alB5OVFq?=
 =?utf-8?B?ckhxUDJ0eWh1Y3N2MmluVXprQ1lHSTBCNmRLLzJDaitndHZJSitHY1B6UkxK?=
 =?utf-8?B?WGJ1aFZqT2graXF1V2ZFdjgvdjUrd2g4SHFILzhjbEJBNGdVd3JucnJvNVFU?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e35040-0d68-4268-c9ef-08ddd599fddf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 10:05:52.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIbbJ6SuZsz8doTZF1eFuO7ErSfeqyteE+Q1haDUrsUN/CAoMGwD050dCmd0Lw5bRPeovWDCR13RxDpHR2Q1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5329

From: Jan Kiszka <jan.kiszka@siemens.com>

The Xenomai project is step-wise migrating to gitlab.com because
source.denx.de will eventually be shut down. Repositories are already
mirrored, so we can start promoting and using the new URLs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3-dovetail.inc | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_latest.bb    | 8 ++++----
 recipes-kernel/linux/linux-xenomai-4-evl.inc      | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_latest.bb    | 4 ++--
 recipes-xenomai/libevl/libevl_50.bb               | 4 ++--
 recipes-xenomai/libevl/libevl_latest.bb           | 6 +++---
 recipes-xenomai/libevl/libevl_master.bb           | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
index a8612ba..3bff2d1 100644
--- a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
+++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,6 +11,6 @@
 
 require recipes-kernel/linux/linux-xenomai-3.inc
 
-SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
+SRC_URI += "git://gitlab.com/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 7381ea6..ff9e685 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -21,7 +21,7 @@ def is_kernel(d, ver):
 python () {
     import subprocess
     if is_kernel(d, 'latest'):
-        cmd = 'git ls-remote --tags --head --refs https://source.denx.de/xenomai/linux-dovetail.git | ' \
+        cmd = 'git ls-remote --tags --head --refs https://gitlab.com/xenomai/linux-dovetail.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
               'grep "v6\.[0-9].*-dovetail-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
@@ -34,7 +34,7 @@ python () {
 # default: amd64 or i386
 GIT_REPO = "${@ \
     'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
-    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+    else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH = "${@ \
     'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
@@ -47,7 +47,7 @@ GIT_BRANCH = "${@ \
 
 GIT_REPO:armhf = "${@ \
     'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
-    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+    else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:armhf = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
@@ -60,7 +60,7 @@ GIT_BRANCH:armhf = "${@ \
 
 GIT_REPO:arm64 = "${@ \
     'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
-    else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
+    else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
diff --git a/recipes-kernel/linux/linux-xenomai-4-evl.inc b/recipes-kernel/linux/linux-xenomai-4-evl.inc
index b13d203..5ca0f87 100644
--- a/recipes-kernel/linux/linux-xenomai-4-evl.inc
+++ b/recipes-kernel/linux/linux-xenomai-4-evl.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,6 +11,6 @@
 
 require recipes-kernel/linux/linux-xenomai-4.inc
 
-SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 689c50e..5718e3b 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -20,7 +20,7 @@ def is_kernel(d, ver):
 python () {
     import subprocess
     if is_kernel(d, 'latest'):
-        cmd = 'git ls-remote --tags --head --refs https://source.denx.de/Xenomai/xenomai4/linux-evl.git | ' \
+        cmd = 'git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
               'grep "v6\.[0-9].*-evl-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
@@ -36,5 +36,5 @@ GIT_BRANCH = "${@ \
     else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
-SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/libevl/libevl_50.bb b/recipes-xenomai/libevl/libevl_50.bb
index 26bcc2e..36c05b4 100644
--- a/recipes-xenomai/libevl/libevl_50.bb
+++ b/recipes-xenomai/libevl/libevl_50.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -11,4 +11,4 @@
 
 require libevl.inc
 
-SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
diff --git a/recipes-xenomai/libevl/libevl_latest.bb b/recipes-xenomai/libevl/libevl_latest.bb
index 2b57083..c7b5c15 100644
--- a/recipes-xenomai/libevl/libevl_latest.bb
+++ b/recipes-xenomai/libevl/libevl_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,13 +13,13 @@ require libevl.inc
 
 python () {
     import subprocess
-    cmd = 'git ls-remote --tags --head --refs https://source.denx.de/Xenomai/xenomai4/libevl.git | ' \
+    cmd = 'git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/libevl.git | ' \
           'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "r[0-9]\+" | ' \
           'sort -r -n -k 1.2 | head -1'
     (ret, out) = subprocess.getstatusoutput(cmd)
     d.setVar('LATEST_RELEASE', out)
 }
 
-SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${LATEST_RELEASE}"
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${LATEST_RELEASE}"
 
 CHANGELOG_V = "${@ d.getVar('LATEST_RELEASE').strip('r') }"
diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
index a1809ab..8fcf768 100644
--- a/recipes-xenomai/libevl/libevl_master.bb
+++ b/recipes-xenomai/libevl/libevl_master.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -11,7 +11,7 @@
 
 require libevl.inc
 
-SRC_URI += "git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV}"
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV}"
 
 CHANGELOG_V = "9999-${PV}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0
