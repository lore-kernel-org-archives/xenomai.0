Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8B3A0EB8
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136092; cv=fail; b=KCDchqQRQCABDgcFVZxFCCTeWOsEKjt+bBf3MQjmhqiflZitAOOAa3ReIJ9JrLCshUb3Q5+8HhonWjt/peEXeIUU7PjwC9hZsS64cHi4vH35JX532miufTohCZsY1ejk9BGSCJCHpy6uLuq1Gwk+1KGh0wtQijDORG/yiGS6qbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136092; c=relaxed/simple;
	bh=hmNjUO+/sOBFSON67TyzA1dOvrWgzgVIFYrCTeM1lHc=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=aqoqX6aSl8VP3fp7ICjtKm9n7myvnIdMwZEMYOF6B7Q5oNk7OMLXgLJHoxXpE7p9B/QRnDsv7rbcwUA39MSiC5J7xHGniycphEuEp2ToCIjy6cDWcoxn0OunJOlImdMJwL8yMgo1NU/pFDXYijmCdZvz+ZlypfgwRBGB01wZ/fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KAGQuYG3; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KAGQuYG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv2faZaaEsGVREC9bKlFtZaIPyfXAIJVf9VHBD2X03AqdyzISa4eD8yY0ahcrRH0b0PEVN4ubexEAthE0KBqw+vueU6xU/OR46jVLzLBku5Qdh9PO04BX7RB+hcgc+oyYtiTz55Q9tH+SD0bMkd28hkUOCjy8iNn7qAwgl8mlU4nVGuq1LSVwhMmXpmA5TUtAOHD+yRr/4DLgVdmjar5zzHE0/CJn/ceXN31ENh03sRg3XF7jRDu67lFuJwWXVKWxFZ+ArCAgokDjkdXD/E2KprG4FsBY6UQ5jDUwsGwWbVOJX26rztE26SeSW5jN0IVUzHmGgHDnlCDdrhJnangaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNQoDq21v6PmEsB6x85jyMAceyCMMXy6NYbcYhebj9M=;
 b=A3DYarc7h0gjmwR0s2Y+7LYtFfdlgZGUpfKe9pR/Qk5rdCnmvjQpBjoMOzTz6LODI1YLt27lA0wRHwDNQ9fdU0nuuvOHE2B+atsnDcJzza+sRAx47kaUD4wl+4Nh+BtAePOToULJyAAa60f7rZ9PDnHaVArdLFqg3bLBH4xeLuuS6aEpJtU3FenCHE65Fhp44Nrdj6Kt7JxOY4/iNaQotNeDXRP84n94qb2EmdKEzjQahKJSjF5pOQLHAH9Cfo7BAza7z2grUqNJitQqQKFkEjqrJ000wz4Unc8j1kavaMv8SU43sr08WAxDGalZ1Eoxy2+C6Uhn1UCTDq/oVOLS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNQoDq21v6PmEsB6x85jyMAceyCMMXy6NYbcYhebj9M=;
 b=KAGQuYG3Zm9Wdh+Fm+vXNYHvdMjcryCy6avOkHBu02iWKEFvVRw6CZR0/R20kMkah72+3chnrytrUXwn/QiUKo0ZejcFc5gjWmRsqS9SY+33VwprfQRuj9qwxDIvfljdQegQH7l8n9ZoU4x5WOP0HZou0oGIrlvl2vB4o31sngsVBlTrXmUH9vkFpdyW0b+jzdi4Y4APQB3PgHJo/9i7oSsr3seUKVopEzkQDhLknEyUmgGx2Cya66XmqwQYXB+o9+KcjNdzWNfBfJt4DFCOFBTjaiwVlaNJJAZBafRwDfpLP0kl0dVR4Z47hMszm+S/9xdx8HaU++7uUQHUdKCddA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 3 Feb
 2026 16:28:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 3 Feb 2026
 16:28:07 +0000
Message-ID: <074a123c-c6bd-46ab-b0d2-6912ea08c1a8@siemens.com>
Date: Tue, 3 Feb 2026 17:28:06 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, February 4, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU2PR10MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d069c8-b796-43c8-4ffa-08de634136a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aThwUCtCOUlQM25ZRytxSzQvc0VUZ2NPczRKTURhU2F0eGp6ZlBEakJ4dTNx?=
 =?utf-8?B?TTJJcGJCdVdMTEdDdU9pRlZ0RGJwcTBneU9sdEpKUWtURWVrbXdVTjVSK3R5?=
 =?utf-8?B?TWNIVDhoVmgzQnNPaXUxRmJtK1RlMUt5Nm00RkJ1anorYXErWlFPN2w5ZG1S?=
 =?utf-8?B?R2ZwbE9yRDdUUXhkdTRyalhHTWFBWURzN0VrQ3FHcWtkWTdsdnpLQjlrVHRH?=
 =?utf-8?B?ODh2MS9TVlo4eWZlNGIrWWIreVU4SE1RTWF0Z01RanVrdnJWdVlEZExmZm0x?=
 =?utf-8?B?SHpMK2ZyUkJuZ1ExYzBrRldVRTZpY1A3T3cvUkZEWEZpbnBOTk9NaW9VQ21G?=
 =?utf-8?B?R3dRNW9teEZDY0orQ2dRTXRwZUV6NnozMGhleHZyelA5eEZlV3BzN05yelRw?=
 =?utf-8?B?YnVNMmpaRjdQK29uU0UzYUtaKyt6Q0tiSjVYbWN4cHVITHlxYkI4YktPYitm?=
 =?utf-8?B?alkrRTByeGZvbnI4TGoyazJOMWRYaGdGVlRKSzkxME90L1FJNk5OVC9SM2Er?=
 =?utf-8?B?R3N2RDRWNnFmUGN6TkRiWEwxRFUxeThIVlgrYUpLbDNXK3RHTXkraXR0NWV0?=
 =?utf-8?B?V0YyRERyNzdqUEVuZHhtNm52a29XeTBzOXpZQ2pWRFFMdm10K0Z0S2JyZDNl?=
 =?utf-8?B?QUxObkpSUEdCRmd4Tlc5blQwMGtLeml3a3U5Zmd0eEpyK29oTDU5Z2tlRzhp?=
 =?utf-8?B?MkV6S2xBTVRpck55U29ja0YrWW5pRWl5OWp5RVlNeWVEcWEvbG5aQXZFZ0Zh?=
 =?utf-8?B?VW1veVJTQVZ6b3JRYW9qS1hxZXJubk8xTDJtNk5IR0tmNy81Tm5kaFRULzVn?=
 =?utf-8?B?bThDb2VlWTQwRktLRDZFNUdKRUpmVENJMjRnL3pGSitKYW1TLzdlRHZQQ1Yx?=
 =?utf-8?B?VGhtNm1IZStwaEtBVHVYWXdoM0NvOXd6ZlpOMDh4WTVLOFpjeVlyR25ET093?=
 =?utf-8?B?ZE1BcW5FMFdXdG9XT3h2QzRVaE4zQVdhMkJKYTB0U3hSb3o4amZxOW9pdWdI?=
 =?utf-8?B?bjcxR0htci81bnorMVJTK1NXYWc1VXcxdlVoV29rMmlIY2U2aFBEUE9FaCtT?=
 =?utf-8?B?QVJKU1RCTjlGelErS2E0YzAwMTFlREpGTTlMN0RLa3hHTjVuemR2U1VQallX?=
 =?utf-8?B?TnczY1hGZ3VsMlRWRGovSEtjTG5FSlZOOUpCemlRTjZOWWtYcW9oOVJPczJD?=
 =?utf-8?B?QWZBVWkyL0RZTEt5QkRYNXB1elA4c3NqZ3NXdHVEZDRqYXVna2g4TFVaUDZR?=
 =?utf-8?B?eC84YlJrSmdrNmdhYTVPU05qWE02RTJLcWxXVmpwcU5WQkVScUJ0TVhOVnIx?=
 =?utf-8?B?N1gxV3RPREdVQmdaTTdHUVFLV1FuNGtHS1E0c043dktxb1E3Y1l4QnJpUkEr?=
 =?utf-8?B?cEF3eFNocHRqZThlZ0xDZG5LVzdjYlJ5Vk1NY1BtZUZCRk9PbzVSZ0krQ1Zx?=
 =?utf-8?B?UVZLelV0R3lhVlI1RXRDL3YwcllBOWdtMW95bTlLcVoyeHNqQ0lXb2wzTmsy?=
 =?utf-8?B?bzM4RTRJaEpDbzc3ZzdxVU96aXZUd1pld2YzZEhtbXl0L0NJTFZBRDBvd25T?=
 =?utf-8?B?eUxoWUdBWXhKSERVS1hkWG1Bb0RvYlVXWnBLTXdOaFZXMWl2NTJLQklEeTk5?=
 =?utf-8?B?Y0wrajg0NTdabTBTeXVhNy9WMkJnT0Z2UzcwUFFCNktYb28zVG42Y2xXRUtj?=
 =?utf-8?B?RVZRWjZWZUlVM24vQW95aGNBMVBLdTlXSW0xeU9aOWhDcFMyMnVHV21TeFc2?=
 =?utf-8?B?VTZsMCtjWTk5NkFDVzgrOFRxQkhKaWUvS2IzaytCUmNDZEozQWZWelZhS1Zz?=
 =?utf-8?B?SFlXL1NMeGg5MlZyYnhyc3E3Qy9yQ0hzemNoUnBHQ1dhck5WL2ROekVaMjd3?=
 =?utf-8?B?dUthcDZ5SWlmS2VnY0NTNEYrUTdRdExBa1FGQ1RQbis1ZnhWS0d2NlpGb21r?=
 =?utf-8?B?RGNaUVd2Qkx1RG5iU082ekRpYTJJNXE1UkRORzFpK3lneGo3N3dLeFAyWElK?=
 =?utf-8?B?QWVRWEQzUWlJd1dVSHZOSUpWaXFVYms5OGgreTJ4N2dpWmY0M0diU21TS1JY?=
 =?utf-8?B?d1pUMUhKSUJ5T25PQ2FNb0RUNmlnSlFQQU54SzJvdDZMVy9iSyt4UFJtRzdC?=
 =?utf-8?Q?OOO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3VRTnRpeW9WMWNhSEc3OGhaK3VyU2NNSDhLY2xxMFozaUdDbXVURjVwdkVT?=
 =?utf-8?B?MVVXMzBSU0QwNER2ZjBLNDRjdjhQdzJJSUtPbGcvSFpYUkZ2ZWJWWnB5bXlZ?=
 =?utf-8?B?bmZnT2djd2R0bFFuWnQzeXpHZjROTVNEZDVYdm5EcExkYXVBZzZxb3ZCZnNs?=
 =?utf-8?B?aWMzdlB2cjlwWXFOVDFmN2gwcmtHTTI5Z2h3V3RnVGRlSkZDMHpRczFjRVBK?=
 =?utf-8?B?Sm1KUHQweTFxZXA2alluWnRyODVrZzhPMFZnamVubTBuK3RUaXBCWGk4R3o1?=
 =?utf-8?B?OEJ1VzM5VlF4UU1GU0dIM05ZZjJURHZjMkR1S3dXL0tCMk12azBRSytaOWsy?=
 =?utf-8?B?UVJQR3VWVlZPMWZaaGhnNmRRa055SG0xNmVqL1U5ZTRyemRVelppR2ZRZFpU?=
 =?utf-8?B?enFZVkJ2RG5PSlcrQzV3b3MyeHpNM2taWElqRU9VQWo1VUs4cWRGQmZaSWxM?=
 =?utf-8?B?YzFISmhWRVhNTFVMeWFPcGxYMmJCL1pXbllXUzhtblAvODVxcVBDRmNzUU5u?=
 =?utf-8?B?eWlFQW9GQzIzK0hLMU5zYWJKOFVsUEdBa1Y0Vk84L2pic3lRMWRiUndaOWd0?=
 =?utf-8?B?NmorWDQvTjU2cFgwOS9DQU41QzJuUTlQUjM4bzErMkVIN3BQYzRXREg2V2l3?=
 =?utf-8?B?eU93ZlNWOUdoN0U0LzcwY1VlNm4rVlEwbWs1MHFuWUcxZTYzdXQzZVo0aWl3?=
 =?utf-8?B?bXNEL2tXQ3cvVy9uZEYrQzdXM2dTRExaM1BNLzlkb256TmtwWVl3ZnR4cFFU?=
 =?utf-8?B?SDhsOWxLVjduYTFtTkVnQ2c4MUxWUU9tUmJrQWpqbTN5a2JWWmI2aXh5Zi82?=
 =?utf-8?B?VGp4U0ZheWVGb1Y4TExjVzMwek5vOEdxQ0ZEbDdidlZvd0p3Y25hMjZndlRv?=
 =?utf-8?B?RnFzY3lIckg3MEtteHA2Y3pNL0h3OUd3Mng4UGZKbDBCTFJldTVySHVZYU9k?=
 =?utf-8?B?R3kzUk01SkR1aEg1cTE5RUJTV0Z1aTRXcEJNNitIUUY4QzVxMUhpeHJSNndm?=
 =?utf-8?B?aHBRa1Brd3BsQWxEV0hVV3kvRmI2WEtDUWV4U3BBT0pnMEF6UEF2a1NEUHB6?=
 =?utf-8?B?dlN0bjlHVUwwMWZndm90R3RVb3VyZnU4Q2hTRzJyclVmQ0xMUkZZRnFaWjA0?=
 =?utf-8?B?a2xqaWpjamJaQ0Yva1RUazZUNHp6SU9Jd2JzWEJBOHk3Wi9BQytjekNleU1P?=
 =?utf-8?B?bjc4ZTBXekRYVU9RMDAvQnFzenVsOE51L01RbjlUQWliTDhEKzVNKzNuT3Qx?=
 =?utf-8?B?OTJTQ2FuUmlwWWpQSGpDVGlmUEdyTjErQ053QjhMY05ZTHk4TEpHazFjTkRI?=
 =?utf-8?B?d0V4N0lwd2RIZkp0MjAzVFVmNUk5WkJKSUhsWEpwZndUZ25FbUF0UTNDYVlD?=
 =?utf-8?B?UjlLZ2hodWx5eGcvY3R2eHVnOVpTcEpFMGdieVVobDZHdUlrNDZXTVphb04v?=
 =?utf-8?B?a01vWlVaeGFpMkMranA2Z3Q5Uk80VnVxVk5oY1hDcVd0TGpGRzVBUzlzTEd0?=
 =?utf-8?B?NVJWMG5jMy9CaUxVT2RwSGs1UXF0ckhCckpORWJBQnM1QUl5dys2aHpUMkNJ?=
 =?utf-8?B?VVdIc0taa1BZRUxDbE96MGVJeVFwNTY4MjdmQjY2N0xsaVdTUDYxUGo4dzUr?=
 =?utf-8?B?K0VibWVTUjZRTE9mOFJXeDAzb3hXWnVybUNQWEN2VlhlZlpCVjIzclJiWXlw?=
 =?utf-8?B?NVVLMzZITDVSZXJLM0YzQzdNTkZoZUdrWUlmazQ2QXcvQ2RnMGc1c010aDJO?=
 =?utf-8?B?bXVTMkpGYjY0SGFoTU11c2FrdTNYOEQzeFl2Vnp2Q0FWWmtsZGNhOVlmcmp2?=
 =?utf-8?B?SGdsNVBTNzU4T2hJMWlkN1poNlFSN2s1UmJvWTJkRFVFQTNnMEZHdlQvY3Vi?=
 =?utf-8?B?VnFleFRPc1cvcUFLM0dHK01mMlozM1VYTHJOL2dlYzA0WGJuTzhZdmpIdWF0?=
 =?utf-8?B?UkgyQ0NnNkxjVjhCVWJmUnlrWkpXWXdVWDV5cVlvNldYNEJoSW1xdUp5ZDBi?=
 =?utf-8?B?YlhHNk9qc3FMZDdXUkFiMFF0b1RDaHoyS2xyWHo0YVYyZDlYa2dneUJiU0lL?=
 =?utf-8?B?UWQzRmR5b2YxMkx2RWJyZ3NpUGcrYVZPMm9wWldwUW13ZXVrUGJIeDJmT2R0?=
 =?utf-8?B?d3c4b0dhK3E2eVVyT0toMkZQVXVBZDl1WEhQMGd6NHpBUUhQREw1b1NZeFd6?=
 =?utf-8?B?MHNtWFkwcEdyU0lNM3JDUmREdUZWU2ZMWjhKb1EwRDFqbUpvSk9aTy9wRTJw?=
 =?utf-8?B?bm1tLzR4d25ISzFERzJBOVVvNDJDUXRpTkVETkJvTGxHbnU4K3lMNGFjT0sw?=
 =?utf-8?B?M3I0b2YxaW1FZHFjWXhtMWwvWmhWbURKRVY2dVMxMlpQejhSWGdzQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d069c8-b796-43c8-4ffa-08de634136a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:28:07.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nbuc3tI0PveSKF/ec/8NDkUTRkmXqcIER5k0Q4aXe1OCpgZ0FwU5Ky7cvTjtaECZcMhAvlfSsqCeGFa3BNAWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7766

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, February 4, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
