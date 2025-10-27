Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCD46B5
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580889; cv=fail; b=kPmDD8loCzY3ABSQibMEVEQOmNboRHz5vNCkMwrjNIJPx5CY/71oeH5swu6dMltmrek26KEL5dnUPFnMb4rAEPecL1FHAJ/4gBIiinkhRQKFw7H3fzqg+rE5BO90MksxJSEgDXcxOrZcoBASqeUOQssPqsnDoIcoRyP1sace+Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580889; c=relaxed/simple;
	bh=7bIhZd46qTyXQES0DDHfgKTtZc2NruvtPQLXXu/H/uY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huFZF2btUnam607qN3tbkzlVtvwuHkYVrLHj0vj7K9CEaphwwZ2ZiIHb2iNAec5Nkh1grqL+CmswAQDtEEOQ1nkIC5TgpyrjjCFtGOG2HkOLWv64G7KQ+mOmpoCC2DB1ZMn1gr3hIpnPX/c9IjRBA168WW1sluhOfo0NDR20qj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jq4FiV45; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jq4FiV45"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id B126B43CE7
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:01:25 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1117A78044C;
	Mon, 27 Oct 2025 16:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiUugXgO+6ZOb2NmQJJAyAE7qc9iQXyC7Q5dmMLlIDqXYWhvRfHvY0HHA+HK2wp8V+NqoYnTkVUi5a0nxT0xpS5BOCE0tptnK7kzDILQxCSmbOrcnyhw1vJypaLDo/nYDyuHM6bJHsloNfFgTMEYxLcyYxli6jzdJSFINY1zkrLwzgL0N4sbvGy3FXHQdgmIGOicw2UDRQsI99v0BKznoRzbyo3NG8aUaH09Iq3YZ1neoUNE2bIS6vq12QXUVW+2+ep4hmx2XrsigFk/Rs0UJJuDazeq3iu7+DM40VVmeUrPqk0shHXrLlXSOASYjBtktS1JspbJonw+97SLGcjYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMFJN0HuHh1DbN4h3/01MMybo0D5d7HUyWnMQK0UbyY=;
 b=yPDjFXa+FeUhLTbc0BDPrg+OarJk4zt46eNv8lE2hohAVr+4COIzow8NbJpbPSfnoyNtczAit/Ao4zoeewxg5bAxTFWM/KLv4ND4heVzzBWpCAAiYp4g82IIpiCqgODo3uSRKfoEqdKenCL9Xay+VyPDO9KWukDcpzFBp2Bef8kF69U1HI7bKKXmNL/ANsFlcQNBePJu6pLpaeeBlkETEkb/j0/xObKsRxL6g5NfwaTsHl1F3zTgN3dqMNUgix0u/J+WBTFY9beUNhWdGaOJnHcO8YlDy1aSx/splY5HZrWr3zP7+Jg+Ad+9XYCzvwQp/tJCJZSoGSbNBkTDfVNE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMFJN0HuHh1DbN4h3/01MMybo0D5d7HUyWnMQK0UbyY=;
 b=jq4FiV452y3fx+fdEZF72B4nTlgiUkpjEPlzdsG3ItlXG1fJEZHP2etYbFGYX2/u3vEE+HTBabqERdSlVJAtaLhCYb1ADawwl4CLtQcYf2C4bL6Uz6615zm0I0lsRAtjdleMY7h6plBwpfES9vJn2r8U0ZyqeZpm17MN1i3G4ozlwD+sFgD4piaZvY/1dtSNx4OSTrrVPPODYbjKSU/YZLHPeOUppV4UTAQSsH7610NtnU4ppbNc2l1PTOBx8Q1wajuTFX0VaNdjFfaMVwtH5sHkIakfVnqB+AvMcNzqHiJhP/9ucRYmCXz8IBiuBCChs85MDfXzwin/TK1k1TIoCA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:01:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 16:01:23 +0000
Message-ID: <0f63813f-d16f-444e-8efd-7b1c4598cf7a@siemens.com>
Date: Mon, 27 Oct 2025 17:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 2/3] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <69e5ff8590d101d24ace2e6708196af7a2ead2f8.1758264904.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <69e5ff8590d101d24ace2e6708196af7a2ead2f8.1758264904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:610:e4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: fc43af98-a88d-44fb-f839-08de1572135f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURLdkRkN2VzTmFTTy9oK0hrY25xWmJLa25NMXQvVS8xSXpCdCt4bTdmNzh3?=
 =?utf-8?B?cElWbjhkeVFMN05Tcm1yOFFHZjFYaWpqdWVjeVVtVkRrSmlmMDVhb2lKREpa?=
 =?utf-8?B?TkZLYXBQeHBQTGExZDZrbUJQeXU1bmFRcnJ4aXNndkl5WHhPVm1qV3F1cldC?=
 =?utf-8?B?STVHVWFxdzBVbUVUVTlCRzJpNGRhejFibXJtRmoxWTNNdHBmcGVjanVuUnps?=
 =?utf-8?B?c3VHQzBCU1JNQ0U0cjJKc2d3eHBJUzZlbkU3c21PMEhkeEdjNXNldlRyS0Q0?=
 =?utf-8?B?VmR0dDNvejN3VlpzbitFdDBDQjRRRGc3U3RJOHZjTzRhL2VNaFcxRlkyWGhV?=
 =?utf-8?B?RkVvQ2paUStvZUNCQzgrUGNQMDJrTWZXd29FMHlBWEg5WTU4cDE5OXphUVNy?=
 =?utf-8?B?U3JHUE1MRlRiOTVMOEZ1aCtld3BIQUlaVTIxbVBtYjlwcytwcU1IOGFWbDEr?=
 =?utf-8?B?L1Zlbm94cm83ay9UcVZNZmJrcDRFTG9tQ1VwaHdrM1AyYWFuUm5iUytqeUZJ?=
 =?utf-8?B?T2E0SExtTy9DekUxTHB6TXpIWW4wVnJsYUN2eVVwU1kyZmx2SkJzTkNZR29M?=
 =?utf-8?B?SXk5MzZoWVdKU00wekRWWlh4N0Yxa3VrVktxTnBtd2diKzBrRUlVbDl6emJo?=
 =?utf-8?B?cFJJSU1Ed282Mk42OHJPTlBYaVVkWFZWR1hPTThLUW51MVk0dkEzOVc3OGN0?=
 =?utf-8?B?RmJwVU1OT2xTbGszL1RHVnhsRVlXMTdGcytMSC9NcFg1ZUQ3emtDRHgxOHR1?=
 =?utf-8?B?K3gyTnVCSlA4ZGU5UFU2dFc4cFNMUnpIV3RoNU0wM3ZsOE96eHZBV3BZVEly?=
 =?utf-8?B?UjRISlZSVHlpRXlYaW5mbG04MXV0TDllK2lPMkZVbjFRTDhCSFU1b0t6Q0Zq?=
 =?utf-8?B?NTVzRGFpVmFhMnh6M0g1cnpXY1h4dUEwSDZNUmFBVVRIN1VDM3ZuZGlFbXN5?=
 =?utf-8?B?M1V5SjBzSStBNnI4OUZjK3FmZzQxdk1tMmcrRkVZTGVBektuVzZmYjMrNndZ?=
 =?utf-8?B?OEIzNG5lSVJlN3ZXbFFDS2lYcHZQd3h0UGIvTGhHenE5YmdDMDE0TXk5NTRP?=
 =?utf-8?B?Y2dMZDNLWVJxS1pTeVQ0L3pmWHE4L2Z2WENXMk9GcC9Wb2drR1UwTW0wNjZ3?=
 =?utf-8?B?Z29oRUlLODFUMWxhTjVTVGw1TXlYM3o0VUFpenI3MEVzcFkwcVVjWG9KSjVL?=
 =?utf-8?B?eHZSMmFNUnpWdDROZ3B2b2I0alJnY3JFYlp0YnkzUEM1VDIxUWxOUThMN0ty?=
 =?utf-8?B?ZG95UXNpTjRtaHFyaDZtOUZZbm9kTGZ2d3BqVk5YQ0UzSVBWRFp4b2xzdTV4?=
 =?utf-8?B?a3dXRjlVM1V3b3QyMWhjZGRJc0N1VjdPaDhVdDJSQ1NyRzVVSzlwbXlrRFpl?=
 =?utf-8?B?VHZqK0VOMWZibzRhUGpHM0dtUzdFdzVMdjhlbUE4WmdrL0tKc2c2V05hbktu?=
 =?utf-8?B?aEw3RzRDeVFrVkI4ek1pelp1Y2daTjB6YWRVMUJtM2RRRzRmWTZNWUhObDNB?=
 =?utf-8?B?VU15RWJJa2Y4M2Rkclhvbk84QzN2ZFd4RTljaEQ4ZkIxN2lWT1ZFZVYxZkhJ?=
 =?utf-8?B?RjZ6L0IwSnBaSzZQMENxeXlqTXBNSURBSm9GaWpsaVo0YTlaZEwzMWY0ZjdT?=
 =?utf-8?B?TWNBbUJOSUlUbFVMWE9qblNja3h6WmVpSUdkdDVnZGpjNk90S2RGR21iNlhk?=
 =?utf-8?B?U3FPTG4xckI0eWIyT1pZOWFlTE9jVVRaTUN6WUxCNVc1cDUzQUNPbFNjWUhm?=
 =?utf-8?B?VlRSais3OW53anZIazI2cENaTjBYa1hMdkdaeG56d0V2UWRzaWJpUUc2S0Jo?=
 =?utf-8?B?c0RMb20xampyV0dyMUQ4UlZleERtS01lNi9JRzFTUk8xS25WUG5XbU5mdDYw?=
 =?utf-8?B?NVpoZnBZYnE3VkN0VmZEZElvZFJSdWNPTFdJcklVQ2prblZrVnlEcTlrNHFF?=
 =?utf-8?Q?kn3sIZUrpRAr6xhDwGdiIi0PhJI/g0dL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUIvSjRWSHZmMk9mZzcxbWFZL2Fldk1RUnJQNVF1SzRjNXVsMG9taStEMTJq?=
 =?utf-8?B?Mnd1eXV6UWF5R1k0L1ZFT0kzRzByVjJOK3NIQnYva2wyNjErK2U5OGFFblhq?=
 =?utf-8?B?cjMxUWRrZ28wZzNIRUQ1bzA4VTNMdnpQUmFGOTZySm5DQWxBOUJrWUhubTJm?=
 =?utf-8?B?ek5VdzRodTBFWFgraE9NdFRlSWZ3alZ0QytnTE9uek56UFJ4Q3hNeXp1OENH?=
 =?utf-8?B?MkhCUXIwNkVLaXVPcFdjYnE0OFBWbGxRSUZvVjJwaHArUnkvTHkyOG5wckFO?=
 =?utf-8?B?OWw5eGs1ZzM2L0IybU85ajFJTkRCczZXZm1MUm9xSTkrWTZDL0tCSGJ6Q1FJ?=
 =?utf-8?B?VWIycmFCcjBFT2dFRjRidnFPSm5MTXlENjcwVGxPVG9OazNXYzVheTR3QXpu?=
 =?utf-8?B?VFVLZnFucEVzb3pwdzduZjAyaElQR0NOeVcwemdNTGsxd1VoQU00ak9KZlN6?=
 =?utf-8?B?b0R4U0Joak16Y3hEa3MxY3dtQytmQUdFaDVmSERzbXlPZXNNYnQ2NDBvRHl5?=
 =?utf-8?B?ZHh0Sm5lUTdXbDJ4Y0JLVWE2ZnRuT09TaWNaUHlwR2lPRmJRUm44bW1TWUxa?=
 =?utf-8?B?R0ZKYnpkY3hyNW1XM2p1TzNDUEtMbENrYnpjZlVVWGJ2SlgxZjk0elhRZGpx?=
 =?utf-8?B?N0V0MHRiVGhDd0V1WnIxLzBZUzZCcVhxOTdBMVk3Wnc2aVJZc2ovdFdLOEJC?=
 =?utf-8?B?Q2FMN3FHandkSzN4d212ODVOcVpBRGttRThZYkwzYzZJYXhqa1NiQWhSL1ps?=
 =?utf-8?B?ZUZibjZwa1JPWDlZUUpTTDlhNmJvSC96Ym1RQnJHYnRub2xWcytJTUFlWTlw?=
 =?utf-8?B?NElVUElDRGNlT3BKb3QrV2xSeFNaVzhIU3RYQm1JZUZoNFRISFBVdDI2TTFy?=
 =?utf-8?B?WEtXbnlMN3JINHpTdURoUWprWi9Kd0NmcDhDaEdTSWk1NVhmVkVpUnRVWGpR?=
 =?utf-8?B?Vms3ZDFyaEZCZytmVTF0SmNlZWpxSW41cGl3SlUvaGRvWkJpZXI1eVpTQS9N?=
 =?utf-8?B?VGxMYW0rZXNKYUJHalRsc2YvQ2VadnFycS8rMmZ3TVdhd1p4eFhjYTFZZWFT?=
 =?utf-8?B?WVljTldLcC9ycEhpMDY0VTM1cDlBT1RFVm1Nc2dqY1ZKNmU1cld3aThRNWU3?=
 =?utf-8?B?TDl0dXBmZGNUdVVpUDJNckY4TTBpYndVSDAybllJTE93M3BHMHVyWCs3SDRX?=
 =?utf-8?B?ZlpyNmZEYVdzZERheU9lOEtwVExsSlZZSWJKMTNjNGFPNmR3ZkovTTFMMGtL?=
 =?utf-8?B?S1FhYkJUQlVvM2w5QW0rM1g4T25hbk9OeWJiem5idVhjaHljKzlyempHdDF4?=
 =?utf-8?B?K1lEUWZTNmUySDZSbmRtNDVTditnRlFvRS9rWXYvMVhGTGg4aTVqYXpPY2hP?=
 =?utf-8?B?NGtPeGdueHlmSmwwMEJ2Wnhsc0JCb0ZybHRWNUN0dDhJekV0L1F4b0tQWW13?=
 =?utf-8?B?NUpqcEVzTHhNNmhyaDlBckF5VlRacWRNOHNlZkdDcnpJcVR2UjQ2SG1rVTFv?=
 =?utf-8?B?VnBRdlhNM1Z3aUlXblhhWE5ZRzIwcVd6dzZvRFhQbGttNlJvZ3ZKR0NXdTN1?=
 =?utf-8?B?ck1mZVNhNnROa2ZTYS8yRmtKNDZsSW1KZm9ldGVzeTZPQWQ0QnpHNWVRQnJX?=
 =?utf-8?B?VlpFUmRqQ3JNOVhveXUrejRyZUlQd0NlYW1IeGRPcDQxVEpSU1g4TXRoRW84?=
 =?utf-8?B?UGJ1NG8vd1JGQzZlbFdTMjRvNmdOWlVYM1o2UkE4YTVHVGR3NTNpTXgzN0hZ?=
 =?utf-8?B?a0MzNFZxeXV2dkxNRDNpL3JMYmk0eHBRRXExZlhORFZEN1pidWlZY3NVQWZM?=
 =?utf-8?B?a3pvNFBYWWJ2UzVhb1o0MVp5aUNhOHE3YXVNdmtVZHlYV2hwdENLdmhIQzlC?=
 =?utf-8?B?T2lTd01QYXZjalNTcU01cU9CcHh3TTZ4bzVUa1E2S2pqb2xkQk00K0lUV094?=
 =?utf-8?B?eEl3Z2tmRmxVQUp4TnZXY3NNTklqWWpSYjZxelVkRFhoK0FQTVVuWG5wMFVz?=
 =?utf-8?B?K1Y2RTFBcGEwRC9NdGE1a215VEhydUczak1ld2daRGRRTUFxMndoZ1lQd2xl?=
 =?utf-8?B?UUJRajduYVlIZWxCUzJXbWdTaFBaZ0syVW1yWXpSbnFOOFRYZlJHaHcxTm1u?=
 =?utf-8?B?RjY1cmNpRjZsNWJZdUxsKytSZlNxZTErVDhHUHc1WjhhV3JJNytIdVNUNnpm?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc43af98-a88d-44fb-f839-08de1572135f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:01:23.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTLUIP4/zzhgET4yiiio1dxeTF2EVJ+x729LbdVfqmhO4MOm/aErv63PsJM//PY8Mt0zka+dupmb7YAxIyTY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5915
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=jq4FiV45;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c20a::7) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffffgfuhffvfhgjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutefghfeileejiefhiefggfduvdeuheevgffgudetgffhgfdtuddvudevtdehleenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 19.09.25 08:55, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> fpsimd_save_and_flush_cpu_state() itself does take care of this.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index ba804fcdfdb3f..f915706332191 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2148,13 +2148,9 @@ void __efi_fpsimd_end(void)
>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>  				  unsigned long cmd, void *v)
>  {
> -	unsigned long flags;
> -
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
> -		flags = hard_cond_local_irq_save();
>  		fpsimd_save_and_flush_cpu_state();
> -		hard_cond_local_irq_restore(flags);
>  		break;
>  	case CPU_PM_EXIT:
>  		break;

And this one for 6.1 should also be merged. The changes in patch 1 and 3
found their way into v6.1.y-cip-dovetail-rebase in the meantime, as it
looks like.

BTW, a new release for 6.1 would be good as well then, to get all of
this tagged.

Thanks
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
