Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441891F4736
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022070; cv=fail; b=cWfrwneP3wTsljCaLckgO2aL1RrlY4yoE3zxn1c7fLlbKP7RbYJpb7bj3ed/gpaum3QZ9TnAFEhd96xNPAl9xwSJGqGTFxYJc9Q/9pahe//Ma1DMYsTX8aHvYIYyCa3lnrxgBl9DkK08CfzBBLe9vfgxkPFPTmNI+wBuO6Y0pK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022070; c=relaxed/simple;
	bh=AEseies8w1mYV0uHb4YJJVlZpYmlriSKL3djOx85zDg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcMzkKLiPQ8V++Jvu6VDL+7tyZCJdyWB+2IqqMmap+YzYzCdk7eAHjG1g/JqXUq4z6B8qLxj3EbkusKRARTNmqf6s3CE4JbQneaxuuT6YeJ6Mih1SbiRKfAad7HWomxFEIsVmkXf2Sdknpeu8BLh1KjjDO5ThM0t2yNi01/pQY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cae.com; spf=pass smtp.mailfrom=cae.com; dkim=pass (2048-bit key) header.d=cae.com header.i=@cae.com header.b=FBacN8Nm; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cae.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cae.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cae.com header.i=@cae.com header.b="FBacN8Nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUO+V4d8jaGzREBfz3VE/1pvny6jsquzwuZSXzot9xYFzM795gOeemijoJVmvejeIDKERmN9jqFhvUanMDcPxtb1zjPyXMEfUgYXWN0H1n/reBRlzsClRpAdxiBBHoeG/imbBQ6tmVVLAFgH32kARbHNH0X02+fFPqr3rx5Zi27zjLEUeqJx2AIVbD+HgtbED9b50Z2h6xDuh8L3zYcGOryk1HGMHkdA9IThEojKzHDVpGNA2ByKB7A7Llkk2COiF3dAIXDAfmQnN5OhfNiWkkQKnvVPJeW4L58dmlOSzlYjIx+0Z16PkoPRRjwLebG74QeCxzE1wXpdNsMc2mMQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEseies8w1mYV0uHb4YJJVlZpYmlriSKL3djOx85zDg=;
 b=b+LAnYVlq/Kz5JfbcTgEkIUs0VdgVR2P2lcU2aNfx5r0sJStRyAA3+Jeol1G/x+ioDoLP0KiXo7nr0YivICdcTzcDbsFMvbn30j642GCNykSPblcKIDPOuLdcYWSSfpP1CNjx3KM6eO1Pqk0wYkHszy3itb5QXkTuveALN+xxnN2hiSssRdQplOY/Tefu3YIPcmFUxpZQMgFzgpv1hOnqLgcl2D0B4ni/Moy1cixlSDlfULgaCIzBwvgVpLRzSt/LktaDK54SCrgk4oeOtXKyYeIfpmks+x5FzoFTXpBhulDTo4m53MYNGDoxwz8FTmENdj7eMUsCANFUXva4CTEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cae.com; dmarc=pass action=none header.from=cae.com; dkim=pass
 header.d=cae.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cae.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEseies8w1mYV0uHb4YJJVlZpYmlriSKL3djOx85zDg=;
 b=FBacN8NmNRa4H2DKpdg4TvTgIJTj8JSrDZxiMv0Cun5QFohj7d+DX5tkVDD6kb/2a1GSBrlBkzcd1qgVTJj71BUqPE4Uojrk4jDHCaizShHA2rA3yB7S2mrcGMExDyP72dlDc9B4966MtzD/NBjJ6Bgv1WbGJSvhk+XBBG3Y8AWidxpkpHWgn7YtdUKayMXGNVVm8AXnoOD5pL+WvDu0ZB6z9o34iAYOVbI8RWzHo01oLxiAlK0wSlVdo9kmXY8AtN+6vfS8mLNJllBtCMTAhMbj05tyJUpiOoXZbIiIUUeTokT/pGjCuXvZogZWL5CdS7fB86/qouHn+hYk5pc+hg==
Received: from DB9PR09MB6032.eurprd09.prod.outlook.com (2603:10a6:10:3d8::14)
 by AM7PR09MB3909.eurprd09.prod.outlook.com (2603:10a6:20b:121::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 20:47:44 +0000
Received: from DB9PR09MB6032.eurprd09.prod.outlook.com
 ([fe80::bcc:da34:bdeb:1158]) by DB9PR09MB6032.eurprd09.prod.outlook.com
 ([fe80::bcc:da34:bdeb:1158%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 20:47:44 +0000
From: Yann Le Chevoir <yann.lechevoir@cae.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai 3 and Linux Dovetail Compatibility Table
Thread-Topic: Xenomai 3 and Linux Dovetail Compatibility Table
Thread-Index: Aduej8lZIXPEjjzTT9Wdqoi1NJTa3QAAFvTA
Date: Wed, 26 Mar 2025 20:47:44 +0000
Message-ID:
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
References:
 <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
In-Reply-To:
 <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHlsY2hldm9pclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLThmZGVhY2JiLTBhODMtMTFmMC1iZWFjLWEwZTcwYjJlYzZiZVxhbWUtdGVzdFw4ZmRlYWNiZC0wYTgzLTExZjAtYmVhYy1hMGU3MGIyZWM2YmVib2R5LnR4dCIgc3o9IjE5NDgiIHQ9IjEzMzg3NDk1NjYyOTQ1ODI4MCIgaD0iZkFaYUdlU0VDSFc2eityUFYvcnZFNXBkNEo4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cae.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6032:EE_|AM7PR09MB3909:EE_
x-ms-office365-filtering-correlation-id: eb4cb3cc-d942-42a6-a369-08dd6ca775cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tzd4RTFOTzRzcUd6ZFJ2ZS8zclJRSnArU2lKQ21jcTZ5RG41bUVhaStnT3pK?=
 =?utf-8?B?RUZSa0lUMFpPbndJZWgrcGZxUW1CWFY0S2tpOGNwVTZVOTQvN0VXczJucEUy?=
 =?utf-8?B?RXBjcm9TY3ZLbnZYb2pka1hST3NpNUxndXZxNkxMRUtnUUMrK0ZUb0hzUFZO?=
 =?utf-8?B?NFFWVUVzWWI4MXlwTGlZcWlwY0JySEdPcTcwY29ya1hyWnE3QzFxZlN5U1d2?=
 =?utf-8?B?ZERvUXZPN2cxTUR2NXdibTRLN2NlbFk2VTFtTHV1TmxvM3pseENiM3B6ZCtD?=
 =?utf-8?B?SnBTMktzVTFkdWZXZzM5QXd4R1IrWDlRa3lha0cwWXpsZ2djVnRFK3JZVFZh?=
 =?utf-8?B?T0VXbDYxUlZ6YzZSK1pFcTFZb1dHU3RZWWxPL3dOTEx5TDQxN2FoTGJWODMz?=
 =?utf-8?B?d3JyT0JISXRsQVZheHpYVVlWU1ZYTmNLQlNUT0hJSDZNMUxSRjNPcTEwVElN?=
 =?utf-8?B?WmtoLzdFOWEvSDYxdENKOS9aZkt3MFlWV1p2eWtLYk13SmhlVUgrbDFMdk9M?=
 =?utf-8?B?NEEzbUsvaDJtTi9yR041R3hGMHAzNTB6TGE1cGpSUEdoY1lZWEphejYyNStj?=
 =?utf-8?B?bVRZWmNyVWlKcVpscDRKbk4rQUJENFBKUHFKNzA4SUR5UTRsQ1N0ZDJJQTBL?=
 =?utf-8?B?UWEveUhLSFI0TCtLR2ZURllVU1lXOXVqUHJScFVoRlI0RWRRaGlwRXJDTVda?=
 =?utf-8?B?VXBRc05GRXg3Q25vWFA4UXBJVlpqeXhrbktjUTdlcVZqZkROMFBhTG52a2Mx?=
 =?utf-8?B?ZXZHenAwMTRZMHRKRkZFbDg0Yk1HakNEc0NKdVFzYVRmUVBpMGJCVDlFNGlU?=
 =?utf-8?B?ZVd1NXpERG9lMXd4Q1BKMDlKRHJZQXNwZkw5ZllQQ1JVaGZQN0pNTVlEbVZE?=
 =?utf-8?B?R005dkR4T0hhZjFPdk9EQkRCMkxOK0N6c3lMQklWTlUyVkg0SGt1c082N3B3?=
 =?utf-8?B?R2hMUXpIYUowOFY4TWMrUDFjcnlUMHNXNVM1TmNyU2NsaFVUeDFzUDlZRlJE?=
 =?utf-8?B?eHZxREpIMC9LNStQQ0RIYUovYWxDM25keUJObC9xQzJmRmg2OTYwSWtNVUdo?=
 =?utf-8?B?bnJsakF3L0piU3Z3VDBEMmFNb3NvM0RSYS9RZ2tuRkJDditTejUyMVJOdTRJ?=
 =?utf-8?B?dDhwSG4wc1RjYTJEcmhvN3gxQzRaZDBnYnBqY3BGUGV0clgvb21sN2c0NFo2?=
 =?utf-8?B?WmdiNmR1eVFwUVJROW85YWx4RGdvTmc0Vk1ZQkwxWnl1MmczM200WDdsVEJv?=
 =?utf-8?B?aXN2bW80L0pPU3ZUZElGQUhjRmxQMjNWZ0hQVnphTWJkdjVITmFEdFJPRmVJ?=
 =?utf-8?B?cTdOVjY2Z29iMjFkUFZ0ZnBHaWt2RTdqWVk3NURaZFZIN2FiUHo1Z092ell4?=
 =?utf-8?B?cEg2cnJjZHlRemsvZkZyN2xKdmVmRi9BdWVhVWhmYjFBMFN0eVk3eXlCbUtN?=
 =?utf-8?B?MENaQWVxY3BwK2VNYzg4bUZlTXYzVFRTc0pveWoxcnBvcFJlV3lLVWpOVEpC?=
 =?utf-8?B?akFsUVMwUkNOOHB2Um1XVkI5OHc1ZmducVRKNWdTd3UvSXR0N01ab1JvSGN0?=
 =?utf-8?B?N1dTcFNubGVDS2pQYS9zclZwWXRncDZYUHYzSElqVyswOUlzVU9iMlg0SEdn?=
 =?utf-8?B?VjNRU1JuNzdzK0xIUzdJMU11YVRzRzZZb291dHR3YlU1amxtL0JiNnMvakxI?=
 =?utf-8?B?QjAxUXB2VTZnWFRIWG5TbXVWdko5SGhJZWdLWjd6USs4MjNaNWZOM2w5RDFm?=
 =?utf-8?B?bWFLZ2tVdDVVaXZOcHprdnU2eUhDR1BReGlXdDA3ek5qWFR3dkRNWC8ra1FF?=
 =?utf-8?B?eFJmbU5ZZk84ZCtpU2tYSURSUmZKZ2hyQkRPYnZ4NTRoZ2ZYS2hBTU1uRUYz?=
 =?utf-8?B?bTRpUDE3YmtsdCtXbHc3MmVnaTgrQnE4MXlIYWxUb3dkS1ZxZDNhRDJpZXVE?=
 =?utf-8?Q?GmMWf27cmbh+kgIM0Xf+Y+b5JqnatyDO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR09MB6032.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTQ1S1haNVBCRmExSlZuUldkaEhsSVVBZUdzNFJhVXBXV3JrQmgzbGtPK2U2?=
 =?utf-8?B?Z3hqbzFreGVwMHZKb1IrZ0JWK0dpMzcvbG9xVU42bmpNNVhtL2NHeEZsTnJ0?=
 =?utf-8?B?TGkzSXh4ZDF1TXF3eTJ0bmtBV3BGRU5CZTYwVEtUTVVHb09mS1BTYnVVU2tu?=
 =?utf-8?B?MWFva0QzWGxSVXNxV1c4dm9Wbmt1S0JjVytxcW1hQVZjaVZNNDNSbnc5ZmFS?=
 =?utf-8?B?eHgvdE03VzhlWU9ScnIyNVhNTWdYVUxnSDY5ZHRNTXFMNXdCNTUrMWNHdXRE?=
 =?utf-8?B?YXczbHZBZVNBOXIvZFNYODNyb3RFVXRMMU5YNk10amRudkpTK2RVNXp0MDhw?=
 =?utf-8?B?VkJxd0pLdm8zSW5SNG1Yb0dLYnErczhnNU1WMlV0UldzRktEbGhSWFNsVUx2?=
 =?utf-8?B?Yi9rNm9yU0N4eFhNY2dyWThJWENWYk0raFhLZmNRaFd4UnBTdWRXZHprc052?=
 =?utf-8?B?TENSWkNTMHpNSjlJS0tPWW9UZlExYlA5b1cxUGRlZVIzTUZkM3UzQTF0WWxk?=
 =?utf-8?B?bUtKMm5Jb3pJS0lOSG10V1BpODFwVlBsdFFjcWlPNklpWEF5SU9IeUZuWDVw?=
 =?utf-8?B?UUQ5NUx2Ykh1VjNXTmpSdHI5M2E1UnlRZFJTMjAxdk8wU3NsSTY5TllWYXNG?=
 =?utf-8?B?Tys5eVZ5NnNMb3gzZnFuMjNFM3dIWUY2RlAzY0tUWlJYNzlHZFpsQnFnZU1Z?=
 =?utf-8?B?cHRrRHJyQ3lJRXB1WDlJZUk1TkZJU2hsZ1lQT3phNERJWjVrKzUvcHNIRWJD?=
 =?utf-8?B?RU9GLzMydTNDczBMdTFaaWIrdy8rWTV4akI5cmhrSmFEU21TVjZPWDFGOVJx?=
 =?utf-8?B?ekhrb3JZZWkzMkxqTlM2OW9weHBnMnRUbFdhSmZhR29QZ1JhZVY1aE1PRy9t?=
 =?utf-8?B?Y21IdFF1T2JvVE42SXk2aGF0WE9RL3phdzBMVWFFNEppZldTSW1WY3k3UzNL?=
 =?utf-8?B?VlVRSzJSZ0xtLzRIRHFXZ3BNd3FoWlBzYm8xNlJFZjlGYmR6aEJaL3dIc09O?=
 =?utf-8?B?WXR3Y29CbEJVb29sUTlWeklObEg5bmdVbWU1N3d5cHdDMk12ZWdXd05PV3Jr?=
 =?utf-8?B?TkR6eiszdE5NSjFxbUlCR0Nra2ZxQTBzc1pmT1hZaVZCUllGRHhoZ2pLbS9T?=
 =?utf-8?B?SEE4azZxTUxhc2xUUEJ0NXBDUzBNT25EbmRtOGQrRkRIY0pwSnYzbVZweUpZ?=
 =?utf-8?B?ajJvQzJXL1BIRG1YRWtDTnJTVnM4cEk2cXZwMWRHamZhb0RpR0ZNVktGTEQ3?=
 =?utf-8?B?ak45TEYyTjhReElsYS8wUU5GTk44dEtaekxUaDEvZ0YvYmU0ZFRyVEtHQnNK?=
 =?utf-8?B?SDluYkJjUS9iV1NzZlVxVDNaNzkrSURqR1FGTVQ0V2txU29YbmxaYjVKWEgx?=
 =?utf-8?B?c0k2SGRHN1JDMmR0SlU2dkgrNGlEcW4raFVqMDI1NWNTUklIM2YyVlNpSVRP?=
 =?utf-8?B?Umw0bERKb1NwSHYrYlZYQjBHQWRRL3B4dW56ZFUvbjEvOGZYZ2FxZ3NiY3VW?=
 =?utf-8?B?RzhFbkV6WVlmd05aOVBDd2ZBdks5RjNwWXRqS2IxVldxT05lc3pCbFVsK21j?=
 =?utf-8?B?VmhaOEJUdW5mRFEwUWZMbVJPNFRMNWhHdEprQ1ByV3k5cU1jVjU1MlhxYm5X?=
 =?utf-8?B?Q2lVd3gwRE1jek9tdlBFMlZpdW9wbjUzMHNWaUVPV3VodStHS29Ea2N1K215?=
 =?utf-8?B?eTRXYUpNM2R5SW1hazBiaXFnVkVyTk9tUUQ4M2plckhaNkw1cHo3RHFuV3BI?=
 =?utf-8?B?V2hBMFF5T2hDVCtvY1h1SkR3STdHMDBnYWtLYUxYOEt6NzJDOGVldnFJNjFX?=
 =?utf-8?B?UjVxdkM4amVuN3dYTGE1T3E3NTE4dHRPQmJmcHJUZ01BeEs0alRTaEo1SjJM?=
 =?utf-8?B?TVJrRWV4MDlTN1JodWdkU28vTER6aWhBQ2Z1QVV6VHEyWkNlTjRORXNhQzVF?=
 =?utf-8?B?VlBkY1doeXMxOWJEL1JRNDhBTjZDSEVnaytCK0RuYUt0NzBjYVU1bHFKeXkv?=
 =?utf-8?B?eWFqQVhudHpXa0ZGY2d2alRwcmxTYnlPUVFvMTZ0R1FrVTM2WkxjZGNQRStF?=
 =?utf-8?B?ajNLekFVaGhhVDdyajlrQlorVHV6OVY5LzdGNDBCeFN0NVkwQ0trZThkc2xN?=
 =?utf-8?Q?/67uqBHlfGin1kRzA6ovktY+b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cae.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6032.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4cb3cc-d942-42a6-a369-08dd6ca775cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 20:47:44.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 006c1e48-e342-47e9-ab5d-0dd9ff89bd96
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTWoRN6+seydLrGI8JTYW2cXmAaM8NBbVJXZBcTlyvBeON5jnz+hi2Jxa5aoE2MCawZ2YrCB+XUdTvdWhe4KCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3909

SGVsbG8gZXZlcnlvbmUsDQoNCldlIHByZXZpb3VzbHkgZGlzY3Vzc2VkIHdoZW4gSSBpbnN0YWxs
ZWQgWGVub21haSAzLjAuOSBvbiBhbiBpbXg2cSB3aXRoIExpbnV4IDQuOSArIEktUGlwZS4NCkl0
J3Mgd29ya2luZyB3ZWxsIQ0KDQpJIGFtIG5vdyB0cnlpbmcgdG8gbWlncmF0ZSB0aGlzIHdvcmsg
dG8gb3VyIGlteDggd2l0aCBMaW51eCA2LjYuMjMgKyBEb3ZldGFpbCArIFhlbm9tYWkgMy4yLjYg
KD8pLg0KSSBhbHNvIHBsYW4gdG8gdHJ5IFhlbm9tYWkgNCBhZnRlciBiZWNvbWluZyBmYW1pbGlh
ciB3aXRoIHRoZSBsYXRlc3QgWGVub21haSAzLg0KDQpBdCBmaXJzdCBnbGFuY2UsIEkgZmluZCBp
dCBkaWZmaWN1bHQgdG8gZGV0ZXJtaW5lIHdoaWNoIHZlcnNpb25zIGFyZSBzdXBwb3NlZCB0byB3
b3JrIHRvZ2V0aGVyLg0KRGlkIEkgbWlzcyBhIGNvbXBhdGliaWxpdHkgdGFibGUgc29tZXdoZXJl
Pw0KDQpBZnRlciBzdWNjZXNzZnVsbHkgcHJlcGFyaW5nIHRoZSBrZXJuZWwgbGludXgtZG92ZXRh
aWwtdjYuNi4yMy1kb3ZldGFpbDIgKyBYZW5vbWFpIDMuMi42ICh1c2luZyB0aGUgdGFyYmFsbCBh
c3NvY2lhdGVkIHdpdGggdGhlIHRhZyksDQpJIGVuY291bnRlcmVkIGEgcmVkZWZpbml0aW9uIGlz
c3VlIHdpdGjCoERFRklORV9TRU1BUEhPUkXCoGluwqBydGNhbl9kZXYuYywgd2hpY2ggZG9lcyBu
b3QgY29tcGlsZSwNCmFsb25nIHdpdGggb3RoZXIgY29tcGlsYXRpb24gaXNzdWVzIHdoZW4gZml4
aW5nIHRoaXMgb25lLg0KDQpTaG91bGQgSSB0cnkgWGVub21haSAzLjM/IA0KQW55IG90aGVyIHJl
Y29tbWVuZGF0aW9ucyBmb3IgdGhpcyBtaWdyYXRpb24/DQoNCkFsbCBpbnB1dHMgYXJlIGFwcHJl
Y2lhdGVkLCB0aGFua3MgZm9yIHlvdXIgaGVscCENCg0KWWFubg0KDQo=
