Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36614A627
	for <xenomai@lists.linux.dev>; Sat, 24 Aug 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724494169; cv=fail; b=rVCvRoS/4NAxB8yNfKngnZjbXveoNcOctg8G+Idx8S7hln2wixOKxh3Mvi/ePZ6zLbkcm54+MnpMkLMKc5gnE7qChHMjxfssRs5ikbVO0g5HMcicJzHSrbnGgS7DZmYOr/zw8298yYI6CCcReBxliuTg9ut1XNCz6niLyzLmgqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724494169; c=relaxed/simple;
	bh=Tlqb2Oc3sHZUfhLD9gzsYIeQdOJ2SQtok9BGYCFzyQs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOiLQDLbbVFlJ2gmRLk9W/i4pVafGuaZLxe8bcKJbT7ibMUKyrvhspVIfqOeMvnwmUG2BwKiOsdlwbZg65cfGkcZQJ8YgfSQAGajAwZef7wgvurF5SVKUczLKXHPCiHmbQv25WZiXEts6dpIu2rV1SSgXDW725LeVY/Kq0lIhPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N13t5Uco; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N13t5Uco"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq0QLRzfTTdPnlvlJ8JHkZKDzS4V+SVhWIz4DaRWmS6vBQwvzhYty63yLG/Ix84XE2DoLFjDuPFhW4P6tSt609MDPtjDhTlhAcdcbmVmGrlM8aJ3xW2MX0PBwmLx+18V4HoCkWu6HvffCEsORluYP4CWuRksf1v//mjFqqbehxzgMpy96NaKmMRkJXwPWluPRZ+Zfzur/npXhbYcf//ytypWABEKBqBVji+XAfb6E2DAjB5ixFXz3OZ2VzJrW71FiJYiRh98QxrLAkQHmVezFcCIV0EWKDIMd9YGnuo+CXvBXiaQgKZu9vyQPrzEQAiMnPwCzfKqjp8iyTOgwB8jzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMLUaq20q8JtciNa51geCkUX0wEtPYdKXs2kpvXSS0w=;
 b=cqDV5TPWYdStKsLhfB5MvYekzXiQCVlrw9AEth19GJP0SVov2Yqw8eK9KVssLxRi5Mae4ZUqGhfpkXaucpkq+C2OUwwrWx4zgJWU9T4fjNfc1Q9RlmxI7nm1xh/SZAvT8WKo0MgMtg2UWiEYsrXRWZNJeA/SaIAk1blVPy2nZm3BVEZpDo3KWZIwDSpo6c0uplOd22LeZGCfmJ2KGQWvL050yXC6WBm/euQXSFpz17YdMIHutTV8GITNmcqURZZTrLz/rZqi76WAmr8S5mcZT1w0S06mjuquMLBQ2FlQRanfx6sFISqh94wPcFkcJ+7Rn+pJBCPnLYrtN+VjCBFxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMLUaq20q8JtciNa51geCkUX0wEtPYdKXs2kpvXSS0w=;
 b=N13t5Ucoc/81vOZDTYCOnb6F7CuTfO6baBdaT0ZvKVhicmwKFHPLyzmbDfhkVtEUYqOxODBnuxjRhl9yjiWiP6Q6KZ+qCPbhZZT+/L39IZe7x3ue3cZGfj4VOEDjZdzmbWnIlHjGFRssKfxhyLNbcN9GNs63ukBFk4yEceZZzw/FqcKzoymJpIjeYW6BI8MqAKeXmi01kRdNBPaImLrzF1154X0qK3B2JKwu9XFF8EzGDBNdNz9nFOO1PCDqMpoxOdJatCA9s6+OgHrudJVLEK6HNTZ86jZLxQEXWyIcvJQTLK02EwWWEOp7o2keferUprwG1qhzqF3qo8lLwKlihQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Sat, 24 Aug
 2024 10:09:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Sat, 24 Aug 2024
 10:09:24 +0000
Message-ID: <c7ab0464-a7d6-4f26-a821-5c96b71bc89d@siemens.com>
Date: Sat, 24 Aug 2024 12:09:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable Extension of Test Timeout
 for Specific Targets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240823165949.3707881-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240823165949.3707881-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 082fca29-8f49-4281-f5b5-08dcc424d457
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGpLYittRlhwUkVKT0JXc3U1Qlg0TitBS254QW9XWDRkYlNDbllUQU9vK2hh?=
 =?utf-8?B?b2pZYjQ2amZDR2FYTnV5VGIxZ2FJOFppV28vQVgzR2lDVzYwTUpCeEIxeDdM?=
 =?utf-8?B?UFdzb0lKdWJoUnFiTmpidUQxYTdmMDB4YmVCak9oRjBBeW11dlE4Qm5IUlJR?=
 =?utf-8?B?ZW04Z0xIRE53RmxDWmdMS2gvYldPcS9vOTd1T2wvNy81REYwd0RHcUdURGYv?=
 =?utf-8?B?KytHNFdPc2NKdzBPKzJWY2ZvZW41em9UeGhMR0xZZndBNkgwcmd5QVhrQnpa?=
 =?utf-8?B?bFNWbW1pWnQ4Q0NTVzBldHBFNnRMTGNDcjJBbTVSVjVBMVY1MW9XV1FNQXJq?=
 =?utf-8?B?QThtSHg1RHF4a1hzbERROUtHM1p6OHhmY2dCSjRtNmJJOU1rSU1NdThwRjg5?=
 =?utf-8?B?SUxJTlNrMC9JTFNMUDhFK1BTS3VvUmhBOVlBL20zREpVRlBGeWMySUF2V3ZI?=
 =?utf-8?B?ZVV6OWYvUldzb1pLUTVGQ1NqampoN3dhK3p2U2JFS3FCRHBrNUtlbVZQQWIr?=
 =?utf-8?B?enl3ZTA0VC9jQmJXUWNRWEdIMm80MjJaa0tTY2tTdzRZWWo0KzkrVUJ0S2ZD?=
 =?utf-8?B?aTVuNCtNNUhCdGQ3MENvTmtQUFVyZWc0NHZpOEdVVnFOaTczbUtHbnpmcnEz?=
 =?utf-8?B?b0ZDNHgydFlDZk4ya2JWcnE5WW9WV2pwZjZFaG9FUGVUZnAzTms1bmZOblhV?=
 =?utf-8?B?UXlnK1poZEVrakVjNXl2WEVXV1Bick5ObGo3MU1zbUxCV0NlK1VaSGJxLzln?=
 =?utf-8?B?bGJtWkxmT1JLdGxRUHJEWmZERXoxOGJ5UFVqRDVRZStWd0RLWDdwZkNacmFk?=
 =?utf-8?B?TjlhRlJCdDVEdHpyaSsyajdxY09IY2thOUFONGpXSEVSN3Y3WkxZMjJ3NUxR?=
 =?utf-8?B?clhsREFHcktRcHdDQzh5RFgvY2RITmVQcVFKa0RyNnFNUlhVOW5pOFJVTm5a?=
 =?utf-8?B?bThWWG93Y1RjYmZCaDYra0gveHM5d0JkNmtjQ0J6T2R5Q3FiKzU5SGlMRkVH?=
 =?utf-8?B?TVZNZCtIbEc0K0RySUFMcHNzZ05IL0lKU3dvdkZsUWF3Y3ZLcitBV0pRYmVi?=
 =?utf-8?B?bUdVczFVUlNhY2gzN2NTeWp2aG5JaUd3TFpMNVhOcGRiZmVRa1ZHRElaZTlG?=
 =?utf-8?B?RlNsTEdZZEptcnloMC9mWDNEMm5XTWVlekJyMWpsUDJnZVNXNDgyeFhBUlBW?=
 =?utf-8?B?SkJGZEN3em1abW95S1hnUGlTNFlTc1FjZEJPRTRnZkpXbFZjMWp6SWdsVDJL?=
 =?utf-8?B?bjV1T05UcGMrdGV1czRJSjI1eVZ4Y3REbmVtN0JkT1ZRUG5qcm5SQm5JNzZK?=
 =?utf-8?B?aW1mN0JsS3hQdWNJczYvamw4QytMVlpYM2I0YzhMUWh0Vlh6ZjBzS0RoQnlX?=
 =?utf-8?B?Z0U0MzQ2aHZrUVEzdktVQUpXaVdPb0Z5ajdRSHJiYXVNdFl2eEd2dXJhU200?=
 =?utf-8?B?a01NaDk5Tk5zVkJPZXhGZzF3bW5EZVFDTDMxVHlWcXljY0dnakFlQTlwbUxa?=
 =?utf-8?B?NzJUSndVaVZaSlVwaTAvK3JBTmJVMGJFQVJTNzJBWVRHbTVvSGtsbEVJY3Bk?=
 =?utf-8?B?Wk5EUWFsWlppS2ZwbFE2SkFmYXFHb3pPZXMzWVk5RnQ2NEpYYW5DRlJ5blY0?=
 =?utf-8?B?UTcxTWJoaWZkcUhvK1ZuVG80SlRrTFFrc0xEUi93N0lLQXAvN1A5VTU5UGpJ?=
 =?utf-8?B?bUlpMStFTFVNMnVua1VOUzlPeDhvUEk3M0hVd1UzbDR0ZjlmZHBSQXpxWFA5?=
 =?utf-8?B?MStVamN6R1dMYU9HRFFmby9VQ0t0Y05udjRlSTFhNW8vb0RMQmczeEtiTlZk?=
 =?utf-8?B?NUhjZXJaVkRoWFRvdDVCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlM0amNEUVBwWEpYZ2RZY21FbzRvWHREZHk3T1V0d0F4NE90eXV1TlJGNmNk?=
 =?utf-8?B?bXNESnEzUG4wMUVjN1Y1R3FRTUJOcmhUcXk5ZFlENXNRWkh1TjVYS08vL1NT?=
 =?utf-8?B?ZXJ3bjlXL2g2bGZiUzhLRHRsZ2s2MDJUY2sxdHdBUHFKQXlNaGltcjhvdGh4?=
 =?utf-8?B?bTJjTVFNa1B0RVZMVFRyVjB4NUp5TjdUZWRXU3krM25lM3J0ZEdyTzVoWkpK?=
 =?utf-8?B?NHZCYjhjL0JwYTcvbldYSFFpcHkzeElhY2tFUGNreDdwTExlaTVSdHZSTDRT?=
 =?utf-8?B?T3krczhJTkE2ZFJpS0dwN0U4VXB5RFc4bFR0N0VnSWJPNnZnT1MzSzBWcEZk?=
 =?utf-8?B?M25EMU11d0NvL0pjaUtJYUFKNXByOW5oSVVhVHVkQ1U0alpjcVpDdkFmMGNB?=
 =?utf-8?B?R3ZPaEx6SEN1NWlBMzhqTFdlRmoyMzlUVERORVAySnhTT0REZkNlL2NHTGNW?=
 =?utf-8?B?SzB2L0FEWkR1Wkg0UVJHN3NsTWNEeGM1cVdrOTVZT1pYM29vd3JMZFRCbmJB?=
 =?utf-8?B?ZjQ5SkwzMDJYaHA1VS81K2QzalgvSkxJR0s2eDUrall5ZmhxMjltNWhoRTFW?=
 =?utf-8?B?SHM5UGZCSStyS205c2JOUlowQkpiQ3NWeVlJVTJCalc1dFprVUpSSzBkUks2?=
 =?utf-8?B?L2pOaWlXS2lsSHhhbTIySThveFo4NFJtb2dweVBrT1JyNTdqajJkZUx6eDdK?=
 =?utf-8?B?T0lXSDY2Ni8vYXowdzBTZG9aYVNjeW56Z2pOTEJQcTdmZmt2a2FVUGs3ZEJn?=
 =?utf-8?B?dnB6d1pFaEJ4blZEYk5aV0hOSDFpUFBwUkJsYWZlSjYycGk0WE1mZ3pYcHgv?=
 =?utf-8?B?anBOUy9jb2RQQVVzR1czcS9LSmtPMkNMZHM4N3lvbW5XbFVCTGtka2p6bmxa?=
 =?utf-8?B?L0wva0p6WXFhNFhtNS94WGhRWkFGVVhUN291eHVnM0tQUjlzdmhKRjFxVmEz?=
 =?utf-8?B?aWZ6T3BzRjdKb1dzWVBabEdndC9GbXZ4WFpnanV0enRjVVFXSVFiRGROQ05J?=
 =?utf-8?B?VTFSUzRGckhSV3Vqa2cvcmYxTzZGSVE5NFdGcWxDRTVsbm8xdTVhNXA5ZWdK?=
 =?utf-8?B?TkI3TWRTaWVhMERmZXR0bnZpMzZ0MVNHVUVuL2oyUFRYdUZNZ2RmV1dSSTg2?=
 =?utf-8?B?Z3dydXRKWHg5R0M0OTlUVWp4M0oyMWdjNWdaTmh5SmF4TGF2Uk1VZ0xXMEp1?=
 =?utf-8?B?VzJGODZ3WWVCNzNuV01GVmRlK0U5V3UySjlZS1RCdE00cmIrS1dyMUM5YWpy?=
 =?utf-8?B?aTgzaG9WVXoxWHpnUEQxNzhoVFc3aUpHSW9QWXlLU2kyb1hGK3VvQjc5UGdW?=
 =?utf-8?B?RDNkd1ZWTUF4WS96cXdYSWdDOFR2RDRrajZvN0g3NHd4SWEydnMzRU1qSlJh?=
 =?utf-8?B?Rlo1bTlPSFQ5OWtyakI1VW9OZXBYSWFzakJFdEpvM1dSSW9RbHZ1NDdFQWdJ?=
 =?utf-8?B?VktIK0dwMlR4VmxVMnlmTElWa3pQdEEwZCtXOHNnWVlTdnY4MG03VmxObzFQ?=
 =?utf-8?B?VXNQUlBYREIrNWdYdXZvUDdYTkdCL0s4ZnlnMGN2UUVXZTNhVXQwQXM0ZkFp?=
 =?utf-8?B?TkE3ckY3a2JYd1pSa3U0WmxRTk1LUHFNRUJ0ZHVicFpVcEtodzdLMFZOT3RK?=
 =?utf-8?B?d3hYV21OSHY2M04xTlZFck03WmV4VFV4THk3aHpGSFJoMUhlWk9XVU5Mbm9I?=
 =?utf-8?B?V3REeGZIcHgrcjd5cTdROU1XSWgvdC9obG1XSUlKZnNGd2hHdjdPdkkxc0Jn?=
 =?utf-8?B?MXpueWtRaWNkUVhONFUvYTVnMDJvM2FMZ0I4UXFCdkZMbWdPYmZ3blo4MGta?=
 =?utf-8?B?RTd3cXpMYTQ1eStxNlA4RHJ4NFRla1JlcHBkUEV6M0V1Q2NkWUN0My91V3Iy?=
 =?utf-8?B?OWlmK3VSMkdjS1FIaG5HaExhNVJsUWQxVmNtNGtmNXVFUDk1S1prT1RRQ0p3?=
 =?utf-8?B?OGxCL3ZaMnlsajlETmJGY0p5VUpSNmIzU0VpTmduTXd4Y0ZTTHVxSGRsS051?=
 =?utf-8?B?MlZtbUc3Tkw3TWRUL2pxZ1NPYUtWWWhJdGl3L09uejdBcEVnTy9jOXVKcnIy?=
 =?utf-8?B?SGNzT2dTaDhoeTF4L0NCaVMzMHdINVhzNUllWC90Y2JKdlp6WjdTVVN2YW0w?=
 =?utf-8?Q?5rdQIBAgS5PrrjdDbQ0zRpstp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082fca29-8f49-4281-f5b5-08dcc424d457
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 10:09:24.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWVthzSGCFSplswwkHVJuUBujK8Jfhp2QSaEexQkHzLm5Kt81K6VoQzpOkF08Fkqb7WT6LN/n0YeSXCMvJY0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8149

On 23.08.24 18:59, Tobias Schaffner wrote:
> Introduce the ADDITIONAL_TEST_TIMEOUT_MINUTES variable, which can be
> utilized to extend the test timeout by a specified number of minutes.
> 
> Use this for QEMU targets that occasionally require extended durations
> for their memory tests.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml     | 2 ++
>  scripts/run-lava-tests.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index bd300df..ea66b06 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -22,6 +22,7 @@ variables:
>    ISAR_DISTRIBUTION: xenomai-demo
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    TEST_RUNTIME_SECONDS: 300
> +  ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
>    TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>    SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
> @@ -114,6 +115,7 @@ default:
>    extends: .test
>    variables:
>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
> +    ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>    rules:
>      - if: '$LAVA_TESTS_ENABLED != "true"'
>        when: never
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index 97061cd..0971385 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -38,7 +38,7 @@ lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}"
>  DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
>  export DEPLOY_URL
>  
> -TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10))
> +TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINUTES))
>  export TEST_TIMEOUT_MINUTES
>  
>  echo "Deploy artifacts from '${artifact_url}'"

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center

