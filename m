MIME-Version: 1.0
In-Reply-To: <1524043270.2300.2.camel@smigroup.net>
References: <1523454871.2312.15.camel@smigroup.net>
 <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
 <1523457598.2312.18.camel@smigroup.net>
 <627da48b-4a8d-e8e4-b521-a3fe99304cae@xenomai.org>
 <1524043270.2300.2.camel@smigroup.net>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 18 Apr 2018 18:47:59 +0530
Message-ID: <CAOuPNLj9WoyAbv3d6jZjaFto9FT+_ZnvH6Skkopd26Z_4Bs9+w@mail.gmail.com>
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
To: Mauro Salvini <mauro.salvini@smigroup.net>
Cc: xenomai <xenomai@xenomai.org>

Oh yes.
I was about to post the similar problem with rt_task_wait_period(NULL).

I did "git pull" for my xenomai-3 repo and installed the newer version.
After that weird things started happening to my previous test program
for latency measurement.
The latency value started giving all wrong results.
In my test programs I was using: rt_task_set_period(100 us) and
measuring latency with rt_task_wait_period(NULL).
But, now rt_task_wait_period() returns immediately.

Then, I reverted back the entire xenomai-3 to my older version.
And everything works fine for me.

So, it looks like there is some change happened in latest xenomai-3
repo, which disturbed the rt_task_wait_period API.

Please check, else all my previous efforts will go in vain.


Thanks,
Pintu



On Wed, Apr 18, 2018 at 2:51 PM, Mauro Salvini
<mauro.salvini@smigroup.net> wrote:
> On Wed, 2018-04-11 at 16:42 +0200, Philippe Gerum wrote:
>> On 04/11/2018 04:39 PM, Mauro Salvini wrote:
>> > On Wed, 2018-04-11 at 16:20 +0200, Philippe Gerum wrote:
>> > > On 04/11/2018 03:54 PM, Mauro Salvini wrote:
>> > > > Hi,
>> > > >
>> > > > I'm facing an unexpected behavior of rt_task_wait_period().
>> > > >
>> > > >
>> >
>> > ...
>> >
>> > > Please try this and let me know if the situation gets any better:
>> >
>> > Yes, now it works as expected.
>> >
>> > Thank you Philippe.
>> >
>> > Best regards.
>> >
>> > Mauro
>> >
>> >
>>
>> Ok, upstreamed. Thanks.
>>
>
> Hi Philippe,
>
> I resume this thread because when I tried your patch I tried only the
> case that didn't work, that is with SET_PERIOD undefined
> (so rt_task_set_periodic() not called), and didn't re-test also the
> code with rt_task_set_periodic() call. Sorry, my fault.
>
> With this patch applied, when I call rt_task_set_periodic() (SET_PERIOD
> defined), rt_task_wait_period() returns -EWOULDBLOCK as if
> rt_task_set_periodic() was never called.
>
> Thanks in advance, regards
>
> Mauro
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

