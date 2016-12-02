References: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
 <7bcf3d70-494c-9fa1-8554-f746ef130b7c@xenomai.org>
 <CAMJ=MEcg43Sz1aT2K3J3LMEoBhRTj8cvZqCx1a9z5y5v+XNTgg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6bc41409-f538-a50a-ee7c-a0116f4ebaff@xenomai.org>
Date: Fri, 2 Dec 2016 19:33:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEcg43Sz1aT2K3J3LMEoBhRTj8cvZqCx1a9z5y5v+XNTgg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?q?Question_about_config_option_=E2=80=93mem-poo?=
 =?utf-8?q?l-size?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 12/02/2016 03:29 PM, Ronny Meeus wrote:
> On Fri, Dec 2, 2016 at 3:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 12/02/2016 02:03 PM, Ronny Meeus wrote:
>>> Hello
>>>
>>> Context: I'm using the pSOS interface over the Mercury core (version 3.0.3).
>>>
>>> I have a question about option:
>>> –mem-pool-size
>>> described on page
>>> http://xenomai.org/2015/05/application-setup-and-init/
>>>
>>> Is the parameter specifying the maximum size that will be used Xenomai
>>> or is this the initial value that will be used while creating the main
>>> memory pool.
>>>
>>> The explanation makes me think it is the first case while tests show
>>> that it is the
>>> latter case. e.g. the memory pool just extends when it is depleted.
>>>
>>
>> How do you check this?
> 
> I check it by creating a pSOS message queue in which I sent 100k messages.
> I see that this succeeds without errors.
> I have also put a trace in the tlsf heap code and I see it constantly extending.
> 
> This is the test application:
> 
> #include <psos.h>
> #include <stdio.h>
> 
> static void main_test_task(u_long a,u_long b,u_long c,u_long d)
> {
>         unsigned long qid, err;
>         int i;
>         unsigned long message_count = 100000;
>         unsigned long mesg[4];
> 
>         q_create("LINE",0,Q_NOLIMIT|Q_PRIOR,&qid);
>         for (i=0;i<message_count;i++)
>         {
>                 err = q_send(qid, mesg);
>                 if (err != 0)
>                     printf("Error: q_send err=%ld count=%d\n", err, i);
>         }
>         printf("SUCCESS: Test passed (nr messages sent=%ld)\n",message_count);
> 
>         while (1)
>                 tm_wkafter(1000);
> }
> 
> 
> int main(int argc, char * const *argv)
> {
>         unsigned long tid;
>         unsigned long args[4] = {0,0,0,0};
> 
>         t_create("MAIN",25,16000,16000,0,&tid);
>         t_start(tid,T_PREEMPT|T_TSLICE,main_test_task,args);
>         while (1)
>                 tm_wkafter(1000);
> }
> 
> 
> The unclean patch below solves the issue (to better understand the issue).
> Correct patch can be provided later.
> 
> I was introducing a config parameter that specifies whether the pool actually
> needs to grow or not. To be backwards compatible the default could be to grow.

The intent is to enforce a limit as specified by --mem-pool-size, just
like the malloc and pshared allocators do (see heapobj-malloc.c), since
there is no way to extend the heap without switching to secondary mode
with Cobalt. The tlsf_malloc() interface allocating the main pool
implicitly does not help with this.

I plan to phase out TLSF entirely, which has poor performances with
respect to memory fragmentation (the numbers are actually pretty ugly).
So either we live with the current state of affairs until TLSF is
replaced, or a trivial patch preventing the extension will do.

-- 
Philippe.

