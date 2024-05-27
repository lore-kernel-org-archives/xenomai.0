Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DE22EE8
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794865; cv=fail; b=tpqgTWABOc2GDIjX2KRKG5uOtlF3ql1gQT7UQ5TxaqDqan35ed5m8EnHyN0grsq4zUOTB3upFnLJBzXaEeV/fYN5k7MsR711t+jzXZ2XfnJU/K0M9rj36pFZHG6fxJpqD3mv1bWGHMemx371ObR5UZ8/t3jAX1WLZyw20sgDPyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794865; c=relaxed/simple;
	bh=7c1+RdBSaWYh9ToCpBBSXnkVrFoKNEyUBuJquZKPYjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rt+fIRyjdLm39F8gHVHUi9JYs1EBpOPqCD/d43n4Rd4iuqy6GoUASey692OpwYclzpamJEhklXs9a+E+dgXCZ5yIcVv4kBYPi2b5eAKBPMTQpHARAuOcFbFUygsxQqpuBdDSHN3lZp9HAB4AJQwEA4rw1bVtdgHDGAgjMdS2QKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=I8FcIotg; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="I8FcIotg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JThNbxd/j3MWivrf8cJ53VzeL9zGWS5eCTZumFzSzdZiB5DmW2ZJJeCU9CLhrQzDBb0AvMLlY/qJb9pJqIg6+jggUwP2HZ2IhpY5B4rVlo4r0tnQ7URHGlPGE+uHKwaCvDHN1BqX+/huhxzHi5sdwBBdIe/O6c2XknXEP14kF6A5qlc4AJZiHPJ6NHXiOncjeNlJH9kpJwD2WoPI5XlGZ3BKXTKLs6qQ+QIjWoGdhTlGotId/7ddFOIPTEsyFKmcwXUL6eGGbB8/ZEnI4Nhoy+Wy9eqUfkObcS/Zld/YvEywZRQVcL/3xxanXwqrVa9poMNhxwSrs7KLExRgzoHQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRwg1r1I/Pjq7eSK4DBdJdRqrZKOwWSsEHY2eYhS9Hc=;
 b=oQEpfF7Nd2ErrCH9aXOsryF3tIKuMpRN6VeNi/fc/ZSAHBFNOr+UnEB/nDGaHztiWRqvrSeXhPt5o3f+YtK6d4gKPmEvB2xIMBHrfv5tO9aORHVkpl7nYMWiyEGAOyURynlgiFA+pNBNzmzlY2LPl6vg2usQpUS/SWERJXa0KWHo5yvn+3xMxySFGzfDdR/iYexVG+k3DlCv6NrAxPlatLOu6cTd6RrG2hzIWc9heOSQ/a4axMbVhinvjhnETUVmxmYoi6mJPAULS9yOSsTBiJMf4dpbcXb/uqMtPERPF+Hz8oAK0uzU7lcCpjFNb/kuJUBNutC+wplvVg8SUVJWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRwg1r1I/Pjq7eSK4DBdJdRqrZKOwWSsEHY2eYhS9Hc=;
 b=I8FcIotgfy/uN4tN51rzhskvie6iIaDcB63rVymaR49Bl/Q+e3OTfIJ7j96dwRTtdPXw2fVxpv4I2LZX53x2b9XVuj9jGKWLCzB+k1ts+mPQEsY0J2v8loh4oHeGwd+1Q4jx1XbT+M6DpnKQrCu4UmsywE3PQuILyTkwI7AIA7vA1CNeGm6RbMvlp3SJMAcaX6//Fc3wVwCI8yXWoVk5IvksOVeHrf1AlCkLxnOXR8/1nUaJSj0RqJmwwuP5okbmekXTyC8IMATzBsA6f3Uppj1PUhysOGt85c85gAP6eh/voNh4CnI3mmBDB3SYWmySCM9zs3QbJlZcIED7RxAqUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:27:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:27:38 +0000
Message-ID: <7e124965-ec6b-43b9-8cbf-7a585f0191e6@siemens.com>
Date: Mon, 27 May 2024 09:27:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] prepare-kernel.sh: Convert to tabs
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-4-richard@nod.at>
 <4236b09da042f9bfb766707a95dd60f229b69a51.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <4236b09da042f9bfb766707a95dd60f229b69a51.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 874c932d-dfbc-4e70-cb26-08dc7e1e7c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXdvaUt5T1lheVRsdVNUMGFTUEh4MTltTTZHZXBiYmlHc3dhUnFDV1BabVRl?=
 =?utf-8?B?dU9lZ1FQcDJOcDRTMGdBZkFtNU5IRlRjQld5K09hdm5PSlZtVklpZjlUQm1N?=
 =?utf-8?B?cklnQ3U1bHJnRUV2bEVKZ1BWNDd2SElqRENaamJVZWlvTzhaY2dqQ243OVQv?=
 =?utf-8?B?alpMdFRRb05LYWs3eXRTMVYrcHNxdWZwM0FXaVBpTFNvNlhEWGZaRHRsa3J1?=
 =?utf-8?B?dVhFaDBDQnZ5TmZOeDYvL1h1M0hkb2RvbWpJbW9HOWVicjljUlNjQS82ZlJX?=
 =?utf-8?B?NzJwakdXclUxZm9QTDhoa3FIYk5haU5RSWc3VE16bnVCaUZrSHZCVmd1WG51?=
 =?utf-8?B?NURUK1BuMXZYWEVwdWdacHd6SkhobTZYYmNLa3pQNVg4dWVtbmxCU0NSeldj?=
 =?utf-8?B?eGpaTWgwNDB0QTdpYWxFTGZMcXMveCtqaTlISzVzam42Wlo4MGZsejRMS3oz?=
 =?utf-8?B?c1FjdGhDOWVnQXhPQVg4ZEwvdmRQcXF6SHVWdnhER2U1QUFBand6ZFJmanl1?=
 =?utf-8?B?UmpjdzZqajRzUGFkdkgzZWZNeU5BMnc2WXRhdklHNmRJYWgwMXRIOXNMUGpz?=
 =?utf-8?B?OUFvcENwUUpaMHhVcXMvU0hyQ2RXM29hV2xGNWFWQ0EwVXRzN1A5VnBoMXZh?=
 =?utf-8?B?R2FOT1hNRENBcjJjLzFBWHVpaGJ4Wmc5eFhYR0ZGNzI2K0tNdndBSU1jSjVR?=
 =?utf-8?B?QWRicU1qZXYyNi9GSnNPTngvdjQweHVuNW1qekZOTG8vSlpyYzVtRmsrNlpp?=
 =?utf-8?B?Y3dxYnZOL3djVE9YRjRad0VDUzk5NUVpdS9NcDNjSGZyejFENTJnZWo2cFRh?=
 =?utf-8?B?a3NPVXdUM1V1UHRQNDNzVHk1YXVzejlNaHU2YW1INjVheWFVbVhKNElRdTZH?=
 =?utf-8?B?dzBCVHZORU1ER1Jad2w4bCtqT0lXdDdhNkpkdGppOTEzeG1IN1QvUXRpZWh6?=
 =?utf-8?B?OW1weE0xWXFDU1lTaUpTR3JBWWx2ajVGR01EZVlFaUQ0anl0dG9aZlAwNkx1?=
 =?utf-8?B?dlhkRWZOSTZLZWFzK2E2ZlhiVmRjamVCb1lSSVBWaW5nQzRvSWxRcE1JRitt?=
 =?utf-8?B?eDNRcFRQa2NGYTVadnJjOVJOWGhWSmZ1NEUwRTAzVmtwT3RPL0VqT0NoV2NS?=
 =?utf-8?B?TFNEUFRmVjhvV3kvZUFXbFJvTU1DUUx5MXQ1VnkzcDFMa0tmSklWVGE3alVX?=
 =?utf-8?B?WDBDaWxqWXdFeW45V1BiYklGR1B5Q3FYUnFiaTJCYnlvTTBGUnJwLzZmYSsy?=
 =?utf-8?B?WUpzcWJlbDhFekQwSEhRRFZNSGtqZ1NFdVloaCsrSWtyU0lrMWMvSi96eVhI?=
 =?utf-8?B?QXAyTXFvUWNEK3JiUFY2YzZmc0d1UEkzT3ZpM243emF5VkFWYWFWelFmeEEx?=
 =?utf-8?B?VFFOaWNFZE5pNFk0MDVrWGVWSW5IT1BMTU1xVDlWd1ZORWNmTE5sZnV3VzQv?=
 =?utf-8?B?Tk9nQ3J4YnFuZTRLclVHSW5oZWZxdGsycjJuRHFXczZWTUxKK0FNSHpCVkJ0?=
 =?utf-8?B?N0dZSm1tU256K2trV0pwRTFuNmhEM0ZNdzBsQ2d4OXpDeEoxZkUwd0g0TDlU?=
 =?utf-8?B?MVNWUGtENnBiYWNVVHh0RlFEZUI5bWxxNXVFU0VDTndSR0IzUDJGRW1CM2ZY?=
 =?utf-8?B?UkNMUXRnS1Fza2dpWVhmM3p4dEh5TzRYUlhTTE1XVEV5VEdUSFVuUEw5WjFt?=
 =?utf-8?B?a2pwajlzdlJlUG9od1RCVHVpS09hMGJ6M1p5RUIvRDZpYjBvUlA4c3l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFA0dUFlaGhERFBjem90c2dZQ0t5SWJkRk5NWFkrRjhxczNLWE5WZWR4bWkw?=
 =?utf-8?B?NXdMNzQrYUp4endzTm80aG5WbHk5Ty8vWDBPaVNMVE1HSnFoTWRyQU84b3Bz?=
 =?utf-8?B?UGhXbno5Vmt4UkxhcUNJTDhqOUoyamErV1VKZ05ReGlUZ3htczdESmVCUlFa?=
 =?utf-8?B?SFJZUXl5dFlSU0ZPN1E2SnhDcFlOTmp2L0FkSllHYnNkVGRUN3VCUmhBY1Jy?=
 =?utf-8?B?Z2t2UHN1UDVVQXVNVUMvMEg5WWlmblBKY1NEa2JuRjJkQ3VhUHZ6RVFXd2NH?=
 =?utf-8?B?eTR6VS9rTDR4cGZ3WWkweVJsNVRtcUxqa3d6SFJkUkhjbkV1YkZhdWlFRER0?=
 =?utf-8?B?SlZVZGRER2JCRTlOM3pDaE5iV1Q4WmJRb2RVWStrYzhmKzNWZCsrZ1lNM2g3?=
 =?utf-8?B?Tld2MGJQMlJmRE5OOHNOd1FKdGVKTy9WNnNocGJqVU9kcmw3eU02V3FtaTYy?=
 =?utf-8?B?dlhQd21Ycm45Q3FnSzh1enVuTlZQVExLOHloRTMvS2M2VG9sd1ZITXJwSGJG?=
 =?utf-8?B?RlBtaVdCcHRCdlYzMFdaOUo0ZEsycEcxQ21Za1M3dElEVDNpWFJEamNtUUFj?=
 =?utf-8?B?U0wvTXl3dFJ5Wm91V0F2bWV6SG1RSDJWNHBTK0UyaUN1bGNiRFJrR3VVSTZ6?=
 =?utf-8?B?bGJkeVJad2YyMEdWSkN2Qm9Sck9FR0ttd0JlZkxDK1NTNlk1YmZtMWJocDUv?=
 =?utf-8?B?dmFvR0hJblVITFpJbXFybjJLZnZib2h2eVFNaTJnRjdhNXlhZE8xK2xUbis3?=
 =?utf-8?B?SGJMYmpvQ3RmOFJuQVFjNjNBSDRzV0piV0tnUHB6YWphN3FWRm1DbnVnYS81?=
 =?utf-8?B?a09RQUZCSVM4Z05iTnBhWXNuYktYSE55cytyQTVwTWxiM0w5NmdLeEhvcjdN?=
 =?utf-8?B?dUppUThqYldFaDJqM2IyMlQyeFJWK0MrZlpXSWFQQkkxbkMvZ0ZoUXQ1MWdi?=
 =?utf-8?B?dExpSzVSbkhFbCsrUDZ5VUlrN1o1dEMwZDluMTN1SVpSMGhUcng2Z0NMdnNr?=
 =?utf-8?B?OTdURjBQb0ZJMVVJaHJMUmtoTHFFcTJObTU0Um9rYzlETXBQNXFuZ3l6cUh2?=
 =?utf-8?B?eFBaVnplOXA2WWRENGkyakJIWkE2UEFNRU1pNVRoT3JsQ25Gc2ZuOVBTaGJi?=
 =?utf-8?B?dWJ4ZTQ4c3FyZDlNUnJHWm9tZTZ2UklLbytlQjVoWTdKK3ZkS3V6RXZmOGU0?=
 =?utf-8?B?RDF0RDZjb2Z5Tm5ma1RHWDV0cU43bk54dERQYWhCMTYzb0hlblR1ZUNBQXdw?=
 =?utf-8?B?V0E5cUxPcTlEd3ZQN3ZZN1lWdWoxZlU4UFZnQ3FRbVE1OVJBNy9xYkw4bnJB?=
 =?utf-8?B?ZGNEbzhxWWFzc1FwK29IMjVSUjlkNHBlVnFsU3U5MDUwYmRoVEdja1gyLy8r?=
 =?utf-8?B?emswWUFjbFBhY1dVdGVVWDlGQU10YkwzYnZPZUV3QVI5WENvSm1tUHhDbTVm?=
 =?utf-8?B?Y296TXhlZzUweXR5RWxmSVd0dHRKT2VKRnVoUW5XaVRhSGFyNXphQ3NveDAr?=
 =?utf-8?B?SWNZdmdWN2tZbUFXeDhnMlZrL2Q2MGxJcW90QTNNZEpWRnREdlZRamJQdFQ0?=
 =?utf-8?B?OHVLVjhDVnV2akJ5V05ITkpiRzFFejBkYklvUFcrYWFIekJLRm9GdW1CUnQw?=
 =?utf-8?B?MTFlWjM0YmFCQ1BBMjRROFVnMzU1bnJ0djIwcEdHZ2RXajRsdXdLVHVGaWww?=
 =?utf-8?B?Vy9hZ0lrWlhaZS9WNDNtNXNSc0FqYkZ0UlF0cm91UkhiMXh6bFJXK0dtWW5m?=
 =?utf-8?B?bStKMnZydm9xWEtxaTZqU1RnSHZ3U0xGQi9qWFprRlZxK3ljQ2RSYXBLV3Z0?=
 =?utf-8?B?V3lodDZJRjFrN3hlcFppemUyOE04VlBIQlJlNGJJaFBMYmswRytHZHV3Vjla?=
 =?utf-8?B?OHZJY2cvSXVPRUQ2OUVSeS9EMGdvSXpxMGVHOU5TdG1PdXM1UDJOaUJkV01P?=
 =?utf-8?B?NGdLWS9DakUzdFA3NzFwTzM2U3RGR0s4RlU1VmdmcHJDWUdIMGoxTTErMkJF?=
 =?utf-8?B?ZW9MSWVKdDg4V2dTTDFxMjkrdWFLaUY2bU05UXJxdytZV1JjdEtIQ01WY1VV?=
 =?utf-8?B?VzhsRUdORHJGYnBYNCtKUlp0RHh0bjZGNlBPZkM1aWdObGx2bUVjZ2dZcmdM?=
 =?utf-8?Q?r16gItgDL9OX9lVEvKRppGLrH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874c932d-dfbc-4e70-cb26-08dc7e1e7c67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:27:38.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWtGEXmawwPehFqcM4kRN2pq4J+RcUsC3KBRiGEnCWNL96UanNoTdIV5r9zlgzCycWt3Bg2pih4+2GvlcQ3ZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7770

On 27.05.24 09:19, Florian Bezdeka wrote:
> Hi Richard!
> 
> On Sat, 2024-05-25 at 13:57 +0200, Richard Weinberger wrote:
>>  patch_reverse() {
>> -    file="$1"
>> -    if test "x$output_patch" = "x"; then
>> -        if test -L "$linux_tree/$file" ; then
>> -            rm "$linux_tree/$file"
>> -        fi
>> -        mv "$linux_tree/$file.orig" "$linux_tree/$file"
>> -    fi
>> +	file="$1"
>> +	if test "x$output_patch" = "x"; then
>> +		if test -L "$linux_tree/$file" ; then
>> +			rm "$linux_tree/$file"
>> +		fi
>> +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
>> +	fi
>>  }
>>  
> 
> This part is introduced in patch 1 and completely rewritten in this
> patch (patch 3).
> 
> We could avoid that by applying patch 3 fist, so basically reordering
> the patches so that patch 3 becomes the first one. Could help if
> someone has to bisect later...
> 

Yep, that would indeed be nicer.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

