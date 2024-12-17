Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6E1F63DA
	for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446463; cv=fail; b=HRMSyxAWagJ9cUU35rDGxXhOgD3UurnCjdFl3nq8w+vRAka0jgO4JAZRmEPM1I+Khvy9jqoxDHiHMC4TNcG2sY030TSQIyOZVFnPe8vOqci0sod3iiWI1Zq9HnhdWbXY5h0z9Evn2yYmUONcl6q0NurNLrKIN2LPc/UP1iQAr+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446463; c=relaxed/simple;
	bh=bhYKSgdi9dbkScSqajH3M19yJAtJAaTa/aPEJMsyt8E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQuCx2ceztKT4hMO7JQmyi12xrdd986q1d1XQIDbb+mJUrODNtLoH3tI3g/2EQU31WbBSUzx69k/ZvreR8BHE8u+K+W6RWQBxb1vv6gtREshyXkmoUm/N2gpjjOKlbrpby2Qv/bgWBzJbh9R0P0BuPbbWgBsQtHF2Rj01R1E6pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jYFL0eSU; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jYFL0eSU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3TJGKoUAZ4JQE4x3xTdUPQs8aalIfOB/XjBm7V+3+LlrXa3sF9o79HCncn49cTttVXdFu7Wd/eJ7D1vXd+W1JbzStnPvN38NhMQ9RG4dlFAmRjPS+ySbV1DciL2COoXo5o/fFpu4H46N4DrUmD8USz6g1hEL0/MIqivj4PuVlHwpTF1DWUY+k/8d5XleBPAJWlnBCAg7smBXr2IPOHVLtZRq7QBLUKr2qxSkdMLL31JrWFVBaxFSfsfK2Fq+1ZGTlnDkaObfKVhn61sJ5LalyxxT8VdiTCnZCKX/y9qnYmDlnsxmwY73Fa+LatLsFgX0Zj7O2NN2WxGy2ySMA0K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhYKSgdi9dbkScSqajH3M19yJAtJAaTa/aPEJMsyt8E=;
 b=Q84y9aRcD++9x8tRWoASRCqI2N8N80f9mOIpd2dnwj0OVEKrVtFH0ejcf7aqubRb9eqTfOmAfWCa1HBvBTJXyHStLy4tYhHUb2MvgSUI0a5TMZiAcH/fuBIk6jLl2SumPA4+t3/lPEX6FHQUe2R0YiedczTWZ8qZ3B/tOJ/33fKrrCRQJH45YFOrExc2r+vT5oKS68L0bjFPCFO69onLqwd5b680xHyeQNmiD3XhzdjQkpS8PDqz6AtASCugXRAyHPEcjZrOCF7tap7nmdh2Hco4KgmW7qM9Hv970643fMONmHm0fZ3paKwf+iQgaf8U+NQ3owPFJXD+DjiJmmrx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhYKSgdi9dbkScSqajH3M19yJAtJAaTa/aPEJMsyt8E=;
 b=jYFL0eSU9aqeaRJGWMQOeORLz4tJTkHKoHnq7lkO3OrLnCCqH5b7Qc/NxNOxyosIr+4kFQdg1Q0CS1iOAUgmM/G7jdoLvDTZ1QnR3Pxg86kmRh8vcIZcGNYa1UTLB99sKQUpd2Jd13LRDarmVTKZy/51Bktti0SstvKv4KUIqvLR1z6xiNiQG3hYRgnGiAimBthiZrZuFyO8GtBXruuCsuYGXR+IIXvOWyyPO+x4tI604KsF3rrVKVUTaW0jX8/ZBqJBt80/vCfZ7t9NN2fBl3E3UyMuXIoinJxAnE8/2RWaT+KEpVhBCN/lNyU9n0ULk07rrf/UZx8uwdSX7JP8Iw==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS5PR10MB8272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:653::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Tue, 17 Dec
 2024 14:40:57 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:40:57 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "shanmu1901@gmail.com" <shanmu1901@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH 0/1] *** Simplify RISC-V IPI code ***
Thread-Topic: [PATCH 0/1] *** Simplify RISC-V IPI code ***
Thread-Index: AQHbTLVgTH0fq1ZGCUSLuPiIACKYybLqifEA
Date: Tue, 17 Dec 2024 14:40:57 +0000
Message-ID: <71fb755acf4de4a7b7bef35ca1de6e420a091a33.camel@siemens.com>
References: <20241212163837.326938-1-shanmu1901@gmail.com>
In-Reply-To: <20241212163837.326938-1-shanmu1901@gmail.com>
Reply-To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|AS5PR10MB8272:EE_
x-ms-office365-filtering-correlation-id: fc752f0d-c6d2-478f-1d42-08dd1ea8d198
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWlpVmpuOFFFS21jcmdKMndIYjRkVEh0OTRNR3JGTjJLSWhVTi9WM3lTUnh6?=
 =?utf-8?B?S0ZBVXJ2WjViWmxwOHgxbWtGTldybkFYejF6Qm40MDBPUTMrb2pJTzhESWhT?=
 =?utf-8?B?dmNocVMvQkUxWFlFYlVTbGJQcUdURkN3c09tOFdQN3Q0UmpPYWk1ZVl0L2Mw?=
 =?utf-8?B?NXA4aVM1NmxrTGNRWEptcDgrMGVnUjRZUnMyeFltRmQ3QzVuQ0RGTnlCTkxl?=
 =?utf-8?B?aGtKKzRHemNOU1NFZlR0OU1RQWlUeEV3VTRKZ2NMYW5rVjJKQWFFMWlSU2p3?=
 =?utf-8?B?NjJWMFcwT0x4enBVekRyUnZqd1ZQVlAyRU1TM0JOb212OFhvNVpQeUx6N2t6?=
 =?utf-8?B?cnoxY2hwWWJUeXpFYWl0RS9lek4xTVpGNzR4cExtOFpuM2d6WElpTEFRSUhH?=
 =?utf-8?B?bnJ1b1ViU3pHeHEyRlhuRFdJaDc4R3ZLUHZPMmhkMjNuWXhaU1dlMzhtampu?=
 =?utf-8?B?RlBsZVAydDAvTXRRQnJPUkYrR0xoaWI2NEdkc3plMitQRktoZnJxZlZpWC9x?=
 =?utf-8?B?UkUydnpnR2gzczMyL1Z2Tm0rdVVGZEJiVENDU3dBN1lmN1RQT3F4a2xtMVZw?=
 =?utf-8?B?cW9UWDlpbmFvYzBzdEN6MzlQWUpsdGNucVhHamYydWs3STFjSjZQQ3hlNkpQ?=
 =?utf-8?B?dW1uVm1ENXlodng1dmg3QUNWZmJyVSs2SWgycW5ENWpnbXlVRVRmUUM0eGd1?=
 =?utf-8?B?ZW4xdSszVWZPYjNtQnU1TTdBVXhSaUJYaVpnRytQZ3lkWXU5eCs3M2xlanp6?=
 =?utf-8?B?azVhandCZXJTWGhLZ1dCOGdSZG94Um0rQUNMVTk4L2pkTEdkMHFobHpwbzds?=
 =?utf-8?B?UEJCalpEUnRvSGhxOUF3WnBNeTMwdGxTbTdHMWMvMUtDMUIvQUU4YllLL1pW?=
 =?utf-8?B?Y2xucTRXQUVOZTRCSHZHSHdNOGZOQ0NoQXFySkpuUkt0Z09lU2lhdFdlT2ZD?=
 =?utf-8?B?c2FtVklhNnZRZUEzOUF0L3Qwb3dWZWRGQTBoMElORTh2M1lPWU8wc3JnS0NZ?=
 =?utf-8?B?d0J2Y1ZQYTdGTWc0YUhjQzk2ZkpIR016cWkrc2pPNy9vSUY4VFR4K0JhbGVy?=
 =?utf-8?B?RXRpdEIzaS9XU0ErSW80ekxxZzk4N3RIRWZLUFNmNUVFZXRTREl4V2lsOWpn?=
 =?utf-8?B?OTdSN0xjL1lheTI2bThrS2EvejVUTmVRLy84Q1hld3hnM2FoQlJoU0ZlQVo0?=
 =?utf-8?B?Y3FsL3VqUFFRS21JMG9hcW1mYVcyRGxRR1lKR1VURGFiVkdRTVRqY3d2ay82?=
 =?utf-8?B?K1VXcVh6eEljWVVBQ0MwL0JHQytYUlFtdndseXRVUU00S1FuVE1CSlZYZE52?=
 =?utf-8?B?YjR5c2FUWjR2L3B6a1V2Q0FDdzZlM3Bva2M5QzNiaXMvZ0pEbW42NjZ1a1Na?=
 =?utf-8?B?WEhFcElkeTQzdVY3SnF3dHZMd08zQ2d3N3VjWTNvdGYxd0xvc0NkVUYrRk0v?=
 =?utf-8?B?ck1YUkVMak5YZndFN0xGYnRnZFdTN1ZhVEdzckRlT2ZhdytQSUxYR3ZOZGFG?=
 =?utf-8?B?SzlPUEd6YzZNS1FkSVowUGhyeWwwQjNISlNLUzY0WDlrZjY0TEZ4UXYzanpR?=
 =?utf-8?B?RGdrMlpUQldtdkF5VXJjWW5WckFUS1ZyNGxpak1TeFp3ZjJPSjMrZzcyUXJX?=
 =?utf-8?B?Q3N3VTcyNXppVFBpSFVKOGQ3SWpYV1k2eU5CYlZ5aTZLdWczNWxjTVlNYTRh?=
 =?utf-8?B?REdyUGRRRmc0RVhIM1ArZnRoU0ZZRHd1clJCZDNjN3hNOWFrS3kybElsaFQ1?=
 =?utf-8?B?SnhIYURqS3RSUHhDQVcwRGVEaUdnWnV6RWdoUlNjZjU1ejk2Q1NpSWdJeUVD?=
 =?utf-8?B?c3ZWbEpFWnJZVDBIcDVhbVcwcmRkMGNrMW81eTNCbUNuNkZzV3Y0azYxL0x4?=
 =?utf-8?B?azRjUElVdGdNaTAveWJqTTNoN3Z4VFJVeDNZbzdjdWc3WVQ1Z2pQWW14N0RY?=
 =?utf-8?Q?ItCiN2r2DYNMeKupDh1TT1efC09syaci?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzkydjRuSFRIWlExUHNRZHQzZGdXY2hjc2tWbVZEMUJhSlVvZ0tYMUd6eC95?=
 =?utf-8?B?bktGWjVPaW5vYlRMVlluVkptaXAxYTFwTnRPaWNoNnlxckFzWHVLY01Tdzk2?=
 =?utf-8?B?WU9YZU5GWDc2THRDZVM0VkMrRjFrYnM0dG5hNjNINnl4cU90MGlmc3BOdW9O?=
 =?utf-8?B?MU03WkNJdmtMSHNMaXIvTWlGc2FuQnFjeEVUV0dNNXJLVjNyelluWnBkcERy?=
 =?utf-8?B?VTYxOWNiT2ZMZUhxQllzQ2Rua3lXZ0hONHJRL3hxNzExdEJUaW9Bbit2VUJ4?=
 =?utf-8?B?dENoT1d0V2MvYnJyaTJya2tBRk9acEZuTTdyMFpvQm5SS1FWcWtLclBNZTF0?=
 =?utf-8?B?Nm5YTGg1RUdkd1FOYkVoTEhjeHRydWtMZFQyeVY2K0tCN3FSM1NqazJhdzBT?=
 =?utf-8?B?U2phempTanhsNkx2eXpaWUx2R3Vwenlaby8rQXpXcHdqTjlNdUdpcFNiNU1s?=
 =?utf-8?B?dm1reUpjejlDRlFTS1NzeFViTmpZc1VndTFWQmZlNUdHUFRCTHFvSmt1aHNy?=
 =?utf-8?B?ZkFPVDc5cG0vazA2Y2Z4OUh6cXpmTk0vcWgyMG5HVXI3L3JrbWJHZlN4L2to?=
 =?utf-8?B?cHRpTmlHMUhsWUo3S29RNEZqNnFUMmNCZDVsMFRUdDNmamY1eDZacWJsRFgz?=
 =?utf-8?B?YnA5ZHBMczV2bjhpVVJnNHBhMzJKeElkZkV1TUpBNjE1aWZWQmZ4c21xSlQz?=
 =?utf-8?B?bnk2SFVGNVRCM2VTN1JzOU1uc2U5R3d3L01sV2pWcXMrN2RBY1ZCUmsvSXlo?=
 =?utf-8?B?REY3b2pIaURLRnZXL0p1cFhnU0FrWjFqRUFydEpiZC9RRHBnbWU4UTVDbnpt?=
 =?utf-8?B?aEJ0RjBsdTFzOTFFdGp1bUxONzVCaDNVcUR1MXM1S211eitKQ3JmRms5RWJM?=
 =?utf-8?B?cCtKanZhMGJzcHRNbjNXVTREbjVOdll5MUhKYnNTRjV4Z1ZqZVpnRFNGQ3FB?=
 =?utf-8?B?Vmw3akR2SUJBMUN4N3BwZ0xJdXhwdkhzUUkrTHF0N2ZqcDY1YXF3STdhcHVh?=
 =?utf-8?B?WUppaHladnE2Y21Sa3NZUWlwaVBpakNDNzc3QWRRS2w0aGcwRlhRYmFteldS?=
 =?utf-8?B?MWc3R00zMm1JTGl6RjYxR2tuTG56eXl6Q3VYSjhqakhtcHlqNTBLTmZLbENj?=
 =?utf-8?B?L2tBRFpyS3F4ZFc0K0FwaHdubVZWVHBheDV5TFc0S2tDckNsa1RhRWN0WVVG?=
 =?utf-8?B?MGRaOXpLT05CN0IxK3RSNm5TaFJhNEE3RUM5V2k1Nm1QYVVKOUEvbmFLYTky?=
 =?utf-8?B?cnk0V3M4SERSL3VCT1huODdXcnhtM1orYVQvb3FqRUdmNmlaMzV0UVNIeHlk?=
 =?utf-8?B?ek1vZjBvakpoK2xYMERqVHVmeGJicVpzRnlhbGh5TFkxOVlValM4NjVrK3Q0?=
 =?utf-8?B?cDh3THdhYmlKZXFJV25JVnFPV2p6OGxKSXhmanRGUlFOZVo2ZU50bTN5UTBq?=
 =?utf-8?B?MGJyeDFUL2lOaGw2VWdXeWpLSXVwcDRIZlZ0dVdzTWJWeXVsQ2xxb2Z4aytn?=
 =?utf-8?B?STlzQXNsRUFybVA2Sk5hWFNvUmZGdTh2K1ozb1NveEo2emI2eVV0RGZkdU9G?=
 =?utf-8?B?ZWNsVk9pT2UxNGVFOWVFbHJHOTlKTlpSeUsyOWwvaTdNeU5Edk1DVjUwUnRZ?=
 =?utf-8?B?b1lrN0ZMSGxOelFYQTloc1Q0UnZXTEhqU3hTSUlrQlpvTnFVWC9kL2xjbGl6?=
 =?utf-8?B?WjlMWnM1WVNRSmpGSHNhWmhXUzMrNFR2WStzNkZPZzFNaHNkNEVJM3NNMXNl?=
 =?utf-8?B?Mms4UkFENzdueEN4VElxVFlwSm5pUHpIak9yNnpLcWhrVXl3RTRNcmlBVURG?=
 =?utf-8?B?eHFqb1VHTUFrbmN6cDh1bFFMVktOc1NjMmwyOHVoMWVhZDl1WnpybDNQS0dL?=
 =?utf-8?B?M1pvaWhCd0ZLc01KZW9FOVhpNUN6UTlWRjFaSllONGowdDZTcGwwOWVCRDM5?=
 =?utf-8?B?eHNFanIvR01EMWUreGgzZ0pqSTFaWnJ3aFZycS8xL29Rd0Q5dFNwUmVuVU5J?=
 =?utf-8?B?MmJ2Z0NONit2NVkybi9JemJ4QnVFZW1kWS9nMmZQQWFmZjVHenNOY1BrU1Ay?=
 =?utf-8?B?S29QM2crWmlia2dBajNLYnQ5Q2FOakVNYndOVlovK2t2NTltaGxPemcvNGYv?=
 =?utf-8?B?bVJpSzRhMER0Q3hnanY5T3BzV0RxYm5YVjZGUXVBVGxod2p5dU5JVEtYZzNt?=
 =?utf-8?B?clRMT2dwZkhwSnBCQktFVkJ6d09Bemp2S2FSYjgwRFdiL0kwODZFRDRrdWxm?=
 =?utf-8?Q?EJsUrnuok4/p5gd0v0/6HqdkTh1+fuSr+89DZYMaEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC9C0127C9B0294DAF09595E03B8408F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc752f0d-c6d2-478f-1d42-08dd1ea8d198
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 14:40:57.6002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PTsYobpRMjzzITqmbtc6TEM1MCsiEIMZUUFZvmF1QyKkjF+X93zicWSUtsfhjzs9JtegTbp8nTNEA5vOtCLVwSE0hC/Z2sGbG0nIJd/B5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8272

T24gVGh1LCAyMDI0LTEyLTEyIGF0IDE2OjM4ICswMDAwLCBzaGFubm11IHdyb3RlOg0KPiBSSVND
LVYgaXMgZGlmZmVyZW50IGZyb20gYWFyY2g2NC4gQUFyY2g2NCBoYXMgU0dJMC0xNSBhbmQgdXNl
DQo+IFNHSTAtNyB0byBzZW5kIElQSXMsIHNvIHdlIGludHJvZHVjZWQgYSBmZWF0dXJlIHRoYXQg
d2UgaGFuZGxlDQo+IGluYmFuZCBpcGlzIG11bHRpcGxleGVkIG92ZXIgU0dJMC4gQnV0IFJJU0Mt
ViBvbmx5IGhhcyBvbmUgcmVnaXN0ZXINCj4gdG8gaW5mb3JtIElQSSBhbmQgdGhlIGlwaV90eXBl
cyBhcmUgcmVjb3JkZWQgaW4gdGhlIFBFUl9DUFUNCj4gdmFyaWFibGVzLA0KPiB3aGljaCBjYW4g
c3RvcmUgYHNpemVvZihhdG9taWNfdClgIGJpdHMuIFNvIHdlIGRvbid0IG5lZWQgdG8gdXNlDQo+
IHRoZSBzYW1lIHdheSB0byBzZW5kIElQSXMuIFdlIGNhbiBzaW1wbGlmeSB0aGUgY29kZSBieSB1
bmlmeWluZyB0aGUNCj4gSVBJIGhhbmRsaW5nIGNvZGUgYW5kIHNlbmRpbmcgY29kZSBmb3Igb29i
IGFuZCBpbmJhbmQgaXBpcy4NCg0KVGVzdGVkLWJ5OiBUb2JpYXMgU2NoYWZmbmVyIDx0b2JpYXMu
c2NoYWZmbmVyQHNpZW1lbnMuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLiBUaGFua3MgZm9yIHRo
aXMgaW1wcm92ZW1lbnQuDQoNCkJlc3QsDQpUb2JpYXMNCg0KPiANCj4gc2hhbm5tdSAoMSk6DQo+
IMKgIHJpc2N2OiBpcnFfcGlwZWxpbmU6IHNpbXBsaWZ5IHRoZSBzZW5kIGFuZCBoYW5kbGUgb3Bl
cmF0aW9uIGZvcg0KPiBpcGlzDQo+IA0KPiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaXJxX3Bp
cGVsaW5lLmggfMKgIDE4ICsrKy0tDQo+IMKgYXJjaC9yaXNjdi9rZXJuZWwvc2JpLWlwaS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsrLQ0KPiDCoGFyY2gvcmlzY3Yva2VybmVsL3NtcC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwMiArKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0NCj4gLS0NCj4gwqBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWNsaW50LmPCoMKgwqDCoCB8
wqDCoCA4ICsrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA3OSBkZWxl
dGlvbnMoLSkNCj4gDQoNCg==
