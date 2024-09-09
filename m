Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936314295
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894014; cv=fail; b=DSMcIe9/IZhiaIpMWqjLJtX5NTE+EKcaMKJiYQuOLbRGcX/XdAr9fQ2OVK5mSOtV2CZccJ2bqPdHAvm4U8z4JxuWyBT3tn+Vsg8+F8QPhl9BNRP1oRBa61fh91TnWIOZzM6Lqs82aYixT0rH8VEN8HqEYN3Dj+KRCYLwiMiCim0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894014; c=relaxed/simple;
	bh=OEuwQ3ajZ7Wnzd7nfpw7Pg+09HYL6TxgaVKoCI2CRZU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ptzXQ4+r+VfTSV5seq4EL78ipqBWqaYS9B8sy48bEfdavsI0mQQblBKQ8VjRc9rgIZBHlblkHA9psrE4MHilJ3IB4E+jfVDiwiZ/uSfXThyRbfXWyiLY9FUGyZTEQHquLKKpyJ/zn5tTDJ8yEimkLvD1AlB98zL2YaiUfioKOKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b=JcC/VfHC; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b="JcC/VfHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t11Z2uTItPAncra7JrUuI3Lcz5hybqDUAd2sNtPF/w7AaJQK7UsPdbUKDaTn5oMV3uwDJSkMY7OyLYnPff/Pm7Gcy1ykgV/7m3vg3WtF7DTydF8jbV1NMvvqMMhYLPg0Df5PIXyUsUli4LEO/hCv7iVd97V5XbUfKbYASAgcYerBar8LTHFvXnIarc9JD8aSzGXF2Q03Zzp5u3LSk1jXeC3VLDrkWLLRJOI/Bouzc7aep53R7c54l9UiqQ1ZNosJdjQ1dNDrCtwbGcYq0rNJoJlmYTPx/TnOGKxtCI/eDE1ViVL/Xn+ud1VD4Q8lqXLdlfMS4qw9vvMOBzuy+ol//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEuwQ3ajZ7Wnzd7nfpw7Pg+09HYL6TxgaVKoCI2CRZU=;
 b=vZlH5w24Jca16zKbxGvnl0Rz/kgLBTo24pE4PG1ODqOMEiv741lv8vv3tGyBlCm9oOjmj8DdNkKFTc46LzTdsiBSyDN/DaPkScsFJ2e4cymLhYpnkVNNjULwJXJD1djv98pA209wyoPjgd3dEJUPQ/iE8Gq8STMoJhjtwh9/gdHk5Yk+NG4zbh+DmG4keNc70ThScQhnKX8fTUDEfEArhu83rTjzEAxEcp8Om2p59ztgS3/o4xJx+Ej5sEVu24w8aNiUCj744KmZGiJdaPDH6iDWO2/GD8NVVrrB8ASxxIuuoh9vcyJi78/fzPbOBhvoDxFOfYiKfFKrmirBY1GakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fareco.fayat.com; dmarc=pass action=none
 header.from=fareco.fayat.com; dkim=pass header.d=fareco.fayat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fareco.fayat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEuwQ3ajZ7Wnzd7nfpw7Pg+09HYL6TxgaVKoCI2CRZU=;
 b=JcC/VfHC3DweKMzKYdwc/a32uZjSrVTsuiYl3jtYduIcGlMPQwofQUbN6V9g+FJ5uSWyMdNiwhRw7pd5scToIpC82YVQFZ4q17OQA8UMMiv5rNgPIKR/nbabETPaLou1RYkLggrmpRKaqBPK54aNa5IDQsVIdkBoZXB/k8KSI1QCoLUKRoagNKfFUcZdQNsSf1cyXpS2294UdV3fKAq1geusf6gAT4N7J0c/0gZr3XVY7KCTjyHIhQ2AQ+1jWLvfuOWoOansULKvFUI6wP1WOae/xV81OgrGLlk4u+rckdUEK4sOF2AWL8P+XasKpwl4YOAV0Gs8uNFimgbfAbFHFw==
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com (2603:10a6:20b:a4::24)
 by AS8PR05MB10001.eurprd05.prod.outlook.com (2603:10a6:20b:5b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 15:00:08 +0000
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e]) by AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 15:00:08 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Topic: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Index: AdsCu/A5CIPDzd4nRhuPtAIfDI6JiQABM2kAAAGsaqA=
Date: Mon, 9 Sep 2024 15:00:07 +0000
Message-ID:
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
References:
 <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
In-Reply-To: <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB6024:EE_|AS8PR05MB10001:EE_
x-ms-office365-filtering-correlation-id: a8eb62ff-ebbb-401e-8a4a-08dcd0e01865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEJneVZBT3htanY5d3NHci9wQXE4dk0xcnlzbFk3SC9NRFdZamJCUXRqQ0xu?=
 =?utf-8?B?Njg5ZDg0ZUhnV2VFc3Z2a1NCV2tTMFlpNk5ldnJDZXhmSEwyaUVMT2VPRUNa?=
 =?utf-8?B?b09UZGFOak5NNi9ZRTBOVEFpUUZXelkzdWNQR0tuK3c4VEFidXllYVVBVzJx?=
 =?utf-8?B?TTJGSkx2c2Q1ZFNPbFppeTlIREthQ2pJZUpjMDRMSC8vYkdPTGVCbnNwbXFs?=
 =?utf-8?B?d25vN3RjVmdWUUVjbHpPc3lkWTAwcnUyRDN1UXpVWEV2NWFJRUdJNzVBaGN2?=
 =?utf-8?B?NzE2MEc1UlB0Q2llNml3eFVKQjNxYlFCSSszd0FaT0NYcHh0Wng3TFJKUUw2?=
 =?utf-8?B?ejEzNm5KWSt5NEVqZHV4NGFEMGxOMnc3dHh5YXU5R0t6YkovNlFqV2RqTWVq?=
 =?utf-8?B?TjY2VU40SlZSUnpPK3lrQllJblpDd1FndXhPVGhRRXN2VnJKTFJkS21rWlFq?=
 =?utf-8?B?V3hSSmJCZ0kxaTduTGk1VUhvZlVMam12UzJUWVovbDcxWWc3blQ4ZCtxcVNM?=
 =?utf-8?B?RERNN1RGM1hxM2ZEYy9yN2p2Rk9aandvNGhzMTBpMG5kNTNKbnY1ZlJyZUlB?=
 =?utf-8?B?RnV2SWRYdkJXS0E2dnZpVElySm16dUdFRzQxcGw3WUFSYUtiTXB5Tlk0cTNO?=
 =?utf-8?B?bFpsQ1I2OTFuZy9aK3JSdWk4VFc1SFV6Y2xCQ0I3NjdzOFNjWjdxTXlBeU5i?=
 =?utf-8?B?YVNNZ002ZDRqOHhVd1pNOVQvakVOT0VReEZIUHV4eThiL2tkMHFYSGVZamZw?=
 =?utf-8?B?bmlzT2dOQnNVVEJBMm9ZWHZEbTZGODZ5K3FGYlQwaS9MZ0x2QUo5SVVjUmZi?=
 =?utf-8?B?QXZ2YXlOdGcwTjJQN3FwL1pMTS9zOFg4ZStLL1FCaGIrdHIwYTBRR1MzenNx?=
 =?utf-8?B?L016SnRaL041UXhOVXVXZVREcVFTa1RiRndaR2dLOWtNdWdoYW53ZzBMVGZs?=
 =?utf-8?B?Z3JJRTFQL2hEaW16TFd3ZUFrNWhUUDZIZ1pNNXlDUHNFZlYzb1NoTGs1NUgz?=
 =?utf-8?B?NFVWbzRUUmlUVlVDNDFrS2pUcStDR3Y1OTQvMVdXQjE2RHdMQ2t2bk5tSCt3?=
 =?utf-8?B?V0xnczZZVFpsaFB3Zi9yei81Wk5rRUZIaEdQdXVVZllqN3Bua3E2c0xEcy8r?=
 =?utf-8?B?V1ZmMjJ0MWx6VDBPcjg0VkpyN0pua0VGM1VSdi83NEJGbnRGVjhta2wyeDY0?=
 =?utf-8?B?RUZFR1NnSE9VZGhNY0thN1R2ZEhneWxETENiSjRjeWNaSlpZcUxlTFE2RHAx?=
 =?utf-8?B?NnVPNEpZT2F1NWpCSTVXNUp1QlE1bnhsVjV1aDZuWngzUG5ZemJTcTNSaUFp?=
 =?utf-8?B?bFRRMlVESTlpRXFIckppcDU0VUJKRU5VYkFMa00yU2NaK0x0S0pGRDRFMnRF?=
 =?utf-8?B?NXhET1ptSUZJbzkrbkFDR3ovbHNiQUZBR1FkNG9adzBEQU1rQ3gxN3FwWFo3?=
 =?utf-8?B?WWp5ZW1HeU4rNkJxbHZEMUV4eVNBRThrMHZyakZhMFpWakNyYWhRczdmOHpH?=
 =?utf-8?B?amVVVVB6QTVHS3A4dXlrMFRPbXpHVXo0bHhXQ1R0V05KdXpWd1gwT1I2U0Ex?=
 =?utf-8?B?MWU1ZUNXZGRSbTZTbks0UlViYWk5Z3Bnc0VQeks0L3o4TnVBM1hwSXpETkNQ?=
 =?utf-8?B?YlBWU1lXdFJyMnZJYXJMR2hDZEZWYlI5K3gzdm1McTdtRUYrQUJCdmdIQUpV?=
 =?utf-8?B?U1pXeXU3T2h3MldNc2w2Rk1sc01CZU1YWURrdDBod1oxeHlHaEZkcFplWjVk?=
 =?utf-8?B?aGNuS1ZBa0FlTnJ0YVlIaSs3QnZmTE5iZGJZdEpKWU1MNG1kM24vN0xMT0Vw?=
 =?utf-8?B?dWtQYW5YZWtEM0N5QW5DNGN6Q2dldllZODYyS0tzRnN0QnlwTE53UkRRdDBk?=
 =?utf-8?B?b1FWbXNlRzlpZUZZYThtRDNhblc2d0FOdWZyRXdkN24vNWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6024.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnB2anBNZ3NnY2NMc1NWWG5yZnlreCt6dFl3T243WktnM0lkZEhMcUtJSGQr?=
 =?utf-8?B?MjV0V0wzZ1NHcjlNQ1VUZlpkd0RDZHN3aExLQWMvbmFNbDM2L2NhK0hLZkFR?=
 =?utf-8?B?YWhPMVNKUFhzbVJUOHhwM2ZlMjJGeHRqVGtyNmpZaWx5UitBTzRGNGoxRXcy?=
 =?utf-8?B?UG5nKzI1R3RpZ2FjMkR5Ky9iTDk2bDd4ZHZlM2x4T1RJNUx1aVJCUVZXRlNU?=
 =?utf-8?B?bkNxb012R0NzT0VwU2czRENJTjdGTG5SZ0tSVEdHNlFTNnZNV2M4cFVYSnpH?=
 =?utf-8?B?T2F2VWdRSS9BVExML3JjNVowOEJUTW9yaVBIRElEblp2a0dzNCtvV0ZSbGFo?=
 =?utf-8?B?a0t6cXQzcnQzKytpMkV3Zk9xZitwUUI2b0U5THNlbFRqakdnMUh1cmNmVnpO?=
 =?utf-8?B?aEowOSt5TWgxcDFSa3JBbTNCc1B1UDZ0eG9KdndWWDFkLzk4NDlGT1VYUk5a?=
 =?utf-8?B?QytWZVlkTHFnQUtnbzBNUXg5YVZQWUFBaDZMUVU0REppZnEvTTVYYWRmQ1FX?=
 =?utf-8?B?cHFSTVNMbVZESzRST2pLNXFNb1U2b1prZXMydVlqV21UWGlMWCtQMXQyV2I0?=
 =?utf-8?B?UEVuV1ZHeFJHQVRJc3ArRE4xY2NoblBxRUFJSEs5YkpIbVpZQVQ4NVE4T3lI?=
 =?utf-8?B?TVVrMkdONnc4dHJINEM4R2oyS1Y1RHFERUxHWWRMdjJra2U4Qk1NSko5WGZE?=
 =?utf-8?B?VGMvSTFJamFhb3NaVEQ3b0dWWmEzL3NBZkNGei9hNGpuYUZRMjNuK3dCd3du?=
 =?utf-8?B?Z1VWYXphOUFPbTNtRkRYK3dwamp4WHE5bEI2VjhrWERBRUxvTEd0UmVwdWxO?=
 =?utf-8?B?bDNFeTlvclJMRmZIb0dtTnJYOFk3alkrTjVJMkg1Q3NpRmpZakVYVWZEZW5J?=
 =?utf-8?B?RUV0MG1KeERiZWZGZ25GOEZKS1FxU0FheGpKc3Jic2NKZk44UlNmTDhDbDlV?=
 =?utf-8?B?VTJ3OGFZcG94c1NlOUVOOXBkcHMvSG51RWxlaFo5dE0xUHJScVQ2M3B6MUFU?=
 =?utf-8?B?b0lkeGx3L1grVFhGODI3T1Jpc1JvZFNJUUdRUzZPeWVxN0hRVXVkM3dUREpC?=
 =?utf-8?B?K1AvbnN0NTNNNGRaa2ViRDg1SnNwZkJjcDhaMXl4cW5IS0FtUzRIZFZVNkJa?=
 =?utf-8?B?c2pjOUlQaGp3a0pJaE55elpEK1pUaWZydTRLanEyS1kzdkU0Z3pJN1hiZStU?=
 =?utf-8?B?NEd1QmNYL0YxWTBUMjNUak9RY2w1MEg3bGwwUUxva0xPNUNmakttNDdKRE5O?=
 =?utf-8?B?ZzA2ZStGUUdHZ0l0L01KS3E1UkVLekRTMzQrWW12NWdrOVhUdjVTc1l4MEVD?=
 =?utf-8?B?TEY3ZjlQR0JjZHN1SnY0aVAvUTJxdXRHd1lyTU9Gd2R1Y3pBSUQzdUhGNWI4?=
 =?utf-8?B?ODJUQ0tUZUlkWE93bGxXL2ZUaDArTGlXa1FhY1g1WnZld283YkFmeXRFMlZl?=
 =?utf-8?B?Nk1FUndYelJBRC84bnZWVnQ3alZXRWlwemE3eEZKUXdnRzFIWXgvWHZJdjQz?=
 =?utf-8?B?bFZRZTIwU3lsVk5tZjhMdGhPSzhlV0RDbmt0RGFOMXg1K0NSNGs1MXdTUE1B?=
 =?utf-8?B?ejliTUNmOG1JQVdVWnV1OVBjamlIei9lMldRTERJd09uWE1DWVJpbUFScDdy?=
 =?utf-8?B?Z1NYVmRIVXRJeUt4bmkxY2hpRDB0eUg2UnQ5SlB3anhoRHBiWWtvSnNJK0Qx?=
 =?utf-8?B?UkNRcDNnWTRkNlRPdnhvL2l6NW1nZGsrazczUkYwOExBaHppQjlpd1Yvb0l3?=
 =?utf-8?B?am9kT1ZFdU5SRGZCbXJZUURxYi9GZ2JuSC9BUDRGTWNvcjhXZ2NLWmlESGw4?=
 =?utf-8?B?YjJSdUxZYVROb0J1ZERjWDlURVg2Vy9HVkJjMWJvYmQ2WGhvWXdWU29wYjlD?=
 =?utf-8?B?TWVGWGtIVEJjekpWUTZxbFNBSTU4bGRMZzdsUEpKQktjWWN6NCtFdGMzWXR5?=
 =?utf-8?B?cVh1MGY0U3drbWx2SXhLNlloV1ZuVGhqR0J6WFlpcEl5SHkyem5Ld24xY3R3?=
 =?utf-8?B?VkdTTjNldG04K0daYkM4Zi9HdkRxL0tJaHFVaXJvdHNRWk1GbVgxSDZRc0JF?=
 =?utf-8?B?QzhyTktPSms2d01sWG85ZUQ5ZDc5R2N5SlZaZndMaExOUWdRNnJaQ2loQ21M?=
 =?utf-8?B?R2hjNHlaSGtDMlZPbXpidVNQMDlFUExLbHduRDJFbXpOeW9Ta0k3R3NRNTJB?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6024.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eb62ff-ebbb-401e-8a4a-08dcd0e01865
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:00:07.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3gtmTESg1jaFtd2y2RPXB8U9Q/ABflpMOEQ2FPEcun05LrbrGXD9GNhOT0cua4IuNKUWIBFjP+zOcKrTeMVOjAa6v/Q/U5vgHGDAnudMyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10001

SGVsbG8gRmxvcmlhbiwNCg0KPj4gSeKAmXZlIHRyaWVkIHRvIGNvbXBpbGUgbGludXgtZG92ZXRh
aWwtdjUuMTAuMjE0LWRvdmV0YWlsMSBnaXRodWIgDQo+PiByZXBvc2l0b3J5IGZvciBYZW5vbWFp
IDMuMi41IChmcm9tIGEgRGViaWFuMTIuNsKgaTM4NiksIGFuZCBpdCBmYWlsZWQgb24gdGhlc2Vz
IGVycm9yc8KgOg0KPj4gKHRoZSBzYW1lIHdpdGggWGVub21haSAzLjIuNCkNCj4+IA0KPj4gwqAg
Q0PCoMKgwqDCoMKgIGtlcm5lbC94ZW5vbWFpL3BpcGVsaW5lL2luaXQubw0KPj4ga2VybmVsL3hl
bm9tYWkvcGlwZWxpbmUvaW5pdC5jOiBJbiBmdW5jdGlvbiDigJhwaXBlbGluZV9pbml04oCZOg0K
Pj4ga2VybmVsL3hlbm9tYWkvcGlwZWxpbmUvaW5pdC5jOjIzOjk6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiANCj4+IGZ1bmN0aW9uIOKAmGVuYWJsZV9vb2Jfc3RhZ2XigJkgWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+PiDCoMKgIDIzIHzCoMKgwqDCoMKg
wqDCoMKgIGVuYWJsZV9vb2Jfc3RhZ2UoIlhlbm9tYWkiKTsNCj4+IMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fg0KPj4ga2VybmVsL3hlbm9tYWkvcGlwZWxpbmUv
aW5pdC5jOiBJbiBmdW5jdGlvbiDigJhwaXBlbGluZV9jbGVhbnVw4oCZOg0KPj4ga2VybmVsL3hl
bm9tYWkvcGlwZWxpbmUvaW5pdC5jOjQ5Ojk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBv
ZiANCj4+IGZ1bmN0aW9uIOKAmGRpc2FibGVfb29iX3N0YWdl4oCZIFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPj4gwqDCoCA0OSB8wqDCoMKgwqDCoMKgwqDCoCBkaXNh
YmxlX29vYl9zdGFnZSgpOw0KPj4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+
fn5+fn5+fn5+fg0KPj4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
DQo+PiBtYWtlWzNdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6Mjg2IDogDQo+PiBrZXJu
ZWwveGVub21haS9waXBlbGluZS9pbml0Lm9dIEVycmV1ciAxDQo+PiBtYWtlWzJdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTAzIDoga2VybmVsL3hlbm9tYWkvcGlwZWxpbmVdIA0KPj4g
RXJyZXVyIDINCj4+IG1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDMgOiBr
ZXJuZWwveGVub21haV0gRXJyZXVyIDINCj4+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTgzMiA6IGtl
cm5lbF0gRXJyZXVyIDINCg0KPiBJIHRoaW5rIHRoZSBtYWluIHBvaW50IGhlcmUgaXMgdGhhdCB3
ZSBkbyBubyBsb25nZXIgc3VwcG9ydCAzMiBiaXQga2VybmVscy4gV2Ugc3RpbGwgc3VwcG9ydCB0
aGUgY29tcGF0IGNhc2UsIHNvIDMyIGJpdCBhcHBsaWNhdGlvbnMgcnVubmluZyBvbiBhIDY0IGJp
dCBrZXJuZWwuIE1pZ2h0IHRoYXQgYmUgYW4gb3B0aW9uIGZvciB5b3U/DQo+IFNob3VsZCB3b3Jr
IGFzIGxvbmcgYXMgeW91ciBib2FyZCBzdXBwb3J0cyBpcyA2NCBiaXQuDQoNCldlIGFyZSB3b3Jr
aW5nIHN0ZXAgYnkgc3RlcCB0byB1cGRhdGUgT1Mgd2l0aCBhbiBvbGQgYmFzZSBoYXJkd2FyZSAo
SVNBIGJ1cykgYXMgdHJhbnNpdGlvbmFsIGZvciBub3csIGFuZCB3aWxsIHVzZSBhIDMyIGJpdHMg
Q1BVICJWb3J0ZXg4NkRYMyIuDQogDQo+PiDCoA0KPj4gSeKAmXZlIHVzZWQgdGhlIGNvbW1hbmQg
wqvCoC9wcmVwYXJlLWtlcm5lbC5zaCAtLWxpbnV4PSMjIyMjIyMjL2xpbnV4LWRvdmV0YWlsLXY1
LjEwLjIxNC1kb3ZldGFpbDEgLS1hcmNoPWkzODbCoMK7IGJlZm9yZSBjb25maWd1cmluZyBrZXJu
ZWwuDQo+PiBOb3QgYmV0dGVyIHdpdGggbGludXgtZG92ZXRhaWwtdjYuNi4yMy1kb3ZldGFpbDIu
DQoNCj4gSGF2ZW4ndCB0b3VjaGVkIHRoZSBwcmVwYXJlLWtlcm5lbCBzY3JpcHQgZm9yIGEgd2hp
bGUuIFNlZW1zIHdlIHNob3VsZCBiYWlsIG91dCBhbmQgY29tcGxhaW4gbG91ZGx5IHdoZW4gdHJ5
aW5nIHRvIHVzZSAtLWFyY2g9aTM4Ni4NCg0KSWYgSSBjYW4gdW5kZXJzdGFuZCB0aGF0IGZvciB0
aGUg4oCcbmV34oCdIFhlbm9tYWkgNCwgMzIgYml0cyBpcyBleGNsdWRlZCwNCml0J3MgcGVyaGFw
cyBhIHBpdHkgdGhhdCBYZW5vbWFpIDMgY2FuJ3QgY29udGludWUgdG8gYmUgdXNlZCwgZXNwZWNp
YWxseSBpZiB0aGVyZSdzIG5vdCBtdWNoIHRvIGJlIGRvbmUgdG8gZml4IGl0IGFuZCBtYWtlIGl0
IHdvcmsgb24gMzIgYml0cy4NCklzIHRoZSBlcnJvciwgb24gWGVub21haSBzaWRlLCBvciBtb3Jl
b3ZlciBrZXJuZWwgcGF0Y2hlZCA/DQpXaGljaCBrZXJuZWwgLyBYZW5vbWFpIGxhdGVzdCB2ZXJz
aW9ucyB3ZXJlIHJ1bm5pbmcgb24gMzIgYml0cyBmb3Igc3VyZSwgb3IgYXQgd2hhdCB0aW1lID8N
Cg0KVGhhbmtzIGFnYWluLA0KTWFyYy4NCg0KDQo=
