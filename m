Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3F7486
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 20:50:29 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2Gsevw018341;
	Fri, 2 Dec 2022 12:50:28 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0178.outbound.protection.office365.us [23.103.199.178])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3m7na20p8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Dec 2022 12:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=fzQc3Tkw+lsqMmiDVI+v0OnCXq+UOf5yMsway0eJbhlYtIrS0639QTG6p9h/vSNbyUdKsaPFiN76jNd3D4FITIpITSK6c/9VAHdS7xQ9rDje13E1tudIfmb3iOsfRBczd0r2qu+AguXfVvbOz2/k5zbqmDxgnN9M6X7Tk7zpgs833lEmZHCEWmoT0FqSwVuN21ZNbAmb7tdptNfUlLcZtNY8K5PYAwKzhHie4S/WApXC/LELNVTJGsbp+ESCHgKwPi7HSfLv4IFh3bhHUQovrIBnp+u2S/RGEp2oAD15JF8Dinu2kPdMqCFm3hqJ8Lx7sLzTGubtG47RZ380VXtMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuNb97skwyw7TgKbL0wJnymaO+E2IMojnXnnE++GLKA=;
 b=l/xIN+qh8lZFOYfIRawcq/CGY2B/kADVO+jM3xksqoyPdVpDFxVv69/Ph4nAGgNPQp1u6Fg3EzmqMypGnIveQFeV3zYJE5U2EAc0Oyk15kF5hQKha6RpSNSd+/sBP7BdXzq1T0tedP6LBmxfi9xvFjBNkYMTVDE89YJG2wFKzmt+GOFPmwbZgEtueYttjWelhW7wq4WpaT5HVXL6JKOTFFPxVrBIJR90/v0svupXP166UwotIoPlB7Nto7xmM70zKrbPhtczPsmOJdbCQULMdTfrIgVg6sCplsWK+jx4IozN9wxW9I7prncSoN/5RV/B4ufJbDV+CcxrA8nOhhJXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuNb97skwyw7TgKbL0wJnymaO+E2IMojnXnnE++GLKA=;
 b=Iwo0XDy0rIXhS1WJ9F+2a6nl0iO0zqgM6w19Q9uS3Uk9mnUsmBAYPLRoHQUIrIhqbdvsXQ/PaVi/2ZUFqzIr51NAYiMd0aBiSEzvM2IlO9w2qFdoZaS9YNGgo1AenCiWrQ9fJldNYr8jj9Q5nC27mCpzD6aat1CDzDMBtgrpJn6BP+QaaI6yeQNUxC8fjWYXPwtDnUROE1ZMfR4evoLcN93Y8GJfABwm9bq+qo7WRu5iZICJY4YY3Ylufp5XO4FKg68EPqWNM4HV9d4VIm2nizOjmD2mh+Zmnqe8HM8FSg7jbNRKz/a1TLvl10/wr1jGgBzGnRnZQcWTdYUcqXWsqQ==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1297.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 2 Dec
 2022 20:50:23 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%7]) with mapi id 15.20.5834.022; Fri, 2 Dec 2022
 20:50:23 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>,
        Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNAAVlSalAAAyZ+gAAIpzogAFofRaAAL3JDAAALO44gABv0W4AADFRKsAAAioEAAABkvAAACttgkA==
Date: Fri, 2 Dec 2022 20:50:23 +0000
Message-ID: 
 <PH1P110MB10508B8825B0DFE55BCC0FBDE2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877czothz0.fsf@xenomai.org>
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10502B0F1F62BFBA1CE3D3EBE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6yj6mvg.fsf@xenomai.org>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87wn797rj3.fsf@xenomai.org> <87sfhx7qta.fsf@xenomai.org>
In-Reply-To: <87sfhx7qta.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1297:EE_
x-ms-office365-filtering-correlation-id: 9ab716ca-966b-4dd3-9ca3-08dad4a6d552
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2wiYEFzSTBbXhaQnj3tgY3TxklSclqOdN7meqhaeKtSXprvkFyHzhsnW2EZVpvZBMBnAVotJbeHs1Q/AIYsb9wzsJRWAjgd+8b2gMkjw5j2GFXLAtuyD1zkS/NysFHENH5tPClNMHZxz+LIYy8MqwnjFDueTEIuHshgcWIm2wFp5sdNSMEKpil0BpUjpCJO3/ZQKKuRq79NfW6GaooO8Ky59RZh/VGkVHHLPN+zSB/wMmPMIHaQVjhBQFZUTLsAoEVthF7yD0EPqhCBb2vssaaMe0jZEdig75p48QGXcU7sTFUBD2q8N8JqenliIv/8jdGWCYkGF4UrlpHPi4uY4Rvd/aM/nRCudEp+I8XoRloPtVSnAld3scLg8dHB3Vrn+TSi6VLj0pqNR9Bn52bm4xzL0GO1DvfswtsaugUBR1O6PJAUqePViKnqYgAvz7XJpIZdko7Fj4kgHKA2Iz+urf79s/lBhwyoMPITB6HcCbwzRk4CpAQIGlTjgpauyQiTjsmcShRJqHXRQ66Z5EQ+XwlQ+RQ9O+AoNp2OTlGkQi1K/cQDp+35l5EaCjdfR2gkvcEAkyyaXrIKlceMOyyaAL5EqpqFUDOfn3vsVdZbSI/A6IZN5s3Yk2VTO8iG1t/v+KTtOSA429nQlqi6FN2mBn+XiQLNSVQgUXvKHo9Uqh/ugh5Ec6/t7/1S16e83Nw+w
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(366004)(396003)(136003)(451199015)(55016003)(122000001)(38070700005)(86362001)(66556008)(41320700001)(99936003)(64756008)(66446008)(66476007)(6916009)(66946007)(8676002)(76116006)(4326008)(5660300002)(54906003)(186003)(52536014)(9686003)(8936002)(44832011)(107886003)(2906002)(6506007)(7696005)(41300700001)(71200400001)(508600001)(38100700002)(33656002)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?huZxFgmJY905kZw+KR6Ncl2plg6GQqtCtZKLQhPQktBSMSJD4h7zTXwzML9L?=
 =?us-ascii?Q?7M4ZrxwdvjfqcLOM8P+Kj6No9/nj3Vz41TcDNaBF6k0w3ARZi/xGd7tXDyvh?=
 =?us-ascii?Q?7J7cl94tLhRGC7M4znp0pcUIme/WKIxazE//nXNN7kSEUARcE7znGggjTGDW?=
 =?us-ascii?Q?ivsJM/ulWAm0bcc6EryeISf9ce8gXtwhRAJEm/zuQWeOljfg7TrAHrRFeP9h?=
 =?us-ascii?Q?g9QkJl+fw4rtJLEQ+hTLzWkaBlvvkqS9+UOwncE7qsKqUTL6kL7mNXfJTqRY?=
 =?us-ascii?Q?FFlvyu9tSzuOMYJkj+F7mBLUZwFFsRmwIC+33VCC22Kvnq/rmIz3SFmgRPaT?=
 =?us-ascii?Q?tPutco/SzVxAOIh6zj7IESATgMsgkKWLAuaRoJsBv8vQe3pfkOimNjScPhym?=
 =?us-ascii?Q?3HU3EkhmeUbJ5jMLedEZN2j1tKnnCs1Zdu8Zt2wEnkT5MifGh+/DnWe/0EmR?=
 =?us-ascii?Q?p/w0kqa9yFmDS7s3FraBpBzaa9qsSBqxJXlKctiob1qw/9qqszhP0IZkqkr6?=
 =?us-ascii?Q?2Av91OSOwlxGraqtb/uTYdtnnjs0qzf0MlU5OIBl1y2FRZmBaby8z8nxrVDY?=
 =?us-ascii?Q?9AWhBGcwmt+mvs850wn1dopulPNYyWPNzs1p8rc9vPk5Qz8mhPnbDBkhoyx1?=
 =?us-ascii?Q?ySLZx5Q8GrRAlPQ+LEhnePD+VuS0EcZWHCuapvTflhMeAyhZEsdt2l0GKN29?=
 =?us-ascii?Q?qaZe2Vz4c/U7RcCupboUz4hDWsnx6k0kQ+CFf6kEPZCfB2j8f5W1q3kS0Zh6?=
 =?us-ascii?Q?gc6BuO5oAdiWGXeJzXHxu1Tjc7bMP6KA++A5GTZpVGtB/eLOWlw5G62hD5IC?=
 =?us-ascii?Q?SDWai7VGfZrWgrRSyIzzSOHIMHPOLfqE7CTRFZzKDDhbOcGH3EdkXdxJT1NT?=
 =?us-ascii?Q?KPI+OFch7MNL/M6iQT3msRRPZSgPkN68u3wr3RSsB7eZTxwSJfsmiYEn83zQ?=
 =?us-ascii?Q?Nd8WyFas+obOp9k0nOY3hDIQspkB84uKRjYED8xK2viAgsOcUOp6dsDaMGdL?=
 =?us-ascii?Q?8Q1yxTkksqJT0k03+7Lv2Kk3MmpvU4xhC68YmYfyx6fj7VGmDsyV0cCeTA/H?=
 =?us-ascii?Q?GC8hHGb658s2Lpk/WMEmJFYYqo+CFy/bUXdlKpD3zooayY+vEyoUpTqmv0sO?=
 =?us-ascii?Q?pyzJTis46OXLSAssrQnspg29Je7DioEJHdjnqIZvhFFv+46v3fRzWa0yDEZk?=
 =?us-ascii?Q?1z/qQ8d9m0dWsK2D4ufLfhluH1yLC0DePXb1PJ7aAbpkLi/32CadyGpMhreK?=
 =?us-ascii?Q?OnXCj/Aw8ez6jAbv5G5c4jpIRz9w1JQMuceKnDl1heWDND6+crcBuC6Ld65a?=
 =?us-ascii?Q?PIfe+5YERx2LFR+K3fcXV7dq0FEbYRRKxsY8hsahTAFd3QJ8x6+CXsRLCrGI?=
 =?us-ascii?Q?EAB0HTv1/L0t3s08Me8K8XlgbiDueMPXs/a+nhNF3hM1hZVSJDOhRG5Ce1Yj?=
 =?us-ascii?Q?hKkFI9TzXNuiaTxp+c0M6DeODHWNMVF63ioZlGdcMsOEwV6BHxgvnq/kiy4W?=
 =?us-ascii?Q?UX1+Gdq3Uda/7Tx4Cebm20fHG91ZYT4SPdw5WqzoMcpqSEuFNFFRy58gHCOg?=
 =?us-ascii?Q?XdrRrZSFv8QaaTF5rbqXE5qtzTx1xHW/hl5u1IJQJ3XPqh/MqFB4v3432Viz?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_023C_01D90655.05739CF0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T9NA37RmiZML6F4h+ng3NgmFPHjJEsxlMCmAXz6AATrguqDUPeA2YpZlR4B5CZ9A+3SvTvvqArzSmYsv5srw1FaQH1UK9pJPx9Wxhyb+vCJv3vwbiKWpZfCDJESeQcGfnP4qXJBgEhrK0nJyGA/pLczN/QiS1bklX0ZH4WsBQX0NsoF3a/ZdL94zeGuQMRiz1UOSMDvZWfVxGkE4HBkl4OY4+vv+5vVk8mtZ/EjOhR88UaKsqNJpAMma2cI/aoAvuvORKteH2sdw64tTT90AAPGxWw+MaW8bRuRDBRedy+3ERTFgOKgL7DzRV5ORyi45FKJYTO6SDvYtaOb9X+eZaq3pxJOoXJf4QNVl/DEHBfuGCIg7bPrr6xpXj0M7+rzj2S4naiFkEAOKpCCeUcK4bgf7IzKtyeElJaguee7PmqZg9NJsnjoq1/w/UbChNC0Kq9+zYy5U2ieyS+VDtUQHTzSs+rZrGTjoeRzBhjYa0BdKBYJ5y9ntpvZ/mCeGDg95tj+RXneW8VZnV2bqPsegRjNzBIefevsaIs8C/ux0XPsttQKo+0nlJw++eZawLP0rjgxBlyLK21LqZKUAnTCR6t3zARK6qPTAX/Uoqm6pGOxN4DrqiAEdKURapnGMgPasUE2LzVQauNqTrulXE33+3w9UYskrUnvMomSYGQVzIV+Xj1+n+F8hIdIKn7Aox0D8Lxr+exCqNu+JkTmkxyeEKTstPShgcpnTLdQ78+SBwDYospRJ1ERXrtGpYUTL73gx3jTrP7iJogmPxO2HMYsAxkn8HiUtlZXKOEsmjLFpBMUbJdOQ9lVhMODL2sdHE5bD
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab716ca-966b-4dd3-9ca3-08dad4a6d552
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 20:50:23.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1297
X-Proofpoint-GUID: BdtB1y2bmTXW_qmK3FRPE44HQAGS5uV2
X-Proofpoint-ORIG-GUID: BdtB1y2bmTXW_qmK3FRPE44HQAGS5uV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020168

------=_NextPart_000_023C_01D90655.05739CF0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_023D_01D90655.05739CF0"


------=_NextPart_001_023D_01D90655.05739CF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I enabled all the ftrace stuff recommended by the wiki page, ran my test
app, and the system ended up getting hung so I couldn't get the output of
the ftrace.. I got a ton of kernel splat.

Thanks,

Russell

------=_NextPart_001_023D_01D90655.05739CF0
Content-Type: text/plain;
	name="ftrace_1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ftrace_1.txt"

Dec  2 12:33:29 10.243.0.116 [ 1715.407337] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dec  2 12:33:29 10.243.0.116 [ 1715.407376] BUG: KASAN: null-ptr-deref =
in trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:33:29 10.243.0.116 [ 1715.407448] Read of size 8 at addr =
0000000000000070 by task DummyTxSample/3577
Dec  2 12:33:29 10.243.0.116 [ 1715.407487]
Dec  2 12:33:29 10.243.0.116 [ 1715.407528] CPU: 5 PID: 3577 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:33:29 10.243.0.116 [ 1715.407573] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:33:29 10.243.0.116 [ 1715.407609] IRQ stage: EVL
Dec  2 12:33:29 10.243.0.116 [ 1715.407651] Call Trace:
Dec  2 12:33:29 10.243.0.116 [ 1715.407703]  <TASK>
Dec  2 12:33:29 10.243.0.116 [ 1715.407822]  dump_stack_lvl+0x90/0xd8
Dec  2 12:33:29 10.243.0.116 [ 1715.407895]  ? =
trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:33:29 10.243.0.116 [ 1715.407929]  ? =
trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:33:29 10.243.0.116 [ 1715.407998]  =
kasan_report.cold.16+0x64/0xdb
Dec  2 12:33:29 10.243.0.116 [ 1715.408318]  ? =
trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:33:29 10.243.0.116 [ 1715.408844]  __asan_load8+0x6d/0xa0
Dec  2 12:33:29 10.243.0.116 [ 1715.408916]  =
trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:33:29 10.243.0.116 [ 1715.409364]  ? =
trace_event_raw_event_evl_init_thread+0x330/0x330
Dec  2 12:33:29 10.243.0.116 [ 1715.409766]  ? 0xffffffffc0b38099
Dec  2 12:33:29 10.243.0.116 [ 1715.409859]  ? evl_delay+0x48/0xf0
Dec  2 12:33:29 10.243.0.116 [ 1715.409892]  ? =
evl_sleep_on_locked+0x730/0x730
Dec  2 12:33:29 10.243.0.116 [ 1715.410065]  ? =
__kasan_check_write+0x14/0x20
Dec  2 12:33:29 10.243.0.116 [ 1715.410616]  =
evl_sleep_on_locked+0x629/0x730
Dec  2 12:33:29 10.243.0.116 [ 1715.410772]  ? =
evl_sleep_on_locked+0x5/0x730
Dec  2 12:33:29 10.243.0.116 [ 1715.411255]  evl_sleep_on+0x7b/0xb0
Dec  2 12:33:29 10.243.0.116 [ 1715.411887]  evl_delay+0x48/0xf0
Dec  2 12:33:29 10.243.0.116 [ 1715.412140]  clock_oob_ioctl+0x182/0x2d0
Dec  2 12:33:29 10.243.0.116 [ 1715.412534]  ? =
clock_common_ioctl+0x5e0/0x5e0
Dec  2 12:33:30 10.243.0.116 [ 1715.412868]  ? clock_oob_ioctl+0x5/0x2d0
Dec  2 12:33:30 10.243.0.116 [ 1715.413406]  EVL_ioctl+0x86/0x100
Dec  2 12:33:30 10.243.0.116 [ 1715.413919]  do_oob_syscall+0x5b1/0x6d0
Dec  2 12:33:30 10.243.0.116 [ 1715.414133]  ? =
prepare_for_signal+0x180/0x180
Dec  2 12:33:30 10.243.0.116 [ 1715.414517]  ? do_oob_syscall+0x5/0x6d0
Dec  2 12:33:30 10.243.0.116 [ 1715.414665]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:33:30 10.243.0.116 [ 1715.415066]  =
handle_oob_syscall+0x18e/0x230
Dec  2 12:33:30 10.243.0.116 [ 1715.415464]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:33:30 10.243.0.116 [ 1715.415976]  ? =
handle_oob_syscall+0x5/0x230
Dec  2 12:33:30 10.243.0.116 [ 1715.416646]  pipeline_syscall+0xac/0x1c0
Dec  2 12:33:30 10.243.0.116 [ 1715.417051]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 12:33:30 10.243.0.116 [ 1715.417358]  do_syscall_64+0x1d/0xa0
Dec  2 12:33:30 10.243.0.116 [ 1715.417595]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:33:30 10.243.0.116 [ 1715.417673] RIP: 0033:0x7f302d4b1b9b
Dec  2 12:33:30 10.243.0.116 [ 1715.417784] Code: Unable to access =
opcode bytes at RIP 0x7f302d4b1b71.
Dec  2 12:33:30 10.243.0.116 [ 1715.417819] RSP: 002b:00007f3013fef5a0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 12:33:30 10.243.0.116 [ 1715.417859] RAX: ffffffffffffffda RBX: =
00007f3013fef630 RCX: 00007f302d4b1b9b
Dec  2 12:33:30 10.243.0.116 [ 1715.417877] RDX: 0000000040106300 RSI: =
0000000000000004 RDI: 0000000010000002
Dec  2 12:33:30 10.243.0.116 [ 1715.417895] RBP: 0000000040106300 R08: =
0000000000000000 R09: 00007ffd9df03080
Dec  2 12:33:30 10.243.0.116 [ 1715.417912] R10: 00007f3013fef630 R11: =
0000000000000246 R12: 0000000000000004
Dec  2 12:33:30 10.243.0.116 [ 1715.417929] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f3013fff700
Dec  2 12:33:30 10.243.0.116 [ 1715.419069]  </TASK>
Dec  2 12:33:30 10.243.0.116 [ 1715.419089] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dec  2 12:33:30 10.243.0.116 [ 1715.419105] Disabling lock debugging due =
to kernel taint
Dec  2 12:33:30 10.243.0.116 [ 1715.419141] EVL: DummyTxSample switching =
in-band [pid=3D3577, excpt=3D14, =
trace_event_raw_event_evl_sleep_on+0xc3/0x380]
Dec  2 12:33:50 10.243.0.116 [ 1736.447142] watchdog: BUG: soft lockup - =
CPU#0 stuck for 23s! [TxStartup:3574]
Dec  2 12:33:50 10.243.0.116 [ 1736.479659] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:33:50 10.243.0.116 [ 1736.493080]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:33:50 10.243.0.116 [ 1736.803990] irq event stamp: 24564
Dec  2 12:33:50 10.243.0.116 [ 1736.840292] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:33:50 10.243.0.116 [ 1736.878499] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:33:50 10.243.0.116 [ 1736.916737] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:33:50 10.243.0.116 [ 1736.955360] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:33:50 10.243.0.116 [ 1736.993539] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W         5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:33:50 10.243.0.116 [ 1737.047281] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:33:50 10.243.0.116 [ 1737.086618] IRQ stage: Linux
Dec  2 12:33:50 10.243.0.116 [ 1737.124857] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:33:51 10.243.0.116 [ 1737.163868] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:33:51 10.243.0.116 [ 1737.247966] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.291844] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.335764] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.379722] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.423854] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.468065] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.512227] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.557029] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:33:51 10.243.0.116 [ 1737.601610] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:33:51 10.243.0.116 [ 1737.647012] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:33:51 10.243.0.116 [ 1737.693142] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:33:51 10.243.0.116 [ 1737.739454] Call Trace:
Dec  2 12:33:51 10.243.0.116 [ 1737.784755]  <IRQ>
Dec  2 12:33:51 10.243.0.116 [ 1737.830140]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:33:51 10.243.0.116 [ 1737.876648]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:33:51 10.243.0.116 [ 1737.922863]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:33:51 10.243.0.116 [ 1737.968896]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:33:51 10.243.0.116 [ 1738.014332]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:33:51 10.243.0.116 [ 1738.059846]  ? do_irq_inband+0x2f/0x40
Dec  2 12:33:51 10.243.0.116 [ 1738.104678]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:33:51 10.243.0.116 [ 1738.149293]  </IRQ>
Dec  2 12:33:52 10.243.0.116 [ 1738.192714]  <TASK>
Dec  2 12:33:52 10.243.0.116 [ 1738.236021]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:33:52 10.243.0.116 [ 1738.280446]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:33:52 10.243.0.116 [ 1738.323930]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:33:52 10.243.0.116 [ 1738.367375]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:33:52 10.243.0.116 [ 1738.410732]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:33:52 10.243.0.116 [ 1738.453483]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:33:52 10.243.0.116 [ 1738.495505]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:33:52 10.243.0.116 [ 1738.538163]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:33:52 10.243.0.116 [ 1738.579862]  ? __asan_store2+0xa0/0xa0
Dec  2 12:33:52 10.243.0.116 [ 1738.620658]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:33:52 10.243.0.116 [ 1738.661383]  ? leave_mm+0x40/0x40
Dec  2 12:33:52 10.243.0.116 [ 1738.757429]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:33:52 10.243.0.116 [ 1738.797065]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:33:52 10.243.0.116 [ 1738.836149]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:33:52 10.243.0.116 [ 1738.874960]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:33:52 10.243.0.116 [ 1738.913432]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:33:52 10.243.0.116 [ 1738.953489]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:33:52 10.243.0.116 [ 1738.991085]  ? 0xffffffffc0b38099
Dec  2 12:33:52 10.243.0.116 [ 1739.028345]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:33:52 10.243.0.116 [ 1739.065872]  ? =
change_protection+0x50/0x90
Dec  2 12:33:52 10.243.0.116 [ 1739.102540]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:33:52 10.243.0.116 [ 1739.139304]  ? =
change_protection+0x90/0x90
Dec  2 12:33:52 10.243.0.116 [ 1739.175299]  ? mprotect_fixup+0x5/0x490
Dec  2 12:33:53 10.243.0.116 [ 1739.211544]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:33:53 10.243.0.116 [ 1739.246174]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:33:53 10.243.0.116 [ 1739.278329]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:33:53 10.243.0.116 [ 1739.310804]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:33:53 10.243.0.116 [ 1739.342598]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:33:53 10.243.0.116 [ 1739.374063]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:33:53 10.243.0.116 [ 1739.407243]  </TASK>
Dec  2 12:34:18 10.243.0.116 [ 1764.447279] watchdog: BUG: soft lockup - =
CPU#0 stuck for 49s! [TxStartup:3574]
Dec  2 12:34:18 10.243.0.116 [ 1764.479915] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:34:18 10.243.0.116 [ 1764.493334]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:34:18 10.243.0.116 [ 1764.789622] irq event stamp: 24564
Dec  2 12:34:18 10.243.0.116 [ 1764.823694] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:34:18 10.243.0.116 [ 1764.859866] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:34:18 10.243.0.116 [ 1764.896015] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:34:18 10.243.0.116 [ 1764.932341] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:34:18 10.243.0.116 [ 1764.968289] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:34:18 10.243.0.116 [ 1765.005626] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:34:18 10.243.0.116 [ 1765.042956] IRQ stage: Linux
Dec  2 12:34:18 10.243.0.116 [ 1765.079153] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:34:18 10.243.0.116 [ 1765.116160] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:34:19 10.243.0.116 [ 1765.196086] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.237762] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.279483] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.321180] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.362899] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.404731] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.446628] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.489146] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:34:19 10.243.0.116 [ 1765.531366] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:34:19 10.243.0.116 [ 1765.574265] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:34:19 10.243.0.116 [ 1765.617819] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:34:19 10.243.0.116 [ 1765.661535] Call Trace:
Dec  2 12:34:19 10.243.0.116 [ 1765.704246]  <IRQ>
Dec  2 12:34:19 10.243.0.116 [ 1765.747003]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:34:19 10.243.0.116 [ 1765.790969]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:34:19 10.243.0.116 [ 1765.834540]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:34:19 10.243.0.116 [ 1765.878267]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:34:19 10.243.0.116 [ 1765.921371]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:34:19 10.243.0.116 [ 1765.964775]  ? do_irq_inband+0x2f/0x40
Dec  2 12:34:19 10.243.0.116 [ 1766.007748]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:34:19 10.243.0.116 [ 1766.050937]  </IRQ>
Dec  2 12:34:19 10.243.0.116 [ 1766.093286]  <TASK>
Dec  2 12:34:19 10.243.0.116 [ 1766.135921]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:34:19 10.243.0.116 [ 1766.179998]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:34:20 10.243.0.116 [ 1766.223200]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:34:20 10.243.0.116 [ 1766.266455]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:34:20 10.243.0.116 [ 1766.310033]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:34:20 10.243.0.116 [ 1766.352702]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:34:20 10.243.0.116 [ 1766.394696]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:34:20 10.243.0.116 [ 1766.437281]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:34:20 10.243.0.116 [ 1766.478887]  ? =
smp_call_function_many_cond+0x1bd/0x4e0
Dec  2 12:34:20 10.243.0.116 [ 1766.519883]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:34:20 10.243.0.116 [ 1766.560322]  ? leave_mm+0x40/0x40
Dec  2 12:34:20 10.243.0.116 [ 1766.599782]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:34:20 10.243.0.116 [ 1766.639112]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:34:20 10.243.0.116 [ 1766.781244]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:34:20 10.243.0.116 [ 1766.819877]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:34:20 10.243.0.116 [ 1766.858215]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:34:20 10.243.0.116 [ 1766.898133]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:34:20 10.243.0.116 [ 1766.935650]  ? 0xffffffffc0b38099
Dec  2 12:34:20 10.243.0.116 [ 1766.972844]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:34:20 10.243.0.116 [ 1767.010173]  ? =
change_protection+0x50/0x90
Dec  2 12:34:20 10.243.0.116 [ 1767.046647]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:34:20 10.243.0.116 [ 1767.083266]  ? =
change_protection+0x90/0x90
Dec  2 12:34:20 10.243.0.116 [ 1767.119046]  ? mprotect_fixup+0x5/0x490
Dec  2 12:34:20 10.243.0.116 [ 1767.155109]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:34:20 10.243.0.116 [ 1767.189546]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:34:21 10.243.0.116 [ 1767.221516]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:34:21 10.243.0.116 [ 1767.253852]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:34:21 10.243.0.116 [ 1767.285437]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:34:21 10.243.0.116 [ 1767.316755]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:34:21 10.243.0.116 [ 1767.349783]  </TASK>
Dec  2 12:34:34 10.243.0.116 [ 1780.530672] rcu: INFO: rcu_sched =
detected stalls on CPUs/tasks:
Dec  2 12:34:34 10.243.0.116 [ 1780.554365] rcu: #0115-...!: (1 GPs =
behind) idle=3D78b/1/0x4000000000000002 softirq=3D161154/161154 =
fqs=3D1120
Dec  2 12:34:34 10.243.0.116 [ 1780.577036] #011(detected by 2, =
t=3D65048 jiffies, g=3D126833, q=3D6205)
Dec  2 12:34:34 10.243.0.116 [ 1780.599018] Sending NMI from CPU 2 to =
CPUs 5:
Dec  2 12:34:34 10.243.0.116 [ 1780.620633] NMI backtrace for cpu 5
Dec  2 12:34:34 10.243.0.116 [ 1780.620676] CPU: 5 PID: 3577 Comm: =
DummyTxSample Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:34:34 10.243.0.116 [ 1780.620719] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:34:34 10.243.0.116 [ 1780.620754] IRQ stage: EVL
Dec  2 12:34:34 10.243.0.116 [ 1780.620798] RIP: =
0010:native_queued_spin_lock_slowpath+0x18c/0x4c0
Dec  2 12:34:34 10.243.0.116 [ 1780.620874] Code: 48 89 df e8 d6 4c 37 =
00 8b 03 30 e4 44 09 e8 41 89 46 c0 a9 00 01 ff ff 0f 85 0d 03 00 00 85 =
c0 74 16 8b 03 84 c0 74 10 f3 90 <48> 89 df e8 ac 4c 37 00 8b 03 84 c0 =
75 f0 48 89 df e8 fe 4b 37 00
Dec  2 12:34:34 10.243.0.116 [ 1780.620914] RSP: 0018:ffff888137737538 =
EFLAGS: 00000002
Dec  2 12:34:34 10.243.0.116 [ 1780.620982] RAX: 00000000001c0101 RBX: =
ffff888101aae000 RCX: ffffffff8d1abe74
Dec  2 12:34:34 10.243.0.116 [ 1780.621021] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101aae000
Dec  2 12:34:34 10.243.0.116 [ 1780.621054] RBP: ffff888137737618 R08: =
ffffed1020355c01 R09: ffffed1020355c01
Dec  2 12:34:34 10.243.0.116 [ 1780.621071] R10: ffff888101aae003 R11: =
ffffed1020355c00 R12: 1ffff11026ee6eaa
Dec  2 12:34:34 10.243.0.116 [ 1780.621089] R13: 0000000000000000 R14: =
ffff8881377375f0 R15: 0000000000000001
Dec  2 12:34:34 10.243.0.116 [ 1780.621117] FS:  00007f3013fff700(0000) =
GS:ffff88841e480000(0000) knlGS:0000000000000000
Dec  2 12:34:34 10.243.0.116 [ 1780.621135] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:34:34 10.243.0.116 [ 1780.621153] CR2: 0000000000000070 CR3: =
0000000137d08002 CR4: 00000000003706e0
Dec  2 12:34:34 10.243.0.116 [ 1780.621170] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:34:34 10.243.0.116 [ 1780.621186] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:34:34 10.243.0.116 [ 1780.621204] Call Trace:
Dec  2 12:34:34 10.243.0.116 [ 1780.621223]  <TASK>
Dec  2 12:34:34 10.243.0.116 [ 1780.621281]  ? 0xffffffffc0b38099
Dec  2 12:34:34 10.243.0.116 [ 1780.621336]  ? =
trace_function+0x11e/0x180
Dec  2 12:34:34 10.243.0.116 [ 1780.621457]  ? .slowpath+0x1d/0x1d
Dec  2 12:34:35 10.243.0.116 [ 1780.622062]  ? =
do_raw_spin_lock+0xe6/0x1e0
Dec  2 12:34:35 10.243.0.116 [ 1780.622247]  ? =
native_queued_spin_lock_slowpath+0x5/0x4c0
Dec  2 12:34:35 10.243.0.116 [ 1780.622318]  ? 0xffffffffc0b38099
Dec  2 12:34:35 10.243.0.116 [ 1780.622922]  =
do_raw_spin_lock+0x1cb/0x1e0
Dec  2 12:34:35 10.243.0.116 [ 1780.623097]  ? spin_dump+0x90/0x90
Dec  2 12:34:35 10.243.0.116 [ 1780.623265]  ? =
do_raw_spin_lock+0x5/0x1e0
Dec  2 12:34:35 10.243.0.116 [ 1780.623903]  =
evl_switch_inband+0xad/0x7c0
Dec  2 12:34:35 10.243.0.116 [ 1780.624326]  =
handle_oob_trap_entry+0x10a/0x200
Dec  2 12:34:35 10.243.0.116 [ 1780.624743]  __oob_trap_notify+0x3f/0x50
Dec  2 12:34:35 10.243.0.116 [ 1780.625084]  page_fault_oops+0x1e4/0x3d0
Dec  2 12:34:35 10.243.0.116 [ 1780.625155]  ? =
trace_function+0x11e/0x180
Dec  2 12:34:35 10.243.0.116 [ 1780.625220]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:34:35 10.243.0.116 [ 1780.625355]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:34:35 10.243.0.116 [ 1780.625497]  ? =
function_trace_call+0x153/0x1d0
Dec  2 12:34:35 10.243.0.116 [ 1780.625567]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:34:35 10.243.0.116 [ 1780.625638]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:34:35 10.243.0.116 [ 1780.626108]  ? 0xffffffffc0b38099
Dec  2 12:34:35 10.243.0.116 [ 1780.626365]  ? =
do_user_addr_fault+0xa30/0xa30
Dec  2 12:34:35 10.243.0.116 [ 1780.626673]  ? =
do_user_addr_fault+0x686/0xa30
Dec  2 12:34:35 10.243.0.116 [ 1780.627051]  ? page_fault_oops+0x5/0x3d0
Dec  2 12:34:35 10.243.0.116 [ 1780.627119]  ? exc_page_fault+0x5c/0xe0
Dec  2 12:34:35 10.243.0.116 [ 1780.627419]  =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:34:35 10.243.0.116 [ 1780.627493]  ? =
rcu_read_lock_held_common+0x5/0x70
Dec  2 12:34:35 10.243.0.116 [ 1780.627641]  ? =
rcu_read_lock_held_common+0x2a/0x70
Dec  2 12:34:35 10.243.0.116 [ 1780.628139]  ? =
trace_page_fault_user+0x130/0x130
Dec  2 12:34:35 10.243.0.116 [ 1780.628307]  ? =
fault_in_kernel_space+0x5/0x40
Dec  2 12:34:35 10.243.0.116 [ 1780.628999]  exc_page_fault+0x71/0xe0
Dec  2 12:34:35 10.243.0.116 [ 1780.629231]  =
asm_exc_page_fault+0x27/0x30
Dec  2 12:34:35 10.243.0.116 [ 1780.629268] RIP: =
0010:trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:34:35 10.243.0.116 [ 1780.629303] Code: 80 0f 85 93 02 00 00 =
41 f6 c7 40 0f 85 10 02 00 00 41 f7 c7 00 02 00 00 0f 85 8f 02 00 00 4d =
8d 7d 70 4c 89 ff e8 6d e9 1e 00 <49> 8b 7d 70 48 85 ff 0f 84 2d 02 00 =
00 e8 ab b4 58 00 8d 50 01 83
Dec  2 12:34:35 10.243.0.116 [ 1780.629322] RSP: 0018:ffff888137737aa0 =
EFLAGS: 00010082
Dec  2 12:34:35 10.243.0.116 [ 1780.629352] RAX: 0000000000000001 RBX: =
1ffff11026ee6f5a RCX: ffffffff8d1acefc
Dec  2 12:34:35 10.243.0.116 [ 1780.629369] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffffffff8f2acb40
Dec  2 12:34:35 10.243.0.116 [ 1780.629386] RBP: ffff888137737b78 R08: =
fffffbfff1e55969 R09: fffffbfff1e55969
Dec  2 12:34:35 10.243.0.116 [ 1780.629404] R10: ffffffff8f2acb43 R11: =
fffffbfff1e55968 R12: ffff888100195000
Dec  2 12:34:35 10.243.0.116 [ 1780.629421] R13: 0000000000000000 R14: =
ffffffff8f219d40 R15: 0000000000000070
Dec  2 12:34:35 10.243.0.116 [ 1780.630165]  ? =
do_raw_spin_unlock+0x9c/0x140
Dec  2 12:34:35 10.243.0.116 [ 1780.631094]  ? =
trace_event_raw_event_evl_init_thread+0x330/0x330
Dec  2 12:34:36 10.243.0.116 [ 1780.631268]  ? 0xffffffffc0b38099
Dec  2 12:34:36 10.243.0.116 [ 1780.631322]  ? evl_delay+0x48/0xf0
Dec  2 12:34:36 10.243.0.116 [ 1780.631354]  ? =
evl_sleep_on_locked+0x730/0x730
Dec  2 12:34:36 10.243.0.116 [ 1780.631645]  ? =
__kasan_check_write+0x14/0x20
Dec  2 12:34:36 10.243.0.116 [ 1780.632141]  =
evl_sleep_on_locked+0x629/0x730
Dec  2 12:34:36 10.243.0.116 [ 1780.632210]  ? =
evl_sleep_on_locked+0x5/0x730
Dec  2 12:34:36 10.243.0.116 [ 1780.632776]  evl_sleep_on+0x7b/0xb0
Dec  2 12:34:36 10.243.0.116 [ 1780.633233]  evl_delay+0x48/0xf0
Dec  2 12:34:36 10.243.0.116 [ 1780.633528]  clock_oob_ioctl+0x182/0x2d0
Dec  2 12:34:36 10.243.0.116 [ 1780.633912]  ? =
clock_common_ioctl+0x5e0/0x5e0
Dec  2 12:34:36 10.243.0.116 [ 1780.634157]  ? clock_oob_ioctl+0x5/0x2d0
Dec  2 12:34:36 10.243.0.116 [ 1780.634659]  EVL_ioctl+0x86/0x100
Dec  2 12:34:36 10.243.0.116 [ 1780.635150]  do_oob_syscall+0x5b1/0x6d0
Dec  2 12:34:36 10.243.0.116 [ 1780.635353]  ? =
prepare_for_signal+0x180/0x180
Dec  2 12:34:36 10.243.0.116 [ 1780.635642]  ? do_oob_syscall+0x5/0x6d0
Dec  2 12:34:36 10.243.0.116 [ 1780.635789]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:34:36 10.243.0.116 [ 1780.636237]  =
handle_oob_syscall+0x18e/0x230
Dec  2 12:34:36 10.243.0.116 [ 1780.636462]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:34:36 10.243.0.116 [ 1780.637093]  ? =
handle_oob_syscall+0x5/0x230
Dec  2 12:34:36 10.243.0.116 [ 1780.637511]  pipeline_syscall+0xac/0x1c0
Dec  2 12:34:36 10.243.0.116 [ 1780.638085]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 12:34:36 10.243.0.116 [ 1780.638255]  do_syscall_64+0x1d/0xa0
Dec  2 12:34:36 10.243.0.116 [ 1780.638358]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:34:36 10.243.0.116 [ 1780.638393] RIP: 0033:0x7f302d4b1b9b
Dec  2 12:34:36 10.243.0.116 [ 1780.638466] Code: Unable to access =
opcode bytes at RIP 0x7f302d4b1b71.
Dec  2 12:34:36 10.243.0.116 [ 1780.638501] RSP: 002b:00007f3013fef5a0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 12:34:36 10.243.0.116 [ 1780.638574] RAX: ffffffffffffffda RBX: =
00007f3013fef630 RCX: 00007f302d4b1b9b
Dec  2 12:34:36 10.243.0.116 [ 1780.638612] RDX: 0000000040106300 RSI: =
0000000000000004 RDI: 0000000010000002
Dec  2 12:34:36 10.243.0.116 [ 1780.638649] RBP: 0000000040106300 R08: =
0000000000000000 R09: 00007ffd9df03080
Dec  2 12:34:36 10.243.0.116 [ 1780.638687] R10: 00007f3013fef630 R11: =
0000000000000246 R12: 0000000000000004
Dec  2 12:34:36 10.243.0.116 [ 1780.638724] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f3013fff700
Dec  2 12:34:36 10.243.0.116 [ 1780.639897]  </TASK>
Dec  2 12:34:36 10.243.0.116 [ 1780.639940] INFO: NMI handler =
(nmi_cpu_backtrace_handler) took too long to run: 19.307 msecs
Dec  2 12:34:36 10.243.0.116 [ 1780.640671] rcu: rcu_sched kthread timer =
wakeup didn't happen for 55940 jiffies! g126833 f0x0 RCU_GP_WAIT_FQS(5) =
->state=3D0x402
Dec  2 12:34:36 10.243.0.116 [ 1782.865200] rcu: #011Possible timer =
handling issue on cpu=3D6 timer-softirq=3D22974
Dec  2 12:34:36 10.243.0.116 [ 1782.886720] rcu: rcu_sched kthread =
starved for 58189 jiffies! g126833 f0x0 RCU_GP_WAIT_FQS(5) =
->state=3D0x402 ->cpu=3D6
Dec  2 12:34:36 10.243.0.116 [ 1782.908748] rcu: #011Unless rcu_sched =
kthread gets sufficient CPU time, OOM is now expected behavior.
Dec  2 12:34:36 10.243.0.116 [ 1782.930280] rcu: RCU grace-period =
kthread stack dump:
Dec  2 12:34:36 10.243.0.116 [ 1782.950285] task:rcu_sched       state:I =
stack:    0 pid:   14 ppid:     2 flags:0x00004000
Dec  2 12:34:36 10.243.0.116 [ 1782.971170] Call Trace:
Dec  2 12:34:36 10.243.0.116 [ 1782.991024]  <TASK>
Dec  2 12:34:36 10.243.0.116 [ 1783.010534]  __schedule+0x6e4/0x1160
Dec  2 12:34:36 10.243.0.116 [ 1783.030474]  ? =
__sched_text_start+0x8/0x8
Dec  2 12:34:36 10.243.0.116 [ 1783.050180]  ? =
__inband_irq_enable+0x4f/0x80
Dec  2 12:34:36 10.243.0.116 [ 1783.070137]  schedule+0xd8/0x190
Dec  2 12:34:36 10.243.0.116 [ 1783.089281]  =
schedule_timeout+0x2fc/0x530
Dec  2 12:34:36 10.243.0.116 [ 1783.108541]  ? =
function_trace_call+0x153/0x1d0
Dec  2 12:34:36 10.243.0.116 [ 1783.127571]  ? =
usleep_range_state+0xf0/0xf0
Dec  2 12:34:36 10.243.0.116 [ 1783.146902]  ? 0xffffffffc0b38099
Dec  2 12:34:36 10.243.0.116 [ 1783.166626]  ? =
__kasan_check_read+0x11/0x20
Dec  2 12:34:36 10.243.0.116 [ 1783.186425]  ? =
__bpf_trace_tick_stop+0x20/0x20
Dec  2 12:34:36 10.243.0.116 [ 1783.206166]  ? =
schedule_timeout+0x5/0x530
Dec  2 12:34:37 10.243.0.116 [ 1783.225381]  ? =
prepare_to_swait_event+0x72/0x180
Dec  2 12:34:37 10.243.0.116 [ 1783.245285]  rcu_gp_fqs_loop+0x150/0x510
Dec  2 12:34:37 10.243.0.116 [ 1783.264887]  ? force_qs_rnp+0x390/0x390
Dec  2 12:34:37 10.243.0.116 [ 1783.284392]  ? rcu_gp_fqs_loop+0x5/0x510
Dec  2 12:34:37 10.243.0.116 [ 1783.304072]  ? rcu_gp_init+0x49d/0x890
Dec  2 12:34:37 10.243.0.116 [ 1783.323572]  rcu_gp_kthread+0x15c/0x240
Dec  2 12:34:37 10.243.0.116 [ 1783.343293]  ? =
rcu_gp_fqs_loop+0x510/0x510
Dec  2 12:34:37 10.243.0.116 [ 1783.362926]  ? =
__kasan_check_read+0x11/0x20
Dec  2 12:34:37 10.243.0.116 [ 1783.382419]  ? =
__kthread_parkme+0x9d/0xc0
Dec  2 12:34:37 10.243.0.116 [ 1783.401964]  ? =
rcu_gp_fqs_loop+0x510/0x510
Dec  2 12:34:37 10.243.0.116 [ 1783.421204]  kthread+0x1f3/0x220
Dec  2 12:34:37 10.243.0.116 [ 1783.440649]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:34:37 10.243.0.116 [ 1783.459969]  ret_from_fork+0x22/0x30
Dec  2 12:34:37 10.243.0.116 [ 1783.480016]  </TASK>
Dec  2 12:34:37 10.243.0.116 [ 1783.498908] rcu: Stack dump where RCU GP =
kthread last ran:
Dec  2 12:34:37 10.243.0.116 [ 1783.518605] Sending NMI from CPU 2 to =
CPUs 6:
Dec  2 12:34:37 10.243.0.116 [ 1783.538329] NMI backtrace for cpu 6
Dec  2 12:34:37 10.243.0.116 [ 1783.538375] CPU: 6 PID: 3580 Comm: =
evl-ps Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:34:37 10.243.0.116 [ 1783.538418] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:34:37 10.243.0.116 [ 1783.538454] IRQ stage: Linux
Dec  2 12:34:37 10.243.0.116 [ 1783.538500] RIP: =
0010:__asan_load4+0x21/0x90
Dec  2 12:34:37 10.243.0.116 [ 1783.538570] Code: 2e 0f 1f 84 00 00 00 =
00 00 55 48 89 e5 48 8b 4d 08 48 83 ff fb 77 53 48 b8 ff ff ff ff ff 7f =
ff ff 48 39 c7 76 44 48 8d 47 03 <48> 89 c2 83 e2 07 48 83 fa 02 76 1c =
48 be 00 00 00 00 00 fc ff df
Dec  2 12:34:37 10.243.0.116 [ 1783.538611] RSP: 0018:ffff888137877890 =
EFLAGS: 00000012
Dec  2 12:34:37 10.243.0.116 [ 1783.538679] RAX: ffff888101aae003 RBX: =
ffff888101aae000 RCX: ffffffff8d1ac05d
Dec  2 12:34:37 10.243.0.116 [ 1783.538718] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101aae000
Dec  2 12:34:37 10.243.0.116 [ 1783.538756] RBP: ffff888137877890 R08: =
ffffed1020355c01 R09: ffffed1020355c01
Dec  2 12:34:37 10.243.0.116 [ 1783.538795] R10: ffff888101aae003 R11: =
ffffed1020355c00 R12: 1ffff11026f0ef17
Dec  2 12:34:37 10.243.0.116 [ 1783.538836] R13: ffff88841e56bb00 R14: =
ffff888137877958 R15: 0000000000000000
Dec  2 12:34:37 10.243.0.116 [ 1783.538898] FS:  00007fb41f68c740(0000) =
GS:ffff88841e500000(0000) knlGS:0000000000000000
Dec  2 12:34:37 10.243.0.116 [ 1783.538938] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:34:37 10.243.0.116 [ 1783.538976] CR2: 00007fb41f126c50 CR3: =
0000000104d8e002 CR4: 00000000003706e0
Dec  2 12:34:37 10.243.0.116 [ 1783.539014] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:34:37 10.243.0.116 [ 1783.539051] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:34:37 10.243.0.116 [ 1783.539090] Call Trace:
Dec  2 12:34:37 10.243.0.116 [ 1783.539134]  <TASK>
Dec  2 12:34:37 10.243.0.116 [ 1783.539253]  =
native_queued_spin_lock_slowpath+0x37d/0x4c0
Dec  2 12:34:37 10.243.0.116 [ 1783.539719]  ? .slowpath+0x1d/0x1d
Dec  2 12:34:37 10.243.0.116 [ 1783.540330]  ? =
do_raw_spin_lock+0xe6/0x1e0
Dec  2 12:34:37 10.243.0.116 [ 1783.540709]  ? =
native_queued_spin_lock_slowpath+0x5/0x4c0
Dec  2 12:34:37 10.243.0.116 [ 1783.540868]  ? 0xffffffffc0b38099
Dec  2 12:34:37 10.243.0.116 [ 1783.541608]  =
do_raw_spin_lock+0x1cb/0x1e0
Dec  2 12:34:38 10.243.0.116 [ 1783.541841]  ? spin_dump+0x90/0x90
Dec  2 12:34:38 10.243.0.116 [ 1783.542220]  ? =
do_raw_spin_lock+0x5/0x1e0
Dec  2 12:34:38 10.243.0.116 [ 1783.543063]  sched_show+0x12d/0x300
Dec  2 12:34:38 10.243.0.116 [ 1783.543225]  ? 0xffffffffc0b38099
Dec  2 12:34:38 10.243.0.116 [ 1783.543733]  ? =
inband_task_wakeup+0x160/0x160
Dec  2 12:34:38 10.243.0.116 [ 1783.544113]  ? sched_show+0x5/0x300
Dec  2 12:34:38 10.243.0.116 [ 1783.544953]  dev_attr_show+0x3c/0x70
Dec  2 12:34:38 10.243.0.116 [ 1783.545417]  =
sysfs_kf_seq_show+0x161/0x1f0
Dec  2 12:34:38 10.243.0.116 [ 1783.545574]  ? =
device_remove_bin_file+0x20/0x20
Dec  2 12:34:38 10.243.0.116 [ 1783.546339]  kernfs_seq_show+0xa4/0xc0
Dec  2 12:34:38 10.243.0.116 [ 1783.546878]  seq_read_iter+0x289/0x740
Dec  2 12:34:38 10.243.0.116 [ 1783.548419]  =
kernfs_fop_read_iter+0x25a/0x2c0
Dec  2 12:34:38 10.243.0.116 [ 1783.548496]  ? =
kernfs_fop_read_iter+0x5/0x2c0
Dec  2 12:34:38 10.243.0.116 [ 1783.548799]  ? iov_iter_init+0x7d/0xa0
Dec  2 12:34:38 10.243.0.116 [ 1783.549332]  new_sync_read+0x2ab/0x3e0
Dec  2 12:34:38 10.243.0.116 [ 1783.549872]  ? =
__x64_sys_llseek+0x240/0x240
Dec  2 12:34:38 10.243.0.116 [ 1783.550176]  ? vfs_read+0x170/0x270
Dec  2 12:34:38 10.243.0.116 [ 1783.550247]  ? =
__x64_sys_llseek+0x240/0x240
Dec  2 12:34:38 10.243.0.116 [ 1783.551011]  ? =
selinux_file_permission+0x1cc/0x200
Dec  2 12:34:38 10.243.0.116 [ 1783.552085]  ? new_sync_read+0x5/0x3e0
Dec  2 12:34:38 10.243.0.116 [ 1783.552926]  vfs_read+0x170/0x270
Dec  2 12:34:38 10.243.0.116 [ 1783.553696]  ksys_read+0xcc/0x170
Dec  2 12:34:38 10.243.0.116 [ 1783.554006]  ? vfs_write+0x4b0/0x4b0
Dec  2 12:34:38 10.243.0.116 [ 1783.554384]  ? ksys_read+0x5/0x170
Dec  2 12:34:38 10.243.0.116 [ 1783.555226]  __x64_sys_read+0x43/0x50
Dec  2 12:34:38 10.243.0.116 [ 1783.555612]  do_syscall_64+0x4c/0xa0
Dec  2 12:34:38 10.243.0.116 [ 1783.555845]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:34:38 10.243.0.116 [ 1783.555924] RIP: 0033:0x7fb41f1a79a0
Dec  2 12:34:38 10.243.0.116 [ 1783.556043] Code: 0b 31 c0 48 83 c4 08 =
e9 be fe ff ff 48 8d 3d d7 c3 09 00 e8 42 8c 02 00 66 90 83 3d 1d d6 2d =
00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec =
08 e8 de cc 01 00 48 89 04 24
Dec  2 12:34:38 10.243.0.116 [ 1783.556083] RSP: 002b:00007ffc99d03948 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Dec  2 12:34:38 10.243.0.116 [ 1783.556156] RAX: ffffffffffffffda RBX: =
0000000000b131f0 RCX: 00007fb41f1a79a0
Dec  2 12:34:38 10.243.0.116 [ 1783.556195] RDX: 0000000000001000 RSI: =
00007fb41f6a5000 RDI: 0000000000000005
Dec  2 12:34:38 10.243.0.116 [ 1783.556232] RBP: 00007fb41f47c380 R08: =
ffffffffffffffff R09: 0000000000000000
Dec  2 12:34:38 10.243.0.116 [ 1783.556270] R10: 0000000000000022 R11: =
0000000000000246 R12: 00007fb41f47b838
Dec  2 12:34:38 10.243.0.116 [ 1783.556307] R13: 00007fb41f47b838 R14: =
0000000000000d70 R15: 00007fb41f47c5a8
Dec  2 12:34:38 10.243.0.116 [ 1783.557962]  </TASK>
Dec  2 12:34:38 10.243.0.116 [ 1783.558036] INFO: NMI handler =
(nmi_cpu_backtrace_handler) took too long to run: 19.682 msecs
Dec  2 12:34:46 10.243.0.116 [ 1792.447406] watchdog: BUG: soft lockup - =
CPU#0 stuck for 75s! [TxStartup:3574]
Dec  2 12:34:46 10.243.0.116 [ 1792.483614] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:34:46 10.243.0.116 [ 1792.497034]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:34:46 10.243.0.116 [ 1792.840127] irq event stamp: 24564
Dec  2 12:34:46 10.243.0.116 [ 1792.879961] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:34:46 10.243.0.116 [ 1792.921994] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:34:46 10.243.0.116 [ 1792.964153] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:34:46 10.243.0.116 [ 1793.006557] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:34:46 10.243.0.116 [ 1793.048711] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:34:46 10.243.0.116 [ 1793.092310] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:34:46 10.243.0.116 [ 1793.135761] IRQ stage: Linux
Dec  2 12:34:46 10.243.0.116 [ 1793.177935] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:34:47 10.243.0.116 [ 1793.220998] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:34:47 10.243.0.116 [ 1793.312708] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.360453] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.408216] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.455977] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.503877] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.551923] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.600030] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.648722] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:34:47 10.243.0.116 [ 1793.697094] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:34:47 10.243.0.116 [ 1793.746376] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:34:47 10.243.0.116 [ 1793.796333] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:34:47 10.243.0.116 [ 1793.846653] Call Trace:
Dec  2 12:34:47 10.243.0.116 [ 1793.895855]  <IRQ>
Dec  2 12:34:47 10.243.0.116 [ 1793.945182]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:34:47 10.243.0.116 [ 1793.995801]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:34:47 10.243.0.116 [ 1794.046133]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:34:47 10.243.0.116 [ 1794.096597]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:34:47 10.243.0.116 [ 1794.144668]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:34:48 10.243.0.116 [ 1794.190960]  ? do_irq_inband+0x2f/0x40
Dec  2 12:34:48 10.243.0.116 [ 1794.236462]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:34:48 10.243.0.116 [ 1794.281795]  </IRQ>
Dec  2 12:34:48 10.243.0.116 [ 1794.326004]  <TASK>
Dec  2 12:34:48 10.243.0.116 [ 1794.370207]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:34:48 10.243.0.116 [ 1794.415541]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:34:48 10.243.0.116 [ 1794.459875]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:34:48 10.243.0.116 [ 1794.503881]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:34:48 10.243.0.116 [ 1794.547660]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:34:48 10.243.0.116 [ 1794.590797]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:34:48 10.243.0.116 [ 1794.633205]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:34:48 10.243.0.116 [ 1794.676183]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:34:48 10.243.0.116 [ 1794.718209]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:34:48 10.243.0.116 [ 1794.759572]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:34:48 10.243.0.116 [ 1794.800343]  ? leave_mm+0x40/0x40
Dec  2 12:34:48 10.243.0.116 [ 1794.840123]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:34:48 10.243.0.116 [ 1794.879829]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:34:48 10.243.0.116 [ 1794.918982]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:34:48 10.243.0.116 [ 1794.957878]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:34:48 10.243.0.116 [ 1794.996473]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:34:48 10.243.0.116 [ 1795.036759]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:34:48 10.243.0.116 [ 1795.074648]  ? 0xffffffffc0b38099
Dec  2 12:34:48 10.243.0.116 [ 1795.112223]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:34:48 10.243.0.116 [ 1795.149818]  ? =
change_protection+0x50/0x90
Dec  2 12:34:48 10.243.0.116 [ 1795.186491]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:34:49 10.243.0.116 [ 1795.223324]  ? =
change_protection+0x90/0x90
Dec  2 12:34:49 10.243.0.116 [ 1795.259252]  ? mprotect_fixup+0x5/0x490
Dec  2 12:34:49 10.243.0.116 [ 1795.295565]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:34:49 10.243.0.116 [ 1795.330273]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:34:49 10.243.0.116 [ 1795.362504]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:34:49 10.243.0.116 [ 1795.395056]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:34:49 10.243.0.116 [ 1795.620916]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:34:49 10.243.0.116 [ 1795.652479]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:34:49 10.243.0.116 [ 1795.685796]  </TASK>
Dec  2 12:35:14 10.243.0.116 [ 1820.447535] watchdog: BUG: soft lockup - =
CPU#0 stuck for 101s! [TxStartup:3574]
Dec  2 12:35:14 10.243.0.116 [ 1820.480297] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:35:14 10.243.0.116 [ 1820.493722]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:35:14 10.243.0.116 [ 1820.790286] irq event stamp: 24564
Dec  2 12:35:14 10.243.0.116 [ 1820.824406] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:35:14 10.243.0.116 [ 1820.860567] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:35:14 10.243.0.116 [ 1820.896758] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:35:14 10.243.0.116 [ 1820.933087] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:35:14 10.243.0.116 [ 1820.968972] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:35:14 10.243.0.116 [ 1821.006251] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:35:14 10.243.0.116 [ 1821.043519] IRQ stage: Linux
Dec  2 12:35:14 10.243.0.116 [ 1821.079616] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:35:14 10.243.0.116 [ 1821.116519] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:35:15 10.243.0.116 [ 1821.196115] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000293 ORIG_RAX: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.237742] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.279413] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.320981] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.362596] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.404505] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.446592] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.489477] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:35:15 10.243.0.116 [ 1821.532090] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:35:15 10.243.0.116 [ 1821.575248] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:35:15 10.243.0.116 [ 1821.619017] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:35:15 10.243.0.116 [ 1821.662935] Call Trace:
Dec  2 12:35:15 10.243.0.116 [ 1821.705794]  <IRQ>
Dec  2 12:35:15 10.243.0.116 [ 1821.748642]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:35:15 10.243.0.116 [ 1821.792687]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:35:15 10.243.0.116 [ 1821.836504]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:35:15 10.243.0.116 [ 1821.880488]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:35:15 10.243.0.116 [ 1821.923848]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:35:15 10.243.0.116 [ 1821.967496]  ? do_irq_inband+0x2f/0x40
Dec  2 12:35:15 10.243.0.116 [ 1822.010675]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:35:15 10.243.0.116 [ 1822.054021]  </IRQ>
Dec  2 12:35:15 10.243.0.116 [ 1822.096506]  <TASK>
Dec  2 12:35:15 10.243.0.116 [ 1822.139286]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:35:15 10.243.0.116 [ 1822.183504]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:35:16 10.243.0.116 [ 1822.226784]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:35:16 10.243.0.116 [ 1822.270115]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:35:16 10.243.0.116 [ 1822.313767]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:35:16 10.243.0.116 [ 1822.356544]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:35:16 10.243.0.116 [ 1822.398597]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:35:16 10.243.0.116 [ 1822.441321]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:35:16 10.243.0.116 [ 1822.483104]  ? =
smp_call_function_many_cond+0x1c2/0x4e0
Dec  2 12:35:16 10.243.0.116 [ 1822.524208]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:35:16 10.243.0.116 [ 1822.564763]  ? leave_mm+0x40/0x40
Dec  2 12:35:16 10.243.0.116 [ 1822.604524]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:35:16 10.243.0.116 [ 1822.644094]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:35:16 10.243.0.116 [ 1822.683101]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:35:16 10.243.0.116 [ 1822.721837]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:35:16 10.243.0.116 [ 1822.760224]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:35:16 10.243.0.116 [ 1822.800334]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:35:16 10.243.0.116 [ 1822.837959]  ? 0xffffffffc0b38099
Dec  2 12:35:16 10.243.0.116 [ 1822.875197]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:35:16 10.243.0.116 [ 1822.912637]  ? =
change_protection+0x50/0x90
Dec  2 12:35:16 10.243.0.116 [ 1822.949153]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:35:16 10.243.0.116 [ 1822.985831]  ? =
change_protection+0x90/0x90
Dec  2 12:35:16 10.243.0.116 [ 1823.021595]  ? mprotect_fixup+0x5/0x490
Dec  2 12:35:16 10.243.0.116 [ 1823.057756]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:35:16 10.243.0.116 [ 1823.092300]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:35:16 10.243.0.116 [ 1823.124328]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:35:16 10.243.0.116 [ 1823.156668]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:35:16 10.243.0.116 [ 1823.188252]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:35:17 10.243.0.116 [ 1823.219567]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:35:17 10.243.0.116 [ 1823.252645]  </TASK>
Dec  2 12:35:42 10.243.0.116 [ 1848.447657] watchdog: BUG: soft lockup - =
CPU#0 stuck for 127s! [TxStartup:3574]
Dec  2 12:35:42 10.243.0.116 [ 1848.480187] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:35:42 10.243.0.116 [ 1848.493609]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:35:42 10.243.0.116 [ 1848.788312] irq event stamp: 24564
Dec  2 12:35:42 10.243.0.116 [ 1848.822354] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:35:42 10.243.0.116 [ 1848.858693] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:35:42 10.243.0.116 [ 1848.894933] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:35:42 10.243.0.116 [ 1848.931344] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:35:42 10.243.0.116 [ 1848.967316] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:35:42 10.243.0.116 [ 1849.004731] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:35:42 10.243.0.116 [ 1849.042217] IRQ stage: Linux
Dec  2 12:35:42 10.243.0.116 [ 1849.078498] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:35:42 10.243.0.116 [ 1849.115543] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:35:43 10.243.0.116 [ 1849.195313] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000293 ORIG_RAX: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.237036] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.278803] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.320405] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.362117] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.404115] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.446248] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.489006] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:35:43 10.243.0.116 [ 1849.531417] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:35:43 10.243.0.116 [ 1849.574502] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:35:43 10.243.0.116 [ 1849.618197] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:35:43 10.243.0.116 [ 1849.662044] Call Trace:
Dec  2 12:35:43 10.243.0.116 [ 1849.704888]  <IRQ>
Dec  2 12:35:43 10.243.0.116 [ 1849.747786]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:35:43 10.243.0.116 [ 1849.791927]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:35:43 10.243.0.116 [ 1849.835800]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:35:43 10.243.0.116 [ 1849.879840]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:35:43 10.243.0.116 [ 1849.923446]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:35:43 10.243.0.116 [ 1849.967256]  ? do_irq_inband+0x2f/0x40
Dec  2 12:35:43 10.243.0.116 [ 1850.010521]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:35:43 10.243.0.116 [ 1850.053959]  </IRQ>
Dec  2 12:35:43 10.243.0.116 [ 1850.096538]  <TASK>
Dec  2 12:35:43 10.243.0.116 [ 1850.139360]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:35:43 10.243.0.116 [ 1850.183625]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:35:44 10.243.0.116 [ 1850.226955]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:35:44 10.243.0.116 [ 1850.270335]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:35:44 10.243.0.116 [ 1850.314022]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:35:44 10.243.0.116 [ 1850.356788]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:35:44 10.243.0.116 [ 1850.398912]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:35:44 10.243.0.116 [ 1850.441579]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:35:44 10.243.0.116 [ 1850.483300]  ? __asan_store2+0xa0/0xa0
Dec  2 12:35:44 10.243.0.116 [ 1850.524064]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:35:44 10.243.0.116 [ 1850.564755]  ? leave_mm+0x40/0x40
Dec  2 12:35:44 10.243.0.116 [ 1850.604523]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:35:44 10.243.0.116 [ 1850.644230]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:35:44 10.243.0.116 [ 1850.683376]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:35:44 10.243.0.116 [ 1850.722254]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:35:44 10.243.0.116 [ 1850.760833]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:35:44 10.243.0.116 [ 1850.801013]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:35:44 10.243.0.116 [ 1850.838725]  ? 0xffffffffc0b38099
Dec  2 12:35:44 10.243.0.116 [ 1850.876052]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:35:44 10.243.0.116 [ 1850.913582]  ? =
change_protection+0x50/0x90
Dec  2 12:35:44 10.243.0.116 [ 1850.950280]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:35:44 10.243.0.116 [ 1850.987037]  ? =
change_protection+0x90/0x90
Dec  2 12:35:44 10.243.0.116 [ 1851.022894]  ? mprotect_fixup+0x5/0x490
Dec  2 12:35:44 10.243.0.116 [ 1851.059201]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:35:44 10.243.0.116 [ 1851.093946]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:35:44 10.243.0.116 [ 1851.126216]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:35:44 10.243.0.116 [ 1851.158752]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:35:44 10.243.0.116 [ 1851.190537]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:35:45 10.243.0.116 [ 1851.222048]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:35:45 10.243.0.116 [ 1851.255277]  </TASK>
Dec  2 12:36:10 10.243.0.116 [ 1876.447790] watchdog: BUG: soft lockup - =
CPU#0 stuck for 153s! [TxStartup:3574]
Dec  2 12:36:10 10.243.0.116 [ 1876.480408] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:36:10 10.243.0.116 [ 1876.493824]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:36:10 10.243.0.116 [ 1876.789813] irq event stamp: 24564
Dec  2 12:36:10 10.243.0.116 [ 1876.824064] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:36:10 10.243.0.116 [ 1876.860438] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:36:10 10.243.0.116 [ 1876.896715] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:36:10 10.243.0.116 [ 1876.933187] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:36:10 10.243.0.116 [ 1876.969200] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:36:10 10.243.0.116 [ 1877.006609] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:36:10 10.243.0.116 [ 1877.044067] IRQ stage: Linux
Dec  2 12:36:10 10.243.0.116 [ 1877.080392] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:36:10 10.243.0.116 [ 1877.117483] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:36:11 10.243.0.116 [ 1877.197397] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.239296] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.281160] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.322917] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.364716] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.406744] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.448842] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.491599] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:36:11 10.243.0.116 [ 1877.534011] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:36:11 10.243.0.116 [ 1877.577106] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:36:11 10.243.0.116 [ 1877.620814] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:36:11 10.243.0.116 [ 1877.664673] Call Trace:
Dec  2 12:36:11 10.243.0.116 [ 1877.707534]  <IRQ>
Dec  2 12:36:11 10.243.0.116 [ 1877.750487]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:36:11 10.243.0.116 [ 1877.794633]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:36:11 10.243.0.116 [ 1877.838506]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:36:11 10.243.0.116 [ 1877.882548]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:36:11 10.243.0.116 [ 1877.925967]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:36:11 10.243.0.116 [ 1877.969674]  ? do_irq_inband+0x2f/0x40
Dec  2 12:36:11 10.243.0.116 [ 1878.012847]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:36:11 10.243.0.116 [ 1878.056191]  </IRQ>
Dec  2 12:36:11 10.243.0.116 [ 1878.098683]  <TASK>
Dec  2 12:36:11 10.243.0.116 [ 1878.141537]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:36:11 10.243.0.116 [ 1878.185760]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:36:12 10.243.0.116 [ 1878.229045]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:36:12 10.243.0.116 [ 1878.272395]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:36:12 10.243.0.116 [ 1878.316184]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:36:12 10.243.0.116 [ 1878.358966]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:36:12 10.243.0.116 [ 1878.401033]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:36:12 10.243.0.116 [ 1878.443713]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:36:12 10.243.0.116 [ 1878.485444]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:36:12 10.243.0.116 [ 1878.526506]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:36:12 10.243.0.116 [ 1878.566963]  ? leave_mm+0x40/0x40
Dec  2 12:36:12 10.243.0.116 [ 1878.606495]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:36:12 10.243.0.116 [ 1878.645961]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:36:12 10.243.0.116 [ 1878.684826]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:36:12 10.243.0.116 [ 1878.723425]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:36:12 10.243.0.116 [ 1878.761725]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:36:12 10.243.0.116 [ 1878.801660]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:36:12 10.243.0.116 [ 1878.839184]  ? 0xffffffffc0b38099
Dec  2 12:36:12 10.243.0.116 [ 1878.876328]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:36:12 10.243.0.116 [ 1878.913679]  ? =
change_protection+0x50/0x90
Dec  2 12:36:12 10.243.0.116 [ 1878.950108]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:36:12 10.243.0.116 [ 1878.986635]  ? =
change_protection+0x90/0x90
Dec  2 12:36:12 10.243.0.116 [ 1879.022250]  ? mprotect_fixup+0x5/0x490
Dec  2 12:36:12 10.243.0.116 [ 1879.058323]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:36:12 10.243.0.116 [ 1879.092832]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:36:12 10.243.0.116 [ 1879.124822]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:36:12 10.243.0.116 [ 1879.157175]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:36:12 10.243.0.116 [ 1879.188722]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:36:13 10.243.0.116 [ 1879.219994]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:36:13 10.243.0.116 [ 1879.253178]  </TASK>
Dec  2 12:36:38 10.243.0.116 [ 1904.447919] watchdog: BUG: soft lockup - =
CPU#0 stuck for 179s! [TxStartup:3574]
Dec  2 12:36:38 10.243.0.116 [ 1904.480296] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:36:38 10.243.0.116 [ 1904.493711]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:36:38 10.243.0.116 [ 1904.787213] irq event stamp: 24564
Dec  2 12:36:38 10.243.0.116 [ 1904.821224] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:36:38 10.243.0.116 [ 1904.857335] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:36:38 10.243.0.116 [ 1904.893475] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:36:38 10.243.0.116 [ 1904.929794] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:36:38 10.243.0.116 [ 1904.965671] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:36:39 10.243.0.116 [ 1905.002931] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:36:39 10.243.0.116 [ 1905.042665] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 1905.042665]   Tx Queue             <7>#012[ =
1905.042665]   TDH                  <4>#012[ 1905.042665]   TDT          =
        <4>#012[ 1905.042665]   next_to_use          <4>#012[ =
1905.042665]   next_to_clean        <9e>#012[ 1905.042665] =
buffer_info[next_to_clean]#012[ 1905.042665]   time_stamp           =
<100179b5e>#012[ 1905.042665]   next_to_watch        =
<00000000b00b2101>#012[ 1905.042665]   jiffies              =
<10018761e>#012[ 1905.042665]   desc.status          <16c001>
Dec  2 12:36:39 10.243.0.116 [ 1905.770842] IRQ stage: Linux
Dec  2 12:36:39 10.243.0.116 [ 1905.806287] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:36:39 10.243.0.116 [ 1905.842339] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:36:39 10.243.0.116 [ 1905.920072] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1905.960846] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1906.001673] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1906.042600] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1906.083768] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1906.125162] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:36:39 10.243.0.116 [ 1906.166634] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:36:40 10.243.0.116 [ 1906.208640] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:36:40 10.243.0.116 [ 1906.250348] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:36:40 10.243.0.116 [ 1906.292967] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:36:40 10.243.0.116 [ 1906.336130] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:36:40 10.243.0.116 [ 1906.379390] Call Trace:
Dec  2 12:36:40 10.243.0.116 [ 1906.421672]  <IRQ>
Dec  2 12:36:40 10.243.0.116 [ 1906.464011]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:36:40 10.243.0.116 [ 1906.507463]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:36:40 10.243.0.116 [ 1906.550618]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:36:40 10.243.0.116 [ 1906.593206]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:36:40 10.243.0.116 [ 1906.634680]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:36:40 10.243.0.116 [ 1906.676127]  ? do_irq_inband+0x2f/0x40
Dec  2 12:36:40 10.243.0.116 [ 1906.716771]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:36:40 10.243.0.116 [ 1906.757021]  </IRQ>
Dec  2 12:36:40 10.243.0.116 [ 1906.795940]  <TASK>
Dec  2 12:36:40 10.243.0.116 [ 1906.834764]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:36:40 10.243.0.116 [ 1906.874467]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:36:40 10.243.0.116 [ 1906.912909]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:36:40 10.243.0.116 [ 1906.950683]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:36:40 10.243.0.116 [ 1906.988334]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:36:40 10.243.0.116 [ 1907.025307]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:36:40 10.243.0.116 [ 1907.062001]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:36:40 10.243.0.116 [ 1907.099412]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:36:40 10.243.0.116 [ 1907.136226]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:36:40 10.243.0.116 [ 1907.172465]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:36:41 10.243.0.116 [ 1907.208233]  ? leave_mm+0x40/0x40
Dec  2 12:36:41 10.243.0.116 [ 1907.243070]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:36:41 10.243.0.116 [ 1907.278191]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:36:41 10.243.0.116 [ 1907.313310]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:36:41 10.243.0.116 [ 1907.349094]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:36:41 10.243.0.116 [ 1907.385219]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:36:41 10.243.0.116 [ 1907.423372]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:36:41 10.243.0.116 [ 1907.459370]  ? 0xffffffffc0b38099
Dec  2 12:36:41 10.243.0.116 [ 1907.495409]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:36:41 10.243.0.116 [ 1907.531782]  ? =
change_protection+0x50/0x90
Dec  2 12:36:41 10.243.0.116 [ 1907.567611]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:36:41 10.243.0.116 [ 1907.604020]  ? =
change_protection+0x90/0x90
Dec  2 12:36:41 10.243.0.116 [ 1907.639849]  ? mprotect_fixup+0x5/0x490
Dec  2 12:36:41 10.243.0.116 [ 1907.676077]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:36:41 10.243.0.116 [ 1907.710738]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:36:41 10.243.0.116 [ 1907.742886]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:36:41 10.243.0.116 [ 1907.775292]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:36:41 10.243.0.116 [ 1907.806891]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:36:41 10.243.0.116 [ 1907.838214]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:36:41 10.243.0.116 [ 1907.871250]  </TASK>
Dec  2 12:36:58 10.243.0.116 [ 1924.447866] watchdog: BUG: soft lockup - =
CPU#2 stuck for 23s! [kworker/2:2:259]
Dec  2 12:36:58 10.243.0.116 [ 1924.474882] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:36:58 10.243.0.116 [ 1924.486050]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:36:58 10.243.0.116 [ 1924.731137] irq event stamp: 23654
Dec  2 12:36:58 10.243.0.116 [ 1924.759431] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:36:58 10.243.0.116 [ 1924.789736] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:36:58 10.243.0.116 [ 1924.820052] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:36:58 10.243.0.116 [ 1924.850525] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:36:58 10.243.0.116 [ 1924.881152] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:36:58 10.243.0.116 [ 1924.912713] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:36:58 10.243.0.116 [ 1924.944397] IRQ stage: Linux
Dec  2 12:36:58 10.243.0.116 [ 1924.974695] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:36:58 10.243.0.116 [ 1925.005121] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:36:58 10.243.0.116 [ 1925.036876] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:36:58 10.243.0.116 [ 1925.103160] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:36:58 10.243.0.116 [ 1925.137688] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:36:58 10.243.0.116 [ 1925.172075] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.206244] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.241264] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.275971] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.310695] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.345999] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:36:59 10.243.0.116 [ 1925.381463] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:36:59 10.243.0.116 [ 1925.414834] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:36:59 10.243.0.116 [ 1925.445684] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:36:59 10.243.0.116 [ 1925.476363] Call Trace:
Dec  2 12:36:59 10.243.0.116 [ 1925.506356]  <IRQ>
Dec  2 12:36:59 10.243.0.116 [ 1925.536560]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:36:59 10.243.0.116 [ 1925.567894]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:36:59 10.243.0.116 [ 1925.599718]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:36:59 10.243.0.116 [ 1925.636448]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:36:59 10.243.0.116 [ 1925.672463]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:36:59 10.243.0.116 [ 1925.708339]  ? do_irq_inband+0x2f/0x40
Dec  2 12:36:59 10.243.0.116 [ 1925.743946]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:36:59 10.243.0.116 [ 1925.779956]  </IRQ>
Dec  2 12:36:59 10.243.0.116 [ 1925.815138]  <TASK>
Dec  2 12:36:59 10.243.0.116 [ 1925.850818]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:36:59 10.243.0.116 [ 1925.887606]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:36:59 10.243.0.116 [ 1925.923337]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:36:59 10.243.0.116 [ 1925.960426]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:36:59 10.243.0.116 [ 1925.996846]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:36:59 10.243.0.116 [ 1926.032049]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:36:59 10.243.0.116 [ 1926.067847]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:36:59 10.243.0.116 [ 1926.101966]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:36:59 10.243.0.116 [ 1926.135872]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:36:59 10.243.0.116 [ 1926.169835]  ? __asan_store2+0xa0/0xa0
Dec  2 12:37:00 10.243.0.116 [ 1926.203129]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:37:00 10.243.0.116 [ 1926.235828]  ? 0xffffffffc0b38099
Dec  2 12:37:00 10.243.0.116 [ 1926.268548]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:37:00 10.243.0.116 [ 1926.300817]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:37:00 10.243.0.116 [ 1926.332965]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:37:00 10.243.0.116 [ 1926.364365]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:37:00 10.243.0.116 [ 1926.397394]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:37:00 10.243.0.116 [ 1926.428585]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:37:00 10.243.0.116 [ 1926.458830]  ? =
process_one_work+0x525/0xa30
Dec  2 12:37:00 10.243.0.116 [ 1926.490169]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:37:00 10.243.0.116 [ 1926.520083]  ? =
process_one_work+0x5/0xa30
Dec  2 12:37:00 10.243.0.116 [ 1926.550365]  ? worker_thread+0x57/0x590
Dec  2 12:37:00 10.243.0.116 [ 1926.580743]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:37:00 10.243.0.116 [ 1926.610735]  ? kthread+0x1f3/0x220
Dec  2 12:37:00 10.243.0.116 [ 1926.638736]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:37:00 10.243.0.116 [ 1926.665803]  ? ret_from_fork+0x22/0x30
Dec  2 12:37:00 10.243.0.116 [ 1926.692856]  </TASK>
Dec  2 12:37:06 10.243.0.116 [ 1932.448044] watchdog: BUG: soft lockup - =
CPU#0 stuck for 205s! [TxStartup:3574]
Dec  2 12:37:06 10.243.0.116 [ 1932.481569] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:37:06 10.243.0.116 [ 1932.494984]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:37:06 10.243.0.116 [ 1932.803512] irq event stamp: 24564
Dec  2 12:37:06 10.243.0.116 [ 1932.838158] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:37:06 10.243.0.116 [ 1932.874930] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:37:06 10.243.0.116 [ 1932.911787] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:37:06 10.243.0.116 [ 1932.948959] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:37:06 10.243.0.116 [ 1932.985721] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:37:06 10.243.0.116 [ 1933.023777] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:37:06 10.243.0.116 [ 1933.061740] IRQ stage: Linux
Dec  2 12:37:06 10.243.0.116 [ 1933.098584] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:37:06 10.243.0.116 [ 1933.136128] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:37:07 10.243.0.116 [ 1933.217191] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000287 ORIG_RAX: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.259614] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.302070] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.344483] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.387081] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.429714] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.472202] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.515298] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:37:07 10.243.0.116 [ 1933.558143] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:37:07 10.243.0.116 [ 1933.601795] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:37:07 10.243.0.116 [ 1933.646100] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:37:07 10.243.0.116 [ 1933.690635] Call Trace:
Dec  2 12:37:07 10.243.0.116 [ 1933.734040]  <IRQ>
Dec  2 12:37:07 10.243.0.116 [ 1933.777505]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:37:07 10.243.0.116 [ 1933.822038]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:37:07 10.243.0.116 [ 1933.866137]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:37:07 10.243.0.116 [ 1933.910370]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:37:07 10.243.0.116 [ 1933.954028]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:37:07 10.243.0.116 [ 1933.998028]  ? do_irq_inband+0x2f/0x40
Dec  2 12:37:07 10.243.0.116 [ 1934.041527]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:37:07 10.243.0.116 [ 1934.085139]  </IRQ>
Dec  2 12:37:07 10.243.0.116 [ 1934.127790]  <TASK>
Dec  2 12:37:07 10.243.0.116 [ 1934.170607]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:37:08 10.243.0.116 [ 1934.214757]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:37:08 10.243.0.116 [ 1934.257972]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:37:08 10.243.0.116 [ 1934.301188]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:37:08 10.243.0.116 [ 1934.344721]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:37:08 10.243.0.116 [ 1934.387389]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:37:08 10.243.0.116 [ 1934.429328]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:37:08 10.243.0.116 [ 1934.471946]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:37:08 10.243.0.116 [ 1934.513618]  ? __asan_store2+0xa0/0xa0
Dec  2 12:37:08 10.243.0.116 [ 1934.554403]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:37:08 10.243.0.116 [ 1934.595051]  ? leave_mm+0x40/0x40
Dec  2 12:37:08 10.243.0.116 [ 1934.634709]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:37:08 10.243.0.116 [ 1934.674264]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:37:08 10.243.0.116 [ 1934.713336]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:37:08 10.243.0.116 [ 1934.752062]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:37:08 10.243.0.116 [ 1934.790495]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:37:08 10.243.0.116 [ 1934.830568]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:37:08 10.243.0.116 [ 1934.868293]  ? 0xffffffffc0b38099
Dec  2 12:37:08 10.243.0.116 [ 1934.905569]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:37:08 10.243.0.116 [ 1934.943054]  ? =
change_protection+0x50/0x90
Dec  2 12:37:08 10.243.0.116 [ 1934.979616]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:37:08 10.243.0.116 [ 1935.016274]  ? =
change_protection+0x90/0x90
Dec  2 12:37:08 10.243.0.116 [ 1935.052032]  ? mprotect_fixup+0x5/0x490
Dec  2 12:37:08 10.243.0.116 [ 1935.088192]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:37:08 10.243.0.116 [ 1935.122778]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:37:08 10.243.0.116 [ 1935.154894]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:37:08 10.243.0.116 [ 1935.187329]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:37:09 10.243.0.116 [ 1935.219003]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:37:09 10.243.0.116 [ 1935.250422]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:37:09 10.243.0.116 [ 1935.283600]  </TASK>
Dec  2 12:37:26 10.243.0.116 [ 1952.447989] watchdog: BUG: soft lockup - =
CPU#2 stuck for 49s! [kworker/2:2:259]
Dec  2 12:37:26 10.243.0.116 [ 1952.474936] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:37:26 10.243.0.116 [ 1952.485927]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:37:26 10.243.0.116 [ 1952.730986] irq event stamp: 23654
Dec  2 12:37:26 10.243.0.116 [ 1952.758774] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:37:26 10.243.0.116 [ 1952.783952] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:37:26 10.243.0.116 [ 1952.813744] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:37:26 10.243.0.116 [ 1952.843412] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:37:26 10.243.0.116 [ 1952.873239] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:37:26 10.243.0.116 [ 1952.904613] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:37:26 10.243.0.116 [ 1952.935686] IRQ stage: Linux
Dec  2 12:37:26 10.243.0.116 [ 1952.965494] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:37:26 10.243.0.116 [ 1952.997078] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:37:26 10.243.0.116 [ 1953.027504] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:37:26 10.243.0.116 [ 1953.093929] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:37:26 10.243.0.116 [ 1953.128894] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:37:26 10.243.0.116 [ 1953.163657] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.198326] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.233457] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.268560] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.303012] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.338635] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:37:27 10.243.0.116 [ 1953.373694] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:37:27 10.243.0.116 [ 1953.409703] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:37:27 10.243.0.116 [ 1953.445762] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:37:27 10.243.0.116 [ 1953.482185] Call Trace:
Dec  2 12:37:27 10.243.0.116 [ 1953.518035]  <IRQ>
Dec  2 12:37:27 10.243.0.116 [ 1953.553529]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:37:27 10.243.0.116 [ 1953.589673]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:37:27 10.243.0.116 [ 1953.626461]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:37:27 10.243.0.116 [ 1953.662586]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:37:27 10.243.0.116 [ 1953.698155]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:37:27 10.243.0.116 [ 1953.734705]  ? do_irq_inband+0x2f/0x40
Dec  2 12:37:27 10.243.0.116 [ 1953.770931]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:37:27 10.243.0.116 [ 1953.806936]  </IRQ>
Dec  2 12:37:27 10.243.0.116 [ 1953.842230]  <TASK>
Dec  2 12:37:27 10.243.0.116 [ 1953.877274]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:37:27 10.243.0.116 [ 1953.914055]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:37:27 10.243.0.116 [ 1953.949958]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:37:27 10.243.0.116 [ 1953.985819]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:37:27 10.243.0.116 [ 1954.021147]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:37:27 10.243.0.116 [ 1954.056384]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:37:27 10.243.0.116 [ 1954.091256]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:37:27 10.243.0.116 [ 1954.120285]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:37:27 10.243.0.116 [ 1954.149372]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:37:28 10.243.0.116 [ 1954.178114]  ? __asan_load4+0x8/0x90
Dec  2 12:37:28 10.243.0.116 [ 1954.207467] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 1954.207467]   Tx Queue             <7>#012[ =
1954.207467]   TDH                  <ed>#012[ 1954.207467]   TDT         =
         <ed>#012[ 1954.207467]   next_to_use          <ed>#012[ =
1954.207467]   next_to_clean        <84>#012[ 1954.207467] =
buffer_info[next_to_clean]#012[ 1954.207467]   time_stamp           =
<10018e37e>#012[ 1954.207467]   next_to_watch        =
<0000000040fb38c4>#012[ 1954.207467]   jiffies              =
<10019387d>#012[ 1954.207467]   desc.status          <220001>
Dec  2 12:37:28 10.243.0.116 [ 1954.685801]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:37:28 10.243.0.116 [ 1954.710060]  ? 0xffffffffc0b38099
Dec  2 12:37:28 10.243.0.116 [ 1954.734207]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:37:28 10.243.0.116 [ 1954.757776]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:37:28 10.243.0.116 [ 1954.779314]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:37:28 10.243.0.116 [ 1954.803030]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:37:28 10.243.0.116 [ 1954.825421]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:37:28 10.243.0.116 [ 1954.847117]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:37:28 10.243.0.116 [ 1954.868608]  ? =
process_one_work+0x525/0xa30
Dec  2 12:37:28 10.243.0.116 [ 1954.890142]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:37:28 10.243.0.116 [ 1954.911808]  ? =
process_one_work+0x5/0xa30
Dec  2 12:37:28 10.243.0.116 [ 1954.933180]  ? worker_thread+0x57/0x590
Dec  2 12:37:28 10.243.0.116 [ 1954.954188]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:37:28 10.243.0.116 [ 1954.975074]  ? kthread+0x1f3/0x220
Dec  2 12:37:28 10.243.0.116 [ 1954.995023]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:37:28 10.243.0.116 [ 1955.015076]  ? ret_from_fork+0x22/0x30
Dec  2 12:37:28 10.243.0.116 [ 1955.035934]  </TASK>
Dec  2 12:37:34 10.243.0.116 [ 1960.448168] watchdog: BUG: soft lockup - =
CPU#0 stuck for 231s! [TxStartup:3574]
Dec  2 12:37:34 10.243.0.116 [ 1960.478483] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:37:34 10.243.0.116 [ 1960.491894]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:37:34 10.243.0.116 [ 1960.784536] irq event stamp: 24564
Dec  2 12:37:34 10.243.0.116 [ 1960.818817] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:37:34 10.243.0.116 [ 1960.855204] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:37:34 10.243.0.116 [ 1960.891595] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:37:34 10.243.0.116 [ 1960.928082] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:37:34 10.243.0.116 [ 1960.964233] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:37:34 10.243.0.116 [ 1961.001650] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:37:34 10.243.0.116 [ 1961.038982] IRQ stage: Linux
Dec  2 12:37:34 10.243.0.116 [ 1961.074975] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:37:34 10.243.0.116 [ 1961.111655] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:37:35 10.243.0.116 [ 1961.190288] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000287 ORIG_RAX: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.231492] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.272945] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.314553] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.356411] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.398485] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.440680] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.483538] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:37:35 10.243.0.116 [ 1961.526168] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:37:35 10.243.0.116 [ 1961.569681] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:37:35 10.243.0.116 [ 1961.613769] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:37:35 10.243.0.116 [ 1961.658008] Call Trace:
Dec  2 12:37:35 10.243.0.116 [ 1961.701259]  <IRQ>
Dec  2 12:37:35 10.243.0.116 [ 1961.744566]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:37:35 10.243.0.116 [ 1961.788936]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:37:35 10.243.0.116 [ 1961.832861]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:37:35 10.243.0.116 [ 1961.876922]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:37:35 10.243.0.116 [ 1961.920413]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:37:35 10.243.0.116 [ 1961.964303]  ? do_irq_inband+0x2f/0x40
Dec  2 12:37:35 10.243.0.116 [ 1962.007709]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:37:35 10.243.0.116 [ 1962.051271]  </IRQ>
Dec  2 12:37:35 10.243.0.116 [ 1962.093927]  <TASK>
Dec  2 12:37:35 10.243.0.116 [ 1962.136826]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:37:35 10.243.0.116 [ 1962.181099]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:37:36 10.243.0.116 [ 1962.224429]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:37:36 10.243.0.116 [ 1962.267645]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:37:36 10.243.0.116 [ 1962.311183]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:37:36 10.243.0.116 [ 1962.353851]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:37:36 10.243.0.116 [ 1962.395733]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:37:36 10.243.0.116 [ 1962.438323]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:37:36 10.243.0.116 [ 1962.479878]  ? __asan_store2+0xa0/0xa0
Dec  2 12:37:36 10.243.0.116 [ 1962.520466]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:37:36 10.243.0.116 [ 1962.561054]  ? leave_mm+0x40/0x40
Dec  2 12:37:36 10.243.0.116 [ 1962.600604]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:37:36 10.243.0.116 [ 1962.640035]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:37:36 10.243.0.116 [ 1962.678918]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:37:36 10.243.0.116 [ 1962.717523]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:37:36 10.243.0.116 [ 1962.755835]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:37:36 10.243.0.116 [ 1962.795777]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:37:36 10.243.0.116 [ 1962.833324]  ? 0xffffffffc0b38099
Dec  2 12:37:36 10.243.0.116 [ 1962.870487]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:37:36 10.243.0.116 [ 1962.907838]  ? =
change_protection+0x50/0x90
Dec  2 12:37:36 10.243.0.116 [ 1962.944284]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:37:36 10.243.0.116 [ 1962.980882]  ? =
change_protection+0x90/0x90
Dec  2 12:37:36 10.243.0.116 [ 1963.016620]  ? mprotect_fixup+0x5/0x490
Dec  2 12:37:36 10.243.0.116 [ 1963.052819]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:37:36 10.243.0.116 [ 1963.087401]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:37:36 10.243.0.116 [ 1963.119515]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:37:36 10.243.0.116 [ 1963.151948]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:37:36 10.243.0.116 [ 1963.183633]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:37:37 10.243.0.116 [ 1963.215046]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:37:37 10.243.0.116 [ 1963.248223]  </TASK>
Dec  2 12:37:52 10.243.0.116 [ 1978.563645] rcu: INFO: rcu_sched =
detected stalls on CPUs/tasks:
Dec  2 12:37:52 10.243.0.116 [ 1978.589999] rcu: #0115-...0: (1 GPs =
behind) idle=3D78b/1/0x4000000000000002 softirq=3D161154/161154 =
fqs=3D31605
Dec  2 12:37:52 10.243.0.116 [ 1978.621786] #011(detected by 2, =
t=3D263092 jiffies, g=3D126833, q=3D17875)
Dec  2 12:37:52 10.243.0.116 [ 1978.648082] Sending NMI from CPU 2 to =
CPUs 5:
Dec  2 12:37:52 10.243.0.116 [ 1978.678270] NMI backtrace for cpu 5
Dec  2 12:37:52 10.243.0.116 [ 1978.678291] CPU: 5 PID: 3577 Comm: =
DummyTxSample Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:37:52 10.243.0.116 [ 1978.678311] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:37:52 10.243.0.116 [ 1978.678328] IRQ stage: EVL
Dec  2 12:37:52 10.243.0.116 [ 1978.678372] RIP: =
0010:__asan_load4+0x21/0x90
Dec  2 12:37:52 10.243.0.116 [ 1978.678442] Code: 2e 0f 1f 84 00 00 00 =
00 00 55 48 89 e5 48 8b 4d 08 48 83 ff fb 77 53 48 b8 ff ff ff ff ff 7f =
ff ff 48 39 c7 76 44 48 8d 47 03 <48> 89 c2 83 e2 07 48 83 fa 02 76 1c =
48 be 00 00 00 00 00 fc ff df
Dec  2 12:37:52 10.243.0.116 [ 1978.678482] RSP: 0018:ffff888137737528 =
EFLAGS: 00000012
Dec  2 12:37:52 10.243.0.116 [ 1978.678550] RAX: ffff888101aae003 RBX: =
ffff888101aae000 RCX: ffffffff8d1abe74
Dec  2 12:37:52 10.243.0.116 [ 1978.678589] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101aae000
Dec  2 12:37:52 10.243.0.116 [ 1978.678626] RBP: ffff888137737528 R08: =
ffffed1020355c01 R09: ffffed1020355c01
Dec  2 12:37:52 10.243.0.116 [ 1978.678664] R10: ffff888101aae003 R11: =
ffffed1020355c00 R12: 1ffff11026ee6eaa
Dec  2 12:37:52 10.243.0.116 [ 1978.678704] R13: 0000000000000000 R14: =
ffff8881377375f0 R15: 0000000000000001
Dec  2 12:37:52 10.243.0.116 [ 1978.678765] FS:  00007f3013fff700(0000) =
GS:ffff88841e480000(0000) knlGS:0000000000000000
Dec  2 12:37:52 10.243.0.116 [ 1978.678805] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:37:52 10.243.0.116 [ 1978.678842] CR2: 0000000000000070 CR3: =
0000000137d08002 CR4: 00000000003706e0
Dec  2 12:37:52 10.243.0.116 [ 1978.678880] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:37:53 10.243.0.116 [ 1978.678917] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:37:53 10.243.0.116 [ 1978.678956] Call Trace:
Dec  2 12:37:53 10.243.0.116 [ 1978.678976]  <TASK>
Dec  2 12:37:53 10.243.0.116 [ 1978.679030]  =
native_queued_spin_lock_slowpath+0x194/0x4c0
Dec  2 12:37:53 10.243.0.116 [ 1978.679106]  ? 0xffffffffc0b38099
Dec  2 12:37:53 10.243.0.116 [ 1978.679162]  ? =
trace_function+0x11e/0x180
Dec  2 12:37:53 10.243.0.116 [ 1978.679263]  ? .slowpath+0x1d/0x1d
Dec  2 12:37:53 10.243.0.116 [ 1978.679788]  ? =
do_raw_spin_lock+0xe6/0x1e0
Dec  2 12:37:53 10.243.0.116 [ 1978.680050]  ? =
native_queued_spin_lock_slowpath+0x5/0x4c0
Dec  2 12:37:53 10.243.0.116 [ 1978.680121]  ? 0xffffffffc0b38099
Dec  2 12:37:53 10.243.0.116 [ 1978.680592]  =
do_raw_spin_lock+0x1cb/0x1e0
Dec  2 12:37:53 10.243.0.116 [ 1978.680823]  ? spin_dump+0x90/0x90
Dec  2 12:37:53 10.243.0.116 [ 1978.681064]  ? =
do_raw_spin_lock+0x5/0x1e0
Dec  2 12:37:53 10.243.0.116 [ 1978.681565]  =
evl_switch_inband+0xad/0x7c0
Dec  2 12:37:53 10.243.0.116 [ 1978.682123]  =
handle_oob_trap_entry+0x10a/0x200
Dec  2 12:37:53 10.243.0.116 [ 1978.682405]  __oob_trap_notify+0x3f/0x50
Dec  2 12:37:53 10.243.0.116 [ 1978.682788]  page_fault_oops+0x1e4/0x3d0
Dec  2 12:37:53 10.243.0.116 [ 1978.682941]  ? =
trace_function+0x11e/0x180
Dec  2 12:37:53 10.243.0.116 [ 1978.683017]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:37:53 10.243.0.116 [ 1978.683151]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:37:53 10.243.0.116 [ 1978.683252]  ? =
function_trace_call+0x153/0x1d0
Dec  2 12:37:53 10.243.0.116 [ 1978.683283]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:37:53 10.243.0.116 [ 1978.683315]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:37:53 10.243.0.116 [ 1978.683840]  ? 0xffffffffc0b38099
Dec  2 12:37:53 10.243.0.116 [ 1978.684162]  ? =
do_user_addr_fault+0xa30/0xa30
Dec  2 12:37:53 10.243.0.116 [ 1978.684332]  ? =
do_user_addr_fault+0x686/0xa30
Dec  2 12:37:53 10.243.0.116 [ 1978.684711]  ? page_fault_oops+0x5/0x3d0
Dec  2 12:37:53 10.243.0.116 [ 1978.684858]  ? exc_page_fault+0x5c/0xe0
Dec  2 12:37:53 10.243.0.116 [ 1978.685214]  =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:37:53 10.243.0.116 [ 1978.685250]  ? =
rcu_read_lock_held_common+0x5/0x70
Dec  2 12:37:53 10.243.0.116 [ 1978.685317]  ? =
rcu_read_lock_held_common+0x2a/0x70
Dec  2 12:37:53 10.243.0.116 [ 1978.685910]  ? =
trace_page_fault_user+0x130/0x130
Dec  2 12:37:54 10.243.0.116 [ 1978.686104]  ? =
fault_in_kernel_space+0x5/0x40
Dec  2 12:37:54 10.243.0.116 [ 1978.686659]  exc_page_fault+0x71/0xe0
Dec  2 12:37:54 10.243.0.116 [ 1978.687029]  =
asm_exc_page_fault+0x27/0x30
Dec  2 12:37:54 10.243.0.116 [ 1978.687066] RIP: =
0010:trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:37:54 10.243.0.116 [ 1978.687100] Code: 80 0f 85 93 02 00 00 =
41 f6 c7 40 0f 85 10 02 00 00 41 f7 c7 00 02 00 00 0f 85 8f 02 00 00 4d =
8d 7d 70 4c 89 ff e8 6d e9 1e 00 <49> 8b 7d 70 48 85 ff 0f 84 2d 02 00 =
00 e8 ab b4 58 00 8d 50 01 83
Dec  2 12:37:54 10.243.0.116 [ 1978.687119] RSP: 0018:ffff888137737aa0 =
EFLAGS: 00010082
Dec  2 12:37:54 10.243.0.116 [ 1978.687150] RAX: 0000000000000001 RBX: =
1ffff11026ee6f5a RCX: ffffffff8d1acefc
Dec  2 12:37:54 10.243.0.116 [ 1978.687167] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffffffff8f2acb40
Dec  2 12:37:54 10.243.0.116 [ 1978.687184] RBP: ffff888137737b78 R08: =
fffffbfff1e55969 R09: fffffbfff1e55969
Dec  2 12:37:54 10.243.0.116 [ 1978.687201] R10: ffffffff8f2acb43 R11: =
fffffbfff1e55968 R12: ffff888100195000
Dec  2 12:37:54 10.243.0.116 [ 1978.687218] R13: 0000000000000000 R14: =
ffffffff8f219d40 R15: 0000000000000070
Dec  2 12:37:54 10.243.0.116 [ 1978.687962]  ? =
do_raw_spin_unlock+0x9c/0x140
Dec  2 12:37:54 10.243.0.116 [ 1978.688807]  ? =
trace_event_raw_event_evl_init_thread+0x330/0x330
Dec  2 12:37:54 10.243.0.116 [ 1978.689063]  ? 0xffffffffc0b38099
Dec  2 12:37:54 10.243.0.116 [ 1978.689117]  ? evl_delay+0x48/0xf0
Dec  2 12:37:54 10.243.0.116 [ 1978.689149]  ? =
evl_sleep_on_locked+0x730/0x730
Dec  2 12:37:54 10.243.0.116 [ 1978.689316]  ? =
__kasan_check_write+0x14/0x20
Dec  2 12:37:54 10.243.0.116 [ 1978.689910]  =
evl_sleep_on_locked+0x629/0x730
Dec  2 12:37:54 10.243.0.116 [ 1978.690005]  ? =
evl_sleep_on_locked+0x5/0x730
Dec  2 12:37:54 10.243.0.116 [ 1978.690430]  evl_sleep_on+0x7b/0xb0
Dec  2 12:37:54 10.243.0.116 [ 1978.691029]  evl_delay+0x48/0xf0
Dec  2 12:37:54 10.243.0.116 [ 1978.691266]  clock_oob_ioctl+0x182/0x2d0
Dec  2 12:37:54 10.243.0.116 [ 1978.691573]  ? =
clock_common_ioctl+0x5e0/0x5e0
Dec  2 12:37:54 10.243.0.116 [ 1978.691952]  ? clock_oob_ioctl+0x5/0x2d0
Dec  2 12:37:54 10.243.0.116 [ 1978.692325]  EVL_ioctl+0x86/0x100
Dec  2 12:37:54 10.243.0.116 [ 1978.692933]  do_oob_syscall+0x5b1/0x6d0
Dec  2 12:37:54 10.243.0.116 [ 1978.693149]  ? =
prepare_for_signal+0x180/0x180
Dec  2 12:37:54 10.243.0.116 [ 1978.693315]  ? do_oob_syscall+0x5/0x6d0
Dec  2 12:37:54 10.243.0.116 [ 1978.693445]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:37:54 10.243.0.116 [ 1978.694034]  =
handle_oob_syscall+0x18e/0x230
Dec  2 12:37:54 10.243.0.116 [ 1978.694236]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:37:54 10.243.0.116 [ 1978.694804]  ? =
handle_oob_syscall+0x5/0x230
Dec  2 12:37:54 10.243.0.116 [ 1978.695258]  pipeline_syscall+0xac/0x1c0
Dec  2 12:37:55 10.243.0.116 [ 1978.695784]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 12:37:55 10.243.0.116 [ 1978.696051]  do_syscall_64+0x1d/0xa0
Dec  2 12:37:55 10.243.0.116 [ 1978.696154]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:37:55 10.243.0.116 [ 1978.696191] RIP: 0033:0x7f302d4b1b9b
Dec  2 12:37:55 10.243.0.116 [ 1978.696239] Code: Unable to access =
opcode bytes at RIP 0x7f302d4b1b71.
Dec  2 12:37:55 10.243.0.116 [ 1978.696255] RSP: 002b:00007f3013fef5a0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 12:37:55 10.243.0.116 [ 1978.696288] RAX: ffffffffffffffda RBX: =
00007f3013fef630 RCX: 00007f302d4b1b9b
Dec  2 12:37:55 10.243.0.116 [ 1978.696306] RDX: 0000000040106300 RSI: =
0000000000000004 RDI: 0000000010000002
Dec  2 12:37:55 10.243.0.116 [ 1978.696323] RBP: 0000000040106300 R08: =
0000000000000000 R09: 00007ffd9df03080
Dec  2 12:37:55 10.243.0.116 [ 1978.696353] R10: 00007f3013fef630 R11: =
0000000000000246 R12: 0000000000000004
Dec  2 12:37:55 10.243.0.116 [ 1978.696390] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f3013fff700
Dec  2 12:37:55 10.243.0.116 [ 1978.697564]  </TASK>
Dec  2 12:38:02 10.243.0.116 [ 1988.448303] watchdog: BUG: soft lockup - =
CPU#0 stuck for 257s! [TxStartup:3574]
Dec  2 12:38:02 10.243.0.116 [ 1988.486820] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:38:02 10.243.0.116 [ 1988.500227]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:38:02 10.243.0.116 [ 1988.845134] irq event stamp: 24564
Dec  2 12:38:02 10.243.0.116 [ 1988.881914] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:38:02 10.243.0.116 [ 1988.920476] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:38:02 10.243.0.116 [ 1988.958723] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:38:02 10.243.0.116 [ 1988.996927] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:38:02 10.243.0.116 [ 1989.034749] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:38:02 10.243.0.116 [ 1989.073974] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:38:02 10.243.0.116 [ 1989.113043] IRQ stage: Linux
Dec  2 12:38:02 10.243.0.116 [ 1989.151073] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:38:03 10.243.0.116 [ 1989.189820] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:38:03 10.243.0.116 [ 1989.272838] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.316267] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.359816] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.403347] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.447076] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.490965] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.534863] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.579489] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:38:03 10.243.0.116 [ 1989.623810] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:38:03 10.243.0.116 [ 1989.668939] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:38:03 10.243.0.116 [ 1989.714670] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:38:03 10.243.0.116 [ 1989.760602] Call Trace:
Dec  2 12:38:03 10.243.0.116 [ 1989.805591]  <IRQ>
Dec  2 12:38:03 10.243.0.116 [ 1989.850632]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:38:03 10.243.0.116 [ 1989.896826]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:38:03 10.243.0.116 [ 1989.942735]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:38:03 10.243.0.116 [ 1989.988730]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:38:03 10.243.0.116 [ 1990.034125]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:38:03 10.243.0.116 [ 1990.079951]  ? do_irq_inband+0x2f/0x40
Dec  2 12:38:03 10.243.0.116 [ 1990.125092]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:38:03 10.243.0.116 [ 1990.170390]  </IRQ>
Dec  2 12:38:04 10.243.0.116 [ 1990.214494]  <TASK>
Dec  2 12:38:04 10.243.0.116 [ 1990.258586]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:38:04 10.243.0.116 [ 1990.303823]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:38:04 10.243.0.116 [ 1990.347734]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:38:04 10.243.0.116 [ 1990.391415]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:38:04 10.243.0.116 [ 1990.435061]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:38:04 10.243.0.116 [ 1990.477843]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:38:04 10.243.0.116 [ 1990.519893]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:38:04 10.243.0.116 [ 1990.562628]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:38:04 10.243.0.116 [ 1990.604399]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:38:04 10.243.0.116 [ 1990.645509]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:38:04 10.243.0.116 [ 1990.686011]  ? leave_mm+0x40/0x40
Dec  2 12:38:04 10.243.0.116 [ 1990.725535]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:38:04 10.243.0.116 [ 1990.764945]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:38:04 10.243.0.116 [ 1990.803740]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:38:04 10.243.0.116 [ 1990.842318]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:38:04 10.243.0.116 [ 1990.880608]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:38:04 10.243.0.116 [ 1990.920540]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:38:05 10.243.0.116 [ 1990.958070]  ? 0xffffffffc0b38099
Dec  2 12:38:05 10.243.0.116 [ 1990.996945] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 1990.996945]   Tx Queue             <7>#012[ =
1990.996945]   TDH                  <d8>#012[ 1990.996945]   TDT         =
         <d8>#012[ 1990.996945]   next_to_use          <d8>#012[ =
1990.996945]   next_to_clean        <6d>#012[ 1990.996945] =
buffer_info[next_to_clean]#012[ 1990.996945]   time_stamp           =
<100199d16>#012[ 1990.996945]   next_to_watch        =
<0000000088ad01cc>#012[ 1990.996945]   jiffies              =
<10019be3e>#012[ 1990.996945]   desc.status          <13c001>
Dec  2 12:38:05 10.243.0.116 [ 1991.695232]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:38:05 10.243.0.116 [ 1991.726494]  ? =
change_protection+0x50/0x90
Dec  2 12:38:05 10.243.0.116 [ 1991.757296]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:38:05 10.243.0.116 [ 1991.788113]  ? =
change_protection+0x90/0x90
Dec  2 12:38:05 10.243.0.116 [ 1991.817941]  ? mprotect_fixup+0x5/0x490
Dec  2 12:38:05 10.243.0.116 [ 1991.847781]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:38:05 10.243.0.116 [ 1991.877045]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:38:05 10.243.0.116 [ 1991.905835]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:38:05 10.243.0.116 [ 1991.934730]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:38:05 10.243.0.116 [ 1991.963315]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:38:05 10.243.0.116 [ 1991.991732]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:38:05 10.243.0.116 [ 1992.022040]  </TASK>
Dec  2 12:38:18 10.243.0.116 [ 2004.448152] watchdog: BUG: soft lockup - =
CPU#2 stuck for 97s! [kworker/2:2:259]
Dec  2 12:38:18 10.243.0.116 [ 2004.469650] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:38:18 10.243.0.116 [ 2004.478924]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:38:18 10.243.0.116 [ 2004.681952] irq event stamp: 23654
Dec  2 12:38:18 10.243.0.116 [ 2004.705331] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:38:18 10.243.0.116 [ 2004.730286] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:38:18 10.243.0.116 [ 2004.755211] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:38:18 10.243.0.116 [ 2004.780218] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:38:18 10.243.0.116 [ 2004.805436] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:38:18 10.243.0.116 [ 2004.831372] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:38:18 10.243.0.116 [ 2004.857397] IRQ stage: Linux
Dec  2 12:38:18 10.243.0.116 [ 2004.882945] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:38:18 10.243.0.116 [ 2004.908295] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:38:18 10.243.0.116 [ 2004.934098] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:38:18 10.243.0.116 [ 2004.989441] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.018434] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.047597] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.076996] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.105923] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.135182] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.167057] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:38:18 10.243.0.116 [ 2005.197851] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:38:19 10.243.0.116 [ 2005.227899] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:38:19 10.243.0.116 [ 2005.258724] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:38:19 10.243.0.116 [ 2005.289997] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:38:19 10.243.0.116 [ 2005.321112] Call Trace:
Dec  2 12:38:19 10.243.0.116 [ 2005.352747]  <IRQ>
Dec  2 12:38:19 10.243.0.116 [ 2005.383429]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:38:19 10.243.0.116 [ 2005.416074]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:38:19 10.243.0.116 [ 2005.447140]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:38:19 10.243.0.116 [ 2005.478381]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:38:19 10.243.0.116 [ 2005.509129]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:38:19 10.243.0.116 [ 2005.539900]  ? do_irq_inband+0x2f/0x40
Dec  2 12:38:19 10.243.0.116 [ 2005.570378]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:38:19 10.243.0.116 [ 2005.601157]  </IRQ>
Dec  2 12:38:19 10.243.0.116 [ 2005.631146]  <TASK>
Dec  2 12:38:19 10.243.0.116 [ 2005.661412]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:38:19 10.243.0.116 [ 2005.693687]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:38:19 10.243.0.116 [ 2005.724231]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:38:19 10.243.0.116 [ 2005.754697]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:38:19 10.243.0.116 [ 2005.785126]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:38:19 10.243.0.116 [ 2005.815135]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:38:19 10.243.0.116 [ 2005.844352]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:38:19 10.243.0.116 [ 2005.873421]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:38:19 10.243.0.116 [ 2005.903113]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:38:19 10.243.0.116 [ 2005.931790]  ? =
smp_call_function_single+0x110/0x210
Dec  2 12:38:19 10.243.0.116 [ 2005.960105]  ? 0xffffffffc0b38099
Dec  2 12:38:19 10.243.0.116 [ 2005.987507]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:38:19 10.243.0.116 [ 2006.015303]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:38:19 10.243.0.116 [ 2006.042180]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:38:19 10.243.0.116 [ 2006.069846]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:38:19 10.243.0.116 [ 2006.097291]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:38:19 10.243.0.116 [ 2006.124300]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:38:19 10.243.0.116 [ 2006.150269]  ? =
process_one_work+0x525/0xa30
Dec  2 12:38:19 10.243.0.116 [ 2006.176587]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:38:19 10.243.0.116 [ 2006.205797]  ? =
process_one_work+0x5/0xa30
Dec  2 12:38:20 10.243.0.116 [ 2006.231419]  ? worker_thread+0x57/0x590
Dec  2 12:38:20 10.243.0.116 [ 2006.256884]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:38:20 10.243.0.116 [ 2006.282006]  ? kthread+0x1f3/0x220
Dec  2 12:38:20 10.243.0.116 [ 2006.307148]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:38:20 10.243.0.116 [ 2006.331156]  ? ret_from_fork+0x22/0x30
Dec  2 12:38:20 10.243.0.116 [ 2006.354369]  </TASK>
Dec  2 12:38:30 10.243.0.116 [ 2016.448433] watchdog: BUG: soft lockup - =
CPU#0 stuck for 283s! [TxStartup:3574]
Dec  2 12:38:30 10.243.0.116 [ 2016.481648] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:38:30 10.243.0.116 [ 2016.495055]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:38:30 10.243.0.116 [ 2016.802972] irq event stamp: 24564
Dec  2 12:38:30 10.243.0.116 [ 2016.837112] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:38:30 10.243.0.116 [ 2016.873498] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:38:30 10.243.0.116 [ 2016.909962] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:38:30 10.243.0.116 [ 2016.946665] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:38:30 10.243.0.116 [ 2016.983174] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:38:30 10.243.0.116 [ 2017.021006] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:38:30 10.243.0.116 [ 2017.058682] IRQ stage: Linux
Dec  2 12:38:30 10.243.0.116 [ 2017.095147] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:38:30 10.243.0.116 [ 2017.132365] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:38:31 10.243.0.116 [ 2017.212507] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000287 ORIG_RAX: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.254418] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.296412] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.338433] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.380581] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.422826] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.465061] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.507853] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:38:31 10.243.0.116 [ 2017.550368] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:38:31 10.243.0.116 [ 2017.593586] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:38:31 10.243.0.116 [ 2017.637571] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:38:31 10.243.0.116 [ 2017.681765] Call Trace:
Dec  2 12:38:31 10.243.0.116 [ 2017.724913]  <IRQ>
Dec  2 12:38:31 10.243.0.116 [ 2017.767999]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:38:31 10.243.0.116 [ 2017.812204]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:38:31 10.243.0.116 [ 2017.855972]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:38:31 10.243.0.116 [ 2017.899870]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:38:31 10.243.0.116 [ 2017.943316]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:38:31 10.243.0.116 [ 2017.987103]  ? do_irq_inband+0x2f/0x40
Dec  2 12:38:31 10.243.0.116 [ 2018.030390]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:38:31 10.243.0.116 [ 2018.073792]  </IRQ>
Dec  2 12:38:31 10.243.0.116 [ 2018.116430]  <TASK>
Dec  2 12:38:31 10.243.0.116 [ 2018.159197]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:38:32 10.243.0.116 [ 2018.203351]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:38:32 10.243.0.116 [ 2018.246629]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:38:32 10.243.0.116 [ 2018.289892]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:38:32 10.243.0.116 [ 2018.333481]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:38:32 10.243.0.116 [ 2018.376213]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:38:32 10.243.0.116 [ 2018.418212]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:38:32 10.243.0.116 [ 2018.460880]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:38:32 10.243.0.116 [ 2018.502596]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:38:32 10.243.0.116 [ 2018.543650]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:38:32 10.243.0.116 [ 2018.584105]  ? leave_mm+0x40/0x40
Dec  2 12:38:32 10.243.0.116 [ 2018.623640]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:38:32 10.243.0.116 [ 2018.662997]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:38:32 10.243.0.116 [ 2018.701747]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:38:32 10.243.0.116 [ 2018.740219]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:38:32 10.243.0.116 [ 2018.778401]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:38:32 10.243.0.116 [ 2018.818224]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:38:32 10.243.0.116 [ 2018.855649]  ? 0xffffffffc0b38099
Dec  2 12:38:32 10.243.0.116 [ 2018.892684]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:38:32 10.243.0.116 [ 2018.929924]  ? =
change_protection+0x50/0x90
Dec  2 12:38:32 10.243.0.116 [ 2018.966241]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:38:32 10.243.0.116 [ 2019.002703]  ? =
change_protection+0x90/0x90
Dec  2 12:38:32 10.243.0.116 [ 2019.038318]  ? mprotect_fixup+0x5/0x490
Dec  2 12:38:32 10.243.0.116 [ 2019.074335]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:38:32 10.243.0.116 [ 2019.108837]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:38:32 10.243.0.116 [ 2019.140926]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:38:32 10.243.0.116 [ 2019.173404]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:38:33 10.243.0.116 [ 2019.205056]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:38:33 10.243.0.116 [ 2019.236399]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:38:33 10.243.0.116 [ 2019.269453]  </TASK>
Dec  2 12:38:46 10.243.0.116 [ 2032.448271] watchdog: BUG: soft lockup - =
CPU#2 stuck for 123s! [kworker/2:2:259]
Dec  2 12:38:46 10.243.0.116 [ 2032.471456] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:38:46 10.243.0.116 [ 2032.480906]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:38:46 10.243.0.116 [ 2032.688557] irq event stamp: 23654
Dec  2 12:38:46 10.243.0.116 [ 2032.712383] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:38:46 10.243.0.116 [ 2032.737423] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:38:46 10.243.0.116 [ 2032.762756] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:38:46 10.243.0.116 [ 2032.788209] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:38:46 10.243.0.116 [ 2032.813367] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:38:46 10.243.0.116 [ 2032.839324] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:38:46 10.243.0.116 [ 2032.865657] IRQ stage: Linux
Dec  2 12:38:46 10.243.0.116 [ 2032.890811] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:38:46 10.243.0.116 [ 2032.916478] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:38:46 10.243.0.116 [ 2032.943323] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:38:46 10.243.0.116 [ 2032.999052] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.028069] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.057407] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.086414] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.115474] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.145306] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:38:46 10.243.0.116 [ 2033.174851] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:38:47 10.243.0.116 [ 2033.204688] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:38:47 10.243.0.116 [ 2033.234293] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:38:47 10.243.0.116 [ 2033.264957] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:38:47 10.243.0.116 [ 2033.295499] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:38:47 10.243.0.116 [ 2033.326362] Call Trace:
Dec  2 12:38:47 10.243.0.116 [ 2033.356394]  <IRQ>
Dec  2 12:38:47 10.243.0.116 [ 2033.386713]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:38:47 10.243.0.116 [ 2033.417675]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:38:47 10.243.0.116 [ 2033.449274]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:38:47 10.243.0.116 [ 2033.480308]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:38:47 10.243.0.116 [ 2033.510448]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:38:47 10.243.0.116 [ 2033.541155]  ? do_irq_inband+0x2f/0x40
Dec  2 12:38:47 10.243.0.116 [ 2033.571516]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:38:47 10.243.0.116 [ 2033.601974]  </IRQ>
Dec  2 12:38:47 10.243.0.116 [ 2033.631929]  <TASK>
Dec  2 12:38:47 10.243.0.116 [ 2033.668575]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:38:47 10.243.0.116 [ 2033.706766]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:38:47 10.243.0.116 [ 2033.742236]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:38:47 10.243.0.116 [ 2033.778014]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:38:47 10.243.0.116 [ 2033.814038]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:38:47 10.243.0.116 [ 2033.849252]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:38:47 10.243.0.116 [ 2033.883939]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:38:47 10.243.0.116 [ 2033.918267]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:38:47 10.243.0.116 [ 2033.952426]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:38:47 10.243.0.116 [ 2033.981022]  ? __asan_load4+0x44/0x90
Dec  2 12:38:47 10.243.0.116 [ 2034.009445]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:38:47 10.243.0.116 [ 2034.037307]  ? 0xffffffffc0b38099
Dec  2 12:38:47 10.243.0.116 [ 2034.064484]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:38:47 10.243.0.116 [ 2034.092349]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:38:47 10.243.0.116 [ 2034.118587]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:38:47 10.243.0.116 [ 2034.145459]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:38:47 10.243.0.116 [ 2034.173190]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:38:47 10.243.0.116 [ 2034.199875]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:38:48 10.243.0.116 [ 2034.225646]  ? =
process_one_work+0x525/0xa30
Dec  2 12:38:48 10.243.0.116 [ 2034.251933]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:38:48 10.243.0.116 [ 2034.277454]  ? =
process_one_work+0x5/0xa30
Dec  2 12:38:48 10.243.0.116 [ 2034.303274]  ? worker_thread+0x57/0x590
Dec  2 12:38:48 10.243.0.116 [ 2034.328480]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:38:48 10.243.0.116 [ 2034.353562]  ? kthread+0x1f3/0x220
Dec  2 12:38:48 10.243.0.116 [ 2034.377426]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:38:48 10.243.0.116 [ 2034.400395]  ? ret_from_fork+0x22/0x30
Dec  2 12:38:48 10.243.0.116 [ 2034.424165]  </TASK>
Dec  2 12:38:58 10.243.0.116 [ 2044.448559] watchdog: BUG: soft lockup - =
CPU#0 stuck for 310s! [TxStartup:3574]
Dec  2 12:38:58 10.243.0.116 [ 2044.481973] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:38:58 10.243.0.116 [ 2044.495384]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:38:58 10.243.0.116 [ 2044.802287] irq event stamp: 24564
Dec  2 12:38:58 10.243.0.116 [ 2044.836791] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:38:58 10.243.0.116 [ 2044.873349] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:38:58 10.243.0.116 [ 2044.909991] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:38:58 10.243.0.116 [ 2044.946899] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:38:58 10.243.0.116 [ 2044.983456] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:38:58 10.243.0.116 [ 2045.021303] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:38:58 10.243.0.116 [ 2045.059006] IRQ stage: Linux
Dec  2 12:38:58 10.243.0.116 [ 2045.095537] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:38:58 10.243.0.116 [ 2045.132758] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:38:59 10.243.0.116 [ 2045.213105] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:38:59 10.243.0.116 [ 2045.255163] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:38:59 10.243.0.116 [ 2045.297371] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:38:59 10.243.0.116 [ 2045.341932] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 2045.341932]   Tx Queue             <7>#012[ =
2045.341932]   TDH                  <b7>#012[ 2045.341932]   TDT         =
         <b7>#012[ 2045.341932]   next_to_use          <b7>#012[ =
2045.341932]   next_to_clean        <58>#012[ 2045.341932] =
buffer_info[next_to_clean]#012[ 2045.341932]   time_stamp           =
<1001a2b9e>#012[ 2045.341932]   next_to_watch        =
<0000000099f2880c>#012[ 2045.341932]   jiffies              =
<1001a98fe>#012[ 2045.341932]   desc.status          <180001>
Dec  2 12:38:59 10.243.0.116 [ 2046.106908] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:38:59 10.243.0.116 [ 2046.148531] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:39:00 10.243.0.116 [ 2046.190377] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:39:00 10.243.0.116 [ 2046.232226] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:39:00 10.243.0.116 [ 2046.274785] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:39:00 10.243.0.116 [ 2046.317038] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:39:00 10.243.0.116 [ 2046.360015] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:39:00 10.243.0.116 [ 2046.403613] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:39:00 10.243.0.116 [ 2046.447341] Call Trace:
Dec  2 12:39:00 10.243.0.116 [ 2046.490033]  <IRQ>
Dec  2 12:39:00 10.243.0.116 [ 2046.532902]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:39:00 10.243.0.116 [ 2046.576758]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:39:00 10.243.0.116 [ 2046.620378]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:39:00 10.243.0.116 [ 2046.663430]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:39:00 10.243.0.116 [ 2046.705363]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:39:00 10.243.0.116 [ 2046.747283]  ? do_irq_inband+0x2f/0x40
Dec  2 12:39:00 10.243.0.116 [ 2046.788307]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:39:00 10.243.0.116 [ 2046.828966]  </IRQ>
Dec  2 12:39:00 10.243.0.116 [ 2046.868360]  <TASK>
Dec  2 12:39:00 10.243.0.116 [ 2046.907769]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:39:00 10.243.0.116 [ 2046.948106]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:39:00 10.243.0.116 [ 2046.987021]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:39:00 10.243.0.116 [ 2047.025317]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:39:00 10.243.0.116 [ 2047.063551]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:39:00 10.243.0.116 [ 2047.101173]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:39:00 10.243.0.116 [ 2047.138384]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:39:00 10.243.0.116 [ 2047.176263]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:01 10.243.0.116 [ 2047.213429]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:39:01 10.243.0.116 [ 2047.250086]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:01 10.243.0.116 [ 2047.286270]  ? leave_mm+0x40/0x40
Dec  2 12:39:01 10.243.0.116 [ 2047.321531]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:39:01 10.243.0.116 [ 2047.357103]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:39:01 10.243.0.116 [ 2047.390970]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:39:01 10.243.0.116 [ 2047.423165]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:39:01 10.243.0.116 [ 2047.455372]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:39:01 10.243.0.116 [ 2047.489147]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:39:01 10.243.0.116 [ 2047.520707]  ? 0xffffffffc0b38099
Dec  2 12:39:01 10.243.0.116 [ 2047.551768]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:39:01 10.243.0.116 [ 2047.583130]  ? =
change_protection+0x50/0x90
Dec  2 12:39:01 10.243.0.116 [ 2047.614115]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:39:01 10.243.0.116 [ 2047.645809]  ? =
change_protection+0x90/0x90
Dec  2 12:39:01 10.243.0.116 [ 2047.677157]  ? mprotect_fixup+0x5/0x490
Dec  2 12:39:01 10.243.0.116 [ 2047.709020]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:39:01 10.243.0.116 [ 2047.740960]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:39:01 10.243.0.116 [ 2047.772601]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:39:01 10.243.0.116 [ 2047.804697]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:39:01 10.243.0.116 [ 2047.836395]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:39:01 10.243.0.116 [ 2047.867909]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:39:01 10.243.0.116 [ 2047.900943]  </TASK>
Dec  2 12:39:14 10.243.0.116 [ 2060.448392] watchdog: BUG: soft lockup - =
CPU#2 stuck for 149s! [kworker/2:2:259]
Dec  2 12:39:14 10.243.0.116 [ 2060.475591] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:39:14 10.243.0.116 [ 2060.486482]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:39:14 10.243.0.116 [ 2060.730068] irq event stamp: 23654
Dec  2 12:39:14 10.243.0.116 [ 2060.758569] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:39:14 10.243.0.116 [ 2060.788809] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:39:14 10.243.0.116 [ 2060.819247] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:39:14 10.243.0.116 [ 2060.850141] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:39:14 10.243.0.116 [ 2060.880299] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:39:14 10.243.0.116 [ 2060.910500] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:39:14 10.243.0.116 [ 2060.941241] IRQ stage: Linux
Dec  2 12:39:14 10.243.0.116 [ 2060.970686] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:39:14 10.243.0.116 [ 2061.000770] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:39:14 10.243.0.116 [ 2061.031233] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:39:14 10.243.0.116 [ 2061.097685] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000212 ORIG_RAX: 0000000000000000
Dec  2 12:39:14 10.243.0.116 [ 2061.132281] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:39:14 10.243.0.116 [ 2061.167173] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.200725] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.235143] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.270298] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.305262] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.340219] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:39:15 10.243.0.116 [ 2061.375425] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:39:15 10.243.0.116 [ 2061.410750] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:39:15 10.243.0.116 [ 2061.446647] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:39:15 10.243.0.116 [ 2061.483639] Call Trace:
Dec  2 12:39:15 10.243.0.116 [ 2061.519200]  <IRQ>
Dec  2 12:39:15 10.243.0.116 [ 2061.555338]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:39:15 10.243.0.116 [ 2061.591578]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:39:15 10.243.0.116 [ 2061.628584]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:39:15 10.243.0.116 [ 2061.665510]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:39:15 10.243.0.116 [ 2061.701603]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:39:15 10.243.0.116 [ 2061.737600]  ? do_irq_inband+0x2f/0x40
Dec  2 12:39:15 10.243.0.116 [ 2061.773420]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:39:15 10.243.0.116 [ 2061.809606]  </IRQ>
Dec  2 12:39:15 10.243.0.116 [ 2061.844564]  <TASK>
Dec  2 12:39:15 10.243.0.116 [ 2061.880756]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:39:15 10.243.0.116 [ 2061.917441]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:39:15 10.243.0.116 [ 2061.953222]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:39:15 10.243.0.116 [ 2061.988742]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:39:15 10.243.0.116 [ 2062.024044]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:39:15 10.243.0.116 [ 2062.060520]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:39:15 10.243.0.116 [ 2062.095276]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:39:15 10.243.0.116 [ 2062.129138]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:39:15 10.243.0.116 [ 2062.162561]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:39:15 10.243.0.116 [ 2062.196576]  ? =
smp_call_function_single+0x110/0x210
Dec  2 12:39:16 10.243.0.116 [ 2062.230191]  ? 0xffffffffc0b38099
Dec  2 12:39:16 10.243.0.116 [ 2062.262961]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:39:16 10.243.0.116 [ 2062.296062]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:39:16 10.243.0.116 [ 2062.327694]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:39:16 10.243.0.116 [ 2062.359335]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:39:16 10.243.0.116 [ 2062.392078]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:39:16 10.243.0.116 [ 2062.423516]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:39:16 10.243.0.116 [ 2062.454905]  ? =
process_one_work+0x525/0xa30
Dec  2 12:39:16 10.243.0.116 [ 2062.486606]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:39:16 10.243.0.116 [ 2062.518360]  ? =
process_one_work+0x5/0xa30
Dec  2 12:39:16 10.243.0.116 [ 2062.548595]  ? worker_thread+0x57/0x590
Dec  2 12:39:16 10.243.0.116 [ 2062.578441]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:39:16 10.243.0.116 [ 2062.608470]  ? kthread+0x1f3/0x220
Dec  2 12:39:16 10.243.0.116 [ 2062.637626]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:39:16 10.243.0.116 [ 2062.665706]  ? ret_from_fork+0x22/0x30
Dec  2 12:39:16 10.243.0.116 [ 2062.693597]  </TASK>
Dec  2 12:39:26 10.243.0.116 [ 2072.448680] watchdog: BUG: soft lockup - =
CPU#0 stuck for 336s! [TxStartup:3574]
Dec  2 12:39:26 10.243.0.116 [ 2072.481782] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:39:26 10.243.0.116 [ 2072.495188]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:39:26 10.243.0.116 [ 2072.803831] irq event stamp: 24564
Dec  2 12:39:26 10.243.0.116 [ 2072.838075] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:39:26 10.243.0.116 [ 2072.874564] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:39:26 10.243.0.116 [ 2072.911128] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:39:26 10.243.0.116 [ 2072.947950] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:39:26 10.243.0.116 [ 2072.984461] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:39:26 10.243.0.116 [ 2073.022321] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:39:26 10.243.0.116 [ 2073.059945] IRQ stage: Linux
Dec  2 12:39:26 10.243.0.116 [ 2073.096349] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:39:26 10.243.0.116 [ 2073.133564] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:39:27 10.243.0.116 [ 2073.213832] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.255849] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.297994] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.340130] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.382397] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.424648] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.466940] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.509838] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:39:27 10.243.0.116 [ 2073.552453] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:39:27 10.243.0.116 [ 2073.595831] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:39:27 10.243.0.116 [ 2073.639918] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:39:27 10.243.0.116 [ 2073.684143] Call Trace:
Dec  2 12:39:27 10.243.0.116 [ 2073.727390]  <IRQ>
Dec  2 12:39:27 10.243.0.116 [ 2073.770643]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:39:27 10.243.0.116 [ 2073.814956]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:39:27 10.243.0.116 [ 2073.858829]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:39:27 10.243.0.116 [ 2073.902834]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:39:27 10.243.0.116 [ 2073.946324]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:39:27 10.243.0.116 [ 2073.990214]  ? do_irq_inband+0x2f/0x40
Dec  2 12:39:27 10.243.0.116 [ 2074.033559]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:39:27 10.243.0.116 [ 2074.077073]  </IRQ>
Dec  2 12:39:27 10.243.0.116 [ 2074.119560]  <TASK>
Dec  2 12:39:27 10.243.0.116 [ 2074.162223]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:39:28 10.243.0.116 [ 2074.206215]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:39:28 10.243.0.116 [ 2074.249379]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:39:28 10.243.0.116 [ 2074.292542]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:39:28 10.243.0.116 [ 2074.336084]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:39:28 10.243.0.116 [ 2074.378759]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:39:28 10.243.0.116 [ 2074.420644]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:39:28 10.243.0.116 [ 2074.463214]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:28 10.243.0.116 [ 2074.504766]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:39:28 10.243.0.116 [ 2074.545654]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:28 10.243.0.116 [ 2074.585941]  ? leave_mm+0x40/0x40
Dec  2 12:39:28 10.243.0.116 [ 2074.625301]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:39:28 10.243.0.116 [ 2074.664598]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:39:28 10.243.0.116 [ 2074.703284]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:39:28 10.243.0.116 [ 2074.741707]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:39:28 10.243.0.116 [ 2074.779837]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:39:28 10.243.0.116 [ 2074.819603]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:39:28 10.243.0.116 [ 2074.856966]  ? 0xffffffffc0b38099
Dec  2 12:39:28 10.243.0.116 [ 2074.893950]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:39:28 10.243.0.116 [ 2074.931179]  ? =
change_protection+0x50/0x90
Dec  2 12:39:28 10.243.0.116 [ 2074.967496]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:39:28 10.243.0.116 [ 2075.004032]  ? =
change_protection+0x90/0x90
Dec  2 12:39:28 10.243.0.116 [ 2075.039649]  ? mprotect_fixup+0x5/0x490
Dec  2 12:39:28 10.243.0.116 [ 2075.075605]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:39:28 10.243.0.116 [ 2075.110053]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:39:28 10.243.0.116 [ 2075.142030]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:39:28 10.243.0.116 [ 2075.174378]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:39:29 10.243.0.116 [ 2075.205924]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:39:29 10.243.0.116 [ 2075.237209]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:39:29 10.243.0.116 [ 2075.270326]  </TASK>
Dec  2 12:39:42 10.243.0.116 [ 2088.448629] watchdog: BUG: soft lockup - =
CPU#2 stuck for 176s! [kworker/2:2:259]
Dec  2 12:39:42 10.243.0.116 [ 2088.475352] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:39:42 10.243.0.116 [ 2088.486572]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:39:42 10.243.0.116 [ 2088.730631] irq event stamp: 23654
Dec  2 12:39:42 10.243.0.116 [ 2088.758626] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:39:42 10.243.0.116 [ 2088.787936] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:39:42 10.243.0.116 [ 2088.817621] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:39:42 10.243.0.116 [ 2088.847524] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:39:42 10.243.0.116 [ 2088.877312] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:39:42 10.243.0.116 [ 2088.909046] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:39:42 10.243.0.116 [ 2088.940060] IRQ stage: Linux
Dec  2 12:39:42 10.243.0.116 [ 2088.970322] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:39:42 10.243.0.116 [ 2089.001487] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:39:42 10.243.0.116 [ 2089.031748] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:39:42 10.243.0.116 [ 2089.097870] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:39:42 10.243.0.116 [ 2089.132269] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:39:42 10.243.0.116 [ 2089.167738] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.202163] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.236901] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.272330] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.307390] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.342680] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:39:43 10.243.0.116 [ 2089.377828] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:39:43 10.243.0.116 [ 2089.413995] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:39:43 10.243.0.116 [ 2089.450145] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:39:43 10.243.0.116 [ 2089.486639] Call Trace:
Dec  2 12:39:43 10.243.0.116 [ 2089.522001]  <IRQ>
Dec  2 12:39:43 10.243.0.116 [ 2089.558066]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:39:43 10.243.0.116 [ 2089.594642]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:39:43 10.243.0.116 [ 2089.630634]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:39:43 10.243.0.116 [ 2089.668391]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:39:43 10.243.0.116 [ 2089.705655]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:39:43 10.243.0.116 [ 2089.741436]  ? do_irq_inband+0x2f/0x40
Dec  2 12:39:43 10.243.0.116 [ 2089.777024]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:39:43 10.243.0.116 [ 2089.812928]  </IRQ>
Dec  2 12:39:43 10.243.0.116 [ 2089.847781]  <TASK>
Dec  2 12:39:43 10.243.0.116 [ 2089.883618]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:39:43 10.243.0.116 [ 2089.920096]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:39:43 10.243.0.116 [ 2089.956060]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:39:43 10.243.0.116 [ 2089.991818]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:39:43 10.243.0.116 [ 2090.027497]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:39:43 10.243.0.116 [ 2090.062693]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:39:43 10.243.0.116 [ 2090.098887]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:39:43 10.243.0.116 [ 2090.133472]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:39:43 10.243.0.116 [ 2090.167668]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:39:44 10.243.0.116 [ 2090.201348]  ? =
smp_call_function_single+0x110/0x210
Dec  2 12:39:44 10.243.0.116 [ 2090.234913]  ? 0xffffffffc0b38099
Dec  2 12:39:44 10.243.0.116 [ 2090.267447]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:39:44 10.243.0.116 [ 2090.299797]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:39:44 10.243.0.116 [ 2090.331452]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:39:44 10.243.0.116 [ 2090.362830]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:39:44 10.243.0.116 [ 2090.395518]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:39:44 10.243.0.116 [ 2090.426866]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:39:44 10.243.0.116 [ 2090.458175]  ? =
process_one_work+0x525/0xa30
Dec  2 12:39:44 10.243.0.116 [ 2090.488716]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:39:44 10.243.0.116 [ 2090.521548] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 2090.521548]   Tx Queue             <7>#012[ =
2090.521548]   TDH                  <a2>#012[ 2090.521548]   TDT         =
         <a2>#012[ 2090.521548]   next_to_use          <a2>#012[ =
2090.521548]   next_to_clean        <37>#012[ 2090.521548] =
buffer_info[next_to_clean]#012[ 2090.521548]   time_stamp           =
<1001b065e>#012[ 2090.521548]   next_to_watch        =
<00000000a47c25ef>#012[ 2090.521548]   jiffies              =
<1001b4cf7>#012[ 2090.521548]   desc.status          <200001>
Dec  2 12:39:44 10.243.0.116 [ 2091.049899]  ? =
process_one_work+0x5/0xa30
Dec  2 12:39:44 10.243.0.116 [ 2091.075135]  ? worker_thread+0x57/0x590
Dec  2 12:39:44 10.243.0.116 [ 2091.100541]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:39:44 10.243.0.116 [ 2091.124625]  ? kthread+0x1f3/0x220
Dec  2 12:39:44 10.243.0.116 [ 2091.148587]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:39:44 10.243.0.116 [ 2091.172035]  ? ret_from_fork+0x22/0x30
Dec  2 12:39:44 10.243.0.116 [ 2091.196708]  </TASK>
Dec  2 12:39:54 10.243.0.116 [ 2100.448815] watchdog: BUG: soft lockup - =
CPU#0 stuck for 362s! [TxStartup:3574]
Dec  2 12:39:54 10.243.0.116 [ 2100.478530] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:39:54 10.243.0.116 [ 2100.491938]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:39:54 10.243.0.116 [ 2100.778576] irq event stamp: 24564
Dec  2 12:39:54 10.243.0.116 [ 2100.812244] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:39:54 10.243.0.116 [ 2100.848101] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:39:54 10.243.0.116 [ 2100.884023] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:39:54 10.243.0.116 [ 2100.920047] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:39:54 10.243.0.116 [ 2100.955649] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:39:54 10.243.0.116 [ 2100.992638] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:39:54 10.243.0.116 [ 2101.029393] IRQ stage: Linux
Dec  2 12:39:54 10.243.0.116 [ 2101.065010] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:39:54 10.243.0.116 [ 2101.101248] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:39:54 10.243.0.116 [ 2101.179784] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000293 ORIG_RAX: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.221019] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.262269] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.303492] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.344652] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.386037] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.427404] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.469491] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:39:55 10.243.0.116 [ 2101.511268] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:39:55 10.243.0.116 [ 2101.553907] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:39:55 10.243.0.116 [ 2101.597049] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:39:55 10.243.0.116 [ 2101.640484] Call Trace:
Dec  2 12:39:55 10.243.0.116 [ 2101.683117]  <IRQ>
Dec  2 12:39:55 10.243.0.116 [ 2101.725983]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:39:55 10.243.0.116 [ 2101.770084]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:39:55 10.243.0.116 [ 2101.814028]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:39:55 10.243.0.116 [ 2101.858141]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:39:55 10.243.0.116 [ 2101.901590]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:39:55 10.243.0.116 [ 2101.945384]  ? do_irq_inband+0x2f/0x40
Dec  2 12:39:55 10.243.0.116 [ 2101.988805]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:39:55 10.243.0.116 [ 2102.032320]  </IRQ>
Dec  2 12:39:55 10.243.0.116 [ 2102.074990]  <TASK>
Dec  2 12:39:55 10.243.0.116 [ 2102.117878]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:39:55 10.243.0.116 [ 2102.162145]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:39:56 10.243.0.116 [ 2102.205659]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:39:56 10.243.0.116 [ 2102.249046]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:39:56 10.243.0.116 [ 2102.292811]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:39:56 10.243.0.116 [ 2102.335687]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:39:56 10.243.0.116 [ 2102.377800]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:39:56 10.243.0.116 [ 2102.420525]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:56 10.243.0.116 [ 2102.462312]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:39:56 10.243.0.116 [ 2102.503432]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:39:56 10.243.0.116 [ 2102.543940]  ? leave_mm+0x40/0x40
Dec  2 12:39:56 10.243.0.116 [ 2102.583522]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:39:56 10.243.0.116 [ 2102.623035]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:39:56 10.243.0.116 [ 2102.662000]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:39:56 10.243.0.116 [ 2102.700752]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:39:56 10.243.0.116 [ 2102.739204]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:39:56 10.243.0.116 [ 2102.779304]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:39:56 10.243.0.116 [ 2102.816984]  ? 0xffffffffc0b38099
Dec  2 12:39:56 10.243.0.116 [ 2102.854285]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:39:56 10.243.0.116 [ 2102.891782]  ? =
change_protection+0x50/0x90
Dec  2 12:39:56 10.243.0.116 [ 2102.928355]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:39:56 10.243.0.116 [ 2102.965099]  ? =
change_protection+0x90/0x90
Dec  2 12:39:56 10.243.0.116 [ 2103.000868]  ? mprotect_fixup+0x5/0x490
Dec  2 12:39:56 10.243.0.116 [ 2103.037083]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:39:56 10.243.0.116 [ 2103.071741]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:39:56 10.243.0.116 [ 2103.103817]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:39:56 10.243.0.116 [ 2103.136229]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:39:56 10.243.0.116 [ 2103.167825]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:39:56 10.243.0.116 [ 2103.199202]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:39:57 10.243.0.116 [ 2103.232352]  </TASK>
Dec  2 12:40:10 10.243.0.116 [ 2116.448664] watchdog: BUG: soft lockup - =
CPU#2 stuck for 202s! [kworker/2:2:259]
Dec  2 12:40:10 10.243.0.116 [ 2116.472238] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:40:10 10.243.0.116 [ 2116.481515]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:40:10 10.243.0.116 [ 2116.690576] irq event stamp: 23654
Dec  2 12:40:10 10.243.0.116 [ 2116.714282] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:40:10 10.243.0.116 [ 2116.739381] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:40:10 10.243.0.116 [ 2116.764607] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:40:10 10.243.0.116 [ 2116.789853] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:40:10 10.243.0.116 [ 2116.815610] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:40:10 10.243.0.116 [ 2116.843038] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:40:10 10.243.0.116 [ 2116.873343] IRQ stage: Linux
Dec  2 12:40:10 10.243.0.116 [ 2116.902852] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:40:10 10.243.0.116 [ 2116.933088] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:40:10 10.243.0.116 [ 2116.963553] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:40:10 10.243.0.116 [ 2117.030373] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:40:10 10.243.0.116 [ 2117.065225] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:40:10 10.243.0.116 [ 2117.101015] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:40:10 10.243.0.116 [ 2117.135637] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:40:10 10.243.0.116 [ 2117.169933] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:40:11 10.243.0.116 [ 2117.204701] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:40:11 10.243.0.116 [ 2117.239608] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:40:11 10.243.0.116 [ 2117.274729] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:40:11 10.243.0.116 [ 2117.309287] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:40:11 10.243.0.116 [ 2117.344779] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:40:11 10.243.0.116 [ 2117.380910] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:40:11 10.243.0.116 [ 2117.416836] Call Trace:
Dec  2 12:40:11 10.243.0.116 [ 2117.452955]  <IRQ>
Dec  2 12:40:11 10.243.0.116 [ 2117.488345]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:40:11 10.243.0.116 [ 2117.524823]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:40:11 10.243.0.116 [ 2117.561380]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:40:11 10.243.0.116 [ 2117.597261]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:40:11 10.243.0.116 [ 2117.634103]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:40:11 10.243.0.116 [ 2117.669282]  ? do_irq_inband+0x2f/0x40
Dec  2 12:40:11 10.243.0.116 [ 2117.705035]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:40:11 10.243.0.116 [ 2117.740104]  </IRQ>
Dec  2 12:40:11 10.243.0.116 [ 2117.774863]  <TASK>
Dec  2 12:40:11 10.243.0.116 [ 2117.809975]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:40:11 10.243.0.116 [ 2117.845972]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:40:11 10.243.0.116 [ 2117.881950]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:40:11 10.243.0.116 [ 2117.917238]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:40:11 10.243.0.116 [ 2117.952517]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:40:11 10.243.0.116 [ 2117.986932]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:40:11 10.243.0.116 [ 2118.021173]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:40:11 10.243.0.116 [ 2118.055060]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:40:11 10.243.0.116 [ 2118.088745]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:40:11 10.243.0.116 [ 2118.121946]  ? __asan_load4+0x1/0x90
Dec  2 12:40:11 10.243.0.116 [ 2118.155217]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:40:11 10.243.0.116 [ 2118.188678]  ? 0xffffffffc0b38099
Dec  2 12:40:12 10.243.0.116 [ 2118.221441]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:40:12 10.243.0.116 [ 2118.254434]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:40:12 10.243.0.116 [ 2118.285958]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:40:12 10.243.0.116 [ 2118.317541]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:40:12 10.243.0.116 [ 2118.349629]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:40:12 10.243.0.116 [ 2118.380715]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:40:12 10.243.0.116 [ 2118.410933]  ? =
process_one_work+0x525/0xa30
Dec  2 12:40:12 10.243.0.116 [ 2118.441787]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:40:12 10.243.0.116 [ 2118.472037]  ? =
process_one_work+0x5/0xa30
Dec  2 12:40:12 10.243.0.116 [ 2118.502451]  ? worker_thread+0x57/0x590
Dec  2 12:40:12 10.243.0.116 [ 2118.531697]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:40:12 10.243.0.116 [ 2118.561546]  ? kthread+0x1f3/0x220
Dec  2 12:40:12 10.243.0.116 [ 2118.589568]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:40:12 10.243.0.116 [ 2118.616472]  ? ret_from_fork+0x22/0x30
Dec  2 12:40:12 10.243.0.116 [ 2118.644962]  </TASK>
Dec  2 12:40:22 10.243.0.116 [ 2128.448943] watchdog: BUG: soft lockup - =
CPU#0 stuck for 388s! [TxStartup:3574]
Dec  2 12:40:22 10.243.0.116 [ 2128.482213] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:40:22 10.243.0.116 [ 2128.495619]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:40:22 10.243.0.116 [ 2128.802341] irq event stamp: 24564
Dec  2 12:40:22 10.243.0.116 [ 2128.836839] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:40:22 10.243.0.116 [ 2128.873513] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:40:22 10.243.0.116 [ 2128.910272] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:40:22 10.243.0.116 [ 2128.947353] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:40:22 10.243.0.116 [ 2128.984026] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:40:22 10.243.0.116 [ 2129.022043] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:40:22 10.243.0.116 [ 2129.059965] IRQ stage: Linux
Dec  2 12:40:22 10.243.0.116 [ 2129.096715] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:40:22 10.243.0.116 [ 2129.134206] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:40:23 10.243.0.116 [ 2129.215161] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.257476] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.299779] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.342076] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.384559] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.427209] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.469768] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.512868] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:40:23 10.243.0.116 [ 2129.555639] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:40:23 10.243.0.116 [ 2129.599174] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:40:23 10.243.0.116 [ 2129.643299] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:40:23 10.243.0.116 [ 2129.687572] Call Trace:
Dec  2 12:40:23 10.243.0.116 [ 2129.730861]  <IRQ>
Dec  2 12:40:23 10.243.0.116 [ 2129.774150]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:40:23 10.243.0.116 [ 2129.818511]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:40:23 10.243.0.116 [ 2129.862419]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:40:23 10.243.0.116 [ 2129.906530]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:40:23 10.243.0.116 [ 2129.950058]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:40:23 10.243.0.116 [ 2129.993931]  ? do_irq_inband+0x2f/0x40
Dec  2 12:40:23 10.243.0.116 [ 2130.037311]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:40:23 10.243.0.116 [ 2130.080809]  </IRQ>
Dec  2 12:40:23 10.243.0.116 [ 2130.123341]  <TASK>
Dec  2 12:40:23 10.243.0.116 [ 2130.166162]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:40:24 10.243.0.116 [ 2130.210255]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:40:24 10.243.0.116 [ 2130.253415]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:40:24 10.243.0.116 [ 2130.296562]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:40:24 10.243.0.116 [ 2130.340085]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:40:24 10.243.0.116 [ 2130.382620]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:40:24 10.243.0.116 [ 2130.424448]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:40:24 10.243.0.116 [ 2130.466895]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:40:24 10.243.0.116 [ 2130.508458]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:40:24 10.243.0.116 [ 2130.549349]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:40:24 10.243.0.116 [ 2130.589573]  ? leave_mm+0x40/0x40
Dec  2 12:40:24 10.243.0.116 [ 2130.628875]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:40:24 10.243.0.116 [ 2130.668113]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:40:24 10.243.0.116 [ 2130.706794]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:40:24 10.243.0.116 [ 2130.745218]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:40:24 10.243.0.116 [ 2130.783351]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:40:24 10.243.0.116 [ 2130.823114]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:40:24 10.243.0.116 [ 2130.860478]  ? 0xffffffffc0b38099
Dec  2 12:40:24 10.243.0.116 [ 2130.897447]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:40:24 10.243.0.116 [ 2130.934684]  ? =
change_protection+0x50/0x90
Dec  2 12:40:24 10.243.0.116 [ 2130.971000]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:40:24 10.243.0.116 [ 2131.007411]  ? =
change_protection+0x90/0x90
Dec  2 12:40:24 10.243.0.116 [ 2131.042978]  ? mprotect_fixup+0x5/0x490
Dec  2 12:40:24 10.243.0.116 [ 2131.078940]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:40:24 10.243.0.116 [ 2131.113390]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:40:24 10.243.0.116 [ 2131.145371]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:40:24 10.243.0.116 [ 2131.177723]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:40:25 10.243.0.116 [ 2131.209322]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:40:25 10.243.0.116 [ 2131.240653]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:40:25 10.243.0.116 [ 2131.273701]  </TASK>
Dec  2 12:40:38 10.243.0.116 [ 2144.448885] watchdog: BUG: soft lockup - =
CPU#2 stuck for 228s! [kworker/2:2:259]
Dec  2 12:40:38 10.243.0.116 [ 2144.476030] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:40:38 10.243.0.116 [ 2144.486971]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:40:38 10.243.0.116 [ 2144.731633] irq event stamp: 23654
Dec  2 12:40:38 10.243.0.116 [ 2144.759283] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:40:38 10.243.0.116 [ 2144.788919] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:40:38 10.243.0.116 [ 2144.818735] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:40:38 10.243.0.116 [ 2144.848402] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:40:38 10.243.0.116 [ 2144.878814] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:40:38 10.243.0.116 [ 2144.909134] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:40:38 10.243.0.116 [ 2144.939645] IRQ stage: Linux
Dec  2 12:40:38 10.243.0.116 [ 2144.967272] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:40:38 10.243.0.116 [ 2144.993045] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:40:38 10.243.0.116 [ 2145.019251] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:40:38 10.243.0.116 [ 2145.076784] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:40:38 10.243.0.116 [ 2145.106000] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:40:38 10.243.0.116 [ 2145.135196] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.164940] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.195994] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 2145.195994]   Tx Queue             <7>#012[ =
2145.195994]   TDH                  <81>#012[ 2145.195994]   TDT         =
         <81>#012[ 2145.195994]   next_to_use          <81>#012[ =
2145.195994]   next_to_clean        <22>#012[ 2145.195994] =
buffer_info[next_to_clean]#012[ 2145.195994]   time_stamp           =
<1001bb9c9>#012[ 2145.195994]   next_to_watch        =
<000000006e41f2ad>#012[ 2145.195994]   jiffies              =
<1001c2289>#012[ 2145.195994]   desc.status          <184001>
Dec  2 12:40:39 10.243.0.116 [ 2145.705538] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.739949] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.774513] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.810132] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:40:39 10.243.0.116 [ 2145.845403] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:40:39 10.243.0.116 [ 2145.881708] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:40:39 10.243.0.116 [ 2145.918447] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:40:39 10.243.0.116 [ 2145.954316] Call Trace:
Dec  2 12:40:39 10.243.0.116 [ 2145.990151]  <IRQ>
Dec  2 12:40:39 10.243.0.116 [ 2146.025115]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:40:39 10.243.0.116 [ 2146.062417]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:40:39 10.243.0.116 [ 2146.097515]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:40:39 10.243.0.116 [ 2146.132641]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:40:39 10.243.0.116 [ 2146.166511]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:40:40 10.243.0.116 [ 2146.202196]  ? do_irq_inband+0x2f/0x40
Dec  2 12:40:40 10.243.0.116 [ 2146.236678]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:40:40 10.243.0.116 [ 2146.270048]  </IRQ>
Dec  2 12:40:40 10.243.0.116 [ 2146.303312]  <TASK>
Dec  2 12:40:40 10.243.0.116 [ 2146.335917]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:40:40 10.243.0.116 [ 2146.368562]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:40:40 10.243.0.116 [ 2146.399946]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:40:40 10.243.0.116 [ 2146.430861]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:40:40 10.243.0.116 [ 2146.462658]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:40:40 10.243.0.116 [ 2146.488474]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:40:40 10.243.0.116 [ 2146.513800]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:40:40 10.243.0.116 [ 2146.539438]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:40:40 10.243.0.116 [ 2146.564914]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:40:40 10.243.0.116 [ 2146.589891]  ? __asan_store2+0xa0/0xa0
Dec  2 12:40:40 10.243.0.116 [ 2146.614324]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:40:40 10.243.0.116 [ 2146.639044]  ? 0xffffffffc0b38099
Dec  2 12:40:40 10.243.0.116 [ 2146.664836]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:40:40 10.243.0.116 [ 2146.688627]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:40:40 10.243.0.116 [ 2146.710007]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:40:40 10.243.0.116 [ 2146.732444]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:40:40 10.243.0.116 [ 2146.754906]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:40:40 10.243.0.116 [ 2146.776758]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:40:40 10.243.0.116 [ 2146.797838]  ? =
process_one_work+0x525/0xa30
Dec  2 12:40:40 10.243.0.116 [ 2146.819412]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:40:40 10.243.0.116 [ 2146.840962]  ? =
process_one_work+0x5/0xa30
Dec  2 12:40:40 10.243.0.116 [ 2146.862506]  ? worker_thread+0x57/0x590
Dec  2 12:40:40 10.243.0.116 [ 2146.884014]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:40:40 10.243.0.116 [ 2146.905731]  ? kthread+0x1f3/0x220
Dec  2 12:40:40 10.243.0.116 [ 2146.926954]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:40:40 10.243.0.116 [ 2146.950059]  ? ret_from_fork+0x22/0x30
Dec  2 12:40:40 10.243.0.116 [ 2146.977278]  </TASK>
Dec  2 12:40:50 10.243.0.116 [ 2156.449070] watchdog: BUG: soft lockup - =
CPU#0 stuck for 414s! [TxStartup:3574]
Dec  2 12:40:50 10.243.0.116 [ 2156.481983] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:40:50 10.243.0.116 [ 2156.495393]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:40:50 10.243.0.116 [ 2156.799560] irq event stamp: 24564
Dec  2 12:40:50 10.243.0.116 [ 2156.833815] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:40:50 10.243.0.116 [ 2156.870130] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:40:50 10.243.0.116 [ 2156.906486] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:40:50 10.243.0.116 [ 2156.943090] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:40:50 10.243.0.116 [ 2156.979285] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:40:50 10.243.0.116 [ 2157.016825] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:40:50 10.243.0.116 [ 2157.054296] IRQ stage: Linux
Dec  2 12:40:50 10.243.0.116 [ 2157.090530] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:40:50 10.243.0.116 [ 2157.127512] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:40:51 10.243.0.116 [ 2157.207540] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000283 ORIG_RAX: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.249500] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.291551] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.333595] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.375819] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.418278] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.460581] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.503492] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:40:51 10.243.0.116 [ 2157.546156] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:40:51 10.243.0.116 [ 2157.589617] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:40:51 10.243.0.116 [ 2157.633717] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:40:51 10.243.0.116 [ 2157.677966] Call Trace:
Dec  2 12:40:51 10.243.0.116 [ 2157.721222]  <IRQ>
Dec  2 12:40:51 10.243.0.116 [ 2157.764537]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:40:51 10.243.0.116 [ 2157.808917]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:40:51 10.243.0.116 [ 2157.852856]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:40:51 10.243.0.116 [ 2157.896928]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:40:51 10.243.0.116 [ 2157.940431]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:40:51 10.243.0.116 [ 2157.984332]  ? do_irq_inband+0x2f/0x40
Dec  2 12:40:51 10.243.0.116 [ 2158.027794]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:40:51 10.243.0.116 [ 2158.071377]  </IRQ>
Dec  2 12:40:51 10.243.0.116 [ 2158.114053]  <TASK>
Dec  2 12:40:51 10.243.0.116 [ 2158.156950]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:40:52 10.243.0.116 [ 2158.201285]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:40:52 10.243.0.116 [ 2158.244735]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:40:52 10.243.0.116 [ 2158.288129]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:40:52 10.243.0.116 [ 2158.331899]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:40:52 10.243.0.116 [ 2158.374736]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:40:52 10.243.0.116 [ 2158.416860]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:40:52 10.243.0.116 [ 2158.459689]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:40:52 10.243.0.116 [ 2158.501474]  ? __asan_load4+0x3f/0x90
Dec  2 12:40:52 10.243.0.116 [ 2158.542485]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:40:52 10.243.0.116 [ 2158.583413]  ? leave_mm+0x40/0x40
Dec  2 12:40:52 10.243.0.116 [ 2158.623416]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:40:52 10.243.0.116 [ 2158.663405]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:40:52 10.243.0.116 [ 2158.702779]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:40:52 10.243.0.116 [ 2158.741956]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:40:52 10.243.0.116 [ 2158.780713]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:40:52 10.243.0.116 [ 2158.821114]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:40:52 10.243.0.116 [ 2158.859112]  ? 0xffffffffc0b38099
Dec  2 12:40:52 10.243.0.116 [ 2158.896767]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:40:52 10.243.0.116 [ 2158.934620]  ? =
change_protection+0x50/0x90
Dec  2 12:40:52 10.243.0.116 [ 2158.971564]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:40:52 10.243.0.116 [ 2159.008657]  ? =
change_protection+0x90/0x90
Dec  2 12:40:52 10.243.0.116 [ 2159.044903]  ? mprotect_fixup+0x5/0x490
Dec  2 12:40:52 10.243.0.116 [ 2159.081538]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:40:52 10.243.0.116 [ 2159.116561]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:40:52 10.243.0.116 [ 2159.149112]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:40:52 10.243.0.116 [ 2159.181930]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:40:53 10.243.0.116 [ 2159.213945]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:40:53 10.243.0.116 [ 2159.245698]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:40:53 10.243.0.116 [ 2159.279163]  </TASK>
Dec  2 12:41:06 10.243.0.116 [ 2172.448919] watchdog: BUG: soft lockup - =
CPU#2 stuck for 254s! [kworker/2:2:259]
Dec  2 12:41:06 10.243.0.116 [ 2172.472779] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:41:06 10.243.0.116 [ 2172.481940]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:41:06 10.243.0.116 [ 2172.693098] irq event stamp: 23654
Dec  2 12:41:06 10.243.0.116 [ 2172.717182] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:41:06 10.243.0.116 [ 2172.742865] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:41:06 10.243.0.116 [ 2172.768174] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:41:06 10.243.0.116 [ 2172.794073] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:41:06 10.243.0.116 [ 2172.819870] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:41:06 10.243.0.116 [ 2172.846125] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:06 10.243.0.116 [ 2172.872453] IRQ stage: Linux
Dec  2 12:41:06 10.243.0.116 [ 2172.898319] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:41:06 10.243.0.116 [ 2172.924692] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:41:06 10.243.0.116 [ 2172.950849] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:41:06 10.243.0.116 [ 2173.008828] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000216 ORIG_RAX: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.038096] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.067630] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.096995] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.126351] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.155911] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:41:06 10.243.0.116 [ 2173.185523] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:41:07 10.243.0.116 [ 2173.215510] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:07 10.243.0.116 [ 2173.245034] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:41:07 10.243.0.116 [ 2173.275141] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:07 10.243.0.116 [ 2173.306146] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:07 10.243.0.116 [ 2173.336932] Call Trace:
Dec  2 12:41:07 10.243.0.116 [ 2173.366903]  <IRQ>
Dec  2 12:41:07 10.243.0.116 [ 2173.397045]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:41:07 10.243.0.116 [ 2173.427939]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:41:07 10.243.0.116 [ 2173.458627]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:41:07 10.243.0.116 [ 2173.489188]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:41:07 10.243.0.116 [ 2173.519684]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:41:07 10.243.0.116 [ 2173.550090]  ? do_irq_inband+0x2f/0x40
Dec  2 12:41:07 10.243.0.116 [ 2173.580331]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:41:07 10.243.0.116 [ 2173.612806]  </IRQ>
Dec  2 12:41:07 10.243.0.116 [ 2173.642398]  <TASK>
Dec  2 12:41:07 10.243.0.116 [ 2173.675088]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:41:07 10.243.0.116 [ 2173.703503] rcu: INFO: rcu_sched =
detected stalls on CPUs/tasks:
Dec  2 12:41:07 10.243.0.116 [ 2173.706116]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:41:07 10.243.0.116 [ 2173.737195] rcu: #0115-...0: (1 GPs =
behind) idle=3D78b/1/0x4000000000000002 softirq=3D161154/161154 =
fqs=3D64098
Dec  2 12:41:07 10.243.0.116 [ 2173.767830]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:41:07 10.243.0.116 [ 2173.800157] #011(detected by 7, =
t=3D458269 jiffies, g=3D126833, q=3D20346)
Dec  2 12:41:07 10.243.0.116 [ 2173.830748]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:41:07 10.243.0.116 [ 2173.862046] Sending NMI from CPU 7 to =
CPUs 5:
Dec  2 12:41:07 10.243.0.116 [ 2173.892149]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:41:07 10.243.0.116 [ 2173.922817] NMI backtrace for cpu 5
Dec  2 12:41:07 10.243.0.116 [ 2173.922859] CPU: 5 PID: 3577 Comm: =
DummyTxSample Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:41:07 10.243.0.116 [ 2173.922896] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:07 10.243.0.116 [ 2173.922912] IRQ stage: EVL
Dec  2 12:41:07 10.243.0.116 [ 2173.922932] RIP: =
0010:__asan_load4+0x0/0x90
Dec  2 12:41:07 10.243.0.116 [ 2173.922965] Code: c0 84 c0 75 e1 5d c3 =
cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 0f 1f 44 00 =
00 66 2e 0f 1f 84 00 00 00 00 00 <55> 48 89 e5 48 8b 4d 08 48 83 ff fb =
77 53 48 b8 ff ff ff ff ff 7f
Dec  2 12:41:07 10.243.0.116 [ 2173.922984] RSP: 0018:ffff888137737530 =
EFLAGS: 00000002
Dec  2 12:41:07 10.243.0.116 [ 2173.923016] RAX: 00000000001c0101 RBX: =
ffff888101aae000 RCX: ffffffff8d1abe74
Dec  2 12:41:08 10.243.0.116 [ 2173.923034] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101aae000
Dec  2 12:41:08 10.243.0.116 [ 2173.923051] RBP: ffff888137737618 R08: =
ffffed1020355c01 R09: ffffed1020355c01
Dec  2 12:41:08 10.243.0.116 [ 2173.923068] R10: ffff888101aae003 R11: =
ffffed1020355c00 R12: 1ffff11026ee6eaa
Dec  2 12:41:08 10.243.0.116 [ 2173.923085] R13: 0000000000000000 R14: =
ffff8881377375f0 R15: 0000000000000001
Dec  2 12:41:08 10.243.0.116 [ 2173.923112] FS:  00007f3013fff700(0000) =
GS:ffff88841e480000(0000) knlGS:0000000000000000
Dec  2 12:41:08 10.243.0.116 [ 2173.923131] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:08 10.243.0.116 [ 2173.923149] CR2: 0000000000000070 CR3: =
0000000137d08002 CR4: 00000000003706e0
Dec  2 12:41:08 10.243.0.116 [ 2173.923166] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:08 10.243.0.116 [ 2173.923182] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:08 10.243.0.116 [ 2173.923200] Call Trace:
Dec  2 12:41:08 10.243.0.116 [ 2173.923219]  <TASK>
Dec  2 12:41:08 10.243.0.116 [ 2173.923257]  ? =
native_queued_spin_lock_slowpath+0x194/0x4c0
Dec  2 12:41:08 10.243.0.116 [ 2173.923419]  ? 0xffffffffc0b38099
Dec  2 12:41:08 10.243.0.116 [ 2173.923541]  ? =
trace_function+0x11e/0x180
Dec  2 12:41:08 10.243.0.116 [ 2173.923766]  ? .slowpath+0x1d/0x1d
Dec  2 12:41:08 10.243.0.116 [ 2173.924082]  ? =
do_raw_spin_lock+0xe6/0x1e0
Dec  2 12:41:08 10.243.0.116 [ 2173.924286]  ? =
native_queued_spin_lock_slowpath+0x5/0x4c0
Dec  2 12:41:08 10.243.0.116 [ 2173.924443]  ? 0xffffffffc0b38099
Dec  2 12:41:08 10.243.0.116 [ 2173.924996]  =
do_raw_spin_lock+0x1cb/0x1e0
Dec  2 12:41:08 10.243.0.116 [ 2173.925098]  ? spin_dump+0x90/0x90
Dec  2 12:41:08 10.243.0.116 [ 2173.925320]  ? =
do_raw_spin_lock+0x5/0x1e0
Dec  2 12:41:08 10.243.0.116 [ 2173.925985]  =
evl_switch_inband+0xad/0x7c0
Dec  2 12:41:08 10.243.0.116 [ 2173.926460]  =
handle_oob_trap_entry+0x10a/0x200
Dec  2 12:41:08 10.243.0.116 [ 2173.926915]  __oob_trap_notify+0x3f/0x50
Dec  2 12:41:08 10.243.0.116 [ 2173.927085]  page_fault_oops+0x1e4/0x3d0
Dec  2 12:41:08 10.243.0.116 [ 2173.927155]  ? =
trace_function+0x11e/0x180
Dec  2 12:41:08 10.243.0.116 [ 2173.927220]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:41:08 10.243.0.116 [ 2173.927519]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:41:08 10.243.0.116 [ 2173.927745]  ? =
function_trace_call+0x153/0x1d0
Dec  2 12:41:09 10.243.0.116 [ 2173.927814]  ? =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:41:09 10.243.0.116 [ 2173.927885]  ? =
spurious_kernel_fault+0x200/0x200
Dec  2 12:41:09 10.243.0.116 [ 2173.928128]  ? 0xffffffffc0b38099
Dec  2 12:41:09 10.243.0.116 [ 2173.928591]  ? =
do_user_addr_fault+0xa30/0xa30
Dec  2 12:41:09 10.243.0.116 [ 2173.928905]  ? =
do_user_addr_fault+0x686/0xa30
Dec  2 12:41:09 10.243.0.116 [ 2173.929072]  ? page_fault_oops+0x5/0x3d0
Dec  2 12:41:09 10.243.0.116 [ 2173.929139]  ? exc_page_fault+0x5c/0xe0
Dec  2 12:41:09 10.243.0.116 [ 2173.929718]  =
do_user_addr_fault+0x4af/0xa30
Dec  2 12:41:09 10.243.0.116 [ 2173.929796]  ? =
rcu_read_lock_held_common+0x5/0x70
Dec  2 12:41:09 10.243.0.116 [ 2173.929892]  ? =
rcu_read_lock_held_common+0x2a/0x70
Dec  2 12:41:09 10.243.0.116 [ 2173.930159]  ? =
trace_page_fault_user+0x130/0x130
Dec  2 12:41:09 10.243.0.116 [ 2173.930461]  ? =
fault_in_kernel_space+0x5/0x40
Dec  2 12:41:09 10.243.0.116 [ 2173.931048]  exc_page_fault+0x71/0xe0
Dec  2 12:41:09 10.243.0.116 [ 2173.931288]  =
asm_exc_page_fault+0x27/0x30
Dec  2 12:41:09 10.243.0.116 [ 2173.931366] RIP: =
0010:trace_event_raw_event_evl_sleep_on+0xc3/0x380
Dec  2 12:41:09 10.243.0.116 [ 2173.931438] Code: 80 0f 85 93 02 00 00 =
41 f6 c7 40 0f 85 10 02 00 00 41 f7 c7 00 02 00 00 0f 85 8f 02 00 00 4d =
8d 7d 70 4c 89 ff e8 6d e9 1e 00 <49> 8b 7d 70 48 85 ff 0f 84 2d 02 00 =
00 e8 ab b4 58 00 8d 50 01 83
Dec  2 12:41:09 10.243.0.116 [ 2173.931478] RSP: 0018:ffff888137737aa0 =
EFLAGS: 00010082
Dec  2 12:41:09 10.243.0.116 [ 2173.931545] RAX: 0000000000000001 RBX: =
1ffff11026ee6f5a RCX: ffffffff8d1acefc
Dec  2 12:41:09 10.243.0.116 [ 2173.931583] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffffffff8f2acb40
Dec  2 12:41:09 10.243.0.116 [ 2173.931620] RBP: ffff888137737b78 R08: =
fffffbfff1e55969 R09: fffffbfff1e55969
Dec  2 12:41:09 10.243.0.116 [ 2173.931659] R10: ffffffff8f2acb43 R11: =
fffffbfff1e55968 R12: ffff888100195000
Dec  2 12:41:09 10.243.0.116 [ 2173.931697] R13: 0000000000000000 R14: =
ffffffff8f219d40 R15: 0000000000000070
Dec  2 12:41:09 10.243.0.116 [ 2173.932173]  ? =
do_raw_spin_unlock+0x9c/0x140
Dec  2 12:41:09 10.243.0.116 [ 2173.933102]  ? =
trace_event_raw_event_evl_init_thread+0x330/0x330
Dec  2 12:41:09 10.243.0.116 [ 2173.933345]  ? 0xffffffffc0b38099
Dec  2 12:41:09 10.243.0.116 [ 2173.933467]  ? evl_delay+0x48/0xf0
Dec  2 12:41:09 10.243.0.116 [ 2173.933536]  ? =
evl_sleep_on_locked+0x730/0x730
Dec  2 12:41:09 10.243.0.116 [ 2173.933878]  ? =
__kasan_check_write+0x14/0x20
Dec  2 12:41:09 10.243.0.116 [ 2173.934147]  =
evl_sleep_on_locked+0x629/0x730
Dec  2 12:41:09 10.243.0.116 [ 2173.934215]  ? =
evl_sleep_on_locked+0x5/0x730
Dec  2 12:41:09 10.243.0.116 [ 2173.934937]  evl_sleep_on+0x7b/0xb0
Dec  2 12:41:09 10.243.0.116 [ 2173.935266]  evl_delay+0x48/0xf0
Dec  2 12:41:10 10.243.0.116 [ 2173.935801]  clock_oob_ioctl+0x182/0x2d0
Dec  2 12:41:10 10.243.0.116 [ 2173.935998]  ? =
clock_common_ioctl+0x5e0/0x5e0
Dec  2 12:41:10 10.243.0.116 [ 2173.936166]  ? clock_oob_ioctl+0x5/0x2d0
Dec  2 12:41:10 10.243.0.116 [ 2173.936888]  EVL_ioctl+0x86/0x100
Dec  2 12:41:10 10.243.0.116 [ 2173.937157]  do_oob_syscall+0x5b1/0x6d0
Dec  2 12:41:10 10.243.0.116 [ 2173.937538]  ? =
prepare_for_signal+0x180/0x180
Dec  2 12:41:10 10.243.0.116 [ 2173.937879]  ? do_oob_syscall+0x5/0x6d0
Dec  2 12:41:10 10.243.0.116 [ 2173.937944]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:41:10 10.243.0.116 [ 2173.938277]  =
handle_oob_syscall+0x18e/0x230
Dec  2 12:41:10 10.243.0.116 [ 2173.938736]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 12:41:10 10.243.0.116 [ 2173.939100]  ? =
handle_oob_syscall+0x5/0x230
Dec  2 12:41:10 10.243.0.116 [ 2173.939784]  pipeline_syscall+0xac/0x1c0
Dec  2 12:41:10 10.243.0.116 [ 2173.940092]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 12:41:10 10.243.0.116 [ 2173.940313]  do_syscall_64+0x1d/0xa0
Dec  2 12:41:10 10.243.0.116 [ 2173.940544]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:41:10 10.243.0.116 [ 2173.940621] RIP: 0033:0x7f302d4b1b9b
Dec  2 12:41:10 10.243.0.116 [ 2173.940729] Code: Unable to access =
opcode bytes at RIP 0x7f302d4b1b71.
Dec  2 12:41:10 10.243.0.116 [ 2173.940765] RSP: 002b:00007f3013fef5a0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 12:41:10 10.243.0.116 [ 2173.940837] RAX: ffffffffffffffda RBX: =
00007f3013fef630 RCX: 00007f302d4b1b9b
Dec  2 12:41:10 10.243.0.116 [ 2173.940862] RDX: 0000000040106300 RSI: =
0000000000000004 RDI: 0000000010000002
Dec  2 12:41:10 10.243.0.116 [ 2173.940879] RBP: 0000000040106300 R08: =
0000000000000000 R09: 00007ffd9df03080
Dec  2 12:41:10 10.243.0.116 [ 2173.940895] R10: 00007f3013fef630 R11: =
0000000000000246 R12: 0000000000000004
Dec  2 12:41:10 10.243.0.116 [ 2173.940912] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f3013fff700
Dec  2 12:41:10 10.243.0.116 [ 2173.941989]  </TASK>
Dec  2 12:41:11 10.243.0.116 [ 2176.435476] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 2176.435476]   Tx Queue             <7>#012[ =
2176.435476]   TDH                  <6c>#012[ 2176.435476]   TDT         =
         <6c>#012[ 2176.435476]   next_to_use          <6c>#012[ =
2176.435476]   next_to_clean        <1>#012[ 2176.435476] =
buffer_info[next_to_clean]#012[ 2176.435476]   time_stamp           =
<1001c8f4b>#012[ 2176.435476]   next_to_watch        =
<0000000020e55410>#012[ 2176.435476]   jiffies              =
<1001c9c90>#012[ 2176.435476]   desc.status          <200001>
Dec  2 12:41:11 10.243.0.116 [ 2177.456207]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:41:11 10.243.0.116 [ 2177.481209]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:41:11 10.243.0.116 [ 2177.507030]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:41:11 10.243.0.116 [ 2177.531975]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:41:11 10.243.0.116 [ 2177.557938]  ? __asan_load4+0x43/0x90
Dec  2 12:41:11 10.243.0.116 [ 2177.582713]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:41:11 10.243.0.116 [ 2177.607685]  ? 0xffffffffc0b38099
Dec  2 12:41:11 10.243.0.116 [ 2177.633230]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:41:11 10.243.0.116 [ 2177.658763]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:41:11 10.243.0.116 [ 2177.683507]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:41:11 10.243.0.116 [ 2177.710811]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:41:11 10.243.0.116 [ 2177.737181]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:41:11 10.243.0.116 [ 2177.763199]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:41:11 10.243.0.116 [ 2177.789914]  ? =
process_one_work+0x525/0xa30
Dec  2 12:41:11 10.243.0.116 [ 2177.815411]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:41:11 10.243.0.116 [ 2177.841478]  ? =
process_one_work+0x5/0xa30
Dec  2 12:41:11 10.243.0.116 [ 2177.867761]  ? worker_thread+0x57/0x590
Dec  2 12:41:11 10.243.0.116 [ 2177.894138]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:41:11 10.243.0.116 [ 2177.919636]  ? kthread+0x1f3/0x220
Dec  2 12:41:11 10.243.0.116 [ 2177.944856]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:41:11 10.243.0.116 [ 2177.971028]  ? ret_from_fork+0x22/0x30
Dec  2 12:41:11 10.243.0.116 [ 2177.998311]  </TASK>
Dec  2 12:41:18 10.243.0.116 [ 2184.449193] watchdog: BUG: soft lockup - =
CPU#0 stuck for 440s! [TxStartup:3574]
Dec  2 12:41:18 10.243.0.116 [ 2184.482092] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:41:18 10.243.0.116 [ 2184.495504]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:41:18 10.243.0.116 [ 2184.808210] irq event stamp: 24564
Dec  2 12:41:18 10.243.0.116 [ 2184.843604] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:41:18 10.243.0.116 [ 2184.880807] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:41:18 10.243.0.116 [ 2184.917645] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:41:18 10.243.0.116 [ 2184.954352] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:41:18 10.243.0.116 [ 2184.990422] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:41:18 10.243.0.116 [ 2185.027726] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:18 10.243.0.116 [ 2185.065085] IRQ stage: Linux
Dec  2 12:41:18 10.243.0.116 [ 2185.101505] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:41:18 10.243.0.116 [ 2185.138806] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:41:19 10.243.0.116 [ 2185.219458] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000293 ORIG_RAX: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.261756] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.304098] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.346507] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.389030] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.431664] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.474153] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.517254] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:19 10.243.0.116 [ 2185.560089] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:41:19 10.243.0.116 [ 2185.603683] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:19 10.243.0.116 [ 2185.647936] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:19 10.243.0.116 [ 2185.692334] Call Trace:
Dec  2 12:41:19 10.243.0.116 [ 2185.735795]  <IRQ>
Dec  2 12:41:19 10.243.0.116 [ 2185.779309]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:41:19 10.243.0.116 [ 2185.823902]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:41:19 10.243.0.116 [ 2185.868093]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:41:19 10.243.0.116 [ 2185.912562]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:41:19 10.243.0.116 [ 2185.956266]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:41:19 10.243.0.116 [ 2186.000431]  ? do_irq_inband+0x2f/0x40
Dec  2 12:41:19 10.243.0.116 [ 2186.044110]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:41:19 10.243.0.116 [ 2186.087778]  </IRQ>
Dec  2 12:41:19 10.243.0.116 [ 2186.130553]  <TASK>
Dec  2 12:41:19 10.243.0.116 [ 2186.173534]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:41:20 10.243.0.116 [ 2186.217906]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:41:20 10.243.0.116 [ 2186.261397]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:41:20 10.243.0.116 [ 2186.304887]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:41:20 10.243.0.116 [ 2186.348756]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:41:20 10.243.0.116 [ 2186.391742]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:41:20 10.243.0.116 [ 2186.434005]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:41:20 10.243.0.116 [ 2186.476894]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:41:20 10.243.0.116 [ 2186.518832]  ? =
smp_call_function_many_cond+0x1bf/0x4e0
Dec  2 12:41:20 10.243.0.116 [ 2186.560149]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:41:20 10.243.0.116 [ 2186.600865]  ? leave_mm+0x40/0x40
Dec  2 12:41:20 10.243.0.116 [ 2186.640662]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:41:20 10.243.0.116 [ 2186.680446]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:41:20 10.243.0.116 [ 2186.719677]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:41:20 10.243.0.116 [ 2186.758644]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:41:20 10.243.0.116 [ 2186.797431]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:41:20 10.243.0.116 [ 2186.837789]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:41:20 10.243.0.116 [ 2186.875699]  ? 0xffffffffc0b38099
Dec  2 12:41:20 10.243.0.116 [ 2186.913217]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:41:20 10.243.0.116 [ 2186.950934]  ? =
change_protection+0x50/0x90
Dec  2 12:41:20 10.243.0.116 [ 2186.987737]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:41:20 10.243.0.116 [ 2187.024688]  ? =
change_protection+0x90/0x90
Dec  2 12:41:20 10.243.0.116 [ 2187.060788]  ? mprotect_fixup+0x5/0x490
Dec  2 12:41:20 10.243.0.116 [ 2187.097277]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:41:20 10.243.0.116 [ 2187.132155]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:41:20 10.243.0.116 [ 2187.164626]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:41:20 10.243.0.116 [ 2187.197302]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:41:21 10.243.0.116 [ 2187.229167]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:41:21 10.243.0.116 [ 2187.260767]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:41:21 10.243.0.116 [ 2187.294132]  </TASK>
Dec  2 12:41:34 10.243.0.116 [ 2200.449047] watchdog: BUG: soft lockup - =
CPU#2 stuck for 280s! [kworker/2:2:259]
Dec  2 12:41:34 10.243.0.116 [ 2200.472753] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:41:34 10.243.0.116 [ 2200.481997]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:41:34 10.243.0.116 [ 2200.691783] irq event stamp: 23654
Dec  2 12:41:34 10.243.0.116 [ 2200.715628] hardirqs last  enabled at =
(23653): [<ffffffff8e1bd0d7>] _raw_spin_unlock_irq+0x27/0x40
Dec  2 12:41:34 10.243.0.116 [ 2200.741161] hardirqs last disabled at =
(23654): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:41:34 10.243.0.116 [ 2200.766289] softirqs last  enabled at =
(23540): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:41:34 10.243.0.116 [ 2200.791821] softirqs last disabled at =
(23529): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:41:34 10.243.0.116 [ 2200.817167] CPU: 2 PID: 259 Comm: =
kworker/2:2 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 12:41:34 10.243.0.116 [ 2200.843479] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:34 10.243.0.116 [ 2200.869540] IRQ stage: Linux
Dec  2 12:41:34 10.243.0.116 [ 2200.894964] Workqueue: rcu_gp =
wait_rcu_exp_gp
Dec  2 12:41:34 10.243.0.116 [ 2200.920962] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:41:34 10.243.0.116 [ 2200.946808] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:41:34 10.243.0.116 [ 2201.003069] RSP: 0018:ffff88841e309e80 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.032233] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.061761] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.090855] RBP: ffff88841e309ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.120085] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.149416] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:41:34 10.243.0.116 [ 2201.179358] FS:  0000000000000000(0000) =
GS:ffff88841e300000(0000) knlGS:0000000000000000
Dec  2 12:41:35 10.243.0.116 [ 2201.209228] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:35 10.243.0.116 [ 2201.238797] CR2: 00007f20be593000 CR3: =
000000012c0f0004 CR4: 00000000003706e0
Dec  2 12:41:35 10.243.0.116 [ 2201.269139] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:35 10.243.0.116 [ 2201.299747] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:35 10.243.0.116 [ 2201.330320] Call Trace:
Dec  2 12:41:35 10.243.0.116 [ 2201.360219]  <IRQ>
Dec  2 12:41:35 10.243.0.116 [ 2201.390402]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:41:35 10.243.0.116 [ 2201.421189]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:41:35 10.243.0.116 [ 2201.451999]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:41:35 10.243.0.116 [ 2201.482889]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:41:35 10.243.0.116 [ 2201.513006]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:41:35 10.243.0.116 [ 2201.543224]  ? do_irq_inband+0x2f/0x40
Dec  2 12:41:35 10.243.0.116 [ 2201.573586]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:41:35 10.243.0.116 [ 2201.603958]  </IRQ>
Dec  2 12:41:35 10.243.0.116 [ 2201.633424]  <TASK>
Dec  2 12:41:35 10.243.0.116 [ 2201.665784]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:41:35 10.243.0.116 [ 2201.697221]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:41:35 10.243.0.116 [ 2201.734042]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:41:35 10.243.0.116 [ 2201.769611]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:41:35 10.243.0.116 [ 2201.805219]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:41:35 10.243.0.116 [ 2201.840034]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:41:35 10.243.0.116 [ 2201.874218]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:41:35 10.243.0.116 [ 2201.908548]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:41:35 10.243.0.116 [ 2201.942675]  ? =
smp_call_function_single+0x118/0x210
Dec  2 12:41:35 10.243.0.116 [ 2201.976159]  ? =
smp_call_function_single+0x110/0x210
Dec  2 12:41:35 10.243.0.116 [ 2202.009858]  ? 0xffffffffc0b38099
Dec  2 12:41:35 10.243.0.116 [ 2202.042400]  ? =
generic_exec_single+0x140/0x140
Dec  2 12:41:35 10.243.0.116 [ 2202.075416]  ? rcu_all_qs+0xa0/0xa0
Dec  2 12:41:35 10.243.0.116 [ 2202.107233]  ? =
smp_call_function_single+0x5/0x210
Dec  2 12:41:35 10.243.0.116 [ 2202.139254]  ? =
sync_rcu_exp_select_node_cpus+0x3df/0x5c0
Dec  2 12:41:35 10.243.0.116 [ 2202.171882]  ? =
sync_rcu_exp_select_cpus+0x2c5/0x5c0
Dec  2 12:41:36 10.243.0.116 [ 2202.203417]  ? wait_rcu_exp_gp+0x1f/0x30
Dec  2 12:41:36 10.243.0.116 [ 2202.234017]  ? =
process_one_work+0x525/0xa30
Dec  2 12:41:36 10.243.0.116 [ 2202.265176]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Dec  2 12:41:36 10.243.0.116 [ 2202.295857]  ? =
process_one_work+0x5/0xa30
Dec  2 12:41:36 10.243.0.116 [ 2202.326958]  ? worker_thread+0x57/0x590
Dec  2 12:41:36 10.243.0.116 [ 2202.356729]  ? =
process_one_work+0xa30/0xa30
Dec  2 12:41:36 10.243.0.116 [ 2202.387120]  ? kthread+0x1f3/0x220
Dec  2 12:41:36 10.243.0.116 [ 2202.416563]  ? =
set_kthread_struct+0x90/0x90
Dec  2 12:41:36 10.243.0.116 [ 2202.446123]  ? ret_from_fork+0x22/0x30
Dec  2 12:41:36 10.243.0.116 [ 2202.474174]  </TASK>
Dec  2 12:41:46 10.243.0.116 [ 2212.449324] watchdog: BUG: soft lockup - =
CPU#0 stuck for 466s! [TxStartup:3574]
Dec  2 12:41:46 10.243.0.116 [ 2212.482867] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:41:46 10.243.0.116 [ 2212.496283]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:41:46 10.243.0.116 [ 2212.807789] irq event stamp: 24564
Dec  2 12:41:46 10.243.0.116 [ 2212.842413] hardirqs last  enabled at =
(24563): [<ffffffff8d1d44ad>] sync_current_irq_stage+0x45d/0x500
Dec  2 12:41:46 10.243.0.116 [ 2212.879242] hardirqs last disabled at =
(24564): [<ffffffff8d49923b>] handle_mm_fault+0x48b/0x520
Dec  2 12:41:46 10.243.0.116 [ 2212.916101] softirqs last  enabled at =
(0): [<ffffffff8d0ca587>] copy_process+0x1307/0x3770
Dec  2 12:41:46 10.243.0.116 [ 2212.953194] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 12:41:46 10.243.0.116 [ 2212.990176] CPU: 0 PID: 3574 Comm: =
TxStartup Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:41:46 10.243.0.116 [ 2213.028396] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:46 10.243.0.116 [ 2213.066458] IRQ stage: Linux
Dec  2 12:41:46 10.243.0.116 [ 2213.103306] RIP: =
0010:proxy_set_next_ktime+0x77/0x90
Dec  2 12:41:46 10.243.0.116 [ 2213.140801] Code: 74 37 49 8d 7c 24 30 =
e8 d7 2d 1d 00 49 8b 44 24 30 4c 89 e7 e8 da 42 0b 01 48 8d 34 03 31 d2 =
4c 89 ef e8 5c 14 00 00 41 56 9d <31> c0 5b 41 5c 41 5d 41 5e 5d c3 cc =
cc cc cc e8 25 f5 eb ff eb d9
Dec  2 12:41:47 10.243.0.116 [ 2213.221591] RSP: 0018:ffff88841e209e80 =
EFLAGS: 00000297 ORIG_RAX: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.263898] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.306332] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.348762] RBP: ffff88841e209ea0 R08: =
0000000000000000 R09: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.391301] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.433897] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.476523] FS:  00007f301ae2e700(0000) =
GS:ffff88841e200000(0000) knlGS:0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.519709] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:47 10.243.0.116 [ 2213.562679] CR2: 00007f1e4033b660 CR3: =
0000000137d08006 CR4: 00000000003706f0
Dec  2 12:41:47 10.243.0.116 [ 2213.606340] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:47 10.243.0.116 [ 2213.650776] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:47 10.243.0.116 [ 2213.695237] Call Trace:
Dec  2 12:41:47 10.243.0.116 [ 2213.738705]  <IRQ>
Dec  2 12:41:47 10.243.0.116 [ 2213.782176]  ? =
__hrtimer_run_queues+0x5/0x780
Dec  2 12:41:47 10.243.0.116 [ 2213.826716]  ? =
hrtimer_interrupt+0x1aa/0x360
Dec  2 12:41:47 10.243.0.116 [ 2213.870760]  ? =
hrtimer_interrupt+0x5/0x360
Dec  2 12:41:47 10.243.0.116 [ 2213.914987]  ? =
proxy_irq_handler+0x37/0x50
Dec  2 12:41:47 10.243.0.116 [ 2213.958641]  ? =
handle_synthetic_irq+0xec/0x320
Dec  2 12:41:47 10.243.0.116 [ 2214.002776]  ? do_irq_inband+0x2f/0x40
Dec  2 12:41:47 10.243.0.116 [ 2214.046406]  ? =
arch_do_IRQ_pipelined+0xcd/0x5b0
Dec  2 12:41:47 10.243.0.116 [ 2214.090029]  </IRQ>
Dec  2 12:41:47 10.243.0.116 [ 2214.132692]  <TASK>
Dec  2 12:41:47 10.243.0.116 [ 2214.175524]  ? =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:41:48 10.243.0.116 [ 2214.219692]  ? =
sync_irq_stage+0x1af/0x1e0
Dec  2 12:41:48 10.243.0.116 [ 2214.262968]  ? =
synchronize_pipeline+0x8b/0xe0
Dec  2 12:41:48 10.243.0.116 [ 2214.306190]  ? =
handle_irq_pipelined_finish+0xf6/0x240
Dec  2 12:41:48 10.243.0.116 [ 2214.349747]  ? =
arch_pipeline_entry+0x81/0x110
Dec  2 12:41:48 10.243.0.116 [ 2214.392439]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Dec  2 12:41:48 10.243.0.116 [ 2214.434406]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Dec  2 12:41:48 10.243.0.116 [ 2214.477042]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:41:48 10.243.0.116 [ 2214.518736]  ? __asan_load4+0x37/0x90
Dec  2 12:41:48 10.243.0.116 [ 2214.559653]  ? =
smp_call_function_many_cond+0x1c7/0x4e0
Dec  2 12:41:48 10.243.0.116 [ 2214.600427]  ? leave_mm+0x40/0x40
Dec  2 12:41:48 10.243.0.116 [ 2214.640220]  ? =
x86_configure_nx+0x70/0x70
Dec  2 12:41:48 10.243.0.116 [ 2214.680002]  ? =
on_each_cpu_cond_mask+0x29/0x40
Dec  2 12:41:48 10.243.0.116 [ 2214.719226]  ? =
native_flush_tlb_multi+0xbe/0x250
Dec  2 12:41:48 10.243.0.116 [ 2214.758188]  ? =
flush_tlb_mm_range+0x136/0x1f0
Dec  2 12:41:48 10.243.0.116 [ 2214.796803]  ? =
change_protection_range+0x8bd/0xea0
Dec  2 12:41:48 10.243.0.116 [ 2214.837115]  ? =
prot_none_pte_entry+0x70/0x70
Dec  2 12:41:48 10.243.0.116 [ 2214.874914]  ? 0xffffffffc0b38099
Dec  2 12:41:48 10.243.0.116 [ 2214.912374]  ? =
change_protection_range+0x5/0xea0
Dec  2 12:41:48 10.243.0.116 [ 2214.949991]  ? =
change_protection+0x50/0x90
Dec  2 12:41:48 10.243.0.116 [ 2214.986701]  ? =
mprotect_fixup+0x2c5/0x490
Dec  2 12:41:48 10.243.0.116 [ 2215.023481]  ? =
change_protection+0x90/0x90
Dec  2 12:41:48 10.243.0.116 [ 2215.059428]  ? mprotect_fixup+0x5/0x490
Dec  2 12:41:48 10.243.0.116 [ 2215.095808]  ? =
do_mprotect_pkey+0x32a/0x590
Dec  2 12:41:48 10.243.0.116 [ 2215.130566]  ? =
mprotect_fixup+0x490/0x490
Dec  2 12:41:48 10.243.0.116 [ 2215.162857]  ? =
do_mprotect_pkey+0x5/0x590
Dec  2 12:41:48 10.243.0.116 [ 2215.195533]  ? =
__x64_sys_mprotect+0x48/0x60
Dec  2 12:41:49 10.243.0.116 [ 2215.227339]  ? do_syscall_64+0x4c/0xa0
Dec  2 12:41:49 10.243.0.116 [ 2215.258936]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 12:41:49 10.243.0.116 [ 2215.292360]  </TASK>
Dec  2 12:41:55 10.243.0.116 [ 2221.347164] ------------[ cut here =
]------------
Dec  2 12:41:55 10.243.0.116 [ 2221.376431] igb 0000:05:00.0: Detected =
Tx Unit Hang#012[ 2221.376431]   Tx Queue             <7>#012[ =
2221.376431]   TDH                  <57>#012[ 2221.376431]   TDT         =
         <57>#012[ 2221.376431]   next_to_use          <57>#012[ =
2221.376431]   next_to_clean        <ec>#012[ 2221.376431] =
buffer_info[next_to_clean]#012[ 2221.376431]   time_stamp           =
<1001cfd74>#012[ 2221.376431]   next_to_watch        =
<00000000a55bfb00>#012[ 2221.376431]   jiffies              =
<1001d4c1d>#012[ 2221.376431]   desc.status          <1ac001>
Dec  2 12:41:55 10.243.0.116 [ 2221.876167] NETDEV WATCHDOG: eno1 (igb): =
transmit queue 7 timed out
Dec  2 12:41:55 10.243.0.116 [ 2221.899091] WARNING: CPU: 1 PID: 0 at =
net/sched/sch_generic.c:478 dev_watchdog+0x4ff/0x570
Dec  2 12:41:55 10.243.0.116 [ 2221.930278] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support kvm_intel mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr sg i2c_i801 ftdi_sio mei_me i2c_smbus joydev =
input_leds intel_pch_thermal mei lpc_ich mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea ixgbe =
sysfillrect sd_mod sr_mod sysimgblt fb_sys_fops cdrom t10_pi =
drm_ttm_helper ttm mdio drm igb ah
Dec  2 12:41:55 10.243.0.116 [ 2221.984081]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  2 12:41:56 10.243.0.116 [ 2222.222049] CPU: 1 PID: 0 Comm: =
swapper/1 Tainted: G    B   W    L    5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 12:41:56 10.243.0.116 [ 2222.258031] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 12:41:56 10.243.0.116 [ 2222.294311] IRQ stage: Linux
Dec  2 12:41:56 10.243.0.116 [ 2222.330016] RIP: =
0010:dev_watchdog+0x4ff/0x570
Dec  2 12:41:56 10.243.0.116 [ 2222.365176] Code: ff ff 4c 8b 75 b8 c6 =
05 81 68 8d 01 01 4c 89 f7 e8 96 fc f4 ff 44 89 e1 4c 89 f6 48 c7 c7 20 =
3f a4 8e 48 89 c2 e8 92 eb 2e 00 <0f> 0b e9 10 ff ff ff 65 ff 05 53 5d =
1d 72 48 c7 c7 58 25 73 8f e8
Dec  2 12:41:56 10.243.0.116 [ 2222.434240] RSP: 0018:ffff88841e289d20 =
EFLAGS: 00010286
Dec  2 12:41:56 10.243.0.116 [ 2222.475306] RAX: 0000000000000000 RBX: =
ffff8881321c8500 RCX: ffffffff8d22a902
Dec  2 12:41:56 10.243.0.116 [ 2222.515381] RDX: 1ffff11083c5b7c1 RSI: =
0000000000000008 RDI: ffff88841e2dbe0c
Dec  2 12:41:56 10.243.0.116 [ 2222.556084] RBP: ffff88841e289d80 R08: =
ffffed1083c5ca29 R09: ffffed1083c5ca29
Dec  2 12:41:56 10.243.0.116 [ 2222.587339] R10: ffff8881001ce107 R11: =
ffffed1020039c20 R12: 0000000000000007
Dec  2 12:41:56 10.243.0.116 [ 2222.630191] R13: ffff8881321c8408 R14: =
ffff8881321c8000 R15: 0000000000000001
Dec  2 12:41:56 10.243.0.116 [ 2222.672328] FS:  0000000000000000(0000) =
GS:ffff88841e280000(0000) knlGS:0000000000000000
Dec  2 12:41:56 10.243.0.116 [ 2222.716123] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 12:41:56 10.243.0.116 [ 2222.759259] CR2: 00007f202c70b000 CR3: =
0000000407e16004 CR4: 00000000003706e0
Dec  2 12:41:56 10.243.0.116 [ 2222.803194] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 12:41:56 10.243.0.116 [ 2222.847256] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 12:41:56 10.243.0.116 [ 2222.891345] Call Trace:
Dec  2 12:41:56 10.243.0.116 [ 2222.935339]  <IRQ>
Dec  2 12:41:56 10.243.0.116 [ 2222.980419]  ? =
qdisc_put_unlocked+0x50/0x50
Dec  2 12:41:56 10.243.0.116 [ 2223.023440]  call_timer_fn+0x224/0x3e0
Dec  2 12:41:56 10.243.0.116 [ 2223.067309]  ? add_timer+0x360/0x360
Dec  2 12:41:56 10.243.0.116 [ 2223.111083]  ? call_timer_fn+0x5/0x3e0
Dec  2 12:41:56 10.243.0.116 [ 2223.143416]  ? =
qdisc_put_unlocked+0x50/0x50
Dec  2 12:41:57 10.243.0.116 [ 2223.188309]  =
run_timer_softirq+0x952/0x9c0
Dec  2 12:41:57 10.243.0.116 [ 2223.234313]  ? call_timer_fn+0x3e0/0x3e0
Dec  2 12:41:57 10.243.0.116 [ 2223.278327]  ? =
rcu_read_lock_held_common+0x5/0x70
Dec  2 12:41:57 10.243.0.116 [ 2223.322433]  ? call_timer_fn+0x3e0/0x3e0
Dec  2 12:41:57 10.243.0.116 [ 2223.365205]  ? __do_softirq+0xf8/0x598
Dec  2 12:41:57 10.243.0.116 [ 2223.398271]  ? =
run_timer_softirq+0x5/0x9c0
Dec  2 12:41:57 10.243.0.116 [ 2223.443418]  __do_softirq+0x103/0x598
Dec  2 12:41:57 10.243.0.116 [ 2223.489152]  irq_exit_rcu+0xab/0x180
Dec  2 12:41:57 10.243.0.116 [ 2223.533367]  =
arch_do_IRQ_pipelined+0xd2/0x5b0
Dec  2 12:41:57 10.243.0.116 [ 2223.578142]  </IRQ>
Dec  2 12:41:57 10.243.0.116 [ 2223.621272]  <TASK>
Dec  2 12:41:57 10.243.0.116 [ 2223.664298]  =
sync_current_irq_stage+0x2e3/0x500
Dec  2 12:41:57 10.243.0.116 [ 2223.699143]  =
__inband_irq_enable+0x74/0x80
Dec  2 12:41:57 10.243.0.116 [ 2223.743057]  inband_irq_enable+0x1b/0x30
Dec  2 12:41:57 10.243.0.116 [ 2223.786056]  =
cpuidle_enter_state+0x1c2/0x7b0
Dec  2 12:41:57 10.243.0.116 [ 2223.831370]  cpuidle_enter+0x41/0x70
Dec  2 12:41:57 10.243.0.116 [ 2223.875002]  call_cpuidle+0x5e/0x90
Dec  2 12:41:57 10.243.0.116 [ 2223.917226]  do_idle+0x375/0x390
Dec  2 12:41:57 10.243.0.116 [ 2223.949021]  ? =
arch_cpu_idle_exit+0x40/0x40
Dec  2 12:41:57 10.243.0.116 [ 2223.991096]  ? do_idle+0x5/0x390
Dec  2 12:41:57 10.243.0.116 [ 2224.032947]  cpu_startup_entry+0x1d/0x20
Dec  2 12:41:57 10.243.0.116 [ 2224.073417]  start_secondary+0x1d4/0x230
Dec  2 12:41:57 10.243.0.116 [ 2224.114018]  ? =
set_cpu_sibling_map+0xcf0/0xcf0
Dec  2 12:41:57 10.243.0.116 [ 2224.155005]  =
secondary_startup_64_no_verify+0xb0/0xbb
Dec  2 12:41:57 10.243.0.116 [ 2224.197428]  </TASK>
Dec  2 12:41:58 10.243.0.116 [ 2224.225993] irq event stamp: 8128534
Dec  2 12:41:58 10.243.0.116 [ 2224.254271] hardirqs last  enabled at =
(8128533): [<ffffffff8d22afe2>] tick_nohz_idle_exit+0x92/0x1a0
Dec  2 12:41:58 10.243.0.116 [ 2224.294358] hardirqs last disabled at =
(8128534): [<ffffffff8e1afe3d>] __schedule+0x90d/0x1160
Dec  2 12:41:58 10.243.0.116 [ 2224.333354] softirqs last  enabled at =
(8128500): [<ffffffff8e400332>] __do_softirq+0x332/0x598
Dec  2 12:41:58 10.243.0.116 [ 2224.370023] softirqs last disabled at =
(8128493): [<ffffffff8d0dc80b>] irq_exit_rcu+0xab/0x180
Dec  2 12:41:58 10.243.0.116 [ 2224.406201] ---[ end trace =
579693c5019e495a ]---
Dec  2 12:41:58 10.243.0.116 [ 2224.455183] igb 0000:05:00.0 eno1: Reset =
adapter
------=_NextPart_001_023D_01D90655.05739CF0--

------=_NextPart_000_023C_01D90655.05739CF0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIxMjAyMjA1MDIxWjAvBgkqhkiG9w0BCQQxIgQgui/kE023fxBxzPEfEGhgFCBa
cs+AYrom94Nxc9V8HdkwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQAM
hK95x1ASVhX6sctKQCP+/6BYwdqzoH12mMnV8cMAAJu8xHYpmjrYZsZCOfK4z7YFGqA/ZOn+D/Wo
H6S33QVULkGwwxyXmtAe1lRmlyw/VEsxAgRXxadTUchj3QdJsoJlSFt+I7IBa8xtPsNYY+Y4McR9
TBjNhUDEUPTv/eyVvn2+5HgH0Uy0vrdxTrCjwSagwv6pjD5ewJhQPFVXyYaEC8DgzXEcGJAlcQMU
CcRoQ/3umstyMKpDQd38iwMAMWUAZBlu1rr883tOJJi42cqfz+TXyRYG9X44lAFZjP+cNQ1amxfM
ws2unpTjsa6JI5RPTo6eTFf09ASlucW+DljgAAAAAAAA

------=_NextPart_000_023C_01D90655.05739CF0--
