Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBC2F4328
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746530; cv=fail; b=GAYgUHpT32nYduzvYmuc9NDWZeqHdtlw4ibg7pGo+LzE+iw9ZhrUGaU2NwJThWfLSz/gn1T5m2oy8icEny65s42HqkCJrOWRSpZ0tjZc2q2I+b2fZT44uL1XwXByQUQeK6wHn9+r+yDOVmIzXvY4VamOVN4rV3wmWI9Bp1ZvfnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746530; c=relaxed/simple;
	bh=7xk+wunJ+xIkMDAllQrantBawAfiHfpHnPjuSnPx71E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=B6pQiQfzbKjL5ZHkDnflXykTAxF+pDYCgp+EVg0ZOSRGaXKXW6e0Ppgs1BGGIRhzMh6jZVmMtFBDQss3J0uT5h0Tz8hWEenW9o4/tKE0ZCWr9gUyxlZk5PIOKnQTsUYbpLqAWt9Hqg4JM9RCqnK8aVwNj0jji+gN5QlArHEmYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=naAbdlCx; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="naAbdlCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQID29+9ZMAoAGOO6+bf0cRZ1i+lFom60Z/wZv/yWjY5sDiWyNyYqXQM2WCaJrwMerCpUraDC+vP4OEE8w2y6+nG+S/0nGIB0d74czRaPPgluwhS3JAfS9K1Ji16wiED5mRRgmLuhnstLIusNqHQPil/+hNc3U98nlSurcenNDOssvxgTwxWsWbWqXUP/odOZbffxi1vDqzi441dFRnhxijm0MTFc/ns2fOk2m+Quz24chdJF36m6+UFrOcpvsWx/Wkkx7RjJZYuraMzAalbALsEXV1/qjHoPeAd1YWbbScvCtskacIJCllDx3uiMahv++oAX3f/2jht2AbBEE7D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8GBjM0qNIHT19cBtQ+Am+++8J0fvnD/2NU1sk5Jloc=;
 b=w29v04kO04dUHNys2F0pu767WaxsBRdnsRpz6NF0wy+rM5B0WeFMTF4H3Pxw6kORHXWv1EYwkiqYmk5UmwGpvsNQO+8HaOIp+FOGE+WpyxJlYWUL/Iz9bhnr+xVI7MJ2+j/7hsKW9Bd6EWpRPxe5n4Q5UmOOtVteqEEHoGB6gtQoU1Ry8eE9oUHJSg8eWyKiMso1V857pVKFWEMt6pXQWPjMNCbO03NfBJn9eACS/cxsrSlsVLcGfLV7iUQ5VKW1OBqgNe4Q2zUMdiEpmCKhJf/GCrYR73cSF6UGawInbhBJamutd55DZB3u+tRfV8T2+LpZfChii6gQFGS2tWxkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8GBjM0qNIHT19cBtQ+Am+++8J0fvnD/2NU1sk5Jloc=;
 b=naAbdlCxhIhrV0tmywW1Fk9YWVMH4E8IwurKFGqyOCbEAzMEjDjBG4vgKCI3l0tbPz73NDuSIxbx5iVQ57FzSQ6+AYZZsCukpo1lJVqiX4eWsx52SbymZva9Ms0zeLdTqL4VEM+h73z1AZkrwHAZeKNnNJ497VDZIewtB1ldQodEDa3JWXuRxXkrDbPgCeTOXdvHffnWuSxi0XzPSbNKwN5WANr0YeHvjrw61xO/ge6S6/A5JOllrAfbRgLtodRPTyAypTkXxnK/aAvpeMbzi5QklJG9KFMxKWdJ/NiXGY4sPdeHEMTKm4ldn2pN+EcZJRoC0ZOraMFv+xAyWTRk7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3204.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:42:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:42:04 +0000
Message-ID: <86f24157-0a4d-4ea2-a11f-b25e9ac16126@siemens.com>
Date: Thu, 12 Jun 2025 18:42:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Kconfig: Fix kernel and 32-bit userspace
 selection for head of 3.3 builds
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:610:58::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3204:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffca286-ac85-48a2-5640-08dda9d00fcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERDZVVyTXp4UFhNUEtyM25KNmhidmFycDJIOWI4KzRTLzNHWFMva3BTQ0Fl?=
 =?utf-8?B?akRXRkswVFBqM0lpcFRiTEZqbEY4MU5vMWJPa1lvMnh5b2Y5QWJYMEREWWVK?=
 =?utf-8?B?TEtGZ09VUGwvbWVqQmlsVTQvNjZKVEVub3FWakZ0UGtiY1NRSGVDTU9lakdH?=
 =?utf-8?B?Nmd1dU5mNnpBOHRGZkxKUEpjSnNTYk1LOFdQcXRzZ21WM1E1SGgvTGRkeVl0?=
 =?utf-8?B?RXlHbTY5Q0Z3QmtCblYrUFAwQUszZ2V2U0xwYlhQaWQ4cE13RzJTOXd0SUtz?=
 =?utf-8?B?b2xCVWtvcFBYYlZXM2hYSDVIMnhFZFZ3VWM0YlFxTUFsVXdTWXIzUGoxNGRy?=
 =?utf-8?B?Q2JzbWJwU1RJV2k0YnF3M2pRUU14aGY1K1RzU3EvcmJOV3hPWG1PUDYxVWE4?=
 =?utf-8?B?MUhXSU5Cb2o1UWdka1dtek5ZU0dKTGpSZXdkb0xxQjVqdDZwN2E3T2hCVUdh?=
 =?utf-8?B?a2pLWTVGc1FnMzR3cnpacWtoZkZnMVJ3a3BYUzlSd2IvOGxEU3ZJNmRGZnZO?=
 =?utf-8?B?VHhYNi9jeVJJNXJlQnN4VUU1RHVzVG1LQXE5ekN1eWpMU0R6NmZiZTlHMU9Y?=
 =?utf-8?B?UU80ZkI5S1RqR3N2WVd2QjIzUEZpT1d1Nk0ybzJwZDdVYUdjMmdnUy90SmZx?=
 =?utf-8?B?Q3JNeElrL2NzQW1zZ04rN012dEJKTmExUGZqTlB6YWFabkt5M25EVkh2eVMw?=
 =?utf-8?B?VTFRWkdjYzM4b3VvMTBFVXdlMi9GdVRFQzBQMi8yRkkxMVlZQzkzbmU5MDhL?=
 =?utf-8?B?ZmdaQnA3L0lWRkZNbUlZRlVpWEZRSUFyS1JVVWdHR0hIK1NFNmJ5V2l6SS9k?=
 =?utf-8?B?VklPUkNIaWZ0bk1KRGFzSWk5Nllwc3UzMk52MXNHVExBTHNSMjQreno2Ukpu?=
 =?utf-8?B?OFVadkdiUmo5NzI2Vjd1a1BlcDlZRmdvcDY2TDhVcWJkSTNZOGRSTDQ3cU1m?=
 =?utf-8?B?ckpmWDdOUTBpaFE4bWtocVpVbXdjYnYwR1NlUHREcEJVSWhtQU4xdVdaeTNn?=
 =?utf-8?B?WlRNOHFWK202VGZOUXBRSmNxY2Ezc1hmSFRDK25jU3ZVVTJxWjN5QWFZWkNO?=
 =?utf-8?B?Wmt6cjhxN1plOGJraThyTmlvNmJuK2VNTGFVYXpUYmRxQU9LYnlYNFhSTlNX?=
 =?utf-8?B?K29RVVk1d29wcjljY0ZrWGZqNHNzMFBZMXZCSUJaZFNMRWxrZVozZFJkNHRv?=
 =?utf-8?B?VnZjNUtOSStoUWpBQk5JOWloWVgwMTYrWEhzVHR3MnBCZ08zNStMSDNQSlFq?=
 =?utf-8?B?VTJJbE16ZUF2am45ZkRXMjVqdTZmZUsydE1EQU1PMno2eXQwRUxyYWlvSW9I?=
 =?utf-8?B?QmZpbk9GSkdad2ZrSm56bnhsT3kvdEdCWU5zMmZJUGROdnVGcVVSdnpGS01F?=
 =?utf-8?B?c2w0dS81TEYzUXhHTHpJYy9ab2hrZkVTNUdxemxqdndFdHFpckxGSlZMMlNQ?=
 =?utf-8?B?bk1nZ2ptNlVOREpjMTE0RzIxZVR1Z045dXdnZi9NdHc2UUFXVVU5SHBhM08y?=
 =?utf-8?B?UjZ4dDYreFlLOExaMVIyVkpwQlRhK2hqZk5uZms4M2VGb2xtMFArQUFGT3Fk?=
 =?utf-8?B?TTFTZklKbGJzVVdQWDdteE82VkxXUFlBZnN5aFZCTXErZzRYMTRBcEM2Mit6?=
 =?utf-8?B?ckRJdm9FYXBoNW11TU8rZHE5MmV0Q1EvMjVnTmduUm9ZVmhpdGhUU1JQZkd6?=
 =?utf-8?B?MGlhUy9lVEhFbVNmeEhzdS9QRlIzeGdIL3Ntd3FJVXJ1UmZZQ3g5Tk9seWNK?=
 =?utf-8?B?bGMvU2l6bjBONGFTdUhjZkY5ZzZhUytpQW9yUkFJcVVNMzczSEpWZlpzbEMy?=
 =?utf-8?B?NHZNcDV3ZEFlSGkyUjlFL21Ca3c2ajc5QzE3b09FVGViQk44aFlKWDJMamgw?=
 =?utf-8?B?L04rRTMzbTVlQzJET204dmxKZ1NXVDZSUk1XZWtJcjZxY2o2VG5LUXUyU1BG?=
 =?utf-8?Q?u9rPBskdUHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FyUUhpbnJZeEhlam11eWRFRXpiY2NmRFF2aXBCSWwxcmF0U0MwZXo4aWtV?=
 =?utf-8?B?Qm9sTDZ4NGZ1RWh4d1dlemVkVWtSNFpIbVJzczVobHdXQWQ5blhqTWdpeGdX?=
 =?utf-8?B?N1hSL0tGNEpuQ0tjTWYxWmhDUjhUa1hUWDVOUlJxUHZSanBtR1ZLa2EremZB?=
 =?utf-8?B?d21jOWx2UTBqY2w1Q05lREFJeWpQOHREdlpCY1l4M1h0QUJmRGMwV2lSeTlz?=
 =?utf-8?B?dlkwNGw2ZVRuY25pMFFsTTNsMXpkUkNjSGJ6eFo5aUFueUxGOXh4bWZNenRq?=
 =?utf-8?B?cHZkUXZEaFlWdjNzSjBuV213WkhNeDhhOXBDRUVsNDF6S0FnL1FJRVBaNVJU?=
 =?utf-8?B?blcra3pqMzlWb2FWc0RHYUY3S004V1pYanFGMjNlTmRrUWFxU1JaQ0kyQ2xS?=
 =?utf-8?B?ZE14RHV4YkNPYWJhMFlKeU50dzNWVHRMaGs3ZWhaLzdQcG1nY2p2Ri9KS0FC?=
 =?utf-8?B?ekw5ajdnbUhBYWRTcm13b2pmWm9EUnIxR0s2a3h0b2xDdUVhTS9MV3NqaUZH?=
 =?utf-8?B?SkZiRG1TQ0NpdHdoZUJFMnVhKzkxWXA4NDFFMXZmUEFRSk5CK3ZxZDRiMHVx?=
 =?utf-8?B?bUFlTXV1bk40d291Y0FjUjJKeUt3ck5YbW5NdnNkQTNsNE1nWFpLdlNSOEhk?=
 =?utf-8?B?bzFxaThZTXZOUG8yTmFyRTNDekordUJ0VnFBUHJ4NHh0V0tjcHRhaDRQKy91?=
 =?utf-8?B?UklyNWpyMzZXZkRUK1NsZEtodlNkd1BqcVNnUElUT1pwdjc2ejc1cmVtM25R?=
 =?utf-8?B?QStoRkI2QXNnMXJEV3lRQ2gyTG9FRDVBaUd3eVNjU29BZjlIZVRtcFJ1Z0VP?=
 =?utf-8?B?SStKMXNzTkcwTmNyMkpLdHU1MUw1d0NwRVRrOFRGNk9xTVBkOTFvNmYvMjd5?=
 =?utf-8?B?cFBFUzZLbHoxWXhQU1NaTG5PaFlkWGpvQVFvcmV5cUhTSjJQNXBMNXpDMnRr?=
 =?utf-8?B?UlN2Z0pFRFZIalJ4TWdzcVl6emhsZThVSzZ6dG54aHpRZ082RlY5ZVNVMUFD?=
 =?utf-8?B?NjN4OWV4NWpKdi9MOXFHTEQ2bHZjK3ltTXNXVFF2RitjMVlWOVpjVkphaDJ0?=
 =?utf-8?B?K1NaWlJkUXhKVDhTRkFZbzZxOFVyN1ZoTGJONUI4Y2RGbWVHQ29qN1UyS2tn?=
 =?utf-8?B?OEE5a3BHU1Z2THV2VFFwand6M2JNRnBpOUw2TFhKY3VXUXVvaTVoY2tTamVs?=
 =?utf-8?B?RDJsSlNCWW9BVXVkUUlFc3FRS3VPK3FYQnUvNUJUb2NwK1E3VHZQMG51aEJp?=
 =?utf-8?B?YmRzbTcvYjlzMVZwSGFZKzB3bDNVd2NCVUxOb0p1OGpveGh5WmNVQ1dUZ2pZ?=
 =?utf-8?B?bE5nNU1Ta2lOVkgyZjgzNnZRZVMyRXlXUVdIRUkzc3RaVm1iSkgxcG8zL2JB?=
 =?utf-8?B?M1BRNWU1M2g2UE9ISlVVU2xydDFjdUdDeTFIdHJmMnUxTGNMQjJwT1BidExv?=
 =?utf-8?B?K3FFa0cvc2VBTU14dkpRbnJXbjB6b1IySThkZlhialh5VjNyT1dyd0VlVjVj?=
 =?utf-8?B?STNYZHpBOWFKNml2aysxYWNMSUd0UUJVbkVmMVQya0FnclhVZHQ3T2lkSDA4?=
 =?utf-8?B?TURWUkYyaFhSYVlnYnlwMkZVU0hraXl4eUovYUVkWDcvTTRSYnBsNDQ3ZTl5?=
 =?utf-8?B?VXVvWDM4YmdTWGIrNkR0ajdBVjJkSGpXZ1loY1huMFhyVjByMUQ4cU0ycjBm?=
 =?utf-8?B?RUV1ZVY3VlYzY1RSVm5PblFhNmR1TzEvK0FJaDNvd2RKVGhHd3dRVEs4bWJC?=
 =?utf-8?B?VWZMeW53QThKenZBNjh4V0tUQlFZY0t6TUJlSG5qN203Q0N6bmdaYzJUUmd5?=
 =?utf-8?B?TG1kT1N1SkVSVUM3VHhUVkRUaitySEVBOG1RSno5RzdLekQ3QnV5NEc2WWRs?=
 =?utf-8?B?c2dhK3NvREpVd0RSOVVibVJZcXIrSmVBZE5SaUYxWktPZEhyeGNEcVk1UmM0?=
 =?utf-8?B?TUpmNWQ3WGRXbG5oc0FhQko2NnRTdmgzdU9vMVVFSG9zanA0V0UzQkdwOFVB?=
 =?utf-8?B?ejhBUy82RHNMQ0JMN3REQUdwei9LZ1pQdkNxWng2QmVWd2lIckhTc0pESDVU?=
 =?utf-8?B?YWNlaG5oRk85cHBUSG9aM0NPYk9zY2NkeUFUajZXbHY2bWRPTjlwRS9zbkQz?=
 =?utf-8?B?SG5LTGVZQmIrYVpzM3JKcklzZHVGWFd2akNoTDhxMDhGNlJRMXhLZzZteUdw?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffca286-ac85-48a2-5640-08dda9d00fcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:42:04.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYUK0/MHdtEdM9ZG2WGNKrrlLmbi2q9ywDDj1PqNfF719L9JEMAuiGMsicA4KGPdUz+5XM7FnBcU744YaJ/CXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3204

From: Jan Kiszka <jan.kiszka@siemens.com>

Wherever latest 3.3.x release is an option, head of 3.3.x obviously is
as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Kconfig b/Kconfig
index 3bcf9ef..14bf12e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -117,43 +117,43 @@ config KERNEL_LATEST
 
 config KERNEL_6_12_LATEST
 	bool "Head of 6.12 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
 
 config KERNEL_6_12
 	bool "Latest 6.12 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
 
 config KERNEL_6_6_LATEST
 	bool "Head of 6.6 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
 
 config KERNEL_6_6
 	bool "Latest 6.6 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3
 
 config KERNEL_6_1_LATEST
 	bool "Head of 6.1 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_6_1
 	bool "Latest 6.1 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10
 	bool "Latest 5.10 Dovetail release"
-	depends on XENOMAI_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
+	depends on XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3 || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_4_LATEST
 	bool "Head of 5.4 I-pipe branch"
@@ -210,7 +210,7 @@ config KAS_INCLUDE_DEBUG
 
 config COMPAT
 	bool "Build 32 bit Xenomai userspace"
-	depends on (XENOMAI_LATEST || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
+	depends on (XENOMAI_LATEST || XENOMAI_3_3_LATEST || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
 
 config KAS_INCLUDE_COMPAT
 	string
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
