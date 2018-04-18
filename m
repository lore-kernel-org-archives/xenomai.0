MIME-Version: 1.0
In-Reply-To: <CALLqZ8T+pFjMOt9Oqruy+NJuVxcV_6YgaXq_2_HqYUV2ew-VAg@mail.gmail.com>
References: <1523454871.2312.15.camel@smigroup.net>
 <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
 <1523457598.2312.18.camel@smigroup.net>
 <627da48b-4a8d-e8e4-b521-a3fe99304cae@xenomai.org>
 <1524043270.2300.2.camel@smigroup.net>
 <CAOuPNLj9WoyAbv3d6jZjaFto9FT+_ZnvH6Skkopd26Z_4Bs9+w@mail.gmail.com>
 <CALLqZ8T+pFjMOt9Oqruy+NJuVxcV_6YgaXq_2_HqYUV2ew-VAg@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 18 Apr 2018 20:01:16 +0530
Message-ID: <CAOuPNLjvqxa+azvZhLzL4QEfs6J9ichrp2h--R5ffjimCffCEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] rt_task_wait_period() does not return -EWOULDBLOCK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

On Wed, Apr 18, 2018 at 7:15 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> What version was this working in?  I'm assuming you are working out of
> stable-3.0.x? If you reverted to an older git commit please post the
> commit.
>

Sorry, I don't remember the previous working versions.
My current xeno-config is:
# xeno-config --info
Xenomai version: Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
Linux 4.9.51-x86-64-mine-xeno3-rtdm #1 SMP Mon Apr 9 21:35:39 JST 2018
x86_64 x86_64 x86_64 GNU/Linux
Kernel parameters: initrd=0:\initrd.img-4.9.51-x86-64-mine-xeno3-rtdm
root=/dev/disk/by-partlabel/system ro ip=off
I-pipe release #4 detected
Cobalt core 3.0.6 detected
Compiler: gcc version 5.4.0 xxx
Build args:

With this it is working fine.

However, when I remove everything (/usr/xenomai/) and re-install the
latest xenomai-3 (pulled today), it shows problem.
I did not revert any specific commit and tried.
May be I can check that later.
Note: as of now the problem is seen only when using rt_task_wait_period(NULL).
         When I use rt_task_sleep() then it works fine.


Thanks,
Pintu



> -Greg
>
> On Wed, Apr 18, 2018 at 9:17 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> Oh yes.
>> I was about to post the similar problem with rt_task_wait_period(NULL).
>>
>> I did "git pull" for my xenomai-3 repo and installed the newer version.
>> After that weird things started happening to my previous test program
>> for latency measurement.
>> The latency value started giving all wrong results.
>> In my test programs I was using: rt_task_set_period(100 us) and
>> measuring latency with rt_task_wait_period(NULL).
>> But, now rt_task_wait_period() returns immediately.
>>
>> Then, I reverted back the entire xenomai-3 to my older version.
>> And everything works fine for me.
>>
>> So, it looks like there is some change happened in latest xenomai-3
>> repo, which disturbed the rt_task_wait_period API.
>>
>> Please check, else all my previous efforts will go in vain.
>>
>>
>> Thanks,
>> Pintu
>>
>>
>>
>> On Wed, Apr 18, 2018 at 2:51 PM, Mauro Salvini
>> <mauro.salvini@smigroup.net> wrote:
>>> On Wed, 2018-04-11 at 16:42 +0200, Philippe Gerum wrote:
>>>> On 04/11/2018 04:39 PM, Mauro Salvini wrote:
>>>> > On Wed, 2018-04-11 at 16:20 +0200, Philippe Gerum wrote:
>>>> > > On 04/11/2018 03:54 PM, Mauro Salvini wrote:
>>>> > > > Hi,
>>>> > > >
>>>> > > > I'm facing an unexpected behavior of rt_task_wait_period().
>>>> > > >
>>>> > > >
>>>> >
>>>> > ...
>>>> >
>>>> > > Please try this and let me know if the situation gets any better:
>>>> >
>>>> > Yes, now it works as expected.
>>>> >
>>>> > Thank you Philippe.
>>>> >
>>>> > Best regards.
>>>> >
>>>> > Mauro
>>>> >
>>>> >
>>>>
>>>> Ok, upstreamed. Thanks.
>>>>
>>>
>>> Hi Philippe,
>>>
>>> I resume this thread because when I tried your patch I tried only the
>>> case that didn't work, that is with SET_PERIOD undefined
>>> (so rt_task_set_periodic() not called), and didn't re-test also the
>>> code with rt_task_set_periodic() call. Sorry, my fault.
>>>
>>> With this patch applied, when I call rt_task_set_periodic() (SET_PERIOD
>>> defined), rt_task_wait_period() returns -EWOULDBLOCK as if
>>> rt_task_set_periodic() was never called.
>>>
>>> Thanks in advance, regards
>>>
>>> Mauro
>>>
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

