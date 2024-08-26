Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FD145A01
	for <xenomai@lists.linux.dev>; Mon, 26 Aug 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666113; cv=fail; b=DVdtzNFFh11mlyeC/6YCxW+KkX5zm98X8vCtK3uSEnYu8AE5ZDPqrkFk+sg36uzvhCMlrA8Z7CsoEkQwBYbOALNN89JaW7KNRSmI3BRYtSX1WMWfxCcauEgIeTsWk8TFUxgfbaTLQg2ZTrkEC6tfKPQgXgLJB90u8teZjYdAQDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666113; c=relaxed/simple;
	bh=HXplT+NwqM1/HbUr0v5ZiwI5NmWkssbxrCjzmYQ2Dbk=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=fwWSr0pWsDPPLPi9I7F4gT1LAsjMr5NbZZaTEd5K3v1zuVJ5XISjgdWWKWAsGr2zM9mrP+KIDQNTl0VgMiIemkBlg4CCbUoqfmK96XWfA/l3R5hLXmxBKfXLQSuJ2xVqEYdpffhvhgrQ2w4KoNjQxrMH0WeHPqOzcH7Kv+Mckn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HfpACIUE; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HfpACIUE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmRpbxHbV8u5YCUu92IoGCCRtc8WcBJ6aPFlPsCAD/HWVKheh5O+mpjFETmj8XNZHkl2H7OhlTUUmfm7yQo7Kjzy1cm+t1o/SjCrFZXLWNRCGSULMpla+MFkXclsiZCF0qGikGkc7w988+LWKbbmBDQAAfzyFw2DVHoaWagKCVjqni/KqfMHca50K78XbMuUjLJGvUIaKeVLKYje6pnHefJCv3Ytj07hfTAdFE2LOV7fG5b9P7crwL3U7L1HDC6lScK6ByKm54CVn7hOcupvdXtlBNM5oAHNoAmDnT8Z9MlqhrK4OaSt06SwfDUF5EVDF+XQ+7En8CJBgErWkz++iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HopU4pGxWI0kJkmunvhHRTNDshHFplLuU9dulk0msXY=;
 b=HrkMv3npYySnN4Be/YcU6Ji3FkIQsjIAfIVVPRETM6MbGT1j5jrtj1V4PIz5PdcLVFae8OW0sHvzHRbktRoECgPvZLu7ykJXx9fTCavCDSR8uHR4RDFRdq+OST9ESJ9qCzOMR4Inz05tE9TeOdZ1LiceF1rSXcaOo9InH6tUhBuTOhpZLo20waEsXAbmyQD2gPAJJ/EyqX/f37sU4nR9+ZkaZNXuK8ZG0oWY/uTvnQnl3CZsNoW5Iz+BMT4CmRm9PQtrtDBf2BDhb6a1T0D2g2MbhnmTcrsDvGgE7wIUkKiOQYSf5iD9Z29HmZd35wjqoD78Dh7ScT708gpv7LtWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HopU4pGxWI0kJkmunvhHRTNDshHFplLuU9dulk0msXY=;
 b=HfpACIUEWYPga3pAFImwhipmNI7TPj/wqSa08m8Wf2sgZPYLoJKUo3HicYk+WT9L0GyLfP6IG4wi/voibT+J1pSTwko1sHET8/znryDTWSfT1ypdFI4CGiz6VkIlMhOmaiRx5Lr/ARiVFtO/FJWLTmXHL9zzuYbdeBwMv8CYCuzlBxKmaQsOKit+soPNbQzj7ExyBHiqB2w+t5YgZRR+IlYyaqwQxYDNI3rNYZAfOZbIOY991XY62UihDyyrIOXaLlOAQmjzigu53W4qmdrHzoNMgRET8hfqaCviZHVtEV4FdHfuKfV3Xpup8ymZwCy20pJkucdp6DT7n3QRTjNttw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6862.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:329::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 09:55:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:55:07 +0000
Message-ID: <76af86c8-30e0-4a02-971f-c5f190985424@siemens.com>
Date: Mon, 26 Aug 2024 11:55:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] demo-image: Add auditd
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9464b187-0106-4256-977f-08dcc5b52a84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFZmNmM2ZG9xSjlvamJBU1ZMSW14RlM3VjExd3ZBR01VSVlNdllzbjBIdzhp?=
 =?utf-8?B?enVaaE1VR25lMElWMDEwWThtMUlEMUs4VU1Kd1U4c2VqNkZSTkp3VzRFd0E5?=
 =?utf-8?B?L3daVytFZmpHM3J6ZTdDVkVneVBPMTl4eUVJaU1aZ2l4WFM2b2RCeCtCdmhi?=
 =?utf-8?B?djFOYUFsNVNPa09zRXBpaWVPWGM1dFlDMWNFdzZiNUFKZy9Jc3kxYU1YWjU2?=
 =?utf-8?B?SjlrYnBMR1ZJSlFjTmxGRkVpWGh4WmhZUndUYllxaXNmNno1bnJ1SzdxUU84?=
 =?utf-8?B?dDRqdTNHbTJOODhxWFg5RXpMTVFVamg0eUNwNmczSmx1VGZ4MW9pMGxiZFN5?=
 =?utf-8?B?RDU4REM2cENzSFJRZWtRUEo3SjFIU09JaWJraUZQRW5vR0RwdDdTdFNDOGdj?=
 =?utf-8?B?cnB5dlBtZ254Z3NTajlzM1MyM2plVCt1NlZmTENwZmFqQVBnWHkwazhQeUJG?=
 =?utf-8?B?ZElUckxoNWpJdVlMVzZBWmQrbjhWL2xjSk92dVpKcUFYbWdWbmJSWDlzc0dj?=
 =?utf-8?B?MnZNWC85SXphTWkwK2JXNFV3d2N4OENzb2NJcWsxNzQzOVk1UUJjeXczYlg4?=
 =?utf-8?B?UkIxUlpTM1VtdFgyZU5CL3FtUEhUS21sblU0eFJ5QXpQUzVoNm1iOTV4WFhl?=
 =?utf-8?B?Q2R5ZTVmbE5HbWExOFZiendrUVlwd2FFNStMVmQ3K1BLd1hiZWVDLzF4Z0dU?=
 =?utf-8?B?ZmlvN2V3dXphNmhEVFU1L3FuR2l1K1lVbnloSmxaSTg3TElZMm5PUGtDajdh?=
 =?utf-8?B?M2FDOGcxSlIxRWEwRWppUWE4U0E5eTN0RU1hd2haOUlBZFFDbWM1dXl3YVBo?=
 =?utf-8?B?WktOOG9mSCtjNjBpOWM1YUhER3BJRzZ1RW1SeFE1bkgrV1l2V1ZTbnBIbFFv?=
 =?utf-8?B?cWxQVzc4aHJLdUFXa2l2VzFPcElmZXNKNHIwQkRINHZmMTV3dWZ0eVRZajJI?=
 =?utf-8?B?NGJCNVdJWTVMRlZNK2czZGt3amZMd3NkemMyYjgvNklWQjN1ZEdOUVdyVmtn?=
 =?utf-8?B?YnZVa01UdXdmUDdUSlVzQzRIdmVZU3ZONHZQcW1kSWhwSHYyN1FSMHZXVGEw?=
 =?utf-8?B?a3BZYWVzc0hGTXFiTVNKc0lOaGRQdUVwV0w3TUxhU09mWDZUejdYQlkyMWpJ?=
 =?utf-8?B?TFFYM2VIWjB0d090T3pPL0xMUzdkNk91eU9vSjl0YVpxaWpoT1VxMEpCdE5t?=
 =?utf-8?B?aUlpdEplb050MXZQTzBOb2NOdEt0R3BBVWFEWE9QVG9RU3FTZDNjekpuUFNL?=
 =?utf-8?B?dHl5R3hwY1Jpd3BMU3NoSm80a2lraXQ5NkZxSlJZUS9wZVMwb1NXUVRvR1BV?=
 =?utf-8?B?Qk9wL0tHeUgycHV0NXJFeTV6d3VvWTQvTmpoYzZBczN2VzBUc1NUTHlrbWJX?=
 =?utf-8?B?ZUZlWXlNSDZyRkZZNEpPYXFOZTdDUUVKUVJOT2laNzlzOWp1VGVSYnEwTzFP?=
 =?utf-8?B?ek9hbFpZVTM3N3ZnTjEwSEFIQkV4OUp3SUNrL2F5Y3BwK3o2alR2U0RJY2Y1?=
 =?utf-8?B?LzhjRFQxajA2K0F4ejFCaENIbXdMM01wNnhDY1NoNEtLSVAvQVBYcWpKRWpR?=
 =?utf-8?B?ekx0R1pKVm5wZDd6OHhiSmpiMUIzVkhxWWs2c2tQNkxlaHAzeFVtT2VkUDZw?=
 =?utf-8?B?Sm9HRmtqNnpTeXlhYjA4SkY4eG1JcXlEZFJjanU2SEFjVmtxU0NFU0pwdm9w?=
 =?utf-8?B?a1grei95L2dmN3pSbUppZmdGTDlCS0d3a1JCQnZYRFZZQXhlYWNpNFVINm1O?=
 =?utf-8?Q?qbk6K/kANHOm6ef7eI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlFsNzNRSEUxdHZYT2tNRGVhMkdSRnNMaWlXMi93VG5IUExZWTc1OUF3VXln?=
 =?utf-8?B?OUs3M3NZTit6YlV2Mk5aQkFaZHZOMDNEdmgwTGczTjFJRktmSjV1SVJuL3ZS?=
 =?utf-8?B?dlJxYUlGZlRka29rY3NpSnZwbGtuU1h0Tlp0SC92S0ZiQ29sMG9YZGRjaHpx?=
 =?utf-8?B?TUh2SjJEVldBd2duOHFRZzlyY0hUbVBjUWtXOWhjMEpESU1tUkxlOFoxUFZi?=
 =?utf-8?B?cVk5Wkt1YmFwWnFLcEdMKyt3Q1F5MHFrTEhtWkpYV1RFY2c3ZkFPUWZFYzBn?=
 =?utf-8?B?WjMyNnc2ZU9pTVdBeDJhSElNRFBqenAyTUxORUlEOUtWbDBHVUdDMWE3UEd5?=
 =?utf-8?B?WTZRTzRaU3lLWlB3M1g1OCtyL0VMWU01bnlqaUxqQjlkQnJ3VlNqT3UvVXlP?=
 =?utf-8?B?Um04N3luZzdNaTFPNHd4OGNOKzhDM0hFM1dhUWk3MHdqRUNvRllCZzRLOUhq?=
 =?utf-8?B?YkFwVjlCeUtVdEFabXdYeDB6ak91ZmszOUFkZHM3V2VHbE9vNjRrSm00aXcv?=
 =?utf-8?B?NVlobHA2d1FOMVZLNFlIWVI4ZDBvR1luVzArczlKbXRGYVh6RGI2MzVSUHhM?=
 =?utf-8?B?VHNwTlJTbzV2SE9GY1poM2JaNUNLWGpzb0xBcWVMNUZqQ3lIQ013dmt5Z3p5?=
 =?utf-8?B?MG5ia0puOW1oeGorbVhMeXBQZDVFd21pY3IxMzE1Ukl6RklLYXNpYUVHU2lB?=
 =?utf-8?B?NlUvNlJTWnhKSGx4bnpHemhnak9VVmZ1YithejF0d3oxR0Fhcjg4K3dvaStl?=
 =?utf-8?B?WlpSbGhSNStCUkVmR053VTdEMHBlblV5RDlPcXpOT1crRGV5dzRwUjVzZlFa?=
 =?utf-8?B?amJGRnVvTnNUa1BjeC9TWExjMTFrODc3Y1pITUJoRmZ3ckplK0NaMDdFN1RL?=
 =?utf-8?B?VGdyVTRmUTRDeGlyeUphSlUvWnZIbFpERHR4MHkwb3hKWGNRNDdmeDMwbVBW?=
 =?utf-8?B?VHFkOHBTZXBJckI1bEJtcHZKdDdNemF4a3p2ajdQWkpZRjRYL2k0aTdZM2Jj?=
 =?utf-8?B?S0hnZmJTQ3h3V21vNDZDQncycWxyNXA3TVF0L1lTOXZESWl1ZEliZTJFWGJP?=
 =?utf-8?B?RHFWNGp1cXk1YW54UTFkK1lpZEc4N29UREdjQjBNYU5ad3ErY2Y5UWtLa015?=
 =?utf-8?B?R0hCWldZeUIrOGxKckFNR2lvTW5aWElsWDNmVmp5U2ZLNGxHTjM2ZGJETTZD?=
 =?utf-8?B?THpDbytycWNteWd0ekg4dStiNVRLR2VqVzBvUGxHRmZMd2Q0eStEc0JYN0JX?=
 =?utf-8?B?VGdmRyt6R0wzNG15TW1sMEhveVlzVk9PQ2pPN2krWk10OVhoOTliRmlDMUtw?=
 =?utf-8?B?Q2hNaCs5eEE5eVpxbnZtYzRUbnZQQmVvTUluU3RvSTBvYktpQ3hTQUtZWXRT?=
 =?utf-8?B?aE9XSFlYOTJSMndHdGtvV0g2TEEycHVQUzlOa2JRQlRRSjhTN2dtVHQ0aUlj?=
 =?utf-8?B?Y3hwQWhObmE0K1Jzb0Z6Ti9DbFFNUG9aK283KzJBenRBL3ZjSVJvcmhIeGRL?=
 =?utf-8?B?Z2RDOWN2VkF5bVRuVmh5Uk04dW82aG1NMVJnNHlFNTRwRTdoZ29tL1J5MTJH?=
 =?utf-8?B?YVZ2cVd3UzRrZ0xveW0vSjhrQ3hTbFNXR3k5d3BOeVEzOXJwM2VubU0zYzF6?=
 =?utf-8?B?TWE3M2VhREFWQ00ydzliQXMzM0R1Umx5aVpxTm5LVERaTGx6Z0lvdWQrQTJH?=
 =?utf-8?B?ZU9yd3VpRDZJY1ZkVWV6amxsa0dBaW9ZcS9TUU9TSVkxckEyMEEveDdmK0Zi?=
 =?utf-8?B?NFBEYjNFYlN5THJ4SjB1SnhtUTF4SmJEalhaS210dTRLd2YyK1c1UHFwR0Jr?=
 =?utf-8?B?SWp4MWxVNW1sS2dSQ0JwVnRWQUk2RURLVy9pVnhEdFhDNEN6cEkzMHQvVWlR?=
 =?utf-8?B?ZlFDY1YwOTMxOFFwaDY1bDk5VzBuWlZzZXN4L1dMNmE2ZE9KK3pmbmsvQms5?=
 =?utf-8?B?ZjRsaC90SzFwOHVIZWdnSjdjdFE5a1BMVkdYQXY3a2NxcG9rZUxLVlQvK3k0?=
 =?utf-8?B?Wk80ZDJwUzJWb2tqbzFzM3l6UU92ZFEvOVZDVXRCMUxxNVRGYlBwelJBWDls?=
 =?utf-8?B?WTdxUnIzalkwa3FOc3l1TmFRMVN6S1NzV0tlR01GeitVMmRuZTVLWGJPM05H?=
 =?utf-8?B?QjVqMU1KQjhSKy9yTDhXcTFaUjhaZlNzYmZkT2kxL3RiL2QvbFdmam9QWmhn?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9464b187-0106-4256-977f-08dcc5b52a84
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:55:07.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5ot19/R/mVyCgr1jQwIfmEf48XE2XgN1V0b6WxgI7CTwXbO8V/4ilJIsYSA5dzwN4JInJ4JJIIkvADBpMujPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6862

From: Jan Kiszka <jan.kiszka@siemens.com>

Only when this daemon is enabled, CONFIG_AUDIT_SYSCALL is actually
stressed and issues like [1] are revealed.

[1] https://lore.kernel.org/xenomai/24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com/

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Will only push when [1] is fixed in our dovetail kernels.

 recipes-core/images/demo-image.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 50b6827..241cd99 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -46,7 +46,7 @@ IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
     iw wireless-tools wpasupplicant systemd-timesyncd dbus \
-    lsb-release"
+    lsb-release auditd"
 
 IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
 IMAGE_INSTALL:append:xenomai4 = " libevl"
-- 
2.43.0
