MIME-Version: 1.0
From: =?UTF-8?B?7J207ISd7ZuI?= <koon@rainbow.re.kr>
Date: Sun, 22 Jan 2017 13:12:55 +0900
Message-ID: <CAJEimAzwYvDuHkSeEzUibkg8oZHX1QNqUNgAzh5SM_+8sPM_vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Looking for help regarding implementing shared memory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I'm new to Xenomai and RT in general. I have some trouble using rtheap
functions.

Xenomai version I'm using is 3.0.2 (no ipipe patch), with linux kernel
4.1.18, I'm using Cobalt mode, and using native skin when building.

I'm trying to use shared memory and it is not working.

On program A, I call
============================
int err;
    rt_printf("heap create start\n");

    err = rt_heap_create(&heap_desc, "SHM001", 1024, H_SINGLE | H_NONCACHED
| H_SHARED);
    if(err<0) rt_printf("create_error = %d\n", err);

    rt_heap_bind(&heap_desc, "SHM001", TM_INFINITE);

    err = rt_heap_alloc(&heap_desc, 0, TM_INFINITE, &shm_area);
    if(err<0) rt_printf("alloc error = %d\n", err);
    rt_printf("rt_heap_alloc got : %x\n", shm_area);
    char myString[10] = "test\0";

    memcpy(shm_area, myString, 5);

    rt_printf("heap create end\n");

and this works fine, on program B, I call
=====================================
    RT_HEAP desc;
    void *shm;

    int err;

    rt_printf("heap create start\n");
    err = rt_heap_bind(&desc, "SHM001", TM_INFINITE);

    if(err) rt_printf("failed: %d\n", err);

    err = rt_heap_alloc(&desc, 0, TM_INFINITE, &shm);
    if(err) rt_printf("alloc failed: %d\n", err);

    rt_printf("heap create end\n");
    rt_printf("content:: %s\n", shm);

and rt_heap_bind would not go. When I try this using TM_NONBLOCK, it
returns -11 and it looks like program B cannot find the symbol "SHM001"

Could you help me with this? I think there should be anything I'm missing
and I cannot find any logs from kern.log or syslog which I can use.

Thank you very much.
Koon
