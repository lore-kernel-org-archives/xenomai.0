Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F223507C
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976486; cv=fail; b=QT4BgLTHO2JzlMSPtq5RP6QFdMG07BdK6a5E6RBTML1CnU2IMA6nJUZs5bWPzqXqcfh5OWxZw45P9o0DqxX0Tq32PJpZXfTqawZr+ank0nkaCEVLVCV+KbnWVoTnQ2ro1ZVVEjP3c00DGZgFi8iow8aWFke/kAvQFyhelrenxOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976486; c=relaxed/simple;
	bh=g8SgQE2LrZDsE/vvQfokfq1xmJ2VqOvJet5LOqVLATI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3iqIST/3J45sg93lFIvsrr0yoWoxdpprijkkE59mt5M+OVJNlhR0wP6R4cWtEYNK3UeKfKsptauKzerqUOPYxBz628p4mo3ChfWwocaMCv0cZSTixAkuHQpqXPAbQLGaS8xmGm3uOl4/UZZp1ADO02ekTb2tVsUghsvzoylBnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jQklOnw5; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jQklOnw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpDsJzmHH4dbyT3Tb3MTJ34agLyyH3f16hWrfRwpEWHI0gcffNXq90Un+zrmiuYcqam58MPsNB3I/d5lMPCCpgK73cVB7cBDN2oV6Z0pqtu6ofNeuUBqva+QlFw6dYv0LGaCXFPzFiEe8UsGSTl0Q4+cpWOq4nfUSvV4Dz1ZsisoyCmdAPaXuFXO+MesIaPU5kvtL0aK+/wnCrTUwDTfZvDoIdyq8btkntVdVaVJ/8VqSLJoHFuEkkxkyPeDw4LR53Qi6ufhy+ALiLLEzyDFX1c37PgEqtnK0FrdBtaSoOj3Kogd+blQYj/mblwvFKSH10ZklqB7llX3vOEcR4cbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13znKlpvdlA0Fr6dqc85FJPsVC+hQUdxG8e7l7nR23k=;
 b=HBBMU2W20hPzYbCAKvD5Qt6EmaB8vcGbgSlA7iTUUFzzpMjNR+FB/U2oaRDatYShyUvh0J+7yRNJe99AlMNtbr2Wyhen5MyU/oN/+hrB9auIFlqG1PgiNOGBDZyMI47dqlyOoAXKN+Li/KjmxXgu+AqvACta4AbKea60Bx5T3hXfUcVUhvEEV12/5yzIB8pZbyETszhb/yVUZCuwY4npLO34ig8ZEoCFisuvSyxETPdSs21cUlW5snR5cWAXTdFI9WSROmdiQn7e0a5V3mzLILFiDVqF3PvEIrAoRd5MsOkGhcHCB0+rPWIdZTFlRCJtiNexc1VRpNavXx1xYNt4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13znKlpvdlA0Fr6dqc85FJPsVC+hQUdxG8e7l7nR23k=;
 b=jQklOnw5dc3HxF67SJFgMOfvgl0+yudD9hKSDqNV3rihDU2P16X6bxQPXxhVxwi0JzuQ1hdS9UJ+ccASmat5LDI/CnQ7Ro15odt1ivtgUzrN7vZfzhqKVaBoEC61TcuYZX7X+WFPk78cQ7hQIrUim5LRr+3r7jbbnc5qS6tY96hSGBzDELzKE1DgGWZRhxd9pyXe12E76ODKqMxAGPqFAT8x0PIEzVOwuUZlbTV8+yngC2zOW3MaywMm7t0MHTV1E2AppVNGPZ4srvdQBeX0UWfKRhbAPCKS3B+kKFBzRK6OOGWO89hjZULr4Zke4ceoGQGgJo64t0OZT5cI0O25xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:46:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:46:39 +0000
Message-ID: <f20f223d-dd45-4821-9534-b54ebf1c92db@siemens.com>
Date: Wed, 17 Dec 2025 13:46:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU / FPSIMD
 usage
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
 <875xaq88tf.fsf@xenomai.org>
 <0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
 <87h5txuqhp.fsf@xenomai.org>
 <a1849bb77a5e82a5eaea88d0498dc42ff6d88c1f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a1849bb77a5e82a5eaea88d0498dc42ff6d88c1f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 06098853-400d-4337-7a48-08de3d6a5286
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUZ2d01tZkE0cXBEL0dpa2JEbDh5REhRdHJYVmhqYUFzQmF3dWlXakxnd1RJ?=
 =?utf-8?B?Uk5oMk8wWEhXMU9LZ1RkSDZZc09McFJRNWJ6U1hYSDBTR1JKVDRzVEd6aDND?=
 =?utf-8?B?MHczL3BuYmNnZ0RVc1Jlb1pKN2hMMkprY09ZNytrSFpsSldiazBjeW02MGhC?=
 =?utf-8?B?akVHYXFXa3J4K1pNU3lRWVpaSzZ1RVhhSENFUkNmT0VKZGhqV3ZDRGNvZlBD?=
 =?utf-8?B?aW1Valg3S2tWT2NsNVhKaWV2NXpTZEt3UnJvQ0xobFhlVUV2ZXRuSlRUQThE?=
 =?utf-8?B?Wm9lTUkxcDlTSEp0SUZ4OVBCR2xKYzNLTEZaZ0VIUTA1Mk1uUDVWdS9WT2M0?=
 =?utf-8?B?STBXUlhUSk1Sb2JsZXRYVDhMajBvZjA3V2NiNG1yblJROUVYUzJlRUNIRVBO?=
 =?utf-8?B?N0lzbEYzSlBsR2E5TzFhMndFd2orWmNHdTBieEZlNytOczIrd0d1bDVkMWxn?=
 =?utf-8?B?RkxFYTlQL2YrQXZiRlJKMjE4ZmJyQnoycUFKNjdtQUc0UVpHZ1RzMkJWaUpE?=
 =?utf-8?B?bFArZi9GSHBpQXpXYXFwaldCMHkrMThTZHEzOUw4UHFzRGt0ZEJSS1hEZStC?=
 =?utf-8?B?ZjB6RzdRc3ZmOVpjM2FxVnd3TzNFUll4d0t0Mzk3R0xvM2VpVDJIOGgvM21R?=
 =?utf-8?B?TDdmQjU3TU1aNlBjb1NEVktJckxySk9RcVVWVGZaMkdrS0lHbXBldU5BVUpi?=
 =?utf-8?B?Y3BrQ1dvOW1HaStBc1oySktQZFd4MHFwQ0t0Z2YvM1pLVTdXV25PT3BJN3JU?=
 =?utf-8?B?UnE5Zit3NFQ5bTFSMkl4M2FqYjl1NVNoM0EybVIvMU9FRnZnL3hFZFBHaWdM?=
 =?utf-8?B?MEQyb3ZDSWxGWTVJMlpORmhCdkI3QWt3azJFdERoV2wzR3lySk9Hc3F2SThp?=
 =?utf-8?B?bjVsY1JLekNPRC90MnZ4REEySTAvaUpPOHlvdkZsZ1R1dTl6SkoxbGlTY2xQ?=
 =?utf-8?B?em5uZzgzQkxFc3ZSYVRZM0VhcEJtRVdJTldBRlZLaFd0bWp4OHg1UmtSaVFh?=
 =?utf-8?B?K0hPN3ZIeUdnNU96MHBONHVWUjFJVTZlTkJMckM0Y0ZBZmZXejAzOHVFL05O?=
 =?utf-8?B?SmpvOTNoZXNlYXoybnRKL0s0aGIrT3RsUnNxRXpub1lURUFtdmNiUHcyUEFQ?=
 =?utf-8?B?OWJ2RlBaMW5VUFBSMmNhMk1vdGh6OU03UTZpTDFmYzAxRHpXSG5jY0F0KzlM?=
 =?utf-8?B?STVYQkl6bkcreEl2UEF3a0MvWWV6NTBXMC9SRm5rWHgxbFBWVUtPb3AwVlhu?=
 =?utf-8?B?eS9QQWNTcUFITTB4YjcyQk5SS05Wb0JDcHJlNUgxMkxxVUFSQTlaVDhYcWRy?=
 =?utf-8?B?N1hMSmNsbU1uRzdMMzhRMXh5RHBGUFV1aXIrSUtjRmZSMGc2OEZrOWlUdjVj?=
 =?utf-8?B?MFlRM09ucE9CQmU5WHdaYmI1UlFTOGNFNHBpd1FZN0V3WmlqR21vUml3QXcr?=
 =?utf-8?B?K01SUWIrUWxLVzJmYVVxQjIxbUpPK2k1NjIxeEdjVDRhTFRqWWxmNk4vUmRx?=
 =?utf-8?B?WWJKZ0oxMWxZUHlUNkQwZ3RmMkNHeHRyNXlsV0pEYzdTNVVzSTlEUTJXNmRa?=
 =?utf-8?B?aHdNR3dSdTdUTUovaENkbUJVTUp2YVMzRTIxSCtTRkkzRXR1WjNzTi9ienI1?=
 =?utf-8?B?NksrWXBkVUh5MFBuamlYYVlkNTB6MlJQendEc013K3pXOHJEMWpybHQ0WCt4?=
 =?utf-8?B?cFBxUkp6NitXM05yVElnZXI1UmtmU0JLRG5WMis5OGhEMjhhYWdFcUQ5YVhR?=
 =?utf-8?B?RUkvOTBZMEs2Tk9ocCtYWFFmdWpLVDZxdEUrd2FpdzZucXZRVzVCZDJCNmta?=
 =?utf-8?B?MlNISTdHdkx1Y1lHeHZjRnJDT2o5azd0WDd3WHVxQVo4VUpmRXFDOTY1dktH?=
 =?utf-8?B?NHVCMGE0WVFDRUU3QVh6V3J3bldvVlBnZTVSekhGVnQ1UHNSSDJGUmVzR0xF?=
 =?utf-8?Q?i8lDqqvVpiRTRFO3Mwf2VqQk/qCS27GS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9QQWJtdEw5Nzh6aFJFMnNxMG9nZC9mZmhoUnJNV0hCTWNYd3RlZHNzeW16?=
 =?utf-8?B?eDlPVDB1M3NNVFlvb3AyeWVzeURGUGhyMXFDU2FnMGdlaHlUR2QzcXdWME12?=
 =?utf-8?B?eDhUcUZZMDZTQ3dRM2MzSGRhL3RSM3hNREcyWVBTWUhGc0x4Y0tIODY3djZH?=
 =?utf-8?B?LzQ0UWwvdVdHa3dwS1p4bmpxTmtrS2Y1bnJiRTBRZHpXK2huU0tEaXBEeWYw?=
 =?utf-8?B?K3pZdHFvcjJxSi84Q2xtVjJOSXRsZG1HaktTYjQwVGFZVC8raWtwdVZ6K2JC?=
 =?utf-8?B?L3Y5UEhoaFFyU21UZ0o5SFVLQzN5VThPT3ZxMDE4K2UraWY4RlJCWkNzWnhp?=
 =?utf-8?B?bS8zSGQwVTgxNzJiT3YxQ3JnREZwVWVOMGJiWDdRVVRkTm1La1dSVG1TTitC?=
 =?utf-8?B?bkl2Rm9MTVMrNERid0prT1Q0aGdMcG82bGVSdUljdVNWM3VqbVIvTG1ySUV6?=
 =?utf-8?B?VjM3NmMvZzNmc2FCRnVrVlczbTlvN3BEQTErMjlCNmFoYkI4T0VhWWlla01i?=
 =?utf-8?B?RDNidFhUcENJR0FWd2JMeCtBRmtrQm1oY1lhOURreHdTdXpwdDRhSUhsNXgv?=
 =?utf-8?B?RGF5bW1uSElIakxIZElhTDhteC80eVU1U3I0cThYa1JEd1BRYk4zNmVXdzYw?=
 =?utf-8?B?aHBPUVVGZUdDRHZaZXRWaGR0RC80MHJDdjNrQ2NkL1JZMTFFTmtNbUdybi9U?=
 =?utf-8?B?SlBHV2JDVmR5UlRVQTFjeFM1aVhTZmk2TGhCUTVrcUNqWTBHUU5ZK21kN2xo?=
 =?utf-8?B?Nm40Qm4xSVRHNklDc2hKUmtLWFpWUEdha3lrTTh5WEJTR3VjVXhsbUZsVlNr?=
 =?utf-8?B?SklCMEFQNWlubGttSEhMM0lYSGxCcGtlZFJuMXBMSXNzSHZYcWdkbU50RmdW?=
 =?utf-8?B?QVdVSzhtT0tGR25TN1lZY3VHL25VV1ZaaHBHVmh0clE3QS84aDdHdHY0ZEU0?=
 =?utf-8?B?dWxBMWpLbFpUYm1HNFlyUVNPckpsR2Y0TWpSbTNkVnVjUThpbjNSSmxocFdp?=
 =?utf-8?B?UXlIdzBLdExOMSt0YkVVL0FFQmxidUN5WXNKa3A4RFk5cVJlRlhFeWZ0WmJS?=
 =?utf-8?B?QTBERGpVckRDa2xGbWd4ckVJejNHWURRQ1ZJdm93WHdqTnZwY1QzbUllZWNW?=
 =?utf-8?B?Q2MyUFBEemN6Y0pDUHcwM2NzckQ0dWt5RGJHTnFwc0FGS2g2b3NKOFlJUGFC?=
 =?utf-8?B?SWdicmdEaGM0aTZRYVErQWR1V0k0YzNWR1hHUVhTNm45WDV5bVRRemlwSHBp?=
 =?utf-8?B?NDVuZ0VDMjZidVRQcEVZMVorRDJibkdHRDUyOVZDNFpJUlZWSzdUZEwvRUJz?=
 =?utf-8?B?K29pNDQrSjNBZk5lS2tJV0ttYzhNSWlkTTJqN05vOVhsZzI1SGppMTB2VEdv?=
 =?utf-8?B?SGlKQmZNTk9qUVVyUm1XNm9zVnhKR09TVlBJSVMySHBjbEJoYjRDUzJCMW1t?=
 =?utf-8?B?bnpTTCtLTlg0bzdHcE1LREtmMDVpUHZlNDFrbDBCR0JLdTZxdG1MaWp6TFNk?=
 =?utf-8?B?STV2cjFTbE95VG5ocE9YL0Y4MmVHQlZueVFHeGY3bjUxb1pQUjdvUEo2Q1dq?=
 =?utf-8?B?MHVOWFBTSW9CVlptQkRCQ05oOWJTT3hkY1RkVUJVUjZ5ZDB6T3BWTEVPVGM1?=
 =?utf-8?B?RGk3OGFJQkxkMW1LVWJRRXkvdWtCdUNjRDFiQU5lalFnVysybUtvY0U1L0dJ?=
 =?utf-8?B?QXJBSGVsM3pGc3doQ1g4SEhyK0pqNmYxQnZwS3ZHT0RhZHA5THJ4WWNPbTU1?=
 =?utf-8?B?THJEWTNsTWUzRzg2QlJwM29vZEhhd0xHbjVmSjRwZXIyWmtiOW5uNU5hc0xv?=
 =?utf-8?B?MUk5YkUwbEp4MUJJUjN0cFgrRnV4cldoRkJESFNMdDVkQWFpY0JYaGNSTGdq?=
 =?utf-8?B?QS9sUzFKS2d1OHY2SE5NMFBMbnIvNG9FK2lFUG5IWXlXamR5QXRKZmJEakxJ?=
 =?utf-8?B?b0Zkcjk5WlAxaXY5a2VqVUdQelJSUmRxMHpDVXlSRkhRc0JGTi9NVnBQVWll?=
 =?utf-8?B?SXZ6a29JVitaRVhjZWcrQ1pSb1pNNUZIWFlPTTZqTmNKakZxWUJRN0ZObUZv?=
 =?utf-8?B?RzVPWHRlTFdkTDB2SUhtd2JuZjc2RHdhaGN1M3FwSzFWVVFpK0hhVzdlMDRJ?=
 =?utf-8?B?cE10eUVrV0lmQTYxQjA5T05FVUZYQmxSWmdZT2Nkb0h5bUhRa0NOeFRTUzNN?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06098853-400d-4337-7a48-08de3d6a5286
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:46:39.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h51eR4nnj2+wkd4GRQbbWtDGDURPX9vRotZliVZdzHO+uPyHMa8XU6GC3y4AwVG1xAZ8XMUVnaJOshfkDiU3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4078

On 15.12.25 12:19, Florian Bezdeka wrote:
> On Thu, 2025-12-11 at 13:56 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> On Mon, 2025-12-01 at 17:29 +0100, Philippe Gerum wrote:
>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>
>>>>> Hi all,
>>>>>
>>>>> these are the necessary backports for dovetail 6.1 that would allow us to
>>>>> enable the in-kernel FPU usage of switchtest. This is currently not
>>>>> possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
>>>>> context switching.
>>>>>
>>>>> I have backported the necessary patches down to 5.10. That would allow
>>>>> us to unconditionally enable the tests for the xenomai3-next branch. I
>>>>> will send out the 5.15 and 5.10 series once we agreed that this version
>>>>> (targeting 6.1) is correct.
>>>>>
>>>>> Please note that there is a small problem with this series. Patch 1
>>>>> removes the check/flag that was used by the dovetail enablement code to
>>>>> detect in-band FPU usage. The new flag is implemented differently in
>>>>> patch 2. Patch 2 also fixes the usage of that flag. I had no better
>>>>> idea. Otherwise I would have to delete? the in-kernel fpu preemption
>>>>> code (temporary).
>>>>
>>>> TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
>>>> using the NEON unit by an oob thread when PREEMPT_RT is disabled, kernel
>>>> or user for that matter. i.e. It looks like this aspect was overlooked
>>>> during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
>>>> broader fix may be required. We may have to use a marker which covers
>>>> any type of preempted context.
>>>>
>>>
>>> I agree, but this is something that we should address in addition / on
>>> top, no?
>>>
>>
>> Yep, would make backporting easier.
>>
>>> This issue seems to affect all versions of dovetail. If we do the
>>> backports first we can address the issue on the same feature set. That
>>> should simplify the back-porting again. Did I miss something?
>>>
>>
>> Agreed.
> 
> How do we proceed now? Once applied to 6.1 I can send out the versions
> for 5.15 and 5.10 so Jan can apply them as well.
> 

Philippe, do you plan to update 6.1 soon? Or should I already take over
6.1, given that 6.18 is on the horizon and you would likely stop 6.1 for
evl and dovetail soon?

Jan

> Meanwhile I found some time to read the FPU code around
> kernel_neon_begin() again. The problem for Dovetail is that there is no
> task context for softirqs in the !PREEMPT_RT case. Seems we need some
> kind of a per-cpu flag for this scenario to track the FPU usage. Any
> thoughts on your end already?
> 
>>
>> -- 
>> Philippe.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
