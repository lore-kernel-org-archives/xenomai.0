Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965227BF7D
	for <xenomai@lists.linux.dev>; Sat, 14 Feb 2026 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771111594; cv=fail; b=eipNYZ7sPLuBVc5qozcB+rj9rco44m6zC/PuJ0tvnjk7XAMJMqVdc5SM6ofBGHqBKMem+KbciUfYoHU4mE4WAXhyiDADlXtFegZYYpjli5WPAQ32zDiOENoc6jgxVRvBj2J0ZN/jEAFznD2RPEaQdY0UUoeHBmR6Ohen9XNcp6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771111594; c=relaxed/simple;
	bh=e7BVywilpxTXqTD5Zo3/UxTHnhz5TaO2fsfL3VzDY5Q=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=PpZMNFmlKeBUyflnCyKG7qpZ7TWANbbzLskbywem02qA2rjQbrO2QBmogGgZbDwBQin3I46k01KcuCho1RcnG8+0CKdHtbAlZPur6l5VUBp2j6t461XjhRpvnpxOE57la9/HfJuP32Y6A4YzNYkz7t92jLbqQrQ8KCp7kpBSBaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VZ+jzR51; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VZ+jzR51"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7GjYrtHWLeZcqHDYVqE6LRJbR9Fgod/91mZ+PVBd/9HEn17WASIiho0mrRqlCZ5TFTcNmjEVd7T7WJcKJX9D62WbqfoSK0wcvVtdjXA9KS1WDbEYR8IHebQFCbvZCRS+EeWbFXMlNKEsS2QRsY4Hz6vS116hxNz2GdinqLATI/raltsIFgBb0R4KBF44ipIoWfiP973FuX7+MxG/Dj4gCKZEA3IyzkWZBcqHlqc1AtMd6HWxMgMX8tqy10EG+T4Pv666NjC8emulnTgu0QulLPz7/qiwX+LOk9WdQASyW7KENJ6aBkWq22/mdMot047r2zcVQNP9MQY7AFtN03c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFOeYOQwh1vqoP0l/PNIRUzIaloEEtzXsq9Ff4BZhZQ=;
 b=xHWRYq0ZKUKOR5LHl2MztN0Da+JDMDRIP4dA+2DrPwivl6T4yVX8cORP6kCKoGty3Nn+3szTcxg7iR1sur4LElA/1vuMI7VVAdQx+/yVwkLHLLgSCcSbhVTL25t9NkQVXgShuEAGazaDSEaWGSSxlX2+ojJ8tqSPY8HI7urFK8wTp+DLMKqax0+8bTOacUJVoMg6obDFUtlwWeQ54vbKESliYOXBIjnEvEgyyQq51MLGFQYqNNNEV7Ovbaz6R/1DMxZ5mNe1Fz5cM5MZvE7jTQZ3Heom3cdeixYlMLhVWFco8hIl29mtXJwuOGXnOrs8bGKs5IrVw/gn6FSmgbxqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFOeYOQwh1vqoP0l/PNIRUzIaloEEtzXsq9Ff4BZhZQ=;
 b=VZ+jzR513Y/jDb36iT2WlvOOUW+xy2bsYZF8NCRYktNxNR9ngXEINjptn3kcXVup+e8ml26v6LfHz8UbI/hjL/sFx2SPZBZrKQ6dwDO+zuANWR7C9LbRMYzFKxyZsjG+a05iYAbpkEyG7A4W8UcDAjFbeskZeZO+Xl6j53U5lyz58rHS2rUr6W0ggfFlD+2bzD8Z52RFbaumMFwCCAicN5weM0kE0Uz2Yfb+FgVa6/mPMnXgmPgV19JXzU5DkS1og5jyWsEKB8LuEhI0R8GrGq74ButbAfOgKmnbS9c2H3SWOe8sXEQH4cT+RDEjAZNqak9us5Llg2klaJ6dFV4kFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::14)
 by AS2PR10MB7047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:595::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sat, 14 Feb
 2026 23:25:08 +0000
Received: from DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ea30:bdcf:399e:679]) by DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ea30:bdcf:399e:679%5]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 23:25:08 +0000
Content-Type: multipart/mixed; boundary="------------XyKZEYap9WRXeyBw1uezNRQL"
Message-ID: <5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
Date: Sun, 15 Feb 2026 00:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in
 exit_to_user_mode_prepare()
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260214113941.91453-1-tobias.schaffner@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Language: en-US
In-Reply-To: <20260214113941.91453-1-tobias.schaffner@siemens.com>
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:30d::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5689:EE_|AS2PR10MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: fccee97a-88aa-401b-6cd5-08de6c204ae8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|6049299003|366016|10070799003|4013099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1h5YUhTVG5HbHZUeHRDWm9yWS95N3Z6NldsWVk4QU5lREdXenhIQjRjNjlC?=
 =?utf-8?B?U3Q1bklVVHJNTlNTOUdaVk9UTU5aSStXNE16ckQ2ZWhGNFRBQ1ZxbG1kVGFY?=
 =?utf-8?B?cndrSFRNUVBrSWg0cGtDOVRhUm9hL0ZQY1Y5RzNHUzBKejNmbE5Uc09ud2tr?=
 =?utf-8?B?L2phWkIwMWZ3NEg5ODMwZFFLQTd6bis1am1BR21qMEhJTHduWXdxYTJvOTJw?=
 =?utf-8?B?b2tLSXM0NTdhYVg3SVpuYjlBUVBMcTZKUGhRRkNKWUljRWtTK05pZ25TVTFP?=
 =?utf-8?B?Nnd4MklMZDZGdFdKNloyV2Z2MCsyOGFmR25ib2tDK1BzZ2ZXVEtmdWhGbFMx?=
 =?utf-8?B?Yy95bWNsN1AwS2xtTHBvbnIyeFJJV3N1TGdrK1J2RTc5VFh2NmUrNks1SkVR?=
 =?utf-8?B?Vm9zUEp2YlNwalhQTGpnTkF6V1B4NFBkdmhySkpGdWNjUDM1OWpma3R5OWth?=
 =?utf-8?B?VEM2RDc4WjY0dDNyd0V0WGk1aENoZ2VacERnSUhiS2YxN1BnT0tuMFFaOEFq?=
 =?utf-8?B?aTJLRWUwZkFka0h2RDNEK2NUd2lPRXdDb0ZXZVR5YktEZEk4akowVkNmOVJy?=
 =?utf-8?B?bUxPbWFVYkZNbE9oVmZ0Z1FYUjY1UTJudW15aEkvcWtDZWtFNDkwZ1NjTWM1?=
 =?utf-8?B?VlE0QUUzMi9SZjNSckkvaGtVYy9MNFVqUUlMUkl3ZHVOREJINm9qK0RCWEMw?=
 =?utf-8?B?Q2J2VEYzZFEzWWFGUnpwNmtBOHpWTXNrcVo2VHVDTzgwbGMyZVZ0V3VwZ3ox?=
 =?utf-8?B?U2NCZ3hRSEw2V2R2a3ZEOTQ0NHVvbEY2Q3B0UnpUcTl4dnIwRFJMYURDamo4?=
 =?utf-8?B?dm9UTml2b3h1bDVwRW0xemZwU3J6Ymx3ck5rdkhSMWF3ZjN4ME9jSk1naXpX?=
 =?utf-8?B?OXpuVXp5bG1EeWNBa1QrbCtOdmg0SVdQY3E4QllpU09QUjZWSVhPQjdqWVFR?=
 =?utf-8?B?aitRVlVCcDczZlVxbTAyOTFaejNwazZKcjNaODU3T0N0MjFmd0lvbU5KWTA2?=
 =?utf-8?B?VnpVZ3ErT3VuMGlRLzNUeEVhT3p1ZFBvN0xOTHJLeE9vUW9zeGZnNGY0Tk0v?=
 =?utf-8?B?VXFLVmhXVjhzZk1YcGp0ZFNzaEhWOCtUVnBEMzBPN3Exa0ErKzFOb01LdkFU?=
 =?utf-8?B?eThsa3pMZGxMUG5aNjhQWkJUWUpOUG9yWHgrVVh3UkFkdEhRc0N1NDYvQUJn?=
 =?utf-8?B?a0R5YmFRMHRJZy8wVy96QTJrSzFhV09TNldQb0FIR3IyMU9jd2NxZlVCekpH?=
 =?utf-8?B?c09qMlFZYzRyaC9DRlFNdk82TnpDV3h0dUdMR2NwQXNkQnk1S1greGU4UE5U?=
 =?utf-8?B?dVlqZVVIMi9KRWZhNktkY25YWlRkZFVCUDFTYkhLYnZwNU5hbmxkTGtOWDZN?=
 =?utf-8?B?empydVVRaktxM1hCM041Q3R1dnl5elF6blV4bDFrekRZajFrRXFpbUJTSUQ0?=
 =?utf-8?B?emZJK082M3U0SWVSdW1OV1hyQmc4ai9XR3N4Q1QySU1SVFdVUmE1dGNQdkUv?=
 =?utf-8?B?MGE3T1NUTW5kVmFHU3pQU1FRN2w1QzJ1M0NLNjFpNmgyMU02MTd1ajUrWkNH?=
 =?utf-8?B?M3BwRDBuQ1RKNW15ek5IVmI5bTRMWHpEbEtaaXFESkVESGk3NVpDUEdVSVBW?=
 =?utf-8?B?ZTNGWXhvaDBWZE96WXZJY3Z6KzJaanhhc21lbXowWnFQMmh2Qmc1eWRhQ3F6?=
 =?utf-8?B?VlFKNFF3MDkxTzBsMkEyeXhjMHloOUh4K0trU1NXbU1DYmQzUERQczhtNjVi?=
 =?utf-8?B?TXBHeUxqWm4zK2loNTJOZHE3V0FZQ3cxaTFidzB6ODhJYjd5RlpBOTl1RWhB?=
 =?utf-8?B?MUIvQjkxQVJuQ0gzanJ0c2swK1lVaURQMUFrblRNMVUrb0ljY2FvWFpLRW11?=
 =?utf-8?B?U3dhNWZzd3VDendBU2tWaGNGZElBQzVNbTBqQ0twenVNOUtiTTl3NFBmTllx?=
 =?utf-8?B?bmJtK0owTWhrbjZ5bS9IVnhPRGgreHNyTk9lU1NuQWVCQS9rZ2Rxa1gwSUQz?=
 =?utf-8?B?amE1YktRcGk3MFRJaTZCZHJQdlVmelpXREUxbkhkS21NVTNVdjdGdnVJTXMz?=
 =?utf-8?B?Z0xFTmE0clhsV2c0aHg5ZnBOZDVnN2xWRENuTmViSDcwV2FpYWdodmUxSjhK?=
 =?utf-8?Q?+K/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(6049299003)(366016)(10070799003)(4013099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3NIcjRsRFVJOTExd2JVQjYyamZuWjNyQWVYeldPQjNqakEvSjZYQ3hKcXRz?=
 =?utf-8?B?ME1TNFN3MjV6T2JyNHZPWHlmNGx3bVQ2bjZMKzlXNlJ6ZEZzVGF1bTRUTEx0?=
 =?utf-8?B?NnhNUmR1WkFiWUhHWUVwT1Q0UlhqbGM3TjV0MXU2TUJuUnpVdmdXMUtVZlcx?=
 =?utf-8?B?NHFFVnRxS1RkRTBiSTdrQ0xJd1lXWG9wb29wQ2UwWG5lRDIwSVE3WWc4Q1dq?=
 =?utf-8?B?dlJPcklCRmxxUTRlL05zV0RnY2VJd2ZyUWlra1JqMTlweHA1NWEwcTE1Wncz?=
 =?utf-8?B?MFpxZ1Q4dTAxMGQyZ0s3ZVZBR2h4YjJtNFY3Q3oremxUM08vb2Z6dXlKYjRP?=
 =?utf-8?B?SlRianZoVnRLaEt3eVlzUEFLdVA0amlyaHRiVDJLcWUyVnV4Wk5lMDhybzhH?=
 =?utf-8?B?NkpGMGJodmpENTdZZG1Zc2drRXZtcDhXNE9LTlViRDJ3b0dxSnI3dW5IWDFp?=
 =?utf-8?B?SG9EbXNtTnZlai9nYkNSZDJEV1ZwVDRBRThLRzMrK3NlSEk0SGd2L1dwSUFD?=
 =?utf-8?B?SWFGeVM3UzBWWm9DWTEvQTV0VENuYVo2OGtncklnYkgxcDJDRFg3ejhGdmNT?=
 =?utf-8?B?ckx4S21Ienl3MnZEUVdOd0N1UE1UUkdiSmE1YjFsL3RnOVNoalhNTWQvcWhy?=
 =?utf-8?B?QUowWUc1dGhhdUlkL0lXWGZGVXJxWFVzaGVKNjRtdDlucHZjOWsvWllMVjBH?=
 =?utf-8?B?bnBsOVV5MFhjK25ub00rNFhHS3BnQ3dtRytTem91Y3pOYlVwS29LeGpXTlB2?=
 =?utf-8?B?N0x3SFBIR0tHNHVadUpaeDhjWk96WkdEbG5DU3NmMFF5SWk4Sm5SbjVSQ0d3?=
 =?utf-8?B?OFhuVGF6UWJ6NldpWXdPaUNnKzVMdHBjTy9MZWFvdUhyaW1WNVZXdDk3MUN6?=
 =?utf-8?B?SmorRzlMQWR3bDlFTVJTMGs0ZityNDVyWTNKeUFLTVJxdGVmOGJsY1h5Nllo?=
 =?utf-8?B?SGRxVXhNZU1YSUhHL0tqM0I2RFlBVnFQYUxEcENvL0Q4NUZ4c3lHb1dISVBR?=
 =?utf-8?B?ZWxkM1M5V2hESkVZNzdmNWxPZDhWSStxYk1sOGdjdUdYUVAyQ29xQzk3M28y?=
 =?utf-8?B?cjQ4eDFWN0VZR1EvNEREVjZST3ZrRnRpUzRaNktYYU9VSHBNODFKdDRDa1Jw?=
 =?utf-8?B?OVlZL0M1TURneURIMVd1SlFBWWN6MGVEU1ZOanRIclNHR0syVmJPRHhwci9D?=
 =?utf-8?B?MTluRVowL1FwYTMxUkk4K3FTa0h3akpiRzJvMWtBTEFIbFNTSHZEa2RhK1lO?=
 =?utf-8?B?WE1QT2YxTGZhREtaeHA0VXlzV1hmYitja1l6V3ljb0Y4ZzRneWxiRW8veW4r?=
 =?utf-8?B?cjVDQkVmOUZqWXpKNEJVZTN0a2hMbDJ4UlM3Y2ZxUlhhU0RsbGNyU2FCajlI?=
 =?utf-8?B?eHpuV1NnQVZyK1ZVMGhPMlpQZ21MUE54bmxyK3BrbW9qbFVlNCt5RURqelVJ?=
 =?utf-8?B?UmRQTUVuQXk5MHIvZHRuNjIwZVlseCtENytpVEZGSVNwdUZYYU9ialBpcWJB?=
 =?utf-8?B?emNXU3lyR0FGa29PUncyNGVRcnFFbWdienIwRE9LTXFmbnVWczRlNGtXVmJH?=
 =?utf-8?B?QVJSQTc4UVB4Umw1bzQxMzIrZ3F2TUpjL2x3NjhvNDc3RTF4anNPTzJMeWg1?=
 =?utf-8?B?K3IwaERaVTZBSlJkUFh6dmVtWlZORFBrekFqTG5jdEIwNVF2ZzhKTU4yazhZ?=
 =?utf-8?B?TVRaWEE2L2M0MGxyK01QbnRUUW0zUk94ajVGQTJyYWxxSGMxT2t0ckxtck1H?=
 =?utf-8?B?QVptZHZXVzFwMW5tNFZyeXZ5UTlrOGdYb3NmMjI2azBYd0l5K3E0NFIvTGVu?=
 =?utf-8?B?WmJmcGxjamZsQXNvMnB3eFZBcEVpeFIvSEd6RDVvUDlMWm5jRjc3Y0FDUDAv?=
 =?utf-8?B?djZHYS84bmx5akhHMnpjcVMzcVZQbWRpc3VWVWg2emQ2ejlhZEdlOUwrWWYr?=
 =?utf-8?B?QjVKUW9LRitSU0x3RlQ1eiszT1RORWVobFUwTWo4WnlWSzVldHBxcnpzZC9F?=
 =?utf-8?B?SWxjcm5IWCs4bmNGN2lHdldlbDVEUkthRklnRmxDUHV3L3ZnTm5xdFdOSzBh?=
 =?utf-8?B?aFFZUlpkSEw4d0RDTWFHRVdMRTRGOEUzcHRiV1BvUEVZQWg5bk50cFViQnkw?=
 =?utf-8?B?TkM4TlJFbmtMTFJZTWt3Q0djMjJEQmQ2aG9uYUNDZFk5YS9IanRuWGxpakU4?=
 =?utf-8?B?RFhWZkdreHc2UWhBNlVTN3hNNFM4Z20wS2VYbExhblBmSCsxWDNKejhURHJl?=
 =?utf-8?B?cGJSSGx6dmwrZnJId1hYbGVVK25BdjU1WGdUVGNmM3hjRTNEWjhpalZaVHR1?=
 =?utf-8?B?TjFaMWo2TnIvd0lRSnJoRnpRR1ZVclBpd3ZlMDhHREJHSnk3djVaZ0VqcEVz?=
 =?utf-8?Q?HPhS5ys+ccY+mRP3j6dDW8tQh+2QN6eNHzxdBP/OlcQZh?=
X-MS-Exchange-AntiSpam-MessageData-1: NoGRyRnkCfAqxJYoUnnT10u+bUgCGcbBu7I=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccee97a-88aa-401b-6cd5-08de6c204ae8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 23:25:08.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtf7XcxXVgpUkU0zB/LlcRwJcz8hM2PMCdmyVmZJyJB3uw89XFeq3yPJDlnHm/j5gEPPgMcNZlSfh0+ROiLS7ySdVwmysndIhgcmzdCH9zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7047

--------------XyKZEYap9WRXeyBw1uezNRQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 12:39, Tobias Schaffner wrote:
> Architectures using the generic handle_irq_pipelined() path do not

arm64 and x86 are not using that, so the only arch left is arm.
See below...

> synchronize the inband IRQ log in handle_irq_pipelined_finish()
> because inband is still stalled from irqentry_enter() when it gets
> called.

I think the real issue / correct wording is:

_TIF_WORK is left pending on IRQ exit.

> 
> As a result, deferred inband IRQs may not be played before the kernel
> checks for pending work in exit_to_user_mode_loop(), causing
> those IRQs to be missed on the return path to userspace.
> 
> Flush the inband IRQ log in exit_to_user_mode_prepare() before
> entering the work loop.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/linux/irq-entry-common.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index b21fb5893a67..e5815511a80a 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -8,6 +8,7 @@
>  #include <linux/tick.h>
>  #include <linux/kmsan.h>
>  #include <linux/unwind_deferred.h>
> +#include <linux/irq_pipeline.h>
>  
>  #include <asm/entry-common.h>
>  
> @@ -237,6 +238,11 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
>  
> +	/* Synchronize the in-band log before the work loop so that any deferred
> +	 * IRQs are played before we check for pending work. */
> +	if (running_inband())
> +		sync_inband_irqs();
> +

I think there is more behind it. Seems your architecture (most likely
risc-v) is missing one corner case in the low level IRQ entry code:

Potential stage demotion of the preempted task which originally entered
on the oob stage, then left it for the in-band stage as a result of IRQ
handling. This should happen in handle_irq_pipeline_finish() - if required.

So on IRQ entry you are OOB, after the call to
handle_irq_pipeline_finish() you might be inband.

In that case you most likely want to call irqentry_exit_to_user_mode()
with the inband stage stalled:

Taken from arm64/x86:
if (unlikely(running_oob() || irqs_disabled())) {
	...
	handle_irq_pipelined_finish(prevd, regs);
	if (running_inband() && user_mode(regs)) {
		stall_inband_nocheck();
		irqentry_exit_to_user_mode(regs);
	}
	...
}

>  again:
>  	ti_work = read_thread_flags();
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))

That said, we should double check that this corner case is handled right
on arm. If arm suffers from the same problem, this corner case is
missing in handle_irq_pipelined().

I hope all of this makes sense at the end. It's late...

Best regards,
Florian
--------------XyKZEYap9WRXeyBw1uezNRQL
Content-Type: text/vcard; charset=UTF-8; name="florian_bezdeka.vcf"
Content-Disposition: attachment; filename="florian_bezdeka.vcf"
Content-Transfer-Encoding: base64

bnVsbA==

--------------XyKZEYap9WRXeyBw1uezNRQL--
