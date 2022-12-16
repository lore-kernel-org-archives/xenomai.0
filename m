Received: from mx0a-0019b802.pphosted.com (mx0a-0019b802.pphosted.com [205.220.162.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE618490
	for <xenomai@lists.linux.dev>; Fri, 16 Dec 2022 19:27:49 +0000 (UTC)
Received: from pps.filterd (m0240894.ppops.net [127.0.0.1])
	by mx0b-0019b802.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJFa0d008687
	for <xenomai@lists.linux.dev>; Fri, 16 Dec 2022 14:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps1;
 bh=dFAByNsVSUaV9c+8brTZIavdgI/hJ9J4gI7Q1E0nJDk=;
 b=IX/wrhE+iwmja4IBnaxKD153q8mHRTCbu5pfD8MWXioBMT0voAg7h9CW1yg5QmFatH+f
 KWK8D+oB4sGPfFCXKZ+MlR0RP/RFaRGkWjkhhFcn4clq86Yz+dzWHMi2jmc2kEq5sjYJ
 cgGX7VvhMxN1U9BSK4qZvg89qsN1BSmmGcdWlDdxf6B0DEgsHbTYmhI6C/8WRqHbsYlB
 GtNwnAFLdMHjomr/PcQJFuw5SmhlKT2/YPtLr7c4R/PIG0ljhfunlgr/VObuQCg7iNml
 9iapYCYyzIQyIq5mCJLixbaLrn44gfXu9KVS44ATWil/Fk8Ci3kXHCyEpxzusYq+1uq7 NA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0019b802.pphosted.com (PPS) with ESMTPS id 3mf6q9hgjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Fri, 16 Dec 2022 14:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGXMnj5MwHr9S1BUz/u1cYnZ9fXRLfaO+hTXtTIvj90821L1etWkPvutbeR1IDteNW5MmrjZVDx1n0lOsehDlvK/rauNJQytFFB2oD8bZZXkdoynzAQAY2lRnL+sdGqu9KMSJaIrQewLBbM+v5n+DRQcg99Mmu/YBL5EOplTUJ3+Ftbm8EL34US3xQ6sT528prSBmI2FSaEUBn21N1UfFvaFfwSxhs7Ow+egNJTqS8/yAMr7a3swfGLg8ZlF/TT5L7W1tgfddbsOQT1RReSgMHbZe58WUizp8wvRjKomQ6swNPvpfKMF0IxVUpJcCjEzBAPI4+tNrWZXAZTAnbtGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFAByNsVSUaV9c+8brTZIavdgI/hJ9J4gI7Q1E0nJDk=;
 b=LUSMjVUDsYPLi60LbVS86gDjeWW1DU25lDdYyjsZki1KJ8aa/fsfYsjLjA8Z9wiDR4KyFhyyO9lJXThjRz/lPZtRIBiV2GkUPYTO4p7nUYnuX9I7OWYgKhCibx+AT7dHNCdsr6hLVgbJZ2xpSyeINI2OCwb9gNm0QaTTfx+DeVVhxPhXw6F2PJU41QCqgCv+uauQAr1jwrCpXev8Ano+uQm5BEayUvMIZNXXirkMuy9QbJ4DbGkYODRWDqpqYx2BOmUnPx/j5yzAx/03qLsIb2yxC1fmnpXshqwHcE/1lWiFsfvJfmGIghzMTvLVoga43gnzgcf181mCNlPBaX8ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=3dsystems.onmicrosoft.com; s=selector2-3dsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFAByNsVSUaV9c+8brTZIavdgI/hJ9J4gI7Q1E0nJDk=;
 b=pjZ+vG5gEzMg7pHN5MPCV4s4x30O3rKGi/3Xqi3X+5PEwkaP20VZheGfTxGLxpvpqOPow1+PYq62J6EfheKzZ0qFSuolMQxjLpIaYUgdjscZX65lgAhvRK2utUJ7KVHFqIuxFyrcXOVRJRqpvvfoUbL9fJxWM6Z7iEBIzzTnxHE=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 19:27:38 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf%7]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 19:27:38 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Patching Dovetail with xenomai-3
Thread-Topic: Patching Dovetail with xenomai-3
Thread-Index: AdkP7SY9DaB3hxUOTbuGgf6/6oEF7AABpNmAAGPgayA=
Date: Fri, 16 Dec 2022 19:27:38 +0000
Message-ID: 
 <MW3PR12MB4460FB2D125F42198BF6CDEEC2E69@MW3PR12MB4460.namprd12.prod.outlook.com>
References: 
 <MW3PR12MB4460A675E6117835996906F0C2E09@MW3PR12MB4460.namprd12.prod.outlook.com>
 <ed42864a-f219-0e57-9638-bd0a6c4c2aec@siemens.com>
In-Reply-To: <ed42864a-f219-0e57-9638-bd0a6c4c2aec@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4460:EE_|MN0PR12MB6103:EE_
x-ms-office365-filtering-correlation-id: 5d0d8854-5498-4698-ba14-08dadf9b97f7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 A8iUl/NULv/f3e4MDbO8LzOnnO4QozO3tsxvkyeM0npMLk96ZsbMSwEFIwJVimWiAP9ecK6RzVQETc45TPWfnLD7lSfPucK8CiIwLq2BRM0TCcyE3q6xqSHfcGN3+cAnXRQ8g73HM51OJya1CwGL+DgZ1qQMbKo+/CAdXDMDyVqiE3WUrmq6BA/aNnG+xDKLtrkxM8vhjiz/NrKHqmLEmABohv/81qADdP5CcV40jTQUzEjhY4Nc1o6HoWT/9yjD7vPycpccumEr9ixc3GsSGj1XQOudG4m2pwmDymX9BdK2UmxAC1YhxlbC9jSZqtGnPmudvt0z7/wBO8Yzy/sh5TdAErx0wZ1Z440ioZjvqgxeoleF7tn9/KumDFlMNO9TOQi7DAoxT2p2ST15zlNwRqQUXrPuiBwgoe64W7EhmWZi/pl4wvi0Al6Fj4F6Ozq2kGTuyt7U/uM1zQ/9HjbQ7R+dpjIwXtDrYp8hUTtbEJJThxer2fEM5fQiiZ5P8b4Gu0OXl6E+DZdRKVg2/NMvfplXEyKiYgorVl1D2+5OSLgzXS34aBedquDIB4sT5ZLpl4kqJlXcNrVtf4Pj6/QHEHXykEbDXO5lSCBlRMI+62JU6+tdtxToOwv8GHvhpaZIQRg8TId5l8eUDyFHmRyo9FZsj7hwMWxtRBaB1DJbbpDVNLHP5dt/IFxRQgTZsAk82TNe49T+0CcBKlrnL4Fumw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(38100700002)(122000001)(86362001)(8936002)(71200400001)(52536014)(478600001)(55016003)(41300700001)(66556008)(76116006)(2906002)(6916009)(8676002)(64756008)(66476007)(316002)(66946007)(6506007)(9686003)(186003)(26005)(7696005)(5660300002)(53546011)(83380400001)(38070700005)(66446008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dzlJNjlaZXh2aGUyRVJzekV0a3diTzZKTzZNaDZ6aTBjOFlzZytpZnBMSEtz?=
 =?utf-8?B?c3ZPR0ZnclBiZ2g5UHQ4anpiYmNOR3kxNEMzMVZnVmFVRTgyUk10UG5XYmRv?=
 =?utf-8?B?aW13Kzd6VXUwTUJseENpVFhpZjlZL3RLaHBneUlNcjVCSTBGVEFUUHRRcDhh?=
 =?utf-8?B?RGZEMXpNanFFeVV2S2xkUUZUbDZLOXlIdTZXNTlNT3c5MHMwSEFGZVFoNFpJ?=
 =?utf-8?B?YTdoRU0zcFl3SGY1TEtvTjRzdE45YlBBRzNWU0xCbnhSR1kwYVFTSnRjRXYy?=
 =?utf-8?B?VEl5OHl2eDZqN0x1NXp1eVNqZ3NPU1FZSUd2UDhNaHNSWVU2azhoOGMycnB5?=
 =?utf-8?B?aVAyT213RDk4U0c2d3Y4L2xHU1kzS2VmcjNFZWFYU1JwK0FoWm8rK1ZNajhu?=
 =?utf-8?B?OXMrV05qaXNMQWQ0UkJKVDhYY21qWFJkNXVWSlQ2TUFGRWtUd0l2NTQvMDND?=
 =?utf-8?B?SnJ4VEMyM2F5RUJoTVNqaWNQand3Qk83VzZ1TGFEcWlPMzJJbFZ2WFk3NHEz?=
 =?utf-8?B?WWZiQWxSWXVZbjhwbnBvWGpkL2hQSnlZdFhkRGwvdm82TElaY2JlQ0dtaEho?=
 =?utf-8?B?eUJKaEdkamlVeTZMR3hwNktOWXF0Y1JBSWhYa1NGZWxLV0lHMmE1YXdsbjNp?=
 =?utf-8?B?Z1dJcjNUK0g5UGRuY1BZNG5mcVNjeWJoSWxpSkdGTmMzR1RGdG5jRDF6ZDFS?=
 =?utf-8?B?Mnd6YTVTMU5lNEpDREp1QVYyazJ3b1RFNlZlZStob2dob2FNYWJDVXNYeWo1?=
 =?utf-8?B?blhNVkM3MXorWUJFQ003MzRxUUIrbWgvNzJBSjR0TkNOcDFQVkhTaXJERG54?=
 =?utf-8?B?MHRwRnpGQnhENzg3dmdIQWp4R3dpNlN3R0lhMkc4a1I2L1lxNHp6Y2xqNnVL?=
 =?utf-8?B?M2ZpNDFKTjZMR0R6Ym0wMktnMFdBQ2ZBeHA5cTRXOEhReWczY3FHNy9PQVVO?=
 =?utf-8?B?NEZJUlMzbHRVMG5uYWtDeGdjV0VoS2plb3pFSVBLSVVHeW4xZHcwMnlzZSty?=
 =?utf-8?B?aTZWRVFYSHpUNUpCR2xYRDBHV0hpeExIdEJrM092a2k0bmgxSU44clBJODN1?=
 =?utf-8?B?aUVhYlpOOFpiNkVjSzNBTDdLU2hHQXBpeWdaNlV2aGxTMlFRQUpMd3ZURnpN?=
 =?utf-8?B?Zmd0ZE1nZHMyY0NzRG1sWHgvSE1pZFFyUldEVmdrb2l2Q3VMTXpFcW0yUVZl?=
 =?utf-8?B?MXB1VWpNZDBqL05oYkw4cjNxVWo4OTRaWEptSkFXdHE3NklHREc5ekxWQkVi?=
 =?utf-8?B?RGwrVUhYbHdEc3dkR0JVM3FuMlBiVjhQaDZ2c1lTdjdHRFhIMzZhNjJLaE4v?=
 =?utf-8?B?UVdtekdvYlZ2bkIycGszYUVzYVlyVXpTT09ZMGpHVk1uNUw3SWsxcE53RTFr?=
 =?utf-8?B?dDdGZFFuRmRsRmd6ZlJ0dGwrd09GWVRUZUVuRnQra1RJR1d2NExHMDdlNjY3?=
 =?utf-8?B?VjB3QlNIVVZYZXlkQUpXNGZYOFIrT1JqK0V0Zk9jTG1MWXZGT3BybWsvcHN6?=
 =?utf-8?B?NUFmby9iVnYvSHB0cjNENnd3ZHpON056RnpDSjJwSDVsVExUQVFTUTVyNFJp?=
 =?utf-8?B?Mlk1aTQzK3FzeUFLRmxEWXFteWxiM2ZUZHYrYnR2YXhFZ3Q1aDdVMjVoYTA5?=
 =?utf-8?B?NHhrVzNDSjJtMi9yV0Y5WCs4SDJyWW5pN29ITkNhbnJLN0NjUEpuOXJIdUlR?=
 =?utf-8?B?UTV0M1hER0hnZnpyVG9YeFFRQ1A3anNJZFZLSlJvUlp1Q2pRMXljZTVhR0FV?=
 =?utf-8?B?RUlsaXlMM3BJNzhVdHhUaU8vZFpKeFpNWEIwUTJsYXgyTm9iQ05iZ3RtK2Nt?=
 =?utf-8?B?V2t0d09zaTFWT1JtdWUrNEVMMjFLdlo3cGxQWXg1aWY1aGNEQmFsaHg0cDlG?=
 =?utf-8?B?dG9Xekk3RHRudzg2K29hSXFFZ2tFV053STFESVFTQkUxQ0I0MXpTRE85U3Ns?=
 =?utf-8?B?ZC9VcnF1WSt1ci8vcjRTNUNvdzJUWC90VWxZN1FFSm1tTjR1dDBMTmh1K2wz?=
 =?utf-8?B?L2hUMzUyMUpTMWgxMFdoOGxuZWRYZUNzTnArSU9ia1ozN2VNVlpnZ2lUdFIr?=
 =?utf-8?B?S2hBSFF5dm5KcGFIWVlwblNFRklXWGxtMUU0bERzWTZ0dGxKSVlaZVZTa2Vn?=
 =?utf-8?Q?Ds5IZw3U9FdchUKJSOhIohJEQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d8854-5498-4698-ba14-08dadf9b97f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 19:27:38.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKqbPCLo+ThIvHYGLG5RFrDpfoNYGhxQWG7QtN8OBo7NLJWXIbAxq3yhyGK/kPf7/WyxfAIj2LpTlvmpZn9W8OxbxT/5pXqPDS6o1E1ZnMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Proofpoint-GUID: 4TNWMkP54exfQr_i3ySCD1ottIXjzT8L
X-Proofpoint-ORIG-GUID: 4TNWMkP54exfQr_i3ySCD1ottIXjzT8L

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDE0LCAyMDIyIDExOjM5IEFNDQo+IFRvOiBBdWVsLCBLZW5kYWxsIDxL
ZW5kYWxsLkF1ZWxAM0RTeXN0ZW1zLkNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFJlOiBQYXRjaGluZyBEb3ZldGFpbCB3aXRoIHhlbm9tYWktMw0KPiANCj4gT24gMTQu
MTIuMjIgMTk6NTksIEF1ZWwsIEtlbmRhbGwgd3JvdGU6DQo+ID4gWy4uLl0NCj4gPiBTbyBteSBx
dWVzdGlvbiBpczogd2hhdCB2ZXJzaW9uIG9mIHhlbm9tYWktMyBpcyBiZXN0IGZvciBwYXRjaGlu
ZyB0aGUNCj4gPiA1LjE1Ljc3IERvdmV0YWlsIGtlcm5lbCAoZm9yIGV4YW1wbGUpPyBJIGRvbid0
IHNlZSBhbnkgdGFncyBvciBicmFuY2gNCj4gPiB2ZXJzaW9ucyB0aGF0IGFyZSBvYnZpb3VzIGZv
ciBDb2JhbHQgb24gRG92ZXRhaWwuIFNob3VsZCBJIHNpbXBseSBnbw0KPiA+IHdpdGggbWFzdGVy
Pw0KPiANCj4gU3RhYmxlIDMuMi54IHN1cHBvcnRzIHVwIHRvIGtlcm5lbCA1LjEwIG9mZmljaWFs
bHkgKHRoYXQncyB3aGF0IHdlIHRlc3QpLCBidXQgaXQNCj4gbWF5IHdvcmsgd2l0aCA1LjE1IGFz
IHdlbGwgYmVjYXVzZSBtYW55IGFkanVzdG1lbnRzIG5lZWRlZCBmb3IgaXQgaGl0IDMuMg0KPiBh
cyB3ZWxsLiBXb3VsZCB0YWtlIHNvbWVvbmUgdG8gbG9vayBpbnRvIHRoYXQsIHBvc3NpYmx5IHN1
Z2dlc3RpbmcgbW9yZQ0KPiBwYXRjaGVzIGZyb20gbWFzdGVyLg0KPiANCj4gU28gdGhlIHNhZmVy
IGJldCB3aXRoIDUuMTUgaXMgbWFzdGVyIGZvciBub3cuDQo+IA0KPiBKYW4NCg0KVGhhbmtzIEph
bi4NCg0KSSBjYW4gbm93IHNlZSB0aGUgZmlsZSAvcHJvYy94ZW5vbWFpL2RlYnVnL3JlbGF4IGJ1
dCB0cnkgYXMgSSBtaWdodCBJIGNhbid0DQpzZWVtIHRvIGdldCBhbnkgc3B1cmlvdXMgcmVsYXhl
cyB0byBvY2N1ciAob3IsIGF0IGxlYXN0LCBnZXQgbG9nZ2VkKS4NCg0KRXZlbiBpZiBJIHJ1biBz
d2l0Y2h0ZXN0LCBub3RoaW5nIGlzIGxvZ2dlZC4gSXMgdGhpcyBleHBlY3RlZCwgb3IgbWF5YmUg
YQ0KbGltaXRhdGlvbiBvZiBDb2JhbHQgb24gRG92ZXRhaWw/IEknbSBzdXNwaWNpb3VzIHRoYXQg
bXkgUlQgdGhyZWFkIGlzIGdldHRpbmcNCnNwdXJpb3VzIHJlbGF4ZXMgZHVlIHRvIHNvbWUgb2Nj
YXNpb25hbCB1bmV4cGVjdGVkIGJlaGF2aW9yIGJ1dCBJJ20NCm5vdCBzdXJlIGlmIEkgY2FuIGRl
YnVnIGl0IHdpdGggNS4xNS43NyAob3IgNS4xMC4xNTcgZm9yIHRoYXQgbWF0dGVyKS4NCg0KSSdt
IGhvcGluZyB0aGlzIGlzIGEgY2FzZSBvZiBwaWxvdCBlcnJvciwgc29tZSBzaW1wbGUgY29uZmln
dXJhdGlvbiBpc3N1ZS4NCkFueSBhZHZpY2U/DQoNClRoYW5rcywNCktlbmRhbGwNCg==
