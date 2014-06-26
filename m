Message-ID: <53AC0D05.8050006@xenomai.org>
Date: Thu, 26 Jun 2014 14:07:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAC66z97kU7PZgPdHrJWxpePUtH68Lo5BRG7CgJJXx9gnhqaNVQ@mail.gmail.com>
In-Reply-To: <CAC66z97kU7PZgPdHrJWxpePUtH68Lo5BRG7CgJJXx9gnhqaNVQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_sem_create problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>, xenomai@xenomai.org

On 06/26/2014 11:49 AM, yogesh garg wrote:
> Hi,
> I want to protect my shared data structure in my kernel module. But when I
> am
> trying to call rt_sem_create(), my module makes system hang. Without
> rt_sem_create()
> call my code works fine.
> Please help me whats the problem with rt_sem_create().
>
> Code:-
>      RT_SEM mysem;
>    ret = rt_sem_create(mysem,"dsem",1,S_PRIO);
>    printk(" Return value of sem_create : %d \n",ret);
>
> ret value is success(0).
>

This is probably not your actual code, but rather some kind of 
pseudo-code, so don't expect much insight. Except perhaps that you 
should pay attention to the compiler warning such code must have produced.

-- 
Philippe.

