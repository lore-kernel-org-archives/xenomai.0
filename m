Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD3AD48
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 13:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAV2z9BhMH+Xu0rw98DjGoLDEG710oTsNRdX3nQNTFO2wCDFgNH89toBWFF00VixKR9CgOTdVFQKy4Yl/1XihYN4WQbm6k+J4zAwj9fHA1zFh7Vdanhpapoy0Kz/QH2WcRTuXju7C4lkAYUPpwp1QrmUrGfRAYci5bc6yLrkWnZGYKNzMfKKaDqD+fRR92lIrQHPXYz3aRX293NUEdP6kToiNCufs98sLGc7Whowe4E1QGANVZuUH+v/GLlHkBKBhTDe/EzCqxTAtt2nCdlDiRMFjiA4d6L5jsVX/nO/7fFMoUsNyPUbWbb/Zzi0GoRCL6Aex/llT2fXlQcZoRX0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hhFO6QCIZ5JkfIqrAve8TTlWskWGXw4S/dUDFZzxxA=;
 b=nfQIDma6SbMF6BhJ9lLvBpB9zmWiLE7am0Z2GwB4XVIC4KOcB1E3FE+RhTRNqz7WRWFRGQKVcGvsh9WJGhl6pPjRQGrmubwtzmN2kueGMBZBmk5fFiUtYzEd2CXolDej/BW2GMt/gAZCtk+pFp8eP/k5Eeujz5ug19Jqr0BSwngGNGWXod8bkoeRTYy/OVPiW4gDM5Bn92N//pYymruywAUtQQNY1EXd9qyBZivOGmbkF5BDzMS0QDFgOYUaj+J6UA4c99UH7g0loXHtKNyJbgPNALYuU0Ecctm/hbzSmEWEZBdv9F6/wpTlpsBkuEGA8iTKB6L4NZ52W+3jo2xDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hhFO6QCIZ5JkfIqrAve8TTlWskWGXw4S/dUDFZzxxA=;
 b=HQfKY3lm3MgjeHZWU6GbpN8bEpPQkwE8FYERYnbkH21WGzN9Kuxbr5WHA/MLEDdCWufR/MV6cbL63EWSplrCoohu2ywQZfo5HLbmfJvLOUhgVmNpl31veTGEaECD3QKYOSBRGa7dMgz5CgaB1ZxPtH25rXQvPdUl9lcnZK25w3u2TrAJd/CpdkfLcZA43PuIztozPI9RPQFrO8wXv5FZAQQkrO1hhwqJrCmzVfHL/k47KNpJi7kgpr979TIVxGTpYiQiaEZ3n4VqIiVqLep9siKjqhQlN5Fay0Za9NC5ZzHa+u3wFxZcvqbCvhZHlkGAo1UBrmE4DBKCwUod9MP8ig==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 13:22:37 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 13:22:37 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "qiang1.zhang@intel.com" <qiang1.zhang@intel.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "Stefan.Heber@zwickroell.com"
	<Stefan.Heber@zwickroell.com>
CC: "hongzhan.chen@intel.com" <hongzhan.chen@intel.com>,
	"rick.y.wang@intel.com" <rick.y.wang@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index:
 AdjUuPBUbK+UhP87T6Sf3hDOZQOijgTLBYqAAA1CmiAACKQcgAA/AGAgAV0zStAACIauoAAAw4AAAOySfgAABi7zgAADOIVQAABgE4A=
Date: Mon, 7 Nov 2022 13:22:37 +0000
Message-ID: <6fd9a1fc76faa35924d2bf19407347a3ed525df5.camel@siemens.com>
References:
 <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
	 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
	 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
	 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
	 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
	 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
	 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
	 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
	 <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
	 <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
	 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB9PR10MB5502:EE_
x-ms-office365-filtering-correlation-id: 107d9b7b-3e8b-4d05-6ccb-08dac0c323cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ViLG/VrdTgU5Yqx6QsSeW/05r8fiP/UIqA5naxBTxRnOkMD3G8fpaUGHAtU5+tVedNLhn/nDPkZ2DmWnmNBJWvKZRtf5DYPQqpfCG5oSh9qG+regBGnioswlA8DgHj2g/bYeJmXXTJN9KEjmpOsoojG6wQnsmoHh/24icbBhiBZJzCgkz3iffGqsgKd25d2x7LuNIkyx8H3xcCAykwXt4atLgELLw2CeRjl9Cg2UhOZFEMAstQQpPdeXxJ96dAIuE5cXRnvQ1arL6nsKCGcdfgakLIF+fgyvl7eX6fNOgxv8WdG2Hu6+xeuGPVL3j260p+VdOrgp1RpdIg0kSoVH2Zpqr+Z79V0ZbyEL6ZSW0ONFyjbEUGam+IwLA4X578xm7CysTrDJHzQk1OX2FPNP6d7dULq78vC/ACb2HQzY9gh4Hh51G13VUwg19PMEsNcGg5byHa4gRe1G4yP8xDVzWCokglmR2NvamnKtt3nHx4d190T7rWrxKCfYBOkKE636XQUVbcY+Qv1eZRiduvHhLMaEdpwK9qV6kgTMTHgwgGQJnQA3gcQNvrQKn8rJ3TAWgMuPTyB2ZH5pZ1MyY9kj3vXwy82Knma/M+j3qJ8HVIZ4i+c4+AIPrezSYvVD7IbwY3w7CuE5DCYVjmfomG4PxFsqYRoyLFXsNKj9YZ1793wxSofU0g1abi+chN0RCURnhilv7M1HMHRhQgp2PfvoOuzCtkwKyQYcilJiuyyJUtLPQirPbmkekoUORk9mm5CX2+3cSJHvAdK0mcQNbxCMqg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(5660300002)(8936002)(82960400001)(38100700002)(41300700001)(91956017)(2906002)(66446008)(66556008)(76116006)(4326008)(66476007)(8676002)(66946007)(64756008)(83380400001)(36756003)(110136005)(316002)(54906003)(86362001)(478600001)(71200400001)(122000001)(53546011)(6506007)(6486002)(6512007)(38070700005)(2616005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTdxYXRQTXRwZjFIeTRRUWh4RUFYVHBTem5MZzRiUzQvWWdybFpqcU5YUzU5?=
 =?utf-8?B?TW9vci9MNGtqYkhqM21hS3BkV3VQRzF4Y2tVbEthUW9ZYWV4LzRDaVhBbVdD?=
 =?utf-8?B?OGFxQWFlYnA5b2htWm5mUSt3NHl2VVZFbnpkNDJZYnYxa0lrSXc5a2dTMkJZ?=
 =?utf-8?B?VkxCVVp6YkxqTlVJNTl1a203SVo3bDFVbjJrVk8yRHZyZ0FtNDFGWi96cW1o?=
 =?utf-8?B?U1puL1oySmVzV2F5YWtwYUtKMlJEK09VN29USndDZVlIYmRlOEk5dzJCd0Jq?=
 =?utf-8?B?a2tzNTdmbENIZEhabk9renEybFN1dXRxZ0hiZlNFdWNvblFMYWdTUW0yT2Nl?=
 =?utf-8?B?WUdWd2hSNjhDakMxdWxhaW1pRFNiZHZLOXFNUHdDWTFJTFdMYk1SdktmQXFH?=
 =?utf-8?B?RkNHM0xSSC9ZNkVIVm5YU25jZHFnbnJ0QjVZNTRSNzh0ZDJ0RFRGeVFKbVo1?=
 =?utf-8?B?UmNWc0lZTDNUWG81bUVHZmlINmZjRHlxNnhSaE8zQ0JScVBnNUNjQXhZWElT?=
 =?utf-8?B?WUVGTXpjc2hzZmNjYk5SaEFGYWVMU0JjRXpUL0RPMVR2UktJTjdvTjkvMFVv?=
 =?utf-8?B?c045aDJNOURuSXBqK0wzWEhhRjhNM1pCSUJQSk9PbWdsaXhwUTNJb0pGTVM1?=
 =?utf-8?B?UnBHYUhpQjZRV3YrWXRXOXcxcnhLQ3RZcXc0Ky9yMGpDYUNwdmhYd3EzZE0w?=
 =?utf-8?B?eFc1MjNKS1RuZ0l3STJySjd5T2h2bDU2UUhXQXBPM2V5QS96N1MvcHJuU0Vz?=
 =?utf-8?B?RVpTQVNJeHgxMEdhWnhDUFVEcWhwODRBSWZ6di9tN0ZkRHdMQndPRVBtN2dp?=
 =?utf-8?B?UGNqUUdjZlpuTEFQSWNyRDBZNHd1b1ByYUJBRk1MNXhucjI3T2FuYnFFWjFH?=
 =?utf-8?B?UERFSU04WFQrc0F2L3dMOURNY1E5YlJ4QXRFSGovdEZqcU1BaGd6a3UrR2lV?=
 =?utf-8?B?ZjRaaDlZVHRnZ3BIYndHQ2d0YTJhNE5mQ1RNcm5pUm0xaE9nVVVYaUpLbExr?=
 =?utf-8?B?dU4yK1Rob3ZUdjUzOER5WS9mR25mWmNSVUZ0ZUd3Tm9JTi9qTEt6OVgxdDBK?=
 =?utf-8?B?eDE0dUw3YXVzK3d5d0hiWER4c3U3K0xRMGlkdkt5a2dDb3lTWWpzVkRyNXlB?=
 =?utf-8?B?TThUR0ZtaGxnTWVCZEw1aW56Y0VPK3dyS3ZBOGNNcEVxK0V6TDh6dHF5NGtZ?=
 =?utf-8?B?NGJ1dFBwY1VRSVBBNnZrTEwwRFlpZmg5a1NLOXBRcU9kQVpaWVJPdlUvYmNM?=
 =?utf-8?B?aEJyQmVmY0JndEt5UHYvcjRQU0xXKzFIczEyMnJjRlFlQkpweXd1Sm5SNUFO?=
 =?utf-8?B?V3hBTGJKWTVVNmw0aGF2NklqcEZKdC9TRlZjRHFFVnFlaURRTUg3d2pJQzE3?=
 =?utf-8?B?YlJ0SG5EVW96OEd0eXIvQ0t2eFVYVFdPWi9qTlJORkdYNTRJNmZ3b1MzTGxK?=
 =?utf-8?B?Smd3WVk1MlJDRTJCTlVsSU9oVm9ORkNkTDBjV3JlSDc0VnRGcVd3cTZIWUF2?=
 =?utf-8?B?eGpIaE5XRU9Bc1NhQ0E5cmhybnY2elRDMm5DbmcxSC82cXNVaHdUUEEwcSt1?=
 =?utf-8?B?SWEzM0RuOVVlR0JjdWZ0N3hOUExsbk9CZm5OSTZiYnp2OGlXQW9aSUlibGF1?=
 =?utf-8?B?T1VRUWhmdWNScUVuelB3Ym42TmFrRHQ5UVZ4VHhiTm9vSFB6WHJieEVuY0hz?=
 =?utf-8?B?SFVBcHdMUjFuK3NHUEh0TWZ5VkxlZ3Q5RXR0S3ZQY3JNNUVJbWVLVk40UUsr?=
 =?utf-8?B?WEx5eWhnRjc0SWgyQUFOSWpJMjk3Ym1xNHNYaVlXbml1OG9yN3RCVmJrRGNG?=
 =?utf-8?B?RytOVFhGVERqaDdaMWx2WDR3aXZzakV2SFNUVk50UlVYTGtZNE15RnhSd2o4?=
 =?utf-8?B?cUJ4cXA5anBoeFFmTVJLTGRTM0ZWbnpxNjIwd2ZXb1lmcXFjYzV4bVRkSmZ3?=
 =?utf-8?B?dUI4dENpMHFzZEJkTTFCV2tWVnI4R2s2cGQwQzQ3VzliQkJyK3UxekpKek84?=
 =?utf-8?B?UU5lZnRpZDNENFVUUGJ4RDdpUlVRQmFmUEhJOGpwUVlaU0tpYk1jekNXMG9Y?=
 =?utf-8?B?c2tSR29aRitLcTlQOUE4dTZjTHhKaU9DektPeEloNDRRNHpPWWNBSzRLUHJW?=
 =?utf-8?B?QWRVZFZzVGpLOWZ1ODlFcmtsYzlsU1FKTVBPb3EzVEFhaElpbkxZa0g0NUNh?=
 =?utf-8?B?bTFLdVF6RmUveEJOZUtmbjVSaUtGL01nb2xEdmJKUGZZRHIvMVRkUC9VK1VY?=
 =?utf-8?B?djRNczNnWFVFd3F2aVY3RWVSbDJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A78FE4B4047A744A79B34B0DAF1DF8A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 107d9b7b-3e8b-4d05-6ccb-08dac0c323cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 13:22:37.7856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2GcLt3+4/t7ZcntYTsfaihHWQWk31GTV/+eHNuf6bfwQ4Qx9B2rGuJe22ReANBUYgpL+EpwoejwbUr4Gtq6OLitlUQfb/4KpKXB0k/uz8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5502

T24gTW9uLCAyMDIyLTExLTA3IGF0IDEzOjE4ICswMDAwLCBaaGFuZywgUWlhbmcxIHdyb3RlOg0K
PiBPbiAwNy4xMS4yMiAwOTo0MiwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBPbiAwMi4xMS4yMiAx
Njo0OCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiA+IE9uIDAyLjExLjIyIDE2OjM0LCBIZWJlciwg
U3RlZmFuIHdyb3RlOg0KPiA+ID4gPiBIZWxsbyBacWlhbmcsDQo+ID4gPiA+IA0KPiA+ID4gPiBX
ZSB0ZXN0ZWQgeW91ciAwMDAxLUlQSVBFLWlnbm9yZS14ZW5vbWFpLUZQVS1vcGVyYXRpb24ucGF0
Y2ggb24gb3VyIHN5c3RlbSAoTGludXgta2VybmVsIDUuNCwgWGVub21haSB2My4yKS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggbWFrZXMgdGhlIHByb2JsZW0gZGlzYXBwZWFyIHdpdGgg
b3VyIHRpbnkgdGVzdGFwcCBvbiBvdXIgc3lzdGVtLCB0b28uDQo+ID4gPiA+IEJ1dCB3aXRoIGEg
c3lzdGVtdGVzdCBmcm9tIG91ciBodWdlIGFwcGxpY2F0aW9uICg+MjUwayBMb0MsID4yMCB0aHJl
YWRzKSB0aGUgcHJvYmxlbSBzdGlsbCBleGlzdHMuDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBp
cyBzdXJlbHkgbm8gc29sdXRpb24sIGJ1dCBpdCBwb2ludHMgdG8gdGhlIGRpcmVjdGlvbiB3aGVy
ZSB3ZQ0KPiA+ID4gbmVlZCB0byBkaWcuIFVuZm9ydHVuYXRlbHksIEkgc3RpbGwgZGlkbid0IGZp
bmQgZW5vdWdoIGNvbnRpZ3VvdXMgdGltZQ0KPiA+ID4gdG8gc3RhcnQgdGhhdC4NCj4gPiANCj4g
PiBJJ20gc3RhcnRpbmcgdG8gdW5kZXJzdGFuZCB0aGUgcHJvYmxlbToNCj4gPiANCj4gPiBTb21l
d2hlcmUgYmV0d2VlbiA0LjE5IGFuZCA1LjQsIHRoZSBrZXJuZWwgbW92ZWQgRlBVIHJlc3RvcmF0
aW9uIGZvcg0KPiA+IGluY29taW5nIHRocmVhZHMgZnJvbSB0aGUgdGhyZWFkLXN3aXRjaGluZyBj
b2RlIHRvDQo+ID4gcHJlcGFyZV9leGl0X3RvX3VzZXJtb2RlKCkuIEhvd2V2ZXIsIHRoaXMgcGF0
aCBpcyBub3QgdGFrZW4gd2hlbg0KPiA+IHN3aXRjaGluZyBpbiBhIHByaW1hcnkgdGhyZWFkLCBh
dCBsZWFzdCB3aGVuIGl0J3MgY29taW5nIGZyb20gc2Vjb25kYXJ5Lg0KPiA+IE5lZWQgdG8gbG9v
ayBmb3IgdGhlIHJpZ2h0IHdheSB0byBhY2NvdW50IGZvciB0aGlzIG5vdy4NCj4gPiANCj4gDQo+
ID4gQSBmaXJzdCwgc28gZmFyIHByb21pc2luZyBmaXggYXR0ZW1wdDoNCj4gDQo+IEhpIEphbg0K
PiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2gsICBJIGhhdmUgdGVzdGVkIGl0IGJhc2Ugb24gWGVu
b21haSB2My4yIGFuZCBsaW51eC12NS40DQo+IFRoaXMgcHJvYmxlbSBkaXNhcHBlYXIuICBJIGV4
cGVjdCBTdGVmYW4ncyB0ZXN0IHJlc3VsdC4NCg0KRXZlbiBpZiB0aGlzIGlzIHRoZSBjb3JyZWN0
IHNvbHV0aW9uIChMR1RNKSB3ZSBzaG91bGQgdXBkYXRlIHRoZSB0ZXN0DQpzdWl0ZSB0byBjb3Zl
ciBzdWNoIGNhc2VzLiBJIGZlYXIgdGhlcmUgaXMgbW9yZSB3b3JrIHRvIGRvLg0KDQo+IA0KPiBU
aGFua3MNCj4gWnFpYW5nDQo+IA0KPiA+IA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwv
Y29iYWx0L2FyY2gveDg2L2lwaXBlL3RocmVhZC5jIGIva2VybmVsL2NvYmFsdC9hcmNoL3g4Ni9p
cGlwZS90aHJlYWQuYw0KPiA+IGluZGV4IDdlMjg5MDNhNDIuLjhiZDJjZDkxMmIgMTAwNjQ0DQo+
ID4gLS0tIGEva2VybmVsL2NvYmFsdC9hcmNoL3g4Ni9pcGlwZS90aHJlYWQuYw0KPiA+ICsrKyBi
L2tlcm5lbC9jb2JhbHQvYXJjaC94ODYvaXBpcGUvdGhyZWFkLmMNCj4gPiBAQCAtNDQzLDE1ICs0
NDMsMTkgQEAgdm9pZCB4bmFyY2hfc3dpdGNoX2ZwdShzdHJ1Y3QgeG50aHJlYWQgKmZyb20sIHN0
cnVjdCB4bnRocmVhZCAqdG8pDQo+ID4gew0KPiA+IAlzdHJ1Y3QgeG5hcmNodGNiICpjb25zdCB0
b190Y2IgPSB4bnRocmVhZF9hcmNodGNiKHRvKTsNCj4gPiANCj4gPiAtCWlmICghdGNiX3VzZWRf
a2ZwdSh0b190Y2IpKQ0KPiA+IC0JCXJldHVybjsNCj4gPiAtDQo+ID4gLQljb3B5X2tlcm5lbF90
b19mcHJlZ3MoJnRvX3RjYi0+a2ZwdS0+c3RhdGUpOw0KPiA+ICsJaWYgKHRjYl91c2VkX2tmcHUo
dG9fdGNiKSkgew0KPiA+ICsJCWNvcHlfa2VybmVsX3RvX2ZwcmVncygmdG9fdGNiLT5rZnB1LT5z
dGF0ZSk7DQo+ID4gI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig1LDIs
MCkNCj4gPiAtCS8qIHJlZG8gdGhlIGludmFsaWRhdGlvbiBkb25lIGJ5IGtlcm5lbF9mcHVfYmVn
aW4gKi8NCj4gPiAtCV9fY3B1X2ludmFsaWRhdGVfZnByZWdzX3N0YXRlKCk7DQo+ID4gKwkJLyog
cmVkbyB0aGUgaW52YWxpZGF0aW9uIGRvbmUgYnkga2VybmVsX2ZwdV9iZWdpbiAqLw0KPiA+ICsJ
CV9fY3B1X2ludmFsaWRhdGVfZnByZWdzX3N0YXRlKCk7DQo+ID4gKyNlbmRpZg0KPiA+ICsJCWtl
cm5lbF9mcHVfZGlzYWJsZSgpOw0KPiA+ICsJfQ0KPiA+ICsjaWYgTElOVVhfVkVSU0lPTl9DT0RF
ID49IEtFUk5FTF9WRVJTSU9OKDUsMiwwKQ0KPiA+ICsJZWxzZSBpZiAoeG50aHJlYWRfdGVzdF9z
dGF0ZSh0bywgWE5ST09UIHwgWE5VU0VSKSA9PSBYTlVTRVIgJiYNCj4gPiArCQkgdGVzdF90aHJl
YWRfZmxhZyhUSUZfTkVFRF9GUFVfTE9BRCkpDQo+ID4gKwkJc3dpdGNoX2ZwdV9yZXR1cm4oKTsN
Cj4gPiAjZW5kaWYNCj4gPiAtCWtlcm5lbF9mcHVfZGlzYWJsZSgpOw0KPiA+IH0NCj4gPiAjZW5k
aWYgLyogISBJUElQRV9YODZfRlBVX0VBR0VSICovDQo+ID4gDQo+ID4gDQo+ID4gSmFuDQo+ID4g
DQo+ID4gLS0gDQo+ID4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiA+IENvbXBldGVuY2UgQ2Vu
dGVyIEVtYmVkZGVkIExpbnV4DQo+IA0KDQo=
