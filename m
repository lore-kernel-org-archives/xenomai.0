Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF5206B3
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 19:22:56 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UI31xe025946
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 12:04:30 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0148.outbound.protection.office365.us [23.103.199.148])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3qwmqy0f3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 12:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=NK4JSPROifPaUcDZ8PUDY+SFfNSxg/87YvvLs8pQPNVXJUW8U6ZROa62ByA0Jl9WDmk73CRICL1I9KZqdw9gfHz7MCW3GNuDeMFMoSzOM7LKo2aF6AGkd0mLi1M2FXOajijMiYvTKbA0dyHpfF/4OdGUo5c+gzpob/HmG1W/e2vDJg5DQtQR1J42e4Ftec+E/1pSa8GrO/ZoIcQJ6Zix4AvHxCHPXcPF+lRZqIiheUuMPQhZhpEd+cljSK+FNMmDEnt8qy5YuRoiLQK3vxx9pgCXREpVTMaTudY5psBckt186Qsg7uwxFtygcTV8TN7jEpVZTJl7ZpNOtoS5axZxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJHZrPMQFRE2na/SH/44oZxosA5YM3E7mWh5G/wigWs=;
 b=FN3fNMFRImptFBQcDrrDtA4S5Pa9Udjl+DDGr81S1laGuI+rtkQ0rI0jZm86slBbeuRvAMReDfrH+ShgLyhJgq3B+WwY/y/aBq6lrA5Ni22Cg+6gkYlYkJDDni3Gqv7TT/SCGhURbMXfKAXtrSFTcVq+nVZcnQT2vKxAJOTfjSvsfBrOOHQg8FCM5H53cvi9izqsP4/8b9gdngqElqm/MZ/oeqsBHxDTH5ZOp/NS7MY0Xzv0H14Sek5TZhEBFZa1UuCrouLcvDV08k32S1+g2ZK8/vUulVQiRfkRc/lTTi5cp9h0zgUhIcEQt/tJEJAq1ZFZBeG7kOOS2a3cV5R9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJHZrPMQFRE2na/SH/44oZxosA5YM3E7mWh5G/wigWs=;
 b=pTjkr+0iG0zNzd/5r6cXp/t5fHIenFFZreKIcKiT3NAJ6dNJ/LzeTKEZ/1VXMeLbt/N4ckbU9oUnlCfaEmnR4pS7dnA9G0eapSBdgF19DSSbTinDyz6lQiKBCvSsmCb31AWm1tMXc7xjt0jTwyHfXVtLKRKlHb0hIkT5a/vcRZpmNqnlRQ54SAPwC5m0j3zVz7oPm242oqBdFjTpvj1Sat1E1Vd0iXP/esfW6IYgX238ZSZ2RFu9jtIIYFcjwwXVv/CCTiAaiC63lPIcKciVYg2lVVRQirCRzaUsMeeoxfo4ozI1zEwvjAY5QjPoG0AI9+wIe1Ks6rXUgiHlr44IHg==
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::21)
 by PH1P110MB0986.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 19:04:28 +0000
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e]) by PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e%5]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 19:04:28 +0000
From: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Dave Rolenc <Dave.Rolenc@kratosdefense.com>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
Subject: [PATCH 1/1] rwsem_down_write_slowpath check if oob() before skipping
 schedule()
Thread-Topic: [PATCH 1/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Thread-Index: AdmTKEdU7DjhqIrUSIyqOe0jOP+fdw==
Date: Tue, 30 May 2023 19:04:28 +0000
Message-ID: 
 <0173f9b60a0e4dfbb40fe55454a65fdd@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1666:EE_|PH1P110MB0986:EE_
x-ms-office365-filtering-correlation-id: f92921d7-06f2-4c30-2df6-08db6140b181
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ky1J/5bywIcz5pPqB9TgXBS9hx4tct/ZTXp+nXoSKU3EsuYDVEJWWgusaSuyL8+GH+K5Sli7mA9htC2AQYEWCqBzIQjejKKwUhe9uoKE+HT+fy1Heo6gXce7wFTkYA1tbudfvQTdNIHYToG4Y5nbUkkJbReoOgmcKkYg354ypihRDU8c+72r95aFDJ/SJr1rYPhvu5FmbQv6IObAx9c3TK0TGAjD2srukX3W801AfWhzsBbLAV1i+Oi++nRhIuNblNstXkAf0dL2FYgQaSp6CYtq2ft4XNMF8MIU2AwVMEJnTDdRuAhLGQAHWgYMThmf8SH5PRrdBt4qvUz/uLYZsHGCBkJlvbygRKLRvLripWyVWGsYL1nzjWr7YQo6sbKEcAPPuGtTrv6/fxU3VdgrsF/5JZsNMtbo7iy7x1l2f3m5r7OPaU8/Ct42VWHejshWNlqlgNBRvNSc/Fk9jW3yaRu1G38+JqtXVtWFeSPStmlXspcaOf3B87L9oYFAoQ2u0nfIXum2g1QIqTd/kLtZYC0i4c8CYNwJKjtQOF+mI7XlQgv3l3+fAk8Fg6K2Fegts2YTxywcPhi/SffvDjAFi/HW4ioIJ8Ez0lh/U91OF74brZMiRr0LWfhQyOqYAm0m
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(39830400003)(396003)(366004)(451199021)(8676002)(86362001)(24736004)(7696005)(508600001)(108616005)(38070700005)(41300700001)(4326008)(55016003)(6916009)(41320700001)(71200400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(4744005)(186003)(2906002)(9686003)(6506007)(26005)(83380400001)(38100700002)(107886003)(54906003)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 4cSS/9Fv1rbcrRVokuu2vhtdl1LBOqf9iDMLiBq9AY1gNwHoKdoouokwshKVIE1MXQuaXomlDvLCC+t7KAakpC9tEJlpPm4s5wsJNZAYVDif4hfr9fK0zc2BceNURJ1KWh+QlvvgR4qhdfiG7mxHiKVpiIDLRMPdyCqGWX6Md3UH3GFlKHe7JukFSw139ElkP61mjctl7iG5Kf1C40OOFuuUm6m83tahimlrNHotLVTtYuZaXSz3k5vE5SXjP5LgrS/MrweMmboz0WdUMCyDkbUEYGmNQihrDwX5snPxIYFBkaq+EhFQueEaltrDlY5MRbqJvbvf156OzBCBusIIc9isnw5udlwqS57jLQBmHzCghH49DMXKWL8W/xDTuOitY52QlI+iOJJznKF5ElC8usZEtKnF46JuB7aj++UZnHc=
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
	o2xaHjOscoaTIP5PhNSNeHq/eNb46d6zKBxDPuJS9W46dXtUbyAx7A3rWLylBs6HufqnstK0g2p9NQnvz1VEzJ/CZHH8sGSmTU/KV0OdsEORxNEtI44OqNILeV/sJ4ap76ly9lskjX7me1qqZphFWvd6er7XtdffTUuNZ6rDkMVVuOTm6KeV9b8aDQh95nEynjL0b/PlCmiuEAHTmoohRRAZBej28wUmthkKVrHZPMGTvYb1qFF5/35I//ZB1K5HHSVizftqg4z9FeBdaGOZxa6smpsu4cGUexPaxzNByswCSPvLchtJnhJA0lDD/aTezr0melkCJN6Fykwiiv2fgj3Swc1X/cc6w8ZURhTCffanVhGBOX7Jyy4+cDrasZCABUZOdvXLveASLdgd26iRaQZcsy7v00e6J4xb0kx07qLGszISwu0L+ElgMEBxbR6A1fg2IozL1kGnLMuGXgvFyoBS8l3jiRT6yrYHCJorT/g0ybWa/E4X7rCMRGJo8Edz8/tBtHg5KnCsRdymT36qwyLxF2A5p1aXhcLTXhgeoUFS+sj71BFj4lHxg9CA+yrdUC259l/1xn/v+JbWp0n8OohnimXk3us9sf/Oj3xu5vABdagQeTeSI+ELdvuXLtZFOOc7cbfWMNAhS0UoZy2RstnALgLxrnpDfhbq1DxEuXvgpQUugdtiSLzqApfm32mM8bR2tQ0DYOUGcqWwIl10UCfXQr/3BiJ0Gzgb9smlGhN64K7O+KwnupTdVG5GqDkdNNBuLUixzlnXn1Kj7+FVMw==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f92921d7-06f2-4c30-2df6-08db6140b181
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 19:04:28.6475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0986
X-Proofpoint-ORIG-GUID: YCsPaakdpO9CGkDtVIXn6L4Jj3Yy4Pnm
X-Proofpoint-GUID: YCsPaakdpO9CGkDtVIXn6L4Jj3Yy4Pnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=504 spamscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300153

Signed-off-by: Dave Rolenc <dave.rolenc@kratosdefense.com>
---
 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4cc73e6f8974..cb77bd38cb64 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1151,7 +1151,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, i=
nt state)
 			owner_state =3D rwsem_spin_on_owner(sem);
 			preempt_enable();
=20
-			if (owner_state =3D=3D OWNER_NULL)
+			if (owner_state =3D=3D OWNER_NULL && running_oob())
 				goto trylock_again;
 		}
=20
--=20
2.39.1

