Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9F33F2
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 14:20:54 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QD6hQE002263;
	Mon, 26 Sep 2022 07:20:46 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0143.outbound.protection.office365.us [23.103.199.143])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3jt12b25bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Sep 2022 07:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=OO9tpYuw/DIOv9RtOQFVxEsRTLWuTOSMEyKYzjnLNjk5WDOJeWa+iadQNn8gAvKtmGzxtafYVEcPVp9szC1tBiurr+nuJuGwHDgD1P8LUUo0ICwAvtFVNdpqXakVjEsg7Dv5eghyQS6P2c4u7pNXB9e6prjuMzTueZ6QtkLuju8tF8BbrjeWxueGjtJImBcdHM1qrCnf0Bs3R7f22uaWiqTYYqcho2a7BclNBiXlVN7hCUyMoMLevJ55BkDl+Sd51NplniEyOKmkRBbDu6oFE5dco/uY3W7ECTUe+gK12G8oNlN13bdXDCQ8nsv33iz5JBJlECvbBRPpYU89O3s1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApAMtozi8oj7z6l8/vZ1sX10cGYakTqqdxX7GaUv5gQ=;
 b=gA+vYPXOIZlvt2FqRCX4uzTNRUraxBi+kFGm8WJVBNlJTex06+i4EoWTwKu2JzT4hTsUv9qFFUZuAUvbgDjfuI+U7c+eaQhT0pz2c/4qcuihujLbZq96ySyqJnydGcNsLOeAcOvjfEp0lcZmj2/lVyidcwNxjb1BNjo0lCWqd6ecF2b+wEtKHNbWpIVw74b5WO+2lolg/Ad4QBmd3flHSGpdEPhmrsudpwszpq84GuwkhoS0YMRMz1GA/zaFko2KPYwKyldL/QbaQoqLIq8exarX/1+RO6gPLNC2VWtP2VyeMB4qIYteb4ewP+LCQxAtJ5Nxv7URwAySywLbAgYY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApAMtozi8oj7z6l8/vZ1sX10cGYakTqqdxX7GaUv5gQ=;
 b=lQTdBRRX8DV5Ii7wRuEo8NbhSLcXAEbNxM6K6y2eC3kUXfeQy0YeJm5loaIvb7JWtSgA6e//j527A43M0VgE5wOXPetjCzIFW3BZwj6Y34smsgfm6f1/i//GTLg7QK1Nwc7GTeRMBvRru0KxN+NUfLX2HZBlt76fXkIgu3ZpUldB8Uou7J/offyDE4ELMPSji8ral6zteJzpCDdRYedtrIuCyxQI+S8OGyxNdzp4zuU7q4Xa48R9sSMp4ihjuoE9qJnkt1mDv5vH2Hv4ztkE4rP3a0q0eAgECcuSIF+Kb5eRW6JUkyeGjwatfYewgTNL9ooIPqpOdKXQtwC9T8xyzg==
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::9)
 by BN2P110MB1415.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Mon, 26 Sep
 2022 14:20:43 +0000
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdb6:83da:a5e9:4056]) by BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdb6:83da:a5e9:4056%7]) with mapi id 15.20.5654.019; Mon, 26 Sep 2022
 14:20:43 +0000
From: Bryan Butler <Bryan.Butler@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Russell Johnson <russell.johnson@kratosdefense.com>,
        "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: AQHYzo9KEi/6rzVHQeiyZvhBQUhKe63tb7PggADQfACAAgF/AIAAGiQAgAFs6aA=
Date: Mon, 26 Sep 2022 14:20:43 +0000
Message-ID: 
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
In-Reply-To: <87edvz8l5i.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1288:EE_|BN2P110MB1415:EE_
x-ms-office365-filtering-correlation-id: f2cb5b0e-3c0f-4cbc-d7a5-08da9fca4c23
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oW+GJ7RSzWoLkk9w6AK0UEhf+RW+6VPmv1AsfkzTIkTe1NObi0ZeVNPT+P7nqLYp21FmReUgLwIiTsbhU6vfFyECs8Y2axBPqgoSAcE2OY6psF6clktGcRmr2FKBF/BICrGREf+NAMm4kPK2vg5wNLioPZkruG7jBHQNRmiFQcHhoNZ/EkzI+YzVcsC+ACxvp53v6NQlOyc45XiOb5hZUcpZJvUN869cK0CLX1OPa6dTrhyax8lY644kGQTyWHOEHft+sbGc16HFoAWjNFGecBkx3DH3z3C4Z3Ie7TeWcH6q64l1DlCf9wFQzkkp0moiWJ1S5O0/iR/KFC49xAtYLbaIwdQxVkBiu+gc0M+I666JBWCaHp99+Bl8QMJ7A2CqWBT9X8CS6nRXbUtkYa/R2reLPHQ/v9vdx9TTaSSJoKN+KDPQ8FY420r98oyVwmfvju+yU47R1+WWLFL0Opb8qfTiQBbDktvxngnxPpeowqa2DKMWyKzihOKuYDw+nL5fT6G27L6gfbZZXl8o0SXlhxc5/BKXEtXBQFAoMSflcw/OmWowvg+CDCT1tkVhUgBmW4uPSP+qZMjPIU42nkKzUYHyouLoG93M/ZEg3bwoSfRmXGKxhgLmPshvDvLaI/q0vQ+CMduhabIzNOcrQ3fI/QHoTp5mkPC9O19QSXsQm/CCqF5rIrY57GgETe45AG19QetB7rPlnCY2ITkfGR98/w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(4326008)(55016003)(83380400001)(26005)(8676002)(7696005)(66946007)(66446008)(64756008)(76116006)(71200400001)(6506007)(38100700002)(6916009)(53546011)(9686003)(33656002)(54906003)(2906002)(498600001)(966005)(66476007)(186003)(86362001)(66556008)(5660300002)(122000001)(52536014)(8936002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 GaO00cuRJmi+uyvvyOXLDYaNsVLNMiD2lf56Q9vZKkJPwV1ivzZx3AOSxTgKfnPmFgwG8nflxIHypS+894zAUhL54DOwbqctIWFqbPy5nTaC3GdJ9ChMhZcwu6y4uM3epxpnq9HPDfDJQ3bk1cbbdi+dABh5ZQy9GUzEBVxOz675QB7hQAcLj2fBtwA4AUGygRx84jksFvWVStFFCHgpRgoy0Tg3CMCqErBBnnNqmlsdRN9cLuMCJjDaUZeamcnYYnMJ2FQz49RgEihPaTiP8RYlUdHXS3BiJ19ZA3cT9fyRTXLG1elfYlq/wpxaIFcozXHCW7ClDUQEkdGxou9Kq0NvU9Nx06CgQ4bZiLHYY0lb3v4LNw5Hu++ZlfZowZgIqAchJBxcWnNWKinbZSYf9XCC1OE4O5ubWTbEOoqhngM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cb5b0e-3c0f-4cbc-d7a5-08da9fca4c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 14:20:43.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1415
X-Proofpoint-ORIG-GUID: VHQnwcjv2BVqwQnWNZub75OcfhcO0YNs
X-Proofpoint-GUID: VHQnwcjv2BVqwQnWNZub75OcfhcO0YNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260091

Thank you Philippe, this is indeed good news! We are downloading the patch =
and rebuilding this morning. Will start testing and get you the results ASA=
P.
Thanks so much for your diligence.=20

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Sunday, September 25, 2022 10:33 AM
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>; xenomai@lists.linu=
x.dev
Subject: Re: [External] - Re: System hanging when using condition variables

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Bryan Butler <Bryan.Butler@kratosdefense.com> writes:
>>
>>> I have another system that behaves slightly differently. When it hits t=
he watchdog, here's what I get:
>>>
>>
>> I have been able to reproduce a bug on an armv7 SoC with the test=20
>> case you provided. Sometimes the RCU stall detector triggers,=20
>> sometimes it's a plain hard lockup. I believe these are symptoms of=20
>> the same bug, which _seems_ to hide in the PI chain management. I'm on i=
t.
>
> Actually, the PI chain was 'only' collateral damage. The bug was a=20
> fairly silly ABBA deadlock issue elsewhere, in the monitor=20
> implementation. A fix is under stress test here, I'll follow up with a=20
> patch asap.
>
> Thanks for the fine test case, having it made a huge difference once=20
> again.

Please test this branch [1] which addresses the issue, passed a 1h runtime =
stress test here. I'll wait for a confirmation from your end with the real =
app before merging these bits to the mainline EVL code.

TIA,

[1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__source.denx.de_X=
enomai_xenomai4_linux-2Devl_-2D_tree_testing_fix-2Dabba&d=3DDwIBAg&c=3DzeCC=
s5WLaN-HWPHrpXwbFoOqeS0G3NH2_2IQ_bzV13g&r=3DZCxAV_wH32iGNw683_LJpz6zY-laHqP=
yFpuUGbfNbD8&m=3Dj4miWzS4SlD0k9MUb_LS6XjrCKUMIzk8_ImpRAtPwW6n61PtaMYSTcv_Wz=
IJ0tT8&s=3DpparDjiwRsE3zGtqgV0Nz3VNc7RfYRhH17md5-Xcw_8&e=3D

--
Philippe.
