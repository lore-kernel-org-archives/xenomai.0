Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40F7E
	for <xenomai@lists.linux.dev>; Wed, 28 Sep 2022 01:08:37 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S18ax5004229;
	Tue, 27 Sep 2022 18:08:36 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0181.outbound.protection.office365.us [23.103.199.181])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3jt12b3w7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Sep 2022 18:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=WfEOiy+YN6noKfYkAX7rCRAVYne6Qq3JdwYjwTN/5/57n9vGC2DCMN8suga6pUmmpTbICP19CFHK2UJ0yLgXAynMxpaMWKqpIJ4A1/gB9w7FbN7+8h5eupNqVYhWqNhzNlNdnwCMEMYv1VF2F6FcK6otTnjgbCuPw2WEGyE4RHEtLMEVB0FPaIty8DOJK3+k4DgHP2PSKQTH2M4QOeXZp6c/8NSTjbrgxbrLIjS7EZyRuzOjMGZj63H08lYKmezM1tGyBWpSZx5y8It6G450Abw/n1QFsMKBobxmcQciZX9/E/UtsQ1drBNyQum0wbzoVZn5rOYBAZqgLmfTq3T5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO0+nQ2UqQG9gO024Ty7+WmHazhKzpmIjD+u2dBaeyY=;
 b=JZbu6I1QFFRuICM29tYKt5oGrAB/HZwYaKXdfdg/T8gbtK2mARLliR182iHRIjlpFgf/u1IYQ8sHSPaZOurl+HMic0DvUgxmllLdmxT68EqUJvAlDlm8go6/XWpAUW/QAVb15aWfwSbt3DB4dNTaBtzkiP1WMUHPrLJYmTdi1h86DhS1Slb2txKVH6d9BX5uD/wTLIGHLtDWujKBDPLpTiiUmnvg/yFM7MJu0n7BVIEDSoZub4OA6CLWJm4BFqZhmSmCIKXlyhGup9I2z+qchKT7AJ3lRYIkvyP+F1jO2oAei21Z3n3nsW+l4pANrTeqhhXwrM+t+OHxjMEtzbCXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO0+nQ2UqQG9gO024Ty7+WmHazhKzpmIjD+u2dBaeyY=;
 b=D4EsW6VSUD2mZcilcYSHUSZrNWII0Hr33E498WmbjpgSQ8V3uThnTwitSXFXr4mQP/BAOn0jn08jpcWBCeHQHqq8rqWrgp19kGoXsg9MDEF9eKzmatTdiqlRSAdlvWZwr6XjkJJ/FmkNIYfQKSBnMbE3wvhK/XpXJfjT1QOFMEJXvoQTzeoOl68YCbjJgn/kNaCzSynMbecwnbehFJ3WUjemE3ONSx4Kj5wsux7BPk0a6hoNlI4aAG+wMcaJF3Sv9yhYVM+FEW0yNg3SJv32GZzBiLIyQhb46E9JKFMwXv4/b3HJJB2ssfMKVq1tw50nKRa0L2T3pIt4bX+KwKdygQ==
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::9)
 by BN2P110MB1748.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 01:08:33 +0000
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdb6:83da:a5e9:4056]) by BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdb6:83da:a5e9:4056%7]) with mapi id 15.20.5654.019; Wed, 28 Sep 2022
 01:08:33 +0000
From: Bryan Butler <Bryan.Butler@kratosdefense.com>
To: Russell Johnson <russell.johnson@kratosdefense.com>,
        Philippe Gerum
	<rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: 
 AQHYzo9KEi/6rzVHQeiyZvhBQUhKe63tb7PggADQfACAAgF/AIAAGiQAgAFs6aCAAiUGAIAAICQw
Date: Wed, 28 Sep 2022 01:08:33 +0000
Message-ID: 
 <BN2P110MB1288DADB384231E5FB72D8EC8F549@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1288:EE_|BN2P110MB1748:EE_
x-ms-office365-filtering-correlation-id: 46c9f446-6d4e-4851-e162-08daa0edf702
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eedUphOaKVexF2WGKkvph+ewr9DiHHjJN3st2usWVgP+ZTgEvAUe0mHpTyK3JpuH0oWPnlYD1UDiQ1COalSl6mQNHBgLvIic6rwuvB56bh/QkkHeKd6Tdcjp0Xpj5PcZg3wm+8JMOmWRdd/JJ4mltkD4M4DgiI4n5NROBBYxLfnAzLE8qnuj/sRxamvHrHRWj4xjNyEO5Wj4rjIK0hFUIsep2RGQ33pq+nWrwVvVRmSlnzgZPbWh2ZxGThDzB0Lefuti2t9lZSuaJtSKVjs3kfRjKExjUuIffXnem096bZUzGiEKF9+TTl/GWq3pbQRuT2/POP/g7wTbL9HS009BPK8BCMAqCtOlm2GVnd0qEgNdnAAN9SIxUicMIJ8gBYV0BHUsQCWArS49OsCWhRkzKKgEHIF3yQgAVTNJGJXXDIav7sLuzTkwvCtq9PaFMiNIK18EAgv8I7/52kU3oZlcuIzqCSc5narsqB6TfqxHnyGCiJGvsqBuIx1ARxDbiQiII3ERUEsVU10ccdDm/ieQNoWYIizihp4wy/SI9S8I+l9TY1/dILqedipLmzdUionjST7bVKQEX/GN8fDIrKwlcns8A7RMC+FJoS5rYnW9K+xNJUbG12RcCiS9m9lUzNUsTUBxzrAPNe7vdiDEekdXZwZadlMIXCaueh310QSW0Qx0gfQqa70M86xE+5P4fL7N
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(26005)(9686003)(7696005)(38100700002)(122000001)(71200400001)(86362001)(33656002)(6506007)(99936003)(38070700005)(55016003)(83380400001)(498600001)(186003)(5660300002)(52536014)(110136005)(8936002)(76116006)(2906002)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 J9Q6X6pfdeTJvVuWuQswPpV/OBIq2Z3ViGDyjguqQzCofty/sWyCcKafkP1VzmooDmzG6wzJ6cCqNTQ9bqrkETMIJyA9yd7dsq3eJw2cMxt2gnLvIW0en26t0xcV6b1LFeliBg/Kz6+8wR12YGcJYUe2wGPXq0wOYDozB/j+Mqtpfa8U1OhrGFODrc1uI9P/z276/b7vpWFOVlqtCG44bMnnPYpxk454yCEQpT68DmmwStJ6kTNGTv/smiP78vBtQsIGuB/wFChneoomSMLqDimeq14vnNirPIXoaIKTYNHNse+Qlz133+bnS3w6SA+efB2pZN0/uI9qytOTN73uLDO7gcaIAk+W2OsPXfmFVQxCySBzvYcA+WBHWwT6hlRieNTuen2NQ8euwki1fFUFkrZV/4bRgBNKvTEmh+NFbHc=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.3;
	boundary="----=_NextPart_000_002E_01D8D2A4.886A3180"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c9f446-6d4e-4851-e162-08daa0edf702
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 01:08:33.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1748
X-Proofpoint-ORIG-GUID: J6gpkY3q2x0hsQbxXpsa01EEGZZiRWNH
X-Proofpoint-GUID: J6gpkY3q2x0hsQbxXpsa01EEGZZiRWNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_12,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280005

------=_NextPart_000_002E_01D8D2A4.886A3180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Philippe, 

I have observed a couple of odd things, and wanted to see if these were
intentional or not:

1. According to the documentation on evl_attach_thread(), the CPU affinity
is locked to a the single CPU on which the thread is running at the time.
Although one can call sched_setaffinity(), at the cost of a one-time in-band
switch, it doesn't appear that this actually changes the affinity settings.
It appears the thread will continue to run on the single CPU it was running
on when it was attached to the EVL scheduler. Is this the intended effect? 

2. Through experimentation, it doesn't appear that I can start multiple
threads which are identical copies of each other. Specifically, it appears
that if I start multiple threads with an identical entry point, that only
the last thread actually remains active, at least within the EVL scheduler
(as reported by "evl ps -l"). If, however, I start each thread with a unique
entry point, then I can see multiple threads starting up (although this is
one of the scenarios that is still crashing on us).

The reason I ask these questions is that we have a thread pool of a variable
number of identical "worker" threads, any of which can take a task and
operate on them. I would like to have the pool of worker threads share a
pool of CPUs, and let the scheduler decide how to allocate them. I can work
around this issue if necessary, but it may constrain the amount of
parallelism we can achieve. I can work around the second issue as well, but
it will make for some kind of ugly code.


------=_NextPart_000_002E_01D8D2A4.886A3180
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCFY8w
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
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIFvDCCBKSgAwIBAgIRAPwI
4UA6sVKfXSIxxT6s4ZwwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwNTAzMDAwMDAwWhcNMjMwNTAzMjM1OTU5WjCBwDEOMAwGA1UEERMF
OTIxMzExMjAwBgNVBAoMKUtyYXRvcyBEZWZlbnNlICYgU2VjdXJpdHkgU29sdXRpb25zLCBJbmMu
MRIwEAYDVQQJEwlTdWl0ZSA2MDAxEzARBgNVBAgTCkNhbGlmb3JuaWExCzAJBgNVBAYTAlVTMRUw
EwYDVQQDEwxCcnlhbiBCdXRsZXIxLTArBgkqhkiG9w0BCQEWHmJyeWFuLmJ1dGxlckBrcmF0b3Nk
ZWZlbnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKRLC0r6Le4UCoF3UDPP
oPdISCBcp1Pz/LMrT9B5S2ugRllkJULR2uF03v5YSCcFHRCuZ5hx+jCbBoKCyr6DxPM6+stHkWdE
1mWRP9yvMahyKyX2tFqYt+NweS9Ezlw6boZyTioQM+ikZW3QbR82GDgXAyB7Hqim6TCY1T+vpPa9
Ew1foa/HgVsxUFBrBxl8+SRQmhFvsqKjGQx29SB/PYSN4a33NFkjZLCKVUuaO9RLzletokl7pHCD
vlXHps5mMHm6eoDKHKAyV6GjghlKtRurSCVD2wihXgUFYkR/1UYke5gcKa1Nhk8HlBfIvU3ivFBO
EGvfx0yn1XihEzLVrgcCAwEAAaOCAdcwggHTMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J
4K0AMB0GA1UdDgQWBBTIvBmJT5ttPXRzgp5STthev2kwxjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0T
AQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEE
AbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMw
UTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNl
Y3VyZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTApBgNV
HREEIjAggR5icnlhbi5idXRsZXJAa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
ADm15bqU4yezvT7SjskR7CvkgxTdYy35tQBdhsPrii09uMxF/pHUWt4+/+356hEOlD3yXenjrqa3
WZB0nSckwV3Vxnu/0jwbcVfOafEzTZU1vzDsotlIGWB3VrT8yK7qFwjjbap1c0Pm7cr29SUKnqZh
NKwtjMfJ+d409s0ZtUPok/nrurBizJP4QUrc5S+oYVCjPHaus/6G0XrbWYA64ePZGr8QAZwz5CuQ
gtmL2GKBh9UiDTwIBPy5WbQq961MTMsvdMumFtyLsclW1fhc1uLrng/QYgLs1eZqnz31NUcUbS5L
6n2IjpdOpzDQEwQ1NRhr9WZNU4UqcY2owrVQ86kwggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
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
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBH0wggR5AgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA/AjhQDqxUp9dIjHF
PqzhnDANBglghkgBZQMEAgMFAKCCAqEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwOTI4MDEwODMxWjBPBgkqhkiG9w0BCQQxQgRAdKoz/0Vv0EIbr4BdZuD3VS3P
l8KBySmdDeBiW0pnlpy9ZaEHVgRuhjIGKy4Ru4Vx8b+LqvHnHNrHjt4UJS6PXDCBkwYJKoZIhvcN
AQkPMYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUD
BAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgMwCwYJYIZIAWUD
BAICMAsGCWCGSAFlAwQCATAHBgUrDgMCGjCBvQYJKwYBBAGCNxAEMYGvMIGsMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA/AjhQDqxUp9dIjHFPqzhnDCBvwYLKoZIhvcN
AQkQAgsxga+ggawwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2Vj
dGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQD8COFA
OrFSn10iMcU+rOGcMA0GCSqGSIb3DQEBAQUABIIBAI5mSl6MCYiggiRf96OgO/Z98ZZyLaLTsZdY
5ROkWc8h436NkCJ9U2tu/1wPybltBQqDuyoLSTzcza2GRZOtIQlmzp8bOk0ZbXsxrBUV6RoEmDKY
tdsJPPWKvs3/2p/rs4yj347b1KDSUcCKGsFSI/eVPiZqNHT0NtchRYsYriOvv1NJbaW81PIut/iL
M9wnUF1Nwbx5DCjlqPB/D9CYgne8VgfNymIs/CpGKXrOxHkBiH80n0PuwSLUc9wPvU/Nh0VLgF11
H2DaJ9hjq2/WAVH86wXzB4hj8AHrA7ofRUF2jlp0zxhoaM1VMXOIjUWljFIX8mBoCJSaRd+hpmNS
bgkAAAAAAAA=

------=_NextPart_000_002E_01D8D2A4.886A3180--
