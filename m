Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4ADBA21
	for <xenomai@lists.linux.dev>; Thu, 12 Feb 2026 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922235; cv=fail; b=bwbuqhc97PkbeDlruh7sDRB1rSfEszhM+cBNSicqDVW5QS+9U9oKorQ6OMHSdxrNi0gaMdNdxzQ1O7/wmV5xhXLwVg7+16ivEbxFWGNmchs0bTyzKqd31/qphtmaNk7r5UWWdSuNlHsags/CEek7oHe4O4b3gOyq0RC/ioxb98g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922235; c=relaxed/simple;
	bh=TYii9G8PQBUOHa7VwLRPNJvud4k7RTC/QX6av4J/fOE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IUgszVez8chon9T3fpw/Esg7+X2uR7Zwm1NTjJVIzsifuOv99n2o10X8R0qt6MqqVWqb3Wd3gZtEv//pBcfozv699eHZAAMMXFxidGJ8GTBQVGcnd87KfYAkKOwj8Vfa9h8lijSEdv95PFIPSu1tkxwU5+rubmUiyI/Bmqm+hgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=a/pgX4JN; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="a/pgX4JN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWrnKWzeDdNKAjrKT0KbuRQKBZVu8B4PliNGqwht73XbUrxBZsjgBPGaUVLJ9b0dEDqMiyavD2BE5xDossJT9KNRH7/PEzTmeEPJFrqhyukiKZueWiEjWkKIPTlI4dN3GizrlyXhKIYoPGUfiJxY6Ix57SeZ7lQtTimp+yyPOML23wfKAh74/CkVPbg+RMhGpX7Aul25V9Z1xPPfPH9AI4jriz9S/0brKVZaoHfXAz7Qc5V4w+eCbZB8IJ+Cor1XXAGZ7Omu9onMVe+9QYrLGTCnlB6isfbYwfKhRSK6ntsSf0AO9yYJmn08YpeqzZfpWO2BZnLzg/W2+QlUC9BDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJx6rkC6H/qr2UEGshJaHLP+/d7LZfUH2J8ThCBIO4g=;
 b=OefgV6l3SqC0JvWuLpkcX+KrXzaBDubStdS/GCMgc1mHiRRvzGuo5oUZR/mRguhn391tUFDZiw4BoggjT8Fnxg4b+BlbzI81XKXV+QzmozqiJDqkC22A7w/k5+uqV+vc5LdkvaxnQdwMJfH3JABd1K84XyCGjrP8hU+PR0i08RSxC/QT6HaDKl5hdqHGFwWKR3x7TiQqzYmWDxf4mVtB7sC91OkTlvXsDAel0aClRJD16PzeAWoSwcvFiiRsD/YfRnfUkJhX1BRm3ML7yyD/9aEfjcUf4zlKpbSjKN0j7RbE5BQvaC5Pjq1KWlRVujR9yMPRoDBUmneMonfJ3iTkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJx6rkC6H/qr2UEGshJaHLP+/d7LZfUH2J8ThCBIO4g=;
 b=a/pgX4JNeTADLEOE4jAXVhHOHN5DrlLCiTbwlw1pw8VWGPqFbWidtaRBHLQm8GD1Q5ZZ4HZ17uggARPwP3ke/bG3MkW86C5sXHVJ/CAcCvcAej67QNaEorQOC/e75i6KaCmBQqIA10Pzr1lMz4TXMmCdjSsGjFBDV+tItWScOv4HIqHij0CPQlscbQqLYCdfG+jmx9P1CR54Oz+DmPl6cv0tv5WMF5BjtzfhPUMUfxAmyn1kSRd+1BpnWZkCsyzSj65gFfsLwokgbLBKiuF6CUJMivSnZ0ieoaX+UyDKyJUnseF2/wNwFfS3XFYzC+jclPlOhnWg/gztF//1ITwyDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 18:50:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 18:50:30 +0000
Message-ID: <8927677b-0efd-447f-862f-7cf296f4adc0@siemens.com>
Date: Thu, 12 Feb 2026 19:50:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 0/5] Trigger xenomai-images CI for
 linux-evl and libevl
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d53b9e5-a323-4cb8-809c-08de6a679853
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXk2Q1VWOXp4U2p1YjFRUklmS0hHeTRqc0xUWHVmK3NMc2pjRlJnT21uR1lt?=
 =?utf-8?B?Q3BpaDB0ZDFBV21VekZqMENJbmtuY1lFN1lFUDg3TU5uUER1dVUvbW9pTjBL?=
 =?utf-8?B?U081K1dDQjBDanAyUnFxeWhhQjNOQnhQaFlZT25WK3NEWnBxQ2RZM09rOEMx?=
 =?utf-8?B?UlJoQ0J4VFRRZWsrVGRYT3FQZHZmbW9icWoxbmc3ZCtNSDhYNXF2d2Z1U2Yr?=
 =?utf-8?B?Mk1YWXpzWk9KREhQZGhMU3VHODAxbEdFSERMSUU1T21yTHhzeWpoVkx0aUVF?=
 =?utf-8?B?K3VEWVJZb3VPeEltSGZmU2s3eEFUWmZLcFpTYWVQSEt3MTRlRC8yT2VUNzBV?=
 =?utf-8?B?MXVCY2I2dlFlZEFibTN6RWF5YXZLYlhKVStNYjBteVJ6cVpudS9oemFWR2JT?=
 =?utf-8?B?MDZObEJOOWprTkxoRkV5RHFpRGhZK25rQWJPNHdqbThueWhOdHVZcVk4Rzh5?=
 =?utf-8?B?K0x1TGV2VWNNU2lCQlhoNkgzUGVZQzcyYUJEMHdNZU9PU2lGbWl1NzFoOStD?=
 =?utf-8?B?TE9pbW1EY2xqL01Hai9oRFFrY2NCdDdGWU5uTkVQYktRZVBCak5CMmJpOEdB?=
 =?utf-8?B?TkV0K0l5eHd4YjBQWGxjckNieG5mRjRJbEhadFFOSDV3VGFRcnowazQvUUt4?=
 =?utf-8?B?ZWlidFcyRWljZjJwRWNzUDVSbVVOZCsyRWdWcS9zOHg3S1hmZVo4SnhKRGNL?=
 =?utf-8?B?cTNCM1pCTlhqT0dYNFF3cHlER1NTMmRnQkdkd29IakZid1lyaDUxNVE1dUpF?=
 =?utf-8?B?QlBBMW5hWUFlWVhGTzZ3V0hIY2tuRVNYdE1NQW9iZU1pMHBWRTM4cG51Rkdl?=
 =?utf-8?B?RlV2bVc4b0J3SXJ3Y2QzM0hMTUVtUDI2ZFFtb2JqWXhGZTV3WDhOd2lTREMv?=
 =?utf-8?B?Zk5NSGFTazBJUldhL205ZXJScTN2Wk54NGpIck15ekZzV2xLOXhZTWRDeFU3?=
 =?utf-8?B?ZWNpVTZaN3kzQnUzQTA1WVgzaDRiQzJsWGdIY0hSUjJKYVVmWHd4Y2RyQWJN?=
 =?utf-8?B?eUNsNlp5ZU9zZ01LMXFZSVdGNkNsVDk3bkszblZuR0lQWFR5OWFYUzN6KzB6?=
 =?utf-8?B?bGhLcXlNMmNtVDZMTTBhMUhvMjhuYzh0blZnM1I5VGVPdjZOcGV0S2NYb01v?=
 =?utf-8?B?NWowTU9QaUdCU053WTltV2lGV1o1bDl4eTU4elF4M3RITlhQNktibFZQUlIy?=
 =?utf-8?B?SU1pa3RlNGdLYnllSXk0QzZnVVBNbFdxWGNMbTNiK1lyWWtBT3phYTVtbUlQ?=
 =?utf-8?B?dDdGZ3cxT2NtSmFSUUxpYmc3cDJiTXdOQ01jVy9MY0JMNDF6YkxKRS82YlFp?=
 =?utf-8?B?UEUvNW9pV2NYN0t5V2hTK0Jvd1E5SHFFYTFDZmxnSDQxVjBPRXRvQ1U5Zktt?=
 =?utf-8?B?MnVjWTRNZmUxZjZ6eWVnSG1iSGpoTnc5VWM1bnlYSWJBODkwR1lWRTVYL25G?=
 =?utf-8?B?TkxYa1F2cnJrYXBhaGU0YnliNERkdEtpQVdzaTluN1F2azJVVml1M1ptZ3JE?=
 =?utf-8?B?KzBWYmszOW9FcnBEZEhXazVYaUNDK2NOMVUzVkt1U09NKzZyeXJFbFNaUlRX?=
 =?utf-8?B?ZENpcnRBR2R0SDhLVEFicFlLeDJiS09XV0NlWXRCYkpXWEp6TjFpdzlzaG9G?=
 =?utf-8?B?dXhVWU1teC9EL0lPSlFQOWVrM2FWZ01xL1JVM2txbUcyU01VdlV2U2NiMDZq?=
 =?utf-8?B?NktoVkxmRHY0QXFaemhmUmtoOC9keWV1YkhmSFhVRFVKQklvWE9mdk5xRVVN?=
 =?utf-8?B?Rzd3MnI1NnNUTlR0eDdUOE5QVk1qYy9wb1ZxLzh1T1NBZ05Ed0pjQ1JIU0s1?=
 =?utf-8?B?a2xwVnY1enRDdlBPZTlLY3EzUUlWblN0TThZR1p1Z25UcE43U1ZqWUpURWJ1?=
 =?utf-8?B?RnJ2dFNnUkVwemhrT21DR3pqYVVvQ25hMFJEMGFKQ2pmUDdKWnl4YjZpajJY?=
 =?utf-8?B?M1h6Q1RDNHN0MWNwWVpnTHlYOGsrWmdIbi9JZjUxRWpTV3R0dWhEdUMxcTMr?=
 =?utf-8?B?WHVIbnNISUtsSUdTcHVzLzgyL0JJbmZaODZIdTVYbFBicFdnOFRVQ0JPd2Jw?=
 =?utf-8?B?ZVdKYmcyTW4xYVA0OFlnUHU3OWVjQ3JZdHpxMXJJWDNaRFRpQVZyY1ViTmlj?=
 =?utf-8?Q?/w7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWNCSHdMb2xQMXB6Nkpic2pUYkRHS0ZaRjExT3MzWjNZdk1NZ1ZYTTNLUzVN?=
 =?utf-8?B?a1RlM1B4L1B6Yk9MYnZKdzhPdmNDUzUySkRCSEM5S3lNdHN1RTFxVVJqMGVi?=
 =?utf-8?B?N1RhOGRreTE0cHVPSFJzTVVUUUFMamwyemNOK3ZPWVdHMUh1NVlPSHFNTVV2?=
 =?utf-8?B?N2xUNnhmSzVMbzRkT0lPbG5mdVovanprbElPZlBYRTcxNVFycjVmNjRQSVll?=
 =?utf-8?B?NWhRYjM5eEtUZ1ZMb2xXZXgvT3Y2VXV5aFdYdFR0OENTT0VXNXVpbXgxYXYy?=
 =?utf-8?B?Q0Z1VTd0dmpDU29EWU5jaXV6NWptNEJueUFwNWpXVWs1ZVFqU1VCTWVaQ2ww?=
 =?utf-8?B?WjcxWklKN1pBekdBT1RXMVFqTHRiRWgwd1F6QUYzb2ZtV3R0eGRISS9iMGp3?=
 =?utf-8?B?OGU4YVNjQkE2d1MrdWRvc1NMOVFjb2JmT0NzUDR6OGk2Q0RGTFJ2KzlMT080?=
 =?utf-8?B?SHVnUktMTWNnTWlZMWpJTllEKzVrVjAvaVU5VG14bVhsRDlmWU45UjR4U3hI?=
 =?utf-8?B?ellMNWZ6ZmpmZGpKYXQxTG5TZlVCc21tV2lUNm9ySDhTbDA1TjFRZkxGbXRr?=
 =?utf-8?B?VGNGdWM2TTNMUTlNalE3cVhBRVJCUjFZQzFTa2lNMUk2SEtzQWlJanA4V243?=
 =?utf-8?B?dXE5TzIyY2dzNnd6VzVKRC91UE9SdGZxMnVJc2s1R3lTZlM0em5hUTZsdnY1?=
 =?utf-8?B?MkdjWFh4QkJKak1EOStvM1JRUDFnenBzNVlhTXprMXJTQXdrc3crMXIycEcv?=
 =?utf-8?B?RWxZVFlzVkxMUEpsb1QrTHBXS21tNFZPLzkyMUV1QkRPZnZqeEJPS2Y5TDFk?=
 =?utf-8?B?SEsxZEFIMXUwcUw1d1orTXZmaWF3cG1DK3MvUFFVVzFLYlNwaDgySlZKcFQx?=
 =?utf-8?B?SGxHRkE2OENNRmNyUHlJbW5zWk95c1F3N0xSRUdOUUc0UzhqQkhvZFczM3l6?=
 =?utf-8?B?UFlrYWhtVXk3cXdpMDRQREVmWHFDbWg2UDFYMWlqMDc2b2Y2bCtWQjFRbHVq?=
 =?utf-8?B?UFlaUVcrREp1OVpmWHAvMmoxL1YySnRPUEFpc1l5ZGNxQVRONnh3aG9Cd3BN?=
 =?utf-8?B?RWZoOXMxQjJUbzJRNzllSGFLaE13QVBXbURWS1YvOWdsNENUekcwUWtlZS9Q?=
 =?utf-8?B?Y1ZFNGxWQ0M2SnpwVGhUMWhWVkFSUzRReEoycGhMb2NYS3phSUNrVTdpMUdN?=
 =?utf-8?B?b2ppWFZHRStKTHpjdFFzU200Qm9nbEZJV0w0aVpqSHl1cWtGenNJcXpTUGV6?=
 =?utf-8?B?SmxQcmRpR0VrZk1JSDNnVVF1dWpEdmtCbngvbEo0U3lERWxmdlhsRU83ZHVS?=
 =?utf-8?B?dDByM3BtdTJGWkM2WFFwQ2lGVHpiQWh0dzljWlhWUVJQS3A2d2VoWXdRUzAy?=
 =?utf-8?B?QVFKaDBoUU5DWjl6UVpnekd5RUdoc01SbWhHcVVFY3dyM2pPck5hL2ZIMDVR?=
 =?utf-8?B?QnNCT21kSXUxZUpJYmhvbWE0OTN0T1UwaWI3SEV1dm9hVnpwRWtPbFZ2bEpN?=
 =?utf-8?B?Y2dYQWJLVjgxQlRmU3NCcFpqWThSRGJVN0xWSm1WcWUwVkJIeU9vS2xiWURN?=
 =?utf-8?B?Yzh5bkFCN01GaTg3aTAyLzdIcU1uaW5EOVRKelpFVDJ5MmFtdTU4eVRaT1cy?=
 =?utf-8?B?NUhhVzU2UFpPRXBTeWQ3K083RWtFZWExVjBkcGtkeVdEUEpMbmVFckY2Sk9S?=
 =?utf-8?B?WnZWR1YxNWhKQjVpd3VET3gyRURhYitrSnBocXRTc0ZSYllwZUhrNlNkUjNE?=
 =?utf-8?B?SHB1c1FXYnNtdFVTYVJaKzg2R2h3azBvSEVRNHBlNVpHSHJ2SERBMmN6VWh6?=
 =?utf-8?B?bmViTUlzYndHN2I3TnRSY0ZiTmpNN2ZZY2tWKzJDRWpoSmt4bEhLUkordHdY?=
 =?utf-8?B?UlZZWTgxR1NaQU1scVFtQlRYM1hpZFg1WVdWNEVvejlsaWdnR0xlcmNSaGRJ?=
 =?utf-8?B?ZldxYkdqTzkybndUdk5kQmZmK05iN1JvRTdzbjZtUStUVmNCN1FjbXR3SURY?=
 =?utf-8?B?OEhmWk5FZThxQnlERHRzcW1jQllmdEd4QUdBWjVOWEdNSkgvMnJ6cFoyVGhV?=
 =?utf-8?B?L1lwSUlDQXVxUVN0RlVscXVuMkZPTVEwRmtZUjh3TE9GV2IvRlJJMDBScDJp?=
 =?utf-8?B?amNFcFJBSW4vcHFBTGdTMkx4emlTTW5aZnplQVoxM2tjVTBOck10dGdvQkxQ?=
 =?utf-8?B?b3YzVVRaRTVqRXBaVE9VN3VVTWRvckpEdE9xVUNRMEx2SmRaSWtZS1RtVEow?=
 =?utf-8?B?dmlTbFNNdncxL3ErcVFaM3JZUUQ0RlBQR0lTaW5aelh1ejZMUnRPNTBXZkJv?=
 =?utf-8?B?VWx0UzM2UnNTTk95dHE1RkFwb21oZ3dsS0xhRy8vV1gzb1VvdEdsUmtzTUNJ?=
 =?utf-8?Q?PsAJ6AONusJHHC6w=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d53b9e5-a323-4cb8-809c-08de6a679853
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:50:30.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPCVv5I+7bAKcVdlE8bhNMRTo2NuoFQAP4zUAZ46dbK+9bA/Yli0m3xHi6wGuiwFELwzBV12KfSzo83jnrGwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3189

On 11.02.26 14:10, Clara Kowalsky wrote:
> This brings support for triggering the xenomai-images CI for pushes to:
> - linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl
>   next
> - libevl branch: next, in combination with linux-evl head
> 
> Changes since v1:
> - Do not consider pushes in linux-dovetail or linux-evl to retired or
>   yet unsupported branches that match the regex rule of the head
>   branch. Pushes to such branches will cause the downstream pipeline in
>   xenomai-images to fail with the error "Jobs config should contain at
>   least one visible job".
> - Restructure the ci folder for better overview
> 
> Best regards,
> Clara Kowalsky
> 
> Clara Kowalsky (5):
>   ci: Move third-party config files into separate folder
>   ci: Move reused files into lib folder
>   ci: Add build job for pipeline triggered by libevl or linux-evl
>   ci: Add CI for libevl
>   ci: Add CI for linux-evl
> 
>  .gitlab-ci.yml                                | 10 ++-
>  README.md                                     | 31 +++++++--
>  ci/{compat_jobs.yml => lib/compat/jobs.yml}   |  0
>  .../compat/xenomai_3_2_x.yml}                 |  2 +-
>  .../compat/xenomai_3_3_x.yml}                 |  2 +-
>  .../compat/xenomai_3_next.yml}                |  2 +-
>  .../dovetail/xenomai_3_3_x.yml}               |  0
>  .../dovetail/xenomai_3_next.yml}              |  0
>  ci/{ => lib}/gitlab-ci-base.yml               |  0
>  ci/{kernel_4_19.yml => lib/kernel/4_19.yml}   |  0
>  ci/{kernel_5_10.yml => lib/kernel/5_10.yml}   |  0
>  ci/{kernel_5_15.yml => lib/kernel/5_15.yml}   |  0
>  ci/{kernel_6_1.yml => lib/kernel/6_1.yml}     |  0
>  ci/{kernel_6_12.yml => lib/kernel/6_12.yml}   |  2 +-
>  .../kernel/6_12_physical.yml}                 |  0
>  ci/{kernel_head.yml => lib/kernel/head.yml}   |  0
>  ci/{ci-dovetail.yml => trigger/dovetail.yml}  |  0
>  ci/trigger/evl.yml                            | 63 +++++++++++++++++++
>  ci/trigger/libevl.yml                         | 28 +++++++++
>  ci/xenomai_3_1_x.yml                          |  4 +-
>  ci/xenomai_3_2_x.yml                          | 12 ++--
>  ci/xenomai_3_3_x.yml                          | 12 ++--
>  ...l_xenomai_3.yml => xenomai_3_dovetail.yml} | 16 ++---
>  ci/xenomai_3_next.yml                         | 10 +--
>  ci/xenomai_3_next_long_term.yml               |  4 +-
>  ci/xenomai_4_evl.yml                          | 29 +++++++++
>  ci/xenomai_4_next.yml                         |  6 +-
>  27 files changed, 191 insertions(+), 42 deletions(-)
>  rename ci/{compat_jobs.yml => lib/compat/jobs.yml} (100%)
>  rename ci/{xenomai_3_2_x_compat.yml => lib/compat/xenomai_3_2_x.yml} (90%)
>  rename ci/{xenomai_3_3_x_compat.yml => lib/compat/xenomai_3_3_x.yml} (89%)
>  rename ci/{xenomai_3_next_compat.yml => lib/compat/xenomai_3_next.yml} (90%)
>  rename ci/{dovetail_xenomai_3_3_x.yml => lib/dovetail/xenomai_3_3_x.yml} (100%)
>  rename ci/{dovetail_xenomai_3_next.yml => lib/dovetail/xenomai_3_next.yml} (100%)
>  rename ci/{ => lib}/gitlab-ci-base.yml (100%)
>  rename ci/{kernel_4_19.yml => lib/kernel/4_19.yml} (100%)
>  rename ci/{kernel_5_10.yml => lib/kernel/5_10.yml} (100%)
>  rename ci/{kernel_5_15.yml => lib/kernel/5_15.yml} (100%)
>  rename ci/{kernel_6_1.yml => lib/kernel/6_1.yml} (100%)
>  rename ci/{kernel_6_12.yml => lib/kernel/6_12.yml} (96%)
>  rename ci/{kernel_6_12_physical.yml => lib/kernel/6_12_physical.yml} (100%)
>  rename ci/{kernel_head.yml => lib/kernel/head.yml} (100%)
>  rename ci/{ci-dovetail.yml => trigger/dovetail.yml} (100%)
>  create mode 100644 ci/trigger/evl.yml
>  create mode 100644 ci/trigger/libevl.yml
>  rename ci/{dovetail_xenomai_3.yml => xenomai_3_dovetail.yml} (67%)
>  create mode 100644 ci/xenomai_4_evl.yml
> 

Thanks, structure looks nicely consistent to me, and better sorted now.
Applied, let's see if there were no typos while shuffling things around.
;) I'll also update / create the triggers now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
