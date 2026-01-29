Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10141366048
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672792; cv=fail; b=InC/RydQsbcKsAGQwNG/LuFv/mryvTb9tJucCoMiWtPot3RvLNQ3fLVGoL41xyd8KX3fdoBSprVFdc4J4EetJULiOW2AEpuEj8AxAak7d6BQm65l/j2GUhXCKjzJTRAGDD9m8QPKA7ERj3xyuTaZzevPbTGrNySQK3MlvvagPSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672792; c=relaxed/simple;
	bh=BPsjE2E7Ubh0QZ3bdS8j/zWTrnDAOJj30I7WxRIOF9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RCGBX8MC4qZKKYfUJbLi7OxFziI/byIGyLzOSVAM97cEvWMLadrL9Z32Mf2AFAtL49wkm1QXA0LppdtOsCIwSoDKjayFuSpVcwbIGKRnAQK9brhbh+kWDPLYNIT3bRWQFU79Gm0mSoFGPwCzqmDwJhS90G51A+et5PyxqdU5Evc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y0WEe8GH; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y0WEe8GH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3hebeKqMlj2FzabXxFEfUg31Hhx9nb2lCLS9Z+Bmk4yMvXYREG4SbAvYH3O3G0mtA3ofyO9A9iipROk7petAv0NPQxaJXMKfc+WmHdpaWw6aXG2ycEheO1DN99IUlf3TUXI50zfBxFWXUT0mChSQK/VqxMOrUWySqgCgWannpxZr00kPS35/QVNElS7rQ5k0me5IXcylBf1RVIZGiUNuYIcpxSl+OOO2XxipzVaCJi+N2dhDptxf24aBw7lwokKXc1LdG9/VGzKd9W0br4D8C+wdyrakPhGKdYIYRZ1/O/Hg2ISpmUsHRKImCyWvFEciMh9iwAPl0WZYFyqJPA9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wJkWh0sF277ObcgK/Z0tG3X2R76iJCcAGBLRuOUPV4=;
 b=fV4OXy6h1c2yW8pCACbTOPdsFMQVxd8Z2pt/Lxs+YQ80h4DuqSsfWjEvmK5dYacISQrcFN7l5/x1/TRPXhYsBN7iN8QY0yIBzHt5HHW94tVRJj2cXDv31wB3QRTrxt0uSxVPgxCkmlaxQAVMq+7r4/MtUExht/7TxQOcODchexQd0K10Fw5cj8w/ZkM9L9yXi5BhxM7pu+McZOL8cYhxm7y+Pyy5x+MLAmldxX7/Pnha5o8/BR6AAmaVDDcKM5rMbJA55qiORcWTnD+SKpnTnwn7uBMWyTE2nJiSW+LByGU5Hqm/LIplLM1jkbuUUlnlT1SgWjFnB6P8P6lNZH92KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wJkWh0sF277ObcgK/Z0tG3X2R76iJCcAGBLRuOUPV4=;
 b=y0WEe8GHXD+tfxJ6Z8Lm3fQ8KqVEn+HxVv6kpgxvqNppQDYoiEqnJ2XPyQBjubvzzZA0NF8P/aT4j8bDypRMpiI14+cD/B0M2KlKXdBZGiXQ2o0DO3wt6ngv0zN6BhKh0YCTj69qY0MMkrUyVM7ET+rvGQc5zEvDbw8MKA/RhUniFGa6DEd4TR7WTHGj/yQHdnUeWT+6L2UkISOdNndlrXO+Uf/3MeV0MaZmOspM5xxgsHLmseBMxwD8aQcmVdSdY1nB1BE/hglYgThnwjcwRH6YsUhjgxyly90aCxnqInVmuX71v9Cp30b9xoby3QOA8Z0p6+gg1J2WoMDhiLCTrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 07:46:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 07:46:27 +0000
Message-ID: <65e006b2-dc10-44f0-85b5-16cbbdcb3bd0@siemens.com>
Date: Thu, 29 Jan 2026 08:46:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: "Mauro S." <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
 <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
 <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
 <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
 <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
 <badbf3d2-4ff7-4d72-ae3e-24898f84c015@siemens.com>
 <f9116b18-0aa2-4b32-bce1-98913cf0c721@yahoo.com>
 <7d2de011f553742fb9c016f190956dd72792d8ec.camel@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7d2de011f553742fb9c016f190956dd72792d8ec.camel@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 484e4414-36d4-4a25-5650-08de5f0a823b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmVRdldxN0xnM2I0SFQwT3E1blhxZGJnclRZWThZSGZldlQwWllMd0RxZGx4?=
 =?utf-8?B?eXp5aHpUd1NLWnRlcmlDZWZCbjAydFZTNFZ1S214SXdNYkkvejBadG9Sb0Ir?=
 =?utf-8?B?RjZRcjlZbHRNcERQaU1UZWoxekZWS3lwRzczSDlYVXdoLzUydEYrbkRseFNx?=
 =?utf-8?B?aW5LNDRuUlNDaGZvN3QyUTNVSU1CZ2lMQkxJbnFtYmdCcjBhdzZCRHNMNVZz?=
 =?utf-8?B?bWdwVDZrUUd0bVJ2emY0MUYxR1NaUHBVL1Q0WFNBS3NKRThNV3crNVJRY1RH?=
 =?utf-8?B?NlE1eTAwL1lnUXV5VEN6UUNHV2FaZ2RJaUdNNDhJSld6L0J2dU5OR1NRc1Ri?=
 =?utf-8?B?RzF4SlZTRFY4L3FnbHVwdXRhQXpSZXZIbCtBMjV1NGdpWVFiN1ZYMU1XemJo?=
 =?utf-8?B?TWl0M2pNWjNMRTFhcUpPQzBHRnZJVlhuZndjdnY4Vk9kY0lvRGVVSUhaWE1D?=
 =?utf-8?B?WEIzeWxIRXRWMkZMMEhYMWxjc3k2WEhSZ1F2c2svTTJ6aTNKSTgzZDJ2aUNn?=
 =?utf-8?B?d1NRT0NIYWRLR3JvdWxFcDZZdkxnOXFHU3dVaEZxMWVVeTBDeGU3YkZwTEVQ?=
 =?utf-8?B?RFJKWDJaYzBPYTMrMGR3Tzd4YkRYVzB3SVZ1MlJFWFZHM3hKd2lDclhrQ1pY?=
 =?utf-8?B?WWxWUk5SRExSbmFHSDFaZERaYkZJNFM0T2hkYlBNQUVJR0xaK2p2NHorZkV5?=
 =?utf-8?B?OHNzZ3k1RnJuUG0zSndRZXp3UDZ1YXB4Tys0amV6QVc4bVVGbzhKTDZ2STFC?=
 =?utf-8?B?QzFTVDUxQkpGb3lFUmdpNUYxQ2dGWkk4VEdGUXk3dTZxakd5Qi9EdHloSnBV?=
 =?utf-8?B?ZGNab2ZXaHZhdThvUFM5aG9xU2NxNnR1WUM1cm85SU90MTB4WnJibmZUYlRv?=
 =?utf-8?B?TmpBMml0VHJMSVNnR2lLWEQxV1RXb1IyVzVqd1pWdXhTbUs5cEFOblo2RkVM?=
 =?utf-8?B?M1pncjJsNllDOHRSb2YwbDBYK0E4cy9yMFlkaTd0cFhnSkRtWUUxdy9BMEE2?=
 =?utf-8?B?Zk9YUmZqb29rckMreEdrVjhNR3VZQ1R0SEFBSEx0UnBLUTRnMGNLNW45Skk4?=
 =?utf-8?B?NGpaS3MzVUVEYXRaMFV5UWZibmhkNzJ1c0paeTg3ekNGYkNDODkvZmJONXdQ?=
 =?utf-8?B?UnVoNWFCU3JPcy9iODFkSHMybWhsbzhPZ1E0MzE0aVg5Z3lGRWFaQUxPcW4x?=
 =?utf-8?B?OUk3RWlhUHkvQ3lRSzQ3dnp4blA4Z0FNbkl1eUkzVWVQRXZPcmVEakxSZUta?=
 =?utf-8?B?NmlJY042RitpUjl6ZjNnaDZYUXJidmZyem80bnZVeEpFQ051dzkxS1k3Q1Ra?=
 =?utf-8?B?V2pQUU9jSmZuR1NyR1BVNnVFTDJtYVNQYlBhZy9kbnorRFQ3V29ONFRPYTFv?=
 =?utf-8?B?YU1aYzJoK3cwdU1kRStWNzdoclRMZzk2eS9icDlOMU0rRWZMK3YycnI2TEVz?=
 =?utf-8?B?SFZ1M0poUDB0azN3Yzl1aGFZbHBqdjM5R3M0MjE0bHlZNVBGNVRrd3RFWWFj?=
 =?utf-8?B?TVBEa2VUWEREdklTMHowVWo5eGJpUmlSb3MzRThaaSticG4xaE9uSE8rZlJz?=
 =?utf-8?B?SVRtYUNZNWsyVW9aQnZaMGhrRVlZejZsdjNOVWdwZVhxeEMwOTNEc0lOd1Q5?=
 =?utf-8?B?Q1Uzc1NBd1l2OUdKTnpEeDBkYWJ0eVJScGNvWmFvanc2MGF2R20zMHdOOFZE?=
 =?utf-8?B?ZTRTMTllelpRUjN5My94WDZTK2pwM2wvU1JDSy9GL2hkUTc2Rk54T092UmFB?=
 =?utf-8?B?eGhsTzNhQXhOS0JMNDRwRzE0K1ZaTUtqb3NJQjVRZDJIT3plclZaUHZ3OFB4?=
 =?utf-8?B?VWRua3prbU1GdUdNY1kxMnpYRXE5K3Z0cEx1U1ZaV2hIaGtBTWJVQnNDT1da?=
 =?utf-8?B?RkdHOVJmaVRVRXJ1elQzVWUxSU5uVnV6U3FCOXJJcWVmQ1BkUWJDQ3pKcWly?=
 =?utf-8?B?MTl4M0Z4cjgyVEdJMTFGa0VaNmVLcGtNbjR5dDNEWkR4cHNlY0svWi9lQTlI?=
 =?utf-8?B?NEdFWit2UENXcFlRS1ZPcEM4UWFZSGZzbm9YMEFwcDFqMytHTTlWaHdyM2N5?=
 =?utf-8?B?aHA4YjRvejh3MWhkQlhpWnVSbUZwbDNQZXBPeUlCemFXanI1RERzMXFTSnNB?=
 =?utf-8?Q?5NGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a281RnppZXpBRlZDcGUxWUtKNSszMm9OcGJjN1dnUFlXb0RRczlBYmNZcjIx?=
 =?utf-8?B?M0ZuN0JwRlZhVjhUOGprcjBQQkc4SUpvMjhRQ0IrbVZpQVpmYnpZRW5CU3kw?=
 =?utf-8?B?azlIaXg1WHBvVHJVaU1POHNJQXRGK3ZCTitmT1pzbnBGeXh3L3Y3cVdQWk1J?=
 =?utf-8?B?OUx6bDRuVWdLNG5jNDhhOHlvQ1BQOGRWaFJkVWk3KzUwUS9KbnRLQ1dOSHVi?=
 =?utf-8?B?K3dNNU1oZzVkVlQrTkNZMU9BdVBBODhpOURBNk44QzgvZk1hcm1ia0JXMUxl?=
 =?utf-8?B?Qm95WFk1ZE1tZzAxNXVudlUxRG5UcmdOZEhCTmFURlIza0ZlYWdYaVlCSGFO?=
 =?utf-8?B?ZDhTSDkwVnRBb2gvbTQ4YW90MS8zaWVvUXNmbjVDK0JVdHhXcTFpVlBCU1Bw?=
 =?utf-8?B?MDNodUw3QUlwL1BWM1JLcXU3Q2FSVHBZSlZKWGdaVXJ4bHpUWnZmT21yZ2to?=
 =?utf-8?B?SnBmNDRKQU1MZGRHYTZXOXNZdkdkd3Nla3pOQzdnR05kWlRoSDFUb3Axb250?=
 =?utf-8?B?UUs2cXBqK25QaFVhSU9ETGJ2d2pZbk4xQzM1dFBYVE1wcU9jM0NvYlZsQmV2?=
 =?utf-8?B?Vng3ZDladnRnYk54N05yUDJvYWUvcDBMREdVTGh2ZHAyYmw4UCt2K3VTRlNQ?=
 =?utf-8?B?Z2xBWFUxYUlwUVA0WTFCRmJ1aHdUdFZXdnU4dFBmSmtoajZWcFlkalFiOHBh?=
 =?utf-8?B?R2xJaXVacXNiZkZDeGVzZ2t6VnVvMFBNUDJOSVkvZ3diSHZkYUxETlNkN2tT?=
 =?utf-8?B?ZTBNUkdRaTNLU0RtUDdhS3Q3YmN3bktOVUovbEE5WTVma2hDSjRkUk1SdUJi?=
 =?utf-8?B?Vlo4WjRUd3pzcTRuR0RNZ21nT3A4UTcxenIzcWFYbVZ5a0lydTVLczBSYjQz?=
 =?utf-8?B?Wm9SNE9ZRzRWMEtvUVZ3QU9DczZsdUQ4YjdjbWdIOGdyc0JsTWV4VGJNTWtj?=
 =?utf-8?B?SFZ5L3pwUnZIT0R0M2ZUN2hFQWwvendDTEZNQTNVbUpHZEhYRzhQMm5xY2pr?=
 =?utf-8?B?djg1Z2IvYmQzeXgxRGNDLy9Fbk9qeTVlbHpuM0NyTllnOE53azZnL01TSG80?=
 =?utf-8?B?MkFiVGxBUDZLcjhQQWRwV0tjdXljUzRXZXdNMWpjRTJ2QzBCUldPSWhrd0gr?=
 =?utf-8?B?cUFqZm40L014SENvakxGckN6cTArYW5lVzk2ejlsZ2owMXV3Tk8xWS9yQjlF?=
 =?utf-8?B?ajNidjg1dEdaenVEN3duUjNSc2FKaGErbUkwc1R0SHhnajdOaVJkL2ZkVGY0?=
 =?utf-8?B?d2N1TXNsNmE4NzYvRytHRWhhRlRsZWhOUVU5a3E4NHV6aklUNzR6SDVPMGpY?=
 =?utf-8?B?TmhIYy9uOVhwS1NhOWd5SXJnRFdiNVlnd0wwT1lib095ZEE3UitQSGM2eTRn?=
 =?utf-8?B?MnBoYlZuQVppWDcvaFE0NkFCaDI3dlYxUGtjRUkzVGVMNVlvQ21maSs1Y3F5?=
 =?utf-8?B?T0hmby8zMWx4NnZ6WVZNZmpONkhZWjZXSkthbTRWVjBpeFIwRUZGcXlXeEVq?=
 =?utf-8?B?RTZqNExkYXA0WWtuSlRSTDhTSHRoWEljcXhoY01qaGI4N2pvYmFVa0NuZEpN?=
 =?utf-8?B?MzBYM2NUOVVhUlFTRmsxbzluOEIzUHIzaDhKVnRiTGRGSDB0OGt5M0pJVlZY?=
 =?utf-8?B?czlSM1p0aXRhOENrQ2VPSkhFaU91SUp1c003cHdSeit0SUpsREY3cFlLdUxS?=
 =?utf-8?B?bHAyN29ZNWkycHBxWTRVNkdQdFdlZVROc09WRE5hN01WdmV4RC9zQVNpU0J3?=
 =?utf-8?B?TEVWYXFEbGUxZ0lreDgzemNnRTQvMkdYWlRmbG1leUY3UVZVMlk0STcvMmw5?=
 =?utf-8?B?UEZQQjNqM0VKRkhBdjNJUS8rR2FnMjduekl4MnFwVzVUZTR0aE9qRE50c2pM?=
 =?utf-8?B?ckxHZTVrSnVBVlZTUk5sN3Vxc21XOTZYbnVJTEsxSEtTeWQ2UTI4amFCY1lY?=
 =?utf-8?B?WnZDcDc4YVQvelFMNlU3ZVFXbHo5SGVaNnJZSGRjN2tFSm5SZDdiV3hZcEZw?=
 =?utf-8?B?RFJNTVJIbm52dGZySFhyY2hOZG9aRXhlSjA4aGsrK0JlSTNsWkd5aFdMbG9w?=
 =?utf-8?B?aC9TZFB5Q1Q2TDJ0WHBQQWZLTHExaURURnV3eDAraWMyV0dnSEduUWFLc08z?=
 =?utf-8?B?SGF1cjloMmZPZnpIL0hWTHVNb0R1TTJUUUx1VitBaW41OXRWVWZrbUtVaElr?=
 =?utf-8?B?UklnamRIZmNuYTdjOUxKNHVaKzl3SGJoS3ZuelhyRXluU2pQbURBRnh5cmxv?=
 =?utf-8?B?NmlHVHVCZGV4OEVvVHo2a2xnNDd2c3l0RmJEQkw4SkVvY0FMbzVUVWxVQk1N?=
 =?utf-8?B?Rk5zZEw3ZFdUQWQ3Tnk0NWdDSXJtNGZUVFBWcU8rV3FJa0lQREMwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484e4414-36d4-4a25-5650-08de5f0a823b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:46:27.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FeLzC9xinceO0CipM3lTLXUvFwPBfPCAXY1Xch5HVgXlsXB60ILtNHFHSrmiQAsM+8yKZlLzd7ZR7zFfUPGkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8176

On 28.01.26 14:03, Mauro S. wrote:
> On Fri, 2025-12-19 at 15:12 +0100, Mauro S. wrote:
>> On 12/19/25 07:50, Jan Kiszka wrote:
>>> On 17.12.25 17:16, Mauro S wrote:
>>>>
>>>>
>>>> On 12/17/25 13:31, Jan Kiszka wrote:
>>>>> On 17.12.25 09:42, Mauro S wrote:
>>>>>> On 12/17/25 07:59, Jan Kiszka wrote:
>>>>>>> On 02.12.25 09:56, Mauro S wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/26/25 12:50, Mauro S wrote:
>>>>>>>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>>>>>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>>>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Not sure if I found an obscure corner case or
>>>>>>>>>>>>> I'm doing something
>>>>>>>>>>>>> nasty.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system
>>>>>>>>>>>>> with Linux
>>>>>>>>>>>>> 5.4.299.
>>>>>>>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Please find attached test case code.
>>>>>>>>>>>>> Program is very simple: the main task starts a
>>>>>>>>>>>>> bunch of joinable
>>>>>>>>>>>>> tasks
>>>>>>>>>>>>> that immediately suspend theirselves. After
>>>>>>>>>>>>> starting tasks, the
>>>>>>>>>>>>> main
>>>>>>>>>>>>> task resumes all tasks. They do a small sleep
>>>>>>>>>>>>> and then
>>>>>>>>>>>>> terminates.
>>>>>>>>>>>>> Terminated tasks are joined by another task,
>>>>>>>>>>>>> that was launched
>>>>>>>>>>>>> at the
>>>>>>>>>>>>> beginning of the program execution.
>>>>>>>>>>>>> Subsequently, main task continues to recreate,
>>>>>>>>>>>>> restart and resume
>>>>>>>>>>>>> joined
>>>>>>>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What I observe is that, when calling
>>>>>>>>>>>>> rt_task_resume(), the wrong
>>>>>>>>>>>>> task is
>>>>>>>>>>>>> resumed.
>>>>>>>>>>>>> Please see the attached log. In this log I'm
>>>>>>>>>>>>> printing the .handle
>>>>>>>>>>>>> and .thread data in RT_TASK function as
>>>>>>>>>>>>> hexadecimal.
>>>>>>>>>>>>> At row 19 you can see that Task1 (that has
>>>>>>>>>>>>> .handle value fc1c9,
>>>>>>>>>>>>> the same
>>>>>>>>>>>>> of the terminated but not yet joined task 0)
>>>>>>>>>>>>> has been resumed
>>>>>>>>>>>>> when
>>>>>>>>>>>>> the
>>>>>>>>>>>>> rt_task_resume() was called on Task0. Task0 has
>>>>>>>>>>>>> been
>>>>>>>>>>>>> terminated its
>>>>>>>>>>>>> execution, but has NOT been joined yet: if I'm
>>>>>>>>>>>>> not wrong its
>>>>>>>>>>>>> resources
>>>>>>>>>>>>> should not be usable until join is done (at
>>>>>>>>>>>>> least this is what I
>>>>>>>>>>>>> understand by documentation). I expect that
>>>>>>>>>>>>> calling
>>>>>>>>>>>>> rt_task_resume() on
>>>>>>>>>>>>> a terminated-but-not-yet-joined joinable task
>>>>>>>>>>>>> should return an
>>>>>>>>>>>>> error,
>>>>>>>>>>>>> not resume another task. Am I wrong?
>>>>>>>>>>>>>
>>>>>>>>>>>>> I know that is some of a stressful test: in
>>>>>>>>>>>>> fact if I call the
>>>>>>>>>>>>> rt_task_resume() only if task is not terminated
>>>>>>>>>>>>> (checking also
>>>>>>>>>>>>> the
>>>>>>>>>>>>> executed flag adding "&& TaskList[i].executed
>>>>>>>>>>>>> == 0" into the if)
>>>>>>>>>>>>> the
>>>>>>>>>>>>> problem obviously does not happen, but as I
>>>>>>>>>>>>> said I expect an
>>>>>>>>>>>>> error
>>>>>>>>>>>>> instead of a wrong resume.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Launching the attached code, you should be able
>>>>>>>>>>>>> to reproduce the
>>>>>>>>>>>>> problem
>>>>>>>>>>>>> on your side. When the test detects a wrong
>>>>>>>>>>>>> resume, program
>>>>>>>>>>>>> terminates
>>>>>>>>>>>>> automatically.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Can you rule out data races on the shared
>>>>>>>>>>>> TaskList structure?
>>>>>>>>>>>> Seems
>>>>>>>>>>>> both
>>>>>>>>>>>> your sub-tasks and the main one are accessing it,
>>>>>>>>>>>> and that
>>>>>>>>>>>> possibly
>>>>>>>>>>>> concurrently and/or unordered. Or does this also
>>>>>>>>>>>> trigger in a
>>>>>>>>>>>> uni-core
>>>>>>>>>>>> setup?
>>>>>>>>>>>>
>>>>>>>>>>>> Jan
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi Jan,
>>>>>>>>>>>
>>>>>>>>>>> attached the modified code: each access to a
>>>>>>>>>>> TaskList element is
>>>>>>>>>>> now
>>>>>>>>>>> protected with a semaphore (one semaphore each
>>>>>>>>>>> element).
>>>>>>>>>>> Strange behavior happens anyway.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ...would have been too easy. Ok, will try the other
>>>>>>>>>> day if I can
>>>>>>>>>> reproduce and maybe even understand.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> sorry, I should me more verbose in my response.
>>>>>>>>> First of all: no pressure, take your time.
>>>>>>>>>
>>>>>>>>> Then, a more deep explanation.
>>>>>>>>> I added semaphores to avoid possible concurrent access
>>>>>>>>> on TaskList
>>>>>>>>> elements, but I already verified that code should
>>>>>>>>> access them in an
>>>>>>>>> ordered way without concurrency, thanks to "joined",
>>>>>>>>> "started" and
>>>>>>>>> "exited" flags.
>>>>>>>>> In detail, TaskList elements are accessed:
>>>>>>>>>
>>>>>>>>> - by main task
>>>>>>>>>       - under task creation, writing task handler and
>>>>>>>>> "joined"
>>>>>>>>> flag: this
>>>>>>>>> happens only if task was joined before
>>>>>>>>>       - to resume task, reading some elements
>>>>>>>>> ("started", "joined" and
>>>>>>>>> task handler) and writing "resumed" flag before
>>>>>>>>> resuming the task.
>>>>>>>>> Here, "started" must be 1 and "joined" must be 0, this
>>>>>>>>> can happen
>>>>>>>>> only
>>>>>>>>> after task creation and start
>>>>>>>>>
>>>>>>>>> - by sub-tasks ourselves: during their execution.
>>>>>>>>> Variables written:
>>>>>>>>> "started" (at the beginning of the task) and "exited"
>>>>>>>>> (just before
>>>>>>>>> termination, after task is resumed and did its sleep).
>>>>>>>>> Also, verifies
>>>>>>>>> "resumed" flag when got resumed, to check if resume
>>>>>>>>> request was
>>>>>>>>> for it
>>>>>>>>>
>>>>>>>>> - by join task: this happens only if task is "started",
>>>>>>>>> "exited" and
>>>>>>>>> not "joined". This can happen only after a complete
>>>>>>>>> subtask execution
>>>>>>>>> task resets all flags and sets "joined" to 1
>>>>>>>>>
>>>>>>>>> Printf sequence seems to confirm that execution order
>>>>>>>>> is OK.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> If you would like to understand a bit more already,
>>>>>>>>>> you could
>>>>>>>>>> catch an
>>>>>>>>>> event trace (trace-cmd record -e "cobalt*" -e
>>>>>>>>>> "sched*" -e
>>>>>>>>>> "signal*") and
>>>>>>>>>> study the task interaction (trace-cmd report /
>>>>>>>>>> kernelshark).
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'll do the setup to trace events (I don't have trace-
>>>>>>>>> cmd on
>>>>>>>>> target, I
>>>>>>>>> need to setup a qemu image with it).
>>>>>>>>>
>>>>>>>>> Thanks in advance, regards
>>>>>>>>>
>>>>>>>>> Mauro
>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> I made a sequential version of the test application:
>>>>>>>> instead of
>>>>>>>> having a
>>>>>>>> join task, join call was done by the main task, one
>>>>>>>> subtask at time.
>>>>>>>> With this code, tasks does not access concurrently to
>>>>>>>> variables.
>>>>>>>> Problem happens also with this code.
>>>>>>>>
>>>>>>>
>>>>>>> Starting to look into this:
>>>>>>>
>>>>>>
>>>>>> Great, thank you!
>>>>>>
>>>>>>>> STARTED TASK Task0 (82a9eab0-829636c0)
>>>>>>>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext:
>>>>>>>> 82a9eab0-829636c0)
>>>>>>>> STARTED TASK Task1 (82a9e2b0-829526c0)
>>>>>>>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext:
>>>>>>>> 82a9e2b0-829526c0)
>>>>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>>>>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext:
>>>>>>>> 82a9eab0-829636c0)
>>>>>>>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>>>>>>>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext:
>>>>>>>> 82a9e2b0-829526c0)
>>>>>>>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext:
>>>>>>>> 82a9e2b0-829526c0)
>>>>>>>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext:
>>>>>>>> 82a9eab0-829636c0)
>>>>>>>> JOINED TASK Task1 (82a9e2b0-829526c0)
>>>>>>>> STARTED TASK Task1 (82a9eab0-829526c0)
>>>>>>>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext:
>>>>>>>> 82a9eab0-829526c0)
>>>>>>>
>>>>>>> So far so good.
>>>>>>>
>>>>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>>>>
>>>>>>> And here you are resuming a task that is in waiting-to-be-
>>>>>>> joined state,
>>>>>>> right? That is an application bug, but one may expect it to
>>>>>>> be either
>>>>>>> ignored, only affect that Task0 negatively, or even
>>>>>>> throwing an error
>>>>>>> back to the caller.
>>>>>>>
>>>>>>
>>>>>> Yes, exactly: task is ended yet, then should be joined and
>>>>>> not resumed,
>>>>>> but I would expect that the resume command was ignored and/or
>>>>>> an error
>>>>>> was returned.
>>>>>>
>>>>>>>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>>>>>>> 82a9eab0-829526c0)
>>>>>>>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>>>>>>> 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
>>>>>>>
>>>>>>> Instead, we see that spurious wakeup of task1. Let me debug
>>>>>>> into
>>>>>>> this...
>>>>>>>
>>>>>>
>>>>>> Thumbs up!
>>>>>
>>>>> Ok, here is the catch: The task handle that was used for task0
>>>>> is freed,
>>>>> even before someone joined that task. And task1 handle was
>>>>> freed as well
>>>>> before you call CreateAndStartFn(1) again. Now your task1 will
>>>>> get the
>>>>> handle of previous task0, and when you try to use that stale
>>>>> handle for
>>>>> resuming task0, alchemy looks up the new task1 instead - and
>>>>> resumes
>>>>> that.
>>>>>
>>>>> I looked a bit into whether we could delay the handle
>>>>> deregistration
>>>>> after the joining, but that would be a hairy operation, likely
>>>>> also
>>>>> affecting libcopperplate. Given all that, I think we are safer
>>>>> off
>>>>> living with this "specialty", rather than risking instability
>>>>> in the
>>>>> cleanup path to handle the application error a bit nicer.
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Ok, got it.
>>>> IMO this behavior should be documented somewhere because it's not
>>>> what a
>>>> user would expect.
>>>>
>>>> Just throwing out an idea (that could be completely wrong): to
>>>> workaround the deregistration issue, should the resume function
>>>> use both
>>>> the two RT_TASK fields to decide if resume or not a task,
>>>> resuming it
>>>> only if both the two IDs matching? From the log seems that the
>>>> second
>>>> field (pthread ID?) stills occupied until the join happens.
>>>>
>>>
>>> I played with that idea. It initially looked simple, then reveal a
>>> catch, but I think I was able to address that as well. Please have
>>> a
>>> look at the patches I just shared.
>>>
>>> Jan
>>>
>>
>> Hi Jan,
>>
>> I've seen patches, thanks a lot!
>> Unfortunately I'm not able to test them on the final system, but a
>> quick 
>> test in a QEMU machine works properly (no doubts about it).
>>
>> As soon as I'll test on the final system, I'll be back with a
>> feedback.
>>
>> Thanks again, regards
>>
> 
> Hi Jan,
> 
> sorry for the long delay.
> I managed to try your patches on the final system and I confirm that
> they work.
> 

Never mind, and thanks for confirming!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
