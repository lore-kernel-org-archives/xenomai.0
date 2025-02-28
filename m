Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1016E276D3B
	for <xenomai@lists.linux.dev>; Fri, 28 Feb 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733893; cv=fail; b=jwhJspBVwf+kQKE8u3nja136KZqGePt+SJ/bEhQD1qQrzeN41G6eZsZUgRvZw6pq7LAsQaD4JQvq6QNQE+MQjtGNb9IeLkWYTEKyiCZahr4eFzSeInBXKB+3c5r9RDgAyxJfXJ0p5qFrzh6OV2ZLpmJzsQv9j8A2EITzlH3IIRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733893; c=relaxed/simple;
	bh=fCz31uHBwJyM1ONeQSFawhJgWEE0czDTcjWJlqKsgBo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir+shKHXE6cNiUtlJ0rRUY5OTN74b5vOz0mNDuI3p3QmjzzFOMPLPF8OgBp9JO/ht8txD2g8cPN6VuPUAJU7So+3J3vaeeXEY9Eo2EcDF+Oow2+HTElvtn5NAQxdnr689OUnthkFGKtCpcc/ITpwU9eYsYhTXRBGom5SLz4J5kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FYSAxXFG; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FYSAxXFG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1L79T5q+t8J2doBPI1QR5oKY6tKSKqXPFCkzQE7WFqsgYixI+nMa3tDv30pChSbamdbE3pcSn3NT6z6gnvQV7PtqXquxi/vl29enzCyLJaStQ+g9cqjOh7MgxSCaa7gVDudB+eC+7b9jyTJdocQBTZP6mWmB6HxJTPTzHafnW5Yuajbulm71kdUS7l3K9wBdAU/U22eFAJbvHcuOcxrM9ywWEbl9eu/mFom2M6rAn9TV9auS2+8WCj/VslA0zrkFYZ2yYAFXq/a1G/2qVSu+Vm5pqnH2g6qTrCv8B3A2e+pXTjmyXbtm3Eudh7CIctrkA1XP8m4VlJRWR/plBvyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyGzSYAggA/pZ2mByuVUBmdAu5ixE3s3V/JMOTxeJeY=;
 b=Sf3+cj/25xBNSNnnWsS3h9KyYrBPYXAA5FgU/kthNjSNiASTtndLtMZCXMUO0MVBrvfY7CW1502eC1DlGhY04RoZNr+emF/c+8wvWIUH8icDCBOzyBSctsYDtKbK2XC4WgMYiZkCBliIl+eDSsT7OK3l5ifEOlFCOyj1qnVBivrCEQ4cxhOrVWpc6Du61htVGKjDzPZq78YLkUCUOxzuV3clwpoX7lamNwkaISHNWFv1yp4Ob+bGddA1sAr8TBQuMTnA1JLVKJk6t7u4gHPGgEkT69ukspTNGLH+Rd+e0i/Fhpmmka3JZtAOgveLYRVuoVm+FckyBipvIDEWHLIx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyGzSYAggA/pZ2mByuVUBmdAu5ixE3s3V/JMOTxeJeY=;
 b=FYSAxXFGssndchkhdsmT06itYNz5981vsCU+5r2MyxeA/DYJrbiUauhnX2k0hCXCwxK4zoIagsSNbfYNRMLo1nkCDeiw+hdL24I3YOM0Nb1BXAqCL4bPUSN/SoL6Whd3qJa37eR0kPULQDx7I9TPL7H8dNxRzxKoVJjpVgK/K5nv+k4rmJto+3rkAjoB7Dbq4/lrmk1Ipg8+6ti/axs0dRHEjCgbzxOr7RiIfAu5+CH5KqgKEC203SabX/EgDBhlB2I1Low293QGjV+LnPPtgxUoV57l5Gfz1+4dlukKTljFX50L0R6OXtWT3nClGo7FD9Er+qguPFFCrnEeUvCgKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 09:11:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 09:11:27 +0000
Message-ID: <93366cf9-4685-4e11-b298-df52e780a8a5@siemens.com>
Date: Fri, 28 Feb 2025 10:11:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Xenomai 3] recvmmsg is broken when using timeouts
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
References: <89fe268d-f404-49d4-8106-c1446e1d81e9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <89fe268d-f404-49d4-8106-c1446e1d81e9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5194ef-0c16-481e-bbde-08dd57d7e176
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE55eFkzbGZhRWRjRGdWTUhheXk1ZGkrRmpMTURFTG5mT2ZyRDZWcktRa0ZQ?=
 =?utf-8?B?amtpa2xQbGorWG1aNWFSUkxUbGxGVmlRRjZFdEt6MUhYeTg5Q0ZqQnRURzkx?=
 =?utf-8?B?R09HcXNIeWxjSWRreTB2MDRlcE1IVFZkaXpjRVBnR0ZaWDFBWHFMaXBISDhX?=
 =?utf-8?B?eUNZVXNVbnJuSEVFdHhhK0lnclg2SitOa3FjTjF1SE9BNEdNZFlFTkViL3dQ?=
 =?utf-8?B?TXU1V0VnM29BMU1EWkFrSUg3YUpITFpRYlZ6eVVqNVR2NFFoUExVWVE2M1du?=
 =?utf-8?B?aGQxNVY2SjRLTHpPME1mNnV0Nnp4QzAwUVFjS0RCaGw5N3NpL2wzYis3TSt1?=
 =?utf-8?B?dXA4ZFJPaW90OE5wdUgwSU9DZWhQcGdyUS90OEtPWHc4RVNJOEt5N3QvNHMr?=
 =?utf-8?B?Y2FTbDQyMUtScUZEeTJsbk42NEFlUGU5Nm83T0U4am1sa1JtSkx5Vm5oTzhH?=
 =?utf-8?B?cEdSNzRTcTVvbDRPN21NOTFTWFN1Y3Q2YjdGVzhCZWVESmZ6UGsvdzRIUzVw?=
 =?utf-8?B?TXRuSWtXQ3JuV2RLNFNBbDVsOUNMY245TmtheGJyTmhqbUxhSmE3cVZSWG5s?=
 =?utf-8?B?VndBRkpRejFndWFBbWYyT0hqbXdYbEdXWVJPeS9UTnNDVmRIRWVGYVJCZTc1?=
 =?utf-8?B?OVU1ZVpvL3JNSGthbTd4M2ZPL0FvTWlHMXQycEFWRGtUbE5EcHZCa1BKUXhD?=
 =?utf-8?B?WGcwWFp2Y2dxaSs0Q2VjdU82T1N6TFZzRzl1b0x6YU5JR3VGMXYrRmFWV016?=
 =?utf-8?B?dUpVVW9wUmJ4UHlKMnhLc3A0bW9ESHgrR0R5OWlEYkVNdVZ0SkFIaUh0L0VU?=
 =?utf-8?B?WGZjYWdDZXZraHBYTlIrQ0ZKV1R5N1ZRODJkZjZnZ2dtUXZYKzFlN09WRG12?=
 =?utf-8?B?T1VnOS9lZ2Zrak0zcm5KRGI2YitwTGl2aC9JZXRiRDZjVzNJR1VjRll1SXlE?=
 =?utf-8?B?QlFzMjk2NkR5dlZzcDZXT1VJTkU0U2x2ZTV2WVRlU0JjS0s4aHlzUzJ2QTJO?=
 =?utf-8?B?VHZ6VEluQVBjTFp3YjVROHlrc284UG5CSi9RYmk3T2lBeU1hY01vT2FoUGVt?=
 =?utf-8?B?R0hhZTZkTC9zT0o1RjNjbllMVVQvSVBpQlF0NTd0Nkwvb2Q2dWdoUFc4WEJl?=
 =?utf-8?B?V2NhSzdsRUpMaTg4TFRFYWI2N0RNQmhxKzg5KzVpK3NBS0lIYTBCNStVbXRH?=
 =?utf-8?B?MlJ1bkNJT3ZvWllWKzA1cHloSkQyQmRZQm1VemU0SHFjYk9zeVR0ZFFVWDdr?=
 =?utf-8?B?Rk9hVzB3emdIdGl5MnpLQWNaMUtrR0w4WGpLVG1hOEFIQmtmUGNpc1o2Z2h0?=
 =?utf-8?B?RnRiUlUzdXBRa2xYVDhQK2d2cDc5aVNyZzgyYnZZQU9kNkNGODZlU2ZGakhI?=
 =?utf-8?B?Z0lhUXlxY0Z1WXJTb0lXY2tTajR6MjUrdmw4WTRUM3lHRVp2Z2l5R3lXT2tG?=
 =?utf-8?B?QmxVVjlITk5DcS9FV3ZOLzdzbVBCeFNnNGN0UXhmdG94VnViVCtpS284SkxB?=
 =?utf-8?B?VGxCMDlHVEZSYU82K1RnQVRyL1lqUyt2b2luZWF1SWUzUVJ4Ny9mWVVZdkIy?=
 =?utf-8?B?RjUxeTNMWlFzNktDc1RKbWVjM2pETVlFRGFFcUJSQmVnUjQrS210MHF5Wisw?=
 =?utf-8?B?MkNZL0cyS2hSVGlpNi8xRDBjbHp4OHdEQTN3bUdUTWhqdHdoSHRJWU1mREs5?=
 =?utf-8?B?SGJwUjRpZDNqVjJDNE9LdVJlRjcxRThSWEpFSk9UZm10cWNlOVV4RjBzMm40?=
 =?utf-8?B?Zk5HOXcvaU5tR2tRMlNmamxIQ3hnK3RNWjBjS1gwVzhBYnMxa3M2c0xaS1NZ?=
 =?utf-8?B?a0hJM2FhODBHWEpObDl4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hQU2UxTHhBd2xkZDA4WE0yT1BNai9NU2FPVXdxWmJiLzIrNCtYVUdNWFpT?=
 =?utf-8?B?aThnZkJhRnoxZXBlbkNyNkpYVTJCYTBweTVwWmU3RnRQSENNczFDZ1hBTFJZ?=
 =?utf-8?B?amNtZjFjeUN4ODB6Y0NxOEk3Mkg3M2lFNDNORERZTzcybUhPekU0MjBLaDBT?=
 =?utf-8?B?blpnQy9mUm1vdCszQUwyRHdFS1I2cGhvUlFyNWF5aGhaWDBWTlhZSUVVbjZ1?=
 =?utf-8?B?TTJCSGdFVi80OVp1KzBBTzZQU0RpWUpUcWJUdFNUaEgwZUpYZ1JhQXFsZVFR?=
 =?utf-8?B?cVBScmdiMzRKY1dwY3NKaTBTZ1pacUoyOHhnWlIwRmZWWWZzT0drclRGT2lU?=
 =?utf-8?B?bStoV2FTNWZtRERWQ21vN0hBWnVwUmp3cEJ5YWZYaCs2VXQwZXlvYUFwaXN5?=
 =?utf-8?B?UzdHUmlYTFcwcEhQY1pBaW5aclUramVsaHI3NlN6cDNwZlR3b2plb1BBVTdn?=
 =?utf-8?B?SkV0V0Q3SmliVXlkYW5ZUGhScHRzSWlvZm52d1dXN2xLbDVtOEhET29OWmpS?=
 =?utf-8?B?YVNYVzZSWHNvWnYxa2xGUHE0Z2NiaU52dzkyWlREOEZXdVNrZ3hDOCtMZ2cz?=
 =?utf-8?B?WE10QWo2MkJ0eWxzOFUvTVM0NS92WHh1WDhYRTJycEZVSXFmUFp0SXBwM0wx?=
 =?utf-8?B?TmQvRENvNk9vMDdqUDJrOW1JQXpNNERWb0VQcDdEK2Z2OUpacXQ1V25qMHdr?=
 =?utf-8?B?YmxVcUkvdWFyY0h4Y1poTFQ0MzJHNzdUbVdhaXZDNDRYUzhiUm5Wb0wzMkhr?=
 =?utf-8?B?UjBVRkFCWllaSFJXenhnNWNTVlVLU0o0STZYM2lrMDRZVDlacDR5TDV3a1NK?=
 =?utf-8?B?K0dxQmpYSFdiNVFrTFY4c0pXbTNUeVYxeG1QZmZTbG1Id1V5a0cvbnFOdmZj?=
 =?utf-8?B?T1BZckFwajFIM2ZPOG1oUDhWYnBQVHFJNjdxdC9PY3ZXODBldzFBZFN1V2xX?=
 =?utf-8?B?QU9NSzBQUnVDT1M4Y200aEJ0RGllLzNTallwc1FlZG1qajZoam5DOFlnMDU3?=
 =?utf-8?B?R1pNSVpqMnNoNXVFMWR2V1gxb0JqK1FybWVNSmJYNlhybjFhMkoxWElJM2dC?=
 =?utf-8?B?WCtqYmYrMml2V1craDg3bkwzTXhDOGZGVnlJNVdhYUNET1hnUzJhZll3U0dt?=
 =?utf-8?B?Y2xSUUhCSmVQamE3QVpCRENGYmMzOXZNOUIxU21UcUM4QUYvdFJSTkc4MGEz?=
 =?utf-8?B?NCtOcTMwdHI2U3VzV0orL2J4QzIwYzhnR0VMek9IZ3p0NWMydmE4TW9tWHNM?=
 =?utf-8?B?ZEdDdXA1M2tpTklHRHpaTWtXMWdSNGRQWnYra3BrcGoxc1NkdFlUVm1hYXFn?=
 =?utf-8?B?Ylp1WXo4VjJ1UmRwb0pXSjRndXJvMHplRCtWc2RobjRYanJubnMrd0IxRjlJ?=
 =?utf-8?B?MldkZkt0MkZGbUNBTlhJdEZqSVJSZFYrR0p5cFdLNVE3V1NHcmIwVzRjL3Za?=
 =?utf-8?B?Ry9RRXRWUVJ1Y3ZNU0ZqdDExQ1VRc0xocUVHYkNwaGpXNmNjZTgrbVZJWVli?=
 =?utf-8?B?WkVrOWxpYTFtRVBObzJBZENCTmk0VlIxVG1ta2cvR3JhSjlnSnY0Y3c1aHg1?=
 =?utf-8?B?RHFtWWFQZUNZSXRWT3Bhbmc5aTR2c1liTkFVbkRwNFplYnc5QWQrT3RlZGY3?=
 =?utf-8?B?VW5VR1Z3U2RpbjlZMkRMengvNndsbnFzVXladjl6RWZrK1F2SklBaGUvcjBU?=
 =?utf-8?B?Z01qcVpEeE9OTkVjbHB2L2Q2Sk5xd3pnNUFtMHFuMWRGVG1IL0N4WmhaNDRx?=
 =?utf-8?B?d2J4K09MSVRueWVncTdFTldKQVN6d0llaC9aN3d0WndMVUI4NkR5Q1ZzdnZL?=
 =?utf-8?B?dW1aRU52QkhYTlEzSjQyU1NYZW1ESUMrbi9FeW9wNDRnNjBzVVI3VnUrckRn?=
 =?utf-8?B?bHBpeDlSR0NDa1R5YlBjSjRTL29YZzA2VnFZaVJWMGhPRmNDcEx1MFh6ZU5t?=
 =?utf-8?B?K0E0UzluckVvQ2FhdDEwbkZyTlp0ZTZMU2Z4cE9iYzhoUmxnY0w5Z3orSURs?=
 =?utf-8?B?TkR1NGc2Y3ljMmJCSXZQcXJUbVpNZEQ0UXNMWDJTaXFWL0w0cnlsV2YxRUVN?=
 =?utf-8?B?b1BQSkRnYnp2azZ0M1p1MUVHR1I1SEphMFVQNE5ianUyczdvUWFRZGdzeUVD?=
 =?utf-8?Q?7A6wZHJB53tyNNdi5Y9ypcyRD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5194ef-0c16-481e-bbde-08dd57d7e176
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:11:27.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhj6ffA+4iQRFQeLT1xi2xAYQzHxi0KNngIPOvzcFDreH8/En9UABqVlST8dy0evgxoGI7rphrI9ea82iIdmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8565

On 27.02.25 07:29, Jan Kiszka wrote:
> Quick heads up, but I suspect only few are affected in practice:
> 
> The implementation of recvmmsg in Xenomai 3 is broken since day #1
> regarding timeouts. The internal timeout handler
> recvmmsg_timeout_handler races with the xnthread_suspend calls in the
> actual recvmsg handlers regarding setting / clearing XNTIMEO. I don't
> see a quick fix yet, will likely require some more deeper extension of
> the cobalt core to support such a timeout across multiple
> xnthread_suspend calls.
> 

This issue is even harder than I first thought:

 - as written above, using a timer is flawed because it races with
   xnthread_suspend entry/exit when waiting for a message
 - recvmmsg simply calls recvmsg handlers of the respective drivers, but
   those will happily use the per-socket configured timeouts
 - even if we declare recvmmsg timeouts unsupported and require the user
   to fall back to non-blocking or infinite blocking, per-socket
   timeouts will still be effective

=> There is no way to implement or even just deprecate timeouts for
   rescmmsg without modifying each RTDM socket driver!

I'm inclined to drop the complete API for those reasons.

Who is using it right now? Please speak up.

Jan

PS: When your read
https://www.man7.org/linux/man-pages/man2/recvmmsg.2.html, BUGS, you can
see that we are not alone with having the implementation messed up.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
