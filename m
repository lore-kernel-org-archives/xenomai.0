MIME-Version: 1.0
Date: Thu, 26 Jun 2014 15:19:56 +0530
Message-ID: <CAC66z97kU7PZgPdHrJWxpePUtH68Lo5BRG7CgJJXx9gnhqaNVQ@mail.gmail.com>
From: yogesh garg <yogesh.garg1983@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rt_sem_create problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I want to protect my shared data structure in my kernel module. But when I
am
trying to call rt_sem_create(), my module makes system hang. Without
rt_sem_create()
call my code works fine.
Please help me whats the problem with rt_sem_create().

Code:-
    RT_SEM mysem;
  ret = rt_sem_create(mysem,"dsem",1,S_PRIO);
  printk(" Return value of sem_create : %d \n",ret);

ret value is success(0).

-- 
Regards,
Yogesh Garg
