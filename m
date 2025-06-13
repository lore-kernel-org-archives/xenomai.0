Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36172636
	for <xenomai@lists.linux.dev>; Fri, 13 Jun 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777805; cv=fail; b=MSpf6vqhjiNowKLvIIeWEagXf+Y+/TqEsSiI5jfJtai+Z1Ygy1bzc/N3JhoqhBhQ+q/X0f8KgGvKJqvpefIEFzaLbQ3JxKfO1gAcMPF9XEoO4PvmKwfX20ejvahJXu5bLwZlWzCrPqj4PVOuGN0YYNkiL/YYq4degrB2ZLl4VaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777805; c=relaxed/simple;
	bh=aGkjYVp/Yw/UCPEP59Uhm3mewN/wq+PTdPfOcoOkYAI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iGpVqpVz70dhNtN5EsyrDQ/7k52Fq7LjdAWA2Gl6wCBNCGwQ97mHcP7icL/U8Vd5AEOd+rleRl4LwuNtDWQl2LIVTct7mTYVHJsgpkYokhai2W4iC3+DWmy9+SAxF9sc6NXbP7/plHg5aLWuMSDmY7pfvkS6VO7gIrKmkQNXbAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=FwuXVhr2; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="FwuXVhr2"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 4B4BF43ABB
	for <xenomai@lists.linux.dev>; Fri, 13 Jun 2025 01:23:21 +0000 (UTC)
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::2])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7F9337803CC
	for <xenomai@xenomai.org>; Fri, 13 Jun 2025 01:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEQfWXwm4TI+5aOcbuPhH8JtUW1aOSzh8JzzrfZA26u6HsjZK0CJHKHBK+v2K0w/zTPKJZzO15zqKwqZS1T9JE7nka9fNJxuB5J+9GBMj/0iLTs9hvsE3oyyxxD283rXn6B4lHpL8/EWgMtt30/4+h0aXRyDrM4oH1N9+Y3hf8semdnoZfjaQctY/78Pl9r3WskKWCjr4LdIaNh71FuMtVAbuwlvB/2tuhKr/yNNGkU5O0WMe8hiKqehX9iwrGoozTDPhKjSBoqqPRy7qfNONqXtVXYdOc1HIhRCzQl3lqCITKtmFef2XxVvA7Oq7fOnSYVU5kFAc6szXujwCtIRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGkjYVp/Yw/UCPEP59Uhm3mewN/wq+PTdPfOcoOkYAI=;
 b=qyAAalTkwukojyKxU4x/KtfHtc+mtK6DoETfv1hj8wLxjkW3BZ2BuUdlyILQ3EGCaKstDYxNU5ld3O1XKoTfZlmNcQpwg1Is2EwVmz8tqI6rnmNBe+yAgHXHx0nfbIL9z5fmqs4N3ADFAFtl/sQYhFqFTfeWA7Ri2WEVAgj5oXQiERWl/d6UjSjEzbFOIG0IADigIY1p3qrsLVKdIOnzxZVefbaqokm6bCgOBn+lyy55vTL4yH0OYP0uIfUJXtuFqGI9Hk7BvSEKdz0YzGkztwz1yRcJkyYYh6Evngp0X0MFxfWg+wB9JXm5JJOeAVBP9oLgG8MWVD2/dfEe5YWDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGkjYVp/Yw/UCPEP59Uhm3mewN/wq+PTdPfOcoOkYAI=;
 b=FwuXVhr2aG5A/wJ2R/j40ig7sbx7zwzFEXnVRzLAhAuviE/UOoaJWzyXTmMNL0qwvEbx/EyEmgcHLwQi1Hjf0DmLZA8QZ/LUqbh71nslYd+vkq/6iMpmbSSEYyvbgjQqDxIOOjXblqSIPHt9laHi2mfijdtEB+10+HhiA2nxvj4=
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ab::6) by
 SE2P216MB3069.KORP216.PROD.OUTLOOK.COM (2603:1096:101:290::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Fri, 13 Jun 2025 01:23:14 +0000
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e]) by PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 01:23:14 +0000
From: =?utf-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
CC: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?7J207ZiV7ISdKEh5dW5nc2VvayBMZWUpIOyImOyEnSDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <hyungseok3.lee@doosan.com>,
	=?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
Subject: Inquiry Regrading Xenomai Usage
Thread-Topic: Inquiry Regrading Xenomai Usage
Thread-Index: AQHb3AGKbh/KApA6Q0e3zRtgw9vVBw==
Importance: low
X-Priority: 5
Date: Fri, 13 Jun 2025 01:23:14 +0000
Message-ID:
 <PU4P216MB13530BC40F39719E7871C290A977A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU4P216MB1353:EE_|SE2P216MB3069:EE_
x-ms-office365-filtering-correlation-id: e828903a-7fbf-4c61-2b82-08ddaa18de9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXJyKzRCdW5mUjFZYlQvNDl4OXlFc1p5am9pczJCUGhVdm5HNm12ZXZyRWdJ?=
 =?utf-8?B?a2JwT00wd2owNEY3a2RjN3Fxd2tHR3ZNbmhSMTFZUGFTM3VnVTlLS1Bod0tn?=
 =?utf-8?B?VlEvYWdtTmJvM2F4Nk53bkRRTVV4VlpaVlNScElZV2dTZitrOS9TS3laY3Zv?=
 =?utf-8?B?dVRMSWJkU3oxTnkxOERPbmRJcWJjSThCcmcwL2pseCtwNjcrcVdka1o0czVG?=
 =?utf-8?B?VXRjVEdnSWNnRHhFa1dyYndZN0JVUUl2V2FNV05qNXJ6eGtWQUZ2ekZjVWQx?=
 =?utf-8?B?ajRCbSs3a1U1UnV4REVYTkxXSzg3L21RWnI2b0IvUFE3YlVRMnVzSW5JVTlC?=
 =?utf-8?B?QTgrM2hmWUNJaFV6V1RZR0RhaDl6OUpPUHd6eHJvQ3pDdlpiRVM0VGs0OURJ?=
 =?utf-8?B?aFNaUHdncndkb1dheUpicXRPN2ZZanR2SHRoeW8wM3VmVkZscGwvYS9OczRp?=
 =?utf-8?B?YTFZeWhLUHA1VUpwUnBWVXJXRW9mNXZxTDlVYmcyNWNpWlREUlRvM2NUYjhv?=
 =?utf-8?B?TXRTTStDcFhrNWhVWWY3L3hJa28yd2hFdnVmNTY3MFpjZG9QLzdiZ29aaXJ5?=
 =?utf-8?B?UmtSVlNraWhuV2RNbWt0OTZMSm1helVNZWFTTEdmZ1lIdU1qb05BNnJ2R3lN?=
 =?utf-8?B?L1hZckFtS2Yxa1VJb2dwODgwQ0hLVVRkVkNvOU04RCsxMGZ1ZmoveitFMHo4?=
 =?utf-8?B?ZER4TnJDaS93Um1oZ1IvOWRVRFZiY1pKTnIzbjNKc3BQOGtVdFJMM3JKYWhS?=
 =?utf-8?B?dHFkM1ZpeThxNkRXYmE3YkNTaU4zc0I4MGpHWVBaV3pqZlN2YWdvWUJyeDYv?=
 =?utf-8?B?TVFvbkhnSTFTOUVYYzd1cEtzSFN4dGczNktxZ1UrdGtsWmppL3Rnc0VkMWs1?=
 =?utf-8?B?OHJzaFZNMTlzc2pvelg1WGRUeXVWb1YzbVQ0TldzTHBMK3Z1bEhnTTJBTjhV?=
 =?utf-8?B?clNGdHo2SUMwZVJrWCtvZzdXRkRhcndTVTdIYytPRExEbDZwTkdEOUxoRGNp?=
 =?utf-8?B?RHBGS1BzNXJGVEdQdm1jTHUzT3l1WWxyQ2NxSFpIdndEQ3BsZlNVWndHU1Vh?=
 =?utf-8?B?ekd1UEZSMm9sNmI5a2djcWo5cmZReGpwNDNmeGFpTkhhQ2VwdXRKZ0Y0Ri91?=
 =?utf-8?B?UjNvVnliVmg5cVU3WGo0aFI3bDFPN1RlczRWRkFibmlOVDFpZTNWdDZEd09T?=
 =?utf-8?B?alEzR0ZzWjJUVE04NDFZM1VjYUJvVzBYZHpWUTZvY09qSnhXTGduYnBoM1lm?=
 =?utf-8?B?d1JTa3hISlhEOE5EdnJhSU00MGtOZDlCcWZETEExY253bWtFMVJlRnF1MkNu?=
 =?utf-8?B?SFFWUDdNM1gvVTFQb0dtQTRYY2NJejNNUmxXNHNVVVZrTldHeTlGbnJhZjQy?=
 =?utf-8?B?cHZNN1Q4TE14RnN4V09kYk9Hd0FFZWxRSXN2cFgxam9qNEgycnM2czc5Y0M3?=
 =?utf-8?B?ZEo0SXp4dFF0Ukh3d2t4RUY4N21iL1p0S3dvZHhUaytRQThHR2JPL1VLMTFR?=
 =?utf-8?B?Z0hlRkdtanhKS20zWk00VWNKd2FZR1R6Vmw2TUZsRng5WEIvcHN2Y2lHbHpD?=
 =?utf-8?B?cU1uVUIycXZEYmVITVJ4Q1ZWRnVtWEpKR1E3cDZSUFZoYlJNUlVpaWhvMWRx?=
 =?utf-8?B?UzVXMlhlTkFHMWhJWjVZSEVwVTNESkVxUS9tbjl3Njc1Q1RaczR2NHhUWTY4?=
 =?utf-8?B?QUdSNS84S2dMcnVodkFPOGREb2JzRWN6bnpSRGJTbmhQMTF3WE5TdlZCWVk0?=
 =?utf-8?B?aTU4T0MxR0gyT0VRVFA1VGRxTXFEeDlxVVZxS0ZkL1FrNkwzMW9IZ1VUUUdr?=
 =?utf-8?B?WXpqcksrMHRjVXNyVzJMb3o1dFpZT0tzSkpSdHpyeFdDMU16TFdrK1l2WjZH?=
 =?utf-8?B?Yms2V2FxejA4Y0p3TnBoZlhsZTFOSG0xRnVUdENNZUs0RGJmUW9mNDJOcWgx?=
 =?utf-8?Q?UBuWALnI0PloL2Y83KOY7jHaqCBZZL+E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1353.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzR0RjA1M1NpRDJ3aDZzS0VaaTZTMzQ2QVpMWTdlZDF5WVN2V2tuNlZiQ1p4?=
 =?utf-8?B?clJTMWlUN1krWS9BTWhDWDBRUkJ5aXlSdWFHNXRJQVVoK3JRWVV6TUFrODll?=
 =?utf-8?B?ZXhyVVVtaWl6Rm9kQVNOWFB4MmJTWFhSNUxqT0RsVHMrN1FyZXZFd2dlQU9h?=
 =?utf-8?B?YWhFYU9TVis5UTFaWkNVVGdsU0lab3ZjNnBOWkdINHVmRnhpQVZOVm5MRVJ1?=
 =?utf-8?B?Y0s1bWh5RjZhbm5ORTBmZjFZRHMrOThRRnBhZjFDUzZOc1h1ZjlsYUJJVHIx?=
 =?utf-8?B?YkNtZmVFMXRtZXRCMTd0THZnb0d0L2FPS3BnV2VVTWNqSmFod2VNS3BldUZQ?=
 =?utf-8?B?dWtuc0tBR0RINVRoYzU0TThBUzFZVG1Rb3lGaFlrcEtkLzE3QUpidUZPVFJy?=
 =?utf-8?B?MzZ3SHBkbEZ1bUozN21hMHdocWhER2FNU3M4M2NkUkRuK2ZpUnZXRVF4dVhr?=
 =?utf-8?B?TzExZWJtQWhEaFk3NllCeENuRnhCTnkzdGwrMUhONU5iampEdVJEUWZ0L0po?=
 =?utf-8?B?bnpNMHJ6N0dOWUF1bTE0RjFlcEFuQWhXbzk4NkdyNllmY0NSclRJU0QzVkN0?=
 =?utf-8?B?dnZIYXpCb0F2WUU2MGZ4RE5hS2JaWTl5aFZodTJRaGFsUGtDaDRRclNtejNt?=
 =?utf-8?B?dHlaWGZESXRDOEVyYSt2eTVLQVlSOVZML3NIeG9xWHoydTlRZ2lYa2pkb3Qx?=
 =?utf-8?B?Sjh1WG9XcHdFVUFKNUZEM0E3U2hUNkZWb1Z3amNodDlCRFdYajdCQ2VVeDJl?=
 =?utf-8?B?d1ROOHNXaWV4MUpqK1lOck04TjQ3aG9hU2JLUjhyTisrK0hROG9RcmlwRm5n?=
 =?utf-8?B?c1VtZzhJUUNoam1VSDlUK1lIbm9iVmtPdmdMRnVoNTVpTW04QzBQZjBBRlhy?=
 =?utf-8?B?NDQwZDFWMVl4NnJiQzk2eEMrSFFneXRoSkF6SENUdGEvNWZMSlFEcTB5RUdT?=
 =?utf-8?B?dkJtcVluNUREeUlVR3VJTkpnYTR1WXVBdHo1bEJRRzFpbTBZb0hqYXJGNmJQ?=
 =?utf-8?B?VHd5WUN6NVRDOUNLak9MeDErUDVkNUlXOEhzaC9NRVFDaExDMXV4RnB1VnpL?=
 =?utf-8?B?Ymlnd0VOdWJENndqM09jMngxOGp5ckFDVlE5L2xrTnlubE1TL1paa0ZIQmcr?=
 =?utf-8?B?S202NmNXQlBxQ0p5MExvRG5QRUFaK3orbWtIY2YvNVhmLzRnbHljRGl6RWZ3?=
 =?utf-8?B?aG5JNXBSQ0RTQWZDOGNTdzYrQnhNWkN3bnVDbmZMTUFoN2dRMmNXTEpXalVx?=
 =?utf-8?B?R2NQbmxJcG9IZkxPbmZxQVgxOVZzZm1GVURWVVVxQzZ2SHp6RXJ1bVo4KzZY?=
 =?utf-8?B?Q3BnSmU5NTFQelBRWkdMemNlS3V6WnJFdmgrb3lZd1RNS2sxV2sxUkNmay9D?=
 =?utf-8?B?WXhyMG0xT24zZVl0OXZ2bVVKMTlxT25nZWdZVExTdnE0VnNXV3JkVkN1bWdK?=
 =?utf-8?B?QktYcEhTdjIwQjVWOEhabVFTc3dFT0dyWUdRRy9UR3ZvZEhUelBGcUtuQzY0?=
 =?utf-8?B?aThZNFJ6RUZEYUxuU1kyNFlNRE16bFFZVGd0WDNDYnBBeXJzTGlDZzF2VkNh?=
 =?utf-8?B?T2tBNVBZZVhuUnd0YW1aSlJ3QVp1UGlNZ242emVkYmJHVFFKdyszYXhYcE1M?=
 =?utf-8?B?MEl3S2cxeHozMHBFcTMxaDV3eStFbHUvQ2FiaUpIbXE1b21ZdlF3QWtPbG8v?=
 =?utf-8?B?NUpsZnRsSm93WkNYS0RJRHRhV1NDajVMSmhJdGtTR1EybjhUL2plZ3BEb2dV?=
 =?utf-8?B?R2VBWG95V0FBUXVXSTQ2Wkt2eHJMTkN2b1RhcmVjZktqQUJJTWNrMGFpN2Rm?=
 =?utf-8?B?bnFmRURZOUI4OWxDUFN0eUdTQjI4Q1FJVWpiT2lqRUN5WHdqbCtPR2hMRVdJ?=
 =?utf-8?B?QVRISnFFMzhidk1Gb3BqS0N1UDVJOXpDTTZKZGdqWEdqZU5QUktzeGFSZ3dl?=
 =?utf-8?B?ck50MjRpb2h6RW84VG9xK3NGbGpEa0RGT3pDTkxWM2hRWkdYK3Rsc28yNHZp?=
 =?utf-8?B?Q1laZ1kvOGF4emY4ak56aUVvU1R5Wlkyb3ZDbjIzODdWVmUxVytxeTNieGJl?=
 =?utf-8?B?bXhrSm9PQVRQTG84TnRoU0pvL2FYa2prcDg4WFNVdUlVMXI4N2R6VjVuN09N?=
 =?utf-8?Q?jIBFcDOasi609/M9H62W3i6uG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e828903a-7fbf-4c61-2b82-08ddaa18de9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 01:23:14.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJih9z8b/jXdRrLPIR8WG/042QMfTl2CL2KKbUWLpGrNYTB63iUogS2d7HrolhAPjZpxe6ehEqnnnM1NxuQztQ/y/7d/xZMF1PjG076d4yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB3069
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=FwuXVhr2;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=none) header.from=doosan.com;
	spf=pass (spool.mail.gandi.net: domain of mincheol1.shin@doosan.com designates 2a01:111:f403:c40f::2 as permitted sender) smtp.mailfrom=mincheol1.shin@doosan.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduieeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefuthgkrfffkfgtgfggsehtsgdttddttdejnecuhfhrohhmpejmmjjmldfoihhntghhvgholhcuufhhihhnmdcumjjmucjmmjjmmjjmmjcuoehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmqeenucggtffrrghtthgvrhhnpeffvefgffeigeeltdeffefhvddtuedtteevjeegffekueejhedvgfejteejtdehtdenucffohhmrghinhepughoohhsrghnrhhosghothhitghsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvddufedpvdeitdefmedutdelieemfedtudemrggsmeemieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddufedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

RGVhciBYZW5vbWFpIFByb2plY3QgVGVhbSwKCkhlbGxvLCBteSBuYW1lIGlzIE1pbmNoZW9sIFNo
aW4gZnJvbSB0aGUgRG9vc2FuIFJvYm90aWNzIENvbnRyb2wgQXJjaGl0ZWN0dXJlICYgRnJhbWV3
b3JrIFRlYW0uCgpUaGFua3MgdG8geW91ciBwcmV2aW91cyByZXNwb25zZSB0byBteSBpbnF1aXJ5
LCB3ZSBoYXZlIGNob3NlbiBYZW5vbWFpIGFzIG91ciBSZWFsLVRpbWUgT1MgYW5kIGFyZSBhY3Rp
dmVseSB1c2luZyBpdC4gV2hpbGUgY3JlYXRpbmcgYXBwbGljYXRpb25zIHVzaW5nIFhlbm9tYWkg
YW5kIHJlZmVyZW5jaW5nIHRoZSBYZW5vbWFpIEFQSSBNYW51YWwgV2ViIFBhZ2UgYW5kIFBERiBm
aWxlcywgSSBoYXZlIGVuY291bnRlcmVkIHNvbWUgcXVlc3Rpb25zLgoKV2UgaGF2ZSB0cmllZCB1
c2luZyB0aGUgUmVhbC1UaW1lIElQQyAoSUREUCwgWEREUCwgQnVmcCkgcHJvdmlkZWQgYnkgWGVu
b21haSwgYnV0IGl0IGRvZXMgbm90IHN1aXQgb3VyIG5lZWRzLiBJcyB0aGVyZSBhbiBBUEkgaW4g
WGVub21haSB0aGF0IGFsbG93cyB1cyB0byB1c2Ugc2hhcmVkIG1lbW9yeSBpbiBhIHdheSBzaW1p
bGFyIHRvIHR5cGljYWwgc2hhcmVkIG1lbW9yeSB1c2FnZT8KCklmIHRoZXJlIGlzIG5vIHNoYXJl
ZCBtZW1vcnktcmVsYXRlZCBBUEkgaW4gWGVub21haSwgaXMgaXQgYWNjZXB0YWJsZSB0byB1c2Ug
UE9TSVggc2hhcmVkIG1lbW9yeS1yZWxhdGVkIEFQSXMgaW4gYSBSZWFsLVRpbWUgUHJvY2VzcyB3
aXRob3V0IGNhdXNpbmcgaXNzdWVzPwoKSSB3b3VsZCBhcHByZWNpYXRlIGl0IGlmIHlvdSBjb3Vs
ZCByZXZpZXcgYW5kIGFkZHJlc3MgdGhlc2UgcXVlc3Rpb25zLgoKVGhhbmsgeW91IHZlcnkgbXVj
aCBmb3IgeW91ciBhc3Npc3RhbmNlLgoKQmVzdCByZWdhcmRzLAoKTWluY2hlb2wgU2hpbgoKClNo
aW4gTWluIENoZW9sCkNvbnRyb2wgQXJjaGl0ZWN0dXJlICYgRnJhbWV3b3JrCsKgCiAKMTU1LCBK
ZW9uZ2phaWwtcm8sIEJ1bmRhbmctZ3UsIFNlb25nbmFtLXNpLCBHeWVvbmdnaS1kbwpFbWFpbMKg
OsKgbWluY2hlb2wxLnNoaW5AZG9vc2FuLmNvbQpNb2JpbGUgOiAwMTAgNDY5OSAxNzUxCldlYiA6
IHd3dy5kb29zYW5yb2JvdGljcy5jb20KwqAKIAogICAgCgoK7Iug66+87LKgCuyEoOyehCwgQ29u
dHJvbCBBcmNoaXRlY3R1cmUgJiBGcmFtZXdvcmsKwqAKIArqsr3quLDrj4TCoOyEseuCqOyLnCDs
oJXsnpDsnbzroZwKMTU1CkVtYWlswqA6wqBtaW5jaGVvbDEuc2hpbkBkb29zYW4uY29tCk1vYmls
ZSA6IDAxMCA0Njk5IDE3NTEKV2ViIDogd3d3LmRvb3NhbnJvYm90aWNzLmNvbQrCoAogCiAgICAK
