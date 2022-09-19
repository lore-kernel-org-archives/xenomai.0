Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C16746D
	for <xenomai@lists.linux.dev>; Mon, 19 Sep 2022 22:00:40 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JInRDw000703
	for <xenomai@lists.linux.dev>; Mon, 19 Sep 2022 14:38:58 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0144.outbound.protection.office365.us [23.103.199.144])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3jnddatmm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Mon, 19 Sep 2022 14:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=oeBcRM4KXNCg1b98ewc5Xh3okkX4BJnQ4b+x9Ph2TGiwbfNzDXdyXKHRiWK/RyQj9dlW6u1hA5aBoF8GiALJOQpa9lO3kj3Crfdamrc2D16B80dgrV6NkbTS5uC6aC2gc0bU8NC9/EKcyfcWUVjjh5rww0WzLuo8LI3kAbIc5mrNBh4oKqkE8Xh7qXUFtMks5muK6d8Wt+E9GRBkgY9SXhFoh2FLevjsa+LN0nHPrGqxrd8sZ54t+DuIaZD2YY1+wHfUcLdP9LPhvukuNgztBb+adTBDsNVaNbCEKBAk4TYk9eaekXa4HuxYBzxPjG6cLiMFAsnkDdr6vVvloTvzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih4AiJfY6fuFdJptGyF3uB/0M28+RkA1MMKz+5vAMOE=;
 b=EMkSMMXK3s/QEOL74RsXWUVBXPAeR9JwCSH6YJKXFPsggxqsZ7FMn74C5doiYN39CEI4+zEs3mOPk1GBhY0n5ORONffp0SoqvUP1q8y9CH36KEaW19VGRSZ9Np74ryY7hbRxOOcCJN99SYPqh882PSCtJLGmxUGaTHYnH9VQgNZJdmbDot4N2Wu4I0bc/Tc9PY6ai4QsPjU1oCAYjFUAQdJP763Yp6Qi/IEgnq1QV3brFPQzydQlzM/Vs1CUOoIkBSSjJEOV3RPVldhLn7VN7fkmCuZSMrfQxPRblXL1IJfh9QBJB9DKV2g9n2qSCsWHhCO+86iG0XzRzr+TXLAOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih4AiJfY6fuFdJptGyF3uB/0M28+RkA1MMKz+5vAMOE=;
 b=Z+5s8aWIedRzj9dLgwyF6Hgkq9BBt25e6zVfLNcHvZMxmnsoiSM0cuCNR3PchOt27w4GYtGjWNBfCCc/bQur/nVGDyMVradm/D6lryizFx/My1xxwS9VZM+utUGl/jDjNRSfV73o/4T55j/ZeIOVV7LdJlqXdvkn3UCd9hYxeW8hLACotb2W5dHF7W5t8/SBAS/YOgHqPQnUutIxB7vCqsle9uglK19+Mghnd0XZcYINmwyYL55hgBLG6Cwy9Bfbajt2x3ugorFzuCRwrsUVJKnsa0krIsYmW37rg8VZTzeiTWdhACiEegSgZQK/dtQYBM4mUHeHRicpi/gin0H0yw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1524.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 21:38:54 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c%5]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 21:38:54 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: System hanging when using condition variables
Thread-Topic: System hanging when using condition variables
Thread-Index: AdjMb2kqEi/6rzVHQeiyZvhBQUhKew==
Date: Mon, 19 Sep 2022 21:38:54 +0000
Message-ID: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1524:EE_
x-ms-office365-filtering-correlation-id: 017aa9a5-7aaa-48bb-92ad-08da9a8759bc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vBvgbDwIe7LlIQPko+FEjw4IDF/5v3XmmIedZuexm4IMFzM2iuoaAobq/srYbKoeEAa3LyEmPRRfdAzVMW9G2vh77pA1zypxQ9SifsYO2iOJ3WFTZ6xkNs+hMmhiCpSQtzQnsO5E0FldxsFh8xzrFlWLIuAEQJgN+DUusQ4xwO7mMyV4QzcZW38akHqeB61ifO5BQJ5LRr2imRKo6ARUj+aukpIpRaFy2wW86MLoP/PzW1cDXVb1NXrWnjf0MD3NTAzl/uRTHpN3asyTShH8jel7pCuILgKXgob8l3KHixY79VHbKrlvbLXkqcHC70WJzxu+dvfG1dX6gez+4D1xXhS9fdY0+IJJk+z/zsJ8AAQaLzD4vKl8YLez6sv2EEQCVWwhHJiu+DCbWZPRK3aEsa5npFXHt2JxmND+w0bH5aT77dJ4YpuatdckZfsBhakAtAjeoNmXGozaRHWoCIRvvrZySBYzsMWzenzOMzd5bvHYXX9q+jiVFXzSMzq0WJnbdRzplMis8I0vODecGyWDlywp/MUcE5Vmd/tjMjuTfVSsCWtWF66YO6ieHmX4X8+uGv2xwrjklVzgS4OepKjBsadDwDivbOJmj2ulxHHY3mkR5g3JJzGmAUPGFhRyZvwG8nbMM1R0qRgtJCRmQ2fA/moTimhwB/IHYO0phctlYcNwop9sRt5VeGZ+4/UXSy9j
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(33656002)(122000001)(86362001)(44832011)(5660300002)(52536014)(9326002)(38100700002)(99936003)(38070700005)(83380400001)(2906002)(186003)(26005)(498600001)(9686003)(71200400001)(6506007)(7696005)(76116006)(66946007)(66556008)(66476007)(66446008)(4744005)(55016003)(8936002)(8676002)(64756008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 3TwRmsFPFBOX3g07w8nIf3iNwUrqqFBaZ6AdKxItlYqEWCJ/NVFE5ohVVtX+v3I9Bb60nCgZCJcYJRA3JWKfKjSOT6W2pf5S9iqsLmvVJGMPSLF1pUwTPuQ9gUxFb5CXzf5FqRn+8aw5THOZ0N7ZHso5Gi50zs+jFdVRS+e/wmr3qTjhlbdn10/QPVBfGKf4N6JfIWc2/obSySEpHRP7411svT/XJyBVH/ONaxhv4FaWk/4F+ZE6KdqaRk+ZUz0vnUU9kxqkgVHO/UlZ0csYpd+jdUkrp064VLOnxRW5o8HsWAGEJwZ6VS3luz0w9OFpqSyjeyIsuJT2+qUHOmX8YLRIJMvT2kuJGe5U/a2kEmElqX+42z+jmZ6jrHShlyYvFDHObSisg5J5sg1/9XuByMINaIgRs+/9AUroi2r5LYs=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0034_01D8CC3D.EA033620"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 017aa9a5-7aaa-48bb-92ad-08da9a8759bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 21:38:54.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1524
X-Proofpoint-ORIG-GUID: rDwJK_3FxWdJ0-TEDw4cawov_7OB9suI
X-Proofpoint-GUID: rDwJK_3FxWdJ0-TEDw4cawov_7OB9suI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190144

------=_NextPart_000_0034_01D8CC3D.EA033620
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0035_01D8CC3D.EA033620"


------=_NextPart_001_0035_01D8CC3D.EA033620
Content-Type: multipart/alternative;
	boundary="----=_NextPart_002_0036_01D8CC3D.EA033620"


------=_NextPart_002_0036_01D8CC3D.EA033620
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I have been trying to debug an issue in our app where the entire system
hangs with the following error from the kernel: "kernel:watchdog: BUG: soft
lockup - CPU#0 stuck for 22s! [kworker/0:2:594]". This happens consistently
on every run. I was able to strip down all of the relevant code into a
simple standalone app that only uses 4 pthreads, 3 EVL events, and 3 EVL
mutexes if you would like to be able to re-create the issue (I have attached
the test file). Is there anything fundamentally flawed in this logic (the
same logic worked fine previously with STL condition variables and STL
mutexes)? It appears that there becomes some kind of deadlock in the kernel
due to an EVL event and/or EVL mutex. Let me know if there is any more
information that I can provide you to help clear up the scenario. I have
spent multiple weeks tracking this issue with no luck so far.

 

Thanks,

 

Russell


------=_NextPart_002_0036_01D8CC3D.EA033620
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I have been =
trying to debug an issue in our app where the entire system hangs with =
the following error from the kernel: &#8220;kernel:watchdog: BUG: soft =
lockup - CPU#0 stuck for 22s! [kworker/0:2:594]&#8221;. This happens =
consistently on every run. I was able to strip down all of the relevant =
code into a simple standalone app that only uses 4 pthreads, 3 EVL =
events, and 3 EVL mutexes if you would like to be able to re-create the =
issue (I have attached the test file). Is there anything fundamentally =
flawed in this logic (the same logic worked fine previously with STL =
condition variables and STL mutexes)? It appears that there becomes some =
kind of deadlock in the kernel due to an EVL event and/or EVL mutex. Let =
me know if there is any more information that I can provide you to help =
clear up the scenario. I have spent multiple weeks tracking this issue =
with no luck so far.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Russell<o:p></o:p></p></div></body></html>
------=_NextPart_002_0036_01D8CC3D.EA033620--

------=_NextPart_001_0035_01D8CC3D.EA033620
Content-Type: application/octet-stream;
	name="test.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test.cpp"

// g++ -Wall -g -o test test.cpp -I/opt/evl/include -L/opt/evl/lib -levl =
-lpthread

#include <evl/evl.h>
#include <evl/thread.h>
#include <evl/clock.h>
#include <thread>
#include <unistd.h>
#include <system_error>

namespace
{
    evl_event e1;
    evl_event e2;
    evl_event e3;

    struct evl_mutex m1;
    struct evl_mutex m2;
    struct evl_mutex m3;
}

void* Thread1(void*)
{
    pthread_setname_np(pthread_self(), "Thread1");

    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread1");

    while (true)
    {
        evl_usleep(100000);

        evl_printf("Thread 1 woken up\n");

        /* Broadcast Event 1 */

        // Lock mutex
        evl_lock_mutex(&m1);

        // Broadcast event
        evl_broadcast_event(&e1);

        // Unlock mutex
        evl_unlock_mutex(&m1);
    }
}

void* Thread2(void*)
{
    pthread_setname_np(pthread_self(), "Thread2");

    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread2");

    while (true)
    {
        /* Wait for event 1 */

        // Lock mutex
        evl_lock_mutex(&m1);

        // Wait
        evl_wait_event(&e1, &m1);

        // Unlock mutex
        evl_unlock_mutex(&m1);

        evl_printf("Thread 2 woken up\n");

        /* Signal Event 2 */

        // Signal 50 events
        for (size_t i =3D 0; i < 50; i++)
        {
            // Lock mutex
            evl_lock_mutex(&m2);

            // Signal
            evl_signal_event(&e2);

            // Unlock mutex
            evl_unlock_mutex(&m2);
        }
    }
}

void* Thread3(void*)
{
    pthread_setname_np(pthread_self(), "Thread3");

    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread3");

    while (true)
    {
        /* Wait for Event 2 */

        // Lock mutex
        evl_lock_mutex(&m2);

        // Wait
        evl_wait_event(&e2, &m2);

        // Unlock mutex
        evl_unlock_mutex(&m2);

        evl_printf("Thread 3 woken up\n");

        /* Broadcast Event 3 */

        // Lock mutex
        evl_lock_mutex(&m3);

        // Broadcast event
        evl_broadcast_event(&e3);

        // Unlock mutex
        evl_unlock_mutex(&m3);
    }
}

void* Thread4(void*)
{
    pthread_setname_np(pthread_self(), "Thread4");

    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread4");

    while (true)
    {
        /* Wait for Event 3 */

        // Lock mutex
        evl_lock_mutex(&m3);

        // Wait for 50 signals
        for (size_t i =3D 0; i < 50; i++)
        {
            evl_wait_event(&e3, &m3);
        }

        // Unlock mutex
        evl_unlock_mutex(&m3);

        evl_printf("Thread 4 woken up\n");
    }
}

int main(int argc, char *argv[])
{
    // Init EVL
    int ret =3D evl_init();
    if (ret !=3D 0)
    {
        printf("EVL Init failed with error: %d\n", ret);
        return -1;
    }

    // Setup events
    evl_create_event(&e1, EVL_CLOCK_MONOTONIC, EVL_CLONE_PRIVATE, "Event =
1");
    evl_create_event(&e2, EVL_CLOCK_MONOTONIC, EVL_CLONE_PRIVATE, "Event =
2");
    evl_create_event(&e3, EVL_CLOCK_MONOTONIC, EVL_CLONE_PRIVATE, "Event =
3");

    // Setup mutexes
    evl_create_mutex(&m1, EVL_CLOCK_MONOTONIC, 0, =
EVL_MUTEX_NORMAL|EVL_CLONE_PRIVATE, "Mutex 1");
    evl_create_mutex(&m2, EVL_CLOCK_MONOTONIC, 0, =
EVL_MUTEX_NORMAL|EVL_CLONE_PRIVATE, "Mutex 2");
    evl_create_mutex(&m3, EVL_CLOCK_MONOTONIC, 0, =
EVL_MUTEX_NORMAL|EVL_CLONE_PRIVATE, "Mutex 3");

    // Thread 1
    pthread_attr_t tattr;
    sched_param param;
    pthread_t tid;
    cpu_set_t tkcpu;
    CPU_ZERO(&tkcpu);
    CPU_SET(1, &tkcpu);
    pthread_attr_init(&tattr);
    pthread_attr_getschedparam(&tattr, &param);
    pthread_attr_setstacksize(&tattr, 1024*1024);
    pthread_attr_setaffinity_np(&tattr, sizeof(cpu_set_t), &tkcpu);
    pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);
    param.sched_priority =3D 83;
    pthread_attr_setschedparam(&tattr, &param);
    pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);
    pthread_create(&tid, &tattr, Thread1, NULL);

    // Thread 2
    pthread_attr_t tattr2;
    sched_param param2;
    pthread_t tid2;
    cpu_set_t tkcpu2;
    CPU_ZERO(&tkcpu2);
    CPU_SET(2, &tkcpu2);
    pthread_attr_init(&tattr2);
    pthread_attr_getschedparam(&tattr2, &param2);
    pthread_attr_setstacksize(&tattr2, 1024*1024);
    pthread_attr_setaffinity_np(&tattr2, sizeof(cpu_set_t), &tkcpu2);
    pthread_attr_setschedpolicy(&tattr2, SCHED_FIFO);
    param2.sched_priority =3D 82;
    pthread_attr_setschedparam(&tattr2, &param2);
    pthread_attr_setinheritsched(&tattr2, PTHREAD_EXPLICIT_SCHED);
    pthread_create(&tid2, &tattr2, Thread2, NULL);

    // Thread 3
    pthread_attr_t tattr3;
    sched_param param3;
    pthread_t tid3;
    cpu_set_t tkcpu3;
    CPU_ZERO(&tkcpu3);
    CPU_SET(3, &tkcpu3);
    pthread_attr_init(&tattr3);
    pthread_attr_getschedparam(&tattr3, &param3);
    pthread_attr_setstacksize(&tattr3, 1024*1024);
    pthread_attr_setaffinity_np(&tattr3, sizeof(cpu_set_t), &tkcpu3);
    pthread_attr_setschedpolicy(&tattr3, SCHED_FIFO);
    param3.sched_priority =3D 81;
    pthread_attr_setschedparam(&tattr3, &param3);
    pthread_attr_setinheritsched(&tattr3, PTHREAD_EXPLICIT_SCHED);
    pthread_create(&tid3, &tattr3, Thread3, NULL);

    // Thread 4
    pthread_attr_t tattr4;
    sched_param param4;
    pthread_t tid4;
    cpu_set_t tkcpu4;
    CPU_ZERO(&tkcpu4);
    CPU_SET(4, &tkcpu4);
    pthread_attr_init(&tattr4);
    pthread_attr_getschedparam(&tattr4, &param4);
    pthread_attr_setstacksize(&tattr4, 1024*1024);
    pthread_attr_setaffinity_np(&tattr4, sizeof(cpu_set_t), &tkcpu4);
    pthread_attr_setschedpolicy(&tattr4, SCHED_FIFO);
    param4.sched_priority =3D 80;
    pthread_attr_setschedparam(&tattr4, &param4);
    pthread_attr_setinheritsched(&tattr4, PTHREAD_EXPLICIT_SCHED);
    pthread_create(&tid4, &tattr4, Thread4, NULL);

    // Do not exit so we can see stats
    while(true)
    {
        sleep(1);
    }

    return 0;
}
------=_NextPart_001_0035_01D8CC3D.EA033620--

------=_NextPart_000_0034_01D8CC3D.EA033620
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
9w0BCQUxDxcNMjIwOTE5MjEzODQ5WjAvBgkqhkiG9w0BCQQxIgQgSUvrxJXqS7CS8Ccfb2ycMgJg
aF+LrM1YuESshiIWHK4wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCJ
dV3/GuZTLkSMAZHJTwUCjS940MH2KwrR9vG/uG3Nca0ULqno5DyD45RWYKVq6rPt354YJSNLvp6o
yOn0fB5EKsDAWCjI2ftPKbi0P2EB0LO0b8nNiAsdUdf5MSpMuZzgXaOV1amKNGVE4f9MCioma6JU
kCkKEmkV1ty9bDS7j4LJnWMA5+J85Ni/Mk3zCwJ6OoioXEzn9pL8Qa7rewdrfWS1fvpe8ARx2U0a
VInBbQM+hsxWgk1Iqefxnp8EMLC+uYOBVFgVvo8QOpRMk/8vXBbyaVXbz6j186gLBOx8rgbamymD
HsmjAjDvGD6APkvfWQc4WRST6cf6SoRTVqxYAAAAAAAA

------=_NextPart_000_0034_01D8CC3D.EA033620--
