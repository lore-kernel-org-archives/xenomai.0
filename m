Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C4331226
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233079; cv=fail; b=qlT/za2Yy+8R1LBumSRWd3rcrXGkb+DCYqouVKa0qg0oVNEyraq4lqVzN6JE04Zw+QfLKRAs5R6dz9N773HqXQc3NUZVg9RJwt4lacH/OxwlR/Q47Yv0aXiG3pC4YC3dG+4bfzc2TsRwoYAwoBs42MyYpdRwZePo7qXnZzJzGMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233079; c=relaxed/simple;
	bh=6z6WooEfk+SZH37Xof2mIk5UGyeRb1EJ4uwql+VLXiQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYOj1rH+1qiUHlkWJAw09EcQ1Cz0kXWaRfrhZvuCMUXWLdSTtWCWNdK1Vd11I1urUrREoUUYnI9BTT7N1wmiXD/gzomCogb3E5ZaItadwAsshEDrROm6DJK2+ylyzCcmjtx5EUi11J2YVBo0lUjoTOycuCYgezbbXjhel8YiZWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nDYTt00C; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nDYTt00C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSFlwaYRR9w0uPr9+QJcRJCq1tmdBCVUigihF7Pwz1zr/mXDbl4K+l7kZ01KM30KwMajrSsDRxZvpDQPLN9c1tmNUlGaOm39ML/o0B8blrSulSj21PShtOPyCcvkR3XEBhVatLoWJYc2daSwc1tIoyvADP2oPe8SIZZmMf3XmPt9Hv/RoY0R7XWLbGeoFQZQNtqZoOp/QXIKtfeQnyT7LJteiV+/c/r8WUghRIIkdds4gxcI+4YbHuuNLNM2dWcgqgZMxkgE7+FAwB4287GYv8v5w4yjG3ItIig6I634TxQ5qx5tv3E6WbdJ8OCjNj8KxDDfra7Re1kkmD/HEZ6OLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPzjuXNsbP4SCWRLxuOb0oOlw3UJ45o24SIrQuFiOxE=;
 b=b8W7R8p+jLgfAJ3ohwIlgrg7AlGPIufnbx2gwT/+w4d7SeW3qDkJUsuGp52ii9jRgi1tLrKN5jh10miSW5+mZkW7OPUPcDizrfFQGFZRS4y97p18Bm2DVTprqxzoqJUfIaYG1wMDZpHkFV4rAibw3NYhFf+6GBPSRKl0/cJPmsX7Gw9aIOHzMIt5iKzkojXkiZV3x+mlZ+lBqdSMwwVS86xUlorRPxRBwa1leQHgMlJOYCTX27C0eCJpusH1r7QhAcy43rmOI0+NC+IEG+TC8Y7gafweWJA5qFM4TwUH1bYq3LEwLccwOGoneDnkrZpryn4Y5zYSq8soCA3G3cHgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPzjuXNsbP4SCWRLxuOb0oOlw3UJ45o24SIrQuFiOxE=;
 b=nDYTt00Cgi9e5RQSVJtXSRY9iYOYmtKfD4AqQW/WsKtxZJ0RU/X9ryXcMbRTzTAqCjoft+ADQd+zvk0HnRP0nSD3ur9Rrm/waRDlXlkRl3bZLK6B3ZUHf/Sw5IqM9BtUIN/01mE20vuQdUWwljL+zYo0hRHBUei0gbWWHX1LTqgfPj47zXcK+grQw5nqoMydGGQ2Hrsz+3pYclQ++1e42hBKn2riC84gyY165aGKdOLCvhKqmiNe17auW+7Sj40NyvdhrKU/t0S//Qx7dwEI8PfN0dL48BVQhEr74eHIEncejKs57vCljtJw6mmrFisSdRT+pDGpdeUPvTwjOUPfQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:51:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:51:14 +0000
Message-ID: <6bb6c04c-bffb-4f9b-8ddd-0d713d180bba@siemens.com>
Date: Mon, 12 Jan 2026 16:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
 <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
 <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
 <b7273fbc764ebe2c5b40b2c1285a0ea56324caee.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b7273fbc764ebe2c5b40b2c1285a0ea56324caee.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 599fb720-58e2-4cc2-20bb-08de51f26a2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QksrTHlUQ0NaYWs5NHlrYSs2MnIyUUZBTmFIM2dsZVRQcHhGekFVNGc2ZGxB?=
 =?utf-8?B?YnZvZ1FuY3VpaEt0MGlCb0E3RzFLdGU4Q2VNc0dzUk9uOUhlZGQzYTZFQTJp?=
 =?utf-8?B?VzNMdmZjWGhLMHNuQTFKUzZIRnlFbTdHTEZlVTVEMzdQWG9id3RnNFVidjhB?=
 =?utf-8?B?V2FaVGszYjRjZlVIbVJzTVpSNjZZR2U1Y3E0TlY2UXN5cVpxZHNJMzZkV0JN?=
 =?utf-8?B?RTgzSExJQlc2TEU5bmUrcmVSOTZpTms2THJxOHM5NzFvMmRmSzZlbGZvT20y?=
 =?utf-8?B?c1VRQUZXdDI5allvYzZabFYzT3J0T1J3cWZMTWVzWW9scVVVRS9SVkNDSTh5?=
 =?utf-8?B?WG0rSGVwQWMzeWdIejJvelMvQ200Y3pnblhLZ2VYaUF6Rm5vSTMzMU1jV1pK?=
 =?utf-8?B?NVNmamtPMksvV1JyZUQvQ0hWZUtIMmhOdElFSlhyZ3JyTUxVN1VVMHFYTjY5?=
 =?utf-8?B?VnVLeXc0OVFwVXp3OFlzUmVNT3ZuVG9kUXM2ZjF3TGUxd1ZPeHg3d29ybDNP?=
 =?utf-8?B?eHdPWjF0SkJybGpOL3dNczBBOHo0L1NOZzRFMWZBZUlMMWdQWnVHV1RqYkNI?=
 =?utf-8?B?SkpySjlwWTE3YXRNRkNsalAzNnlZbGdVaElrQ1pkTEZIclBCZVdrODIxTGVI?=
 =?utf-8?B?bVArNkVINHhWZnNHQ0tsT1N3Uld0eXpZNk9Ob1lzalZncitiU0s4UnFjQTRp?=
 =?utf-8?B?cmRWdlRFelpXTFpuOHdxd09KSUFWdVBDWnhFWFM5bndDWjNoS2U3d2J3OHlD?=
 =?utf-8?B?MEVoV00yaWpIUXQybG1iVktPZDVTZkZVT0VEcWZSdjgyYnQ4OXh2bkV3QTVm?=
 =?utf-8?B?R2FNS1pRR1hqTGljejV0T0h2WUJSbWxDMUtTdFl5SkpuUW5Ic1pVRHlnSkpv?=
 =?utf-8?B?QzlzZW1ndGpVWFBqRTZOd1JEa3EvOFcyeFoyZzV2VDRGZzZkZDZpRUJvZmtM?=
 =?utf-8?B?S3dFelpWTUFmUVkxbGJ5UEJjaWxoOVVhUjNuM21PdkpHUW5uaWFVdWdNRytK?=
 =?utf-8?B?QXFIRXYyYm1pZUJRRlEwYVVibXdnSUVvdzJ4T2tsTFA3WUNyUFFTdm12c2x0?=
 =?utf-8?B?RzAzZ1NQMXNBZ1ZTV3F3NkxzRFVNVFhRTFpYZVovQlRMUWZWa3hYNlprd2p5?=
 =?utf-8?B?Rlg0anlMdElqT0tPY1JOM0dURkNQckZUd1BVNGp5WWdJVHFCSE1VZ1dtcXpX?=
 =?utf-8?B?SkZKNjV3WCtodm5Felk0TVArTEMrRkRveGYycUtwTC9LMFRNOWp3TWRmcG9M?=
 =?utf-8?B?NmRaNWFibjB4NUY3U0hSWHRzVm55UGpkNm05bndjNXRieWNQa1dKV2RYQVFv?=
 =?utf-8?B?TDI3bFRjNStwVVpVVjFOSW1raEduOUNyOWFqdXNENGN4ME9HbXRKMTdUNjVE?=
 =?utf-8?B?K2tMbEp3ZmlEcnNETWlma04zM2tzVEljcjVVUEFlaVdWNngzK3lENWNmcm0y?=
 =?utf-8?B?NTQ3bHhXN1JHL0JqVHNOKzdLN0dOTG9kMTZ6TVFmcnpUV2VISVAyanY1VEhm?=
 =?utf-8?B?aUl3RzZkbTdJc2ZuSG4yQ3pNNVZYOVlPQzIxYkJQeTBvS0k2d2w4bExTMlVw?=
 =?utf-8?B?VXhDVi9zenFPaW92QzdjS09oUUtUTkZ3dEhZUldKMWgxWWQwZnNGbUROZzl1?=
 =?utf-8?B?TVUrVUJjMVhUOEw1aTduc1NZNmw2MTNxK1hoWGNESERwOWdia09wU1F3VnFZ?=
 =?utf-8?B?TmVLN2trMmRINDBkS2dHNGNJQTJqdjQ1WHZnd25FS2Nnd2MyYWE0TCtBeWlD?=
 =?utf-8?B?OGFybWFXVmVZUUx0aXRqaFFyVkVFNjRmKzE3VTRBdmdCcENPUC96c05yQWYz?=
 =?utf-8?B?WUREMTVFUjVsZWw5VmhUOWdWdjZ4Mnp1WGlLR0F3Q1MwREVoS3N4TzMzTFBG?=
 =?utf-8?B?RkFGRnFiYTYxV2lhWUpUc05YbG9ua2h5SFplUStpN2hHSEZHR0l2NWZNaTY5?=
 =?utf-8?Q?X52SgEIuoWztKreIEBc9NCIQ6wVkZTrs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy94VWtVMXEvSTM3a1lLcXJyTEtONU0xOGZ1TjAwL1VDMm85bFRwSjhLWmF6?=
 =?utf-8?B?YXRkWG5EL3F1a2k2TDJoeWhDUjdIaVJmUFJBUjNURHRmc2ZEYU1lczQ2a0Zq?=
 =?utf-8?B?MXl5TkRQQjBaSE1JTXNMektKTmJ6clhJVzU3NUdKWUVPZ0poZDNMdjVWMnpt?=
 =?utf-8?B?NURRcU8wNytEUnBCZ2ZQMHdnQ3NlcThaQnYxV1U3S1hSWXlLM2FMZjVPMWJK?=
 =?utf-8?B?ZWw1a2xnT2o4YXdCNFVuZDdPYm5OeS9KV3ZRU0JQaS90NkRIVGkvd0F1WGdD?=
 =?utf-8?B?eklMekJFYWdjaGdrSGRKa1p5M0lZRVY0RWFMQ0xLR1NLUEVpZWdIcG0rQ0Z6?=
 =?utf-8?B?UlJRZWtuc1E4S0N6UEROQWdKcXZMZ2pEWEdwM1hEMlJKTFVjNDY0VThOak1H?=
 =?utf-8?B?a0FmM2djL1pldFhqUkFlOHI1b2swRmtzQTlVNWoyMGE4aFNubVc1TnZSMHk4?=
 =?utf-8?B?Q2x1Tktwc1VIZnZ6a0dQbE5qWEpCWEFPZVNCamtPZkVZU3AxRkdrbzcwdURP?=
 =?utf-8?B?V0lvTlg5TkpmcGk2MFpESTNSWTZkRmQxMGdQcURuUWg1VXAvSXNvTy9FOGFP?=
 =?utf-8?B?WVI0NDY2bks3STVaMmJ0V0lMQzE3RDJJVlFkR0xLYWxmd2xldHdEZFhYTHMx?=
 =?utf-8?B?L3dlc1BEY2lQa2pIQXoyeW5ZVXVUTkNkT2ozMjRUd3VPdlE3Wm1KL0NObFVM?=
 =?utf-8?B?Q2hCN3g1UVpVejZ0eEUwcUt5bXBaWFA1OFRJN1FtYWc2MUVUZTV1ckl3SklS?=
 =?utf-8?B?VGFaK0dxS1dtZ2pJN0tKS2l5NHJhZVUyTjVzRFVnNEJSM2ZyRm5tdG1FMWpD?=
 =?utf-8?B?Z2ErSFRmME5ISW9IYUg4SzBSMytseEJjdXl4QnZmZ3pyNUJGNERzUkMxRlZ3?=
 =?utf-8?B?aTRLS0hCK3RxSGN2TkxZUEtiSzRtclVOQ2ZSZ2thR1lhY1JXc2UrcFV1Rzdv?=
 =?utf-8?B?Szg1L2tLMXF0SHUzKzc1RXovRVJ6V2Z1R0ljaFZqQ1ZjSU1MbzlYRVR6dkU0?=
 =?utf-8?B?Z0g2YU05cHVnbTFXWS8ydURwemRDL0VIVHFEQUNsVldaQ3N3V2NFUkFnR2xK?=
 =?utf-8?B?SEhKWkVtV2w1cnRMWXNqYW9uU2NFUThHQS9wb2FVT0d0Q1VCMkFZSjBJY0FE?=
 =?utf-8?B?TDJwdnR2VHNBN3pHNHovWFZUQ0ZRQ1ZBODQ5RTBTQkxzbkZSdkNub0RBVUdJ?=
 =?utf-8?B?L1VkcDltQm54dUhvQzh1ZkxIODFma1UxSWFFeXhqSndqUElpelFjM1c3M2tE?=
 =?utf-8?B?N0EwQVFUUGpkbFVUUFo0bjBTaWNKSHdXK0lhd2RHVW43c01uWGluRzBiaTgy?=
 =?utf-8?B?RWhjME54eE1sYlg1NHJvb0tOaThlUk1Xb0V4dmMxREVBdUxvTUsvOFF5NndI?=
 =?utf-8?B?dGNoREwvWk8yUS8wYVlzSzRqMHdDWTJORzZwWkplU3FRZE9wYzhwaGNDdmNN?=
 =?utf-8?B?Y1NUQUVFMUpoK295V0RmcDdWbm1xTk5HSkR1MVdJcGtWZWhDOVF4T1lZWERa?=
 =?utf-8?B?Tm1uV2UzTWk3NnhSUkZVUDdEQVFUY2NCWFB6Nk9ER1dNWUdyT0VJQllMZ1NE?=
 =?utf-8?B?MllSM3VZRVkzUEZTRUtjT0cyWFNXZ21BTk1HTGJoTVJQUUFyNW5kT0hseUhj?=
 =?utf-8?B?cUNGN1ZkUnJENVVWWGs5OGQ3ekN5S3dWTUNUMThHby8yZ2xISGtydklwZnRH?=
 =?utf-8?B?RGFkdkZ3Mk5ac21QbTVrenJpR0lHQlpMM3cxZ3VlWS8xSlp6RjQzTjZOUkVP?=
 =?utf-8?B?TWR0aEpLK0lSTUJFQWExRWo3R1MrS3A0N2hZUXU2NlFTS29GaFRXTVNvQ01h?=
 =?utf-8?B?NzMxQ3RzdWNkTUhwMzhEUjdxZHdLdzA2QktsTzBVWmg0VExkdjZuNXd3SStj?=
 =?utf-8?B?bHhMdG43Z0k4NTY4aExzN0ZEMG0ybzFTV3QrKzk0aXJJNEdickZITFIrMjZ3?=
 =?utf-8?B?amViWjdvQmM0MU51ZTdvcFN1a2x3dnc2TUhXV0U0bGk3MDVUYkk5eGdNMUdi?=
 =?utf-8?B?YjVEajVEaHI3Y1J5MDgvVTFzWG5hSEVhZGFNc0w3cy96bFpwV0xwbjljYjFm?=
 =?utf-8?B?UytFeE5kYTlTYnN6U29pVytHYU5kZ1pVVGJFSitEb2N3WGdOV1lPeGJpWjdl?=
 =?utf-8?B?MVJpOUhQRE9SNzMyUG9NK2FrQ0VpUGIrSWFKNjdGdTErWXhnNDZzZ0syenBr?=
 =?utf-8?B?WEVqa2xRTTUwMS85RmFVdDlLcTA0czEvZmFvSUNER2dEVG5iV0d5ZGNrRFZi?=
 =?utf-8?B?TmNxY24zOU03OHoxNjVjNnlHemdQUEk0eFpkWVd4SE1wbHFzUlExcHVkQ1I0?=
 =?utf-8?B?OHN5TmhVYzBpSEEyNnUvVkxlcGdndmRBU3pkYzM2M1hSQUVDcmorZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599fb720-58e2-4cc2-20bb-08de51f26a2d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:51:14.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZiAPCbccpP9lmoveQnjShCQRX5XgGINXv5S4bQyZjhl1OyQYt6JllOOPLVAajyIHaQeIaQCMc0i+mITjJCNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3705

On 12.01.26 15:27, Florian Bezdeka wrote:
> On Fri, 2026-01-09 at 15:52 +0100, Jan Kiszka wrote:
>> On 09.01.26 15:42, Florian Bezdeka wrote:
>>> On Fri, 2026-01-09 at 15:20 +0100, Clara Kowalsky wrote:
>>>> The linux-dovetail repo is configured in the CI/CD settings to use as
>>>> configuration file this file in xenomai-images.
>>>> This adds a CI job for triggering the xenomai-images CI if new commits
>>>> are pushed to a supported dovetail branch.
>>>
>>> What is the overall goal of this series? To trigger a CI run if one of
>>> the LTS branches moved forward?
>>>
>>> If so, is there a plan to clean up all the branch specific recipes?
>>> Keeping them in lockstep should not be necessary anymore, no?
>>>
>>
>> I can't follow here. What exactly would you do differently?
> 
> Ignore that. I thought that we could remove the kernel recipes
> referencing a fixed kernel version. But that would break the "build a
> reference image" use case. See below.
> 
>>
>>> In addition the gitlab magic (uncommon project configuration to point a
>>> project to a CI configuration from a different project) is completely
>>> hidden. The file seems unused und might easily get removed. There should
>>> be a comment somewhere explaining that.
>>
>> Good point, can be done in the file as well as in the README.
>>
>>>
>>> I'm also unsure if we should really move that logic into the xenomai-
>>> images project. Seems a bit overloaded already. Maybe it's time for a
>>> xenomai-ci project?
>>>
>>
>> xenomai-image is so far the project driving the main pipeline that also
>> does on-device testing. But there is also CI in xenomai3, e.g. A
>> separate "xenomai-ci" project would sound to me like all CI is handled
>> there - would that be your vision?
> 
> To me the purpose of xenomai-images could be split-ed into two parts:
> 
> a) Build reference images. Images that get you to a working starting
> point within seconds.
> 
> b) CI. Build all the kernel/arch/userland combinations that we need.
> 
> The b) part is getting more and more complicated, which might confuse
> users - especially beginners. We have a lot of bitbake and gitlab-ci
> magic. At some point it might make sense to split those different
> purposes into different projects. 
> 
>>
>>>>
>>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>>> ---
>>>>  ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>  create mode 100644 ci/ci-dovetail.yml
>>>>
>>>> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
>>>> new file mode 100644
>>>> index 0000000..52685e6
>>>> --- /dev/null
>>>> +++ b/ci/ci-dovetail.yml
>>>> @@ -0,0 +1,43 @@
>>>> +#
>>>> +# Xenomai Real-Time System
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2026
>>>> +#
>>>> +# Authors:
>>>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +stages:
>>>> +  - set_vars
>>>> +  - trigger_xenomai_images
>>>> +
>>>> +default:
>>>> +  image: debian:bookworm
>>>> +
>>>> +set-vars:
>>>> +  stage: set_vars
>>>> +  script:
>>>> +    - |
>>>> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
>>>> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
>>>> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
>>>> +  artifacts:
>>>> +    reports:
>>>> +      dotenv: vars.env
>>>> +  rules:
>>>> +    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-dovetail-rebase$/'
>>>
>>> There is no 4.19 branch in dovetail, good old ipipe times are (nearly)
>>> over.
>>
>> Yeah, we may also skip 4.19 for now - or forever. The exact EOL date has
>> not been set, but I already warned about it in different threads that
>> all users on our end migrated away by now.
>>
> 
> Hm. I think that the workflow is broken. We need something like -rc
> branches for all the kernel versions.
> 

I'm using the -rebase branches for that, and I think Philippe as well.
And that is also why we are picking them up for the triggered TI: Even
before there is release tag, CI may reveal issues - and we don't tag yet.

> If CI reveals an error for one of the branches it's already to late. A
> public branch has been forwarded, so we can not revert / restore it.
> 

-rebase branches can be reverted, restored, well, rebased.

> The usual workflow is: Push changes to a -rc branch, run CI on it, if OK
> move ahead and merge it into the "release" (= non-rc) branch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
