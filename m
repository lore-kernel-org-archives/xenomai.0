Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB71E520
	for <xenomai@lists.linux.dev>; Thu, 18 Jul 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276104; cv=fail; b=fB/CVitAgr9zKoTNtgosmTRbwd9qK1QPcvqMyAmgYAXONXvQHhp+lCkVsiAzMP/QV1sv0peeGKojLa/5CCkc160+hgXk/swoH0FXNe71Tg9Ot4SGW2u9xbTSazCp55Yqe9aUzG0mIBqPCw89Oo7/7PSFglpPt63CPHA0kVe9H/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276104; c=relaxed/simple;
	bh=cwWUDdad+kFoLzlK1J/Uy+vDTs1CNoiZ1Vp0ROwob/o=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4i/17M5tzbHn2oppKIWYYuiBV9KD+U60laZ9plDRwNEn1EDSNqq7oRizdGrO5WdTtJJwKQClihlwjFR8iYvLF8Ol5vfDZIRmfDqwpwc2jp025ssHhB/5pEwCbpr0Dn0D6afK7+r8rwlR68hECjZ/wGUZAbDDkZWsyjps1ilMHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zlyzvDYe; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zlyzvDYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXXS1pD+1matqjdJDrrTZpTLeidgWKGw1GtCX4l/HU3kZbNlN/bimVLNQb5WKmwjXqMGfPphzFLGrfq31wYErWa4XFU+w+/UamCMA6K+SVMUqMFSeMQhEl8HKG4nEApb7swyBHLaWflQZG1kXPhK9+fGs/dUO+aVS/WAIF+OAziO7zpAC//3dy8Y83vdpoNLO5XQ7J0GVOFUtKhro2Q3I4hq38FYzrO74wXZhGEqM5oR0LjEnZXg2rxRZ7xrrIwYqmOJ6EkTecTEZY+0tgUmv+1941DV/CIbSf1s4I6n58lyZPhvjaQzge3xmiOaeN0XQgPzAtmj2Kk5Sp94EqM4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHVvIcwG1jZgNtbXsBc4hyFI4X7fLSNDQdpDOCdZUCo=;
 b=RsgNt6h2hd3WjbbtOc9zSUUPFp+Fr005ks9ze59xp90VrlN7uMLKjOxACL6QorRS25AnOTXYP5jwUmEovX6Rbb/VHk3Ak5qELLNax2Yh+X3mzvKN8VJ4+oa8L034m7+AqZh9q+vNCJyf9G3af+/biPo7L5c2bgzil/XKFbZan8E5G1ztNcj5kPv5RtXydnZLV4u7BPRhCn3SLVxLnRhKXpqXf7SggJoi8kjL757+lF/Ka7N0uyLPiVGWz6pwo5c+1y84iwGyc2im+8ZJvu4VGDB9VrjMGU7Oh2ymA2EQ0OudmCj58B/IrQzNi1bg+2vNVZKvYNGZwu1C1sj1LlBrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHVvIcwG1jZgNtbXsBc4hyFI4X7fLSNDQdpDOCdZUCo=;
 b=zlyzvDYe9Hnc761hV8W7kWnZfUdp8YBTkx3RA60Py9BPqk9o4e8oWAtEam8KvDGTBsHb+bhX4JNx497u0q/43F4Cclmvd5XbclCBKJk4e0JvS1+1UQ1ppvMVPvl+179CgQ5T0FLfJTB41m4ac40WyroPLhYGcPwBgxYb7t8wqenmR8vzITzNkeLUi9gaH9bNlqjbboZjLiY257WypNY66zXpwL8KyMx2xICsey4/Vd6t94zp9S9Na+CPgym33Q8Hpr92hGARF0LZukj1UO4H0/wpjuY3ro712/UIBUs7SYZ1xI3wWH2REeF2czVxNyJlSU0U0ixJcoOBACLtrSB/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 04:14:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 04:14:56 +0000
Message-ID: <fdc86873-434d-4347-ba7f-35c0a7d0f60f@siemens.com>
Date: Thu, 18 Jul 2024 06:14:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: add x86-64-efi target to long term
 test
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240717193152.510216-1-tobias.schaffner@siemens.com>
 <f4c2a08d-9f80-43fa-9dff-d7d6f1d81bfa@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f4c2a08d-9f80-43fa-9dff-d7d6f1d81bfa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 665511f1-76b7-4cc8-a123-08dca6e02ea0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmdlZ241eFdDU2RJS00wU09yWUpsdUF4U2JQUWd5ZHUyOE1teWU3WVZZcVVm?=
 =?utf-8?B?Ry9wQnNZckcwOHpNQllzRmtxSGo1SzEvQ2FOSjJrdHhVeGkzckNjUFNyNDhY?=
 =?utf-8?B?UGVWSEhjcWVCeElWbm84OVF1MDVpVWZUc2xRQjU1cGFnMExkT0dTcmN4blFI?=
 =?utf-8?B?Y2ZzaVl6aGN1OUlLV3NSU2FwZWFOZFlzMWhxY0J6aUFZTElTb2xRd0ZMbEpj?=
 =?utf-8?B?Sk0zM0pBa2Q0ZzIwaUdjNlhrSTNZOS9kR1E0OFljRWRIZlRmT01jWmc2bEZ1?=
 =?utf-8?B?RktKSWlyNzk0VTdLbDEvSUZwK2hlMERtRXZ6WUkxTFBzaHdKSTUrSStwTTAz?=
 =?utf-8?B?YUN0eUlWb0dGdWdEV09wV0NFUzNhU01rTzJ5TGhDaDR0em5KSmVRVG5BOFpo?=
 =?utf-8?B?YlZtVk9hN3Ewd2FNZUhwSVVaYVcrbHVyVW54L3ExZnV3am02TE12R1oxTWFw?=
 =?utf-8?B?K3hvT0JFVGFLUTNib3UyZ1ovYjUzcGEzOFhNVC9nN20zYzNPUjZvUFpQejFm?=
 =?utf-8?B?dmdyTjA3bmg2clEvaFJFZStyTjF4RXR5SjhWanVMN0NPZFVPUXZkekUrazZD?=
 =?utf-8?B?SU5ndjBjYWk2MzZkMzhJT2dtVEhnRG5xbUFTQm1jUG4rSlJGZG9LdkJjekxs?=
 =?utf-8?B?TXNvUzhyZHhXWTdRQVkrdFAyZG1GTkw1UkZTejZRN00vNVhyZi84TTlZVW8v?=
 =?utf-8?B?bmlNbDZOWnRtWkhuK1VWNzB1dXhRS0JTSHFhRkNSM21ReGZhOUJGT2prYWVm?=
 =?utf-8?B?T1ZXQVZYdDRYWkZCTXk5MVVqRWpmWGN2bUtjTzFIS2F0cXlsZkRwaUt3NzJq?=
 =?utf-8?B?MW9ZYTFCbFd4Q0t0TDdwd2krNmVwSGpsbzY0bzRraGZpWWk5TWVIdmRHN0FP?=
 =?utf-8?B?WXAvZitEcUwyVDVTSzRVQWFXSjcwOEN3SVRTZ0ZySVY3enNTZnpwZWdxRkx3?=
 =?utf-8?B?K2l3cm1lSkVUeUpYNUI1ZFcvUDhySjBMTFFBYXBYVjgzSVk1bkIzY3FOSUhz?=
 =?utf-8?B?RTZPMzQ2OHBqV2xrTGhRZndoTVJ3c1Z5ckNBNDN6TGZ2dlZOWU1yWTRMVVRK?=
 =?utf-8?B?blBmK1pFYnIzT2NHdVRZU1BpMzN5SVRzTUhWaE96cXBSbE1VRm9RQlNVRksr?=
 =?utf-8?B?NFdzV09ZWmhsWUlSTnVzZlVtNW82N3puU0Z4NVNQc29ZTUpJbmdablNrYW5O?=
 =?utf-8?B?dk5WWEFhSmRkam56aGtqc1J5VFh1ZXhxRk0vSTdtSjFxRm5LOTJsTlExeWg5?=
 =?utf-8?B?eFlOdDFhUm9RRldLL2Z1MCs1WUZheHR2aS9Bdm03aitmUDdmNEhxenlmdzMz?=
 =?utf-8?B?cldCZEx4SXhGOEN2VHlkRURRVlZMSnRKaWJSZFJ5TDJxSmt5Z0srMXQvS0J2?=
 =?utf-8?B?V3NHQzZXMjY1a2lPdUQ1UWlXQWJic044ZHZ6cm5FWFBjQUUyeEZpN0JlbWox?=
 =?utf-8?B?WHhBVkQ5bTBZWlZwRmRucnlpbnRoOUwyOTRUVVkrbzZiNjdSajBNdTZTTWNu?=
 =?utf-8?B?S1BNcC9GalM3akt0M3RGNThPQlB6KzhwbG1MbEl2a1JNcjhCajRqSWhtTlJu?=
 =?utf-8?B?RXhCRktRbFRGUm43N05YSXpGVVBmL0ZmdlVSbUJmNTc0VnU5eXhOQUtEMk1N?=
 =?utf-8?B?VjdPdFA1bmpOYjIvdyszbHkxcEFlVjMyd0ZyN0J6NjZsVGRHYnlkdEVCS01J?=
 =?utf-8?B?b1IzYUZZSjBmMGlRVDBCTWg5R0locUppL0h0ZS9iWGR0eGFFR1N0VzQxbDdh?=
 =?utf-8?Q?TWIilSlcOCmpCulhjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVxTlNKV3hPcFluQTA1ZkorYTZ6QUFWQVZnYjZkMEcxa0tyc1FFZ0xBNlVr?=
 =?utf-8?B?b0t6UU4rZ1BySDRXWHU1anJtRGRFSUNWY0ZHR1Z3ajFSTm1JNTNTNCtsa3FP?=
 =?utf-8?B?aUVsR051aVg0UkJaSzVTY2FxdWp6dVgzWEY4cUJ2Tk1VSGJtNHJMYVRreWV6?=
 =?utf-8?B?ZFE1T1JXZTc4UUUwTENZMjFLb1NHdk1EU1pLS2Jpd3RubjUwMktEem9xR1Zy?=
 =?utf-8?B?Q2tOSTBoYXVmVG9QV1h0UnZSMU9ubDJYdzJqSVdkTjdDZTh0MllqcldjVzJG?=
 =?utf-8?B?bU84bUFQVlBJZFhaQTJyS2FJZG1UZTlVVk11ekFsV2YvcDkxa1hpVTI5N2ph?=
 =?utf-8?B?WHhPTDlQNlBMVXRUa25GczNkQ21PYzBDWS9UZE9NSmU4ditob0FoVEtQUzRI?=
 =?utf-8?B?TTVDencvNzNTRGFmNmxFWFc0KzFpNGVzV1pkcnhiNHY1aDFST1orczY2WnFT?=
 =?utf-8?B?aGVGUlRDOG81eUJmdEdlY0t0bnBrME96eDJJa2JIZEdCbFdrNnU3dG5hYkVV?=
 =?utf-8?B?bGc1VXFUSVdQQVM2dUI4cHNkb2xJbVl3RW8xeTBuYktJWjgvZzNmK0RUSTF5?=
 =?utf-8?B?cHdBaUEyYndqWXVTZ2VTcVU2YnB2VmhVbW9JL0IwdExMWVhGY2FWTFY2bnhx?=
 =?utf-8?B?YmRwMUc0eHVxQWNCZ2pxcXVBWjQyLzRLdzJ3Y0swSXo1b3RpbjVtRDV4R1dx?=
 =?utf-8?B?dTdpMWlLTkYrOW90Q2JTS0RHc0RQb1QvUkQ4V1AvbEsrQ2RjRk1zT0ZNbGZj?=
 =?utf-8?B?MThCZUJnZEdxenp3YloycWMvK2hBdjlWcFFvT2szL3JvZW94U1ZQdEpyckpG?=
 =?utf-8?B?bXlHU2F0SUVtQTcxM2VqRmpldVFOZ1FmYzN3b3ZFNk1BNmJwZTRuNnZzSFo4?=
 =?utf-8?B?UjV0blplRDJmY283SlUxYThVOFQ2RnVmVnVsSlhKODJaYzFDR2cydkhDbHZt?=
 =?utf-8?B?WGZHZ3BqdGRvRmxSd1hLMEpONzY4MVNmZ0c2NG5EU3p5S1lKcW1NOWVlT1gy?=
 =?utf-8?B?QzdMYkNkS1hXMzFib08vWVdCMWhrM2VoWWFLNUpoTGxMdWptdDdQa2xvUTRI?=
 =?utf-8?B?R0VhYWU4eHRMM1pXVEJmSGlRNHJpTktHOTBIa3B6STlJaG5VUGFkcy90TXZN?=
 =?utf-8?B?YUgxMDRKVG5melJab3g2OFlJYUNnUVVvVlQrZHF0YmFQd2RVd2lsUU9HY0Va?=
 =?utf-8?B?OXNVcnlQMFhwYkJ5SGVSNDRsd01lN2EyVnMzV3ZTUjhYZjJ4R1RqN3Q5NTdD?=
 =?utf-8?B?ZTAvMDhnTXJORExmYlo1Y3dQWUptUDdWOVNLZEdUaHlHZDhzaHNhOUxZbzNZ?=
 =?utf-8?B?ZGZXakQ1NjZVK0pxNnRLT2tXajMvc2o4Ym5DRDFwbFBMYTJkTFpuZXlWd3FB?=
 =?utf-8?B?ZENpOW82c09NZVhQWjA3SkhwTFNMT25qWGxPbW5YRTlNbGhtcTZNWnZJZ1h0?=
 =?utf-8?B?Z2tPRXVBa1pyTU85OVFma1luMWt4NkUvdW52cHFwdmUyWlBJZVhqVUFCVTBS?=
 =?utf-8?B?cTdSWUJ0eUdwQVNCMWoxc3NvUU9pKzNObzk3aHlzUFcwSm1wTGxaY0RyaTZM?=
 =?utf-8?B?cmdoY1dINjBiRjFzdXZabkJZZVBLL0dOV092RGtuRUVoK1g0eGduNVhwQkJY?=
 =?utf-8?B?TTExRnJrN2tpeDFCSzM0TisyRmZ6TUdJeVdXLzdUME5MQ2Q5ZmZLeFRmc1hJ?=
 =?utf-8?B?MFpDakloVlRUZUd0U2pMZzlFY29QUFdYcWVxNGFaanRqaXhUTzUyRjU5WGNl?=
 =?utf-8?B?RmVPMXp4c1ExVWlWMWhEbmlqd0tLdGZCQjc0ZEJOWm1qWmNsS0RCU1oxZFpm?=
 =?utf-8?B?UExiNHQ4N2ZzTG1vWWx1cnQzeURkTERUbi9qWERIY2lMeUpJRmFPQ3ZNRTVk?=
 =?utf-8?B?YW5UdFdFa2prK1M5cE9EQXZKQ3lLcnI4cndHZjQ3WWZMY0tnTWlVdjZqOXNN?=
 =?utf-8?B?ejQxR1labmtHZjc2a295UHBhd0JUcUdwOWdRZlBvYWFPS2JDRXNIQzNxOVFx?=
 =?utf-8?B?MnJwMEJlb0JZcXk2QjNCUnFKVU53Mk5LbDg5Zkp5Si80bE55N2lONFFIalhK?=
 =?utf-8?B?YzhGWG5Hd2NaOGhqWHY1Nmx5R2xhYm16OWtKNW5vblhMT1F0cUZDa1QweC9P?=
 =?utf-8?B?SUdkUmhvYmNuWS9tRjRZUitBb3pic1V6eFdlU3BIcWNiaktnK2pGa2l4TUp1?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665511f1-76b7-4cc8-a123-08dca6e02ea0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 04:14:56.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVRKyJ/Xqe+yWoGrD5bVIBCtWSPWHnOToIYnbiz8cdzKYW1peLYUeaLNQ2VZk9RGBKJrAZv2leSK2u2NnAFDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6874

On 17.07.24 21:38, Jan Kiszka wrote:
> On 17.07.24 21:31, Tobias Schaffner wrote:
>> Enable the x86-64-efi target in the long term tests. Set the maximum
>> latency threshold to 100us.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  ci/kernel_6_6.yml          | 13 -------------
>>  ci/kernel_6_6_physical.yml | 14 ++++++++++++++
>>  2 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
>> index e9efe20..59e9704 100644
>> --- a/ci/kernel_6_6.yml
>> +++ b/ci/kernel_6_6.yml
>> @@ -50,16 +50,3 @@ lava-test-6.6:qemu-arm64:
>>    extends: .lava-test:qemu-arm64
>>    variables:
>>      KERNEL_VERSION: "6.6"
>> -
>> -build-6.6:x86-64-efi:
>> -  extends: .build:x86-64-efi
>> -  variables:
>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
>> -    KERNEL_VERSION: "6.6"
>> -    CACHE_KERNEL: dovetail
>> -
>> -lava-test-6.6:x86-64-efi:
>> -  needs: [ "build-6.6:x86-64-efi" ]
>> -  extends: .lava-test:x86-64-efi
>> -  variables:
>> -    KERNEL_VERSION: "6.6"
>> diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
>> index e57eea0..2693907 100644
>> --- a/ci/kernel_6_6_physical.yml
>> +++ b/ci/kernel_6_6_physical.yml
>> @@ -36,3 +36,17 @@ lava-test-6.6:beagle-bone-black:
>>    variables:
>>      KERNEL_VERSION: "6.6"
>>      TEST_MAXIMUM_LATENCY: 150
>> +
>> +build-6.6:x86-64-efi:
>> +  extends: .build:x86-64-efi
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
>> +    KERNEL_VERSION: "6.6"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-6.6:x86-64-efi:
>> +  needs: [ "build-6.6:x86-64-efi" ]
>> +  extends: .lava-test:x86-64-efi
>> +  variables:
>> +    KERNEL_VERSION: "6.6"
>> +    TEST_MAXIMUM_LATENCY: 100
> 
> Thanks, directly applied.
> 
> There is now also a weekly schedule for this run:
> https://source.denx.de/Xenomai/xenomai-images/-/pipeline_schedules. Once
> the current pipeline runs passed, I will also manually trigger it for
> the first time.

It's running now:

https://source.denx.de/Xenomai/xenomai-images/-/pipelines/21669

Given that this is now rebuilding what has been built before, I'm
wondering even more if we should introduce a persistent sstate cache...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

