Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3F13F439
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774911; cv=fail; b=KWSWwOdfEBvRrNOGg/sqZRCXjs/ky9SGhxhr7bzYh0DcklI9v1LJ2lORF5rry40hYLg3tRPJ5/BU2XplgVVTI7VVXHVHAeEi0V+rDrMhj988WPts7tosROpTUx8m33jiDnNKd4fnab6ikKmPZcob821msiVNc/Ist6mTxkoIsmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774911; c=relaxed/simple;
	bh=kg9d3Gu+YAjwryFMOjrElJ1CP8bkLT0jM9E7c53bAOM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BxL8xnIIc5yQOdYol1RFOWDqyfhyCwFZywxYi9NkiOIwbqFwtR8RH+3t9mUL726QxwFTg6wisROiIMChPIIveXY4d4voVRIYoJ5X0aMQtb82s/Sbs88g2yJ9j7ufX2j2rDEjEmZgDixhrZZl0RfhTS7mKm+iHtGKwMyJGIEpmUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DCRbJOUK; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DCRbJOUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTAl7NKOzmkT/Go+g3dFI5dqIb/5mVNlK3chUE/SZXPCCRDWVTVtB+0ihsaRCcJmL3awlkuxy64h4OSmcT8CVsuaFNUP+InU0uqItfZMAq6fb/nCn2fVZlHn4HKe8j9dCSsZNrvUTSqSYhzqyZe4OBJyakYyjwx1bGKQpYPcF/Mbfos+Gs/TzfX3LONPH4T5XnUGEefSyGlZpzMvCJ976JAe+9aYdgf/JEvVVyD1K8s4/7aW0Ox7fPcg4nwH8M5k/xQqQDI5Jk02BfLSBjJ/Ujdx5FJy/n3E39AHKuGjLtEuiyoEPXB+a8PQetTK6E/JxOtn87dk+ditzgtE2Q2vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y4F4Gv6BvG4pbTjmsiYhMX3Na+rHMCRAZvjjn9rj7k=;
 b=XSRKdF53UjPZ+sl2E8o6TJIkF2M7rFMN3yxGyvQ5tKEi3Naxp75g/ue2ffirQJnF/D7w+8N6YZu9nqNyoxjsYu0CGr9vVdryUkzEsR9d3Lczl3hetb2hdPva+gPYCXa6RVhZUwd5huCj/9znWgJYYKxfiJN3mNQFUegIJcd56GL/ZIJ+7fVOwNuEolB8kPk8aqaIW4N9tgmTCHTjmD7vl0i2GEj5TnrgwVJVh3ko8+R2d6U4ydBbJ6+fpaIveXtQjvHPptP0J2bbvNuXI6xio932EfalnPCHTyrjul9DVxte+WFCzWwsdzi7+vdjz3vzod3hRrbhGbL/obWeQgSgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y4F4Gv6BvG4pbTjmsiYhMX3Na+rHMCRAZvjjn9rj7k=;
 b=DCRbJOUKcOiQskkOjlxsG4uOcb/iBn1k7SrvmMvXcDLd4lDscoSC2zg7XWGgxwQ8no93WUhCU/iZBcpJj/DjL7SCQCQww2gx9AqXtNkyOGOjAmdC9jPPQOPQqYhZ7VMPyfYNmxDUz+WCaHwy8nfVPrBnJ+KcEqrTq50r/9FeNrGxaZN2++R780rgPUfd359lVABuuaJqOlQZ2KAmhxh5DYGEtjorfRegHuTSAu5teAp2DLM9UeV8nvdzgXgoCINUpfiOoJvT/luY6HuRYCxtnruTsGR9Ff3G10nj/veqTHYQ1pi0qRU+PpNEc1BTUlLT+QeEE5ZGLHFpY+r/FsrnHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:01:43 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:01:43 +0000
Message-ID: <d01917ff-79cb-44f4-b051-e393be802bd1@siemens.com>
Date: Fri, 12 Jul 2024 11:01:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [xenomai-images] Ignore name when searching for failures
 in junit report
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240712085232.2989424-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712085232.2989424-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: cc552d78-107d-47fa-0fd5-08dca2514000
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlF2dmY5bVcydUdVcjJ5d2hFRzJzNUxidU9qVEZ3TjI1aXlyNFVyd2I3dlJU?=
 =?utf-8?B?dWswWmVjYkJocm9WUkl0bHRSbTQyOFBadk4wK0JhWVhKZ2tVS1duRlEvTWZk?=
 =?utf-8?B?RE41V0dIY09WSGd1dGR6aVROdUZ1d296VFJrK0FZcE8xMjRIc0hrNTZRRDhE?=
 =?utf-8?B?eUtyVUhydnMvQjNtV0hGbVdma2JXTHY3aW5Ea2s0aGpUUU83cENSZnFRU1NV?=
 =?utf-8?B?OGxCeGFhRlRWeXd3NDlHaHRwc0NOVXoxMG5kd01tWGlwSnlBR2czdHRvUzBa?=
 =?utf-8?B?VmRiVUFFS0l1bmlsZThmYU95ckZhYVRkcmMvYm14QmdLcWhyS1pnSU9ubEpT?=
 =?utf-8?B?aXZoY3lIR0cwSytjVThvRmp5bXp0eTcwS0VsVitiekdOemZqbUp2S2tsdWlu?=
 =?utf-8?B?a0VKR3lKeE5WUXFmWWFNdWVMSEZQVGw2TTNwOTA0M2VCL3FobnMvWjNNeUhC?=
 =?utf-8?B?akhuMGVqS3V3VitGZklwMXlRNU9SekFBRzlDU2xqK3RrVkVJWTdHZ1AwcTgv?=
 =?utf-8?B?VFNiTWhjOS9NYURVVTlqWGM0cGp1UmtrSnV4emxpZU43Vmp4Z0VNd3FuNkty?=
 =?utf-8?B?MHZRcUtWUjNrd1pJVjg0d3NHY2NGQ216RXMxRVl3dE9jV0k4UWdiQ21lb1FG?=
 =?utf-8?B?aWp4c3VZdWtkY0pyRVBTUFhsbDliMFpLYmJ6QnNKdTdseVJCYWFRUTB2VmNz?=
 =?utf-8?B?b2JZYVJ0b2poSGdDcU4xb0tHaTdJeDdQOXBQU1N0SFV3b3hNRS8ydXFhWERu?=
 =?utf-8?B?ay9KaDhoRHltQXRNN0VvZ2NDNUUySDVKR0dOK3NjTnd6QkZZUDZORjcrcU5o?=
 =?utf-8?B?WkdGdTMwMkYzdEI0ODZJWDVsMEltdkRiMjdjOTF5eVd6cE5POHY0dEdIZlVq?=
 =?utf-8?B?OFQ4NllQL0xDNmZTaHRMZXFnN0NaSmZnWWI2WHhaMjBpcWNGM00vRTlzU3Zy?=
 =?utf-8?B?bGtCRWVuazd3U0EyV003WDRjb3h4dGpydFhKbkdkbWw0VmdaMEJlLzR1NUR5?=
 =?utf-8?B?Y0lZZU1XbUdYckVDTTA5ZnZBa2greDN4RzhDS0JjZitrM3FzNklINkJhbFN6?=
 =?utf-8?B?VVQ4c0tWbHI5OUJ1ZWpoanEzbGZ0dmFFbS93R2ZyV1ZFUGNiMlNHbDE2ay9k?=
 =?utf-8?B?QzFPbHZ1YjJrZkhObnIyZG0rSHFadzlzanl3ZGdNWVdtR1h4TDk3N0s5T2Fy?=
 =?utf-8?B?U0kyajRIL0x1Y2ZINnFSNWh0Z1JmbTlrVEhQMFFVN3pDMlBXQVc0MlRZYk54?=
 =?utf-8?B?VGgwN1B1ZEFnMThoWEJlbGhFRHdaWml3dmpsdFIwZThRT245a2xOQzVnQkR1?=
 =?utf-8?B?VytYV0crQ1lVNXIwMGRwazB0UjRsK2greHQyaGExbE9UMGNsaldZY3Q3ZUpT?=
 =?utf-8?B?aEVyVDVraG5jaVQ0R1FIT2wwd0xEUVI5R2NVNGtoSGpXVlhuUGwvTW0vWTBM?=
 =?utf-8?B?YkxxbTJxY2E4dC9DekhGbFM0dXZ4eWc5ZWk0dzVUMExmdGRnbkdXZDJsUVJH?=
 =?utf-8?B?Z1dVT0lzbUZmQ2wvZjEyc0xOS205U0VEWlVTbDlJWmJSVDdHTTJjMlAyNWJw?=
 =?utf-8?B?bmhVNUZwalRHMDFBeDd5dmFqczlRaytqaFc0Y095RzFRSFhXZ3VQcHp4T3Zi?=
 =?utf-8?B?T05EQTU0Ni92UGhIU0FsQkYySGpVcWZiUm1CRWNzQTllTE9sVVBPbnBGenB1?=
 =?utf-8?B?V0dWanBueVgzS21vWVRmSTJqRGlWZHFnVWp1TU5iWWJWQUhZdHZCcUl3cHU4?=
 =?utf-8?Q?nxD+c8cZ21A+iB0BvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjVOMzlEZGVHZjNYeU1TUm1NVVRiNkFRNWQzcnZ1SWY5c2JFQXQrS1hXQUoy?=
 =?utf-8?B?TkZucVROVmROcEljeUtFTHpzU1l3MG1TYVdtaU00Y1cxUzJNMUJpMEVnWWo4?=
 =?utf-8?B?eUtHZ2o3QkFCR3FQNUV3T1VFWmtFNE40eTZheVlJVm5OVTFtRlhaTDlpbmlx?=
 =?utf-8?B?LzQ2N1VubGllcXF1aDlFb2Q2Z3FNSGRvbWx2eEJXSlU5Ky9kY1FjenQ1MWJv?=
 =?utf-8?B?OGM2UWRYMnl4U0xKR21QUUJaa0Uya3RxTzVoMGJ2R2tlOENSM1ZDREwrQVht?=
 =?utf-8?B?WkZVZ25OcG9lTVBCNUdvY1VrN0hqeVovYVZ0R0JpS1pNU1A5bWJGLzc1aE9K?=
 =?utf-8?B?cjRqcDdwdW9UU3dZd1p1QVFQUC9TWFJJdDZTYTRwdHRTNnU4WTR5MGpvWkFp?=
 =?utf-8?B?eThLYTR6ajNGUEIvSjlEY003alFRNHNwTHJSbGtjWTg4MjBFeGxEdHVGZ2pk?=
 =?utf-8?B?ZWZXZVgrNzJqOG1zVkxDZHR4ZEdjblRPQjdsMXhsdXB0WklhejVGSHhwbHhF?=
 =?utf-8?B?T0dqcnIxYmptWXlwQno1OWxQWGtVSTZ0OHZ0dTZBTHlTNTFxNkRUUVFvcTF6?=
 =?utf-8?B?d3hvNDlsNWhCYm1DMUZmMFE5SnhlcTNCL2tCM21GOGdRRXJIQ3pFZEFpbmpn?=
 =?utf-8?B?Wm1Yd1N2Y2ZKL296MXF3eWlXQ1JYaDNrSjZGbXhYajVHN21ySjBLV1VVNkZu?=
 =?utf-8?B?VklqTlVGTUNuTXkycnJmb1ppR1VtZkoxYzVEOVh5MVBZMVhZOGJLWGErQmho?=
 =?utf-8?B?RHpkaFlWeTN4UTYralhmY3d2Z0RlZWhuZDV3cWJmQnhyMGFpM1Zrd1gwVExJ?=
 =?utf-8?B?S2xoeE1lUEszWCt6akNXRkRyOE1uSmphRzBuSmlIbE1YNWFKdm9iVm8wZmx5?=
 =?utf-8?B?V1pWSkpmeTkwdE5KVng4dkowQlFHU3RCSmtJUUgyb2ZLQnZOeGt2dUVPc0N3?=
 =?utf-8?B?NEYxdWp1ZiswNVo3cWo1VlhuQWFNVWhack11L1FVRlJsWEJ2MVcwSUFCbUNF?=
 =?utf-8?B?TlJxRnZMbFd1SjRyMGdWb2p4emtCT3NJcDJGMjlvWmZNTnF6akM2SFZ2UUpQ?=
 =?utf-8?B?aWRjVWt4RWlKbG5OTTV2dkZZd3YzTndGTUZTNnY1UytWYWkrWHN5NWdhb09C?=
 =?utf-8?B?dElTUFRrK3NBc0lhYUswZExwam10SnZHZVJYaCs4TlRnM3pGOHpGdFZ5MXdN?=
 =?utf-8?B?L3YzaTJrTmptUk44RlltKzdscTU4L0gwOXVoYUZwZkZrWkFndituRTJzWjht?=
 =?utf-8?B?QTlKaUgzeHhJejY1ZWZzZmtBcVpPanBkandWSHkxL1MzNGhpU0w4VzAwekJT?=
 =?utf-8?B?QTRIV0RaOEE3Zit4WkMzSUt5T1ArQ3d0ZktyamM2SEFuZXI4TjZHTTdzcXhG?=
 =?utf-8?B?UU9kNWFvSnBkVDV3U1RSUDBJWnZPZWVPN3BRRkF3NXNNZnFTang3dEJxcUFB?=
 =?utf-8?B?M2ZJbm5veWdqZk44d3oxUVdHcjdyLzVVS1RiUGN6bVRHMDJuZjh6M1c1TlRB?=
 =?utf-8?B?OWZhczdLUDl1T24xRGNWaUhUK1plZXY2RjlpQWhoWWxEUktRMG9NWE5HSk5n?=
 =?utf-8?B?TmN6UGtwWG9UZlRFK3lrRjg5cHVlMUpKUmdOcWFnZVBNWDgzOXZHemtxMWFC?=
 =?utf-8?B?aXVCQ1ZWRDBnMm80VFd6NVJrRmJOY3dXbS85NjU1cktvZC9lZEFaOUhVYjBT?=
 =?utf-8?B?d2xBbWlUZXhYV0RnalcxK3ovNWcreStkeUwzejRKRnVYWkFqei9vY1dwcjJF?=
 =?utf-8?B?enYwQ05ZTk51QUl1VkswZHAyd0UyalA3RkxjVWFoUVB3Zy8xZHdKT1h4NGZ1?=
 =?utf-8?B?dmZhN1dkNmo0K2pobFU0eFQ3THMxUmpvS2hraUpVbGk3M1BzK1VySTdGT3hP?=
 =?utf-8?B?ZnJwR05iWkh0ekt2MENta2FqbXR5VHp6OGZLRzNGM0JDeTBJVlVXL2phME9S?=
 =?utf-8?B?ZmM3LytlT2l0cVJmaG1MU28wR3c2UVJMVUduTURORTg4QUtsakJJelVBOUlB?=
 =?utf-8?B?TFpVc0ZxV0xseE9MRVg2ZjF0QXgzVlZjTmxUSVlwc1c5ZzNCQXpYVXEwbjlT?=
 =?utf-8?B?QjB0YTBZVmFya2czREswcDQxS09QdmRjRUhCRDR6VWM4MTJBUVNLVlpVc0pN?=
 =?utf-8?B?bWlySkhYMmlXaVJTZUErYmFxL0NZREpEUHBWeERNWm5VcTNkckEwbWhiakFH?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc552d78-107d-47fa-0fd5-08dca2514000
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:01:43.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyolV+uuGMbQMo51OyAFbLY1BKdLU6RXhDxArzXXnHBafPpaQcRwBGdNI7cVKZejuGaJVSTAOjOD6qd+UVDBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6934

On 12.07.24 10:52, Tobias Schaffner wrote:
> We only search for failed test-cases that have the name job. This is not
> correct. E.g. the xeno-test result will have the name "xeno-test".
> 
> Fail if there is any failed testcase found in the junit xml report.
> 

https://source.denx.de/Xenomai/xenomai-images/-/commit/22db8c107109eef90bc5f93baa5a38c2e7f50f5c

If you find a case where a test failed and that did not leads to a job
failure, please let us know. But that should likely be addressed in the
LAVA tests then.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

