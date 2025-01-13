Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F746B5
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770584; cv=fail; b=J/iNYxe2k+7uL49GN+tThw5l8gK73ox/GKA/lXujzv1MjqyhnbgZTg6qLpRlXzvvctsf2/BMPY+Us6jBxQec3JGXXVq3p/Ho3l8z20y1zFEMRsl2gdcd6VaKjzhHJ6+6WCDlJdwBdii/+UA+6hqPp3I0Q8V0Ft8etPCplZy2veI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770584; c=relaxed/simple;
	bh=uMsuyg48nx+tVLh02cYZlFqTctZw3zgIimD5GZSGXHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R94d4mOTngVJ37Kx4L5XjD64pvsLNv+i6oA7T9iXHk7U1fGTrM2gmBpx1ItSpt88fXl6AIJYAx48TplwZr52PqZnKfgEJoa6ApcsKqiod2jDB8a+53c8L7jkhpyfVTvxyeMpIX8aX87JEWWi5PCKmbyGDUJS+CYvLm/6ArYSiPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Rf5y3eyd; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Rf5y3eyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i87PRz+zM+dxCHAsJyf+sTyJ64GTeuktbUGdsKEdOU/cpDu97dwxM1BivMqM+0L+KKtoYFkYmUo1QQhEwFWCvj5VrXLfTGMMBkdFHE7KYrBPLj471yXUG7xM/+ZSpO8G+4NpeK9uvEuMMJ0xkhIECpTI3wmXp/FC8XnNJDOE0jEKOBvIA2bKBoFIfoZgKyXRKhO1NT+jmcawdv2pqxvo1MIkrQ7Ncw2OkwLhvHV8JKe1iDaBa+3Px6URDhQy1rtbnCfklvvpVvO4CMrf5dweb1yUH8EDvCrZpYN6yfrdl8VwU/UkkdNL+Qhg3T1uGirwBgWbnKONWPxgamI3VGVLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUPWRmz4tCYTdBYlbzJigF3g5ydh60X/Fni/JXz4Yjc=;
 b=kIddSmgo3LDCT4z1AgxrF+rchnIScI7YRiITxsmo7iFBM9haMAjsbgUkbgLhvaWQapktpJkuKvC4DJ4gs/1lQKF7tvk4Ntk+kWw9XrK+mKcHAQRHrHagnTmh/U0N7Hcfm4p1tth3JgFW2FVheGoTcaKFksIQjlY8qndOmXP5U9KdqDx34mlHidGya2B9AAfALCRcv5xWPUlQ1eGn53kmdWTqm3UKktdx0f6IooaJdLesLLOYevw/k8B6sDUrBp+PNeKRYpYfU6PsAXVL+Q0lhvjrrZTFRJMNcwVeT9zKu+db2bpfqA+mKRa7IoU0xtJMWKF3NScUdfmOlyjZCFGgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUPWRmz4tCYTdBYlbzJigF3g5ydh60X/Fni/JXz4Yjc=;
 b=Rf5y3eydtmEIpnCUdq5LmGxmbfVMpMPDVgxHYMO30C5T1+8NZFZHSz9ZZd9R+Yy0tgAWNNGOz8HqVU1Sfkaabn+V1+nIVNiroaPXQXji9STxwuy8LH7FaaZRN2aoBc8AX65LOEJlaULYU32BAnAx434MxsqIbJm+kZcQedTlFVHM43BbzbfiSFOQQEMNsrBMHoKd6vs5aIqfKR9dihozOKJC1klwd+uyT8u0ZJ3z1VfxZURJ5JuSDRKeBrAbNK6Gx9HQAIOg43tpIfasAygHlV4USw7X6qCngaG2YIQewxYKhkns/oyvl0Q6M1TwUJYekNhl5kEH6UrYG3ELhTsfVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.9; Mon, 13 Jan
 2025 12:16:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 12:16:20 +0000
Message-ID: <82a756ae-2320-43bd-86bb-2bb66122ada0@siemens.com>
Date: Mon, 13 Jan 2025 13:16:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cobalt: Add missing access_ok checks
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
 <eaa1b565f740f337b62cb18ea2217e0b8c2cb69b.1736678909.git.jan.kiszka@siemens.com>
 <6f9ca8871d3e9e594c0620a0f59f46f64228d6ac.camel@siemens.com>
 <85736265dfcb90e4ad1d2c70d61408f48217e9a7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <85736265dfcb90e4ad1d2c70d61408f48217e9a7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::48) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc1ad95-4d00-42f4-d700-08dd33cc1697
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVl3V3hQRmxXY05mUUtoRnU5TjhKcjhiR3VUZjRod1ZPdlVXYmU3UEtHTjZB?=
 =?utf-8?B?MDZERENjQ3Z2RXlNTFlFZFp1WFExNmZoc25JUXFMdjJVcld6SjBacDhPN1dD?=
 =?utf-8?B?ZWk4UmdxSmw4YXVQeVhQaThDMUcwZDROcDQrYlB3SG5UWkRsbmJ1ZHM3eEdq?=
 =?utf-8?B?aDdEdWlvU3RGUDBWZmdhazA5NTU1di9yK1NDdDlEK2RSK04rSExLaXVXVGoy?=
 =?utf-8?B?Z1E1M3gxc1dSZFVTWWFsa0Z1M1M0NFZBdWIvbnZhT3dFYW9aUmRaRXZIRWE3?=
 =?utf-8?B?b2ptZ0pOWnd5V2ZsTEZlakF0VWE3OTE4ZG05dDJJdWNlcGlJWmQxa1NYK2Jo?=
 =?utf-8?B?Z2NFOEJiNE1yc1YxM0o0MVVMQlhQMkZ3a3F3SC9PR3EvbjdTcEVmbXZpWFZn?=
 =?utf-8?B?b1oxS1c2MnJFT1cwLzg0elUxYUgyNnJMVWdnNTB6REd0VmdCd3BMYlVKZEdY?=
 =?utf-8?B?YWFYemgwUVRkZmJNWGtaZVBGZGxBKzRmbURqaFVzRVpVbHlrQXVIU2I4bmhG?=
 =?utf-8?B?MzFzNnVxdFduVTVCd0ZxdVpBOTI4Z0JFYXdXMWFzY0RkSjU4OEx1ZWZWazAx?=
 =?utf-8?B?WjlKYytlQWhhQlNKM1hCbzNKamNVU3N2Z1VvdmYyY09mUzJwcDdwQlFyUGlv?=
 =?utf-8?B?Z0lSZjRsd3V2VlA3cmJxQlF5bWg4aG54amEwalZtKzJOZHF5TzEvUkMxUzA4?=
 =?utf-8?B?RkgwRFUzS3dlbE9vSDVpeWlNMWQ4VGtpUEFVdkxqVWdQN1RnWEVneHpldjk3?=
 =?utf-8?B?RjdsYmpaUE1OaUN1cEc3eHZ2bDJVOXM2cnh3dEU5NHR6MlQ3WnpYemtKNURi?=
 =?utf-8?B?UW5yeGthSTg2TjFOVllGQW4wYlJ6alB0ajFDenVGZExHOFJIZDBsSXNpdTcy?=
 =?utf-8?B?WUo5Y2xKSXU0SVJlMEFZUHc1SFZOY0ZFdHpCQWFYNzc3U3VkRmtJQmxQMlRS?=
 =?utf-8?B?dUp5OFlEWmhXaGw0L0w1MG9sLzRtQXV5ZjV1RysyRmN5T245RTlIY2dOOEMw?=
 =?utf-8?B?ZE9kb0ZxRFNhSXlVZFZYZ01wV2lEbWY5UnNYYWtqTHByMFA0MGkrcHNCZWZW?=
 =?utf-8?B?cXZSZ2ZXOVBhd24xTXBreGpra2JUOXdHTUZCWUZncGs0QlZuSDZhclZ5Nm5P?=
 =?utf-8?B?Q1E0TE5ucFlOWGFCQWtPZlZhdStvVGxQZ09kRGNFUmtHellZRUd3Z1cydEJ5?=
 =?utf-8?B?UHIrUyszQnQyd2hqMmlha0xpRVByNjFwWlJRNWY0aTJYMXJRcVBDTWl1Uk52?=
 =?utf-8?B?T2VVdUN6aU9vQk80NlZ6MzU1cldiWmhucXoweGJwYXdScldpaVJPVjh4a0lH?=
 =?utf-8?B?K3djQnlIa0Z4WkNmMUdlejFlbFN2YXVZVGlnaTJCek5lQW00elNaUkNFcVh0?=
 =?utf-8?B?ME1zRS9JT1JUSWZDK3FRQkhVckVPM21EVWF5NzNYcE1KNVVNcFRLVVhIK0lF?=
 =?utf-8?B?SWpnVnBMS0Z6VGQ1U3Y2ZXp2YTVnNXcrVmFKc1BjRGpoMmlsbmZzd0txd1pY?=
 =?utf-8?B?d056ZVVGQTVrdjNiUzVmakJyNkZVYnd0WmRTa1Rjdy9rZGtFaktyeEdqenJQ?=
 =?utf-8?B?WmRwQWRpeHBlZTl6WnJ3eTI2MXJIaEhuaDYwRDUrSlhtS1Y1Rm04WnF3VUli?=
 =?utf-8?B?K0ErUkVxdnF2VFFKVXRkWFJDRzA1QTVpdDFYYkk2WHV1SE1jVTM5SEdLOTVs?=
 =?utf-8?B?NVcwUytNckFDNlNGd3NIaXd3VVhsUWh3Sm0veGpzbXpVNHlQcjV6U3hMYk92?=
 =?utf-8?B?bEFpcHdLOHdNWU9YYmdUcE5FaVFxSm5JNGZWVE1UTXFQNUlSYktyaE44ME5z?=
 =?utf-8?B?MThvOE9wSGp0R2JzZkh5SXZ0b1h4eE9kaEh1UVFRZ0lMbC9ZQmtEdXJUZG9i?=
 =?utf-8?Q?PZevDU7LPn7r7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkhHVkxEejdueHoyYzFNL04yVkd5cEcxL3BpR1Vrd2p5dlQ4b2FiakUwZ3l2?=
 =?utf-8?B?ZndRLzZxckJEZWF2NzJZUHpWZ3hycEN6Z0hzeHZsS2VZRXdNUk95ODRMNWk2?=
 =?utf-8?B?eVk5Ums5NXAvdk1HeUhRdG9LOGtOdVQ1RWVYTjlZYzJrRjZ6cVZncmZiRE1O?=
 =?utf-8?B?Njk4MzdQVzdmNkVJcDdxT0RlLzNzWm5iL1ltRUVJMUcvd3hrdzYxVzlLL0ZD?=
 =?utf-8?B?S1V1cUZBNUlhN1c2RVdWQzFlakdnQWhqVVdjcTZEcnIwTDBNUzJhWk5oeE1Q?=
 =?utf-8?B?TzJ4T0RpMWowelprRGRMTXJRYklTYXdPZ1B2TUtvYWdVdmtnNDE0UWRjaDha?=
 =?utf-8?B?Vm9zSGdwbklZMmxQSzJ5a3BkVFU0MHNIM1h5WHQvRW9INVFnc0pya2RpYUhQ?=
 =?utf-8?B?and0UVhqSWNyT3hvVS9WZ3JyZTV0a2VORTFYZksrYUltMUpmbnV2aWltclFh?=
 =?utf-8?B?MXJyb3A1dVpvRmVPNmowbm55S1ZoUmtNV3l3NzVhK3BkRmh2L1NvUE9IOURa?=
 =?utf-8?B?Z0VWMDJ6ZU9rMlZnbXRLRGxYQWNGM2tDeWl3Y0RJZjlSMWRvd01hWURXZkRY?=
 =?utf-8?B?L0ZEekd5ZjBJb2E2bTVSTkkxc2VwazlRZXRIUlJhOUVyeDlkODI4YnBDWUdp?=
 =?utf-8?B?YWQvZW1Xci8zckU1b00xeGpyZVAwVjNBdVg3T0ZwdCtGWVMvekFpcUpHQkFo?=
 =?utf-8?B?QUQvZzI0VHhLaVVkNVlTbmY3b3JCd3Mwc1dHRWZVZlRSSlViNVYvZjZ6UHg2?=
 =?utf-8?B?Uis0eXZ4dUhEL3NFOThCQ09ZbUVnTWNBYmNIdkoraXlnM3JtUkRMS093cDF4?=
 =?utf-8?B?UHdvTkJRM3diU1pPdG1PTkJTSUgrVjFDM0hNTFBNV0cwWWpFWHpJNXRmOUxx?=
 =?utf-8?B?K2pEYTFaNERrODRlZkIvbWJoWWc4MEE3Q0gyMmpGeDltVFl3R1oxOE5ZWm1w?=
 =?utf-8?B?Y1VtYXlacXlsYkpWNzBVZ2hnZFRoT2dBbW5WT2o2aTZveXN1eS8vWjdWVnBN?=
 =?utf-8?B?TGlNRDhQUXI4UzBTZGJid3lSdWJPT1BxM1c3OWZsWGp2MU1ucUVmYTV0c0wr?=
 =?utf-8?B?eG9ndTdzWUxNTGRqYWJxWHlhMFlvMVc4ZW9xdXV2MWlYOUpVa3h4UkpUUGdT?=
 =?utf-8?B?Q1hKQ3F5TjFKRWxpMVJoTVhlMVB6bjNGdUhUWElOY1VhR3d3TXlUZDVOY2pX?=
 =?utf-8?B?a0dOWEZmalNQVm4xRWJGSEl5M0dJd2ZQTlVYMS84dkdVZk10clBEb2QzK2tM?=
 =?utf-8?B?TGdsTVhVKytLZ2Z2LzlFMG9WVHQ5UVplZVNlVTJCUlVCTkZhaGlmQlJCeHNI?=
 =?utf-8?B?Y0F0bVRMZnBmNHpWdTdjY3dITkd3bXMrazgwRzM5NlNEVk1rTUhPWm56b1Fu?=
 =?utf-8?B?bHBxMkEwMWZQVDUzMlBsODVWSXJvUlFyeEhMcklrTHNacDlySzFFaDQyK1Y2?=
 =?utf-8?B?MnIvNE8zYlVRT2pXQ1I3b0Q1UHdFUHQ0TGQ0RW9yT3ZvaWp0S2xkV0dxeFhy?=
 =?utf-8?B?RjJpRFNhMEtUaVZ1WkR0WGxlZXZzbFNyZXhzSDZDcDhUQ0FCUnppT0R6d3lh?=
 =?utf-8?B?cDRncDQwZEZsYjJlMXQzNkNHNlI3V1pHVFQ2WWVIN0xXOW5BVmVXUzVDbVU1?=
 =?utf-8?B?bWxCYU1YVXRicjNYUFdZWW1FaTNmcFBmaVA5cnNITTAvTU55emdySURmWEQz?=
 =?utf-8?B?Z1g5S2dLSDVySlBoSHVMdHJTM3p6cGNSeW9xM05sVWk0eGdBSTRRSEJPWTF4?=
 =?utf-8?B?WDMwR0Q1cSt3VnZmaFRyajgybmVMR2hBTGhqRkZIMkZnL3BERCtYVlB5SFJz?=
 =?utf-8?B?dEJwZ2RJcVdDeTFZNHJKL0szSFdwSTBTbDhEV0ZkTDdnSHRqOUFGMzJIZG9W?=
 =?utf-8?B?UlRaTG5zeU1kNnVVVW8wazR1UVAyYzJUYmhURkltOGdudUFLdVNGUzdvMi9s?=
 =?utf-8?B?NDFscmc5ZXYzWVl6STkrTnpzQzg4b09XblFxb1dROFpsVjExdHJ6aS9rNThp?=
 =?utf-8?B?MXB0NVE0dUtiM1l4K0pOZ0FnTG9mZDVmSFNqK3dZTjlFOHg2Ui9BMlpmenpT?=
 =?utf-8?B?Q3hqalVLVVdlcVVmdUQ5dDBFTXR2eU0xbjVyYmZRM3NwaGZuQWtnckwxUWw3?=
 =?utf-8?B?S0FSY1d5S2ZnWGw0Q0dnZUIyQmQ1OFM1T1BweStIZFNxSVhRM0F2c2Z6T0Nn?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc1ad95-4d00-42f4-d700-08dd33cc1697
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:16:20.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbXj7gPE6Q9XBaKDtOuXFYDJs/DfRBceiFB7gSOjkaoZaf5NxG4xK0tAOgZQ3ydB0CuI3VVAcVcS6xzpTyol6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6766

On 13.01.25 10:31, Florian Bezdeka wrote:
> On Mon, 2025-01-13 at 10:26 +0100, Florian Bezdeka wrote:
>> On Sun, 2025-01-12 at 11:48 +0100, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> These ensure that we are not using an invalid address range, possibly
>>> writing to kernel space.
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  kernel/cobalt/posix/io.c        | 2 ++
>>>  kernel/cobalt/posix/mqueue.c    | 3 ++-
>>>  kernel/cobalt/posix/syscall32.c | 2 ++
>>>  3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>>> index e581ec6db8..722f1ce20c 100644
>>> --- a/kernel/cobalt/posix/io.c
>>> +++ b/kernel/cobalt/posix/io.c
>>> @@ -146,6 +146,8 @@ static int put_mmsglen(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
>>>  	struct mmsghdr __user **p = (struct mmsghdr **)u_mmsg_p,
>>>  		*q __user = (*p)++;
>>>  
>>> +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
>>> +		return -EFAULT;
>>>  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
>>>  }
>>>  
>>> diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
>>> index 853aa6cad8..34776fe6cd 100644
>>> --- a/kernel/cobalt/posix/mqueue.c
>>> +++ b/kernel/cobalt/posix/mqueue.c
>>> @@ -1031,7 +1031,8 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
>>>  
>>>  	cobalt_mqd_put(mqd);
>>>  
>>> -	if (u_prio && __xn_put_user(prio, u_prio))
>>> +	if (u_prio && (!access_ok(u_prio, sizeof(*u_prio)) ||
>>> +		       __xn_put_user(prio, u_prio)))
>>>  		return -EFAULT;
>>>  
>>>  	return 0;
>>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>>> index 793bde1388..484f059844 100644
>>> --- a/kernel/cobalt/posix/syscall32.c
>>> +++ b/kernel/cobalt/posix/syscall32.c
>>> @@ -605,6 +605,8 @@ static int put_mmsglen32(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
>>>  	struct compat_mmsghdr __user **p = (struct compat_mmsghdr **)u_mmsg_p,
>>>  		*q __user = (*p)++;
>>>  
>>> +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
>>> +		return -EFAULT;
>>>  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
>>>  }
>>
>> That all looks OK, but I think we have two more missing access_ok()
>> checks:
>>
>> posix/cond.c: __cobalt_cond_wait_prologue()
>> posix/monitor.c: __cobalt_monitor_wait()
> 
> Just realized that you folded that into 3/3...
> 
> Fine but slightly mixed, but as it touches the same code...
> 

The spots in patch 3 were missing any return code check, not just
access_ok. Therefore the separation.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
