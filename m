Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7A29C325
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969301; cv=fail; b=qo1HPRLt7Z0LelDyi6YspBzr1Qv5BozCK/oRr6VQ+QdI7JOppF8M7oY7Wc7HNlZHc2TA1CVHliC+7WNq3lGyAhEGxV2OJ67l88+QK0wDDG2lqefIDfEk2iMSou4szA4Vci3mtWNa3Qmx7H8qYFgmTq0ZnzuhXKRyJfp+13jTXT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969301; c=relaxed/simple;
	bh=ZCi/pO9JeR6a5cWlEbqtZZNWaFhAi3PgFq7yruXzzns=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pe1Osj5dPlr4Sx/PljmJW7aRVoitE+xNb2jmUo+5ut9tT9XjrFxwa4yA7hIJ1iFDJgXqKFcmHtYiIR3QTjysf3Roe0fc5pahceMRQrVM2nAbJKTCGxVmEGUTB6npaeaMGvezKBOhaA8surN41INNiwR13r1uJ6kpP3mll5qvZQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hTgHOpXs; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hTgHOpXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPWHnca7RmXGy/NzS69r2cq39NJFZ2urBrq/EJh9BpmZ7S6Rm2ctM2ap+71bcAdR3vKL2NXXRkgpIsPuGOoIEeikZnHlQ7T9BW1imxIDVp2hoKElcASNJ7H5bbdCJMj6Az5aINt/poXSMZsbBBMx7z9zQCcm5svEV4wR5zRS4IFFQ4hzthGF1XQw3086D7zCsCshsCcPzua1PeXtAB8AeiSZN1QHQAI5tFKm9ebMa9Jjt4TSooJaPWwOK/4DbZ/cd/GTrCYRVBOtT9lCu/DgdbCh1JlQGJmzj+1M9P9A+Q2WYBgF84eBBTq5MiT+9D0rRV531vudRwZebWkZ3sBubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/0HRHwcID6cX8DUJ7IQSiE4WvMQ8760bYrvcUNmGpE=;
 b=slLeJv8S4LtoBTFPBffwb8/qdAgGkRRA93qwzsL+RAqd/eKUXQLAR07Lv1Uvlhzn6nJ6s7WXINftR17g4vrfkt2TkMOuc4c3uJepj2pUPlWefCaLgLyljdWNIDhZV9mf25Y/gOdlMBpfbE7WRfLrld4SYLbJOWbQaJft3vig5Dc+Ed8PlBW0GUbk5ZZngqtI4jnEa4Vo7QnNBx1AtNC11ZYrUfNlejeB5gyGCf5uc1mpI2C/K9SmXd5qenF/AKrITteyCbYYCKoldcs8ENd4fCwO1tLCs6aYpMThvbvrTOUkS/sscB4NBiyFpteEXK2BYMe8kyNHUshJQPo0yCE1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/0HRHwcID6cX8DUJ7IQSiE4WvMQ8760bYrvcUNmGpE=;
 b=hTgHOpXsKb39ah9ToMN8e9L0N1YjeYtyi9LnDl02jvcf54eIHzIa71IakUSjdaCy5+y9se98vJpvhKF7fCscjO29SuoDBbvLXkZLVZNpS8vgaxFjd7kuTsqcvySPRYlaZXsE2L91VmKs021iME1hE68n6FvHs8Q2ibihMjm7ycyrC31SF/NW+iOJrs924Rcn12GEmd6o7yI1/UWhtiPBnFAmCMQaXU64psgVBkocnqYnDcsisR8mPHEL8xWrbd6LWuHVIZc9ZfHRKY8Bz6Ghkj5a9vuBQ5tCWQTGrdjwFMi6rVS8xV66IinnBYm2eVB3zmA4JIGRAbL5Vez7HZwN2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:34:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:34:44 +0000
Message-ID: <4a1d3972-bb52-4fff-b4cf-40bb4419b6db@siemens.com>
Date: Fri, 9 Jan 2026 15:34:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/2] ci: Add build job for pipeline
 triggered by linux-dovetail
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 094a14e6-0a3d-4291-8d93-08de4f8c3b80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bENvenFwMGtQVWRiUTlkbHNtQnVsenIza0d3UXRBUFA5UmhnbHI0MGJCS0sx?=
 =?utf-8?B?YUZGSXY1SC9YMzlPQVlqdmdYbVhwbzNjU0J1VUJ4Mi92Wk9XcnVRZC9XalZp?=
 =?utf-8?B?VEVHTXp3ZXk5OUpFb2oxZ1Q3Z3VXZFpTcGRkMmJRb2tmeHZHYlc1VzMwY3Nl?=
 =?utf-8?B?bFZpZXNCQmJ3Yk9kL21TQW5MbmtrMmlvakY0Q1JPYm16N3NDTEtBcFg0MEN5?=
 =?utf-8?B?S3NOa3dEM0N4VEZMbGtDa3ZTVUg3ZDltMGNYY3hzNGdDejBkL21NREZyb0RJ?=
 =?utf-8?B?T2h4MTAvSWRrbEFTcnNBcU1XcnRodDFoVFJPcTZPelNlbmVacVo0RHFGME1r?=
 =?utf-8?B?MmE3UmxCRDFPdXhXMXlBaklKSzRaY1Urb1Y0OXdVbFVJRjRtdjhDTVRuOWRr?=
 =?utf-8?B?V1VEWGVnYmxGTjF0eVRmbUlWMGphdzRCQVQyMXRaN2VIdGc2ZVRHTTJPeXFa?=
 =?utf-8?B?MlVQdHRoZWVHd3NXa1d4RUd4NWNtNG82bHZFRXdyR0ZGdGJyeXZSZjBVZzBW?=
 =?utf-8?B?eUVNSVVBRXlURzU5Vm9OYWViQVdqL3FTWEVKUnRoQWlqdFk2MTBOMTI1MGtz?=
 =?utf-8?B?WWVIUERnZkV5bEI3ZmtqaXVzeVp2ajBKK0tjNFVhVlJQSGxVMVNKeVhLdVBy?=
 =?utf-8?B?cklJZnNwcTdsWHA2NzRwcHhmZ3dxaXByU2hZQlV2Sis3M2xvNXNYWlNpaGZw?=
 =?utf-8?B?RUdQZUxneXlXTklTZ1gySEh3T0dkTG11N3NWaXcwVlU3bFZ3b29ybUU1SzEw?=
 =?utf-8?B?TmVieTRjSUF3eFlyUStKUUZvb3RvUGJXalFBODhvZVpZUGdQd0IvVUV1eXJF?=
 =?utf-8?B?YW4zUCs2YitaYUZkeWhrMGRxeGw0RXZMcnJJVlZCb0ZXTDNEY1FnN1FJTVd6?=
 =?utf-8?B?b0dJUEV0Y0hQcFZMY2doZVFpWXRyd2pTMmxwNmFRalc4a1RBZ3YzaVQ3TGtT?=
 =?utf-8?B?WWp5TW1NL1pkTDB6aUpEWVpkd3pBeVVGdXFhb3k3TjF4ZStTZ2N2cFpMZWdT?=
 =?utf-8?B?UGZray9FaUVGWWo0dnRMZEZJcS9IcHRIVHFnTzh6UmhWcEVyQ1AwOXExWkwx?=
 =?utf-8?B?bnJ0ZzBxTXZ4TWtwTDU1NiszTjFiSFowTEs2OE5QRnNsU0V6OEJzVmZhTGRD?=
 =?utf-8?B?dTRaaG1ud2pGaWY0MWRLd3NFSVNlUytnWFVlYnYwNllvVUk3NzJsUHlSL0Vz?=
 =?utf-8?B?UmJhakxDTTM2RktLWkVWWGlHMW1BUTd5dFBZeGFnQW96ZnRZbDVyQXZrSnFL?=
 =?utf-8?B?RmRGOGRzUk1GOU5qZFNsS3lxQU8xK1ZWeXBOcFBMY2ZpUjFYVkY5elJEMlhY?=
 =?utf-8?B?bGVjTTFISkQ0K1hpYjRhblBsd0RVRVJ0YWtxajNUUHk4dTdvaitUaGtZTUlX?=
 =?utf-8?B?Q1BWYUZGOVVyYkpmUkMrbFhkQm9Xdk9wR2lNQXhYM1Zrb3pCQXYyd2x0czBs?=
 =?utf-8?B?a2lqYWkvbDV1V2o1NXZwVmpSc0VxVW9kUVNTTnNmaERRcXNkdHVIb0RrMEZD?=
 =?utf-8?B?NEY0U2ZOWndPdGpYZnRDZVpqK0xQVmZFbmpvb20yYi9Ma1p4VDVseFZTWEpT?=
 =?utf-8?B?emtKSVV4NTRSRmQ0RWxlWGp4dFJhRHVESU5VQS9zc2MzQXBZZEVXRnAyMFhD?=
 =?utf-8?B?ZnRqeEFKTW1hYUFySDJWNEJqSEQrbWRrdHdaN0Y5NVlEOXMzTnUza3BiRGJS?=
 =?utf-8?B?eGNXVTBSVlhOczNSR1M2VTJEbTZHK0pqemd4cTBheVNZOUk3ejhDWmswN1ls?=
 =?utf-8?B?RUFPWWRMUmJGRmZqS0pnVS9lWG5GQ21mK0lMSlNFQSswRXB1ajlTdlVHZ3cw?=
 =?utf-8?B?VUF2bVNsUmw1Z3AzeFltUXQyL3h6U3Z4QkdxN3UxenZkbnZnMDYvTkQ3ZzJS?=
 =?utf-8?B?akFUTGFvUHRlQld0dnNTRUVTUnN0QkZPT1pmamJsMVhiRy83NXM3OUNzQkdW?=
 =?utf-8?Q?AmgTvYg/wcAhJRDX9zp56LbF4VLVSlp/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekNVWkdicWplV3k0ZUJ1UDlLbElyVjVhKzFGeWtpL0pnaVJ3d3YyVUdYL3Yw?=
 =?utf-8?B?Vm44NFVOWUFJUU9PUXVXQWxpNlpGS2dzRFkxM0l1ZVhxb055a1A3MjRHWmZV?=
 =?utf-8?B?eUx0eHl0OEdORkRRMmQ3MHVEaVBCd2lQZnlBdzJibXprelgxbjAyMHVyalUx?=
 =?utf-8?B?a0ZEN0IrMjdPZks1dmJ0Zngvczh3d1QrWVl1QndhcjZici80ajk1bVBzelVv?=
 =?utf-8?B?Mkh4MFUvWStqd3oybzRMcUd1NmNZUGsvMldoYVVOMjRKcWpwZFFldnh0M25C?=
 =?utf-8?B?RjBjU2pBZDV3U0pRL2ZGWktvQWNlYitqNnU5ai9mQWN6bVNla2VHUlV3SUEr?=
 =?utf-8?B?Sk1RRko4ZHl6SHhvSGNieW1VUDNMTk4wb29Ea3I3VllLVmxrM3VmTEFPU2Fy?=
 =?utf-8?B?Z3lwcHAvTWp0NlpraFdreWJXb3Nlem1hcEJ5SW42TVRzYzdnUDNmSnB3a2hH?=
 =?utf-8?B?TVdEYSsxTUdTQjBaWVVPTDBRR0JVR1YvWkhYOVZqcExsT0FTYlh4VGJ4WFNz?=
 =?utf-8?B?a1VQV2hUK2NzbXhvTU9ZWHBJQTRuQWtHSjVTSExKQ1lsLzJFY2sxOWxreCtE?=
 =?utf-8?B?L09aWWdYNkFZQVpwSlRqNnVrV2p6K0RIdTJ3T2M1NUs5b0xnSW1MVGNWMGcy?=
 =?utf-8?B?T3MxcTF0eE0veXNDTHlSWnFzN2g2ZnU5d3FCOTdQV0RlWXJCak1NTXVPQUJp?=
 =?utf-8?B?L0J2dEo4L2dkZTNBd3ArV3NhSEdKYlJvZ211ZFlBYndwTC9nYzFjQ2JrT1cy?=
 =?utf-8?B?MlJiTTJuN0g5NDV4ZVpram9LQnFqa1FVWTFPODJlZVlDN2JYampOQm92YXFv?=
 =?utf-8?B?NlY0bTFGTWNOR3VBVjk3ZnYzODVHbDNUK2pkM0RCNmJOMnZjbVpDMlNkZzFZ?=
 =?utf-8?B?VVYvZE5kbEhWUWhCcXRyVER1bkcyNVczRm1uTmRzODBkWURXb21wUnQ5anJB?=
 =?utf-8?B?NFJIb1NIL3lTd2U5aEhza0lOdXNxek5tQ251aU9YOGdTQXppR2JYby82Njkx?=
 =?utf-8?B?VU0xaG9yWDNtczRscmhlQkYyTzczWnF4eWJ3Y2JCaGl3SmdCZnArZ0gwZEZw?=
 =?utf-8?B?elZlUVNYQzYwR2FBbG1PaU5RVCtza3ZTZjZ1dTlTbHFkSFhLTTdrMmxOb1pm?=
 =?utf-8?B?SmtCSmxIcU85eGIzdVB1aGs3VklBZWhHTEVoR2RFSlJhVjNtTnJzVXh5d3A3?=
 =?utf-8?B?Mm9SVzZGOG1FdDN3K3EzQmk0bjR2Vm1LdXF3V004NUxMUWNlcEpaNlBJTlNY?=
 =?utf-8?B?a3YrcG9iQm5MZ09EQ1NPR1dhUXYxOUgwUXFxY0c4eGFMdVZFdC9mdUZUOEVD?=
 =?utf-8?B?VUVxaWRpQ2hrKzh6Z2FMTXRFUFloenNlMkE5bEQzdm9oRlBDbVFUR0RpUm91?=
 =?utf-8?B?bTdxWHowSCtMTDlhY2FQRjNHODdjdWtacEQ5NVdlQzlHeG5sZkhBN0ExWXo0?=
 =?utf-8?B?MzRrWnJTVGpNTzNZbXcvb0VrUHBvUnB6SWdTa2M1dHRpT2t3WkVoTVZPRGFU?=
 =?utf-8?B?c3BXS3JvVjd2T1F3NWM2c2JLK29JeDV3dDJjVnB1TDcvMC92SVRhMDZ2Q1k2?=
 =?utf-8?B?dzg0eXlQN1FES0hkeWRTazI3R0g5VEtwLytieFphZmIzM1MyL2YvSXBmZ20y?=
 =?utf-8?B?ZVcyTTlCQXdoMmlSYk1NODQ5aVgzRlpBMjZmSmtpUUpCYkw0RVRyRWpudU52?=
 =?utf-8?B?T2JkdXRpdUU2YWZuSVFWeFJ5OURQRmFIeEN1eE95cy9xU3BsSmErdlV6eExQ?=
 =?utf-8?B?TzVncjJyOFhqTFRLd1lPV1daODRWcFQwWjNFRTJKVXJLWnhnVUovUm5ObkZR?=
 =?utf-8?B?RFBTMWF5bTBjWW1FaTN2SXUwQlpuWWlhb1FGYUQyY1FOYTFBV1dobzBKc3Bs?=
 =?utf-8?B?REM3VURHbTRxWnpwYUpadXdGaWowUk9CYXN1SVF0a1dwWnNnbXI0cUdLU29K?=
 =?utf-8?B?MVhuMWFtMkJjQzhwcnF3UEhwQmdKVTFwK1FMcG5HVm1SemIxc2ZSVXRRNytR?=
 =?utf-8?B?THJXWGE3NFQwQjdPV1ZoNlcrV3ZjbWppWGc4dC8xeG5Wb2FqRk9jWDNxK3Ra?=
 =?utf-8?B?eGplQUFNV05ReXZyWlhhcnVTclpiblZJZ2prWXBienFTYTg5NVd2aGhIWitR?=
 =?utf-8?B?cVlPaEZpamJ0WGFDYlQra0dZTk9pRStZVTdzdFpVQURRSTZPY0ViWHZ6a3Jv?=
 =?utf-8?B?aU9YTVR0blN4Nk5YWFNvZWlJRk5PMHRRdmt5R3pDRjRsOEhBNFlOeFZQbUNS?=
 =?utf-8?B?bE5scmdxeTNkVGZCMUNBRG1lN1N4czNtK0Vyd0lDeGdRSDFQYlcyTWovc3BF?=
 =?utf-8?B?a3N3M2VpTE5hWUJJRk1BTGNWWGFKRTVnK0MxaUJZZkFDYmM1ZGkwQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094a14e6-0a3d-4291-8d93-08de4f8c3b80
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:34:44.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igY+a6Bd+0Os1MAooWtwpWB2xChWKVZ8JZNhhwh4YQkmT+u/VPYyfeaPyVh1emI5Lux96Yb/cLCCUUO500tbkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4088

On 09.01.26 15:20, Clara Kowalsky wrote:
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .gitlab-ci.yml            |  8 ++++++
>  ci/xenomai_3_dovetail.yml | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 ci/xenomai_3_dovetail.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2f03fdd..c8f649f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -59,6 +59,14 @@ xenomai-3/next-long-term:
>    rules:
>      - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
>  
> +xenomai-3/dovetail:
> +  extends: .parent
> +  trigger:
> +    include:
> +      - local: '/ci/xenomai_3_dovetail.yml'
> +  rules:
> +    - if: '$ONLY_RUN == $CI_JOB_NAME'
> +
>  xenomai-4/next:
>    extends: .parent
>    trigger:
> diff --git a/ci/xenomai_3_dovetail.yml b/ci/xenomai_3_dovetail.yml
> new file mode 100644
> index 0000000..e54cafd
> --- /dev/null
> +++ b/ci/xenomai_3_dovetail.yml
> @@ -0,0 +1,51 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +include:
> +  - local: '/ci/gitlab-ci-base.yml'
> +  - local: '/ci/kernel_6_1.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "6.1"'
> +  - local: '/ci/kernel_6_12.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "6.12"'
> +  - local: '/ci/kernel_5_10.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "5.10"'
> +  - local: '/ci/kernel_5_15.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "5.15"'
> +  - local: '/ci/kernel_4_19.yml'
> +    rules:
> +      - if: '$KERNEL_VERSION == "4.19"'

Let's sort this by version.

> +
> +.xenomai-3-next:

Maybe name this after the kernels we catch: .v6.x-dovetail

> +  variables:
> +    XENOMAI_VERSION: "3-next"
> +    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
> +    LATEST_KERNEL_VERSION: "6.12"

This variable controls for which kernel we are also using qemu as
target. We either do not include qemu, or we always include it
(LATEST_KERNEL_VERSION = KERNEL_VERSION). I'm leaning towards the
latter, even if that means more builds.

Maybe renaming the variable to "KERNEL_VERSION_WITH_QEMU" would make
this purposes clearer (separate commit).

> +  rules:
> +    - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
> +
> +.xenomai-3-3:

.v5.x-dovetail

> +  variables:
> +    XENOMAI_VERSION: "3.3.x"
> +    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
> +    LATEST_KERNEL_VERSION: "6.12"
> +  rules:
> +    - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
> +
> +.xenomai-3-2:

.v4.x-ipipe(!)

> +  variables:
> +    XENOMAI_VERSION: "3.2.x"
> +    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.2.x-head.yaml:kas/opt/debug.yaml"
> +  rules:
> +    - '$KERNEL_VERSION == "4.19"'

Looks good otherwise!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
