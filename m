MIME-Version: 1.0
In-Reply-To: <53232310.2000506@xenomai.org>
References: <CAC-NLwzBXJ6BkmR+L-WnmJ04PnTba+7pbW2Y3nr7D30bozJzTA@mail.gmail.com>
 <5322D3B7.6000408@xenomai.org>
 <CAC-NLww-JD_q2pfW1L0EgxQGA6O400GcmYaQxsgvx7=oY9KD8A@mail.gmail.com>
 <53232310.2000506@xenomai.org>
Date: Sat, 15 Mar 2014 08:28:28 +0530
Message-ID: <CAC-NLwz1yNxh=zcGhNJO4BH=_Gi6TYsJbz3+Ery4==oLV4WDag@mail.gmail.com>
From: ashwin damle <ashwindamle@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Transfer data from a kernel module to user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello Gilles,

Yes, you are correct.

Sorry to bother you with trivial questions. I will start reading the
documentation you mentioned. Also, the e-mail sent to you was not
intentional. Sorry again.

Thanks for your help.

Ashwin


On 14 March 2014 21:11, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 03/14/2014 03:13 PM, ashwin damle wrote:
>
>> Hi Gilles,
>>
>> I got it working. Thanks for your help. I am very grateful to you. You
>> responded really fast.
>>
>> There is one more small doubt. I want the kernel module to run with
>> highest priority. I saw the APIs for setting priority but they refer to
>> rtdm_task_init() which is not used in my program tut01-skeleton-drv.c-so
>> how do I set priority?
>>
>
> You do not seem to understand much about C and kernel modules programming.
> I suggest you read some documentation, or buy some training on C language
> programming. When you are done, read the "Linux device drivers" book:
>
> https://lwn.net/Kernel/LDD3/
>
> Then come back to Xenomai, and start by reading the documentation here:
> http://xenomai.org/index.php/Included_documentation_summary
>
> Please do not send me private messages.
>
> --
>                                             Gilles.
>

Support the
