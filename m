Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0D2253EC
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181476; cv=fail; b=pVt3X6q1i5/IkrsmKnUmv/uUIDRLhl2eqYsyKAwuWcnw/csKy265M0MKm+jjWBQgxf5C5q0FM5mvZLmJI/X+UPBhgjfjKFXojkk7S3/Wrhhfz2rf3o/UjnEigCh1bZ0IY+iO2u5zxwGqJu9rhyvQcpbY5uC6+ovEMKuCJ9pj/uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181476; c=relaxed/simple;
	bh=u3xoebFXv2AcMPuBkIXimYEObTbubgZs9ic5AvRc06M=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=ox5Xw4vMCR8c51LmcbeP1Wlzpsn9JR3DvqgmMpP7WB4nFbxBBlXlHzDPPrVNSiYNRBTok/2noVExCfvhF+4qzsnGj1XSRCMNpAvb2L1KNTRmCem1J5Csc4PUORHFdP0roMkF99MjgEF75QDXEfTwYKOmBKyjySX1uanhBM3RbsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GYzU/QUW; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GYzU/QUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3+cmMoQPXQ0kDlJ7Uo0LJWtJhOzllG0Kmh9jhCi48UY5nsVmyvCl2+1pLlNXjRgCE3v6Y5RO0M5CIwFXV41v3HhS9a+WPxJgqmKdadPGu6Rpy0Rl7TAafCYxqhAkmqO0WOZNT+NVUXxnpDQy02PYIk0ixCS11XQoImZMvM6YXEUBwRwPbiFOxcdU2lw+PUxsq94lU3GNc8xhrDHSncpLl5kVwYhHYmrGrmzyZnaSNi1xn87Dw48WXkYcKTpgsJmkIAZ0u3iqeuEJ2LuQNpMMB9hccovfPUVaaJdj+WaMivCr7X67/mc4PqDpshU0N7gzb9lsibcsaYemP5i2YIlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3xoebFXv2AcMPuBkIXimYEObTbubgZs9ic5AvRc06M=;
 b=yXkZ6tuc779QKDZlYlA+rBIlrgjI+g8dDHVJhZSBcdrH0V2O3v4k86tiDpZgD4ZOZ882e3XvdaMcbiL42sbAEdPxAZB4gd4ArYuREa+mkJ0+yGCQKbSIEXMn+pq66oZ4sMTzYNiVxLP/CRZRf0SfWno6HSTq0oK8kAHW1TaPgnkDIhecICmAUL989OIa+PDq8vGfuvJTpF1eybCv8EuPHSmdmjd/tz1l/jMDVJrFo4mlkB89oq9G7yuFgLrQwrwUEbGS4Q8ldLVoqge8MRNfuYIxWCQwbe5wasmAXtCYz49gx/2Jy85G2OIbXFbrQSpTc/Vg+1MDCROgoy59bOjW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3xoebFXv2AcMPuBkIXimYEObTbubgZs9ic5AvRc06M=;
 b=GYzU/QUWzQ14czwF+Q7HAU2k4VzqYPJQjHJyZgJGSxscyY0mv9AegF1STYUKVf2gOfTCTAEkSuUeHedetwxRwzV0tyHvZ4d39oq5eT4HxnBoPrFxvxjXEj6xiNRbP4C+1MnP+/vjj24ZoJJe02qp77ggmOU5ajZQErT3ktMSFIUIuJ+SxgJWfDn9mt6EqSsIB13L4n5zKNyMv1E6RnFxFvjQkQfvf36UcT6ykb52wmj8UoNE/ea0QhRiy/nV5oK63P+za4uPGlRCt9xmXZ+UQsaTnMdOcPwqDOswI2mna9vWGgBUBUIjmv5KgGenyrxz7RFy7nhBJbjM0yK+krhBVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:44:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:44:29 +0000
Message-ID: <b1eaa352-5ef9-4a91-8bbc-55b5a9ac7efa@siemens.com>
Date: Tue, 14 Apr 2026 17:44:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, April 15, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: fed7c178-bbf4-4b5b-642b-08de9a3cb6d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DX6Ued5eSGME72qv3naiTfQY0g2CLLhJBlqIhclmcIP9JJbx3Zy5XxW5dWKQmMXD6FjYX5ml9ycaeskJqzLOhEELtBjQ+/+JSIASt5PQltB+uiwwBCleLRtfGjGtHjjTnh9uLvsXDtAKwpH2Ro7khJCa/p+c6CrGvbH6c01+fq7Fi9MUxF75OTriPgwqVIh6mMRWMMSN6bLwhY1/wtVfv1yUQz4jIvT+kD5/0OdY5scIJXP8Cs+VozIlYxp7Lph1QaUx90WKxhiChXQv+ZJ2K+kADuSjm018GcytDWHkD8P5in8IWvynSsQ+dfgQ+6LxovxnCDw44QMkItZz6dMCiCwsOrmn/zuYMFOVm1pSYE4/hIlvB8hm51HKhwPDsO3xv1UFGWI7xcq/s1R/MxaoKS039N9KXl7Dj0tgWgek9vpi6CifjjTDCnseqiUHsmAaP9J3TFHDGsdXzTy0oYqqbSF7uiYwfvrh5FV5hc7iUXdr6q7GRnJ4bopimFWjmRG+9YmzwqRBjUkzGitoPXLnvMfPV0DHvS2Sy0fpwBlx+6CaB4wtDVxa3DB9w3derJaAuFiBRma7QSGfN3R5yFcMJLp8TJnGQtGHYSesc/NbggvBN3nKPjnQL7HXbXGMeQOnElLnUpvQ+TVEr5ti7SL2RNKHfkQSpfDDBXYY8BPsVfFxb0A+i9QrGGm03kfM+epqZlmoQGc9DotTaTYR094F1FYq8/+SbuQlIWXtEmzbPXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckh5NmR1WnlaYXpjNHdRUmxNMERLRjN1MVRyeHczVVZBMWIrbG45MTcyZ3JM?=
 =?utf-8?B?WU9qaWErNlo0bDBQcHZYNkhteUgvb3J6T0luV1dCS0dCN1hkdndkdjB2bTZB?=
 =?utf-8?B?ZWUyZ2l5UVB3aWQ2b2grN1RLOXJPd0pGbWlTRzduYzRqYWcyVTNzeVNMRkJ2?=
 =?utf-8?B?clRHS0NiTUwxVytYZjk0WGI3SHUrY1RqRnFidkRtYnQxVldqZkJWcjlhTWxU?=
 =?utf-8?B?S1RFekIyNHBDVDdzVW4wZmduak5DY2JuWlpHck1lOUpoek9Ra0lvSE1FQVVO?=
 =?utf-8?B?QllCUDZJSWh5R0lBQ2lYRlFpZ3lubmdBa1o4cG5JdytwOFZ4bkxQSmtYc1VV?=
 =?utf-8?B?Kzg3bGViUlB2ODJzZGJSSUJHSXpiL1hvK09nQWlXU05RK3ZGcTdvYTQxNlBX?=
 =?utf-8?B?MG9ZTUNDeDVEWGRkeVdnWmtVUGpNeENuU3l6MGdHZ096SkwzUGJQRU5CZzZZ?=
 =?utf-8?B?dzEveGdyRE5tSzRydUlvclJOQ3ZNWXNaTW15WXl1TVVSODBUeGRMcEZRN2JJ?=
 =?utf-8?B?VHkyNVlwVHRvWkJvU0FVdWlBZFEyRURqU29ZRnR6OVFobCswYnRhdkw0dlpR?=
 =?utf-8?B?Q0QzUElseW00QTB5QjJYSEJOTmM5VzJ0ZGJTaHNSMXFXaHN2L0xYU1ppd1pJ?=
 =?utf-8?B?ZUV6dXFPdVRQT3I3SVh2V0VHTXlzRWxDMkFRZW82S21WOGhvTTRhb3FOa09u?=
 =?utf-8?B?K1M5RzRlZG0wLzBPTlhqOHU2M080OGF1d01EM3ZnSk5IZWRPQWIrb2dpZHVq?=
 =?utf-8?B?YXFVU3BYRFF1WXBxaE8xN3Zqb1pnSFpMYk1KeHRqaFhweHhLQ2pFZThTS09a?=
 =?utf-8?B?U0hiUW9MOHRJYWZQQ3RDSG9YVkdjMHRzUUdFYk4zU1RoWU9USndXVHdseU85?=
 =?utf-8?B?ZVo0VGFybUJBSDc0Y2VzT2cwMlJrL3BXdVl4dG05V0JES2VwMUYySjlZd0J6?=
 =?utf-8?B?NU1YVWxjSmxKdkV1Mm9GM1NPbnlWbGhLWnhqSG5rTHdTMTBjRyswcTZOenZl?=
 =?utf-8?B?Q1d1ZWFyRm5kNHlHQm5kOUdlYWFjZ2czVFBncHZSL1VXbEU5Y1hLM2dLbGRu?=
 =?utf-8?B?akhyODdmVUlRclB3TTRSODB4bC9IWlNIK2lUSmdPbW50eVlFOHM3ZlpVeita?=
 =?utf-8?B?bHpJSkU3WUNxeE9sVlBZUGQ2TmY3RGNjWlFOSTlYUitKUDdVWENQMG9SVXdO?=
 =?utf-8?B?eUFsbEJsYzVEV2Z3TzZ2VThzcS9qMmdIZWg3TysrR1Y4OTk3ZkdkdDk3Y2xB?=
 =?utf-8?B?UnZ6cGszVGtLREh3VGl6bktWL29CSTJQbVN2U2FvS0JhSEZBZm9LN0ZabzNY?=
 =?utf-8?B?MWkrY3ZZc3dxZDhnY3FaWkxuTXRPcnZrRWJma0FOajRCQjZYQi8waXpITHNC?=
 =?utf-8?B?NEtnZ1F5VEJ1TGZUN1ZldG9FbzhTOW1oVEV1blZjcGIvTEZzSkQwL1dJSWN1?=
 =?utf-8?B?TGovZ0NJNk9UL3ZsOE1pc0pSOFZtZVBWSDZ4cTF1SWliMnlyWEc4bVk2S0lm?=
 =?utf-8?B?cHlOdWI0RktKbHREcjRqR0xyM1EwWFVxcXA2Z0ZqTTJBOWcrV2tKZzA2bDlS?=
 =?utf-8?B?aWNZb2ZicTB6YTc0bllRMVJiZEhySEUxb3gzY2xxZFpVL1RDOG5QaFQ0N0Zw?=
 =?utf-8?B?MXlCeSswRDlCTTNjbEIvR3dKR1hoVFk3YW9jYWJKbnFrd29WMWdmYWZaVG1q?=
 =?utf-8?B?MkdnT1pkeDJDakROb3NydjFhWXZFa3NSbitJT3UwOUI5eVJQU3J3L050YVNP?=
 =?utf-8?B?cm85bElyd0E2SDQybFloSnBsbHNTNkFSbUVTNzJqTERydVVtMXQrbkY0UDZm?=
 =?utf-8?B?V1M5Nk9GelZWb0pGRVFLcW9yQjZTN2NIaGFQS2MxWUpweW9kN2xPdVI0TkFn?=
 =?utf-8?B?REdIVk03NUVrUmUzWlJqaS9mNkU0Ni9ZU0RMWmRHUlhFbHdicUJaVmVTR3Zr?=
 =?utf-8?B?Zi82TXV5ek83RE9tNjZOSFhMSDlNVmhqS3d5eUdJQjZmcDZyRVpDMG96d0xN?=
 =?utf-8?B?QXN0T0U5d3J6WHZ0dzdBMFBpdWt4cEg4MjVzNVRxR2dUMnYvS0ZzS2ZHSG9M?=
 =?utf-8?B?UzlUVnNqNjdpSy9BZjJhS1ZUOFJnQkc0dFdLK3VqdFVpVUxSdkcya3FDUGxC?=
 =?utf-8?B?L1RnblBVY0xjeW5YVlVNNHFyQWtNbmZscDZyeDREN1hTenB3R0kyVWxra09H?=
 =?utf-8?B?MUlURDVldWllYU9QSnZWSkhIV2ZDdDUyMi9aa3ozSUVvRjhTWlI5TktiaHcx?=
 =?utf-8?B?WUppY3VsWWdNRGtFOWNlY2pTNThTK3pqakFSWGk4Mmx0RkVLWXFVQ3llMEZn?=
 =?utf-8?B?czRYVW9XMHp2MVc2eEJtSVkxNjhORGV4Zkp0cnpXVmJpZDRoejNxdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed7c178-bbf4-4b5b-642b-08de9a3cb6d5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:44:29.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB3CwZeuY1aKLQLIPR1rSgOjXF8mg/me3uBAX15yairALU5IDmulJhPxTA8kzbY8Wpo17TvAnONTn3khdYTNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8821

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, April 15, 2026, UTC 7:30 AM
Paris, France CET 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
