Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF126F2BE
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598174; cv=fail; b=K+DfZYlv/ULShcZPVKNNUMpQxlcSTE+uV29BnPEIKfETdB4dyl6lv51dvl9y6Gqq2ypn6gV6sZRG/DPlDziWA2S7D34L9pKyu8FJTOZ4m63rlsNQvffo0phYwyxsddq3J7dQTYixOPLv1AhGqgv7COKACfbQkB6hMnKma0KSORc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598174; c=relaxed/simple;
	bh=Nb1gfWVjnJ3BacXF5mrgFd0aDcL0ow2uDP9j2J6lHhg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTTYhad81jHAM6LJIhndjLiqqNHX/0FMJpB679i99e4hHVWlrIrkIUwvP7U/d+Zuhp1eQSbDdj4f53lK6qyDs0TrrNglWWmMZLp6qmvrhJCHqmbz3Pbup0ZGwDUCD/O0Z3b8gPsmf/lR3f5Z74rYpOynqua7rYJXH/14xrmxMgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F30UoAnU; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F30UoAnU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhI3frLP8FPKDiJ71dCnTbbOqPV8EsoiztEVkA28f8SdTNv50jobcqoLADmx2F9qYoSbG9wVX9DFCzib3K7oZcR1aMcrxwvLNFW382wXKuSFVMtQhs4LLjt/1IoFHCzpP24c5dSBR0m2qua0cIlUpPkikx8q0QIvI3pnC/MHMU5SAtGDyMLPUq2Dlig6s2aQ1UmqjKTNoxQAlHdb59vU6KB3otWRgzPX/6pxbGODB4AEjO7MceAWoEhIMfJG7muXfTXsmEteZ+1E79Qm/ugsK/II3cCV1t1SfIi/oCWqIEWzq79qOWdTyzJ8XRT243+XBjoIKuybIFrz+cTcsXp/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiHr47XuAau1JdHmXnkoGDyD9wWeuSKnmGpOdm0+DLg=;
 b=aRDpTbjnQ2H/Vr3edHOpRfsoV0YOEFn8aSjuOiV6T5t59KLI2SwSy3lAzoMiUC5qkoQ5/HHNZ0cJWsCqaay1gCr6NpIl+TbPtJJoUqaX/8DF0VCMFY8CrQCRJ2XIX3u7KqCW9wol3X0clT0oweYYm8JVTlJuzLQU+sMl+dPKAkPwL06m83kumh5Od/N1Gs3W6whM8OGrbZHqHZ2amHzrl98ug0yED1Q+PdC8IhQIGf1RREKDSLTv8ucOn0+HyQYBeG8EJBwnV6R0XlTlT3dmHOk6CetDi6a10FJAbuEBr9HBsKhbJPvCQkXhEe9cX3jsDHls8Xs9RQ9mkwXnRz/BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiHr47XuAau1JdHmXnkoGDyD9wWeuSKnmGpOdm0+DLg=;
 b=F30UoAnUUciu6GW2qOAsPcNuZIHDVUfpPAb40+zYzsGw4mztXXMuFQkwnxl4F+VSxnajip4//MKWWxvNATH3SAG1nVPhspx9IE+Rvn0ioFluurZpECzapiUHt02zDsZFoquvP95Y2xNPFRef+X35xSot8HBi+7RRMppGU0MigRCrneQEJ4w/F2yAfzfjcZh5io8vH1JsUoCndMv+iBNi6UUDdKA5kLdmYc5TIFjz4vwO6OGZluI6BboAkfK8CY+S+F8e2SWvc/XfalaWE6UA0tduB5/jSJ9qH5U0I2UpMo88WXabTzBZe/mETY6AYUPBkrzPWahDgMCPF3PNzrKDgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 14:36:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 14:36:08 +0000
Message-ID: <91cc0a1f-e1f7-4ce0-9607-606839d0c01c@siemens.com>
Date: Fri, 20 Feb 2026 15:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] lib/cobalt: Introduce wrappers_time64.c
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <20260220-wip-flo-fix-time64-32bit-native-v1-5-731c773e72cc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-5-731c773e72cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7ed1ee-7696-40d0-20bf-08de708d62af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUYvQ3gvcFpPajU2eVQxTEM2TklaS3BrbEVhU0d1LzZYbVhrMzJibWxKamJv?=
 =?utf-8?B?QU83QmNXYTRSbmdYclJjMGNsMXZWMk41M0NRcU9KZWZ0OXZDMm5FSkpSLzBy?=
 =?utf-8?B?bnR4ek05QzNkbWFPWnN6SW5Fb0tuWWpkYWdGRFR4SVF6eWVnUzVQT0oxdldh?=
 =?utf-8?B?alJYd0RpcnhkZmZ5ZXFPVko5cFBjU3NJUjhsVEFNSlF5d05Cd0ZXK2dyTUtE?=
 =?utf-8?B?ZytQdW05YWpKcVJoK0tBNnNHck10VUR4dllpaVNBRElLRFJpZVA0Z2xxYzlC?=
 =?utf-8?B?Wk1La0taaEV0Y1l6UmFjejZXcVlUbkN3dnVXUzVpWXhUWm5pc0V6blVZdjBM?=
 =?utf-8?B?TFRkbWdHNC9ydmdvUS9wQ3U1c25SZGZIc3pFbS9LanZNM2czSmZ2ZjRPbnkz?=
 =?utf-8?B?bnhJN0p1d3phMmIzQkpyU1dEbE9PRmpwQnJGODNkV3h0bUhqd3lVTUFscThT?=
 =?utf-8?B?R3BzVFVFRlBFUmZZY3VCRlQvK0tZVG9KOVlXcnFOWng1V3lDNnRQZ3BLOWVm?=
 =?utf-8?B?S0M3dVNEblBsRm9Ta0hzOTR4dFAwVy9NTmxQY2tUR1R3WUZXa3BJQm8zVmt5?=
 =?utf-8?B?aXdhVThWcGQ5eVNJdnhEdnhVdjlWSlMxOVIrRnEwMndGeVh4REdXRi91U2kz?=
 =?utf-8?B?OXBnSW4vQkR4MURoS1pSNExXV3Q1dTJyTG9mVmFtR2JzbXdSQnd3cjEzaGlY?=
 =?utf-8?B?RTZGMFZNUmtjQ2lWbHcreXBidE9WV0RWcWgwUnNyZ3JhVk9jdVYwdXB5dEg5?=
 =?utf-8?B?SjJoSDdtOFh1WjMrRDRuMG5xL0c2RnZuTmlVTEVMZjY0WjhnQWtBMVVsOWVm?=
 =?utf-8?B?WjdSbTZlVlRjYWVYV1VBMzU0Y2RHK2xrZjMva1Q4Yks4d09Kb0JUazhoSWtz?=
 =?utf-8?B?OUY2Q1ZVTmt4T1pWRmNOQi80ZzhpbVJiN05BcHRtcE5KZFB6RHZKUkFnMzBV?=
 =?utf-8?B?Ym9XL3BIczVEVDRyMEErZU9GMjEvd3BORFBVSGF4L1FPdzJjWSsxb2Z0ZXVG?=
 =?utf-8?B?N1VkNk9XdHNueWs1RjVFTjQvV1o3M2VKVVlDTlhNOXFLYmlsYks3eVpEeE1K?=
 =?utf-8?B?K0FaVkFJcllTYTRTN1JrU2QrU1VWVGh2d3ZvQzZOTVRUTUxkM28wZ1kzc3Z6?=
 =?utf-8?B?NlJ4akFmOGFCQVAzckowbmRnM1ZLMVpSTCtnV1lxZlJnenh5dTg3UzN2Qmg3?=
 =?utf-8?B?NzI3WnhIRjZsWE1zS21MMHl1d2IvZG5NMVdZTXhUSTRaS3lXdTBtUENSSURM?=
 =?utf-8?B?RWd0QWU0cEQrMXExSkVPdC92ejJ3Y0gvd0pBUTVFQTRTV0dtU3U0WHJhWmY4?=
 =?utf-8?B?cjNhS3FEREwyNGlWZEpocHlaSVZGNC8rREZpZS85TDIxbVBFRm5jV1dacm0x?=
 =?utf-8?B?TGRpMFpZSW9XNGFubm11ODA1RnpoSlZ3SWZMcHlxc2R0cml1NnpDSDRnSFBu?=
 =?utf-8?B?bG5UcFlaK0I2NFA1MVMyMWR5dWVIY1YxL0l6UlVwdjQrMlpkT3ZLVlJ3T0VX?=
 =?utf-8?B?cDh4V3BUK0tnMFBpY216T00vM0tVL3FIcFMrbFE5MWMySS9qbnRCZ1pmUm5U?=
 =?utf-8?B?UzllL0RoVWdyMDVBenBaQ2VobytKTlhPV00rZm0wNmFyTE16dDY0R2xCbDB2?=
 =?utf-8?B?bWxsTkhTeldXSlpPSGR5SzA4Tlp3ODhkQ1NIK2hCd2RYbUJBYUdMY1gzVWZa?=
 =?utf-8?B?L0h3Vy8xdlFDWVBQTE5wZ1pLdTkrbURQVHU2bmdYQ3FWZXdhWWJvdlkxNlBV?=
 =?utf-8?B?OGg2S0o2bzNQVWt0My9MbVdiVXY0NE1xbFpuQnlWbWpPTWVvMDd3bmlsZCtF?=
 =?utf-8?B?N2pVNmdiSEdtWWc5YVVzZnlWeVpLVGJrUUFMdlcxcGVLdU5kaXQ5V2RtRk9J?=
 =?utf-8?B?ZmtVbWNsWS9LeVhDcEQrWTBDM1Uwd1l1WHF5cytZU0d6ZWVoTEFGZEEwL3J2?=
 =?utf-8?B?bWQyc3VYb1VybzM4bkllVGxSTzRhaTg3Yi9NcjlQdUdGWGxPUm9meDRLb2Jq?=
 =?utf-8?B?ZTNFd0RtYmphQms4dnJTcUNPR1dHaERiaFdxa0RRYkVRTUtEY052RFZZaXZP?=
 =?utf-8?B?ZGZLYVcyTzdHM2xlVGhyTmZvMSt5T1NTRlhKWmUrTUptVDlzREVKSzZ6dkRX?=
 =?utf-8?Q?QLHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDgwRXlVSjhJa3JnZ2xyWTFOSnpTTlpwNXRrS0pxSlc1UVN0SGFoR2ZGSGth?=
 =?utf-8?B?T3N3NjRNWVlLbk9pL0QzMU82UG15ZFNnM1N1dmMwcDdFSTlQTXFsdFRYbm5I?=
 =?utf-8?B?T20ya09CbnJwaWYvV2VpelE2WDZWTmxTY05FcytHQTVCL2UxVlVpZkRqMW9y?=
 =?utf-8?B?ck0raWtzUHZOT2lkZmZ1V0N0akp6MWVsV0hqTUtodHBsVnBSaGNjajFaTEVl?=
 =?utf-8?B?emY0UFNKZ1dxdHM1bEk5QWY1S2xSSzQwQ3U4d1p5VjdjTmpOYjFvaGVIN3VQ?=
 =?utf-8?B?ZjZlUWFGSUsydU43dk4yM3FBTkk5blV1bE4yMHEwOEVnWE9CU0pQdUk4L3Js?=
 =?utf-8?B?a3N1UExES1lrMEVlWElmRmJSR05sTUp0d0hHWFlQWXBtUTRoRXA1SDM2Yzla?=
 =?utf-8?B?S2t0b0JWbm92azd1TDNLV3hqMzl4YUlkUWpOTVVUQm1hVThQMlNKOGs0Rld0?=
 =?utf-8?B?VHNhMjBVL3BKUTZDdlF0MmxIajJsU3pzNmx5YzNVK3hkTnF6M3ExMjhGRURx?=
 =?utf-8?B?dXF3LzRxeUtHNjdCVmNyR3dRd0NoOUJBdVYwKzBuNEhTdFZSU1JhT2F6Y2Yx?=
 =?utf-8?B?OUdpZGVUNXpMVEtJcGhxa2lIVEh5ZXpvUmVJZk9ZOTQwTWVwQ2JYeHVUOUJu?=
 =?utf-8?B?bW9zT3ZiL3l6MVRHUHVoaXNFM3BoYWFsVVhJQjBGOVRVYlRrZEtPekMxMEFw?=
 =?utf-8?B?RkNxNUZkem44T1hTUG82T3RteWNqMkxYQ0NVaXBPejFYakh5ZnJuanlkZmRr?=
 =?utf-8?B?eXZWMU5iUEdNblpWMmpEM1pOT21wakVVY0YzOElDYlFyWlM0c0l0cmdCK2hk?=
 =?utf-8?B?bUV6SGFTSU81dWZBZVRkYmlVaXczd3kzL2NITXM0a1pHVmFLdVhJNEQ4ZkJL?=
 =?utf-8?B?Uit2MWtoYzRzeTh5UjRnK2NvaU1vekdxZlByb2pjVGpDemlBYTJyRFVuT1JJ?=
 =?utf-8?B?djNrandhMzdxRmRqbDQxUTRwTCt4bzk4MHNZN0c4alk0Z2NKb3FPajR2OFA5?=
 =?utf-8?B?empYY0Y5S28vTWlWL3JXMy9EdnJxdFFyb1JKcUgyQ25KMjZOSW90U2tHVlQ1?=
 =?utf-8?B?WjlYdDVjVUxlcXdXdHpyeFM4RXhmSGlZQTBCUHJTdFd2Z1p3VW5UZE0rOVFH?=
 =?utf-8?B?SG9SNGNDcTk3Z2FKbkE1WTJiY09UMWlXbHFBUVZyNUUydTQ2MS9yTm9Mcnhl?=
 =?utf-8?B?VmhwMWxhU3BUaGR5TldrZ3cwcysrQ2d1clMzdnlmcXNOc1N4c2dMWWFFRXdr?=
 =?utf-8?B?ZkRucUsraXRuY1R1SEpmQm12d00rMitYU0dGRXpaa3ZESitCc3NBRlRQNmMr?=
 =?utf-8?B?aEFsVytLSGh6VTJCdFNXd1oxTzYxUHZYL1pETER2Ri8vSC9qQ0gxM0hTT0M3?=
 =?utf-8?B?WC9VWkxMZW5qSFR0ODR3Z0F1MituRExnZm9JU1hSOU1RcHVidngybXExRTc1?=
 =?utf-8?B?WTFEVWMzZWZwTWlObE9BZXdJd2VkK0cyTmRLbXBSMXFxWWJmOTNlbEI5aThY?=
 =?utf-8?B?ZG1sYzc0ZGpuenMrVjdyNE9OUnNGT1JSTlRMb2p4bjVDdXdab0ZJYXhDRGxx?=
 =?utf-8?B?clUyVlRydWRkdmNRMHJDQkxCaVN4blZrRkZ2WXZkZUJSU1phZkpCeStLTHBw?=
 =?utf-8?B?OTM3bnJsZUFQWFRvNG9yejlpMnRDUGY1WThPYTh3WnpONUlISjF0MURwdVgx?=
 =?utf-8?B?all5UEpPR1VOaHpKQ2YzaVpIam1MRUlQVEp6ZHdzR0NYZmd2cnphUTBDOXZt?=
 =?utf-8?B?ZDhsLzNuUmlFcFl4NmJOTTRqUXRRVXEwZ0ZyT1ZNenNiZVZzbzJsS3dLb1Bp?=
 =?utf-8?B?WnNxVDdrWG1wNjQxd21pYllxSWhFcnZIMEZBVVAyZGlsYmR5YkVjVlNlTXEy?=
 =?utf-8?B?b1ZMSkI4ckxXQjN2Z0dwaE9ydlVGb3ppT2pLbk5oTnRCOE9xRHQrUGdtSVB5?=
 =?utf-8?B?Zm5DK21CRHNpNDZZd0FIT3BBZUp5amdTT3g0OTRXWTEyeTczYXhNbUV1OEFn?=
 =?utf-8?B?a25sK1NhSit5eGV3akRrYzN5NEUzaS9BOXRObTg2L0QxNi95V2ZlbnJxMHJT?=
 =?utf-8?B?blVKZmppNDBGWFNHZG96YTZYRmJZeWN2VnE4N1RYRUhLaXcvOE9xT0FiaWpZ?=
 =?utf-8?B?KzhWc0Y2TG9oZDVrd0psWXpBQVg3aXNNelJqYXFZTlJQOElnTHIzeFJ2VTln?=
 =?utf-8?B?Wlo2OGUyT09EU1dHL0xmR1BBUXFqY2VqRlpvR2Exc3BrTnpWSENXVldvendL?=
 =?utf-8?B?ajh0WkdiKyt0dWE3ZkdCdmN2STlVbU1UQktRKzhGTU5CMmMyOEt4SXFUMTV1?=
 =?utf-8?B?UGhoTGE4MFprQ0g3UnMvQ2o2YnM1V1c2eXo2eGNhY3lreDV0bHJjUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7ed1ee-7696-40d0-20bf-08de708d62af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:36:08.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4afj9OnMQzL7ZMIX6r41xAmpbTdYda+F+nqDTLk+xKouyIJwXT/GaJjWZVVmq2pVf8Qah9oGk+/NaBsN/DKatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9423

On 20.02.26 10:08, Florian Bezdeka wrote:
> All COBALT_IMPL_TIME64() services will be moved afterwards - step by
> step - into the newly introduced wrappers_time64.c. At the end that
> should allow us to compile libcobalt with time64_t support leaving
> the native time_t services in place.
> 
> Currently, all native time_t services are replaced by the 64 bit
> variants. That is OK as long as applications are rebuild after
> libcobalt, but we try to remove this limitation now.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/Makefile.am       | 3 ++-
>  lib/cobalt/wrappers_time64.c | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> index f461e570ed42a0d5cbc43eabb373c3c9edd83bad..17e203f9015fe2bb5306609e4d51c62f3a725780 100644
> --- a/lib/cobalt/Makefile.am
> +++ b/lib/cobalt/Makefile.am
> @@ -43,7 +43,8 @@ libcobalt_la_SOURCES =		\
>  	timerfd.c		\
>  	trace.c			\
>  	umm.c			\
> -	wrappers.c
> +	wrappers.c		\
> +	wrappers_time64.c


So, a should we do a wrapper_off64 for mmap, or put both into the same
one? I don't have a good name for common one yet, though.

>  
>  libcobalt_la_CPPFLAGS =			\
>  	@XENO_COBALT_CFLAGS@		\
> diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4c4e0db0650b49f46cbd6d9ecf7cd656bb04bbe4
> --- /dev/null
> +++ b/lib/cobalt/wrappers_time64.c
> @@ -0,0 +1,6 @@
> +/*
> + * Magic ahead:
> + * This file is compiled twice in case y2038/time64_t support is necessary
> + * and requested. The first time with time64_t and a second time with native
> + * time_t.
> + */
> 

Header, but still no copyright notices...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
