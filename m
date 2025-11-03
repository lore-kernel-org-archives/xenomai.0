Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5C2D8780
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162192; cv=fail; b=HTsBUcI0EjryfpAANaaUv2pWqrmveba3eQeHFhhbe4uiJVHW70o+dDtwycpqCzoVDIi2u36qUdAH8LNRa1vmOZ8pkvSSYyFOrzezz2Rs4NZU1rxBKs05PsCp8Rth6dPkLzukTtEWsiKu7rA2HgR+h/zguO026SLdxC1jC2LOa0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162192; c=relaxed/simple;
	bh=Trd2JpKVRi0/Xw8TFHojpaPQqHjWQGUVC7VLyJ7bsFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GEorjqAQUe042mgB0CaYNh13vrQye3CNPHypdNYjwCJKG2j9NAR9SBRsmhI/2O1vWdTZnJkUu2Ni+dS33+TQoJ/CCkLXtyZ1ryakLIdQQjo9wP3JnWhzPkGkk8G7r1DzqaM+RH6dCSB9nhWjIx7KqLhwPQfm61F+W2LbIa2+TFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ipYbGRLm; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ipYbGRLm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRdXlqp5ET7OJoYtywb4As1KRv2/UXYoWQqKFeLvNS4Xz497xVOmnN+Ys167GWU86A7SSPBsI+ug98/kp1VI0B9f3QylPDBeS9q9yUB2fknw9mheDOgV6iGIvX32RHAoDuqkTyVhjbyf6oseTS9It0X7OJTmNoGR+Xr9o5GvwqLXXWUlG/M6Yo3uvnjyLoPM0mbj/b02xVUpScqaPcyKIVjW3jKjrMhaX3Q3WfjMshTSw+wt3UzH6UYxVXJ3+P4sch2xPn0nQoarv7Cd12pkNdaLx8hD3i13/no4kbvoyIduj4y0NJFvt1JxttN2k8Ww91tFhp0PhTAETJen7tl5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ5beVmKztSpk+5SA7Ekmo7OQUdgpB88psH46pqrzFs=;
 b=YWRl8XGpJHKnqZGrSC4XNUa80rtpp38++0PFwMDeppHJSVxwCF6+TBko3i+ZBrJAZDq0JcxF68qh/IM5av3d18g5lokcFf6M76BLoGR83k7/KZLkiVuJMUwPRIn27HuALQKy2dkNxSdi9TizWu1qzQ01DqWW/rJaBGGHdgdGu4C68N+yf71PT6b5iyCOjZcmtH5njmagHbvjyRLQSf+40xLEJ9QFTgUoiJw/WHa0sjK8Jm7bIgoP0t9olq6jZk72CXMydEB0SUkwxKwZpWRmTNxYyEOTVnpakEZjUg/FI8WOIKl8Xdqv8U1lbZ+hARtYjTRUGFanKfp7Re/CcE7rSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ5beVmKztSpk+5SA7Ekmo7OQUdgpB88psH46pqrzFs=;
 b=ipYbGRLmR+U6HiQ/h5R805lLh5hPSc+N3b/Ejg97FLW3edTEirZFk8Y45BuEtcI4LE9o4yhi34eZ+v7csiGkj6Vz68B9vR9WJhV+S3ufIOMlBOY7zVmdShDT1h8Cacv4T66ByOgF64IIyYNqWbhWuJ1R64OgddukejmPGayBNh9V1cqDbU31qk5iyjVI5ZjOfKdBg5PMN45lWryTSVFhhrXYY34I0bMXV3by9yfAFVX/niH1sO4RUf5DRc5Wsk1yrehwxEliyJEBSHSXtFPA2rIAoH1EEYizhnULTAa9OAlLDfavx4b4NqYwMBiD1YOeE2BSkNgdD6R6sfAPzldGxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:29:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 09:29:45 +0000
Message-ID: <d2c60dc5-b808-43f5-a31c-5ec02cff617f@siemens.com>
Date: Mon, 3 Nov 2025 10:29:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected switches to in-band
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
 <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> <87o6q1ad07.fsf@xenomai.org>
 <20251023155439.0170f987@wsk> <87a51djuor.fsf@xenomai.org>
 <20251027120535.7933c720@wsk> <20251027172505.29eecfb2@wsk>
 <875xbyawx7.fsf@xenomai.org> <20251029145125.71debaab@wsk>
 <20251030132602.2d1ccfcc@wsk> <87qzukuzy5.fsf@xenomai.org>
 <20251031165615.2c9f72f5@wsk> <87bjlnc9u5.fsf@xenomai.org>
 <5c69758f-876b-4a56-99b7-09eb22537680@siemens.com>
 <875xbvc5a3.fsf@xenomai.org> <87qzujaqlw.fsf@xenomai.org>
 <2de7f3b171d713e45a624896ea170d49066d5aeb.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2de7f3b171d713e45a624896ea170d49066d5aeb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e935e73-e19e-434f-c1b6-08de1abb8682
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0JiRXFzTVVRc0I3SFZNOUI1UzRaaGRiTyswK2plQ3h3d0JvL0N3K29iUlRK?=
 =?utf-8?B?TExoNnR4MHVtcnAxcmdyODZ0dHFSbW9yakdwYVRrTWkvQTM3UG5hVWFQSnFo?=
 =?utf-8?B?U3JteFNSQTBSK1k4TGMxZlpocW9qSGw1enRzRUxQTmhBVDZkekNtb1FaK0NC?=
 =?utf-8?B?QWRXUVZPUUkwRkV6VTVweDBoeXhZNWF2S1Z2ZHhLYTdqMlVBZ1h4YVVHcTZT?=
 =?utf-8?B?MkV5YlNBZE95aVZHS2JJbUxzaVp4dVFvSWlJNVBMeHAySUJGaWVxNTJMeFlW?=
 =?utf-8?B?TU1LTHJrT05KNm1zRXhjK2VDcnoyZytmeUdvTVB5c0J5cnNERVJkSDd4dVZJ?=
 =?utf-8?B?OGo2YVUyczlOLzBEWFpESkwyRFVLZjRWZ01CM3lGYWd5QmZPZElSaU5peWtp?=
 =?utf-8?B?RDZDaUJQdWZ6bzZvZmo5Zy9uNk1waCtIM2NzZGJmZGloSTd3bU41dm01VGUr?=
 =?utf-8?B?TGpVSGhnQXloM0d1V3NKSk9jUmVrQTJZaURZQndFOE1NVnVteDlBTHBBbUQ5?=
 =?utf-8?B?RnNXYWhDQzZXaUlOTnZPcmFyWWZuNU9mZWZOem5DMXMrWGtRNm5nV0hUaTU2?=
 =?utf-8?B?eDZsOTk5REdVWXJ1TG1IMUp6MmdxMXh0YzVDdVkrM01UM2tlUEF5TTE4Sk5H?=
 =?utf-8?B?dVBhNThNMnhkdXQxNXc1NUJuN1Y4MzVCSmc5cFgvUGZOdVNMSUsvemJ3QUdI?=
 =?utf-8?B?SmNoMlFKWW9WQ1MyWGZhR2xZWEhCczEzWTF3UEFTN1pONE8xQUFpR0ZqV2h5?=
 =?utf-8?B?MTlZNEpFY3UyWmhRSy84SXRBUGl0NlJQdENjZGRTQXlqRVo1S3FjVEUrcWdy?=
 =?utf-8?B?Wk53SkJjcWdMSFVEaEtqejdnYUpabkpIc3FTbEVtRVNWYkxlbnl3K05LY200?=
 =?utf-8?B?VHhjajZZb2VhTnlLUVpVTUlTR2sxSzE2Q29KcDVRVTVWYXhia3pIZ0FkUXpx?=
 =?utf-8?B?OE9MNzhmRUNjTWYxNlhYMXJ3OVJidHBuenFIR21ldCtQZTR0UmFkYmZ0UmRt?=
 =?utf-8?B?N21sMDltY3hVME92a1hLVkxnVExlUDROOFJmMExEd3o1dWRHMGpnSkNSb2NR?=
 =?utf-8?B?Um90NzFjczNPMEJNMU9JdjdDVkZjc2ZjK3JmMlRmTjZpUEhVUjMvaFIxbEIy?=
 =?utf-8?B?cEFsMGhLcExDcjVYWmYwYXRGV1pyUnA3YmxVcVFPeWwwZVQvQkFCcFlOU1hB?=
 =?utf-8?B?bm9XM3pQTEk5K2hxaHI4b3RrYTlqRUt4UVljUytDVHpaVzNpNWZYODZYSW95?=
 =?utf-8?B?VVMycHFUQVVBbXRaR2VWN2kzcVlHNjVSeE5sMzJTN0kvTUgrUW5sMXkxaWJ2?=
 =?utf-8?B?UVpxQVdkUHB6eDZBRWtXN3l5L2FRSkYzOGVjdXRqeUxydGcybTRUaVdjQm40?=
 =?utf-8?B?NEZETGVPM0t3eWNUYUk0N3FpT0lTQ1ozQ0lsdEkvRldqb2ZXV0poM09wWHdz?=
 =?utf-8?B?R2Y4OE5pSVZGcDR6NEQrRnRSaDN6d0YzYlo2UFI3V0NYTEJ3QmpRZ0pKa1or?=
 =?utf-8?B?bnRXdUVyamdNdG13M084Qm1KR25ZSHJ0ZWV2QkpsLzl2V0RzRFBKMTI1Rzl6?=
 =?utf-8?B?cUl5ZUlJU05jRGo2T0VQa0UxR3hyaENZR3Bya3VEY25NYnBYaHpCMnJTSGYy?=
 =?utf-8?B?UnhqLzNhb285U1JHNkZoY2dibjAxa0JOcVkvMExMM0JTTml5QjJjQWNkOE5p?=
 =?utf-8?B?NHg4QWs4WjczMS9LVGhYRit4VzdlUGVXb2JrRVVQTytVM2FLUzZhMFRWV09M?=
 =?utf-8?B?aFJpbEtkQ1UxbmF2MGc5aC9oMnZXdGpBWXZsS0ZmR0wwVW9SSFB2akVYVDVY?=
 =?utf-8?B?anAzMk8rMlZRNHU5WlNkZmxoeGJRZUdneTUvZzZURkxtOFlLNVQvNzF3anZR?=
 =?utf-8?B?bzNEZkhIRmYxbUNQTGtreVZNeVMxOWFIT0ExbWExOEpxRk9JcE5xeDFyQWNa?=
 =?utf-8?Q?AnhveAzVCFW2+LrqmYMdj+070rNc43QT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmFEVmVqZDlTNGdUS1prdnkwdWo1Q2orZXRWYVNxQUxvejYwQTd6L01xYk4w?=
 =?utf-8?B?UTc1M2lxaUxRclYweXovMGxwWU5CcTlSMVlGZ1FJNjJWbFNPZW9DaSt0eHY4?=
 =?utf-8?B?bS92NEpZcVVlL1NQQ1QrVG5xSXl0OWpMYnFSbWhkajBmMG5nRVMyN1orY01F?=
 =?utf-8?B?bDdMRFgwcWVNdlpQb3ZDRm5JM1dsSk5MZ3hkSllOL1ZlcnlLZ0NyU3EvallF?=
 =?utf-8?B?OG0ybkdkaFYzRVhqSGEwZDA1VCtrSzlaZE95NVNoeXZmdVhXaTc4TlhrMkY4?=
 =?utf-8?B?YStIYkVlU3laY1J1NnNJdDdiNHZZRGtqNERFeEQxeG90bjhHc2JxNVhyRGQ4?=
 =?utf-8?B?OTFaendKRHI1czFVTHBlUXlHUmN0ZTR4OTZqUjhsTVNXMmUyNlJPR0t1YW1D?=
 =?utf-8?B?Q0tLYjVWMGtQTTdlVXA0QzNXcDF5L0lMbDFqV3lVVWY4VmRCU0MxYTFDKzF0?=
 =?utf-8?B?OWl4T21sOFZvbk84QkV1RlhKcE5uWVV5V01xOFdvTmw5RVhxbFppekhKM21w?=
 =?utf-8?B?THZqcm1XMjhrV2c4bCtNTUxHQkNlampjUVZJUjl5c1Jxc0wyU2VIaVhGQzJy?=
 =?utf-8?B?cWc4cDRRdkxITzVMYkROSFIzcGlPS2VwZEZrTlpJb0dPbDZackc2RytHdXJH?=
 =?utf-8?B?bHFYK1BUVzN0TjVScHM0TDI5UGdrUjFPMXRvMlRUMGVqV3ZSZGFyVkVXMmZ5?=
 =?utf-8?B?Y2UwbXAvZ2VUdmxoYm5wVlFiOHlZQlhjWmhrd3lhcWt4SjRDayt2WDBxVjBk?=
 =?utf-8?B?bi9jci85NDAycEo1dDVNd2dzSXNNZUJCTXpmOFFiM1NIWndpSXdEYkN3MFU0?=
 =?utf-8?B?TDJNayt5TTEzSXVjemMweGV4N3pXVjFuM3g2N0NXU2tGZTBLRHZqWW41NEVt?=
 =?utf-8?B?MUJnLzhlOEpaNzJSUkxwb05wbTY3Y1Q4a09JU0o5SDFnY3JBZTI2cVhmSGpC?=
 =?utf-8?B?Y0Q1T3N4M0VYVHVFcUxsUk9UQTJQNDdJYkZVVWpDcXo3L05NY0NhVi9pQWV5?=
 =?utf-8?B?Z3ZyQkZCemRNWVhQd2xERlFDUHJuK0duZC9RdXBTODNMT3ZHY1FGTHg1eXU5?=
 =?utf-8?B?OEs2NmVaVUErbWxjRVZtMTUrMjRxMFE1UXEvY1FCYUV0bFlscXRSUUVpaVIw?=
 =?utf-8?B?dU55Unh0UkVuWk5DejRnQVVUY1pYUFZJdzZnUlNaN2psWHVwK1lYbVphYmZ6?=
 =?utf-8?B?NklnVzJZaVFvY0U2cXRnM3gvRGpIOUpYMXpUbUZwMUthWkRVSUlzOVZGUWhX?=
 =?utf-8?B?NENZNDZBWGFIeTZMZ28wQXRMdUR6Q1lnazhuUENRTnhpclAzYjlVSWpPVWx6?=
 =?utf-8?B?ZWhmdEM2L3VBWXRHaEVFcEo2YUhWcHkwU0FFY0ZoQTlvVUE3eUo0dWlORTNL?=
 =?utf-8?B?VGhVbUlVWG10TzBLbFpZSW1TbGw2b1VGUnJWdzhJS3BlWHBJS21PUGhQYTlB?=
 =?utf-8?B?Y05CRHAxMCtQVy9EOEpIVzNJSFZNNVZCcWh0L3dRa05IYkdSaHVqZ0FkbEJD?=
 =?utf-8?B?NEpUczVGbkZ4eUhIYmM5Q1BvSWwxd3oxT3BvK0xCM2k1dHFoTlRadzBCb2ZF?=
 =?utf-8?B?OHBjOWxrNno5S0JzQUJlTTBXUWx2c083VG90MDVIRmJtNmJYb1ZvUVBqWjZQ?=
 =?utf-8?B?VnBTT0lpcC84S0dYZVB1bUl3ZE5mZlNFRi9NNjNrb1pPc2ZQdXJBYlpIREVY?=
 =?utf-8?B?Y2Y4a1U5eDRwQ3BtS2dZdnpFaHorMjRjd3J1VmlGSWVVU0pjUWZ5NGZ0SG5B?=
 =?utf-8?B?TW1FZUJTZVVvcktlTFFMTG9uZk5VK053aVlCNG1oRUxScmZuaUZyQlJOSWJE?=
 =?utf-8?B?SzBmeXRHdyt4VzJKbFBETmY0NGRISjdCeXNEeXRrVmZXZnVrOHk0ekNCT0RP?=
 =?utf-8?B?MjEyeFNvcXdMRGF4Z3pmSytZeDc3dG9iNFRUb0UxRWVGOWhzMHE3TXdRUGZV?=
 =?utf-8?B?YWNGci9mbkw4WFcyNTVmYWJyQ2l6OFBXQmIyQXBSdzIyemwwcUd2MU5xczBo?=
 =?utf-8?B?aGpvclliR3FMeEFjV0JWUzBTajNqckViSTIrMmlmZjU3dGM5SHJMWnJ1dHJy?=
 =?utf-8?B?LzliUHVDOHBiVmlJdTc3aTRNRWtueDlZVnYzUWdRMDNyNDBGVmdCREVxZ3N0?=
 =?utf-8?B?NzVBRGhRYmpYTDM4c0dyU3k0YWNPV3ZiUE56VG4rMFkyelloZ0dKM0pza1Iz?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e935e73-e19e-434f-c1b6-08de1abb8682
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:29:45.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfCMJTm9Luj2XTsY0Af0Fdrp/Mj0EuQBxSex3Jr23NK79n20wuPk1tNDDCbJ8foAQ4EWKfenWy+ysG35wPVYGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3208

On 03.11.25 08:57, Florian Bezdeka wrote:
> On Fri, 2025-10-31 at 19:11 +0100, Philippe Gerum wrote:
> 
> [snip]
> 
>>>>
>>>>> Thanks. I need to analyze the fault flags next week to see if I can make
>>>>> something of these, but I just stumbled on an obviously significant fact
>>>>> when looking at the multi-CPU view: the memory compaction daemon is
>>>>> running asynchronously on other cores while the responder is taking the
>>>>> fault. Compaction is all about moving memory around to free larger
>>>>> physical regions, so updating PTEs will happen as a result.
>>>>>
>>>>> Moreover, I could not reproduce the issue at hand, but I did not have
>>>>> CONFIG_COMPACTION enabled. In the meantime, could you try disabling this
>>>>> on your end, to see if the fault still appears?
>>>>
>>>> CONFIG_COMPACTION selects CONFIG_MIGRATION, and that is well-known to be
>>>> incompatible with RT. Xenomai 3 is warning about that that, EVL does not?
>>>>
>>>
>>> Dovetail should do that when CONFIG_DOVETAIL is set, this is by
>>> definition common to any rt core.
>>
>> Also, it would be much better to find a way to exclude any mm bearing
>> the MMF_DOVETAIL flag from the movable set, instead of excluding
>> everything that sets CONFIG_COMPACTION.
> 
> Are there any concrete ideas already? Asking because I'm expecting this
> topic to appear on my radar soon, again. Some colleagues were fighting
> with the opposite direction in the past: CONFIG_COMPACTION being
> disabled. That caused some trouble with a memory intense application
> running next to the RT workload. The OOM killer was invoked quite
> regularly.

I even heard that this could be a topic in the PREEMPT-RT context, thus
for upstream. Maybe worth to look left and right first before starting
own work.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
