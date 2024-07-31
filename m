Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AD381AD
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456349; cv=fail; b=fT5evhPuWS9516X28OlurJCN69wtTLd63oAtPWzFfy4nNgzIwt3TVkBgmbnpd4WWz2XsTqy05kwCiZmfXN6CH5BcYDUrPnm21rjXGy2exRKD+BiAPCzHKg+4klGe3u+01+ICrYylzXcVEYL0B9exugcdIAEuy9bMdQdKJV51eok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456349; c=relaxed/simple;
	bh=2LzbeFG555WOyFN72RGzsi2xcc5zNLk7lUoi0KZc+QA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwOdwgN4Yc07VTsUsKxKI/+wqDnM5o0GkG9JrGovh9OMGYKKJo1fQPtIolbFIB/OaH96dOE+xf+lBML5+XjmvnpmVDOoaWIDmLWrKcvsVtwSOPXwtWnnXw79rqRxFU4vmjsa2DgT2f+1AuiNuL2Rd91nFK5o2N9uKAJs6KtjcDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iOHssKYj; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iOHssKYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6tu+E7HOzcAoUjHml7K92oEjvUVg56j4IxrNjhFIF4MSIN/1LJdmzb9pCtAyB9KgRfW5P2xylbdJSb9kZcOUh7mLuXI5uzruzg7xsdS7bzEfiWMRX430YKIM/taJ+XfhW5BoLiMiHoQmgigvgyVAPo8miPVIhCXqeaGfhzsN3i5dqHVArPtNINxWkHN7IwSgH/Jbk5/0LMLe1o13mLDN+nGS/D4zyWKLzRiV2OnmrVIdFt2KLQ15TQ+RYizYI2hJTWX3YYm5YpqRbmpn4Roi8WuTQ1EtjYE+wR3YcYpETDbM75lIs63SCZll8jCVA1/WNEkUmWQ+ik8IHxTLShrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH0LjNvEKNHmnJVlY5iol3SrHbYXKnyWtoctk3rPjZg=;
 b=fvZ64oPXv7ly1I/qf6RDS4VRtteVaidr9WzmqsCQGKMIEpuhAaVINl7Q3Ifi+oKhhZWMKRMFEQX9D/bNCLQbppLEb4fAndoo8x7Ck8Jo7GMpPWgcWLc6ndX+f+8f/KjxRIisK400db7/gk7wsjvxYeZdzLjOxPy1BvkBvBOGWnWFc/2ZA5fCApZYWv1+6Wt2HFkEDHdzOhAz0wI0Ak047lzaOTyoj4SCP1qNaWlFeyGleKDJ2SaAxyCcn3jrOS617IHmRaktMrk6RlEezIR8SdG0x9rvMYn7ItjwtYYcFOV2UdsOWgPq/kxgST4XUog4xp2YPRxbQm/5ukuRcvGKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH0LjNvEKNHmnJVlY5iol3SrHbYXKnyWtoctk3rPjZg=;
 b=iOHssKYjZScJp+i9HSggyc8Jh0a42pTZwoXhheOKVQ3UIK2JyyyWT181+wO/G//RfDCJYnRri5t6DcrQdMAkOgT7yGD2QTOKLAdaW/e98j4kLbrfffjT83Sc1ERdxmdRsel3tc3jL0WNzHga9vrFMstGksA3UHyAJTdUVUm08V56u2qWGn8VKVzwHFnLbkKpnyiIyVbkfSjXqexjou9ziuibe+PDDvosLfI9wnvjhV9qBPz2UksdaogzRt4kLz0jVTimuX4MjT93I1/6PvJIr3zj7qQ1h+5BIsML66iW1SxukyF8zQq1zHVN7KtMoZ5iuSrlT0B/nGj1WaMGiBOu0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:381::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 20:05:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:05:42 +0000
Message-ID: <6944e637-2560-4571-87a9-2bb7d5294025@siemens.com>
Date: Wed, 31 Jul 2024 22:05:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <89ad3b15-7fe7-44b2-8719-02dc8425ecfe@yahoo.com>
 <3d312b9673593f87ca2cfe6d86d3c9a1a791ab8d.camel@siemens.com>
 <3a545b7c-f6d4-41bb-a7b5-60cca32cffef@yahoo.com>
 <5bf13cc0-0236-44f7-b48b-c5b972180633@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5bf13cc0-0236-44f7-b48b-c5b972180633@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 95299072-f943-4a52-7c4a-08dcb19c27fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVdIL0VmQTBqMk9KN3ZJMkZrZThzRDlGT2laY3Jwa044ZCsxUjg5dlVVV0Rp?=
 =?utf-8?B?L1RFK3FXd3Z5cXBRS25xSXBYeE53SnVNbCsyQXZybGdQaTBDZFBjdXNLUElL?=
 =?utf-8?B?d09QZXNzVDk0dko1K1d2YUV0TVZac1NJWnVRb21XYXAxUFkyeEZzTkJ2UXNJ?=
 =?utf-8?B?T0hoVmRCamZYd29sRGdjZnJ1Vlh2Ulpjc3lta09tOEdjOUpaazRKL3lHUGYw?=
 =?utf-8?B?cnlmQ3RObWtkMEY0S1htZDBsaHJYbFpQQlJWYVB2MzgvanBRekkyZ3Y4Y2Yr?=
 =?utf-8?B?WHN1OFpOTnJ0Uko3emsyUS9iN2ZpSmhTK29EUWhUMTZtY1pFSkgxaVU5bUl3?=
 =?utf-8?B?aS80a0R4TEs4YXF0V3J6ek5rSU12bHQ0Qm03UEc3ZExpcjdsWkEwMVgyTVZa?=
 =?utf-8?B?NlVWeHcrRGtmN25MS1BsRTF4M1BkeVNaSEEzczV5Q2pMdC9UMCtiTTRUQjdY?=
 =?utf-8?B?Q0wwRGZXZkRZck9KRzdacGJpc1JnNE9nN29qZ1VLcllPVG5VeGNYeUNYdXdB?=
 =?utf-8?B?WVo4SEpQbTl6eGl6cGxNVVBhazlIdWxOeWJXVmkvY3BGNmFsbEdqelhJU3JX?=
 =?utf-8?B?L2hFOXBvcVFYRk43cS8yUERNUngwSnUzRVVDVWM0NTJTMmtMMExtaUJaMFN2?=
 =?utf-8?B?cDh3cmh5OGY4TENNRFVGN0ZYMDZpT0NKak43bUh2NEZIeHlQT25ZMkdKVmlB?=
 =?utf-8?B?ODFINTV5MXJlMFRSN3lnV1NlT0lzM1dvamVKOVAwbWZacGZJWDdUMlVzRzhK?=
 =?utf-8?B?MGFMVWpqbDdDaG5EM0J2QXBpbnExb2lvRHVnbjZZcFdqMHQxOCtzMUowRWxI?=
 =?utf-8?B?c0lCaTBSRXpaejhtUkNsRzFzTCsvTDlNMVJIMHpsSSt2Z1cxRGc5SXE3MlZZ?=
 =?utf-8?B?RkpjV0ZXN2NiMGlpSzZoazJVSGFLVFBhKzdhUVpjTStQbE9yN0NjaXhiekFJ?=
 =?utf-8?B?Y1JzbEExdDBYZW1qSjlDc1lCWko3R2tzeTFGblRvcUt5UU05eFhtbUtXdTJ1?=
 =?utf-8?B?aVdBV1k1M0hKTVloYnBmcGlTMVZWaDZPNjA5NG8zRkV4ZUxQRDRieU1oQTFW?=
 =?utf-8?B?d2I3aE1FUXROMjFxR1AvN3V0NDhzRzVzdDUxejFqbEJDSExOQXJ1cnZybTdJ?=
 =?utf-8?B?R2xGSHlrM1BFQUh1NVJLZzU2WmJpN3RjV2dMN1dlbThnbHFxWXBrRW1qb2RP?=
 =?utf-8?B?UU1RbWZRcThsdVh6VGZHMTFRTk0vMmhWZUxFcDljN2ZiQ0JFQm1IQXA1bjVO?=
 =?utf-8?B?RzI2cDJRRWFEWHNQTHlkZUhDUHgxc3N0K29RSXJNeUNLZU1sZG1SV01HVi84?=
 =?utf-8?B?T2p0TlowQThpb0NtcDhzaDk2M1U2eTVNNU01dlFHd2ZxNlVCa3R2dDBWN21o?=
 =?utf-8?B?TWVVdFhEdVlaTzFXTkg0WEFYWDNpVGs0MHFZWTJ3OFVqS0YvVDhFc1Bkclpi?=
 =?utf-8?B?emM3MHZ3Y2JILyt0Rlo1QU5OdmRIcy9RMTl0TStsUE9FMGxhdjVnS0tDWWtj?=
 =?utf-8?B?VDlaeVk5VTlkMzRxMGtoZWxKQzkrcTd2ZWovaUZmdDJuVW54bkRxNDJFb3ky?=
 =?utf-8?B?ZFBnQmRtdmUzMnJMZDZqYXM3d0p4N2g1eGt2eklpMWRrSEZPTDM1TkVjUDBH?=
 =?utf-8?B?SUpnZFpiT28rOVhUdEpFWkk2ZXFsWXVRS3ZxQndtQmd2d2tRUm8xczA0S2JD?=
 =?utf-8?B?bUJVa0VITTM3dmlJbFRXQ3JYY2w4WHQxZFJ0UVQxazlGckZPdFFuWEp1ZnU1?=
 =?utf-8?B?dy9YNjh0S1lDWGttZmpTUVFWNk1YbTRIVWpTOEdKbVBuc1VPOXhWa2tTV2R6?=
 =?utf-8?B?eWdFYWZkdkNkUG9OWjh5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNwL1dNVVBHSzZ1NFJLTzBjRDRFSkptd0RRWUlGZjZoRDgzY2s1R3B0WTJN?=
 =?utf-8?B?ZzRHVVR1L0VvY1Q0S1E2RTRWZnFjWmFnUVQ1NlZlUHFRU29ES3V5cWd4cXV6?=
 =?utf-8?B?a1lFcFNZYTFNdFJwMXhtVEN2Ykhac2lhVXducGJhYUtqLy81S3Ftc1RzWTZs?=
 =?utf-8?B?M0JvM0ZVSDQ3ZUNzWEkySmU2VmRQVUpwZzBYcklmczNhalpFMG5yajNmRjVE?=
 =?utf-8?B?S1ZPcUovWStxWDFQRllMS254MG9aUW1ubW1TR1ZEYWtxcFlwUzNQVzBrUFBs?=
 =?utf-8?B?eVRKWEVOVjBqUFBwODVlWFdBaEM4K21pM1Njdkp0ZXJsRjlRT2ltdFpqNmNR?=
 =?utf-8?B?SWx6OWtRbytjdkhxcjd0dGJvR1pUN2pEV0hRRjBvNUVRUWJ4ejdrZkdVM3pj?=
 =?utf-8?B?WWFLR2t0ZVliL09xRU9KRklka2VpYWxPVGVwOC8xNG50cmhQUVpkazVpMS9S?=
 =?utf-8?B?emVkK1d4TUF2aHdSNXhwZk9DZWc3RTdnKzZuamxSVVUwVFRXMFI0TlhUWG1i?=
 =?utf-8?B?MjgybUNQU1dKOFBJaUxLekdtb0UyTnlYMjEybE5WcE5aeEk2WmxsaUV4MFlN?=
 =?utf-8?B?SjhXa3RZSkRkOTdLRzhBdmw3bGNqT1pFUjVySjVXOXI2VERyNEE0T0gyY29U?=
 =?utf-8?B?R21iR3I0ODJ2SWhSNDhTVndrcHI3WG9xdEU0OUUzK3FBRjRKejRBQkVXTEJF?=
 =?utf-8?B?MWprbVgzd21NQ3hvSnd1ODBzZWV2bGNUSUJWZ3pOMndYb1BkVHlwTFA2Tm9L?=
 =?utf-8?B?eVh4UTlMZ2o2am4xOU5qVTU5SzJGWTNjdXBZemZzMzR4SzJKblM1REFhYjlz?=
 =?utf-8?B?NGlka053ZVNWcytpUXZITEtWREd5cWI0Rk9ieGNTeHhPdnhwaVZ4M2ZBSkgy?=
 =?utf-8?B?V1NCTUkrb0d5MStYUVhzdGd6QlY2NDJMVm9LVDB0TDJFZGZ3SFBXTFpOaTkr?=
 =?utf-8?B?SjRQaGZSNTFZam1mQmtBRzRjRDZFakJERjBQVVE4SE1HcmloSFBXajh1aTlS?=
 =?utf-8?B?dSttblFqWXJTVlpabVUxcUJqemhmdzFSa1BtYlprbXV3UnFNVWg3Z2dWWW1E?=
 =?utf-8?B?a0twQi8xalRkeHdqNU9ndUg3K2FwcEtnWUkwb25XVnZRSTB2aWl4dXE0alZz?=
 =?utf-8?B?OGNqcU5lcEMzZkwwUk0xcytQakdmVlAraGxiQVM0MmNybWN1dWdweXdyaXpp?=
 =?utf-8?B?Wlh2R1Vlcy93VVFZdmJZZEd2bzQ3K2FlQXR5WXErSGI4eUdNU3E0bHlIM2k0?=
 =?utf-8?B?YVorcUVWQ0pqaTNHS0R1b3NmMEZiTWFFUnlneVlyN3UyY0VYS3lVcjRyZTN6?=
 =?utf-8?B?R3BpWHlxR1FqdzRoT2hKMG16REtnbnlybTF4SlhWRXFIeEtQaDdYOCtLNFFM?=
 =?utf-8?B?T2RnMWlXdGgrb3lRVW9LcFo5Sk5zd2E1OWxRWGdhREVneit4Nm03UDJ2NFhB?=
 =?utf-8?B?T05zdm5YdmpseElpNVE3OC9FWGhQRy9lNzhtWDhpbWd0QXRvNjBxN29namRV?=
 =?utf-8?B?Y2pjcUhVU3l6VUk5TlNLNlJncGlENW9ZMTJLaDd4aTk4QUVCK2k4a3YveFBn?=
 =?utf-8?B?c3pqZzhoTEx1ZnVzVXZOZDB4YnFSOGN6ZHdvVFlJVmtWNmV5Nnk2TW9ycGRZ?=
 =?utf-8?B?STNsQTRQSzRiRkVWbFlrOVpiVDkwNWhGTVJtRmhjTzlzbXlmK2JFVGZjSEpY?=
 =?utf-8?B?TFI5ZmdlWU9FVDJ3dXhUOS9NakVQaHBOZE1nTXV6UG0wajBwQm16VSt0OHp0?=
 =?utf-8?B?TDJCbVdOcEdGaGo2UXRpZW1oVTdTSlk4bHB4aldEOHNJZStEL2pMUkJIb2My?=
 =?utf-8?B?VmdQWG16L05OQUQxb3AvOXRnbWp4ejJtZE9VL1p3SjNaQm8wWXduTjgyR2h0?=
 =?utf-8?B?NXlXcDJ6am9jZnE4aXhzM0I0Slg1dWI0cWYyeHpxTWpHanczdldEYmo0eFkw?=
 =?utf-8?B?VCtuNy9aTmNJZ0xrWFVpVm9EeEtSc3l6TmoySVQycG5JWlVqaG0vSmRZaHhn?=
 =?utf-8?B?WWczcysyQXBrb2o2STV0Z2VXWWFYZHNPVkhOVkU0MEZuQlVHWkdUYlJaQ1BF?=
 =?utf-8?B?YlZmcFFWMlZ2ZnoxaXcxdkVKYkIzcmFORTEwcGtEdGRSKy9GMHI4ZDNLU2Vr?=
 =?utf-8?Q?Sq8Pyq6pqAuZS/m/yPrifjZOz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95299072-f943-4a52-7c4a-08dcb19c27fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 20:05:42.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E00romRRa/pwVmv2o3OSDnRMJjvjWZcuilDQVEeHSdC+YRYwkzsWdS+q4wDtNa8zVFi8LdoIPTQGWhdZ/08juw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8163

On 25.07.24 11:40, Mauro S. wrote:
> On 03/04/24 13:03, Mauro S. wrote:
>> On 02/04/24 15:41, Florian Bezdeka wrote:
>>> On Fri, 2024-03-29 at 17:06 +0100, Mauro S. wrote:
>>>> Hi,
>>>>
>>>> kind ping about that.
>>>>
>>>> Not to put0 pressure on, just to know if the problem is worth
>>>> considering and will be examined or if I have to make my workarounds
>>>> definitive.
>>>>
>>>> Thanks in advance, regards
>>>> -- 
>>>> Mauro S.
>>>
>>> Hi,
>>>
>>> we had a short discussion about that issue in the last Xenomai
>>> community call and agreed that we have to dig deeper. If you got more
>>> information in the meantime, please let us know.
>>>
>>
>> Hi Florian,
>>
>> thank you for the update, good to hear that.
>> Feel free to ask any additional information you may need in your
>> analysis.
>> Unfortunately I have no further information. If I will have, I will
>> let you know.
>>
>>> How does your workaround currently look like?
>>>
>>
>> Nothing useful, I suspect: simply the external process that kindly ask
>> the main process to terminate with SIGTERM also monitors the main
>> process exit duration: if the main process does not exit in some
>> amount of time, the monitor process kills the main process with
>> SIGKILL. The side effect is that I brutally interrupt some operations
>> that, in a normal exit, would be finished in a clean way.
>>
>>> I think Jan will answer once he's back at work.
>>>
>>> Best regards,
>>> Florian
>>>
>>
>> Thanks in advance, regards
>>
> 
> Hi all,
> 
> I don't want to bother you, and I don't want to put pressure.
> Just wondering if this issue would be analyzable/fixable, or not fixable
> at all, to decide whether or not to make the workarounds "official" in
> final code.
> 

Sorry, this fell through the cracks. We should look into this before the
release, for sure. Scheduled for next week.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

