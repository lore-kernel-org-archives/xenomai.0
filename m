Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF11118B
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 12:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye+YyEll6qpHnFJinyzc6aGwm9rgQazbDyAbuzTVu6V26vLGjzsHqqJbZoBgFLMtKuUKRmjO2YPk2oydOOhTOCtaq7ZC/oApg8eADs/6B4aN+wY6YHODYKCuF0Bb4j8VXJVjjcJh5fbzlwalKH5cu53YuFZcRFpiDlqrig7JkB5X8KbGnDoz/BatcHxzR7Tn5y1qypB5QS6Yqvs8bsc36k6INoSp9YjzsEtzXf29SFyUxfqFsaANMRoxH4QqjTXoxcwRNwH81m3dy9NR5crRjOGkZPqvisabFfkY5Tpq+zwoKcJpfr90CWVEvV602hQN/EoTEDYMx9PJfWeOeMweoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae3d4hRjSrqtpEYMwrNBEc8F3qdaszKm9++c8IFAOjc=;
 b=ZSRXGIWoJVZfd/ArHH4rtkcIRcBvlANMv1yCj1DO+UlL0B49Em/Vnb2YIIgEardYkMr3NI9vgVtCv6vAsIEI/hsewsbRCHj3UakCRve/Mc6S5hKvEB9KHFMQ1xt3gTo+NlPiWX3OBtMHRUSkw9e6kxj+hUyxTzW8KShYBiHCvaupgJaZzbLC0ctyc05yoETOc88qTeCO/qJD2SxdvrEd6YULFTIn6YscmxLt+Ucnvet4SNIowpPJcXFEEvMiwHV7hBkQa27nvVLLpD1iUUQywqNXURjkGtbNKVt+4xB2D4KrrPaPjDb/XijyJDcUuI/CcA5nuovGbmzcsqt0Sid2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae3d4hRjSrqtpEYMwrNBEc8F3qdaszKm9++c8IFAOjc=;
 b=LmxaC+rd83WPXE3gPO7kXNcnqlStsIIwqfeQXeJQ9Y5oLOCrVp9y7oSgfAioB/z9Neh/hiH0YDSVYX6L2YPspbaqc89BjoLpULSvxJxtOwkl7Waf01gkCyjEVPrG82A0wb3a4IrHMRu7kKIz48FxtkW9AAGC15a/vpD4uBTuzIBcChs8FlpXo9Ju+Hli5YrIiQAPCaedFweHnbEm5c75T5cMnJfx9A+WAtwE/CfOZK6V9GgIG2lVebZzuv38NuB7wSykYduOcFkGhbVBhckYFaHlSK7OinMxDIMTitYGJ0EpfeXGSx22U0p3yIDVYYRDdDbvEP/+RORYtAVgO4uC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 12:45:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:45:46 +0000
Message-ID: <07b6a1c3-b341-60a5-23aa-9338cc8be501@siemens.com>
Date: Tue, 8 Aug 2023 14:45:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Latest Dovetail patch release?
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev,
 richard@sigma-star.at
References: <20230808063230.q46u55o7xjzy2dob@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230808063230.q46u55o7xjzy2dob@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b0e26e-9ee5-41da-42f6-08db980d62db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FnAzDNqJdqmxzpMWzEq28BUsIUvfximN5H2O4KtxeVeT0rXQvv4fCrDBo5WzbN6Aum6enNBPpNlNijSxulDqQ5IrJfYgbbXEx92pbUt+lc+MyjoQTh01X+dS63J7xh8XUSWE1sxz5RM6DDH7MAzlCDu5h46Kpr1pTuShdg3wiwFhWWSxq3JVui19fYfk7dU2msx/fTqDupWEQV5xsyGz4ArznBGCAiYvdsacjbN50PYi2HHmrWJPtIzpAfNRLZOlP5m+GCX+43tyAkuZxpOlYxg2fDrP4zWGje5uN5AZYf7y1HAjNVRN+W4zDOunVN1dTKyFYD/pRLRH9/17FhOB/T92hbauD5FPJCVYjbH4KVxGoNCQaqOun3Fv0EejjDSMkzrlH2ADYEa6Mt9pmZ/GSoU9iUnB7idqkGxDll7VFuAjO+VSGuKg1rxXp68y5TmZ4Rm6ARN0Nw1eDPmI0yno0QHoPcpx1YhK6dtKt68xThkxfvbL+haxOANp4F+2vcA0wnkWLBh/ae7GWq9mIQQqXZzgArapGKZU9D3ZUBJCRkDBL+v3IXIA2QD2Igz2TsF/VpFgotSpIZigEJEMiNt0sRwLZLvUwVxv8/OWRwpWgJbKhn2SdqenHfmoUvcLD1Af
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(186006)(1800799003)(451199021)(6666004)(83380400001)(31686004)(3480700007)(2616005)(44832011)(316002)(5660300002)(4744005)(8676002)(8936002)(38100700002)(66556008)(66476007)(2906002)(66946007)(478600001)(6512007)(31696002)(82960400001)(6486002)(86362001)(41300700001)(966005)(36756003)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmpMMGdycTJMZUd6d21YQUdhWm1WbE52RE5qbzFDZGVJeDlMYWp5WjVuYTkv?=
 =?utf-8?B?enlyTHQ2RXdhNU9RL0dFVnRzSkovZW40QU9WNy9mQ1pmNER2TkRpcWN6NDlp?=
 =?utf-8?B?QzlYNzFFMldyOTJtMTQ5NFUyL0lheTdaZ21wUVY3T0NXZTNuY1pSWkNDd1Bz?=
 =?utf-8?B?eVRoeXBYU1p2ekJ3bU5nZURIRFR2ZURrbk9QT2w5d0xPZjNUWm44SXdKWVpW?=
 =?utf-8?B?b2VqcEVENnRXT3F6RlNCcFp5MHZNNmdwdXluRitVMThDTHAxaElBeHV1TXF3?=
 =?utf-8?B?OHJ5UngrVzFxV0tWUm1oNXMwSnplY1krV1M5NUttbUZJa1d1ZkZQTnJFbzRj?=
 =?utf-8?B?RDhYYzN3bmx4dHVDNGFIOVo2VW9ES1hGM2pzOE9QWXVaeHZaRTJYN1JjKzI0?=
 =?utf-8?B?L0JLZnE5NmV0eG12ckxPV2lFVHI0SG1aK2FMV0tjTENpQjAvMWo2TzRIcnl6?=
 =?utf-8?B?clUzVkZkZFE0U1c5OVpyOHozK0J4QmxUTjNWUXRvUWdFdHJRRzFSbUU5TERX?=
 =?utf-8?B?NUVRNVpkZmV3WC9YY1pxS3FoTEY0cGZwRjdlSjFSNmZYaURUVWFZYnNRL0lz?=
 =?utf-8?B?OGpFU0tUNm50RXBsRXpnZFdvYUREN2p6LzVKTjQvZkRPN0NOWGFwemtPcCtB?=
 =?utf-8?B?Skk4SHU0cnlZdFhHR210UDJySDVuZkdMNk9ZV012K1h4S3hPdi9nMm9ibUhk?=
 =?utf-8?B?RHhXSWNnMnpkcTk1NExYd21pMEtOaHEvZTV1UFdvVHlnTDBXU2cxZ3EyQm9L?=
 =?utf-8?B?RDAzOWt5WXBGbjIrQkltTWFzQzlDU2g5YzQwbmZhcGo3dHpadHMrR0FGTVlW?=
 =?utf-8?B?YTlmWE4rSGhUd0hWSHo3cUhBN0FZdmtWdlN6K29ta3k1UE1DZER3MmIvT2dq?=
 =?utf-8?B?K1hONEdnNHkwcFJDZzhoOFJqNStDcENGcmtoaGVxMVJuQ3A2bFJvQ3BqWHB1?=
 =?utf-8?B?S2R1cUdSelZYbzZxbXJtTFV6K1hGd0NhdTJ3eWozZjFSZmlCaXczZ05yS242?=
 =?utf-8?B?K3hpL2RzeitBbjdGQnRQZDkwdmMwS2FmdGlwT2FHRkVuMHFPOTQyTWRuejhv?=
 =?utf-8?B?ano3UjFRWklZZktpU09yMGxGalFQeU41aUJ2TGZGbmVmTTA4Y2twcXd0RXo1?=
 =?utf-8?B?cU03NjZMNy9lTG9qYXRxd2NZM21GZzNxdkVzZW9lc0tZaVlzaXBwUU9nblZZ?=
 =?utf-8?B?VWduQ3puQTB2K3RUWTN2OUZkM0YxeUNseTlKNjhQOU15blJaVFgvU2J2S2xK?=
 =?utf-8?B?eUwvb1Jab3luaFJFWitjV0VMVmZOSU9pVmRKdDNscTM3SXlPRnFsaUFOVG8y?=
 =?utf-8?B?MnhoM3BuSCsvSTJYN0VtTFJ2KytmYkJaTFFoYnl6UVUyaTN3dllSUHJ3Zy9m?=
 =?utf-8?B?OVhXVnE5aHdFMUdKVmQ2SHdTZno3N1pzbDM4U0NtQUdmdFVqbVloRE0rUDdh?=
 =?utf-8?B?WXFYbjJTalZIYk5zdEZSWVQ5U2plSlBpYVZMbm44R2JBZ3BUU2llTmFLOXJo?=
 =?utf-8?B?RzdsNTlCWVo4MW5Jcm1QVW5sY1FzbzE5QUNaeWQxRWMyUkZqeUQzZlJrS2RS?=
 =?utf-8?B?UERPZk0wWWVESU1sb0s1MG9PTFdJMjB3SVRPVjZadTF6V2VBUG5FL3NPbi9V?=
 =?utf-8?B?YVF1cXJia0VRUWxXUXZiOTFST1p2cG9LUzRLeGRJTEZZVHhjTURRVmdQaVc1?=
 =?utf-8?B?ZFk2Y3lhcEF4VW1SWGFnZWltcmRRVTdTdGVXbkhtTFgvTGZ6OW9VRDk3Nndz?=
 =?utf-8?B?MnY1ZWtVd3BxcHlTVGk3alE4N3VqcjFMT2pGeXVvVkIvaTduTFFvTFhnQ3h2?=
 =?utf-8?B?SzIreFhZRHMyQ3FsSHlDVi9oVXpDd1draWlzMmxPZDFmOER2Rkl3Rlc0Qys2?=
 =?utf-8?B?eC9LVzlYTDB0NlUyWDNIT3J5RTJ4YXpLUWJqTDFvL1ZtS1c2cjl3akFvSEhE?=
 =?utf-8?B?UVRZb1VlUkxvLzN6VGF2RUFXWFdsMkJPVjI3OUhlZVNydnRFbE5udGhNUGRV?=
 =?utf-8?B?ZmVBSC90eUdxV1pkb2FlVnhjOGFMS2E1OU5qR1BOYzdpMlN1NDVONlMwelVn?=
 =?utf-8?B?NG9NWXVWSHZSQ0VDRVdseG5tU1ZkNTAvQjhuLzdTV0pmL0RMOWVIeEFaZzRv?=
 =?utf-8?B?NVlyWUw3ck1VRVJ5N2tVVHY0ejNLZTNTa084U054Tm5VdUlYNldUK2MwMURz?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b0e26e-9ee5-41da-42f6-08db980d62db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:45:46.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezEMGkDLa+Bm8a6+HzbREDmiN0zPev0WzR66jDw95KncdqLZoGGsB1U3l6qwO3ueGIzK3jn/TezfWkTrVmGOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6236

On 08.08.23 08:32, Aaron Marcher wrote:
> Hi,
> 
> currently it is a little bit confusing to identify the latest Dovetail
> patch release:
> 
> 	https://xenomai.org/downloads/dovetail/
> 
> lists the latest kernel 5.15 relase as 5.15.51
> (patch-5.15.51-dovetail1.patch.bz2). While on
> 
> 	https://source.denx.de/Xenomai/linux-dovetail/-/tags
> 
> the latest tag for kernel 5.15 is 5.15.119.
> Where can one find the latest, stable & tested Dovetail patch?
> 

With Xenomai 3, we are testing v{5.10,5.15,6.1}.y-dovetail-rebase as
well as latest v6.x-dovetail-rebase, always the head revisions.

Regarding patches, I would refrain from looking at
https://xenomai.org/downloads/dovetail/ as it stalled last year. Use the
linux-dovetail repo.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

