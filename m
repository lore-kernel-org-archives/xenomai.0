Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B4226CFE
	for <xenomai@lists.linux.dev>; Wed, 24 Sep 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748180; cv=fail; b=KStFe9NBriqyEYcFHV/JcamObiS0/HGr40ke+unQdxjFpzeoiw3Ry7Q9PMoHQcPXU7BadlV0llvCljA7tdV0BLzTilHxaDokAo0cCDJcK+DetUXH0OYdXCywG96L/xkpbzxljEZGWxg4gaEgCEzWi1Y446jeel7mgvP3Exwoh/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748180; c=relaxed/simple;
	bh=+PqpW5dZxdFKq2NGW+XVLZmT7w1HNznVp3cdY2ZFZHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OB4SETL3Cb5hF4MIooitH2YhblGpDMvaKejDnOu+/CdhGJPfnC+FAzxojY6TY89v/NDnhtVYwZwHZYoCsBI1YCMGvSxu1KzjNDq/sbDq3xLJ3r2CYpO0kkakLpdCct1W7ek/mdNaTxaElRGv9s16IlI9docXXWeNsTycnHpMMsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=HbIJMrOW; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="HbIJMrOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbA9t3Na8Zcf/qoxlilFPdqvEtyuwMVWYtdXK+9B6Qr6fxioUfKkvgcE+0AM3mYYxhU7v0l3jb/axoAKhNFoFjBGkk0wwRxzb6M3C8eOfBn7HcKhNRO7xzwQ5r1oF8WIxlKMfjAsj849auFfb4DEcG+FGMfg5KhSxM+Q68pEXhKWSBa46w3vuWB1Zvn2pOjSBmS6zePhCGVxhisOHctyumAi4zc7ljzbA78uPQS8haq3e0Sqk5EdP3XQBbecTD8XfO39o7IDjtEcODzF9MVavPtGSQl2+s252S7cb93Bb7FpVfL5GJLFYu82/FgkfMEMa27hSTw0rEHf8lvmU8qnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrzuuLkQ6rFoaqH/gIS+sNkcBDah6HSdK0vvvVpDsDM=;
 b=ymTexfNjW1TAi7zFAc7yjwOL24gmyjoqpB1Ujs3rFw/RCbVpvPdqdcALBpL8I+13tPuWdZ4g99w8z23/8/o2Xo+Ok3CWviSZtIBrm4OiHK3wBTRiVG0UeTIaoYB4Mu1OZ/88mlISyI6ZDEIiCiVwK3m2dkHM9SI1d9Kxc6l28i81IBUbBt59n0L1PtoJHIulBX7e0C+thP+ZpoRSahvGTrIPqCzXRpvfXjdLXPFaqNA+Jr03TgBosEEJejA+qwaaIbU9fC+sQi5A546h+ajwDNCiQaAKVqkcpwOGZu2ISMU+uqbhfCmhjPyByH72DFUvpZlZq4Dnuyx9BuaiIf5hXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrzuuLkQ6rFoaqH/gIS+sNkcBDah6HSdK0vvvVpDsDM=;
 b=HbIJMrOWeb/tAuvTrcLwr4lML5toK3qzO1KzgOeWbU/DiT88DlDoztSXdJKspzzeqnMtPgY1lov3/SrbOCHYTD3vRW1ckfWGdQImtda6Kvwrdc5unkPhudSlV+VcmiSdTdXoG7oZ4ISwZCzKU1yiGzVAI478C1Nbty5EBGjfqvE=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by DB9PR03MB11025.eurprd03.prod.outlook.com (2603:10a6:10:5e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 21:09:32 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 21:09:32 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwABgKnAqAQl7ioAAEisLgAAVEMvgAG5y25AAlay2kA==
Date: Wed, 24 Sep 2025 21:09:32 +0000
Message-ID:
 <AS8PR03MB10056EAAD28FEBAF37FA1071A8B1CA@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <878qk3za1e.fsf@xenomai.org>
 <AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <878qimxczv.fsf@xenomai.org>
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <87plbuz9ib.fsf@xenomai.org>
 <AS8PR03MB100560006594FE9480F592EB98B16A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <08e34367-c342-48a9-91f2-09e00779d870@siemens.com>
 <AS8PR03MB10056194CE9C24DCF7863A7478B11A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <AS8PR03MB10056E8AC01A0C90B520575328B13A@AS8PR03MB10056.eurprd03.prod.outlook.com>
In-Reply-To:
 <AS8PR03MB10056E8AC01A0C90B520575328B13A@AS8PR03MB10056.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=960f4394-bee2-46d5-bc5b-a850714e7326;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-09-19T16:21:33Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|DB9PR03MB11025:EE_
x-ms-office365-filtering-correlation-id: e731a00f-7d53-4f9a-9855-08ddfbaea866
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VVQ4VXBEVlZUOHRHYnFUYnJPM3d2UU8rYnMxbVA5NGNwUHZxMVFJOFR4?=
 =?iso-2022-jp?B?SURHREhDTkt4SVoyYXNUSldNMXdkUVdoWTV4VHFEaC9mUkgvZWNQZFdK?=
 =?iso-2022-jp?B?aUZKSVNxanFseDZBNkpZRk9Kdlh1L20zWjc4NHNDMVVkZHIvSWM1REdJ?=
 =?iso-2022-jp?B?YUxuckc1RngvcEJ1dHhzTzBCK1R1OWVTZmltaU02MFI4eE8vbU90U1Jk?=
 =?iso-2022-jp?B?Rm12cXZMV0l5NkFJQklINGdPdkd6ZUhMUkFFbnBQNlVUWWtFcGdZZHJ5?=
 =?iso-2022-jp?B?aXkweHREU056bXd1blNxV251OWdJdVkzbm1ncE1kT014SmRNRHJVMzdM?=
 =?iso-2022-jp?B?R3NwM05vRVhUYmtjQmk0bi8yR05iQml4YnNLWkE2SzkvTDExdEdvYWNN?=
 =?iso-2022-jp?B?OTNROU9lR0Y0YzFEdmF1WnZQaFhDaHRabDVSS0Vldldva3Fjb3lnbEtu?=
 =?iso-2022-jp?B?RXZrbUJBN1BhZ2o1OXZNTzZVWmVvUlNvWmI1QnRUQVZJTjlXY3dvcVJ0?=
 =?iso-2022-jp?B?ZHVKK0ZMQ1hvU2tWRVVXZnBCMmhhN1lvWEh1UFV4a0prZzBGVGtyUU1a?=
 =?iso-2022-jp?B?OTRmc2R0QUhGR1N4TVE4K25Oem8xaWhjV21oNlJWYTZnQ2tBaGNpVC9T?=
 =?iso-2022-jp?B?R3FBWG1jWVVmWTJSaU41OHE1V3U2WmRHbU1ZOXp4UHlyTjkwTmZSd2pF?=
 =?iso-2022-jp?B?eWVIR1ludkhRbUJXVmxPRndROVdzNncvV2dvZzhZaEsxUGNtL2dOb1hJ?=
 =?iso-2022-jp?B?YjdiaFI5SjV3em1jN1A5SFY0RE9xMmozYzRPUkI1S3ZpUTdaQjlyQ2k1?=
 =?iso-2022-jp?B?NXd2QUdCT0sxUmUzUkhHRkoyWmhZVnZCODNjZTVJcWd0eEx2cElkMnFr?=
 =?iso-2022-jp?B?dndxc2tMd0NLL2dJN3ljWDF0czBIcktwM1RwNk5DYkpmNG1LVWdjVVlB?=
 =?iso-2022-jp?B?T2FiYTd1L3hqSnZyc0lLZGZrUEVDSlI5QW80QlNVbmc3OFhjNHZnWEtq?=
 =?iso-2022-jp?B?TC9SemYzd2hjNkF6UklnRFdZeGMrM2dLeE8zUmJtNkpKOVBteUpIWmxy?=
 =?iso-2022-jp?B?dldLYm1nZERHcER6U0RzNzlqU2JtbVRXdHEvVy9qU2ptQk5aR0NSOVk1?=
 =?iso-2022-jp?B?N0d3K0xkTnhYVHlDUGhBb0JmaWZpRmRycjJRQ0Z0K1AyNkhPbGltSTc3?=
 =?iso-2022-jp?B?R0xqQnlQL3kyZDBtcXRqRmhBL1Uwc1J5RjdNaVk5bDRLeXRwUFE3UU54?=
 =?iso-2022-jp?B?KzNCekhEdExXTjJWZG96M0RyTVZHWW5ERUlxdk9BVUdOTEd1ZUo0MEFy?=
 =?iso-2022-jp?B?a2ErQmExTFZhR0ZRY0t6bGxGT05xblRkRVkyVXNrcTl5Z2pKQ09oTXV3?=
 =?iso-2022-jp?B?T1N3ZCsrb2tvZ24yOU90Tm42ZUQ4VlA5UGR3c2REMkJRdjJFNlN0MU1z?=
 =?iso-2022-jp?B?azE0Q3k2NUVyVDhkSnhsdDNmcGhCemNlZU1XNDRvbmxQWXc1OGtaSm54?=
 =?iso-2022-jp?B?eWl2b1ByYVU3emhZQkdRWlJBakwzeDFyeEFwN2JRR1hXUkZDWC9LQktn?=
 =?iso-2022-jp?B?THFqSEdwR3FMblZiRUZMU3ZLZURaQ0NYVHhjbmRnRG4xK1FPYkVYdnhL?=
 =?iso-2022-jp?B?UkJYeU8rOTNoM3FQUFlUMnhmSUZRUFR3ZGhRazVPclFBdnNQYUUyS2Fi?=
 =?iso-2022-jp?B?Nko5NjNVY1Yxa1hEcVk5b2ROMTZCYkh2MlAwS2kwUHJYVHB0MVRGNUd0?=
 =?iso-2022-jp?B?NFJIaHJ3N0hIcnBSd2Y3UXltTUpLMXJEK1NHOEJlcGtXSkYxcExCYW55?=
 =?iso-2022-jp?B?RWhML2MyV05XQkZoaTJ4Mnc5VFRuMVd0R1BzbG5ZZ0dMR0VLVldhbUw1?=
 =?iso-2022-jp?B?N3Bma1NLa3dMd0hVWkN0Rm5oeVZ1WW54djBqU2hwQXZPa2dYeHRLVGln?=
 =?iso-2022-jp?B?bVc5QU9mdVNDUTNYMTNtNG1DYklNR2dnQ2lYWWlKMis3bmpvQ0lxTXkv?=
 =?iso-2022-jp?B?OHppZ1dJbkZwWlMxd2RqU1JvclpEK0NDQU9TRE50YXEwdnFTY1BKQ3lp?=
 =?iso-2022-jp?B?SkFWS1lYR3MzK1NldWVjQTFVWm1BNWc9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SUhCZUdBQVJQZU9ITURRekdWdHpGbFRXWE1nQkpOQW5kMFo3YWZlNjBM?=
 =?iso-2022-jp?B?cnk1allmT1B0aS9CajYwSm5kaG5aUkdqZ0JEeXBJd0dZU011bldlVy9N?=
 =?iso-2022-jp?B?aUYzT0w0MGdLUWUxSkFBRDU1K2tOTmFCeWk3SjRrUFNjMkNMU2FBWElE?=
 =?iso-2022-jp?B?djk2bGtpd3hWL28zQlczRkFhWDV4V0NCdHJGb29JSkphUTNUcTNlM1dz?=
 =?iso-2022-jp?B?Q1l2d0UrZUdXWENib2RxbUcrdDB3bkJER1J3NlBDdWVrMHFkUXQ4UDZm?=
 =?iso-2022-jp?B?NitWREw0NmF4b1JFK2hrS1Y4eUtRSFZNMGpCcVN0VCt3cHQybWl3Ni9W?=
 =?iso-2022-jp?B?SEtKOFQyUjN6MUdEMGdkeVp4OHl3STN1WHpaYlB3REo1NU1sSklUOVFQ?=
 =?iso-2022-jp?B?Z2lGaE5tZUd6dDU3R2pqNGNKUFhSRmZ1R3RZUFNnWVBBTVBZZ2twbE1S?=
 =?iso-2022-jp?B?bHQrdXVxd3JtSVcvRXQ1NEFNcENqTUNpanpTTzNFVzMzVm5zalFiSFZh?=
 =?iso-2022-jp?B?Ty9hVU95RVlsMGx4VFczVmhoYm5mdnBNU24zNjFiWHZnMDF6K3B3bjV3?=
 =?iso-2022-jp?B?ZFNDbFNUL1RGRllTZ0RPT05UWHIyUHk4dWpYZ1NzRml0dEpSL2NMUWNl?=
 =?iso-2022-jp?B?R0QyYWVkdHI2UmhlKzZKa0EzU25maUxaOHkxbFpGNDhGQkorYUE0NzVx?=
 =?iso-2022-jp?B?VG9wb0RJMmQ1R0ZJcGtnL0lQTnVWMCtkOEdNNlNKaGlzM2ZUSDdDK3BH?=
 =?iso-2022-jp?B?VVNRWklSZ2NsT3lQNkRETUFYVUg1SWVKTFp6b1UxeGI4NFk3U2pTTkkr?=
 =?iso-2022-jp?B?Vkl6aE05RldDVERqakwzTzFKaXRuZ3lnYXAzRk9aays2V2NBc2xENEVQ?=
 =?iso-2022-jp?B?aUp6OXFTKzBzdk5PWU9mZTFsSEhaU3pUcGVUcUFUa283TE5WRlR5RjBa?=
 =?iso-2022-jp?B?Zk00eFMzc3RnMlBWM09BdnVoL1oyUEYrd3FxYjRCdkErdzJkdmNDa2Jv?=
 =?iso-2022-jp?B?MU50QW9ER09sRlJyV214VUdOdlAvSDRvUlVzVmhaZVdzNVltODFoYzlS?=
 =?iso-2022-jp?B?dlMrYmNnanRqMUgxck5xVVFOclpMZ2RRWVRONmxIdlpKb3hzclhwNkpK?=
 =?iso-2022-jp?B?bW5sVzlsUzBpanQrVDUvbnVNanRvaGZCWHQ0djRGZFJJR29nMHNWNnZj?=
 =?iso-2022-jp?B?Mko0SkVWcVhNVjB6dEJCQU5uVktwVTVSa0ZxYXVyb2IyQ1BZTXNuM2Q2?=
 =?iso-2022-jp?B?dXY2VHRHa1lrR1plK0xYNkgydU9iYzRzeEE0b21qTHpiMVRnV2s5V1JR?=
 =?iso-2022-jp?B?Wm93eVR5SldXSUtvRng0MDFCeG80UTZZQUFnK0NyYnFMaFIza1pVeUxa?=
 =?iso-2022-jp?B?K2U5MUk0WC8wSjg0dm5Fd3JTc3hKZW0rdEFQRzVIamFOa2dzSjVYTEtN?=
 =?iso-2022-jp?B?SmRwL2hlQmJ3ckZJUkdTN09HbWhQaEVBdE5YSzh4M3hodWVZbFM1OTdH?=
 =?iso-2022-jp?B?aWtTVjAvL0liTEs2eFBxb0VKUjFTYXo1NmV3bXJ0TXduUkwvWTFIVUxy?=
 =?iso-2022-jp?B?UmtXME1tLzQyQTJKN05RQTFsQks3ZWZ5cEFldFJXUktnNzZjSjFCbE1j?=
 =?iso-2022-jp?B?ZklTTTFvR0lMK3BxQkx4K0JzMnl1dGhTTFIxNExaSG1RYzMwVnROc3NE?=
 =?iso-2022-jp?B?cW4vb1FMRXJMMWJRRS8rYWpMYTN6d1RJQkhIeUp5LzJwWXZwRkhUeXli?=
 =?iso-2022-jp?B?VXJ6QkVubk1NQ2dtdUptSi9OL2ZTUWc5VkkyWGgxQ0JRb1ZyNkIzd0w1?=
 =?iso-2022-jp?B?L1V1M2RPcVozRnlmMzV5bmtTSitDanlWdEVBdVEyRWIyaTZsRCs1eVBL?=
 =?iso-2022-jp?B?ckQrNVAvaEJ5WElxT3FldVhsN01FVU91UDZXMTRwYUJyRlJpQmpRK3c1?=
 =?iso-2022-jp?B?bGdnTjlSTGJ2eU0rRmROanlBNDhucGc2WWI4UEFDc1RUSU5kWE01eGQz?=
 =?iso-2022-jp?B?R0tRUlMvTTcwTWE4QkwvOUFBTHlDTTRRSjVkdEFoYXNhTStDVHhHMENv?=
 =?iso-2022-jp?B?VklqM3ArOVVsN2Jnb3hqazlBR2xUbXc1OVdYRVdiR0hWTFVIN0tqbjk5?=
 =?iso-2022-jp?B?N3d3UVVuUDdQZHFpRk9IRWtFN2huUG43VDlyZGs5MVBYYVhFenJyeWhN?=
 =?iso-2022-jp?B?REZQSlovYllPQ0gvcWZSODlXU1hHbkx6N0VQcDJ2Y2VRM0ZKZXdMSFc4?=
 =?iso-2022-jp?B?NUt6RFAreHoyT2wvZFQxMFUvei8zRlI2az0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: festo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB10056.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e731a00f-7d53-4f9a-9855-08ddfbaea866
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 21:09:32.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6WnuGY7VOOYMA2dWldUnUq586hOWclZqZcxpU8nx/fABngGRDQ+sIvTkDpP+cdSc/P2YJSraRc/N6DC3cj08g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB11025

Hi Jan and Philippe,

Please see below from my test update. The first machine latency is greatly =
improved, but my second machine still having issue. Please advise. Thank yo=
u in advance.

1. Machine one 4-core Ubuntu (Intel Alder Lake CPU-4core)
I added below parameter to GRUB_CMDLINE_LINUX_DEFAULT. The latency is great=
ly reduced.
evl.oobcpus=3D0-3 isolcpus=3D2,3 nohz_full=3D2,3 rcu_nocbs=3D2,3 idle=3Dpol=
l processor.max_cstate=3D1 intel_idle.max_cstate=3D0 threadirqs

nick@nicklinux:~$ sudo latmus -t
=3D=3D latmus is now tuning the core timer, period=3D1000 microseconds (may=
 take a while)
irq gravity...0 ns
kernel gravity...1000 ns
user gravity...1000 ns
=3D=3D tuning completed after 20s
nick@nicklinux:~$ sudo latmus
warming up on CPU2...
RTT|  00:00:01  (user, 1000 us period, priority 98, CPU2)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.353|      0.551|      2.105|       0|     0|      0.353|      2=
.105
RTD|      0.399|      0.583|      5.037|       0|     0|      0.353|      5=
.037
RTD|      0.422|      0.595|      4.175|       0|     0|      0.353|      5=
.037
RTD|      0.339|      0.554|      3.637|       0|     0|      0.339|      5=
.037
RTD|      0.113|      2.408|     15.731|       0|     0|      0.113|     15=
.731
RTD|      2.532|      3.906|      9.463|       0|     0|      0.113|     15=
.731
RTD|      2.354|      4.031|      9.550|       0|     0|      0.113|     15=
.731
RTD|      0.497|      2.323|      8.349|       0|     0|      0.113|     15=
.731
RTD|      0.271|      0.460|      3.616|       0|     0|      0.113|     15=
.731
RTD|      0.228|      0.341|      7.862|       0|     0|      0.113|     15=
.731
RTD|      0.164|      0.295|      3.139|       0|     0|      0.113|     15=
.731
RTD|      0.153|      0.316|      2.993|       0|     0|      0.113|     15=
.731
RTD|      0.183|      0.315|      2.969|       0|     0|      0.113|     15=
.731
RTD|      0.177|      0.317|      3.205|       0|     0|      0.113|     15=
.731
RTD|      0.170|      0.320|      3.098|       0|     0|      0.113|     15=
.731
RTD|      0.175|      0.337|      3.819|       0|     0|      0.113|     15=
.731
RTD|      0.169|      0.337|      3.217|       0|     0|      0.113|     15=
.731
RTD|      0.189|      0.343|      3.010|       0|     0|      0.113|     15=
.731
RTD|      0.185|      0.337|      8.410|       0|     0|      0.113|     15=
.731
RTD|      0.174|      0.360|      3.490|       0|     0|      0.113|     15=
.731
RTD|      0.176|      0.351|      3.422|       0|     0|      0.113|     15=
.731

2. Machine 2 (AMD Ryzen 6000H cpu)
Since the Virtual machine has bad latency. I install a ubuntu 24 to the mac=
hine. Then I build xenomai with the same steps.(no error no warning). I reb=
oot and enter the xenomai kernel. The Boot stuck at loading Initial ramdisk=
 again, then I turned on kernel console. " EFI stub: Loaded initrd from LIN=
UX_EFI_INITRD_MEDIA GUID device path EFI stub: Measured initrd data into PC=
R 9" I compared both .config files, they are identical. Is there any specia=
l setting to run AMD CPU.

Best Regards=1B$B!$=1B(B
Nick Xie

-----Original Message-----
From: Xie, Nick
Sent: Sunday, September 21, 2025 5:26 PM
To: 'Jan Kiszka' <jan.kiszka@siemens.com>; 'Philippe Gerum' <rpm@xenomai.or=
g>
Cc: 'xenomai@lists.linux.dev' <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed

Hi Jan and Philippe,

I resolved the issue from last email. I thought it was caused by virtualbox=
. I used Vmware workstation to ran the installation again. The problem went=
 away. Please see the evl and latency test result below. The actual Linux m=
achine was running much better than the virtual machine, but I were still s=
eeing about 200us latency. Xenomai's latency could tune to <30us. Is it tur=
e? I have a few questions below. Please advise. Thank you in advance.

1. Should I run Xenomai in virtual machine? Does it affect the performance.
2. How can I improve the latency? (I am going to use it to build a EtherCat=
 master) Is there any hardware requirement?

Both machine are Ubuntu24
1. Machine one 4-core Ubuntu (Intel Alder Lake CPU-4core)
ick@nicklinux:~$ sudo evl test
[sudo] password for nick:
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
../libevl/tests/sched-quota-accuracy.c:213: FAILED: evl_control_sched(44, &=
p, &q, test_cpu) (=3DOperation not supported)
sched-quota-accuracy: no kernel support
../libevl/tests/sched-tp-accuracy.c:222: FAILED: evl_control_sched(45, p, (=
(void *)0), test_cpu) (=3DOperation not supported)
sched-tp-accuracy: no kernel support
../libevl/tests/sched-tp-overrun.c:220: FAILED: evl_control_sched(45, p, ((=
void *)0), test_cpu) (=3DOperation not supported)
sched-tp-overrun: no kernel support
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK

sudo latmus -m
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.479|     11.304|     73.482|       0|     0|      0.479|     73=
.482
RTD|      2.134|     66.364|    167.666|       0|     0|      0.479|    167=
.666
RTD|      2.679|     70.065|    164.169|       0|     0|      0.479|    167=
.666
RTD|      2.486|     61.561|    127.858|       0|     0|      0.479|    167=
.666
RTD|      4.370|     62.240|     76.170|       0|     0|      0.479|    167=
.666
RTD|      4.220|     82.704|    193.732|       0|     0|      0.479|    193=
.732
RTD|      0.180|     99.642|    202.283|       0|     0|      0.180|    202=
.283
RTD|      4.316|     98.797|    207.727|       0|     0|      0.180|    207=
.727
RTD|      7.103|     63.529|     78.923|       0|     0|      0.180|    207=
.727
RTD|      4.281|     76.397|    194.532|       0|     0|      0.180|    207=
.727
RTD|      1.636|     65.308|    187.265|       0|     0|      0.180|    207=
.727
RTD|      2.314|     67.532|    192.044|       0|     0|      0.180|    207=
.727
RTD|      4.585|     63.799|    153.583|       0|     0|      0.180|    207=
.727
RTD|      1.563|     63.780|    120.452|       0|     0|      0.180|    207=
.727
RTD|      3.757|     63.276|    123.750|       0|     0|      0.180|    207=
.727
RTD|      3.794|     62.681|    120.261|       0|     0|      0.180|    207=
.727
RTD|     -0.022|     80.300|    209.774|       0|     0|     -0.022|    209=
.774
RTD|      1.381|     63.559|    161.354|       0|     0|     -0.022|    209=
.774
RTD|      5.056|     63.004|     75.401|       0|     0|     -0.022|    209=
.774
RTD|      2.896|     61.048|     74.324|       0|     0|     -0.022|    209=
.774
RTD|      1.338|     61.750|    187.294|       0|     0|     -0.022|    209=
.774
RTT|  00:00:22  (user, 1000 us period, priority 98, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.512|      7.897|     70.633|       0|     0|     -0.022|    209=
.774

2. Machine 2 Virtual Ubuntu using Vmware 8 cores

nick@nickvm:~$ sudo evl test
[sudo] password for nick:
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
sched-quota-accuracy: 80.8%
sched-tp-accuracy: OK
sched-tp-overrun: OK
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK
nick@nickvm:~$ sudo latmus -P 10
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 10, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|   -929.993|    174.488|   2600.458|       5|     0|   -929.993|   2600=
.458
RTD|     18.963|    297.375|    983.319|       5|     0|   -929.993|   2600=
.458
RTD|     19.865|    298.184|   2808.978|       7|     0|   -929.993|   2808=
.978
RTD|   -979.453|    -19.014|   1014.285|       8|     0|   -979.453|   2808=
.978
RTD|   -911.677|      7.487|   1587.974|      10|     0|   -979.453|   2808=
.978
RTD|   -979.476|   -677.605|    -52.038|      10|     0|   -979.476|   2808=
.978
RTD|   -918.623|     95.344|   2168.010|      12|     0|   -979.476|   2808=
.978
RTD|     84.914|    365.212|    963.395|      12|     0|   -979.476|   2808=
.978
RTD|   -919.064|    -66.003|   1421.899|      14|     0|   -979.476|   2808=
.978
RTD|   -930.611|     71.721|    754.604|      14|     0|   -979.476|   2808=
.978
RTD|     63.837|    359.260|   2245.524|      16|     0|   -979.476|   2808=
.978
RTD|   -910.610|    181.606|   1004.474|      17|     0|   -979.476|   2808=
.978
^C---|-----------|-----------|-----------|--------|------|-----------------=
------
RTS|   -979.476|     92.452|   2808.978|      18|     0|      00:00:12/00:0=
0:12
nick@nickvm:~$ sudo latmus -P 99
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 99, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     68.162|    391.712|   1611.035|       2|     0|     68.162|   1611=
.035
RTD|   -912.291|   -475.666|   1010.092|       3|     0|   -912.291|   1611=
.035
RTD|   -918.423|    119.871|   1937.203|       4|     0|   -918.423|   1937=
.203
RTD|     60.344|    387.485|    903.844|       4|     0|   -918.423|   1937=
.203
RTD|     76.729|    388.215|    980.691|       4|     0|   -918.423|   1937=
.203
RTD|     71.667|    379.802|   1528.251|       5|     0|   -918.423|   1937=
.203
RTD|     64.122|    391.833|   1084.815|       6|     0|   -918.423|   1937=
.203
RTD|   -923.345|   -162.983|   1046.850|       8|     0|   -923.345|   1937=
.203
RTD|     56.628|    402.514|   1140.448|       9|     0|   -923.345|   1937=
.203
RTD|   -911.562|    231.340|   1141.412|      11|     0|   -923.345|   1937=
.203
RTD|   -928.371|   -361.258|    869.662|      11|     0|   -928.371|   1937=
.203
RTD|     71.141|    396.117|    976.691|      11|     0|   -928.371|   1937=
.203
RTD|     63.273|    393.677|    946.488|      11|     0|   -928.371|   1937=
.203
RTD|     70.335|    401.533|    942.252|      11|     0|   -928.371|   1937=
.203
RTD|     71.243|    395.450|    857.735|      11|     0|   -928.371|   1937=
.203
RTD|     66.630|    401.924|   1087.476|      12|     0|   -928.371|   1937=
.203
RTD|     68.832|    396.441|   2199.416|      14|     0|   -928.371|   2199=
.416
RTD|     83.153|    388.793|   1171.043|      15|     0|   -928.371|   2199=
.416
RTD|     76.944|    406.898|   1074.956|      16|     0|   -928.371|   2199=
.416
RTD|     71.327|    394.167|    986.145|      16|     0|   -928.371|   2199=
.416
RTD|   -944.379|    -77.007|   1662.945|      18|     0|   -944.379|   2199=
.416

Best Regards,
Nick Xie

-----Original Message-----
From: Xie, Nick
Sent: Friday, September 19, 2025 12:36 PM
To: 'Jan Kiszka' <jan.kiszka@siemens.com>; Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: Error during libevl build and runtime settings failed

Hi Jan and Philippe,

Thank you for your quick respond. Appreciate it. I didn't notice the error =
was generate in early stage. I have fixed that. I have built the kernel suc=
cessfully and install libevl 5.5 without error, but there is error when I r=
an the evl test. Do you have any idea? Thank you in advance.


nick2@Xenomai22:~$ uname -a
Linux Xenomai22 6.12.30+ #1 SMP PREEMPT_DYNAMIC EVL Fri Sep 19 07:59:54 PDT=
 2025 x86_64 x86_64 x86_64 GNU/Linux nick2@Xenomai22:~$ sudo evl test [sudo=
] password for nick2:
basic-xbuf: OK
../libevl/tests/clock-timer-periodic.c:43: FAILED: ticks =3D=3D 1 (=3Dfalse=
)
** clock-timer-periodic: BROKEN

Best Regards,
Nick Xie

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Friday, September 19, 2025 2:18 AM
To: Xie, Nick <nick.xie@festo.com>; Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: Re: Error during libevl build and runtime settings failed

CAUTION: This e-mail is from an external sender. Do not click links, open a=
ttachments or provide your password, unless you know the content is safe! I=
f unsure, report the e-mail using the Outlook button.


On 18.09.25 23:58, Xie, Nick wrote:
> Hi Philippe,
>
> Thank you for your suggestion. After some investigation, my previous erro=
r is caused by I download evl as tar.gz(it is missing the hidden git folder=
), because my network was not stable. I used git clone to download this tim=
e on a virtualbox (it is easier to output the kernel console in serial)and =
find out the config file is the problem.
> I was followed the link(https://kernelnewbies.org/KernelBuild) from xenom=
ai.org. As it suggests using "make defconfig" which will generate new .conf=
ig file, overwrite one I copy from the current kernel. I used "make olddefc=
onfig" instead to fill in the config and it built successful on my linux PC=
 and I can start the kernel and the evl test correctly. I will continue tes=
ting tomorrow. But there is a problem with another test on my virtual machi=
ne using virtualbox. I followed the same steps and the error was showed bel=
ow during make. If I used "make defconfig", the make will be successful but=
 there will be a problem on boot. Do you have any idea? Please advise.
>
>   CC      kernel/tsacct.o
>   CC      kernel/tracepoint.o
>   CC      kernel/latencytop.o
>   CC      kernel/irq_work.o
>   CC      kernel/dovetail.o
>   CC      kernel/static_call.o
>   CC      kernel/static_call_inline.o
>   CC      kernel/user-return-notifier.o
>   CC      kernel/padata.o
>   CC      kernel/jump_label.o
>   CC      kernel/context_tracking.o
>   CC      kernel/iomem.o
>   CC      kernel/rseq.o
>   CC      kernel/watch_queue.o
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     kernel/kheaders_data.tar.xz
>   AR      kernel/built-in.a
>   CC [M]  kernel/kheaders.o
> make[1]: *** [/home/nick2/linux-evl/Makefile:1949: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

You always need to look at the first sign of an error, not the last one.

FWIW, xenomai-images is capable of generating full images also with evl (ag=
ain - changes in next branch only), for qemu or real x86 hardware.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center
