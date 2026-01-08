Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF619DF4D
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888405; cv=fail; b=Sv2fQGSWG5T1BwkLUtzagwoCwdue03tDziCW4FjLYhuLovBXDBhLt/82wT32ZE+1srjH0QRQT+b5uACvYEbvQrSPLRs/Wl9eALHa9xeye1eT+STOq6xqXqpdUJE6JKkGYnTlw0HOPZGWp+gGMrj56QTbSE7bsfMSFHXuMA3Jl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888405; c=relaxed/simple;
	bh=Vnc+BZyUiu3wmibN1kB2mBdry0XXE/8kjywrItqN6UU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vt7rXp6IRYYmDQ+w6G9h4enp/IVitqovY8BbGirYs6UWXqN17UJk5PsmRw3rbr5+V82ozf5EBozESjzif5eaUBDF4AyqOG0zGvmITxBbQjcNVSRBbleabPogkoSy/nztBlw+RsTNVlicKyvKhPysE+TR33vGpIS6eGQc00QbTFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=d2XPVP7V; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="d2XPVP7V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i79THdYcGJe5f9klCrm966rT7z+HEtStUeOzDpYx2PRLCsVTxZMcncr2BGTwuj/0z6syBDi8Td/sEWasuKfCSi2CCqF7wFURehqW2TJ1b/twFl5ynrxbu118+6nkmOmXsSkOQOEwjaJLcBPp5Spb6QMxz9WTvJxAON76VGCpGa4eb9QeSbYGc59fWSMkWQNONU9TaKsKc8Tlf3va3WJYRXM8H9ZIXZIhT5XDHh6NQjdToA0cux2/L4ciuQAnCAATfivOQ4vtz7VebFX/p8r8s6nTSuPVjEcoCWud/AtLTtxp2HQ1Hx6J5xCInIt6axrEcSIZNAE4Z/4JfhesiE68rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfbTFejJDPzp+coytz4lc72dQR2HxpnwOBDn6TbpjBo=;
 b=qtd2qdx9RdBWV8mITjlWSW/MT6iR3k7xZA+Bcpq+MtsT2B4q6EYkjdoQEE9jaiFbDlUHzUQhVaJLrFRFC7eUrlk4Hrep53AB7e96knRx/+TFM8o/TUcC6BG2hB0XmTm/Rf8n/W5wu++zWlJRzagnvfdmHV14lSRl2FUyki0LMMQbNQ4GSyrZxnLq8COTmP52u3ti4MVjidxzicpakcNoMGMPoqPgTbbxYzcXKGeKFr2vsI+pGwKZQdO9PLXr3FubKCGbFQkAkx0kD43L4g9VgDtg41MkhkbWhSDzpEAqD1H9Hv2Zxkmi8XUStXHMJgDwLTAfg+I8fie7+VF+gm6Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfbTFejJDPzp+coytz4lc72dQR2HxpnwOBDn6TbpjBo=;
 b=d2XPVP7VDYLt58yGHaeuG0D2G1/xRvRH/FU8DvMkYB0S/VudPtWHAnrzXHRgfJy0dDVTVR2UtZO/4ZNX3Qf7biH0gJN6Xb/fF/mHd4mnDQUS107k19S3L0Sok3bUP5wT90b6LTUErynxv/gRlIJ6bSZat2xO70XX8NQbuJwTxY8dGWtoQZdVdwFkZCjC5fwO8mTR2vrWynIdS3UaH+124qgaRcdIyfAaNjY/gSNKJKkIxeH/Rcs8Ti8IkPQ6PFF5w8bM0bpCXY+LSQ9H1SYf2PftJ35Eo4ApzDRfDHfWuVDk8eb1wcdoPWmYaZoc+b+g61mY/XQXbq6LlIcYkPx0Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:413::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:06:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:06:39 +0000
Message-ID: <8e273236-5213-48e4-aea8-ef47825ab2ce@siemens.com>
Date: Thu, 8 Jan 2026 17:06:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wip/dovetail-riscv] riscv: irq_pipeline: synchronize IRQs
 on exit to user mode
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260108094551.92100-1-tobias.schaffner@siemens.com>
 <DFJ5SWPCJUZ8.1DRILTETK05GX@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <DFJ5SWPCJUZ8.1DRILTETK05GX@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA2PR10MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a813de-b0bf-4cd8-bdc3-08de4ecfe845
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1lrU2lvRldqbi83anE5S1ZScGcvRUN0S2VNK2c3ejlTQ3FTS0lyaWM2elll?=
 =?utf-8?B?QVE4WENJTTNtOXBwcnJaQmRFWTd3VnZ2ZDZNbVdoTThSUnlhN05OSDcwVEFL?=
 =?utf-8?B?Z0hBTHZPRGRiWUxZNUpVb1FPQWl3WDM2K0RoTlhVTnUzVHFYUU1yQVJBTkVx?=
 =?utf-8?B?RmJLVFVucjdjencxaEYzRDhZSEdyUlh6RG1Oa0pVQXJhazlmbjEyZTRMOHAr?=
 =?utf-8?B?NkpYWGlIbmVWUVA3K1hrK2MwenFWcE1ITUxZVlRmc3V5OFdYTUN5ZTdhSXkw?=
 =?utf-8?B?aGt4Z0NoUC9MdVZhU3V6eCs5VE10ZG82THcxZ1hOVTdIaHpTd0ZHeEVTNytG?=
 =?utf-8?B?S0ViVmlIQ3hiTkVzN2JYSjNBWVAvTW9oZzFZOWFRcDQ2OEhmdzBnQnpKdDVQ?=
 =?utf-8?B?OHowa3A5aUxnSzBMN1paeGpkSXVOUHY2Y3h2TTRGSFZnWlZrYVNxQXFVc3Ri?=
 =?utf-8?B?TjJ2MFVqNng2bWI3akI3LytHb1hOZjIweFMzek04Yy80T0xQbnhZWGdYYjlS?=
 =?utf-8?B?U2xGQXpuZC9ldHJ3bFVHakhJdU9YUlFoYjBDZWxoTDNnU3N5SVd0L2E4dnZx?=
 =?utf-8?B?ZmU2c0JXU1dyUzcvZFZBdmZOL2ZPckczemxvdTIwR2lMMWFhRnYvUG5aZ3E3?=
 =?utf-8?B?VGRmeTVoNjFEQlpTWWU0UlVMRlpMS29BTUV4Ti9xT2UrQnhNN1lpYUd5QTlk?=
 =?utf-8?B?Rk1NU3VWVldnUTM0Nnlja0tQQU1aQ3UrVHhtb1R4ZTE5YkRvWEYwdGNINzVJ?=
 =?utf-8?B?RHk2NXlvbHRVaTNDck9Kcm4rTmNkcitlWlNmblEzRUYwcXV4dDdlanhoNFpK?=
 =?utf-8?B?Y3k2OU0vVG9uRjBmU0NVaG9KOU5ybDEySXVTS0EvbVVNS1ZLRklHTStiRlh2?=
 =?utf-8?B?RWdSRHVzMkRUaFl4R2xoRUxZYkNLZjlmU1FzRkxPVksxUVBWY0lqYzBjS0M2?=
 =?utf-8?B?L2Y1UDViRjI4akhsTlY0dDRMN1EwUzFkeDFJRWJvRk4vbE5wMzFnNHU4ajZP?=
 =?utf-8?B?SVZhSnA5MkVRQzFZVGVrTFZKWEcycWJKc0lydmhZcFVadGNHWjE3SFUwcUZY?=
 =?utf-8?B?OUkzakpxT2VsQUhONDd6dXlZaVpjM1NMcTBGNExXL1AvTTJsUTlQTWxiYlV0?=
 =?utf-8?B?aDZUb0w1K1EwaUx5bCttRFB1cTFxSjhpZnpMQTFOMXI4dEQrMHhzdHBLYndS?=
 =?utf-8?B?dnRoazZwZ0doSE1RWmM2ZjZQbE5tVTF6NWFqbXJMdmxPb1BuVlZtaFNMWDcx?=
 =?utf-8?B?WndvZldLeUNBV3EyYjNtenZlaUxFQUV0R0QyYmNFTnR2ZlpDc0w3YkF4Q0No?=
 =?utf-8?B?QzFJc3BEaENrNmVHRkFaUVhZQ2JrMzdrOWczbW03VmFLUEVHaWExeWlkQnhB?=
 =?utf-8?B?bm8yVCtYN2dMREVoclhwbGNxQW1DRHd1QVc4NFlrTnV1Q0NxZGp2NUdEcHlE?=
 =?utf-8?B?dHlNUUx0NTFBb0dtZGlzNWd0Lzh1K2ZrRmhRZnlmaGlxanNjWEpGY05EVVZX?=
 =?utf-8?B?M0E5TEoxUmR1VEV2M3piWU9UdlJIaUVWTTRSdzdGcVJyemFHWWY5N0ZQZlhp?=
 =?utf-8?B?WDJtVW1OZk5VZGl2SDBBd2ZMeHd2ZmtnMFU3bytXdkczMFdnc2NhamhHZVp4?=
 =?utf-8?B?RTdiMTBHNEtWTWdVbFZOUlVnS2x1eHRCZ1YvVnVMdzdNSHpRMkxzQjczZkxy?=
 =?utf-8?B?SDBUREVraDhScHVtWUdYZHJRTGFpSzE1eng3ell0NWVGb2lWQTJORXNZMXEx?=
 =?utf-8?B?blJxQ1puSDZVbjZUNFh6WEFFOEY0Z2IvOEZRdEYyWC8yY05DYjYwdDRpSEdY?=
 =?utf-8?B?czdMKy9TU1VpQ284Ym9hbUtrNElMZ2srVi9PLzlBTlhGVnZzMGdNZmlkay9Q?=
 =?utf-8?B?L2J4WkU1ajcvbTVMMTZic21EUnp0SFpPeW0vUTZXekJkYUxkTUNscGlUeWdk?=
 =?utf-8?Q?0y+HfYpcMFL4Vb8C9ARqYR1BPgJtsesV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNJNFlDSUJmL2tFNXBqSGRzcnhYSURjRnFvZlFqUFpBVVIxQ05ZbFRuNWhC?=
 =?utf-8?B?M1FEVXV0cXQxNFl2djRMTmVuYktER2Q1WjFYNnBLZkxMZVN1c1JWL09Id2pQ?=
 =?utf-8?B?V3RubTkwZFVTeERRTWUwMFFJcGdaYjRVbThIbHlEbWdmTWJtRXRFRkhqclU4?=
 =?utf-8?B?S2dPa0dwVzJZYVF0M3M5N2FGTDQ0RlUxUjFXWWJxbkVxM25saFhmaFRrMHdr?=
 =?utf-8?B?QklGSWlaaE1GYVdCSUVwaWtQTmEzNjRiZnBYdTJ4M2k2bzNMOWNrQ3Z0V3p2?=
 =?utf-8?B?eXVldmVsV0VTR3pEeVZOdkJrWHVOZTQrSXpTdDVrTGdaNUh6YzcvU2g5djB4?=
 =?utf-8?B?RjNOSWFnQjZIaE1WbW42Sk5MYnRKNVBGeHZjSFFQbXVrWFZUZWZFK2ZZN055?=
 =?utf-8?B?b2FzMVhRUHVOMitSTTQ1UGcrdCtBS3puUUlycktLd0JpRWFnSUpSRkRlLzQr?=
 =?utf-8?B?dHJFR1hNN1ZuR0VqOFk0SlZIYldINlc2QzlidmdqczJ0RFNHMjgyRGxKUmFF?=
 =?utf-8?B?QjVCV3dySVVvQ3liLzh1ZU1DTTJaUkhZNkhsU054dTVmTDIzZnQrSGpFd1lv?=
 =?utf-8?B?TEVsN1FCdVhWZW01Tmc2YnhOUDdZeUtWMWcrcWxaZ294QUJ6aFNDalZoMGlR?=
 =?utf-8?B?Ymt2SUNoMHhwWXFRWnRlMEFxekI5V2QwUkc1TTdCc043RVgxOXFuc1lRL2lu?=
 =?utf-8?B?cDYvWEpsbXF1YzZvVEhOUnJwc3BaUmQvMEs3bTBZU1BlQ2RMVnBQY05ueW5i?=
 =?utf-8?B?Z3FnVWZYREQrUFh3c0Q5S0dkek82Z0YzdVdKcnp0eU5hdDZxblczbGxwUVZi?=
 =?utf-8?B?TmlqN2xadG0xRFc2Y2ZvcUthR2pRT0lkbzdvajRWZHVrN1FVRWVOL3NzMjZN?=
 =?utf-8?B?R1RucGtVMVZLOGRRZitUZ1pueVM2YTloZDA3V29TVHNRQ053THpDcGxWeU9G?=
 =?utf-8?B?dzhiZVY4VTlYRUFocEZTMU8yNE9PeDA1ZWRlWTlZYkpYa0tXUmRsam1aRXZ4?=
 =?utf-8?B?a0N1a0FCQ2hnb2Zwcm85eFg5c052ajh0eXFBMlNwcEE2eW5YaWduMU9oSElk?=
 =?utf-8?B?cVpLeVB4cm81K3BkMWFNeGF1OUhjNjFBZUdtbm9jbmNlY2FhT1JQU2Q3Mngy?=
 =?utf-8?B?My92Sk5tSTg2V1hoZkVjcmJiVTE5eW5wcEl1cUpJMU9kRGNBOVlxWFptNHdM?=
 =?utf-8?B?ZGFHM3dzSnJTTVFBOE84TCtiYXBkdzBHL2drL0VFUUgwU3Rnd1l0Y1dYRy9L?=
 =?utf-8?B?OXNYQjRRUkpQMGwwOFJyVC9VUmhEcTZsNS9JcEQvS0wxZTQ4d3Q3czV4Wjdv?=
 =?utf-8?B?VkozOVRtTVo2U3VTL2s2SkJxdXBtK3pwTFBvdFhaWmk1NnNFL3BPVldaY0dJ?=
 =?utf-8?B?ZjJTKzRzTDVXMkVBT1RVZ01randzK1lNZEtGQjNPQTBmQlFCU3dKRjQxWmNj?=
 =?utf-8?B?VkJUREpkNnVDeEwyV0hHckJQQkN4MmJBUE0yQ2NaRmpub1FRdjZnYm9ER1dw?=
 =?utf-8?B?bXh1WkNFOUI2dkhGc0g0ZmdjRUhYN2gzaDBwaXVPZEIzNUVQclkzWlRnNFAz?=
 =?utf-8?B?K2dxS1hzY0ZHdm9UOTE3czlTTmV5VXdqdVVXTW93dzZ3VWo4NEp1RTh3eTZq?=
 =?utf-8?B?RlN4dWlHekxxMHk1cGxQbzVHOG8ycUdudjYzM2lHM0FDbW9mek9ZVXV4VFpF?=
 =?utf-8?B?NnlycGlPWGxOMFUzMVBwT2doWG1wZXQvVlB1dVZEcEtLbGtrM0diM2ZWdFk4?=
 =?utf-8?B?bVFVd29taUdab1E5T0RJdUJ3UGtpSWI3dUUrNjBUdXdLM1Vkeis2OGlTV2tR?=
 =?utf-8?B?bkVUOGpEb3Nndm9FM2JQNUVUUm9ZVHR1ODUxU2s2aWYvLzlWMFkyLy9TVmJm?=
 =?utf-8?B?L1VXQlFWa2lMaElxNmh1a1dTbU5FaThMTmkrUFI4N1Evd3lLRERSb0I0bTY3?=
 =?utf-8?B?bTNKeElZN3d0UWRKdzhuSmtpTCtvaGMwclgzNmVYcEJjZDl2TXV3U3NEaFR1?=
 =?utf-8?B?NEVoYVl4QkNEZlAvNXF3RzJpRkpDWUtMUHVCQjQrY0R6OWFnN1hIeEo4Tkk1?=
 =?utf-8?B?SFJab1lhQkVNaTVNTURjbmZObC9NRWhrYlUwWVhITHVLT0tjQ1Rldm5oZXBh?=
 =?utf-8?B?ZjgybXYya1poTmdWaTVjMEV4eVlMbXJWVmZxQyswVm1BSDFSeE5haWRDa3Bj?=
 =?utf-8?B?YndIS29leU9MRWY0OC8wMHNHalF2TDNndnF4d3pGYW9jSjY0b1Z5S1ZTaUdD?=
 =?utf-8?B?ZjZmOEV4STVHaFpaL3lVcEx1WkRhcjd1N3lqeDNoMTFzSHFNb20rRzEzNkVI?=
 =?utf-8?B?VWdxT1NNdGZmdVhHNWZGRktoYzdZMGtERk9VdTllbTdJUm1yS3F4NHVWZ2hF?=
 =?utf-8?Q?PWc2ZxtIQ8hRb+7Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a813de-b0bf-4cd8-bdc3-08de4ecfe845
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:06:39.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk+QuIjRqWFY0vEajs5jLfqR9kGAo0RUClhfzS76PNV5OqlT3xMRuCci7EFS+gX7gu1sqdJGgmqQ7iai9vRXjqShAv/ftDs3BmvXDbRR4Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8962

Hi Florian,

On 1/8/26 12:08, Florian Bezdeka wrote:
> On Thu Jan 8, 2026 at 10:45 AM CET, Tobias Schaffner wrote:
>> Ensure that any pending in-band IRQs are processed before returning
>> to user mode.
>>
> 
> Two drive-by questions:
> 
> - Why is risc-v different here? All other architectures seem able to
>    use the generic entry code.

I do not fully understand why some IRQs get lost in the log yet. There 
must be a path bypassing the gerneric exit code. I am further 
investigating this but for the moment this fixup is unfortunately the 
best I have.

> - Which Linux version is the current baseline for wip/risc-v? It must be
>    something < 6.17, as the generic entry code has been refactored in
>    6.17. So please note that once you update the baseline you will have
>    to do a lot of entry code alignments.

Thanks for pointing this out! At the moment I am on v6.12.y-evl-rebase. 
I plan to rebase this to v6.18 as soon as it is released.

Best,
Tobias

> Florian
> 
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   arch/riscv/include/asm/entry-common.h | 36 +++++++++++++++++++++++++++
>>   include/linux/entry-common.h          |  2 ++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
>> index 2293e535f865..1f6189413a19 100644
>> --- a/arch/riscv/include/asm/entry-common.h
>> +++ b/arch/riscv/include/asm/entry-common.h
>> @@ -7,6 +7,12 @@
>>   #include <asm/thread_info.h>
>>   #include <asm/vector.h>
>>   
>> +#ifdef CONFIG_IRQ_PIPELINE
>> +#include <linux/context_tracking.h>
>> +#include <linux/irqstage.h>
>> +#include <linux/irq_pipeline.h>
>> +#endif
>> +
>>   static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>>   						  unsigned long ti_work)
>>   {
>> @@ -22,6 +28,36 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>>   
>>   #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>>   
>> +#ifdef CONFIG_IRQ_PIPELINE
>> +
>> +#define arch_exit_to_user_mode_defined
>> +static __always_inline void exit_to_user_mode(void)
>> +{
>> +	instrumentation_begin();
>> +	trace_hardirqs_on_prepare();
>> +	lockdep_hardirqs_on_prepare();
>> +	instrumentation_end();
>> +
>> +	user_enter_irqoff();
>> +	lockdep_hardirqs_on(CALLER_ADDR0);
>> +
>> +	if (running_inband()) {
>> +		struct irq_stage_data *p;
>> +		unsigned long flags;
>> +
>> +		unstall_inband();
>> +
>> +		/* Check for pending IRQs after unstalling and sync them if needed. */
>> +		p = this_inband_staged();
>> +		if (unlikely(stage_irqs_pending(p) && !in_pipeline())) {
>> +			flags = hard_local_irq_save();
>> +			sync_current_irq_stage();
>> +			hard_local_irq_restore(flags);
>> +		}
>> +	}
>> +}
>> +#endif /* CONFIG_IRQ_PIPELINE */
>> +
> 
>>   void handle_page_fault(struct pt_regs *regs);
>>   void handle_break(struct pt_regs *regs);
>>   
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 1d15bc4ebeee..2cf32471f784 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -419,6 +419,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>>    * non-instrumentable.
>>    * The caller has to invoke syscall_exit_to_user_mode_work() before this.
>>    */
>> +#ifndef arch_exit_to_user_mode_defined
>>   static __always_inline void exit_to_user_mode(void)
>>   {
>>   	instrumentation_begin();
>> @@ -432,6 +433,7 @@ static __always_inline void exit_to_user_mode(void)
>>   	if (running_inband())
>>   		unstall_inband();
>>   }
>> +#endif
> 
> Especially this hunk will look different in "modern" Linux versions.
> 
>>   
>>   /**
>>    * syscall_exit_to_user_mode_work - Handle work before returning to user mode
> 

