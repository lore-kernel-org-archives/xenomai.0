Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5E1DE8A4
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387287; cv=fail; b=aiIlbranjVu5+Q/b++v+HyuPA4+4XiEqt4ksuExnPflXpK6+gSs6lRqs/+u9OXP5ODsiU3yXuUX5pbVC4zQKz1MqJLK42idDVHf8eyvsescxroA0Z5GT6bRA3r4wjyCAhafSdlH53fCMR8ZpYPUPBX/7xxa0QiINF1GWdDkjb2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387287; c=relaxed/simple;
	bh=qMIf5eyR/gFmawQJNhthcAT1VkOXhNR4i8ccuSQi6k0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i+uggbh2cbKEhKuPBvgDLWMnp1Mi4YYbADSbxQs5uLYO+2i1sFErw6JHtN+2DXMzf5YAKMGZ7YZqF6Sm6BFOOQpsqFTywiT+t6YuPGT1bPZjLtQ+IhxSbXGuQOby/qNMybbWf6GTBt7ZCV2lkOmmAIFkpNwVjNMcBYvXL2DfEIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=j5HZYnV7; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="j5HZYnV7"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id AA94243535
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 09:21:23 +0000 (UTC)
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c410::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id AED7DD811CC
	for <xenomai@xenomai.org>; Fri, 16 May 2025 09:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttkpgVOn60SeDY3h9EukBUgVpF93fmq+bv42qUhhOOd9oKn6+Pgp0VkMHtwJj+qYAmgXJe6CGNaoZ8EGy/Y1KfE6mbp2xanhj7OkVUDbwj5Uqarvdk2sCZf/dAdPMVWZDQlB7aoo9yv1Iy/WNuBZj5lEQCwiJZQsxyM4q094w9zwLi2G5ltOoIkYs0k6bWgmngzb6FGMD7OIAtFo3xJRKN3Yij5uWkKh0eEPlgKfhyzYz2NeoEgOCq/eAxkMp2onKSzFHaEPhGOq9GOLLIolfRyKRsTbv7bFDDvaWjWUxjRVH8ooxpYGJbc6RATxqSa8Wl3CYxxMIgyQtgJyv4GegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMIf5eyR/gFmawQJNhthcAT1VkOXhNR4i8ccuSQi6k0=;
 b=hOMdGSe9sjPt7byZJdrwQz+ZB0OnZ5OgR2/qmuYjTrgGpBI+j02SHv7WP5lCfTpFk/vUn7UCrENeTiw1pnkd7eAsOrThiXJex+Se5AzTJfE2FYZBiXzDKtyqz0HhSVzbt4C5f7E8GL2Qum2MvUJTxA9zX6MlA/u6reV7E1FA/gzjB+jciTvmt0ohqwEA4HxPgAj7y/wk1YLnTDrvPeFHrcW5wvzcUM5TdVF77glhUSSdt+vZyipvnRU2ysjf+rfmS5FQ/N1mHJzZLxhnjH33tF/aKQcFDnq6HRHGbADfYsGMWxplwussli0uFZFdWY25SGvJvrSNDSYrMSekAVYf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMIf5eyR/gFmawQJNhthcAT1VkOXhNR4i8ccuSQi6k0=;
 b=j5HZYnV7X8TF7o7SoBtQyysZM2dZFf8m+PqxFugEyz42X7Ud8ZmeLdQkbco6eSkwGYtT065aBgg5oa0A9O0pZevq5I+mpRm8CAZJ9h6/VY5qVbDE4e2lqf4dcuLq3/Ma8onm4Fcb49ZVsyTKckEUK+BYmSg5abJrkvtEMg68I5c=
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ab::6) by
 PU4P216MB2231.KORP216.PROD.OUTLOOK.COM (2603:1096:301:130::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Fri, 16 May 2025 09:20:58 +0000
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e]) by PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 09:20:58 +0000
From: =?ks_c_5601-1987?B?vcW5zsO2KE1pbmNoZW9sIFNoaW4pILyxwNMgtc676rfOurjGvb26?=
	<mincheol1.shin@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Inquiry about Xenomai Performance and Latency
Thread-Topic: Inquiry about Xenomai Performance and Latency
Thread-Index: AdvGQ8mCXMtiW6xPQPa/cNFYF1moRQ==
Date: Fri, 16 May 2025 09:20:58 +0000
Message-ID:
 <PU4P216MB1353703F35EA11A43EEDA57AA993A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU4P216MB1353:EE_|PU4P216MB2231:EE_
x-ms-office365-filtering-correlation-id: 265bf2c2-d6c8-48a8-1984-08dd945af81e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?dW1kaklZUjN5REhXaGRSL0FzbEJQUVRkL3MyaitibnlSQWpWWm05?=
 =?ks_c_5601-1987?B?SXM1NzFBQ042cTBCQldseDl6MDdqT2Z3OFE0bUloTlR3YnNCWGVO?=
 =?ks_c_5601-1987?B?TmNuMENRYnJNQkRxakJVWTJwY05Qc2F1VXhjUWZKQTh3U213MXdS?=
 =?ks_c_5601-1987?B?R3JUcEdJZlgxOE9yaUdsRGtlU0NLTmNTQXJJYmtuSDJhMGpHNTRJ?=
 =?ks_c_5601-1987?B?YTJGV2EwY0NlTE5UYWd5V3I5eGVJV1p1REtteUF2VkU5Y05xNUho?=
 =?ks_c_5601-1987?B?MjF3R1c2R0F0Z1RtN0hhdStKYW1GUUlDTmNLc0ZlSU9kQW1zTGxQ?=
 =?ks_c_5601-1987?B?cXByeDkvdVVCSC9LUFRNRnM5a29FZnVTcmFJMkZKdWhYYllMbjd2?=
 =?ks_c_5601-1987?B?bW1veUgxTmtXM2N5Zk5mU2xrRlZoSXA4SG5FUEN2UjJCVUZENWVp?=
 =?ks_c_5601-1987?B?MmdOb3lYRC80VXdVekYzWkJUN1ZmVEZpVXRGUXRaUkVQTnF4KzMv?=
 =?ks_c_5601-1987?B?QnVva2xaZHR2aC9za1J6R0krUWwyTFlWajlQTWFvRllGcW1NRFhX?=
 =?ks_c_5601-1987?B?Z0t5b3lkY2FMekJnR0IyaGpSb2pUQUgzcm9HR1kxOEdJaWxZaG5x?=
 =?ks_c_5601-1987?B?eElMYi8zMVBpZXFlQnl0ZjFuVmtWU1lidjhwZUZIVlFIR1h4SzZp?=
 =?ks_c_5601-1987?B?WFBWRHpacWRNT3Z3WjMzWkk1bTFoQ0dDWjBONVFSMDJlbnF1UnR4?=
 =?ks_c_5601-1987?B?ZUdoOWo2MDdkNGpkd1k2RCs0U2J4ZDRwazl0aFlHd1hwSFNuY1Fo?=
 =?ks_c_5601-1987?B?VkhXTkJjeUlyT2wzR1ZEOFdqRGFaU1czaktkY1FpeFpQNWRoT0hW?=
 =?ks_c_5601-1987?B?QlUwRG9GMlQ2SjVFMzdHQ0k1UDVpWmxDamNDL3lpNHFqOTZoaFEx?=
 =?ks_c_5601-1987?B?UHpqVjROVWk3L1ZxK2k4OXlpYlBlYytVRnRNL3FkT2ZHQTJENmJC?=
 =?ks_c_5601-1987?B?eW9aMGFMa1Z6K2V5YnB4YUFBZjZJS2tzK0JBdHBPZEd0aFNmcTU0?=
 =?ks_c_5601-1987?B?bzM1UThoSk9hRng3RFJ3bXQ0a2tkK3ZJYlkzekl4bWxmQnp3M0V1?=
 =?ks_c_5601-1987?B?cDA1Vkl2bWxJdWsvVXdBUUNIUzNPbjZiRUhnTXhlTnFrQ05WaFQr?=
 =?ks_c_5601-1987?B?cnZmREdiSWJQcEUvR3pmM1g2VDlXMnRYTUx0WERncTE2RkYyM281?=
 =?ks_c_5601-1987?B?YzdmOW5SL08vOGlYUDIzMzEya0NJbklFNG4vQ3lBRC9hbU1hdnlN?=
 =?ks_c_5601-1987?B?VmpFZk5IZUsvblBxNnU3d0hIVGt2UXplb3pkV3JpZ08vWjlhNXZM?=
 =?ks_c_5601-1987?B?dzVzVjdQUHFVdGorZXUzVDk3WDA1Qk9NMG1qeksxTndOWlZkZTRj?=
 =?ks_c_5601-1987?B?ejBSTlBBeW00UWRZVjhoNXdiOUkvQklrdlBNTlk1UUZJMklPRlRB?=
 =?ks_c_5601-1987?B?cndmcXdLbHZjREJHaDBGaTNXOC9FdDdqaitWaG5qcThxOEE3TC9S?=
 =?ks_c_5601-1987?B?UVJ4azZaQ2oyWjZ4aFhnTnova3JrQnpBUnIyNWNQb09wb2hWMGxl?=
 =?ks_c_5601-1987?B?QjYyZjZ4bTNhb0k5YlJ6TzdNYnkrNUg2THN2OFV1TUZ3RlRKdXl3?=
 =?ks_c_5601-1987?B?WDlwK3hUNGxycGtmSm1tSWtQdG1PSy9VcVNrekdJck9xVUlDSlNj?=
 =?ks_c_5601-1987?B?bzFZQWpucUwvZU9iZUJIWjNSRGptZk5wOXg1YVFkOW9wbDg1bTdn?=
 =?ks_c_5601-1987?B?L0pqY1l6d0hMME0rTEEwQlZtbnVFVWpCaEp2cnFMRzgrbVd4UlZp?=
 =?ks_c_5601-1987?B?azFLVlVzZlYxQ2NNY3R4NkZxc04xY05HUjdCUE1PYVlkSmlQeTUv?=
 =?ks_c_5601-1987?B?YlVqb1l3SS9COVZONzRDRWluMXNGWVNsZGNiWU9XYXJ2QTMxWCtW?=
 =?ks_c_5601-1987?B?S000L09MdU8xaVJzcjdCTVcyU1o2VlRQU281N29ZMm8wcUJEYWVa?=
 =?ks_c_5601-1987?B?cS9UN0oyWks2WDhROGJOMnFaNFdmN0xLMzR0b29DTVpKU3paTnlZ?=
 =?ks_c_5601-1987?B?NDZYcWNMS0FvZ0hPY2Z1TTdxZlZwLzBIa0dWaGh0UFdidVdZSkwv?=
 =?ks_c_5601-1987?B?NXg1MThqTm11Q2dkVkZpOXdPc1VTaWZ2T3FTVHVMajZFVnpEZ2Ey?=
 =?ks_c_5601-1987?B?ajlOV3l0MDM3RU1vNXM3ZTNVdktod1Y3a2tKV0lYZWJ4NnlMeXhS?=
 =?ks_c_5601-1987?B?RW9TbjBGcmtwSE5sSUtCYWgvMm5uWmoxdVlrVUk5cEhORUEySHJ6?=
 =?ks_c_5601-1987?Q?fdU3GrgYoCvHuUC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1353.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?NUlKRTRaZ25jaEJWaEpLMExzelVaUHZUNi83UVhqL3ZFa2lVeStn?=
 =?ks_c_5601-1987?B?S1FMb3V0NkdFWFI4aWVucWxYSmUrS0dVL1paWUxjTlB0WDg2eUJP?=
 =?ks_c_5601-1987?B?N2J6ZkpwVHJNS1F2MkdIWHlNRXFZblRzdS9LSDBRYkhKdkZIdFVx?=
 =?ks_c_5601-1987?B?RjFybjliQkZPd0ZDcm03M1kvL0Y5NUFUV2FERVdQUFQzby9lS3p4?=
 =?ks_c_5601-1987?B?T3JvTkxva2Yxek1sVncwdndJYU5LNTBVbDRFcWpYNFA5d05aanpu?=
 =?ks_c_5601-1987?B?WGRaZEVtaVVzR1JIL2VTT1hsOXRoTTVZck05UmhGTVgrQXN6WGRm?=
 =?ks_c_5601-1987?B?VE9qaWdtOFRpckZmNmdQZkhxNWZFejZIdkJuT3ptL3VqYXJ4VXBS?=
 =?ks_c_5601-1987?B?c0RhOVNzYlppNEdoSTl4TzlDOG9kdXczSitqajkzM0hJVE1lUjVr?=
 =?ks_c_5601-1987?B?K0hwVVlhbnVZeFBTam5JS3pSNTBDaCtQRlp5STlDNXNVM0NZOXla?=
 =?ks_c_5601-1987?B?NXh4dHIzU3loNVJVRm1iSnVCUFI4SHBJRmoxeFFYTzcwbEdTOTlQ?=
 =?ks_c_5601-1987?B?N0ZDWHN5MC92VXdlYkV3emR4L3lnYW9Yc3NJd3dqNlZpN0hzSHJ4?=
 =?ks_c_5601-1987?B?dDVUK1hwZ3FPaFFDbmltdUFnbG92K3UxVlpoejVCbXMxTGw2TlFo?=
 =?ks_c_5601-1987?B?Sk1jYWpZTE5MSnkvb2NTZHdYdjR6WlZVTW1wMkF3dmF6cmNPb3oz?=
 =?ks_c_5601-1987?B?djBmSDhJbml4SjQ3T24wYjhsTE5GQ2hNayswM1ZYYlFnWnNGbEh1?=
 =?ks_c_5601-1987?B?SmVoaGxCQUV5NG5QaVg2SlhGcVZGVU9WSXFhbllPaXNHSTRJMENX?=
 =?ks_c_5601-1987?B?VnlVU1JjUXhnempGZXdvb3VycWVVRHZLSnVQUkkwVWxVR1ZOMExN?=
 =?ks_c_5601-1987?B?b3pRRUppREFML3JPNTBzOVJIRUpHT0FTV1ZWWnpWd1BPRjJPczlV?=
 =?ks_c_5601-1987?B?aXgzdWgva0NNZFo2Y0l3Qmo0cjdSeEh0SG16eGFlMTIzMWFBWU9n?=
 =?ks_c_5601-1987?B?SHFPc0I3MEo0S0J4REtBbEIvdDk0Z212ZzdHZXl5Njk1ZS9MUDZq?=
 =?ks_c_5601-1987?B?VUkycnFWa1k3OW1MZHROeDVaY0hwQTdqSk1YUXk0MEVRaFduN1pG?=
 =?ks_c_5601-1987?B?ZXNSSEtHSVJGWXFEOVd0T0dXSXFOTjVuUWlXc1FodHlxTUo4dmZU?=
 =?ks_c_5601-1987?B?SUNTd0duK2JaL05iUW4vYU1nbW1NQ3FnUnhrT3N6UEY0TFUrRHkv?=
 =?ks_c_5601-1987?B?S0dIeWlER3JrdW8ySno5L2FGTWFXc0d4QVA5Q2QvMXNzK1JVeEVj?=
 =?ks_c_5601-1987?B?TFpkZks0SlVwbFlBU3U5dUpnN3hWUVhtbmNhVDB6b2ZGZmoxYkJT?=
 =?ks_c_5601-1987?B?VmdBTXpZT3kyc215NjVhVXphQmhtZVFZeml2SFZSYzFrcTlPZ3RO?=
 =?ks_c_5601-1987?B?WHN4STlCMjFFYTRHeDNhYzVHZzh2bXViT0cvc0xidDZHTDkwWmND?=
 =?ks_c_5601-1987?B?K09mOGMzKzhFNHBReUNBclJ1eXJiSzNOTGRGdWFVTXN1OWJUZ0RM?=
 =?ks_c_5601-1987?B?WUVRZm5FUy90WWRNdEoyTXgvY2pXaDA3TG5GY0JJM3E2N0ZzOVZo?=
 =?ks_c_5601-1987?B?cXo4QTBZdnIxTFVpeFlOOCtyMGd6UmVxcU1rNDVOL3R4UmppSjd2?=
 =?ks_c_5601-1987?B?Ti84VmovSVN5Wm5qQ3ZYT3hlYjZmeWpkN0dJbllmUlFqSWRpck9j?=
 =?ks_c_5601-1987?B?NFVLSmNHNmN6czZCUGFobi83VC9vUXJYSnV2Nm53cUoyRVFkK1py?=
 =?ks_c_5601-1987?B?VXlOS1c2V0V3SXlGSlVVaWVFdnl0YU1tcnU3MThPMEFNNXhyTkFx?=
 =?ks_c_5601-1987?B?cEdCMGlsQW5ObTdTcjcvSEt4b0gyYWVvUXRHR2NLRHdHcWZkT0I0?=
 =?ks_c_5601-1987?B?Zjl2WTRkQ0I3TUdEOVBzR20xSWk5bWdoNTZtMUthdTRaaEJIT011?=
 =?ks_c_5601-1987?B?emFOam1nQ0lldG05UnNVRzVPNlBZVEJwc3Naek0zdlVMK29QZkx5?=
 =?ks_c_5601-1987?B?RkE3OVRhdk4xT3VGSFUxNG5ROE0vRjl2a3lHZDJ5TDFqWUhrZXl5?=
 =?ks_c_5601-1987?B?MHNrSXZzMTRCVk1EcENVYUFwVTE4UlZqZExHVmVjWE1YRnNGSmo4?=
 =?ks_c_5601-1987?B?eWZIZHN6TkZ2WUZkWm1ZUThJT1QwbzFvZFdFRzFHTzJ2N2o2UnBG?=
 =?ks_c_5601-1987?B?dnd6ejJlY1I0eXNhQ3lkZnNmYjhCTy9IaVpJclR3NGxma1BWZUlm?=
 =?ks_c_5601-1987?B?ZGVSdHFaaGFRMDNUM2JEOVg5QTNWODQwSk1KZ29La0NpTDloT29l?=
 =?ks_c_5601-1987?Q?bSbpXhVK6SrTmGoSJiRnRRp7HM19S8o6nwis5CXp?=
Content-Type: text/plain; charset="ks_c_5601-1987"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 265bf2c2-d6c8-48a8-1984-08dd945af81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 09:20:58.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh/xHbclVOqeuMcDpCFfKUPZUnFhUrN64QGmv4jMeuLniRT/eGM08fZhXnchIlG28IX8QHiFDQ6AYX3yw2R3C18bqTRsS68OxbaewOVwZMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2231
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=j5HZYnV7;
	spf=pass (spool.mail.gandi.net: domain of mincheol1.shin@doosan.com designates 2a01:111:f403:c410::1 as permitted sender) smtp.mailfrom=mincheol1.shin@doosan.com;
	dmarc=pass (policy=none) header.from=doosan.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufhtfffktgfgggesthgstddttddtlhenucfhrhhomhephmmpulnhnmlrldfoihhntghhvgholhcuufhhihhnmdcugmlmkmnmuclqhnmfsolshnlvtlmqhmmhvlcuoehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuvdfhvdfhueegteevfefghfekhfefvedutdeuieekheeihfekgefgfeeutefgtdenucfkphepvddujedrjedtrddujeekrddvudegpddviedtfeemuddtleeimeeftddumegrsgemmeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudegpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepmhhinhgthhgvohhluddrshhhihhnseguohhoshgrnhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

RGVhciBYZW5vbWFpIFByb2plY3QgVGVhbSwNCg0KSGVsbG8sIEmhr20gTWluY2hlb2wgU2hpbiBm
cm9tIERvb3NhbiBSb2JvdGljcy4NCg0KSaGvbSBhIHVzZXIgaW50ZXJlc3RlZCBpbiBkZXZlbG9w
aW5nIHJlYWwtdGltZSBzeXN0ZW1zIHVzaW5nIFhlbm9tYWkuIFJlY2VudGx5LCBJIGVuY291bnRl
cmVkIHNvbWUgcGVyZm9ybWFuY2UtcmVsYXRlZCBpc3N1ZXMgYW5kIHF1ZXN0aW9ucyBhYm91dCB0
aGUgTGF0ZW5jeSBwcm9ncmFtLCB3aGljaCBJIGhvcGUgeW91IGNvdWxkIGhlbHAgY2xhcmlmeS4N
Cg0KSSBob3BlIHRoaXMgZW1haWwgZmluZHMgeW91IHdlbGwuDQoNClExLiBJIGhhdmUgcmVhZCB0
aGF0IHdoZW4gdXNpbmcgbW9yZSB0aGFuIDQgY29yZXMgd2l0aCBYZW5vbWFpIDMsIHRoZXJlIGlz
IGEgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gaW4gdGhlIENvYmFsdCBjb3JlLiBJcyB0aGlzIGlz
c3VlIHJlbGF0ZWQgdG8gdGhlIDgtY29yZSBDUFUgYXJjaGl0ZWN0dXJlLCBvciBpcyBpdCBhIHBy
b2JsZW0gd2l0aCB0aGUgbnVtYmVyIG9mIGNvcmVzIGJlaW5nIHVzZWQgYnkgWGVub21haT8gSWYg
b25seSA0IG91dCBvZiA4IGNvcmVzIGFyZSB1c2VkIGJ5IFhlbm9tYWksIHdpbGwgdGhpcyBwZXJm
b3JtYW5jZSBkZWdyYWRhdGlvbiBpc3N1ZSBzdGlsbCBvY2N1cj8NCg0KUTIuIElzIFhlbm9tYWkg
NCBtb3JlIHBlcmZvcm1hbnQgdGhhbiBYZW5vbWFpIDMgd2hlbiB1c2luZyB0aGUgOC1jb3JlIENQ
VSBhcmNoaXRlY3R1cmU/DQoNClEzLiBDb3VsZCB5b3UgZXhwbGFpbiB0aGUgbWVhbmluZyBvZiBu
ZWdhdGl2ZSB2YWx1ZXMgb3V0cHV0IGJ5IHRoZSBMYXRlbmN5IHByb2dyYW0gcHJvdmlkZWQgYnkg
WGVub21haT8NCg0KSSBoYXZlIGxlYXJuZWQgYSBsb3Qgd2hpbGUgY29uZHVjdGluZyBudW1lcm91
cyBleHBlcmltZW50cyB3aXRoIFhlbm9tYWksIGFuZCBJIGFtIHZlcnkgZ3JhdGVmdWwgZm9yIHRo
ZSByZXNvdXJjZXMgcHJvdmlkZWQgYnkgdGhlIHByb2plY3QuIEkgd291bGQgZ3JlYXRseSBhcHBy
ZWNpYXRlIGl0IGlmIHlvdSBjb3VsZCByZXNwb25kIHRvIG15IGlucXVpcmllcy4NCg0KVGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgeW91ciBhc3Npc3RhbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQoNCk1p
bmNoZW9sLVNoaW4sIERvb3Nhbi1Sb2JvdGljcw0K
