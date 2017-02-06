References: <c28ec7.1697.15a110b7694.Coremail.dreamtale90@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <681ccdf8-5b7f-e9e2-2047-d789b6e0d10c@xenomai.org>
Date: Mon, 6 Feb 2017 14:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <c28ec7.1697.15a110b7694.Coremail.dreamtale90@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fw:some API about RT_TASK occur Segmentation fault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "dreamtale90@163.com" <dreamtale90@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/06/2017 02:30 AM, dreamtale90@163.com wrote:
> System configuration:
> debian-8.6, 3.18.46-rt50
> Xenomai/mercury v3.0.3
> Build args: --with-core=mercury --enable-smp --enable-pshared
> 
> Now I am need help. Thanks.
> 
> 
> -------- Forwarding messages --------
> From: "dreamtale90@163.com" <dreamtale90@163.com>
> Date: 2017-02-04 12:04:15
> To: xenomai@xenomai.org
> Subject: some API about RT_TASK occur Segmentation fault
> Hi
>     During using API about RT_TASK I found some doubt.
> 1) rt_task_inquire(RT_TASK * task, RT_TASK_INFO * info ), if info is
> NULL will occur Segmentation fault, but in API reference this is valid.
> http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga53bad6acf5496f8008e594954507dce8
> 
> 2) After main task called rt_task_shadow(), program will create other
> tasks depend on request, but when create second task will  occur
> Segmentation fault.
> Now main task don't call  rt_task_shadow(), program will OK. I don't
> know why.
> 
> 3) I write a demo which create the same task three times as follows:
> #include <stdio.h>
> #include <unistd.h>
> #include <alchemy/task.h>
> RT_TASK task1;
> void func(void *arg)
> {
>  printf("enter func ...\n");
> }
> int main()
> {
>  rt_task_spawn(&task1, "task1", 0, 80, 0, func, NULL);
>  sleep(1);
>  rt_task_spawn(&task1, "task1", 0, 80, 0, func, NULL);
>  sleep(1);
>  rt_task_spawn(&task1, "task1", 0, 80, 0, func, NULL);
>  //rt_task_delete(&task1);
>  return 0;
> }
> 
> When the third time create , program will  occur Segmentation fault.
> 

This bug was fixed in the stable branch some time ago:
git://git.xenomai.org/xenomai-3.git, branch stable-3.0.x

-- 
Philippe.

