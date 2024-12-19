Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC086343
	for <xenomai@lists.linux.dev>; Thu, 19 Dec 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618689; cv=fail; b=FmLwuMXHzjn6n/BaElnuvJOX48Ro6jztobDOkTwDv9FOxkLL3EAf5WQ9mRITJu9PA2G0/N2WI1tdEsCDpr3BPmQGaElgCFSL5T1NVDhHVp8GhyxADnIU3kruIfvczk+Wt5n3jPZoTm5fTqnCeytZMWocM2k5xtPsermgzQOyETw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618689; c=relaxed/simple;
	bh=V6jKyvSyjdSiuwQaC5Sb8lEkvnuEhkopW6ujJl6x284=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhRCl0EF/0op3bQUDOpDoIji0BszyJwdvbUEtJXM5yHWPUx8NYoHSKpMRRmM+wxebvE/zui8yh21GONcesc97XFgb0v5FI/Pj0WJd4MtQOs9bt24GUHHJkw+P6vIgQCcGhBdXs3CmlBB0jiCNaZwtL8++R0+spnbFebqT1CyWBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Cb7Wb2xg; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Cb7Wb2xg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkuH765+eEiHoqIFWu65PZGLikoh30JQiynWe4FXuL4A9DkrEXXz9lFw40lfvaN0nspEn166xod477ta+EEbIEov2zhzZSMbwXk6Cn1A7bKPtS1XTFt9uW4vG+Matw9hMckfgiTHHj+B08inTLTSZ6lZYraseAxcwaXlXNktXrW+WQesP6/oCOv9nQWt6zu8TElt+Iy8rqy0wvRgyRKHl8emgJDqHREzCwn0E5DXFkH7TCvCSAeFnq+kd8H4hco2rQzqulc1Pia/xO4YW0FU3DyklahaLQhmr7IhxpQ+wsKJQ/z0m41ktI38VXJQF8eBUSsiziw7BeDyW+zHYFhlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzZNgbbWVJAGmsfC5k+5f8BVzrN2gl+6ZRYiTzjZcV0=;
 b=XT84l6e1QJ38dbBjGqwVJMXFqaVjZwc+qecuGlCdTQqF5tDZCWfbJ+phD3zf6XUmwt91j2vFLsK42T0d0WKMTYOF2hflqKKP37EqrvnRpgvHlTPxaYtbVLX8M+xsv+MUIvEEjF+ydXy+DgiqxOfCP0lnjaeFi68RcGBiMEsTRaMcLJprH0U8zw3MQdba+dvckqFXDZ8YqnNNW1WQMMPyPa63FUjHMQ7ddG1DhMdWttldONzGaY9J4VNks2mXxnC6tCqdfctpnTD0uwdom7NOLrqVCRqMu+ZYUstOtlzuMNUcShYvK49AItLM1zcRmfjIS2kfTFwCY3wAM1UFx6nOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzZNgbbWVJAGmsfC5k+5f8BVzrN2gl+6ZRYiTzjZcV0=;
 b=Cb7Wb2xgA2UE11Px+w7eeAVjFVApF9tBL5/rzSO6syMuS78OQtZVtenhdN6IhFX92kvNoMFTpDsYkv+ZVR4DaS8kjhCqiI49WuCemR90RSVMamK5MTsqT19nXevEADMTK65DYhMzOJTh6E79bCd0l0BwoIts2C3QL5HkRfyft6g2Wj6patWiF6ghH80mrPoXQtbgOwzo1ZfcjozeZy8Y6q8W9bV4dT5L3RKnsv0cTx/5KXIFr7KLZik4EX8aLWW1kCuiTbwc8gVzFXEWF6f0nzX3N3INQi1kATbXxKgJ1Rt99FsX1XhmFVPDxD05YZqwRypMlAARv1XLoKieD/R6YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 14:31:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8293.000; Thu, 19 Dec 2024
 14:31:23 +0000
Message-ID: <7c009e16-9ce5-4e50-8a2b-cc216ffedcb3@siemens.com>
Date: Thu, 19 Dec 2024 15:31:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Draft RFC] Bring POSIX signal to evl
To: Qichen Qiu <ruiqurm@gmail.com>, xenomai@lists.linux.dev
References: <20241218122615.1974864-1-ruiqurm@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241218122615.1974864-1-ruiqurm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f39637e-5a97-4679-4ca0-08dd2039d02d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2IxWXBCeHo4TFlCK0J0MkVoQk9wZWFtUHJwck4vWUpDNWV0MzNjRlJnQUc5?=
 =?utf-8?B?TE9aZzROVnI0d0k5M0gvMklvVG13Tlh3cCt3b3h6RmtmdnhtNzU2bVQwT09p?=
 =?utf-8?B?RWNnYkg2S2FvSk9mRjhZRWxCeGVZN3pDL1gvYmZRTFdwRXRibDloVk9RVmZE?=
 =?utf-8?B?QTJjU0lhcmxtbUZqalhFcThyQ01RWEVWT3h1SUcyb3JjNVU4NUsxYklIcHV5?=
 =?utf-8?B?OSt2VGF0cWxzeFcySjh1NkZpbWE4WEVMeUYvVDdPZ3p1L1ZJaGw3NGNCOVFh?=
 =?utf-8?B?YWFUclVXanBtWkl2NXhhUjNsV1ZHL3NRVFo2N2VWczNZYzZvajFIYUMxcDIy?=
 =?utf-8?B?cXZWczBCcjZKamUrUUM5NE9xMkRCVEdqZ0xsMFdyY1Qra2dXVGc2WFA5ZUFl?=
 =?utf-8?B?WTFkcmxjQS92UVlveGhGNWpGalBta3ZyUTgzbHAybVNJWks0NHF0Q3RnTUFk?=
 =?utf-8?B?U3VUUmMzN2RtKzFqUEduVjFyM1BUOEJUN1B4TlZWdGU3TkhsZWRrZU1kWHYw?=
 =?utf-8?B?S2NXSFRiUTk1alBVYzQzckxlTC95TDA5WWNJNHNjODF0YWRRdmFkbXNsZHF3?=
 =?utf-8?B?S0hwenBldkhhcnRZb2NDeVBIWGxVbGZNZnFTZ24zYzZKUTloOGRIOE9mc1or?=
 =?utf-8?B?enB6VFQyNHd5ckJuRWw4dWs4ci9URGFtMGhhWUdoQVV5N2pMQ1A3bkVzanFk?=
 =?utf-8?B?Z1BsaXNxWlU5SUNDdkYrYWp2czBOSERETW80cm10UHo3dE9uTVhWaHBKRDM3?=
 =?utf-8?B?MnhobUE4YW1WdmprTzB0aTlyU1lNVzJ2bUdjUnEwWVJkdkVVSjhKUklNTC96?=
 =?utf-8?B?bzR3Y2ZPeGdpcmM0Q0FkditJNFpDZEZtL0UxdHVuS3RHcHVoR1pDSldyL2Iz?=
 =?utf-8?B?dnkvY2xSTURMWVZTbC8ySFVwSVV0UEpIeE5YdkNyVXUvWDE0VEdKT0Y5VUZn?=
 =?utf-8?B?K3ZvQlptM3hacG11aytzNHJTOUJzelRYTk5GOXJxVklVVG5NbVZJUHBNOWc5?=
 =?utf-8?B?TlVzUFlFRlcwemI3N3NJamNvQ045T3VKVTkraWd3dVhLTXoxK1gvVTJEclFJ?=
 =?utf-8?B?ZWx4ZjFnTjR6eE5Hb3ZpQzVtbDF5aVR2TUZFOWw0UEdaYUFnZDJmaXRublJw?=
 =?utf-8?B?K1pqb2xZQjFWSlVJakVDd1hKZHBNQmNxMmNaQ0FQUzVHUWRDbWRkZWlIN1NZ?=
 =?utf-8?B?Qm9PM2FNNFlIZG9tUTlmYmt1S2pEK0Y0ck1wMER0S3MwV3QwWmJFVWR0N0VI?=
 =?utf-8?B?VmphYnNOaS9nYmlWSWRFNGZWUE9Rd2JKeWZLYVl4NG1mdzM5RkRoWllSVUp0?=
 =?utf-8?B?clJTMXEreDZSRmE1d0NsSzJlTldzSGRSZVRqME9IOW5oTGdKajBZL1hJcXh6?=
 =?utf-8?B?L2w0YkFyK3ZlTVdORlpWUXJzeEQ1OG5LaFRjL1NVS0xkY2Z2MXl3RklET2Zu?=
 =?utf-8?B?QWdzSVo3My9iRkU0WndRY2h3RjNWTDZrSnFNZ091VlpVTThBNStFNGIwU2FR?=
 =?utf-8?B?Z093YkxKbmZNMU1kc01iM29JeTVkRGc5dzE5dDE0enhPelJGUGlyUHJHbWZR?=
 =?utf-8?B?RG9iK2RqcmVJZElrTU5zd2E2S1hRZVJaSnJLeW91WXVQTlAwY2dkUzRsOVhN?=
 =?utf-8?B?cnlNN0U0b0VWS0xYb1BIeUEvbittNS90ZFZUUDlVa3JDU3pVVGxRTWlrZ2h4?=
 =?utf-8?B?Z3UxREZSOHp4a3hZQzNqMmZ1cVNSR1k0dzdhZFlYMHRjalNNaEZQRkg0TEEw?=
 =?utf-8?B?aWNONEF2NGlkVEd0c3U4cG1wbUYySDBpdnM2VVk5OVduOStsTDFRd0F0aDVF?=
 =?utf-8?B?aHFQcDZza0xrbGJvMWhBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJxWWtYVE0vQUxiVGs0QWtQVURmUkQzVEFFNDJBZXdWbjliUXRRYW0zU2Rm?=
 =?utf-8?B?OUhkUGNjaGt0M1h1RjdGMlY4QjFyNU9JbXZDSDZkNmNIaU9wTXFzcFczSHNt?=
 =?utf-8?B?SXZvSWdleHY3UE5ZNEhSbmVqYkQrOSs3bGNlUkRzYW5kVWt6QXR1cnIxZWl2?=
 =?utf-8?B?Lzlmc2FIQnR3MUh0eXhoYkNxK1l2WldKUGE5bjRYMC9xQm9teHBkRWF2NEJD?=
 =?utf-8?B?UUlkODJrL1VualhJUEFSTy9HT2tDVzBXV2dBQVMzeGtHOTBNem94elNxeVV2?=
 =?utf-8?B?T1RpN01CelpKM1E3T3gzck4xajJwRVZsd2ZtWWhOMkgvN0h6aTFYb005U21H?=
 =?utf-8?B?dENtbjdnT3dKeThlVi9HTjVPRTVFWWhGcFJaMjNqUk9ZZElpMnJ1a2hYcHFH?=
 =?utf-8?B?WWh5cTJ4ZUtCVFB4VVV3NFM5UDhocUpaSkM0Y3NneWdRN0M4Y0c1dzJJUHUx?=
 =?utf-8?B?a1RDRXczS1piZWtkRzNqeWZoOC9xeWtPbkRxTEdsb1VvOWtsM3hIOWVGYmJV?=
 =?utf-8?B?eHVFM3ZRWUQ4VllSeHRLbzdGTjdoWU1MS0tYMlNod2VEUWdKc2F0VWdPMHBM?=
 =?utf-8?B?UlhQWWtyMlF2VVZVVlVtT3U4dFI1V01zMVRyS284K3NUblpGQThQWHhZTHA5?=
 =?utf-8?B?Zm9jUUhteWVnazhLZzVpWm10WTh6TmdxdE1IZ1VRU1VJajgrc0lhSytkT3BK?=
 =?utf-8?B?VDkwK1B3aDhxMkRNMHlaR1pVNlBIWnFwMmdvUXVKc2dCckFpeUVHeUhvSXU3?=
 =?utf-8?B?a2N5eit0SFptRWhhS2tpV2FiUFN6WFVDSnhFVWtLZmw1TnpyZlJ3ek1FbVVZ?=
 =?utf-8?B?VFh2RlYvYjRSZ0MreThORGVvMTE4V0RIZ1FObjVYZU5LVnFZeHFnYm5WSzdF?=
 =?utf-8?B?ZEFLSDJCeFR6dmhIb01WaG1adGt5b0c0UjZWWHFRcHlYZG5SSGlYc1k3ZTBE?=
 =?utf-8?B?SGsvUVdiVnlzaVVPaHRoM1g4dll2eHo3Njc3OW94ZmJnV0NqQWxCUHczQWpY?=
 =?utf-8?B?WjcvbDRSOGkvSFMwMlZDellwdzd1UGZpMkorRmNtVUZIbUtIVlgyY1ExaUVZ?=
 =?utf-8?B?NDVxSlFMak01QnFMdGcxWFdKMlRSczl1ckZIajRZZGNpL0dDSWttckxiV0sw?=
 =?utf-8?B?MHZrTUpYWWFKWWtyTXZqWlFVU2g3L0REQ3lTYlJyNHBacDZ1cUh2T3p2Vkox?=
 =?utf-8?B?TlRUVlF5UTBqdmtrRU85aitmTnRIOVp5UEp3OWxQcjI0c1pyZUlFdmhDVjY0?=
 =?utf-8?B?TXBOQ0kzalVSYVVyZm1BSUljTUVJdmtLUHpwZmY1UFhyMGkvdmVlU3pYb2dK?=
 =?utf-8?B?MnVCbzFqQ3dTcVpDRU5ndk9tRFl4NmhjU1Rlamg1c2M3a09DREVTc1c4V0M0?=
 =?utf-8?B?azRINWFrcThSaEp2Zml0ZmZyRFdIV1RmWFBDU2UxcktXQlFZU2l6azhpMWdm?=
 =?utf-8?B?dFVXZ3dISEpYa0dERWJiOHM1SW9heDU2UVYzeVdRakR5VHBDV0xtTTYrZEZE?=
 =?utf-8?B?NEpRNWk1Q201Q0NDbCtYNC9RME5lMDg2RGN2blNiSW42N240dmZNaHNSdGN0?=
 =?utf-8?B?b2w2aFVEV0tpczNuQ3hzM3Vlb2Jhc2ZYMStpR3podnl2eDJiWVIxODY1STc5?=
 =?utf-8?B?MHhOdTMrZjVBOExYbFZqT2VxOTVKS3JjU2dZb1VLMHlMbnNEQURzdkVYN1VG?=
 =?utf-8?B?a0pKVHlVVTN0YU9PQk9zb29MSDFTWW96TnRrVXRRc3l5ZVl3dUpNQ1c4aC9Z?=
 =?utf-8?B?QU5VRWtxd2I1RkNqeCtLY0lBVXVPczQ2Y3d4MnQ3dmV4MjJYM05UV1NUeXNY?=
 =?utf-8?B?V3NXdTQrR1FQNzdPSUtTTDZ5UDNHalVkNjErYlF5SXZzWk9QSnh1cysvZ25Z?=
 =?utf-8?B?RkRGbXNaaVFvQmdWVmZZV2VyNEhYZmVaYU1Nd2YxUFAzTWlWVHBRT0hkRkFR?=
 =?utf-8?B?QVNWMWg4bTBWcERrSWF0RHIrWW9oNWt5S3lNU2tQSnJwSTlMekJJSVh6WXZI?=
 =?utf-8?B?MHl3d3BoRS8yY3RUQlJYWVoyMTByVjQrRDNIWWpzSnBxdTVhLzl5WTJuS1VD?=
 =?utf-8?B?aUtQMU1kdEY5Qk5oZVVHNHFKRWp5RzdHQXROWjJ0Zk0rRzFENGs0WndPaTV1?=
 =?utf-8?Q?Y+SiQsnjOuohctR3FFR1GSuoV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f39637e-5a97-4679-4ca0-08dd2039d02d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:31:23.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/nyFddsvhDOvfXTlVrbakuJrbhOrkDijrX7igU/QH1nV3IEANGAPlHgdJkmLrJylz2HJoV2pfV9KUPoo88i9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6100

On 18.12.24 13:26, Qichen Qiu wrote:
> Hi all, 
> 
> Currently, EVL does not support POSIX signals. To better align with 
> Xenomai and Cobalt (see the CXP [1]), we need to add POSIX signal 
> support to EVL. As far as I can tell, there may be two potential 
> approaches: 
> 
> # Approach 1: Adapt the current flags mechanism to POSIX signals 
> 
> EVL offers an alternative to signals called flags [1], which allows 
> sending a 32-bit word to another thread. The flags mainly offers the
> service:
> * use `evl_create_flags` or `evl_open_flags` to open a flag element. 
> * use `evl_wait_flags` to wait a specific bit and evl_post_flags to 
> post one or some bits. 
> 
> The mechanism is like a POSIX real-time signal without queueing. 
> However, there are notable differences between flags and POSIX signals 
> that would need to be addressed:
> * Signal Capacity: Cobalt supports 63 signals (excluding pseudo 
> signals), while flags are limited to 32 due to the monitor's design. 
> 
> * Initialization: POSIX signals are pre-configured and require no 
> explicit initialization by the sender or receiver. In contrast, EVL's 
> flags require users to initialize and open them manually. 
> 
> * Target: In POSIX, signals can target either processes or threads, 
> whereas in EVL, the target mechanism is more limited. 
> 
> * Sigqueue: POSIX signals can carry additional data (sigqueue), while 
> EVL flags are restricted to 4 bytes of payload. 
> 
> * Queueing: POSIX real-time signals are queued, whereas EVL flags only 
> store the most recent signal, making them more similar to standard 
> signals. 
> 
> While it is possible to adapt the current flags implementation to 
> address these differences, I believe doing so would overcomplicate the 
> existing mechanism. For this reason, I prefer an alternative approach: 
> migrating the Xenomai POSIX signal subsystem to EVL. 
> 
> # Approach 2: Migrate the Xenomai POSIX Signal Subsystem to EVL 
> 
> Xenomai implements a signal subsystem. For each Cobalt thread, it 
> maintains:
> * A wait channel (sigwait) to sleep and wake up while waiting for a 
> signal. 
> * A sigqueue structure to store pending signals. 
> * A sigwait_context to hold the user-space waiting context. 
> * A field sigpending to track the current pending signal for the thread.
> 
> Philippe once suggested that the new POSIX-like API "would be 
> implemented as a separate driver using the EVL kernel API" [3], meaning
> the POSIX signal support would be loaded as an EVL driver. However, 
> since signal sending and receiving are per-thread or per-process 
> operations, the signal module would need to attach data to each EVL 
> thread. This integration seems challenging for a standalone driver. 
> Instead, I propose integrating the implementation directly into the 
> current kernel. 
> 
> Before starting work on this, I would like to gather feedback and 
> suggestions from the community. Thank you for your input. 

Going for a careful extension, even of core data structures, sounds to
me like the best approach as well. Just also keep on eye on the ongoing
efforts to use posix signals to deliver synchronous fault events to the
causing thread in RT. That we would love to have with EVL one day, too.
It should widely be orthogonal to synchronous waiting on signals, but
better double-check.

Jan

> 
> Best regards,
> Sam 
> 
> 
> [1] https://lore.kernel.org/xenomai/87mtyr1abi.fsf@xenomai.org/
> [2] https://evlproject.org/core/user-api/flags
> [3] https://riot.im/app/#/room/#evlproject:matrix.org/$kFRgs7y48Qr0033GNh-sDnI7GUrrp_mo-OEhDI0GAWk
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
