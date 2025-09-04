Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5F2C21D8
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988034; cv=fail; b=G7B0d6pi4YGTQqA0h/qVHbo11s5a+bLk8CBVAyENa/liHSUsBOaDcWlnmP5ZHjTb5X95f9G8lFPgphyc3OxuTHylrzeoTDuP4QuDsJMXnDFHAUBi7GtDFOckrMYfrzdzGUkdGF+lJ7lRBiQn67TUfrZP07WWN4KDf+gRwbdYmp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988034; c=relaxed/simple;
	bh=F1wDP5xeLMfftc9/Z+T4BydJwrEbOOca0KgAOYq8NzQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dU86idMK4dTXnTYvtx8E4+Nmc+WB9A5giE/DYgnl2d7sjwyW6aOisC9p0NahwANQtwtrlKUecBusSQEyC4BembTW6EgvCnTZWKlytgaSOwOak7MAlL6hoN6dCbwUQjYnJrnGc52qRTG379Zwyp5so8woFMRByRHlwC49wJOm0Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T/rVnNBm; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T/rVnNBm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0T+ToZG7c+kvHxttRarpUFwgP8E1hVpO/pvUMvXIFmdnc2QzqLaOeiewclWn9tuDLsGGe3iP2mWdJQPD9IjZgbTMyBdFu/H8nj2EuZgSM08MifXHwvFVxfE22VvDbcIZ8BvDzx9DDpaG55eNM6TGBnBVkO+KIba9fmmk2aIss4NgNgCIy3SWtPb9QT5hQmj5rGkmKwJerDhJtAlr1whVDm99zPCZUP5cLHLTBl3UuCpylUimMCEbAByS9rE0YbcrZmJ4prS/X9W61kjJBmOmyh1JHC0BmgqtZor6ZFYniEaA3gsCL5WcRODlQAYmzh71tSR4VNwmUv5alOBEFy3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXz3EZmkUj6JdHLm+wHtJZ/oeoy92rQi6X+ycDJI4KE=;
 b=CAiQjIVTwFLJHbPLNhpALQn0t4S/kurpDFk/7/xLaLsH+Tw4H1ktrQBcsHOLFolKP4Bjj1Os7Oj+xtScKXa0+0XL70oGPT6CYribz61X5uL8c8y9pSvAck3CQ1rCOADkXBNH22wDg7NH1gywzNJ8pDP6cH7nT3d+RRRtCD13+uM9uVD4xGI+YYGajfVFt71VhThL6bh0rhxUeXDHOelWbkIX3IrWP9DqvavL4RxFMfB57HxON5FZUJ8BXJ/aHI9BgNjqY4sKSMcIzrHBW6S8/kAeusgaLs3wpyidOXKRQBsvHEIrnrGmEa2yiR1PPWYbqpccLyeAtiujvNL3XUMTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXz3EZmkUj6JdHLm+wHtJZ/oeoy92rQi6X+ycDJI4KE=;
 b=T/rVnNBm7+hZyx6d4rlITQRPK6X4TRpCs0ZJ24hGmTPffSoAIcQ6Op1CGizWS6EFyEEE/uzZGFK0FgBqnSCF5VCzj81/0rC+jkiq0sJQOB0Pbrih5Q+7U7+CGQt8EFhfismUBVOM3tzNmAe5dvSJZoigsMm0u6ek9pZNV2i/HMBUQ9B+fAafS9wnZzMQrHynjM+qraFEt0wL+Nl6c9ZctM1MnK0SawoHa8jdTVQcJCcLdcEdDtwV/YdoTHOWSCJTqZteuKcozIR8sLZ/BEPPjAgja0G+nVwRrzPnjXRUS72SZRw0EM41PN26qXpclrhhMathc7hMvzgsTvBYFWIqiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by GV2PR10MB6113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Thu, 4 Sep
 2025 12:13:45 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 12:13:45 +0000
Message-ID: <2d7ffc62-687c-42ee-9a6f-86b81d7b3f64@siemens.com>
Date: Thu, 4 Sep 2025 14:13:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: check the device health
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
 <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
 <85b19acc-fd42-4a59-83c1-0063afecff62@siemens.com>
 <170648d9-b953-4827-b79d-6b5f22c7ff96@siemens.com>
 <abfb1d64-5310-4227-91b6-4fd962a4424e@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <abfb1d64-5310-4227-91b6-4fd962a4424e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|GV2PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 21da890e-6670-4fa4-7dbc-08ddebac7ea7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWcyZGx0Y1dGVTgrSU1SVXJ6Z1hWdDRES3VVOWtZdC9MZlNiV0E1RE42VVR3?=
 =?utf-8?B?S3I1SU40QTBkQWIxSitCaURUK1lKaFlONEZKdHEzQmxSUm54aVVnQ0dIMHo2?=
 =?utf-8?B?RnlQVnRlUWwxQVJVSk1uSldBbHVocHJTK21wNWhOYWxCSExzVjJ0eWEwYnBw?=
 =?utf-8?B?dDBPOWt4VHI3Z0VRZlVSeXd1SDFsT3BVak1MTmVxdkxVeVR2RGRDcTVqalhD?=
 =?utf-8?B?Q2N4Z2VFdnUwbnRaMElZekZWNWZSeW13RysyaHN6dDFuNyt3QlorOVo0d0dn?=
 =?utf-8?B?ZFloT0lsbE40SmExNEUrblFIL295cjBlVG93bHpqY2ZjZjJWTUEzOENKV0hN?=
 =?utf-8?B?bVhHdXkwN1l5MW9Nakk3dmJRcFBBeGdKcXRiQTdscmNLL0Rwcy9lL211Z1M4?=
 =?utf-8?B?UzNrcTJta0h5eE9KVUQrcHJsNXlHaTh2Q2VVQ216S01vdGkwWGlpK0RtUXJo?=
 =?utf-8?B?L09DYjBUeVNsS241THo1dlFRUitheGV0dmlPV0o4STd3UTJwbnJFaytHNEVH?=
 =?utf-8?B?aFJ4QmYvcTBIODlUams4c2F6VHJmWHZBdkY2dkpCdkVJQlR4UjVDNnhrL0dD?=
 =?utf-8?B?b0xGYW5hMkZiZ1lDNmtta01pYnQzQ3dVR3ZpaGZXN09Gb0Z4NksyOW5SUXQw?=
 =?utf-8?B?ajVPdU9Oa3ZqSzhySjJJMlE3RVluck9kbkJONzdiQXA0dm5WVk52Lzcrb3ds?=
 =?utf-8?B?ZWFBUGlMblJOWXVBTlNCTlhVZlRsd1Y0WmROWUFpbldLWVBqRUlOc1FLSThV?=
 =?utf-8?B?S2o5dm5ONURQZFZaMmYzdURrcTdRSmJJMG10ZVE0Z296OTZpTG10MjRQS1Ji?=
 =?utf-8?B?YUJINUFDbUhrdWhPcmNjTExSWklqVmFUNmlIb3JaemxvaWF2eG1vY25uN1Vm?=
 =?utf-8?B?R2NSczBJMXpseWs0a2ZrbDYyVmdEVHJwZTJITXJXVFMxM1UrRVdTaUR4Q1Vj?=
 =?utf-8?B?QVNDRzN5TUNhTkxhNTRqOVZEOFpISk9LcVNsUS9HdXl0a2Y5VHJhZ0FkVkFD?=
 =?utf-8?B?TnN5ejZtWHoyZzNmQ3I5d1hib2xBbldYb2pKQ1BKYUJDMUc1Ly91WmxsZHhZ?=
 =?utf-8?B?NTdxYUNURDZoN0ZOUlh4aGJyTUNYUmlzT0NRMktRN0FrY3RXdXpQNUt0ZlZX?=
 =?utf-8?B?eXU4RVZUTUwxMW50OTlDcXVVQjRraVhFVXpLdS83MS8xWldMQXlKaHlGVnY3?=
 =?utf-8?B?MDBhWFgzeEd2OUhQZjlJOEh6eXFtR25ER2NVbkNnLzZYN3lkYzRrZGhJSkJn?=
 =?utf-8?B?RDBqOXRxK0dKRkY3WFZ3c08vZWFCS0lyZExNSDVxTkU2ZEpiTmhJOHpWSXh0?=
 =?utf-8?B?VzJ6S24zQWFDYVFkY3g2UWsybE45NXdFMjdyb2t5WXNudG9aeVlybndMZnQ0?=
 =?utf-8?B?eitFWkdkUXE1UVZ0VnNRYmVyd1YyamUwWWZvQkkxbzJNYlN3MVFtY2EzU09L?=
 =?utf-8?B?ZGNsN1h4QWYwN3V4K0ZFM1RpMEtqTVk0UENoOCtMY3RId3grUXVGQnhmclI0?=
 =?utf-8?B?MzZzMDJqQ0lrWEp3SklsSzRzclBtQjF6dUZ2YmdDdlBLb0w5dDkrMVBCd1Rr?=
 =?utf-8?B?OGdkN0xzNlRlWFBSSEdxN2p3MDdJT2FVQVB2czZHbVpsS2l2L0RVVmthQi80?=
 =?utf-8?B?VEs0cS9Mc2Y0TGlIdVpuZUhhZW0rUXJkd2xuOExhdVVMRmVFZEhseEVDcUlK?=
 =?utf-8?B?ZldxbXpIc05XOVpRaHRRWE50NmJGT2V0b01aVFVtNStHdUltQ3FLSmhaUDNl?=
 =?utf-8?B?S1BtdUhtZUVxZ1UwVGxtK3BML0pCVzM4SjlXcGNFNi9wT1FLck9BTXY2akhR?=
 =?utf-8?B?ZzVGNnZuRUIrSzNEL1k3dlBIS0IrUDkybzJwa2pBTWtsRzFtSkxsRmFHdTcw?=
 =?utf-8?B?WXdBVm5lREN2VUJnbW5lRkpMclFFYVJZam9nV2pHaUNuNXVuRVp5RERmbzcr?=
 =?utf-8?Q?U03MxXKnc4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djl5L29ZNDVqQzZ1b1hVQnBpc3J6TEU3NldRd1NLajAvSEJCSVhWZEpJbVJt?=
 =?utf-8?B?YWNzTEdLZXl0dVRuQW1xY2tOazlRZnFhVVIyb21XbC8rdFlqeUdnOWJtZTA1?=
 =?utf-8?B?SW1wUVNGaFkxeUxsd2p0Uk9zdndzWm5kTFlSNm5PeW1Xb0gzR0lsMjMyeDho?=
 =?utf-8?B?ckMreVlGdmE2cnFUbFpkc3U1QWVvQUpVM004UkpWay9SN28vMG1vY0R4MS9U?=
 =?utf-8?B?d3pobDhlbERKRGFEZTZiOHhnVmxkV0J2dmw4YW5vYlpwYUFESVFBNS9jZ0ht?=
 =?utf-8?B?OTBiU3VFaWFLS3d6WVNQekVLakc3dWZSaWJDRkJzYWN5ZzlmRkRjMXhkVk1m?=
 =?utf-8?B?K0dYMU1xLzN0aWhEN1FuRzQ0aE1qZS9jeDY1OGlEMzVRVE4ya2c1TWk2cHBr?=
 =?utf-8?B?emVtOUViV2pSQkRMVHFxbk5CS3NOR1lweFRXbkJUSW5YNWNRQU5nSWNpRGYw?=
 =?utf-8?B?TXVITHZoZTNwbDlweHMzMXYvVTQxYW1mazJHZW5QUXFCTXJMUXE4Ym9hc3la?=
 =?utf-8?B?SWhMQVFaOXlEY2VFOCtsakVsc2UzbjlPMnM3SW1lN01pSFpzWUZqRGhaalo0?=
 =?utf-8?B?WWQ0elJkL3hyVmEydUt3YWc2NFp6RzVnRkQwdnJQcmwxeWoxYkYzWE1LL3F0?=
 =?utf-8?B?Y2oza2Q2SjRNdWZNcEZwb3hGUlpjWGVVRzZTTlo4T043QklNNGN3SVN3c2xJ?=
 =?utf-8?B?N21Xeng5cG5yQmNrZFg5WENLQ2MvQ1d6UVorbEFDV3o0a1JwcFJHckJMeGNo?=
 =?utf-8?B?WVNDWkpMcmlrcUd3YW9qYTR0TC9CdUlJVlFneFVoa0s0dzMzcWI3L2lLTkJV?=
 =?utf-8?B?c1ZSZTIyMUpycDV4Y2ZKWTl3MGF6MXJTYjRGaUptWWJ6dUZiNVRqcldUaWN0?=
 =?utf-8?B?T2o5VkJwUHR1SmVFa093WDJIWVpWd3RtbnFtQ0VNc2pybDZqckpNL0lSRnRV?=
 =?utf-8?B?MTVNQWRXd3ZXcDFuVi9Sekl2V0JndEFEL3dEcWVIRWYxR2xVSHY2Q0pvWnRw?=
 =?utf-8?B?UURRc3ZqMmJsUkZrcDJvUXBjZUZFbzEyM3JQS1h1UTBNa3V0eWZpL0ExUFEx?=
 =?utf-8?B?ZFhIZ0ZBdmVpY0pqOHdpeXFaRi92MDBIMHJIVlhDM1VsMEZmeVB4QTlYUFEy?=
 =?utf-8?B?YStraEs3bGRyWGpsMGxlT1A5dmMwSGlIT1lhaHN3TnY1bTRWREdMTG1weTVo?=
 =?utf-8?B?NmRzMjI5b21Kd01uSE14cWRpTlQ1Mk5TdWpIT3ZrbUpmdjdYbFdQbmZDMmt2?=
 =?utf-8?B?YWJBeTVXSkR0M0VqajFlUDdFRE1yL0xlQm1ZS3VvbzlzWnllL1lPbDRka0lt?=
 =?utf-8?B?OE1za3E1dUEwMlhZOFYzVnlQWG1zdEJHVG50Zm16QnZaZHZsb2RGM1lLUWVL?=
 =?utf-8?B?ajdlenQva0hzVEdrUFF5V24vN0NDZWs3bzNBMElZMlNpaEZraTJvRyt4cm05?=
 =?utf-8?B?Y0l0Z1hoZ0poenRpYi8xcHhnTXA3QVNWOWI2MHdNVFJ3eUxGNkltQ0FJUTJ3?=
 =?utf-8?B?bm1wRHZGZi9TbkVYT3AyS284Q1FLU2lvWXV6WHZLQVBxZ29UOVlRY2Z2L01m?=
 =?utf-8?B?eEV6QTlFZG9RZWhvZ3dGU0FVRjRYUFh3OUhUMFZKeDJQNkJlSjA4WlZkV0sv?=
 =?utf-8?B?b1VlQUdUVWJJdHhhOS81cUdzZThidWh5V2dZbDE0MzlNTTlZbC8yQ1V3eFRn?=
 =?utf-8?B?bkNseHpNV1g5elVOaldVb0hKUE8rZVI3Y3l6WGcxZkZCcjFPdmJmTEtuTHlE?=
 =?utf-8?B?K2lhRCtYd25ZaHUrdWFaTEhQb1FGTUVZb1REbHV3Z29saXFPZlRObkFTbU15?=
 =?utf-8?B?Yld4N1JQZkxNV0xHbkRXb3RFQU1RUU82NTZHdnJyNVFhU255Y0lQcWJ1TzNv?=
 =?utf-8?B?NXhpTkRXR0QzUUgvTkNrbWNwUU91MmpCYlBnWEFwdGQrS2ZXbVkxbW1zSVhw?=
 =?utf-8?B?c0FaMXhVRUFGVlNDcXdVRlVMOWx2YW1rNUdROWRyL1JKS2p6UU1Rb2Rvckxl?=
 =?utf-8?B?bkkreHJjblhHaG5MQmt1OXlzM1prNmZBQ2VEVjJEaGhWU3dxVkhhSTUyb3ZR?=
 =?utf-8?B?N2xidUVPd24vcnA0eCtGVnc0bnlkaXZoWkordncyT2ZSSWJIRGswME5YRWxy?=
 =?utf-8?B?MitqSWRDYU1qL25DQTFNeTBIZTZwRHpRbmRUVFdwRHo5NWNpTi9VQmVPeFRj?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21da890e-6670-4fa4-7dbc-08ddebac7ea7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:13:45.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D5bn7hhZZrXPLJD3W+qpkhZCcPvZbzq/GZVpGwX0ZGZrE8FpdPnjSgpmibBkP/nDkCfDln++nuAyzyheZiTWNN2CVySI1LjamusE41moxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6113



On 9/4/25 13:23, Quirin Gylstorff wrote:
> 
> 
> On 9/4/25 12:47, Jan Kiszka wrote:
>> On 04.09.25 11:58, Jan Kiszka wrote:
>>> On 04.09.25 11:42, Florian Bezdeka wrote:
>>>> On Thu, 2025-09-04 at 11:29 +0200, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> Check the device health and the device state. If the device is not
>>>>> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
>>>>> minutes until aborting the test.
>>>>>
>>>>> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
>>>>
>>>> Hm... Not sure if I understood the problem correctly.
>>>>
>>>> Assuming Jan spawns ~5 or ~10 jobs for a specific device type when
>>>> pushing to one of the Xenomai 3 stable branches (or something else that
>>>> triggers a lot of test jobs):
>>>>
>>>> - One job will get the device and will run
>>>> - remaining jobs will wait (and time out roughly at the same time)
>>>
>>> Right now, they will not run yet because of resource_group:
>>> <desired-device>. But if we removed that, we would have to take the job
>>> runtime into account while waiting for device availability. However,
>>> there is no reason yet to remove the barrier.
>>
>> Unfortunately, this is not true for qemu devices right now as we have 3
>> less than when the Intel lab was still around but even then not enough
>> when a full pipeline run hits the test stage more or less at the same
>> time. We need a much higher timeout now, or we need to throttle qemu via
>> resource_group as well.
> Ok then I would send a new patch were we ajust the time out in 
> the .gitlab-ci.yml.

in https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2021409958 3 
jobs failed due the timeout:
https://gitlab.com/Xenomai/xenomai-images/-/jobs/11243163456
https://gitlab.com/Xenomai/xenomai-images/-/jobs/11243163391
https://gitlab.com/Xenomai/xenomai-images/-/jobs/11243161947

Quirin
> 
> Quirin
>>
>> Jan
>>
>>>
>>>> - one of the remaining jobs will get the device and run
>>>> - all others will still fail
>>>>
>>>> Correct?
>>>>
>>>> Does that really help? Maybe one more successful task (when the timeout
>>>> was enough to wait for one test-run), yes, but is that enough?
>>>
>>> The main issue this change is addressing is that NO device is available.
>>> So far, the job would wait for hours then before timing out.
>>>
>>> Jan
>>>
>>
> 
> 

