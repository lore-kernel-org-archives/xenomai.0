Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E3807
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 18:33:46 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGGbJK012525;
	Mon, 21 Nov 2022 10:33:40 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0151.outbound.protection.office365.us [23.103.199.151])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3kyqwx2k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 10:33:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Y5CIXwMxv6LHLmrg94GpkkAag7f8IhK+9NAQCJpytJ9Ut+m3uGagNe7egIZB7o6Fb3T1iYktBUA+Ejp888mXdoDH4d3T8SOPuPRHmuY4mJ2bklhocjp1MA2FrdtLCv3RkDk4lFH/SquyNTwbd1m1nlrfvQPq9E3b/R1RBxpiUKtjfEcso2E5YF6ebdfERA5tuDWgMEm++AjHUTMvP31MqOc3k9i02Y/kmZlpU7GngfUqHET54c585BUgaS1Wt5qO8JyCJxt8h/ngkTVRb8JaHeo7sLJjS+ExOBcdf9VGGOyq1Li9t0lRnVWjlgNHHXfkplyXwHmfuzPw1rOajS16Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0BWMZXrhwtGG3Fyl0czuy5pHl90hbFanUP4eNrz+Gk=;
 b=tiLVEhu5O5vxVmpcxYr53IS3+BE4Lqatx34kYb6O2wcY98LTeSCOZkyygu2X7PcvaGuwaAoCmzZqtQMhjPBnddXWt3b6hTchgZO7Qbm69Mprg1SJFPQDsIHurx2k5Wgmux+ThTCMcXvURum1swGq02dwAoH5EFJSdPX8zb0BHxN+YmCtJc5FKOPbKcOiRnV8vsZ16f+ADXsRm6gvG2x1DJi9Xgb4sekJd7JUkzrJwMgZbK+yxSxSgnognHrMqBCKWKZCDyJ/eGT0i39QK5cqiY9dVPVDh4whzBLvmPPGg155fjqZdJaQAhyrtveHeVsaHoUYCwYAXPsreMe5KmUA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0BWMZXrhwtGG3Fyl0czuy5pHl90hbFanUP4eNrz+Gk=;
 b=taQEbdAI10JqsHUDl/CWU9VaCWXd9V78Pj0aLo34BEJKNwr7HHCY9froS5ciqEpJO5iE8ejY1GzjjMYYAyvK6FqqqktUcSfaMXs8sgS/jKV9hIijwSV5NVMnyK5W3VbjSI2IqCt7rkA8c+/3Pe4flHY74L1gfqIugvK6QoXo8Jp1Rsuu5L0JZHCz+BBysAlBHJDBCaziWJJ/gnuq+MAIgkqpFlulj/L3TfrXSbmM9xd8Uz9VQCOWaqTsoji8PmbRdYzeCftp3rZsnd1aWyWqnDDYh+DrlGhB0qqZdKRo4Tn0GB7cW0EYxb+RrT5KY/d5Flh6fELr/k7FmTQARzChAw==
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::9)
 by BN2P110MB0946.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:33:37 +0000
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2056:dfda:4520:d00f]) by BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2056:dfda:4520:d00f%4]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 18:33:37 +0000
From: Bryan Butler <Bryan.Butler@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNA
Date: Mon, 21 Nov 2022 18:33:36 +0000
Message-ID: 
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877czothz0.fsf@xenomai.org>
In-Reply-To: <877czothz0.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1288:EE_|BN2P110MB0946:EE_
x-ms-office365-filtering-correlation-id: 921f7d4c-d063-43fd-f767-08dacbeee751
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 G7TG23aoLZ+i82QqrrrobM8D/OShb9dZtwXz6/Lm5nzJlSzA78JIfGT2mhRRtuJz0+6NPhdDo726vCnIYkpXN6KpBAV2UcKrkpIi3RE7u/hDdAJXVmxYLEj/qAb5Qv3Mds+09MTVMvOGH7avynaQL3kSSOnO4LHB9Nt/rcyiZ1tjGo/RGKeJemjzkUgKay7ZsIotBJWH+Zz5/ZYLUXLcu0QgQQiJ6wYxLOAhMOYmjoOZfcB6iyc2Outtvn5ZNrhoN7/EWwZbJJELdGVIfpLywtP/5Avlzc2u3xr1s2X6jFoffqc7Q+atM8ipAFNq3V1XXIyfS/Cbs8O85KaE/MgfgKPf7wn8Abw2RnqWrRF2IYrDaeWlGdKF2Ed06oEJj8dzAeCGoQ+DXBiu2zChhYj5qncOcdxDCHlsqlkKSSVm/RqHdpOBA+/6ic4PQDagRMr4JghEVHLGU/1/SZwx0ocz+Sm+b6ME0gkXwyrQpGB/psmEJoZ4oAGqTdFaavCH8AHkAntDVfaapVDvWLK9gp0eTsu4k3nL362NFv4ao0JPH7o8siLrDiMJjk9Jw2IYPvGWJ6ZY4CpEGyEDjmPyi97bB4ngtiDEoD832BDz5navZ6s7RmYeAw/iGN3yjJ6AOY+V
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(6636002)(33656002)(54906003)(110136005)(38070700005)(107886003)(53546011)(55016003)(83380400001)(186003)(9686003)(71200400001)(7696005)(26005)(498600001)(6506007)(5660300002)(86362001)(52536014)(8936002)(38100700002)(2906002)(64756008)(76116006)(66446008)(66476007)(4326008)(8676002)(122000001)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 mJADH8qBv7uxMO26CaxdbcIzrr3gumvu69451N9rHfIuG35mvbGr6R16Ew2D+MejklfpuN5jtc6La5g568H7CLN7MsnxIbg+UAh5bEOmzLabrTXoVEAefacsTv7XFQ84fwLCz5vEixmtECONHO147xAIhNF5jHbJZrHoCnIzhRah7p1TWjy6OovwSqmJohi5d6wa5eFupXIcgKtRR7PQnGqILx4ZMq2EZ3AuLtBx1+nk7mPqoUIg8cSkIyl6wU8bKWJrDq69oGJLaVO9FMOPukL+vC5r84cUYsOT7d40bWx7JPAXPiwD7gIFHjBpw3aT6knXFoeACHdbs3SOrcy39p+HZNje5E8EHppYffcxIC01dETryR2apEXcL6Bb/+TBnNYX6WF3yXaEro2fA1CxtIjwQriZ/jJCOFrJ/WKakh4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/LXKvubh6ghYPWAYSZylD2xbEALLz0YHHNAzoDr1k9QfJhESfe8oYX/bAXmyEgwSZYbGDlFQIh4QPOYHyJUcEt+cjriLPpU7HUI392bU84guYYQ7o5B9Dur8R/ZWgqN2z1YC4tZnLKfaFpQRp/+cRs4lbtUaQ5URdM0yTMZKzSQE4CPJFBM0zcNdrB1hin404DL+lcnmfFrDTgfsZ6roaavHWHeKDQcjB8p3Z5TIjbZ77chNUqzXNk3NRUnqQZYupaeTzSJIqnAlMayVYVeS894ySlmuHm7vpsFMijs8HPqw+WEpSENoZ3S4z+gKWwGOZ1iZXxMbPNUw10qba2wrg7D60p2VG5rr/PqC81A9Gr3QmGvRemj1qJ9Q5DZfsUzYVxyU5+oxACZbJbhD6zKFUSHnao/BKq2EwI6Ki6sueyD0QenJ2HOsLLfUPosDb5Zjy/Kvw7Sy9hpwsfIjZ1N/WWtjmOgowZeU1C2jAndVZR5eFxLZrY/EcAHWNga5ROBPohlPe7JSsl6Shxqj5DWmRZvcoxuzlQeqRHXur3ZauLY1b5JDKieq3ylz6/yPEDlALsysC9l4UpGZ8EcXVU2FTnOE15K3L4A2VVsmsxFbiLkgk7Vok0kXfI8HihRYyv7kxAslTCIT0Gh3jOKiwZ7tJ+uYMF3VZo55WDna7m3kSWNM3eNvnvBJyHNdrsAoTSDRrWAKivUHhnELnz7uyTDCGRQHXT/rOMDLxuOixdpZRoi8wqR6d+yrZvGx9yoIennBqGcqUQM1zQr7tQP/HKjVVFm+ugvwsKXpBed/xn8GRWjnacyO1ik6nuaHee0Gpvng
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 921f7d4c-d063-43fd-f767-08dacbeee751
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 18:33:36.9441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB0946
X-Proofpoint-GUID: KmazcQSFsg6issTcRkyRvbj4zqABHITN
X-Proofpoint-ORIG-GUID: KmazcQSFsg6issTcRkyRvbj4zqABHITN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210141

Hi Philippe, just to let you know this is a holiday week here in the US, an=
d Russell is out until next Monday. Those of us left will try to update our=
 build, but we may not be able to test it thoroughly. Just wanted you to kn=
ow since you may not hear much from us for the next week.

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Monday, November 21, 2022 8:56 AM
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@lists.linux.dev; Bryan Butler <Bryan.Butler@kratosdefense.com>;=
 Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> After fixing that line of code that was causing errors with building=20
> the EVL kernel, I was able to successfully build. I am now running our=20
> scenario that was causing issues previously. I will let you know what=20
> issues (if any) I run into.
>
> To your other point, I can confirm that the priorities that are being=20
> boosted are never being cleared back to the original base priorities..=20
> What do you recommend looking at first in order to figure out why this=20
> is happening?
>

I could not reproduce this PI deboosting issue yet, however I eventually fi=
gured out the reason for the lockup - which may translate to RCU warnings o=
n your system with many CPUs: this is a Dovetail issue wrt lockdep support.=
 IOW, the bug is in the lock debug infrastructure, caused by adding interru=
pt pipelining to the picture.

You can work around this issue until fixed by disabling PROVE_LOCKING and L=
OCKDEP entirely (which is also enabled by DEBUG_LOCK_ALLOC and DEBUG_WW_MUT=
EX_SLOWPATH indirectly).

--
Philippe.
