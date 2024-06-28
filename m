Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3C1BE852
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586938; cv=fail; b=cccWX3s7NYD8e/Fo7fwfQ8W2tdxZfX1+r7XlWmI4bImYcOKtBR8zvoX0IOiIc/f340XuYNHICc0xwdVdKBte1T3m3VQPRcU/MBCjjnpsRQS3kKymt6OSm5Rereyxr/hQoncjw/eeW1wjXBt9Il4y0w8jYwQCmWtctFocnsu4vI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586938; c=relaxed/simple;
	bh=GBT2zlN1VnZM+MsqqXF6LjZVJtflAtjbwrMwV3MTrw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jazK0NWBSmHjNrxBXCzX+sVQIpATvbpt4nXDcAjWIhUjDXAlIFU+w05VBkK3X3ihfHHl9nyhDGe1ADfcZIhirDyxsBMMN3nF5efmybyQ0H171bmnUriQJyUA+Ggvq0Ad8j1znMrlH0BmgWJDf+0YPTp9v6jm7H2DCp6dv6QCVcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Eo73aeLN; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Eo73aeLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oel4vxM1utmL9Le7mywDTibJYAjNoQdHOsePCdy4it+GQWPq/pi02UaI2vL9LXdrYc/GBnEEB7CkDZyqeR+2dMTUQZj6Kb5KEmJ3OpQDG+eQD0vRtAn3QAI7XEUhyn7OvjW4J3aULEJTy5ZnDDitc4ODAFK5M5LTtkhztHUWQlqi1McPrxrMDJ9xFzVz1Y5fTDaqCzqzJQAr6Hl5Et9GEsRpKmmewBUczGOikJa5RZEjdMiTO8K716UeDT4nIwrN1xrDRfP9TzZlzy4eLQwZAiqXqwLhbJAUSsGuMO46BTSgZfUwilTXDT8LBUEzEXRqwsPEjW3rCCmYyuGlmNdtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBT2zlN1VnZM+MsqqXF6LjZVJtflAtjbwrMwV3MTrw0=;
 b=iEyw2AF5ncKBSblc3gEbDVzkKphIaHiBPB9fpLtnrpFf8adbb465hXGHQ0uGbDK0wJ3uQ7HfhRsUEObBi7iIDnlrOv+CaWicYoNwRE55pKK65P9Yh4zsXcHSUQ7TEy82hIi88BcupPRK247vzPZNMdnmKAuTAiFa7TEUgBDoHCtSs5hps/KGd7q7antCZiAxc1lMuyDmR9xwVaKhIDzKzoRrnitLmY30KvjMA5CkbVRnvg+fyqIyX9lR24lEaMeMlG2RdIIxI4jsvvFVpZSpexzvf+CU7VwXuC6sUKddJfsdY6dYSnCBnPVVhdxL6+vK5fAB+NFSuYayMTXtJ7uiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBT2zlN1VnZM+MsqqXF6LjZVJtflAtjbwrMwV3MTrw0=;
 b=Eo73aeLNruxwyQVlW50xYpx0I0f13HfGxERKg9wRar76zBrCrR31skZDsKIW8dtNLk89v9EPbiw8Q6VehV+j3nA3Vk81Ob7jRU69v9BITmVaLdAzB+/7UvimlrlxRbQ4mukfdjx0mrSvWeXG6BnJ/7GTVao34cVC6fSDv+Q8+H/p8PAV+LtDg0ihOdmiwqbQe9ZPizgE7IsqbY0di2KBbVSRL4uA+urs+DPLspCcMf7u0c5jZClNEbOfJ7UqdhuYDbKGlfGP6G2K8U/TywMdPaYW56sdmPEO3CiDw9omwCAXDxkSeuLsPkHKq3hK5E20MxKqXFH6Mn0dH7X1Xcv/Dw==
Received: from DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::11)
 by DU4PR10MB9165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 15:02:11 +0000
Received: from DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4753:3a2:d61c:4d46]) by DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4753:3a2:d61c:4d46%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 15:02:11 +0000
From: "Jiang, Yi" <yi.jiang@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH 3/4] ci: add kernel support for rpi4
Thread-Topic: [PATCH 3/4] ci: add kernel support for rpi4
Thread-Index: AQHayVWx8VECDJDwx0ySEGr+UYQowrHdG/+AgAAJOoCAABZcAIAACg2A
Date: Fri, 28 Jun 2024 15:02:11 +0000
Message-ID: <8fa17dc59073333182c99604e26aac9bac5fff77.camel@siemens.com>
References: <20240628122117.19059-1-yi.jiang@siemens.com>
	 <20240628122117.19059-4-yi.jiang@siemens.com>
	 <3565bbae-66df-40d5-b3e6-f70fa692378b@siemens.com>
	 <ee8023806d83f942c37369187e34692d83f39ddd.camel@siemens.com>
	 <b8bb88f6-d412-4986-8a4a-c08d09e8b84c@siemens.com>
In-Reply-To: <b8bb88f6-d412-4986-8a4a-c08d09e8b84c@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6226:EE_|DU4PR10MB9165:EE_
x-ms-office365-filtering-correlation-id: 5a3acae0-3e7d-468f-a4ef-08dc978349ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEt3NXJJenJOaUpuZWhVdGp4QVZhOWlHd2lMcGZiN2h3N3pjdWVsc0d2Tldv?=
 =?utf-8?B?MGNRakdOMUtWei9URWtwbEtvTWh2TnBDTEJKNk1nNk0vdnJJZURtMzhLaU1r?=
 =?utf-8?B?WDFuYitBakIzMTFmUmV6Z2cwOXZGVUhyRnJ1cmNNWExtZnhyNExReUQ3TTBZ?=
 =?utf-8?B?UVdrUzM0YjBmb0VrTlF6OGVHemZYR2NEeDZvUG5uOUh6bCs3M1c2cHhhYmll?=
 =?utf-8?B?SGNUcXZhZ3ByOHRqZ2pqQ1VrR1NEZk91N2tFZWJHV1NvUVdPdFBuQzVxTE1B?=
 =?utf-8?B?dXJsZmxaNGVLZGg0bWZudmhZRXc5TWZXb2o0eU51OHU2Yjd5NWVMMk1RS2dV?=
 =?utf-8?B?ZGVNM2x1bmgyS3UxUnpGeEhQUjUxTlNNUU4xeXR6MXl2RVp5cyt6YXpEMUp2?=
 =?utf-8?B?YVVWMC9NRnhYek9uZzJSb0V2NURzWHEzU2xVMU1xc0JPMERrSFlaejZyNkJM?=
 =?utf-8?B?TkYyTUZlUytyUEZmQWpGTDhOMGFmb044ZW53VitaT1lqcUowMDdYVFBBSlhC?=
 =?utf-8?B?M04yZFNhQ21wdHF6dFlFTGlWUzNDL1NMNVBNTEYzR2s5bGtlSDZUYU5KV0JM?=
 =?utf-8?B?cXlOaFhmeEhqMmhNNHM3dG50blp5MTdoc3BIRS9hZGdNK0tIRTFqa2E2OFFM?=
 =?utf-8?B?WTNjMllxK1U5QzlhK3lqakF0TGttZjFjOFl2bUo5UkFvd3IvTTl4Y0JCK243?=
 =?utf-8?B?VnZoczc0UGViVUNQeUE2V2pHMUFwSG9zL1FqOXJIOHhNTm11a0JKdmMzNjd0?=
 =?utf-8?B?Z2tlUk9Gck5ZS0JFVFVweitYQU5qZ1diSzJOSDcwdDhlV0xQU0xCNFgxY1hO?=
 =?utf-8?B?dUZ4dkVZaFJSNU0zODVxQytGTVRUZDVuUXV2Q3crOVczUVlNVjJZVUpNYk9k?=
 =?utf-8?B?OHMwcWF5N003bFJldmx2cFVMa1ZiMTdwTkRiVERIOHoxRWJmVWttYUtNSktm?=
 =?utf-8?B?MDUyVHErWDhORmFCd1lMOTF4akhqb0Y3WFEzQlF6VjdBMExNMU5KcGtKclI3?=
 =?utf-8?B?dUJERnRJWW45WlhsV0tibVdjV3pMMkE4UzZkUDg4VWFFWFZlTjM1TSt2V2dX?=
 =?utf-8?B?QkRtL2RIZU9zSjBWYmMrYkZMSzBDSnRKZWwwTHJDTy9lNUVwU2lrTVZnejNr?=
 =?utf-8?B?TllOMUw5UmpGR1JuQk9aUjBGUytjN2lrMDJHOXN6UElnNEcyb2p4cWJ5Vktz?=
 =?utf-8?B?ZXRZdGo1RzZ3Wi9rYnVpSHBCUm9tSFhzbTVNdWs0M1ZYOXdGMWJaL21HUFJF?=
 =?utf-8?B?eTdJOUJjczBZN2E5N3VkYVpOSzkvNDY0N05YRWhwZFBneGxHSkgzTFE3OFB1?=
 =?utf-8?B?L1QrWk9TQTdiZWw2YmRGMHBFSlFOZldDMXJxZEpRQ2dRSVRBQ056S3czM0dY?=
 =?utf-8?B?eUJtY3VXQjExazVFVVZkVWxTUExGZk11MkFESTE1Q3o1emNJQVhaaHJXMUd5?=
 =?utf-8?B?Z2tLdTMyMnpZVnhMdXhxTm5iMnF4R2tWZWw3cnhlbWU2U20yTDAveUVkNzBp?=
 =?utf-8?B?U1VRc0FkcHhpMGtwTDQ1SXVsSTBGV2RUNU96b1VPck9YWkEvcVR3cWJhMkdW?=
 =?utf-8?B?NkxVU3VkREx0VEVDMUxWMml4dzc0eTdxR3RSc1Znbk1IOTYwWU5CcUZFZ1hN?=
 =?utf-8?B?d1RKamQvTlNkVFJuOEx6cEhYSlFTcFljNTlnc0FOWUlTODYwMDVadWhrQnBn?=
 =?utf-8?B?OXZmaDE3UUZiNkNzSjBBWE9qQU1UVm9KVk1MRjFHbmN5bllYeElvYldGVTJK?=
 =?utf-8?B?ZGttSTRuNmxub01HbkhBZWt2cEN2NC9wVTh0dG1tYzlleGxyMkV5UmNBelBo?=
 =?utf-8?Q?ZMRFQLWeJwfaHRZ7to8FGJeGaAFEeDBFVNw7Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDVmelB0V0VEcmJVbFNWQWc5OVVlOGw1RyttS2JFNnh5NFZDT3FpTm1qamhj?=
 =?utf-8?B?Sk0xZHRFZGp1YWtoNHdGYnZNRXJHSDVZcndKbVhUcnBjekkrZjVDQXpQdEpl?=
 =?utf-8?B?WkV6azhyNjJsRDRhVEw5OG5MYnVZZk0vQ3p2ZkFWSTZQVzEvcTRpdTZ4UnFr?=
 =?utf-8?B?YlY1cWl1cFUrckpNWkYyT1Uwb1dZeDc4WVZuVlRpK1c1Vlh3eE9xdUdqTHJs?=
 =?utf-8?B?aVlqR2QxSmNvdDVFSk9uUkJzUmtxMmVNekxyY0U0djdCMHlXVDYrRXhxYUtw?=
 =?utf-8?B?TkdWelJwWmhZbGZLdVljYXhCd214M2tkVmFEM2JXcVgwRjI5L3RuSHN3dHQy?=
 =?utf-8?B?RVJ2bVEyWXNrank4Z3I1SmlxUDZkRk02b0M2emhjRWFWc01FWGxXejRhSmZ6?=
 =?utf-8?B?OWZFUmFjVVZPSHFlVGR5UkRuSS9QYjl4QkZTQ3hzQjI1QWtvOVA0M3VxbmQ4?=
 =?utf-8?B?VjM3R3ozOGxMOEpjblVyelFzUExtZXZIRUlFSnUrZHlFT1l1YzlkL1IwU3JF?=
 =?utf-8?B?dzNyWVA4T0kyT2VST0dHaVlLL3RaOEZDbkpCVWZpWUZMKzcwNTdnMXY1dWVm?=
 =?utf-8?B?VnJVZU9ZaldpU05WNE52YW1SZVNoTU5ZYmltQkNoTUxyOFIzM2dCeGdtS0Jj?=
 =?utf-8?B?NXJzaXVyQ1NCSGZyVlZIbmN5RlkzbDkyU3h0Tk5TRVdFNW8xTWRGOUE2cGNu?=
 =?utf-8?B?TC9KOER6VlBSTU1ET3VISmZWN3ZlMHE0YitTMTVnM050VjBmbDVPQVlwZk0w?=
 =?utf-8?B?clFQMGdmUFF3dENIQnVKTHhYaXJqbHp3T00wbXBuaVdST0p0aUlYazkzRjJO?=
 =?utf-8?B?QVVxbHcwa1k4VTRxM1FoT2ZsTjJYQ21kbVZ6UjBmak8wdU8vMXZnc2Q0WVQv?=
 =?utf-8?B?UmdORHJaRzVyV2lLTVJ6T2p2bkpRVHlza1pqdDNWWkVHMERyaWJtQzJzM3hR?=
 =?utf-8?B?VG5MMUlOQUpYTHhWYkRqc2hCMTZBaFFaMWVLazJza1dqTkpCSXltd3RHaDZv?=
 =?utf-8?B?NHFHZDlOTG53bklQL3cvd0Y2ZmUrUVovUzhMR0JrM25VMzBxaEdWYzc4VHVy?=
 =?utf-8?B?VUlsTUtlWUl5MEZlZzd6ZTRLVEsxUVFsY0hVU0U4UFJqVUZ6Tk9NMnhtTS9J?=
 =?utf-8?B?WDVrU0c4VEdGdkF0MUVuMzNCSHpJRDh0TmZWRlgrVXFWWEw0T3RrU001U0R5?=
 =?utf-8?B?THZUeXVHaXg5bU1BVkJUbmFhdEt5MTBWeElvazdpZnNWWEE3U0lDMGVTWTZR?=
 =?utf-8?B?bmJMWWhWbEc0TG83ZGlSNHRZR0hFTUptb25NL05EK3lIQThMbWZRbW50aUVn?=
 =?utf-8?B?THBYaEF2RFlRakJEbkE1K25GM2pPM0NNZVFiR21NOCttd1dORDNSL3dkcW10?=
 =?utf-8?B?Kzd0V3NDTGJvYnQ0UE0zaGd3TkJaRHNyNVVLYW1wMEtKR21xQld2L2FvSnF0?=
 =?utf-8?B?ME4zMjR6VjVqLzVCOE9zcjlwSVViQytLQm1GT2xtMXBRNDVPdlR4VWVnUDBE?=
 =?utf-8?B?R0RPUWI4OGUrTmtVZVVsdFlHRURwbDNUanp0Y1hzNjhBeFJ1K1c0czRjYXZ0?=
 =?utf-8?B?MWhMeFA3QUpyTDJHb0FRRWpYcDhGeTQ2WVFRb1dwSzAzemR4eTlRMDdIQlRi?=
 =?utf-8?B?SFZGSmNVOWJnaThidlhoL0lpT1E4NmF0aXZTbEtMWEYzY1hZaStIM2JzRHF0?=
 =?utf-8?B?UG5SQTZadVplQ3lqQW9ZWXltT2U1aUF1aVRHd3VsQ1B0OC9JY3hJNytCaGF0?=
 =?utf-8?B?VC90bS84V2RkVWFSMXpCMk0zcEVaQWE2THlWOFJsdHBEc25ZVnh4TGZ3dlVG?=
 =?utf-8?B?bWdyMEhyYm9mbnh3WUlsb04rTkFORk5NQ29YUWYyK1I4K3hQMldnTVVBai9h?=
 =?utf-8?B?QUJwY1k5UXBCM0s3WEZLekVHRzNrUHB3ZEVzOTgvQnoxMkJESGhHMWJ1M0J6?=
 =?utf-8?B?ekJXSEhKaFpVSm5VK2sxbjE1NEVDMzhSVTdkc3dpNjh5VmpIb2VuTFUzUzNw?=
 =?utf-8?B?WnNESW1VY3REZlIyVE1KSUN3R0VWYzdEalpUcElyRGZ3OEdtcis0VlhrY2hF?=
 =?utf-8?B?YW5QODU0RSsrVGw0YWJhY2dyTENPditpR0RMdUNjMmRQSTR3Zkw0bUNrMUVB?=
 =?utf-8?Q?ccTbjA8cHm1W+LFJ3BjYo3TpG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F7452CE7431FC499F93F0800F35FA81@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3acae0-3e7d-468f-a4ef-08dc978349ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 15:02:11.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+N7RLaPoCN/JdH0fMWUhpB6UyW1bJr3UYyXNnBBC9L6QdlsHJvZR061oQozl7PUnu/tPcqxO/rJhivm4X8yjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9165

T24gRnJpLCAyMDI0LTA2LTI4IGF0IDE2OjI2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBb
YWx3YXlzIHVzZSByZXBseS10by1hbGwgb24gbWFpbGluZyBsaXN0c10NCj4gDQo+IE9uIDI4LjA2
LjI0IDE1OjA2LCBKaWFuZywgWWkgKFQgQ0VEIE9FUy1ERSkgd3JvdGU6DQo+ID4gT24gRnJpLCAy
MDI0LTA2LTI4IGF0IDE0OjMzICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiA+ID4gT24gMjgu
MDYuMjQgMTQ6MjEsIFlpIEppYW5nIHdyb3RlOg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBK
aWFuZyA8eWkuamlhbmdAc2llbWVucy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGNpL2tl
cm5lbF81XzEwLnltbCB8IDE1ICsrKysrKysrKysrKysrLQ0KPiA+ID4gPiDCoGNpL2tlcm5lbF81
XzE1LnltbCB8IDE1ICsrKysrKysrKysrKysrLQ0KPiA+ID4gPiDCoGNpL2tlcm5lbF82XzEueW1s
wqAgfCAxNSArKysrKysrKysrKysrKy0NCj4gPiA+ID4gwqBjaS9rZXJuZWxfNl82LnltbMKgIHwg
MTMgKysrKysrKysrKysrKw0KPiA+ID4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9jaS9r
ZXJuZWxfNV8xMC55bWwgYi9jaS9rZXJuZWxfNV8xMC55bWwNCj4gPiA+ID4gaW5kZXggNDRjZDZk
Ni4uMzZjMmUwNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvY2kva2VybmVsXzVfMTAueW1sDQo+ID4g
PiA+ICsrKyBiL2NpL2tlcm5lbF81XzEwLnltbA0KPiA+ID4gPiBAQCAtMSw3ICsxLDcgQEANCj4g
PiA+ID4gwqAjDQo+ID4gPiA+IMKgIyBYZW5vbWFpIFJlYWwtVGltZSBTeXN0ZW0NCj4gPiA+ID4g
wqAjDQo+ID4gPiA+IC0jIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOSAtIDIwMjINCj4g
PiA+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDE5IC0gMjAyNA0KPiA+ID4gPiDC
oCMNCj4gPiA+ID4gwqAjIEF1dGhvcnM6DQo+ID4gPiA+IMKgI8KgIEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+ID4gPiA+IEBAIC02MSw2ICs2MSwxOSBAQCBsYXZhLXRlc3Qt
NS4xMDpoaWtleToNCj4gPiA+ID4gwqDCoCB2YXJpYWJsZXM6DQo+ID4gPiA+IMKgwqDCoMKgIEtF
Uk5FTF9WRVJTSU9OOiAiNS4xMCINCj4gPiA+ID4gwqANCj4gPiA+ID4gK2J1aWxkLTUuMTA6cnBp
NDoNCj4gPiA+ID4gK8KgIGV4dGVuZHM6IC5idWlsZDpycGk0DQo+ID4gPiA+ICvCoCB2YXJpYWJs
ZXM6DQo+ID4gPiA+ICvCoMKgwqAgTElOVVhfQlVJTERfT1BUSU9OOiAiOm9wdC1saW51eC1sYXRl
c3QtNS4xMC55bWwiDQo+ID4gPiA+ICvCoMKgwqAgS0VSTkVMX1ZFUlNJT046ICI1LjEwIg0KPiA+
ID4gPiArwqDCoMKgIENBQ0hFX0tFUk5FTDogZG92ZXRhaWwNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
bGF2YS10ZXN0LTUuMTA6cnBpNDoNCj4gPiA+ID4gK8KgIG5lZWRzOiBbICJidWlsZC01LjEwOnJw
aTQiIF0NCj4gPiA+ID4gK8KgIGV4dGVuZHM6IC5sYXZhLXRlc3Q6cnBpNA0KPiA+ID4gPiArwqAg
dmFyaWFibGVzOg0KPiA+ID4gPiArwqDCoMKgIEtFUk5FTF9WRVJTSU9OOiAiNS4xMCINCj4gPiA+
ID4gKw0KPiA+ID4gPiDCoGJ1aWxkLTUuMTA6YmVhZ2xlLWJvbmUtYmxhY2s6DQo+ID4gPiA+IMKg
wqAgZXh0ZW5kczogLmJ1aWxkOmJlYWdsZS1ib25lLWJsYWNrDQo+ID4gPiA+IMKgwqAgdmFyaWFi
bGVzOg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvY2kva2VybmVsXzVfMTUueW1sIGIvY2kva2VybmVs
XzVfMTUueW1sDQo+ID4gPiA+IGluZGV4IDUyNzEwZmQuLmUxNzI3NWEgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2NpL2tlcm5lbF81XzE1LnltbA0KPiA+ID4gPiArKysgYi9jaS9rZXJuZWxfNV8xNS55
bWwNCj4gPiA+ID4gQEAgLTEsNyArMSw3IEBADQo+ID4gPiA+IMKgIw0KPiA+ID4gPiDCoCMgWGVu
b21haSBSZWFsLVRpbWUgU3lzdGVtDQo+ID4gPiA+IMKgIw0KPiA+ID4gPiAtIyBDb3B5cmlnaHQg
KGMpIFNpZW1lbnMgQUcsIDIwMjINCj4gPiA+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFH
LCAyMDIyIC0gMjAyNA0KPiA+ID4gPiDCoCMNCj4gPiA+ID4gwqAjIEF1dGhvcnM6DQo+ID4gPiA+
IMKgI8KgIEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4gPiA+IEBAIC02
MSw2ICs2MSwxOSBAQCBsYXZhLXRlc3QtNS4xNTpoaWtleToNCj4gPiA+ID4gwqDCoCB2YXJpYWJs
ZXM6DQo+ID4gPiA+IMKgwqDCoMKgIEtFUk5FTF9WRVJTSU9OOiAiNS4xNSINCj4gPiA+ID4gwqAN
Cj4gPiA+ID4gK2J1aWxkLTUuMTU6cnBpNDoNCj4gPiA+ID4gK8KgIGV4dGVuZHM6IC5idWlsZDpy
cGk0DQo+ID4gPiA+ICvCoCB2YXJpYWJsZXM6DQo+ID4gPiA+ICvCoMKgwqAgTElOVVhfQlVJTERf
T1BUSU9OOiAiOm9wdC1saW51eC1sYXRlc3QtNS4xNS55bWwiDQo+ID4gPiA+ICvCoMKgwqAgS0VS
TkVMX1ZFUlNJT046ICI1LjE1Ig0KPiA+ID4gPiArwqDCoMKgIENBQ0hFX0tFUk5FTDogZG92ZXRh
aWwNCj4gPiA+ID4gKw0KPiA+ID4gPiArbGF2YS10ZXN0LTUuMTU6cnBpNDoNCj4gPiA+ID4gK8Kg
IG5lZWRzOiBbICJidWlsZC01LjE1OnJwaTQiIF0NCj4gPiA+ID4gK8KgIGV4dGVuZHM6IC5sYXZh
LXRlc3Q6cnBpNA0KPiA+ID4gPiArwqAgdmFyaWFibGVzOg0KPiA+ID4gPiArwqDCoMKgIEtFUk5F
TF9WRVJTSU9OOiAiNS4xNSINCj4gPiA+ID4gKw0KPiA+ID4gPiDCoGJ1aWxkLTUuMTU6YmVhZ2xl
LWJvbmUtYmxhY2s6DQo+ID4gPiA+IMKgwqAgZXh0ZW5kczogLmJ1aWxkOmJlYWdsZS1ib25lLWJs
YWNrDQo+ID4gPiA+IMKgwqAgdmFyaWFibGVzOg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvY2kva2Vy
bmVsXzZfMS55bWwgYi9jaS9rZXJuZWxfNl8xLnltbA0KPiA+ID4gPiBpbmRleCAxYzZhNmQ3Li5j
ZDc5MDZkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9jaS9rZXJuZWxfNl8xLnltbA0KPiA+ID4gPiAr
KysgYi9jaS9rZXJuZWxfNl8xLnltbA0KPiA+ID4gPiBAQCAtMSw3ICsxLDcgQEANCj4gPiA+ID4g
wqAjDQo+ID4gPiA+IMKgIyBYZW5vbWFpIFJlYWwtVGltZSBTeXN0ZW0NCj4gPiA+ID4gwqAjDQo+
ID4gPiA+IC0jIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMi0yMDIzDQo+ID4gPiA+ICsj
IENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMi0yMDI0DQo+ID4gPiA+IMKgIw0KPiA+ID4g
PiDCoCMgQXV0aG9yczoNCj4gPiA+ID4gwqAjwqAgSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4NCj4gPiA+ID4gQEAgLTYxLDYgKzYxLDE5IEBAIGxhdmEtdGVzdC02LjE6aGlrZXk6
DQo+ID4gPiA+IMKgwqAgdmFyaWFibGVzOg0KPiA+ID4gPiDCoMKgwqDCoCBLRVJORUxfVkVSU0lP
TjogIjYuMSINCj4gPiA+ID4gwqANCj4gPiA+ID4gK2J1aWxkLTYuMTpycGk0Og0KPiA+ID4gPiAr
wqAgZXh0ZW5kczogLmJ1aWxkOnJwaTQNCj4gPiA+ID4gK8KgIHZhcmlhYmxlczoNCj4gPiA+ID4g
K8KgwqDCoCBMSU5VWF9CVUlMRF9PUFRJT046ICI6b3B0LWxpbnV4LWxhdGVzdC02LjEueW1sIg0K
PiA+ID4gPiArwqDCoMKgIEtFUk5FTF9WRVJTSU9OOiAiNi4xIg0KPiA+ID4gPiArwqDCoMKgIENB
Q0hFX0tFUk5FTDogZG92ZXRhaWwNCj4gPiA+ID4gKw0KPiA+ID4gPiArbGF2YS10ZXN0LTYuMTpy
cGk0Og0KPiA+ID4gPiArwqAgbmVlZHM6IFsgImJ1aWxkLTYuMTpycGk0IiBdDQo+ID4gPiA+ICvC
oCBleHRlbmRzOiAubGF2YS10ZXN0OnJwaTQNCj4gPiA+ID4gK8KgIHZhcmlhYmxlczoNCj4gPiA+
ID4gK8KgwqDCoCBLRVJORUxfVkVSU0lPTjogIjYuMSINCj4gPiA+ID4gKw0KPiA+ID4gPiDCoGJ1
aWxkLTYuMTpiZWFnbGUtYm9uZS1ibGFjazoNCj4gPiA+ID4gwqDCoCBleHRlbmRzOiAuYnVpbGQ6
YmVhZ2xlLWJvbmUtYmxhY2sNCj4gPiA+ID4gwqDCoCB2YXJpYWJsZXM6DQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9jaS9rZXJuZWxfNl82LnltbCBiL2NpL2tlcm5lbF82XzYueW1sDQo+ID4gPiA+IGlu
ZGV4IGYxM2QyOGQuLmQ4NDBkMjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2NpL2tlcm5lbF82XzYu
eW1sDQo+ID4gPiA+ICsrKyBiL2NpL2tlcm5lbF82XzYueW1sDQo+ID4gPiA+IEBAIC02MSw2ICs2
MSwxOSBAQCBsYXZhLXRlc3QtNi42Omhpa2V5Og0KPiA+ID4gPiDCoMKgIHZhcmlhYmxlczoNCj4g
PiA+ID4gwqDCoMKgwqAgS0VSTkVMX1ZFUlNJT046ICI2LjYiDQo+ID4gPiA+IMKgDQo+ID4gPiA+
ICtidWlsZC02LjY6cnBpNDoNCj4gPiA+ID4gK8KgIGV4dGVuZHM6IC5idWlsZDpycGk0DQo+ID4g
PiA+ICvCoCB2YXJpYWJsZXM6DQo+ID4gPiA+ICvCoMKgwqAgTElOVVhfQlVJTERfT1BUSU9OOiAi
Om9wdC1saW51eC1sYXRlc3QtNi42LnltbCINCj4gPiA+ID4gK8KgwqDCoCBLRVJORUxfVkVSU0lP
TjogIjYuNiINCj4gPiA+ID4gK8KgwqDCoCBDQUNIRV9LRVJORUw6IGRvdmV0YWlsDQo+ID4gPiA+
ICsNCj4gPiA+ID4gK2xhdmEtdGVzdC02LjY6cnBpNDoNCj4gPiA+ID4gK8KgIG5lZWRzOiBbICJi
dWlsZC02LjY6cnBpNCIgXQ0KPiA+ID4gPiArwqAgZXh0ZW5kczogLmxhdmEtdGVzdDpycGk0DQo+
ID4gPiA+ICvCoCB2YXJpYWJsZXM6DQo+ID4gPiA+ICvCoMKgwqAgS0VSTkVMX1ZFUlNJT046ICI2
LjYiDQo+ID4gPiA+ICsNCj4gPiA+ID4gwqBidWlsZC02LjY6YmVhZ2xlLWJvbmUtYmxhY2s6DQo+
ID4gPiA+IMKgwqAgZXh0ZW5kczogLmJ1aWxkOmJlYWdsZS1ib25lLWJsYWNrDQo+ID4gPiA+IMKg
wqAgdmFyaWFibGVzOg0KPiA+ID4gDQo+ID4gPiBUd28gdGhpbmdzOg0KPiA+ID4gDQo+ID4gPiDC
oC0gSSBzdHJvbmdseSBzdXNwZWN0IHRoYXQgcGF0Y2ggNCBuZWVkcyB0byBjb21lIGZpcnN0LCBv
ciB0aGlzDQo+ID4gPiBwYXRjaA0KPiA+ID4gwqDCoCB3aWxsIGJyZWFrIENJDQo+ID4gPiANCj4g
PiANCj4gPiBEb2VzIGl0IG1lYW4gdGhhdCBjaS9naXRsYWItY2ktYmFzZS55bWwgZGVwZW5kcyBv
bg0KPiA+IHRlc3RzL2pvYnMveGVub21haS0NCj4gPiBycGk0LnltbCwgc28gdGhhdCBjaS9naXRs
YWItY2ktYmFzZS55bWwgd2lsbCBjcmFzaCBpZiBpdCBkaWQgbm90DQo+ID4gZGV0ZWN0DQo+ID4g
dGVzdHMvam9icy94ZW5vbWFpLXJwaTQueW1sPw0KPiANCj4gV2VsbCwgeW91IGV4dGVuZCB0aGUg
cGlwZWxpbmUgaW4gdGhpcyBwYXRjaCB0byBydW4gUlBpNCBqb2JzLA0KPiBpbmNsdWRpbmcNCj4g
dGhlaXIgbGF2YSB0ZXN0cywgbm8/IFRoZW4gdGhhdCBwYXJ0IG9mIHRoZSBwaXBlbGluZSBpbXBs
aWNpdGx5DQo+IGV4cGVjdHMNCj4gdGhlIGpvYiBkZXNjcmlwdGlvbnMgdGhhdCB5b3Ugb25seSBh
ZGQgaW4gcGF0Y2ggNCB0byBiZSBhdmFpbGFibGUNCj4gYWxyZWFkeS4gSWYgSSdtIHJpZ2h0LCB5
b3Ugc2hvdWxkIHNpbXBseSBmbGlwIHRoZSBvcmRlcmluZyBvZiBwYXRjaCAzDQo+IGFuZCA0IGlu
IHlvdXIgbmV4dCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzLg0KPiANCg0KWWVzLCBJIGV4dGVuZCB0
aGUgcGlwZWxpbmUgYnkgYWRkaW5nIFJQaTQgam9icywgaW5jbHVkaW5nIHRoZWlyIGxhdmENCnRl
c3RzLiBJIHdpbGwgY2hhbmdlIHRoZSBvcmRlciBvZiBwYXRjaCAzIGFuZCA0IGluIHRoZSBuZXh0
IHZlcnNpb24uDQoNCj4gPiANCj4gPiA+IMKgLSBJIHdvdWxkIHByZWZlciB0byBzd2l0Y2ggc29t
ZSBleGlzdGluZyBoaWtleSBqb2JzIHRvIHJwaTQsDQo+ID4gPiByYXRoZXINCj4gPiA+IMKgwqAg
dGhhbiBhZGRpbmcgdGhlc2VzIDQgZXh0cmEgb25lcy4gSG93IGFib3V0IG9ubHkgc3dpdGNoaW5n
IDYuNg0KPiA+ID4gdG8NCj4gPiA+IHJwaQ0KPiA+ID4gwqDCoCBmb3Igbm93Pw0KPiA+ID4gDQo+
ID4gPiBKYW4NCj4gPiA+IA0KPiA+IA0KPiA+IFllcywgSSBjYW4gZG8gdGhhdC4NCj4gPiANCj4g
DQo+IFRoYW5rcywNCj4gSmFuDQo+IA0KDQotLSANCllpIEppYW5nDQpTaWVtZW5zIEFHDQp3d3cu
c2llbWVucy5jb20NCg==
