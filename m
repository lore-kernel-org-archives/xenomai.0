Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569971990C1
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930380; cv=fail; b=iEckkIGTUmwgUwPlHaOatFmbVq6dK2Sc8csQgE0g0EeVmHWK8U2F2ODeWTlLpWXwCEG8YSQ0+h40bu851E7mqHUXkmObaWPOcBAPmTWAj3odv+EoLZGUcFlVf2dNowNOkjIBy9ccnTi+JXjwqyoykcKZv3EVhQLkWciwk09YGOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930380; c=relaxed/simple;
	bh=yc2pMumcGgOdUXoyEp299IKpWnrWgGVgeuPiavasd4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDIwttSz2tRd5j1dlaFuGfOtpxD7QegcrBc0jz9c+wI/ghc2re8BGYRLlnNUEY3GaQYypxj7NWqk7ZSE3NbzJQBVniPeOVLkzdarINYt9tbOn9MZNW2DZJYE59WjCmosUlxe+wkvMTc3jhKYMDuFRROq15f3tLiCCXxkPjWeNLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j26MtHry; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j26MtHry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqJU0kWcNA5zOUN/r7loxAjwVvS+dDoeg0NR+ghhNU1kYyaNeJ6XZeO8e4MFsF3EERCgBIKCu096WX21zqE2d8O2FTtMtDxScMyQsKmEljw9+MlPl81CLrpo+lzQFGmbOkpkG5S1t78ACZRmXMfYXjL6EVb6Xspc/q8IQOT6F3/SsaQktLyQnw0pEKx+YabJiv40Ueu6Y+6kqLlIy/obI7y3BbjjE6Aa3fTQUOcPRjGF6mrOhk0IEafx4mcsKOfsFp3JFHGQjFC8wq3IPNRWMotxacWHNFbDjtM1H+9gEz1Iwb4M+Q6jvW0yvwkkoioRohKA3AmKfzrotB0yOKKMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1KsxWA0EmLob/Hcbj3sAKwgfJ+0cl7+OCFVFt2SonI=;
 b=dke+fpBvhV4Mff4zmvEHetZzCEPzjJ56IaNIN0yr0sxFtyHEtabc6s1p7C/hiMC6RrDOweq+l5pOVZLg5OCCT4tuFyei9m2RXEqSewEvIOG1VmKuJyJT8M/NqWR3baRoDCi8XuHh3glbQCIbTV6JDghRV+0gYqZ1Cw8F5UwQ5pqftW6eiYEKO5FCYfQkbD3LORZy0yv49neoUGGDavpqMeizLTO8BrjxjNFpgffh9VzY4yU1d9iRrJpJx0RqRYqK6g7gYK3dpgZmqgdsD+QMlZTxgMuyipcKXEEG4acHdk/r/vr5R5f4NmuCed3AFdiaOlcqDcblFGUJRGIk//ga1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1KsxWA0EmLob/Hcbj3sAKwgfJ+0cl7+OCFVFt2SonI=;
 b=j26MtHryUk1I9BU3LkFIEH+hT7TtisDDuvZYdHZq4XGveB0qVaR4BR81ioZ3kqQ6uDWGAvtVixCe1d1A/0TbKGmn/9/lvArVEwQRnfmU3zd8A8kpCRjja1EKeyrZ0ANgtRkyxU0rV3jOf9aUg852rxC/bqguVJRcSWk8cda9dm9x6eBTDh7zfunUlWWEz1vnshwpdA4Nxw3LacDtmaAsKKVi21hlWYmOKQ3A2sKUkIaOQweFVmlWmgDYFDyxqDCLlqyHq5Xw3WF8bpCTsnyM64wXSpC4nC9Jm5yy3ECvgpXiWMtbgKmTfoeLMSY5Nd48d7/Y1YD219r05TI6CamBHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 11:46:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 11:46:13 +0000
Message-ID: <3f64437b-6914-4d41-a98a-d10f09ca16c0@siemens.com>
Date: Mon, 18 Nov 2024 12:46:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] libevl: Add build dependencies for r50
 and above
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>
References: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com>
 <91f3bdfa29efa0929ede19ec9e2464151f7e5f7e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <91f3bdfa29efa0929ede19ec9e2464151f7e5f7e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 6680ddad-aaa6-4220-be51-08dd07c69a50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlpTcnIvUUltZ21nV2ZHVmVkNjM1OWFxdi83cDkyU0o5Z3pIV0tzcERFci8w?=
 =?utf-8?B?SU9mYU9xNDRYaSt0dTNvd1NWNzBoeStGanJkNVRnVCtGZ25vVVpLUi9iVXJ6?=
 =?utf-8?B?NGhTMkRxczZBdS9mRHJIenkrY2w5Ujlyb0lWMnVXaHREamhnWCtFcHJTTGhZ?=
 =?utf-8?B?b0VoeC9IU05PTUVMVlZaUVZPblRLL01WTHZ0dTlacEkrQTlmdmR3TDYzaFhF?=
 =?utf-8?B?dTZyZEdITkdMM0hpbXBiOSs1dUNobjQ3UDhPTjMycXU0SzM5Q2h2aEt3cWNL?=
 =?utf-8?B?RUk3Ulpwd0RHdE53cTBKZEY0UjdqS0JvZTNBcWw4c3RqWmpCa2daUFZmSGpG?=
 =?utf-8?B?d2N3NC9BTjN0Z01TUjNhMk9tUFNzamtGTjRZa21mL293QXFoNUFIdzRvRG1H?=
 =?utf-8?B?Wm05YVBOQ2hTZUlVWk9hYXo0Z1duMVBGQktBbWtsMDRKcjVDb3dpb1RlRDV4?=
 =?utf-8?B?Rlk4SHFVZkxGN3AvaExFT2Z3ZXlsRnJ4SUdJQ1p4MDh6UnJYcjVVSi9YbUUv?=
 =?utf-8?B?cStvelc5ck41aldKUWxUTWQ1bElRZ1doazBESStacWY4VnpkR2xTZjRyUlhh?=
 =?utf-8?B?enAzOGlSdUdHdnI2QXhLQnp0SDJQR0Z2RUkzVUsvdkJma2pFY3ZYT2cvTjc4?=
 =?utf-8?B?emNOeXRzQmV3T05qTHNkNFIyamNweGFUVHFIMk9leXZncU1RTFYyMks1Q0pW?=
 =?utf-8?B?dXlBOSt3SVZKSGdtUDFsRCtyTy83cE1zUDJjNkRsS0dyRW9NbHQwSHBoMUUz?=
 =?utf-8?B?aFJPSERpMmdXbVF3ZVR3L1gzUWQxOEpDUkVRNlpEcWlLK05mZnlSaGJtZ2F3?=
 =?utf-8?B?UGN4NFdNWTJoNDZ3MXIvU0I3YldsRVVJRkJYNW9RaE44bXJHdk45TkhNcHda?=
 =?utf-8?B?Wlc0U2xaald1clowU2xMSHUveFR6Z1hGNUt0VWo5M0VLR0s0NWRRTXR5ZTk0?=
 =?utf-8?B?OU85cjJxR3E0NjhmNVdaMUFMbkxJanF3QlpOSFhvU1NyUGRKeERaOVNCZ3Ny?=
 =?utf-8?B?cUs5QU1RM2FUQTZpV2lmOFlxWjhkc3NjL0RWRUV6ZUlmaXV2VGtLMFNWNUdI?=
 =?utf-8?B?dFFmdUtQVmhqdjJjV0JIZnlwb0c5NHh1ZWN2SHZ6ekNPSHdONGhtMHozUDFB?=
 =?utf-8?B?czBjaGJTMXFSYmpQcTdxU1FWYUVZWUJnSTlIRjBoUWlOSkJyVytHaStMQW9N?=
 =?utf-8?B?RUhYeU0rVjNMbldMT2tsbGVzd0hWdXRxUFhma01XR2g2N3FPbDJmSHMzVGUz?=
 =?utf-8?B?djQ1R0xsSzc3Tk14QTNseUQ2VEUvaFlWeTVkZEJweVIzQk9uZEptSkpoMXN0?=
 =?utf-8?B?VENFODVHdUJJc3NHcVhRQ2U2RHdmaS8yY1N0MTcwaDFRbmxoNGhSLzg0bWxQ?=
 =?utf-8?B?dDFsbXQzM0pKN01ZYUI2a0JJMytGMlVEbU1EMzJKZ1V4YUdzU0hqUlp3MS9I?=
 =?utf-8?B?cEJhSGNJQkhaV1lMSVVPQ1N0TnNGZmZZcVliaXcxTGFScW0vOGlTNzJHNStW?=
 =?utf-8?B?OU50WFY3U2IzanIwUXNicCtKY2ROeUhpSXJuNXlvNFg5cVgwZXdjbm53RTVI?=
 =?utf-8?B?MXNZUGt4WGJ2TW8vYlJ5OFpuaWs0czJZSW80clhKUWN1L29kL2xLay95OE9I?=
 =?utf-8?B?ZUNsbGpLUTRkRElyL0xlb3dqU0VsZmVLUklSK2RCeitPdG1XZXNhSS84S1pL?=
 =?utf-8?B?WWRYSGZNY09TVTMwdHdNU1Viazdndmh1dlhCWnhqczd0b2hBWThRY0pSZjBj?=
 =?utf-8?Q?3C9ZxqZ22kotbGeYEjVkbbWOsQZRHMuEWFxCR9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckR5V0dlbzZmcHpsQkdMbHoyejhwR0d4aFJiaFNxaEdQR1dKTkhCcDBtU2Rh?=
 =?utf-8?B?VHNkY1lWdGszNWlZclcyazRZQnA4b0gvSzc4TWtaLzJ4cjR3SkpGeHNBODNJ?=
 =?utf-8?B?aEZxZk9PTXhNN0llQVpYYUF1Q3E1elB6NkdkaEpReTdlQWc0RnpEMmZNUjc2?=
 =?utf-8?B?U3JRbTVjYmcyY1Bpb3Y4a1ZIZmNiTldJWWdOd2VHV1pMTHc1WDBIYTVkNVFo?=
 =?utf-8?B?ZjdmT0Y4cEtqNTQvejNYZndwMkRhTUJYTVN1ZERMYjRBWEcza3BHbU1lanZE?=
 =?utf-8?B?Z2lCckxWMmxPdk5xeG5LTFlXRHBtWFlSdUFZRWIrMFB2amhkU3UwN1ViSWV6?=
 =?utf-8?B?TUFIcitDaHNrNk5hZmxadHZyZXplNkx5VlhDTzd0MHVtemR3KzZyQjNDdk9Q?=
 =?utf-8?B?cUZnZkI0djVoVlQ0Y0JISmxtV0p1UDUvYTV5eUttVVNxUWVXcTFFMDRVY004?=
 =?utf-8?B?WGpTVkRGbDdqZi9zcVV0ZjlDTkpUckNlQ0U5ZmZHRDF6M1NEMkRWTE9kZEVW?=
 =?utf-8?B?SzM4YVJVWGMvUng3QUNuWnJYeVFXc08rREtKQVN1cE1DMDA0c3M5N2RJb28y?=
 =?utf-8?B?YWI3a004UDVMUWR0RW05b2dpeXRSNlBNNTZ2RTl5UlU5TnI4ZWV3RDRUSHYr?=
 =?utf-8?B?WEdXc1psY0VoQlJuNlBvSUlxYlgwaUpxUlpwNFJkbmRjZCtXcFA2UjloUHQ2?=
 =?utf-8?B?bm41emovRC9tSUY4R1VxdWNNalA5T2J2K1dSQ3dTZG9sYlNGcmUrMk01aFJu?=
 =?utf-8?B?VVRkQ2xzd2dySmNXUVc2amx2bWwwQ3JtNDlac0J3bUVJQTF2MklrdHFEc29O?=
 =?utf-8?B?dlgreUw4b0hqTENQbThuUmM1TjU3cHRzMHZtRnV1UlpHQk1iK0JlWS8xMGxo?=
 =?utf-8?B?NldnWDk5cUlrYXN1V3NJQTNsUXc5Y1o2QzZmSEpkVlJmK1JoZE9QelpTdWdD?=
 =?utf-8?B?d0trajliM1VYQmZZZ1NkQ2lycENXME9nYkZ1V0lZMHRBOUtzcTZBekRwSHQw?=
 =?utf-8?B?cUZ5bk51OUwrTkJoWDVma0tzMWNyN3UydUJlUk9ldGVNMkpTUGpQQ3lHajNB?=
 =?utf-8?B?V0VvTHlaNXU0b01VSmwwVTJnNmp5bVFhcDR1ZitFeSs4dURSVzFPRGo2b2du?=
 =?utf-8?B?VjZJNkROajF2cUYwOUtIVjlqeHBoNVRKY2Z4c3NIY0d6TDNURy92eWFkMGxU?=
 =?utf-8?B?QmRXZDNWckVkb2JvNVlOM005aXFscDhxeTl3Ujhmb0NhNkhDUTF1SEsweDkr?=
 =?utf-8?B?bjAwZVAyR3BDRko0Y21sL2oxZFZhcHhhWlR1M3UyV2lqb0RhWTlEcWw3VGZx?=
 =?utf-8?B?ZUs0Y1A4eTFOVDhxZzlzUWlvZ1NlZWViVmhnVmJ5V2V5NDloZWIrcWpQL2s1?=
 =?utf-8?B?QmNlY3k3WVFRbnFVT0FOQTBLZGhmK0N5b01IQ2lpSkdqVTZ2UTBCNWpSY0Jh?=
 =?utf-8?B?cEtISk5RMkp0Z0N4b21weTljSWlHWHA1NnU2Q2U1S3drRi9TOTJEcmhBS2tO?=
 =?utf-8?B?bGhkTjBuQkc5c0dlekZXbzhRRW95ZWxNL2VPRVZNbG1wZUc5ZWIrdUNVa3Ay?=
 =?utf-8?B?VXM2dFZEV1lSaHhQZ1ZKZW9ibXdCM2FWQTBadnVzNGczM2ZUdDZlU3duMzBo?=
 =?utf-8?B?OWZhS3dEd1BXbURVZWp6VjdPYkUzaEtuZlAzMVBLay8yU2lIbHBBdDlCckNp?=
 =?utf-8?B?c1hlMU5mSm9ORGMyUlhTTnBCRUtmOHdyd2xZZ3F4REVXM3Jsd1IyNVRiV0NE?=
 =?utf-8?B?ak9wa09MUFZtVDNwNVFldTNwWEpxYzN1QmZjVUVVWS9aRHpRZzZHWkFMcU5z?=
 =?utf-8?B?OXJuT1pJcXAvanRXV3BUOS9WUEp6cFRicEpWZUNrSk1VZnlidzBNOUtDeCtj?=
 =?utf-8?B?dUhrd08vTXF0cGMrUVluUmZZRlcxdGJhN0drMGxuM29Hd0RpVU9PaUkxVTJr?=
 =?utf-8?B?OUpSdXNqTlB5ZXNwVXBYL0YyOVcyZXFKcUVGeG9QUUF2QmlQTHAvUTYwZ0JI?=
 =?utf-8?B?WUE3ZENIRkRMTHNVbm03N2R2bDFOWUROM0JkQ2YwMHpma1RtNTJvZU5nS2xS?=
 =?utf-8?B?V3FvTkNaWFdDdEFpQms5MGRtdUpIUFlGNWFPWFNSZDBITjdySHUvN3VNUk91?=
 =?utf-8?B?YVBLZVovejhWNkpqdWh2R0s4di8zNG5zRlR0L2lacDZZdXZTYUovQzJjTHFL?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680ddad-aaa6-4220-be51-08dd07c69a50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:46:13.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9KnEtfeFXoVwDcgKogOvrtB/eSr0BDeewf/kisKrzyAgt/xo95S+P/ouc7raAJZ1GQjm1NnWUlnina6o9oZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5313

On 18.11.24 11:18, Florian Bezdeka wrote:
> On Mon, 2024-11-18 at 09:02 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> libbpf is needed now to support the networking stack, and that is found
>> via pkg-config my meson.
>                  ^^ 
> Typo?
> 

"by" - of course. Fixed in next.

Jan

>>
>> Reported-by: Pierre FICHEUX <pierre.ficheux@smile.fr>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  recipes-xenomai/libevl/libevl.inc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
>> index 405be8b..fb82d09 100644
>> --- a/recipes-xenomai/libevl/libevl.inc
>> +++ b/recipes-xenomai/libevl/libevl.inc
>> @@ -17,7 +17,7 @@ DESCRIPTION ?= "libevl libraries and tools"
>>  SRC_URI += "file://debian"
>>  
>>  DEPENDS = "linux-xenomai-4"
>> -DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson"
>> +DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, pkg-config, libbpf-dev"
>>  
>>  TEMPLATE_FILES = "debian/control.tmpl"
>>  TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
>> -- 
>> 2.43.0
> 


-- 
Siemens AG, Technology
Linux Expert Center
