Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D8382
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254736; cv=fail; b=qTle0iVjLf6KuWu0+1YY7kk6ylNngTwIiQLdEgjz7968t27U8c5JoQm33bLcLmlAQXLQKihwG2bmhCC/69vn3Q3v7SQTcrW7TAdWtangTaD28mZ3sDSwFy4rTZ15Do0jQ40cto7Z8ALN0ptfa2oBAjD973wTO3L6hslVlUmnQJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254736; c=relaxed/simple;
	bh=KQqR0vsNZCY9MlbwIck7zGS8nLRc/cRYTK4UXpkL1Ok=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gjo8RTPFUx5+YtZS04o9Wn2NKXVWy6YLNmHN9VLSgsoQbAntEyOM8gsIk+l+YE1Fm/+UW988JN465xAokgca4CmEJ3MdjW4MWra/ntDmBisPqHz0K4scBUZ004FhfHz7xkV3zHoZtnJL1BtgpZT2YKzU+M84Hz8mTnSnhaLKQ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Kuc/1wux; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Kuc/1wux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD/FTudzgaXQieqdBm2bRGHs2WHn0Lka9TpxukTBO4bgPxpQ6pXlWwAYIuPr2ev5aGW6VVMvNbWolg8SMEP/5rzntFK7jbRPeHMYwEqpnN45EL7+CMG5O5m/p6cIuC1lSYp6KxBETLQi10CKqFjgEbujmM6zoBpZN/7m5q9VPtG2sCGmJyoTdczlLQX3EdnOdWZp+8QmN6EcGBBW5J4ErE0pl28qBZmBcePgdgaVoWpYJWMAHJTpnze8ChsMLIoHrzbjlJ3jR+CehsQZl4TqOgGL/1Y/RRJs3LfKbC7rZQSMlCtD2rv6tgB2ikJicJ3t5nOs+pzkR9dRabdJ0TrDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ft6LmeBXIV7DcX7Ot2TNjZsSIBUU0SIXW4NTMxGpTM=;
 b=rOrzDzuJS3dPSvDpK/wKebdYLtbyNsgL0W2afByvIod9rtnFmgvFX7iiTGeAwStF4/yGjak0pCFg+oPKsIEvzVp8IJbrFkGD9dzuDAmV+nHn6zBgYfBk5W4Yy06pE12HqiMW70rN+loXpAX6TQ5RzPufvs4Zreb5x9t1rt0PINj1A0S1mRcIGLuWIW/eTJ9FWZS7powOJxoal9ibiom8IIWDbRvyjD2aki0q/SzYyfGPssQJcYJ5QYI6WTYMIVceW0n6lQGLW679sdGZBsiY/vz8QkskMesqkIFKV0XEM51BxJolDxvmZ3q5XctAtO1ha5yMg8jnMuHMiPGxQDOWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ft6LmeBXIV7DcX7Ot2TNjZsSIBUU0SIXW4NTMxGpTM=;
 b=Kuc/1wuxkxZtCEif8NlS9ZEg5XKZnTAcB8EJ1K4o6sbW/NUU6lLWhPJhflQiQ64kg/VmY8oTG2l8lXnHpsTRGImFNVxX8fD12OSVA+LD2zxMQ2oB2kYfdIDAShSUq8IJLnqIDnpAjU5QdA2/JPeWWrAoRx7vwVseyPJ6DFX/TmrxCbfYTKdHhXGcltf3UYdR9E7GINMYNUN7NbjurxpHKac1P8m78vf/G0UpeFIlzHISlAvCb+cQ23aul33o6QNt125tJjh+eQpK7BEMj+mEZUNkv39wrirrK/Ej1rrbBOiSjymCaX7GudBKDCLnRNJZZ4a7xTgypmG7swJZsVMGmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 05:25:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 05:25:29 +0000
Message-ID: <496eca47-63a2-4b6e-a1ba-5f2289c99481@siemens.com>
Date: Mon, 2 Sep 2024 07:25:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
 <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
 <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
 <7e199e8b-3d17-4885-81a4-6297863fa2b0@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7e199e8b-3d17-4885-81a4-6297863fa2b0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8680e030-cf2c-4bac-fb14-08dccb0fa873
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnV3R2oraExEVGNKVmNIOC9ZeDlxamd1RW5wdnBkM2llbE9nT0ZndjFsSHNS?=
 =?utf-8?B?SCtaS0FNM2VwazFwL09QMW13OEtxTG45T2c5dUIrN2U5bjVLaDhQcHlhT0s0?=
 =?utf-8?B?ZU56ckZRelFDQkRpVWNrRmNobGZSS09tQytBN0xzWFFIS0tvVHJKeWVFWWZy?=
 =?utf-8?B?L2ViSTJDSzYzZ3ZHU3pQV256L2ZJNFg0eXA5eFhXNU90K080MWw1WnRlVTlB?=
 =?utf-8?B?NzNkRDJFWG5xTUhhYWZ1QVRCU2xnMkw0UnBaMlJUblVyYTN3MXBoTnk0MlFT?=
 =?utf-8?B?WlB0NDlvanViSWU4TFpwSm0vbms5VVN5UStJR0ttNnJtQm9tRGhpNTVRNmNJ?=
 =?utf-8?B?SnJYUVpGcjIrUFZ5T2lHdTVhQmh1Sk8xNk5CaDc1WktUOFd6M2FCYjhBUTZP?=
 =?utf-8?B?bnAvNWNtLzBTa0ZGa1BiVXhKaXIyTUxCeUk2NTErNCtaZHI3TndwaGJ0NFNZ?=
 =?utf-8?B?KzQ0SWhJSy9MMlJlbU14b2FqQ3NPM1Rad0JxclVjNzhFRk9GS1d6b1htcHZY?=
 =?utf-8?B?a0ExT1kzZldSZ2V2dVBGZmVlRHpHNE81eEloNy9hSDFlbHlFVzVMQjVneGV0?=
 =?utf-8?B?bkRqek1VN2tiekNhd1NwMk1kV0JlcHl2cmdwSVY2MkRWM0hOMFpHSkhsWlZk?=
 =?utf-8?B?Y25KUi92VXNKZFBkQjhEZ1Y3TGhGdzlHU1RnRlRrc3hNSExucnZZVXgwQ3hu?=
 =?utf-8?B?ZEJySlJubjZaY1p5QzBUcVRkTVFjczBXK0NIU2lLQ212YXZtd09ySmEvRytn?=
 =?utf-8?B?Z2xTOGVSR0M4ZmxtQVpxaU9tMXViMkdzckVYeXJDcTJjSVpOeEQ5QTFjcHNT?=
 =?utf-8?B?ZkZPR1Rzbmd0WWNIRFVHTnZpdGpzY0hIRHdVaDlFencyUWFTTFY0NXpQck5U?=
 =?utf-8?B?Y1lhb2RqaE54aXh3UVptOGxmMGhhV1NSRFAxdUIvRTlvYXVIZ01kaGVIS1VN?=
 =?utf-8?B?K2VoMFpoRTh5Q3NseHdxQjM3YWFVa2llY1R6NkhYcnkzZ2NLNzVMc2lMYllD?=
 =?utf-8?B?SHRWN2kreVA2NHlOMGh6TWE1djVXNlpObjkvdmx6NE9oMzZjWm9QTW9NdHBy?=
 =?utf-8?B?Mm1IZ2dJdUNZcWJCL1hUdTNyTHhxYWpDc1hNL3FVTHFrczVzZUNyOEJ5SHdy?=
 =?utf-8?B?VGJ3T1JrQXF3eGRuOUIwcjg3cmJxbVEybCs0ZG5LRlR2RnlaTHZ3cm85U3dq?=
 =?utf-8?B?Q0NtelNBd1c4WC9rNDFtQVVaNHQxV2VKL3JSZ2hPMUhNZlgwb0c2Wjd2a2Nt?=
 =?utf-8?B?TGRRQTIwQlptMnhUQk5mcnIwSGZWbU16WTRXcHFqVERzaEZXKzZuNG1YMDFE?=
 =?utf-8?B?VnZuWXhiOVdqUFZoZng4RCtVZTlkemdMYTR0SHdMT21LeUQ2WXg0QkphR0JB?=
 =?utf-8?B?NUVuVlo3anl4N0RXcVhzblE3TzIyQUZSaitkM1lZQmNqa05UcjJnZnlRbVAy?=
 =?utf-8?B?QmttVkdzcm5XcnBKNklWdXFIK1Vaa293ZzZwOFh1RXRxTS96NTVkSkIycmVF?=
 =?utf-8?B?c01vVDVHeWdsQzZDOUxZaS9INFRneFQ2d1I2eld1UERGZ21POEFMSVRXN1dz?=
 =?utf-8?B?Mzhva1l1RitFZzd4L3RxYWFrQytkTGt3RGtwTzZBVWtZckNhemkrOWVDdXlk?=
 =?utf-8?B?bUZ2WXRQRDRyMnUyZlVqL3YzR1F1RGRhMW9DTC9yUWRVc0RZRXUrTWcyTkQ0?=
 =?utf-8?B?V1lQcm9iTTFLeTAyN2NvSUpLMzgzNTlHSTh1eE5tWU1aNVExVHQyYU5hVm9a?=
 =?utf-8?Q?NxbnWipwsIR+T0njKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWhORmVJQWZIbThoNXM0MWZrK3pBTlJyUENmaEZWYWdoYnlzdjFqV0JqL2cw?=
 =?utf-8?B?R3ZBNDllTnhFMGxQVUVNRkpLWVdKdVVjTVBQMkZJblVSeVpNRXpKajVNWkZQ?=
 =?utf-8?B?UTJlU3dTMmlyUnFnY2xkRWNqZ2NPc3dMeTU0aTlSVzRFVDhhTzFHYmxFZzlT?=
 =?utf-8?B?V2hDTGozKzFXci9YSFkwTFdNNE0ySUZHbWtNY01SUHZvKzErMlZ2NWZLZ09r?=
 =?utf-8?B?WkFpeHpLSFZqcnBKbnZYcS8xeWFMZnliUXYwVVU3SjJ1VzBUYXVZdTc5dmdr?=
 =?utf-8?B?WG5vTFY3dys5YmtIOVZoQnpta09VcnhLSmdqU3JpMWVPdTRWMFVRNXB6dGFB?=
 =?utf-8?B?RS9kS29PS0F6SjM1UUZTS3l0N3ZDMFBYbDBnSFZ5SHJuMTVPK2lpcjJ6MVNB?=
 =?utf-8?B?TU5tOEhscmljRmlFZkkvMm10UVRocTI3VEVFdVFSU3dLV0h1Vkp0UkhEYXVu?=
 =?utf-8?B?eTdZOFFhSnZJVUpEWStZeUoyVXRDajVDSjZhclRERlFnM1lCVjNUZFJvVUpL?=
 =?utf-8?B?QXd0a08xRThlNk1wMjFCRFBWWnpCc2d0WTRXVUNvM2VSekYxdklMWkMrSWp4?=
 =?utf-8?B?blZxMHZOQ2Z5emdUMmRLZUxNbFJ4M1MvZmVXVDh2UDFyLzdnM012a2JaYW1u?=
 =?utf-8?B?SUgySWFnUklYWHQrODlrMWIvaEc2TVVxbUVJYm1UY1hLQ0k4NEFYcStvMXdw?=
 =?utf-8?B?aktVK3RkeHo5SDh6aEhzMm1rT0F3ZUhaMi9zc2tldGEvZjFLNUk5Q3JySlAr?=
 =?utf-8?B?U0grQVdUNHlJVURBOHBHaGdkZnZqbVZwSk9wMzNyUzZUTytuMU1ucDlRWmVG?=
 =?utf-8?B?L3B4SmhQQlZQNGQ3R0JTZjNtUm5GV3VlVGZFOWgwQVJud2J6cVhKNTA0cTB0?=
 =?utf-8?B?eDRCRHJEbGdCWkxaa0lrcEkrdUhnd3dEZ25TNlRhT0phYzJaak4wemVKSHNm?=
 =?utf-8?B?ZlRzczZKR2p6NnBiT09BZlJkTzhBVnFLaE5oVnNTdnR2NUlsdzNPcTd6MmJH?=
 =?utf-8?B?b1NNQk5sSnFmTTA2aEM2U1pzNWJlcm9aQ0xzZWUvZmtuTXh0RmxDaVFVSlZR?=
 =?utf-8?B?NGM0UXljeGw5bER6UkRWQ1JzMG5hNXNXVUUvOExneDFMcEVpM0lwU2lNSzN6?=
 =?utf-8?B?VHJCOXZab1lMd09mUHFhalNNMml4aUJ0cGo3Y1B4V2ozTDBVUlJJR1NIcXF4?=
 =?utf-8?B?V0UvTG5BMUo5YjRnNEVwN3pTb2tCcUh6SFNpeHBnaCtQU3VpSFRZekVQOVBj?=
 =?utf-8?B?amV4ZDdRQXQ3U0t4REpXSExIalpFdGtVQVZxNGNIRWVwOXN4T0pQT3dGbDNm?=
 =?utf-8?B?cGs5UFhCYnVHZlNoeVU0aDk5bFVXV3YrWkp2Z1d6Z2JPK1p0MEZYbjFqOU1n?=
 =?utf-8?B?Z3NJRGJ0eXY0dzAvcGU2QVVZbFBOMVVEMmxGQ0N5blVvYmE0V3VMeVkrNklk?=
 =?utf-8?B?c1N0SHRTZ29QenJPTTZXTlQ5YUNHSk9IZlI4TUwvRWJmRlVxNEROUHppdE5E?=
 =?utf-8?B?NmlrbGQ5bk1ONUJIRWJZd2FHMldwdVRPak5BMG5SK2l2OCtjMFdTSkhMRHND?=
 =?utf-8?B?SHp1V2JBdXg2ZUd0QnlONHRzK3V3eGU2UEdRWFNYdUh2eE9wcFJVeDNjaGJZ?=
 =?utf-8?B?aUx4QUUrTm0vdmdOZC93QWIxcVBJWk0vbWp2cng0K0p6SzlZRkg1Mm0yVStE?=
 =?utf-8?B?OWYzQWxEVlVaVTByTStBUjBlTmpaMHhkc2J2eWp3aHhqNVdINU8xOXBLWU1y?=
 =?utf-8?B?VXhQNmM1MXhTYWNqd2JobHV1dDloMFpuZ241OXFoRDlaeVdNdWp0UkxmTDJr?=
 =?utf-8?B?dmNrZHcwMzRVLzRXS2hRMzNxSzdacjd1RXFlSjhiNlBLVzY1S2VEbmJISXRG?=
 =?utf-8?B?dmJSV0N0K2x3bWkwdGpIMEwzNmZVLytQS0dGSzQ5SktDNkRCTi9ZMWs3SGxx?=
 =?utf-8?B?dGVlUTVIdURTMUNSbHVaMHJSdlJtMUpXTmZudTBMQTYvbDRNanNjQUZKRW85?=
 =?utf-8?B?Uk5XVHhwaFdtNWY3RVVwU05HbEJDdnFhMmJHWjhtYTZvODg4KzJlaEQ5Y0lL?=
 =?utf-8?B?aWVzbVU4dmJiUjJISnI2VlZsaUJjNVBLWGZWR1lQNWhXc2lWaCt6WFFXNC9q?=
 =?utf-8?Q?W1L690bkdIaP6iXl2Is5Pbple?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8680e030-cf2c-4bac-fb14-08dccb0fa873
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:25:29.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5c5pGoPij9e6AxCER8KlRBsOiCYtNvZ58tBVNp5SWIvwL4dGPqtyBvp9SR10l1/awEeuS0O+QpuLxJktWTb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9113

On 01.09.24 11:49, Tobias Schaffner wrote:
> 
> 
> On 30.08.24 15:44, Jan Kiszka wrote:
>> On 07.08.24 23:52, Jan Kiszka wrote:
>>> On 23.07.24 16:08, Tobias Schaffner wrote:
>>>> Enable isar sstate caching to an aws s3 bucket by using the
>>>> SSTATE_MIRRORS environment variable.
>>>>
>>>> The isar-sstate script is used to upload, analyze and clean the remote
>>>> sstate cache on every build.
>>>>
>>>> Cached artifacts will be cleaned every 14 days. This can be overwritten
>>>> by setting SSTATE_MAX_AGE.
>>>>
>>>> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
>>>> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
>>>> download caching.
>>>>
>>>> Currently the size of the cache is ~20G in size but I expect this to
>>>> rise to a multiple as soon as this is used in productive environment.
>>>> Keep an eye on the output of isar-sstate info.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>   ci/gitlab-ci-base.yml | 47
>>>> ++++++++++++++++++++++++++++++++++++-------
>>>>   opt-ci.yml            |  4 ++++
>>>>   2 files changed, 44 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>>> index 1dc05a8..f5009e3 100644
>>>> --- a/ci/gitlab-ci-base.yml
>>>> +++ b/ci/gitlab-ci-base.yml
>>>> @@ -24,12 +24,39 @@ variables:
>>>>     TEST_RUNTIME_SECONDS: 300
>>>>     TEST_MAXIMUM_LATENCY: 0
>>>>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp
>>>> ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>>>> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>>> +  SSTATE_MIRRORS: "file://.*
>>>> ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>>>> +  SSTATE_MAX_AGE: 14d
>>>>     default:
>>>>     image: ghcr.io/siemens/kas/kas-isar:4.4
>>>>   +.sstate-prepare:
>>>> +  script:
>>>> +    - kas checkout kas.yml
>>>> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}"
>>>> --max-age "${SSTATE_MAX_AGE}"
>>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>>> +
>>>> +.sstate-analyze:
>>>> +  script:
>>>> +    - echo "=== Analyze sstate differences with remote
>>>> ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache"
>>>> "${SSTATE_LOCATION}"
>>>> +    - echo "=== Check for cacheability issues in build/sstate-cache
>>>> ==="
>>>> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>>>> +          --sources-dir "${CI_PROJECT_DIR}"
>>>> +          --build-dir   "${CI_PROJECT_DIR}/build"
>>>> +          --pedantic
>>>> +          --exit-code 0
>>>> +
>>>> +.sstate-upload:
>>>> +  script:
>>>> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache"
>>>> "${SSTATE_LOCATION}"
>>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>>> +
>>>>   .common-config:
>>>> -  before_script:
>>>> +  script:
>>>>       - if [ -n "$ALT_DNS_SERVER" ]; then
>>>>             sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' >
>>>> /etc/resolv.conf";
>>>>         fi
>>>> @@ -40,17 +67,22 @@ default:
>>>>         fi
>>>>     .build:
>>>> -  extends: .common-config
>>>>     stage: build
>>>> +  before_script:
>>>> +    - !reference [.common-config, script]
>>>> +    - !reference [.sstate-prepare, script]
>>>>     script:
>>>>       - echo "Building
>>>> kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>>>>       - kas build
>>>> kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>>>> -    - du -sh build/downloads/deb build/downloads/git build/downloads
>>>> +    - du -ah -d1 build/downloads
>>>>       - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh
>>>> ${TARGET}; fi
>>>> +  after_script:
>>>> +    - !reference [.sstate-analyze, script]
>>>> +    - !reference [.sstate-upload, script]
>>>>     cache:
>>>> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>>> -    paths:
>>>> -      - build/downloads
>>>> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>>> +      paths:
>>>> +        - build/downloads
>>>
>>> Strictly spoken, this chance is not needed because we only have a single
>>> cache entry. Anyway.
>>>
>>>>     .build-qemu:
>>>>     extends: .build
>>>> @@ -59,8 +91,9 @@ default:
>>>>       - if: '$ALL_QEMU_JOBS == "true"'
>>>>     .test:
>>>> -  extends: .common-config
>>>>     stage: test
>>>> +  before_script:
>>>> +    - !reference [.common-config, script]
>>>>     script:
>>>>       - scripts/install-lavacli.sh
>>>>       - scripts/run-lava-tests.sh ${TARGET}
>>>> diff --git a/opt-ci.yml b/opt-ci.yml
>>>> index 01d5c07..e1466a0 100644
>>>> --- a/opt-ci.yml
>>>> +++ b/opt-ci.yml
>>>> @@ -23,3 +23,7 @@ local_conf_header:
>>>>       IMAGE_INSTALL:remove = "sshd-regen-keys"
>>>>       IMAGE_INSTALL:remove = "expand-on-first-boot"
>>>>       IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE',
>>>> True).startswith('qemu') else 'tar.gz' }"
>>>> +
>>>> +env:
>>>> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>>>> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
>>>
>>> Thanks, applied. Let's see how it will behave.
>>>
>>> Jan
>>>
>>
>> Only saw now:
>>
>> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0
>> do_dpkg_build: Export of 'AWS_ACCESS_KEY_ID=[MASKED]' detected, please
>> migrate to templates
>> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0
>> do_dpkg_build: Export of 'AWS_SECRET_ACCESS_KEY=[MASKED]' detected,
>> please migrate to templates
>>
>> (e.g. https://source.denx.de/Xenomai/xenomai-images/-/jobs/894592)
>>
>> Is that an isar issue (but we are not that old), or are we rather doing
>> something wrong here with the export?
> 
> We could evaluate the environment aws variables in Kas and use them to
> create an aws credential file to fix this. Maybe also because bitbake
> prints environment variables when running verbose.
> 
> I already proposed a patch for this some time ago on the kas mailing
> list. But it would need some rework and I am not sure if this is
> relevant enough to forward more sensible environment information by
> default. Whats your opinion on this?
> 

Sound like we rather need an isar patch then to ignore all those vars
from FETCH_EXPORT_VARS (bitbake/lib/bb/fetch2/__init__.py).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

