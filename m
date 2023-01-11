Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8617EA
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 20:33:56 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BJT4mx031848
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 12:33:55 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0149.outbound.protection.office365.us [23.103.199.149])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3n1k5k139w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 12:33:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=gazgRloeI2LhvnIiKbyTKqKiKwa44OZjOi3o4atvG4j+EmIljvqQJ8GDrpOPL3IAveXohf0U7ropU62pcMVpfthGpfXkSRrkuWmpaKTXUIdRd3pfoZWWvZmPJ2XhuvduMGGoOFP7FehZ+B0yw+0FcxergLwg5ix5vyGQ7Iupyxs9zcwZvxIIRqeKejPkAVgy7asEaYsF2sNnw8kv4WnlSwe+GsZuwTN+F5eAs3/8TcBmRysDH8CToH17iLETYMMzO6nR4Ag8VwtZKN6xwnmAuN9/AODQF1zxQBrWtFSd/J+eK/oXOHM6vJTB+liKp03EteDyR3UT2JXPewBPu4UsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q58Y+6y649WEj0kEYBh9oTu8XuotmL9Hr5synGrGdLI=;
 b=bHhEc6cvdUYuj4veHANDBKGpJrf7jSKwHYv/kdflJCo4e/8LpZazLAwtVTqIqcuLPfzoRYFlAVbyGz30t10cZr0uOQAGeANM8uYFDoHZcqphWxJ+jv1cNMaTIMcnnDz8hKMoBzwgTNwZcdJvElTsIONgPXiBWOL30zweMXbtL519pJsO9Hnva9ntg6adAIDjtkPEC3sSwWxijwQKje7Y3dQfmI/iHOOirzdz8NhP+AF4oDUsqpk0fZ7UzK9eSADuIlc41ulq7hN/Uucz4KxrZ8S61PKhK4TCMHKBs/QgvHZsJP7M323dv1sX8DV5tahcojAQ8HvP6Bith3k0Xw1orA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q58Y+6y649WEj0kEYBh9oTu8XuotmL9Hr5synGrGdLI=;
 b=BuSdMXNHy9lubxfHakuDdf7/7BpbUl8q1mlOoYIEZ+SBReG6yZR59E25+ebig2ORMOm/hMEddM4hPL2SwSflOoUMZRiyxdpV64/HD63zLy5nIW5lFFosATB7gyICXU/QB+APMKHfw0K59XnNoQBqSSSNfHna71Y4NDu4r3+8j/RT23G9oBFMCoUDunSNRNUN0iKJH+j+yvC9K6/JLVMNHECPmo0QIkrhttVCHpNXSR+eYDWT3ibtdRIu300ejwbAgwUplNRrpFaeEmIGHG1Poq4uuOQvlBvj3osnDzFw7rkxkZvqO4WyLjLCkw4ets7FlQDvrSE5ywN5GYQSymUg7w==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1130.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 11 Jan
 2023 20:33:52 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f260:75b3:f076:14cb]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f260:75b3:f076:14cb%4]) with mapi id 15.20.5944.019; Wed, 11 Jan 2023
 20:33:52 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>
Subject: RE: Conflicting EVL Processing Loops
Thread-Topic: Conflicting EVL Processing Loops
Thread-Index: Adkgi+LtPmHGHADoTpO4vPcK7ox9NgFSNX3AAAHH/gAAB7P/wA==
Date: Wed, 11 Jan 2023 20:33:52 +0000
Message-ID: 
 <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507C980109C793A20E6910E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1130:EE_
x-ms-office365-filtering-correlation-id: 1977d891-8b73-401b-1620-08daf4132706
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 84uo+FbZVcbBHCJ+gCFKdNTW59OgfcbyAS6bKj53UkH/cm1E9cBocAIPHbQX3+/thYta/BIYPjn3Dz+kbt/0w7c0FqTX6l0IRN9zL/OEvd0ucQcHPSSkvdW8FEcC3xYjY0VD1SJy2NRs3HVqduzGMf3pDu8U/EknzCKqZemWPiFTtYEZG5cWJy3DTamU29G+4P+6J40nuLf5z52PovVD2/k4cFSfgBJ8oYh4oHqf9QqYWI0jEpBa1SLJkjcepyrF6pdyK6YuVjPtjHnDoH7p7tb5V2s2mehZukCj8eAtheQMNVby6YaKzZ2Flg5XXZqIKvBSLgwj9jBLyG514RKL1liq5Eh+epdUu4hXy/b+8LBjffPz46BjdV1ZDxWcJ36ZEU461ozb/p1yqghRDzqf6Ls4mRLZV9FHmwmXN1k925kSLIZlVnejWD2tHpSdQ4vySowMSoN9OemArgAVrkzrNLQt0eHvITLVBSMGKQwtrt0R1JxYtZ32d21drd+5hC3NNROzU6z/a/FZcI5NZ6N70T6OG7dX1XxTOXr6rx2dsRpv3epcnT1zDMggQuPgCMts
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(39830400003)(366004)(136003)(451199015)(41320700001)(55016003)(6916009)(508600001)(33656002)(5660300002)(83380400001)(38070700005)(86362001)(122000001)(3480700007)(38100700002)(2940100002)(41300700001)(186003)(71200400001)(9686003)(44832011)(66556008)(7696005)(8676002)(52536014)(2906002)(107886003)(99936003)(6506007)(8936002)(76116006)(66446008)(64756008)(4326008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 ITaKVR8GvAr8OivlWGwxlujzS9rL28X4TQGZ1buU2PLfEdIiG3YBkFUr05SNtgyMVlB651r6hBJyhWtvb7ugPQyqco9kWHZx2Btydork/RIGRlg3+/3ZofNLjBy5sYW5gPai+P3YpatREI67qc+dmRqGVhpR32i7iYTWLK3TVo3gJqvhUaxNroFzeXpDeBjBCN3sTxyrbTcYMbxU82e35EYVg3XSBr9YLFZ7o8Nml8aLFQnvVZbPdS1JSgO3Ehs/4VMacpiy2+zEiEqAY3Dxs8HE6tIKjwrshdCKuCoV47C/jLM1vE+gHhrK3iGXH7UuFMIk50F5jWMTz1D+JW8ui2Xc6TdGZLARUaQYOImyaEw17CSNYRlPRNbXNPcApPusc8VRK5HRTaFZbrLEUjIga1caMEjPj5qhP/vRxu0eb+sndMqFslUtEQvtKZCEZmfrPHjsOLmseiiKdD0KyicOPlava2SWiaILJ23eMRmCQ3U=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_03DA_01D925C1.572EEFF0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kQaB1+4tYsxYk3U3ZzrDqXntngC9Aod+8VhksG6UlNmAgsjb3nAFzPCWYICXpL+O51q3PsbL1LeY7FGXTR+G5E5Hs+89NyAVC9u80xZrkgMim778mcCQmwFY5atYaMThrOLB4H4+KKChju+BKt9ql7YIl0S/MfWL66I021RuoLVW0NjnVpexdveDaEr/ieeQK7flA4Tme1/lhw4xZFLcP8pUJiUgtnQe3X+d2bGdEnnffZYSPDIuG+fd3PnEk6aTB9jjTmVIR4L7yxpJFImidnn/y582nwF12D3Fknb6DoIvK2oHcc7VDaaasRgnwL5D2kGGxEX5QxN0CZTzg8VlGl64/kDbpolIs1IQaY3gjIT9Ql6mcpt7dxMhdHV6MIzib6GgXxY7I618Zj2bY82yZqgmBvNQ/ESLVQp9xMxtJprCejdQImozPhcPUUILby706T4J2OIvJJYv+xcONkPVWLN1E2L9tMBMtZsxTWSGN4vVYuIFGq0aFoH02oseTuN95PaWxYK8rjmu2L3U9mv32EdUMb4SkktclPYOBao4qVkSamrLiZgRRAmEXgXK5zm/gAZAHqtDJkN1Z419142yY7JNOyi9U70YwaKILOWhCjs/fZTe4CAHaQdTnOqHtpFdZN51Cg8P4QKalKZZ9pya8oBR6JBXYZ8Jo3VKbQORSFb5qXNcAgmGD2tbd2i6vpmJEuejqHKBu4VjbddgWxXU/ajzO6xchBTMALBEQW5VIC4QW8mCSERKCiLIv77nAVRADyt5ZNSV59FzvS78XODIAQ==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1977d891-8b73-401b-1620-08daf4132706
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 20:33:52.2300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1130
X-Proofpoint-ORIG-GUID: ZGeHzLXYCdOOrjE3pnQq_ltfbbkDp_O9
X-Proofpoint-GUID: ZGeHzLXYCdOOrjE3pnQq_ltfbbkDp_O9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110152

------=_NextPart_000_03DA_01D925C1.572EEFF0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_03DB_01D925C1.572EEFF0"


------=_NextPart_001_03DB_01D925C1.572EEFF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I went ahead and put together a very simple test appllication that proves
what I am seeing when it comes to the EVL heap performance being
substantially slower than the Linux STL Heap. In the app, there are 2
pthreads that are attached to EVL and started one after the other. Each
thread creates/destroys 100k std::strings (which use new/delete behind the
scenes). The total thread time is calcluated and printed to the console
before the app shutsdown. If enabling the EVL heap, the global new/delete is
overridden to use the EVL Heap API.

Scenario 1 is an EVL application using the STL Heap. Build with the
following command: " g++ -Wall -g -std=c++11 -o test test.cpp
-I/opt/evl/include -L/opt/evl/lib -levl -lpthread". When this app is run on
my x86 system, I can see that the average time for the 2 threads to complete
is about 0.01 seconds.

Scenario 2 is an EVL application using the EVL Heap. Build with the
following command: " g++ -Wall -g -std=c++11 -o test test.cpp
-I/opt/evl/include -L/opt/evl/lib -levl -lpthread -D EVL_HEAP". When this
app is run on my x86 system, I can see that the average time for the 2
threads to complete is about 0.8 seconds.

This is a very simple example, but even here we can see that there is a
significant slow down using the EVL heap. That is only magnified when
running our much more complex application.

Is this expected behavior out of the EVL heap? If so, is using multiple EVL
heaps the recommendation? If not, where do we think the problem lies?


Thanks,

Russell


------=_NextPart_001_03DB_01D925C1.572EEFF0
Content-Type: application/octet-stream;
	name="test.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test.cpp"

#include <evl/evl.h>=0A=
#include <evl/thread.h>=0A=
#include <evl/clock.h>=0A=
#include <evl/heap.h>=0A=
#include <thread>=0A=
#include <unistd.h>=0A=
#include <system_error>=0A=
=0A=
static char heap_storage[EVL_HEAP_RAW_SIZE(1024 * 1024)]; /* 1Mb heap */=0A=
static struct evl_heap runtime_heap;=0A=
=0A=
#if defined(EVL_HEAP)=0A=
void* operator new(std::size_t n)=0A=
{=0A=
    void* mem =3D evl_alloc_block(&runtime_heap, n);=0A=
    if (mem =3D=3D nullptr)=0A=
    {=0A=
        throw std::bad_alloc();=0A=
    }=0A=
    return mem;=0A=
}=0A=
void* operator new(std::size_t n, const std::nothrow_t& nothrow_value) =
noexcept=0A=
{=0A=
    return evl_alloc_block(&runtime_heap, n);=0A=
}=0A=
void operator delete(void* p) noexcept=0A=
{=0A=
    if (p =3D=3D nullptr)=0A=
    {=0A=
        return;=0A=
    }=0A=
    evl_free_block(&runtime_heap, p);=0A=
}=0A=
=0A=
void* operator new[](std::size_t n)=0A=
{=0A=
    void* mem =3D evl_alloc_block(&runtime_heap, n);=0A=
    if (mem =3D=3D nullptr)=0A=
    {=0A=
        throw std::bad_alloc();=0A=
    }=0A=
    return mem;=0A=
}=0A=
void* operator new[](std::size_t n, const std::nothrow_t& nothrow_value) =
noexcept=0A=
{=0A=
    return evl_alloc_block(&runtime_heap, n);=0A=
}=0A=
void operator delete[](void *p) noexcept=0A=
{=0A=
    if (p =3D=3D nullptr)=0A=
    {=0A=
        return;=0A=
    }=0A=
    evl_free_block(&runtime_heap, p);=0A=
}=0A=
#endif=0A=
=0A=
namespace=0A=
{=0A=
    const size_t NUM_ALLOCS =3D 100000;=0A=
}=0A=
=0A=
double tdiff(const struct timespec& ta, const struct timespec& tb)=0A=
{=0A=
    double sdiff;=0A=
    double nsdiff;=0A=
    =0A=
    if (ta.tv_nsec >=3D tb.tv_nsec)=0A=
    {=0A=
        nsdiff =3D double(ta.tv_nsec - tb.tv_nsec) / 1e9;=0A=
        sdiff =3D double(ta.tv_sec - tb.tv_sec);=0A=
    }=0A=
    else=0A=
    {=0A=
        // Borrow required.=0A=
        nsdiff =3D double(ta.tv_nsec+1000000000 - tb.tv_nsec) / 1e9;=0A=
        sdiff =3D double((ta.tv_sec-1) - tb.tv_sec);=0A=
    }=0A=
    return(sdiff + nsdiff);=0A=
}=0A=
=0A=
void* Thread1(void*)=0A=
{=0A=
    pthread_setname_np(pthread_self(), "Thread1");=0A=
=0A=
    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread1");=0A=
=0A=
    evl_printf("Thread 1 woken up\n");=0A=
=0A=
    // Get start time=0A=
    struct timespec tstart;=0A=
    evl_read_clock(EVL_CLOCK_MONOTONIC, &tstart);=0A=
=0A=
    // Allocate=0A=
    for (size_t i =3D 0; i < NUM_ALLOCS; i++)=0A=
    {=0A=
        std::string msg =3D "This is a test string";=0A=
    }=0A=
=0A=
    // Get end time=0A=
    struct timespec tend;=0A=
    evl_read_clock(EVL_CLOCK_MONOTONIC, &tend);=0A=
=0A=
    // Calculate total time=0A=
    evl_printf("Thread 1 Total Time: %f\n", tdiff(tend, tstart));=0A=
=0A=
    return nullptr;=0A=
}=0A=
=0A=
void* Thread2(void*)=0A=
{=0A=
    pthread_setname_np(pthread_self(), "Thread2");=0A=
=0A=
    evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
"Thread2");=0A=
=0A=
    evl_printf("Thread 2 woken up\n");=0A=
=0A=
    // Get start time=0A=
    struct timespec tstart;=0A=
    evl_read_clock(EVL_CLOCK_MONOTONIC, &tstart);=0A=
=0A=
    // Allocate=0A=
    for (size_t i =3D 0; i < NUM_ALLOCS; i++)=0A=
    {=0A=
        std::string msg =3D "This is a test string";=0A=
    }=0A=
=0A=
    // Get end time=0A=
    struct timespec tend;=0A=
    evl_read_clock(EVL_CLOCK_MONOTONIC, &tend);=0A=
=0A=
    // Calculate total time=0A=
    evl_printf("Thread 2 Total Time: %f\n", tdiff(tend, tstart));=0A=
=0A=
    return nullptr;=0A=
}=0A=
=0A=
int main(int argc, char *argv[])=0A=
{=0A=
#if defined(EVL_HEAP)=0A=
    printf("Using EVL Heap\n");=0A=
#else=0A=
    printf("Using STL Heap\n");=0A=
#endif=0A=
=0A=
    // Init EVL=0A=
    int ret =3D evl_init();=0A=
    if (ret)=0A=
    {=0A=
        printf("EVL Init failed with error: %d\n", ret);=0A=
        return -1;=0A=
    }=0A=
=0A=
    ret =3D evl_init_heap(&runtime_heap, heap_storage, sizeof =
heap_storage);=0A=
    if (ret)=0A=
    {=0A=
        printf("EVL Heap Init failed with error: %d\n", ret);=0A=
        return -1;=0A=
    }=0A=
=0A=
    // Thread 1=0A=
    pthread_attr_t tattr;=0A=
    sched_param param;=0A=
    pthread_t tid;=0A=
    cpu_set_t tkcpu;=0A=
    CPU_ZERO(&tkcpu);=0A=
    CPU_SET(1, &tkcpu);=0A=
    pthread_attr_init(&tattr);=0A=
    pthread_attr_getschedparam(&tattr, &param);=0A=
    pthread_attr_setstacksize(&tattr, 1024*1024);=0A=
    pthread_attr_setaffinity_np(&tattr, sizeof(cpu_set_t), &tkcpu);=0A=
    pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);=0A=
    param.sched_priority =3D 83;=0A=
    pthread_attr_setschedparam(&tattr, &param);=0A=
    pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);=0A=
    pthread_create(&tid, &tattr, Thread1, NULL);=0A=
=0A=
    // Thread 2=0A=
    pthread_attr_t tattr2;=0A=
    sched_param param2;=0A=
    pthread_t tid2;=0A=
    cpu_set_t tkcpu2;=0A=
    CPU_ZERO(&tkcpu2);=0A=
    CPU_SET(2, &tkcpu2);=0A=
    pthread_attr_init(&tattr2);=0A=
    pthread_attr_getschedparam(&tattr2, &param2);=0A=
    pthread_attr_setstacksize(&tattr2, 1024*1024);=0A=
    pthread_attr_setaffinity_np(&tattr2, sizeof(cpu_set_t), &tkcpu2);=0A=
    pthread_attr_setschedpolicy(&tattr2, SCHED_FIFO);=0A=
    param2.sched_priority =3D 82;=0A=
    pthread_attr_setschedparam(&tattr2, &param2);=0A=
    pthread_attr_setinheritsched(&tattr2, PTHREAD_EXPLICIT_SCHED);=0A=
    pthread_create(&tid2, &tattr2, Thread2, NULL);=0A=
=0A=
    sleep(5); // sleep for a bit=0A=
=0A=
    pthread_join(tid, NULL);=0A=
    pthread_join(tid2, NULL);=0A=
=0A=
    return 0;=0A=
}
------=_NextPart_001_03DB_01D925C1.572EEFF0--

------=_NextPart_000_03DA_01D925C1.572EEFF0
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
9w0BCQUxDxcNMjMwMTExMjAzMzUwWjAvBgkqhkiG9w0BCQQxIgQgMIuxe1BRY5aBYGe2zsZVTpoD
/8qsFW5exV2O3YZhMqUwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCb
ltOzXpTyTa8+etxA/yACIGwOcKoESKCZrobcWknRVxQNJs8KAJt3VdnXdhxlvatkPPDgUUIm+dqY
cP+1BKSFD1By0vfxxlk2tfBCIoQ6Dx+wFp2GlBVNcj4zv/l9iV0Zbl675SmTz1R/3gMzIuzP6AtA
qzx3/ViLi8aM73GkJMTPxUFn9Ik5llW2pGbepgvyqzf5ZS2X17j3uDc0iEnUlKQjWhiZ8gplWjas
duiF8JevUJCZwtVNYocqzvddBejwb361N32JrsXTX0zVa1wW61FUgL5jONzO+KAA/v/4kCksD94J
0kyqI13utqAhAaj2YP6t511R1hNqw2yzES9QAAAAAAAA

------=_NextPart_000_03DA_01D925C1.572EEFF0--
