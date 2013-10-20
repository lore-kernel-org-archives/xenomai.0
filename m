Message-ID: <52638078.8090603@xenomai.org>
Date: Sun, 20 Oct 2013 09:04:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
	<CAMJ=MEcagp21eJ+O1eDZRfNoZEyGuXzV5ctEYj42UL7VFM70Dg@mail.gmail.com>
In-Reply-To: <CAMJ=MEcagp21eJ+O1eDZRfNoZEyGuXzV5ctEYj42UL7VFM70Dg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0 of 2] Xenomai-forge thread_obj: unset
 __THREAD_S_SAFE when not needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, Kim De Mey <kim.demey@gmail.com>
Cc: xenomai@xenomai.org

On 10/19/2013 08:42 PM, Ronny Meeus wrote:
>
>     test code snippet:
>
>     static void test_task(u_long a,u_long b,u_long c,u_long d)
>     {
>        while (1)
>          tm_wkafter(1000);
>     }
>
>     static void main_task(u_long a,u_long b,u_long c,u_long d)
>     {
>        u_long tid,args[4] = {0,0,0,0};
>        int i;
>        char name[32];
>
>        for (i=0;i<256;i++) {
>          printf("counter i: %d\n", i);
>          sprintf(name, "TEST_%d", i);
>          t_create (name,50,0,0,0,&tid);
>          t_start(tid,T_PREEMPT,test_task,args);
>          t_delete(tid);
>        }
>        t_create ("FAIL",95,0,0,0,&tid);
>        t_start(tid,T_PREEMPT,test_task,args);
>        t_delete(tid);
>
>        while (1) tm_wkafter(1000);
>     }
>
>     int main(int argc, char * const argv[])
>     {
>        u_long tid,args[4] = {0,0,0,0};
>
>        psos_long_names = 1;
>
>        mlockall(MCL_CURRENT | MCL_FUTURE);
>        copperplate_init(&argc,&argv);
>
>        t_create("MAIN",90,0,0,0,&tid);
>        t_start(tid,0,main_task, args);
>        while (1) tm_wkafter(1000);
>        return 0;
>     }
>
> Philippe,
> I think it would be good to add this test to the testsuite of xenomai
> since we discovered a bug in an earlier version of Xenomai forge already
> with exactly this test.

Makes sense. Please push a patch, I'll merge it.

Thanks,

-- 
Philippe.

