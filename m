Message-ID: <556867E6.4040608@free.fr>
Date: Fri, 29 May 2015 15:21:42 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_heap_alloc fails in shared session mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

The next code snippet fails in session mode.
I can create and allocate heaps from a program.
In another one, I can bind , but rt_heap_inquire fails with Invalid 
argument.
Or I can use rt_alloc_heap with it. But when accessing memory, a bus 
error is trapped.


     //err = rt_heap_bind(heap_desc[module],module,TM_INFINITE);
     err = rt_heap_bind(heap_desc[module],module,TM_INFINITE);
     if (err != 0)
          {
          printf("can not bind %s [%s]\n",module,strerror(-err));
          return (void *) -1;
          }


//    err = rt_heap_inquire(heap_desc[module],&info);
//    if (err != 0) {
//        printf("can not inquire info about %s 
[%s]\n",module,strerror(-err));
//        return (void *) -1;
//        }
//      printf("size %d\n,",info.heapsize);

     err = rt_heap_alloc((RT_HEAP *)heap_desc[module],4288,TM_INFINITE, 
&shmem);
     if (err == 0)
         {
         return shmem;
         }
     else {
          printf("can not alloc %s [%s]\n",module,strerror(-err));
          return (void *) -1;
          }

Regards,
S.Ancelot

