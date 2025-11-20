Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D13274B42
	for <xenomai@lists.linux.dev>; Thu, 20 Nov 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664849; cv=fail; b=XjNt+C/Ry6YDVY3rn9y18+AuUp2CFnluooU+dtLNBQkLCCHw0Bbb9SieQuTyIIMSG1xGgjgbXyX4GXxAuO2JbhRC3eWa4UtJDtsChD7+pRz18hHZjJwr7FxsF1u+zL72+ybNHouoP38Ov8LRHWWvv1v3SKTsohh61JW8rciV4wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664849; c=relaxed/simple;
	bh=05a6OJotc2AhH99SOA7GRBrSL6pVgP/8lgSUdGtAYqY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fR6qMQLfPlKEe2jkU0O3pqfiIYHDl4vxFjk1QVmpFjZfQqHk6r4tzbrmn0IdDkqb/h9xgQKM74Snv61ta5/ilOHLKwxKbDJMj8gAMOpomBfY704EPH74BVQMM26LGPW9Po8L8mei0lXUIaf2CDxCe6wZrKXrmrUiaryz4HHjPhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HYIaVDrK; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HYIaVDrK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlwFpTnnA+2aKggfIyGSb5/JtVYZ1hV3RmoNxDynb0NM3cfiI6I0TGpydp4of9JdzRuAD1rnTpsMTUNtEHQJuXwRnFOak7v4dTW1c/VpzrBpJ3z9PgKU/zdzkbZR2fdxHcUGHG8lZtz9U6LES7hNthPrzwKtCJ/Q7mXtUrAYTNH/OouBikcLgt3BpMlO3Mx8a9GBKDg5BFF5HrXUhlzu1RGbF0Dal6Viw4tc/XWWMzoQpci4yobpFNhDv/SUU6Zrlurw3hDjUor8vV/dgeNDLR5NfAKVI9EXufuGiOqMX62TfEW1wBmBWqamuOfFwCSWfad3RfyE1Tb/sgj22cZngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrJtrBjQ9l1H5FTSkB++6DFNn3hYbUddGSJMrP/ctAI=;
 b=ItgqykyCWhsEshxHrI30BUcYOT4wIxoW1UwT7qKK+u8jW/xPGRGP7FsNxapd7uotgJZ1NfZ3HIPk0HfX1AMwyqwJIlTME5jSpW12Evh8prw+nfbFfdqug3gUEyAg5+JCjZxkf6Vi7kiI01utp8Gn7RcxG/7h9B2zMd+v3aWgW4Tjm8LawOR3197bxOmgqvrjNqnK1Lv9gR6j4d3uWZoGrWF800L+sSyl6MEd4oo3QvXPob/9l2X57nNVZlLBOZWdm31b3iSX7OVvyHZr9uuDe9H+HWPRRQIJmSCam1I3POhqTTfq+rnP1LJwIP5r3zpk3MzjrCuiLK1MsbWWQT1PSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrJtrBjQ9l1H5FTSkB++6DFNn3hYbUddGSJMrP/ctAI=;
 b=HYIaVDrKsaBTAl9z7zlXanjkIGHi850OmJP9iyqafHoImhRQM8iLPcTRe+1SuJzBSKzxvG5lwsy50X2D++riLmDuXQdraTcCVUhAnz0h3AJsTf9lthfebjSDSFcOBkxkqwcva+7NzsGCs5adGTBfpFS5GHvHy+ihUi3qFRuMVyvaVqcRxaMKlg8wEPcrPd0A89IVQ7ugQBE3Lyy+KDE8539/4ok8OTjx62G1ekUAU514M8CxXlq9kQ3ZYTlk+kB7Ltn+N8SwZDqZw0kjFg6Y7+VAzn4Cp5urMiIsdRYVcz6F1Xj2kefibvcUODliLZqyrpzsWyBB2jZXBBCbME+u4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:54:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:54:01 +0000
Message-ID: <9615deaa-5eca-46e8-9d96-e786bb050916@siemens.com>
Date: Thu, 20 Nov 2025 19:53:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: schedule delay 15ms
To: JerryJun <jerryjun123@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
 <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
 <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
 <077351d6-f855-4034-ba1c-3c9f2b713743@siemens.com>
 <17aa2896.2b1e.19a8043a959.Coremail.jerryjun123@163.com>
 <78da3e59-a848-4019-aa53-639f2ef22f33@siemens.com>
 <7fd14fcf.a9b1.19a97976af9.Coremail.jerryjun123@163.com>
 <90075e27-a5ee-4e84-a621-eb8a69198590@siemens.com>
 <45c8c387.6dd1.19aa0503297.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <45c8c387.6dd1.19aa0503297.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b997d1-1a31-4e27-c94e-08de28662b7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJrdkswMTVHbW5yM3BLZFlGbzV4WE5OdjZ2VWtUQ2xmSjlyUVVpNGdyOTJr?=
 =?utf-8?B?SnBkcFNSUGx6eFdBYmd1ZUlvbStOS1VmMmlSWVpxaUcrRUp6THZoVlpYZkFm?=
 =?utf-8?B?dHVRQ0x1NUhWVUt5RjBZenF3QkloWVlxeVRNMStZamhnVkZCTUhLWHUyVGo4?=
 =?utf-8?B?b2tuOFd3WHpCbnBkSm5saFhRTmlpUW5UcmQrOEhiM2luRXRrQzBqcURhWXBj?=
 =?utf-8?B?ZTNpYkRhRlplL1FLVkYyZ3U5QjlTSlZLMTEzcUtBVVpaV2syWlkwOVF4REJW?=
 =?utf-8?B?RkZYZkxPMzQyTi9TMW1wNW9oWVRwSEcyTkZleHBIZHFiQXl5RDlYcFd6ei9O?=
 =?utf-8?B?eGxqMnpWQWtybGNYREZGaC9jWFR1NEhSV0I2SGJIMTlJaVJrZ0RZUDNjUVh6?=
 =?utf-8?B?RnBUTFlaMWhXdjh0Z3NHQU9JOUxySEI5dy9PQ1AwTW5oMHEyUlBxOUtWZ1dD?=
 =?utf-8?B?TFVEc1kzQ2hhRUFSNTdxM09SN0xVM2RnZ0orRjlyRENsNlZ1Y0VseHhDNW1n?=
 =?utf-8?B?elUyNk9Wbi81VjFZdDJ3b0tGNVhFM05nNWIyT3ppWHJXcXMwejArRDNERzNn?=
 =?utf-8?B?Y05JVElTcHQzdUFEcXNDUVB2OGIrSjdhTjJnNHNSNzlVc0RVUFVEVnNnWnBu?=
 =?utf-8?B?RUdxcTEvK3pMMDBjUFEzZEt2OHZhYkQ0SitVcXh0U1BFSURRbEtnQUZESTdp?=
 =?utf-8?B?cC9vQ3FWc013cWl3a1AvZDdlcnhNbE14QjJBckpQVmNOcFZpcVlxMWtEMmFZ?=
 =?utf-8?B?UWoxeVQwYS8vemVlU3pYZWtFYXBmQnJHeDJNK2VjUjV2eWFtTkhYSGcyMXFv?=
 =?utf-8?B?VGNxSEZ3WlJzK242TEsxdmt1Rityc2tBTUdBcGVCM0xnYWJMVkdEUlQyY3ls?=
 =?utf-8?B?c1dtYUJXZ2FxeVpBQnVuMXpRU3RHYUh0enMyMGpkeUNKdWduS09KQnRzdFZs?=
 =?utf-8?B?MEtJaGw3d3Bmem5yZzgrRzNUb1JTKzJSNko5VExyOUVRa3VFcWVPd2RsSVdr?=
 =?utf-8?B?S05sOTNsWnFoQXBpbVZIUUVlMHRGaEtJTlJMM0w5czI2ZmE4cHJaS3NUcFA4?=
 =?utf-8?B?V1FOVWhsYnpZdVozZ3grWWk4dnB0RHdHeEhCaE9VMlNVU3NXdjNOTnFmSDJU?=
 =?utf-8?B?eXJxMUU2NnNHWGIvTUsxYTE5SFNtOTAzQ0piUXByWDNPOExGTHRleHBZMzN2?=
 =?utf-8?B?WXNKUWpLcUtoa05PL29HM0xUSmlTc3Z5YWZSbDJ5Y2crSWpMQll2L0tzSHhv?=
 =?utf-8?B?WGFndE1Mblc5VitlUStzbEVSWS9YcDFiamNFRjltRUhsd2ExR1hOcTZsSS96?=
 =?utf-8?B?YWxLRTdyNEJMK1hsSkpVMVF5bTJENFdUeEdpV3lyckQ3MDNKWXp2bDMydmEr?=
 =?utf-8?B?TkEzc012U1ErZG5kRlJrNnFDY0dLVzdoQTRVL1pwMjM0elZTMTI3a3NRbGl5?=
 =?utf-8?B?c3R4d04zRWd2d3dGMTBjWkhjSjNFdkU4V2YwL0syOHZmTFdrVGdQT3ovWHVn?=
 =?utf-8?B?SXVTaW1wODY3VkN1azZkbHEvRUp4aTNBdEhjblVyRDJUSkZlOXl6Y1JoZkFV?=
 =?utf-8?B?c0dvMEVrTGprZ3JyWnY3ZnNONEdpUzlTT3JvRVRQalRERE9pSjdUYitsOVJG?=
 =?utf-8?B?azNRcjJPNTI2dnpwemVQa0lNa0t6MTAzZzk4dEd6SVJsWVdHZVNFUU9iWHZo?=
 =?utf-8?B?VlBQY0p1WWN5VkhPcHFHSWxleWZtSit1bE5Jb01MUDRncndpMXI5cVYxVjBB?=
 =?utf-8?B?WHI5NXRJNGs1RW9TWmRkUlZBaEJZV1V1dTZzYW9LS1dEU1U2WnR4YXVkN0ts?=
 =?utf-8?B?VUJKNWljUWlYcUp1WjF4TFVsRTRpeVRYV25UWDRsVnNLUmdWYlhXaEN1Q2ZX?=
 =?utf-8?B?M0QzK0NYTzk3Mkp0eFBVbVo0UldrUmNkSmdzYm5aMnZyRUt4MlFZdXZQNXNw?=
 =?utf-8?B?QVRHem5nZ1dNaVl6MVVpM3FjcWYyZDF6R3U5WmE0OU42cnJVcmdpdGp4S1RX?=
 =?utf-8?B?UnFXWDBsb0pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bndoZmc1WUJyUjJNY1ZHMi9OU01zaGpKU1ZXYS9nL25NMVBFQlNScjRwZDZK?=
 =?utf-8?B?Z2tZeGxXQWtpbTdjVmNRK0NveENnYlJsR0l1bW1RY1pLUDErSkthaGJMU1Fy?=
 =?utf-8?B?NElDdWY0eEZaNVQ4UjFpcWwvVU9yRnFBK1YzS2F3RC9zb2toK2hKMFBSSWdy?=
 =?utf-8?B?bDVFbmM5Mml2aC96UjBHVENzaTFyQXhIZmk1N3JIUWg1SGYzZWpFeHFFaU95?=
 =?utf-8?B?dG96YlJXeFVmQ2dsNFRTNUE5RTQxa1Jyb3VFTGVrTWlseVlvbW9IbWJuOSs1?=
 =?utf-8?B?bDVENlFPYnFmOHJyNTVUQzI5UDZmTzcxV2tMcVRQTkVHUktpQ3lqQS8vaDNE?=
 =?utf-8?B?WmZFTGlxbGJPOE00bWVLeGFldWc2amtZMExkd1hyVmpEWnlabnpVcFh4OU9E?=
 =?utf-8?B?NlJiVitPS3NQb2FSSDJscXVrTjFIOFQzaXd3RCswcGtPbnhFNVBtalBUbWY3?=
 =?utf-8?B?YkFXTDhJMFY2RHJqTHpET29WdU4xUElkQmpHM2U0enRVRXhMQTNldElPWG1U?=
 =?utf-8?B?cWhkbDE0Zkl3MjV1SEdGQzhzODd3cmpjdGxKSkVta1lyLzZhV0RKZi9oQ0gv?=
 =?utf-8?B?NG9XaTd3SW43K3MxdHVram9qbXk1OGp1dzY5cXNIZi91eTRuYnoyb0ZGN0h3?=
 =?utf-8?B?RXQ2aDdJMlRwSC9QTTVMR0Jka0hPK1RaVWRFZmlRMklhanFrbE4wVnI3cXNM?=
 =?utf-8?B?ZjJMOVBLUWIybmRUMjdxc01WK2lqT2hGcG5jeWFrSW5CdHJKYkFkSGl5RVE5?=
 =?utf-8?B?ZGp4ejRXVmNFYzBmdG95QndWT2I1MXJxT0tzRWVQdHFPbDgzcnUzNjAyeGtz?=
 =?utf-8?B?Z2xNVHBtaEFVRlJuMytEU2NJR1VJZzlrRitvd0Q1VHBSK3E2bUx1d251ZnhQ?=
 =?utf-8?B?K2tzZWJSU2Z6YksvWERFS2ZDQjBLVTdYRFZBRzlkajArOC9NUU54Z3RVcmNU?=
 =?utf-8?B?MmZQMDVGYW0yK3BNSFZ0NVdmQnR3QUJ5R2U5RXJsUFFoT1VnbGNYQTFPNlc3?=
 =?utf-8?B?dDROekJURlBRN09TZ1FFNnhJS210UEp5bE84dURPVGxKc2FuVnNobFFwdUNw?=
 =?utf-8?B?L3lheWNwZExreTU1NmFud0JzSmJ2NFNIcitBcVZkb0U5TmppNTFoWGFFMzd3?=
 =?utf-8?B?WFhBa2tjVklJM01RaEdsN0J5QU1SRm9mNkFnZFZZMUcyTFluaWhIZnFxTVM0?=
 =?utf-8?B?NjRKeExvQmUzVzB4aGYrZWdkbVpjRy9rdFh5K2hiRkRhbSt1THdnY01MWWFn?=
 =?utf-8?B?ckcxU1N0bVAvcDBUSlBJR05xU09MZDhzaXJURGx2MWlJZlFoaWRuYnNDamF2?=
 =?utf-8?B?bGFnbmpKTDZDNFJCMm4xY0E4aUhLQUdjZ2FGdmFXK2hzbnhPYS9rYzZOS2do?=
 =?utf-8?B?eDNrUUNzY2Vzb1djWkRGbzdaNTRxY0JLU2RxeTRvMWdRWmNNYWRIMFo5OGg5?=
 =?utf-8?B?dE5seG5WYXM4cmtxSTVWNUlBemJwa2d2dkdEMnhDaE5hZVlPa2ZLeWVHMjVl?=
 =?utf-8?B?REluNGFBN0M1UVplNmN2Y2U1b1lDem91RWcrZTY1dnd3VDBDbllKLzYxL2x1?=
 =?utf-8?B?eGJrT0tRM1p5ZWpleU1HMXRmUXhqck5Ua2hjZVIxMnVkSlB5RlJ0WE5Eb3dV?=
 =?utf-8?B?MTFWNmo4eEZvb2hVdFJBWVZWVThGczdkZXpaTFI3ZER4WGhDYWdlcENvUGNp?=
 =?utf-8?B?L1M2WjdjNFk1WjF5dHBWb0x3TGJYYUZKWkdCSmp4cnFWaHFFakQxOWUyZEt0?=
 =?utf-8?B?QVZjV3NrOHpWWVdDYWkvcjdTc25JUUtIMUtaeXpHZU5GMWw3b1BiS2tCUVdi?=
 =?utf-8?B?MjN4SjU2ZDhOb2xpdFF5U1BueHM0RmxpRU1lNDQycVYwZGFBaEdwWTA2U3VQ?=
 =?utf-8?B?WXpiUkZLU05RMVE4eGxkbkllOUpTdHBjUlREc1VqSnZRby9lZ0w0NGEvUjFn?=
 =?utf-8?B?Y04rSC9xbVVqMnNnVnpyOFBRQzFQSkw2VlVobHcvc1ZGMXlSTk5zMWRLbHNM?=
 =?utf-8?B?TGNqNUtUekNJdEwyRnRFVjMybWoyNG5VSDI3Z0hqdWIyVm9nYXZiNFkyb293?=
 =?utf-8?B?MTZkWmJRKzdYZTlieUpOeis2NlpBYS8xdVh5TGI4bzg2amNrQi9pYzd0RmQ1?=
 =?utf-8?B?SnZ5ZTdrL0lScW85R1BZNytpVGRQbjRaSEExN0NZQUdaa2llV0FYdm5PNjdv?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b997d1-1a31-4e27-c94e-08de28662b7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:54:01.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rh/qR6JXD3XrSQMbkBXv5BZy+FRlI4EQ5nMs6jrz/NPHhqholV9AHqJddReZeT3ne7kWM5FsQEp7XFarAiV+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364

On 20.11.25 09:10, JerryJun wrote:
> 
> Which configurations do you think could cause this delay? During this process, the hardware remained unchanged. We used the following configurations and attempted to disable certain features in the kernel boot parameters, but it didn't work: xenomai.smi=disabled intel_idle.max_cstate=0 intel_pstate=disable nox2apic
> 

I cannot name a config option yet. But rather than comparing those, try
to diff the structures of /sys/devices.

Another shot into the dark: Boot the kernel with efi=noruntime.

BTW, x2apic is harmless, actually better than [x]apic, but the latter
should also not cause such issues.

Jan

> At 2025-11-19 00:00:12, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 18.11.25 16:31, JerryJun wrote:
>>>
>>> Strangely enough, this delay wasn't present on the 4.19.89-ipip kernel - it only emerged after upgrading to 5.10.199-dovetail, despite no changes being made to the power management policy or thermal throttling settings during the update. Could this be related to potential instability in the HPET or TSC clock sources? And does upgrading to a new kernel version also necessitate a BIOS update?
>>>
>>
>> Generally spoken, a newer kernel could always have changed something
>> regarding how power tuning is done. Simple scenario: a kernel config
>> switch was renaming or gained a new dependency that is not fulfill ->
>> tuning feature is silently lost.
>>
>> Another reason for different behavior could be the enabling (maybe even
>> by default) of a new feature that has unexpected side effects. You may
>> check if there are new drivers active, new devices available.
>>
>> Jan
>>
>>> At 2025-11-14 13:38:36, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>>> On 14.11.25 03:48, JerryJun wrote:
>>>>>
>>>>>   We added some trace event information, but from this gap point (6208.695948-> 6208.708726), it appears that the Cobalt kernel was frozen and no interrupt handling occurred.
>>>>>    include trace point events :
>>>>>     irq_vectors:call_function_entry                    
>>>>>     irq_vectors:call_function_exit                     
>>>>>     irq_vectors:call_function_single_entry             
>>>>>     irq_vectors:call_function_single_exit   
>>>>>
>>>>
>>>> If there are no interrupt in that phase while, e.g., some timer
>>>> interrupt should have occurred, then you should definitely check for
>>>> hardware/firmware related delays that the OS cannot influence. Or for
>>>> power-saving / thermal-throttling causes.
>>>>
>>>> Jan
>>>>
>>>>> 在 2025-11-13 13:31:54，"Jan Kiszka" <jan.kiszka@siemens.com> 写道：
>>>>>> On 13.11.25 05:00, JerryJun wrote:
>>>>>>>
>>>>>>> We conducted tests on the kernel version v5.10.245-cip65-dovetail1. The test results are attached. During this period, we also performed latency tests, which showed a 10ms delay at 7174.313414 -> 7174.323086.  irq 114 is net driver interrupt 。
>>>>>>>
>>>>>>
>>>>>>         swapper     0 [003]  7174.313414:                     irq:irq_pipeline_entry: irq=114
>>>>>>         swapper     0 [003]  7174.323086:                     irq:irq_pipeline_entry: irq=33027
>>>>>>
>>>>>> So, that is the gap. Did you also turn on irq_pipeline_exit? I'm not 
>>>>>> seeing that event in the trace. Furthermore, I always for get about 
>>>>>> that, it is useful to have irq_vectors events because those include 
>>>>>> timer irqs. But it is unlikely that we missed any in that gap because 
>>>>>> they tend to trigger activities like cobalt_core:cobalt_timer_expire.
>>>>>>
>>>>>> What is more likely here is that your hardware or firmware is not 
>>>>>> letting IRQs through. We could confirm that if the issue is reproducible 
>>>>>> while have function tracing enabled. That comes with high overhead, but 
>>>>>> the detailed result can tell us what the kernel did while there were no 
>>>>>> interrupts.
>>>>>>
>>>>>> There is also native tooling by the kernel to detect "hardware noise",
>>>>>> see https://docs.kernel.org/tools/rtla/rtla-hwnoise.html. Due to its 
>>>>>> nature, this noise would affect Xenomai equally.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>> -- 
>>>>>> Siemens AG, Foundational Technologies
>>>>>> Linux Expert Center
>>>>
>>>>
>>>> -- 
>>>> Siemens AG, Foundational Technologies
>>>> Linux Expert Center
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
