Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0E2D46B6
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091104; cv=fail; b=h4RO595siPkQzvQnQFvI5GU+STgV0C4vLsR2qE7aTcdAMoGnaE9SpdCUtWpQjR/C8EBb0UiIe+7X559tV7yoMsJCUbADd7ZQO0Um8Vh4qvajOHLc7V3eYcS80VpHV3urfljo2JB7VS0QVhZuXMQrPJn2ldweO4DrxG0FR2KmdPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091104; c=relaxed/simple;
	bh=aCZ/pVtCc5wDl6PSCBGqW53N0Q6G0p2TWinorL5hwBY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HkdJjVQCtwpJEZsEMenCQAOk4i7fZuC9rhQG2KYq+vTKVaMLoszeZe+GB0O9h2BbxfHdO6QvCLHPqZNDulPUAAAmYq/HSM2kwYNu9F6irsbnkMmtJlJOEIJ3FurI0jmcFp/qBte52VvXcLgqy8US4ikcJG38u+qlLammkeRahJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rwp897TB; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rwp897TB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA2IVAm2rJUsGigh5NInpojkLab867qsI/ws0eLjChQ9LSV9gKyOCPwFNJIFqdlbgnuTx73sAwDjhztIhR2etCGKVKmMxKZA4iSqOqsSJJMmFqxdyhr59EeBc008DkdRY46D3fdD98a/Hvivzy9E8AXMF7MxHU5FO/AHnn2G+9DXt2b+DxE9NvGW8zjJAjPN8m36VgWy9ZvmkTqH1VjO5M2VRQGEdgXdUy0JETwAXX8G3Qrqg9NrC2TNPrApPBHJpCwjRmoO/wesoRndNJTor7MOx3wPJILjBMsgpCSLYl1wHn9B+3nkT+FYA2n0UAX/44KlqDJl1OrXYQiL7v4Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lxVxM3lBubMEgPy7hx9CwPjXABSriHUakMhOxCf3hU=;
 b=YT3a3dQ37CkCKNmuvOO+rmn2cUTqmbhDbHqm9ZYzZLRou4AeLvgAom1CmfGnxUWF4nWOH/LdU10qEyzc7Smdd70x/1/vH2WNdM8DMrObh0DyyJH8zPzbGF7d7z1A9ViMYR3PulXYaN0uaAeZ6XPp8Nrz0yWem0LByv5ayK1ZczJIa7l5Q/J2YZcLedIEjYMh7A9JrsLh3f0t04t5cVgQEo2zAcuMV4kHhNDX85UchGSIEcPQnWFfx4K9g9XC5jkSYL93jK14FuVEkUCkR9JMosDG1oDojSh+KenNbCjVAqlOCvow6sn7Wwp4OSi3870KkJuuRCOAeYQCFaQ8NA3FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lxVxM3lBubMEgPy7hx9CwPjXABSriHUakMhOxCf3hU=;
 b=rwp897TBW/lL0bjYr/NaXgeXjCu6eH3v6LcdzEc9Z6sLcjcn9fsmqbX87VTsL+t4KxLcph+STIOva/CbGKW+7xwUe6H6mfhKQI1iG4skF/6im1iZokfybW+ILXR4ABxR07ayvPQ3jrV2Q/SGfpK9suug3WWPFgYb70QfoUVfCvX8JU0WeHfepABVUK6TbYU/rW5VOnSHJJ/b5ERmhq4RqM35XQrRUkPEtRxu26p8lJ5qayUkH3Pc2CqVFOzlycVEZZIAd5EsAR7pEFUWpybHyEsd51VAXvtnNb9e/Roz0ZT2W+8gZ9RhHUWmAj85ULcBcIdkf/Yo19XtPFnQXZwDdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 10:11:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:11:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl 0/2] Add RISC-V support to EVL
Date: Fri, 10 Oct 2025 12:10:48 +0200
Message-ID: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: e277d526-81b2-4dbb-1ae0-08de07e56656
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXB3U3FKbjJwREtXdVJJblNIOUZacExPSmUxOHo3ckRQbndsVU8rRjV6TlVy?=
 =?utf-8?B?cEtCU3RRVE5MRVBRR3gzRmhXSXVCMnQ3QTM5bnArc0hNSmxaNWxlejExSHY4?=
 =?utf-8?B?QmRNU1NBNGpYaTBhTmI3amR4cWxGMW42ZkM0bXk5L1hnUmp4U0lDbnJIeUla?=
 =?utf-8?B?MjU5VHMwQmJsQkJHZW5ad28wTnljSGVsc3MwcXdEbEthVUN5RGRQaWVDY0xD?=
 =?utf-8?B?QmYvLzNxZEFZczY2OXNDd1JuczZiY2h5NjhHbHNNbkZvNXBKWERYOWZ0S3Np?=
 =?utf-8?B?bUsxdFlDNTJobHQzdVN3N1dnTXZpRTA1YzBXSlZUOFYxOUZIOXpuSGg2bFA3?=
 =?utf-8?B?K0M0aTcxYk1FaUQxNUpkS3RYQnRnU2tNaG5kcVhxYmNrVjVlbDZyZnY2MnNo?=
 =?utf-8?B?Y3VaOGd0bHBjTW5NUDFoM1pDSWRFbmdLQzArWlhRZ0hxMjIyb0VrVkVNSGZD?=
 =?utf-8?B?dGZVNWVmNCtQRmFDc3l0THFhdXNuY3QzcGkvMC9PQ2lTMEI5cjBBc0ZlMlRO?=
 =?utf-8?B?dmJTYUUyOXVjZmVqUFJwZUVvOGtLeWMzbzBPdnZmVThsSExMS21uWFFPdU1G?=
 =?utf-8?B?Z01FLzY5S0JORHBQd1A3Yzdzbjk1UW9jSG52R093c2dGYS9rakE3NHdzUGhB?=
 =?utf-8?B?V0x5TGljZ0xDNnd6dGVHem1OcjBLZFBKTHFIY2J1dEhSWjZSeExGcy9vWlEw?=
 =?utf-8?B?QUF6QjlQdE9BUFRFMHdEYURxK3pnTVRTQ3ZDaUFhN2VjN0g4b3ZLYXY2OEkz?=
 =?utf-8?B?WHFwMGdWaWRQeGZEcU94TjUvWCsxS3ZBME5MM1JUeWV4QWFhQkRkcDYrdGVu?=
 =?utf-8?B?eDgxR0VNa29OL3BXb0N0bW5ENVpsb29MRzJqWEFjOXczSDk5UVI1T0NkTzFz?=
 =?utf-8?B?bitNdllHZHI0Q204bUFiRzJUd2JtOHk2dkhScnNwYmlkRnk3NjRWTnlvcHFE?=
 =?utf-8?B?Wmg4TWtXWE1MWXcrQk9kR25LM2s0Q0psWkJSZ2N3aVZJV3dNeElJYXpFR2VB?=
 =?utf-8?B?ckp1S2xDcWpwaGlLd2pYMnJremZ3R3lybkUyNXJ0Nm5VYnprdnh3bVZXVmdR?=
 =?utf-8?B?c1pGU1E4cnJXcW5jTnZHMDM3SGFXYzZqS1pGdURPNkZJcllCM0tuR2hzTEl1?=
 =?utf-8?B?aEk3c29WWW80TE5nNHdsUjVBZmlpT3hQUEJwS2JnTURBR2xlYVhIbkw1aGNz?=
 =?utf-8?B?MUFRRXM2RktEbEFoNTNRWDlTbmNsdUcyTTNjbVdpbkplOTVSdlNiMll6UTVZ?=
 =?utf-8?B?VXlReEpXWGd3WWRTcExMcXBwa1NOMVcvTEd5NU54NWgvNnNEZDQyMm1sV0R0?=
 =?utf-8?B?ZjBGbjNxQk9LVFpHYllxZjFvcGhFN3BNb0JhbjdxRHZBNnhQVUFoQUVOZlNF?=
 =?utf-8?B?OWIyQ2RkcHFocHdlRFgwSVBGRHpKVk9Bc1R1aXFlaVhHZmNhSzEvMDM5bzNU?=
 =?utf-8?B?YVJ1YUFLRUN2R1lmTEVPVFM4VXkzZFA2VUFoUXcyUHhSQ20vWjAxUEhRNkFu?=
 =?utf-8?B?RUhSMU9xNmJUMGR5aldlT00zbjB5MTlDYjBLR2ttWnlZNlBnZEVNTkNMbnFj?=
 =?utf-8?B?QkFpaDIyVldSbEdjejhoYzN1VGh3Q1A1dURtdDBVcE0vUnIvWEV5Nmo0QkVl?=
 =?utf-8?B?aGtpUkpaeDBuYVNlalMvUE5ySThYK081K0lJOGpaellneG1IOWlIU1JvUitz?=
 =?utf-8?B?L0U5bXl4d2luTXJzV2N5Z2w5SVB6NDU0OU15RlNJcDl4Y09GcnpYQ29OUGs2?=
 =?utf-8?B?U3Z0WHpQK0UwSlcra1FYVjc0YUxTWm9IUHRnZE8zY2h5TU45MUJYdmVRTnRG?=
 =?utf-8?B?TTZxVmoxR3JieTJkelVOOFp3N2ZXWksySTFVSVNKNUttWGxxUlN4MVhBUCtk?=
 =?utf-8?B?MU9UV1lvMDArakgrS3RJZUIwMWYyY3l5NCtmRldkRDJWakNsNnorbHhhemhl?=
 =?utf-8?Q?SMYRf/ZcZkbxhC9KBjjbDS68LpVrTHnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTR5clo0RGtHdzFoU2t3M3Z0ZlpXZk9wRXY1WFFLdUFMaHE3ckp5VFdWT1ZW?=
 =?utf-8?B?VEVtVFFkUGFpL083eVBuNnA3eVJVZVpFR08zSjluZzkwWjYrbjE3ZUdmOW9E?=
 =?utf-8?B?TEhIbGU2Wm9FakRleVRLekJ6NGNpR1lDMGNLM0M4VkxaVVExUmhNVE5hMFJ4?=
 =?utf-8?B?eWxIRmFPYXhpMEpFbE5nam1IZmNYSHp4VXNqa3JyQ2lRTVR2dTF1Sk91TWhj?=
 =?utf-8?B?aDRpcmJ6ZXhZMEpmUUwySnk2am90cXNuRE1CTEFIMnYzSmhuUTB2bUpvam51?=
 =?utf-8?B?UmhwSDNiS1hCWFIrVWQvaU9LZ3FYemdoQlQ0TTJ4NVVVTTlVcUVMVjJqUXd5?=
 =?utf-8?B?bUI0OFhMR3lZNVlQRFBSeXY0SVV2YVc4R1YzZ1dwd1RGZnlNSXd6UEdBc1ZW?=
 =?utf-8?B?ZVR6cTg5ZlZsdXhaU1Rjc3VFNjkxVy9pWTdwa2hZZGluTG95ajNLM0prT1JT?=
 =?utf-8?B?eUVGRHhkNTFIcDFXYmtEVnRNd2xVWkVZNXAxM0hMdVdlODVQZ0RBNkVOZ3Iw?=
 =?utf-8?B?ekxBQzdWTDFESTZ5eit5a3pJYVNKajZ2STJkbmQvcFFLdmc0OEQzR1BQTUto?=
 =?utf-8?B?Y2pVWThQRmtjay9SSUgrYmR1U0YvQnIrcWhKMk1WZGhTRGtRQk9ScWFEanJF?=
 =?utf-8?B?RVFlSFBXVUNYaXpKMWJrV2srckhSSi9FMk5LY01SWTNMWHh5Zi9acFdpQzlt?=
 =?utf-8?B?bmd5NmFIVDIrd0k1OVlTWml6S3pxUnRRTTU4ZTlOWHlseDRRRWYxNll0emxw?=
 =?utf-8?B?WFJ6eTNqdVp4SklsYjdHMndvUWJZQWw1WlBZMlBMUkVKWVQ3SWtuRGxKUWxl?=
 =?utf-8?B?ZWNSdldQZHlJS0VqVityS2I5dGREUGp4b1hveUYzWGozRW45M25XY0hwSCt4?=
 =?utf-8?B?UVFsSmpvTU92eXRTSU9kVVdZZ1FYUTJvcW9saGRXOFprWUtUNG5yem5JMFhn?=
 =?utf-8?B?OVphV25CM1NRZjBvVVFxUUREVlNrTEhjRjYzTzQrTmREK1UyMzIyV0N3bk9M?=
 =?utf-8?B?Nk1xL1FFd3R6OHY4WFRVVVAvUTVIVUQyWjVVSDdYdzNXQndTUHVsZjdlWHZt?=
 =?utf-8?B?UUEzVzhpelF1R2d0QmYzOUx3bWNmRTZxTzVSbVNCeUJlTjBUMGdOUE9PT3V6?=
 =?utf-8?B?Tlc4c0JydFZRek5HclhqajdJeHBINzhlMExoOG0yMGZKVnB5azJBSWNmd0Z2?=
 =?utf-8?B?ZnBlTHNOS201QzI1VzR1N3VPK2tYSmVjNnJnb1U2eUtGa2Q5azR1MW5tMitC?=
 =?utf-8?B?M05zeDNsYzh3NHBpZXZ3bEg4SFVKYmVtd045U2tIdWtOZXQ2OG8xN2F1UDhh?=
 =?utf-8?B?MDNBdHc5ZkxIalNsMDZYZFRIWW5MaS9jY0lDMUQwV1FpZ2NVSEk0dVVMbFVJ?=
 =?utf-8?B?c1JIT3FtWDlrb1EzdUIvVHF4WTRlWFVpM0lVUmt6Q2RFTStkVmJSclNnbElE?=
 =?utf-8?B?N1FmWHlZSlZjbXhVQXN1dkNjQlFpNGY3UnVya2l3MG80R2txY29YeXhDNFlv?=
 =?utf-8?B?bFFPTUhqOUZ6MjlmRUUrZmR3Tm5UOHVWdzUxVzdwelBPVTdoZTljMlQzdWJs?=
 =?utf-8?B?NUhsR2tRVDVtbUVyWWZ4ZlErNWFqTERYc2FBRTZxQkhuSXp2VUdsWDF3UlBv?=
 =?utf-8?B?U2I1V0V5V0k1ZE5pSlFzV0t6azIxazVGN3ZPbDFyMXI3dnZEWE0zcDliSjBD?=
 =?utf-8?B?cnRONWRSYWR3anRGZFo5UEVSVjE1RnBOaWF0Q3RXM0FxMWFoTUx4SFRFdUdO?=
 =?utf-8?B?RW5VSmhzeTIzd1hHaGNYdWVIS0VIcEFsSnVLNWhrZ3pjUm9qZ3E3RWFuNkhS?=
 =?utf-8?B?ZUJLalNxSkZhZ2xtYS9LWUlxYU1ScHJyN295UXN0ZUZSbzhjMlc2SklJbjdk?=
 =?utf-8?B?K1NWN0RmWWMxZ2hTS2FRRVNmTWxSSDZKRExyUlM0dno1UFIwcFdTTEV5VUVV?=
 =?utf-8?B?dHpMVUJKRzlIYjVIcTQrcDIzNGYzNzhzZWdvckVDTUh5WUFHNTNXek5Tciti?=
 =?utf-8?B?cUR6QnY4MFI2R1lqZ0lXaGdFaXlSeXgwcm9hWExQblZkby9jSWFJbDNrbGdk?=
 =?utf-8?B?N2NuNlRNcjY1a1EzZVpIVWM4YWl5ZFJ4dWR1ZGZ5ZXNKdXJhMll3UjNLR0Rj?=
 =?utf-8?B?bmRuWitmSWZjZnl2MmpwTjRXWk5hNi9kQ2tZZUhBcGIwT0FLQVRBcUE1ajZF?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e277d526-81b2-4dbb-1ae0-08de07e56656
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:11:38.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdDjMnUnpWlvQMQe3rEa1A0Y8IDPrxRHn6rcBTvwanBc5M0HGapN1Monf7NaEg3AQmgNXTtQwYea0VQCDsp6UPZpfJYxN/0YBfPIjfW83mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217

Hi all,

this series introduces an initial EVL port for RISC-V.

While some tests are still failing, I’d like to share this early
version with the community to gather feedback, reviews, and hopefully
some assistance in refining the port.

The patches have been tested in combination with the Dovetail RISC-V
port on top of v6.12-evl1-rebase.

Looking forward to your feedback and suggestions.

Best,
Tobias

Tobias Schaffner (1):
  riscv: Add EVL core

shannmu (1):
  riscv: Add FPU register test support

 arch/riscv/Kconfig                        |   2 +
 arch/riscv/include/asm/evl/calibration.h  |  12 ++
 arch/riscv/include/asm/evl/fptest.h       |  31 +++++
 arch/riscv/include/asm/evl/syscall.h      |  25 ++++
 arch/riscv/include/asm/evl/thread.h       |  12 ++
 arch/riscv/include/dovetail/irq.h         |  11 ++
 arch/riscv/include/dovetail/mm_info.h     |   7 ++
 arch/riscv/include/dovetail/netdevice.h   |   7 ++
 arch/riscv/include/dovetail/poll.h        |   7 ++
 arch/riscv/include/dovetail/thread_info.h |   7 ++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 138 ++++++++++++++++++++++
 11 files changed, 259 insertions(+)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

-- 
2.43.0

