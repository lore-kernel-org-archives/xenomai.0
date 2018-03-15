References: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5f063f66-df76-f7d4-c01e-aa7baadf3420@xenomai.org>
Date: Thu, 15 Mar 2018 09:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/15/2018 09:24 AM, Pintu Kumar wrote:
> Hi All,
> 
> I am trying to test rt_cond_bind() and rt_task_unblock() API with a
> simple thread program using the Xenomai native skin, and with xenomai
> 3.0.6.
> 
> But, during call to rt_task_unblock(&task1) from the main function, I
> get the segmentation fault.
> 

Use gdb to get more information about the crash.

> # ./cond_bin_test
> PINTU: Inside bind_test task....
> PINTU: Before rt_task_unblock
> Segmentation fault (core dumped)
> 
> This is the code snippet for the program:
> 
> void bind_test(...)
> {
>         ....
>         err = rt_cond_bind(&cond, "COND1", TM_INFINITE);
>         if (err == -EINTR)
>                printf("error....");
> }
> 
> int main(...)
> {
>          ....
>          rt_task_create(&bind_test, .....);
>          rt_task_start(&bind_test, .......);
> 
>          err = rt_task_unblock(&bind_test);
> 
>          rt_task_delete(&bind_test);
> 
> 
>          return 0;
> }
> 
> What is wrong with the above sample ?
> I suppose this code was working on Xenomai 2.6.x
> 
> If there is any thing missing please let me know.

Your full test code. Task descriptor definition and flags are missing.

-- 
Philippe.

