Date: Mon, 12 Mar 2018 18:45:09 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1182515752.3725277.1520873109725.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <CALLqZ8RWkkFLbt6=bYvEPP_BKCKcAwS0rU_+JCYAAMhFhkyQYg@mail.gmail.com>
References: <466115005.3631078.1520863793122.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8QkmhLRL+T=QmMDctCdrpQ+xw=7ntR0Pj5Pgt1nq4HNFQ@mail.gmail.com>
 <724564032.3685392.1520869318586.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RWkkFLbt6=bYvEPP_BKCKcAwS0rU_+JCYAAMhFhkyQYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] simple rtdm driver x86
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


could be the problem in loading out-of-tree module taints kernel.

yeti@yeti-UDOO-x86:~/develop/rtdm_hello$ dmesg|grep rtdm
[ 1536.073433] rtdm_hello: loading out-of-tree module taints kernel.
[ 1536.073532] rtdm_hello: module verification failed: signature and/or req=
uired key missing - tainting kernel
yeti@yeti-UDOO-x86:~/develop/rtdm_hello$ dmesg|grep RTDM
[ 1536.075500] RTDM gpio init.
[ 1536.075617] RTDM numero 266:



----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Monday, March 12, 2018 5:46:05 PM
Subject: Re: [Xenomai] simple rtdm driver x86

Use this https://xenomai.org/documentation/xenomai-3/html/xeno3prm/index.ht=
ml
for rtdm references going forward.  You are running Xenomai 3, but
using the docs for 2.6.

-Greg

On Mon, Mar 12, 2018 at 11:41 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =
=C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
<shevchenko.taras@triolcorp.com.ua> wrote:
> Xenomai 3
> It is work! Perfect!
> Now i have the same problem as below
> http://xenomai.org/pipermail/xenomai/2017-May/037361.html by Nitin Kulkar=
ni    and x86
>
> interrupt registered cat /proc/xenomai/irq
>
>
>   IRQ         CPU0        CPU1        CPU2        CPU3
>   266:           0           0           0           0         rtdm_hello
>
> but the handler is not invoked when I trigger the gpio pin.
> I found http://xenomai.org/documentation/xenomai-2.6/html/api/group__rtdm=
irq.html#gaf4e76db13d7f7aac4be2cae59e0097bc
> only RTDM_IRQTYPE_EDGE  option
> is there another trigger or another way to do it ?
>
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Monday, March 12, 2018 4:16:03 PM
> Subject: Re: [Xenomai] simple rtdm driver x86
>
> Are you using Xenomai 3 or 2?  I believe from your previous posts you
> are using Xenomai 3, include rtdm/driver.h , not rtdm_driver.h.
>
> -Greg
>
> On Mon, Mar 12, 2018 at 10:09 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=
=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> Hi,
>> could somebody share simple rtdm driver for begginers
>> better fo x86
>> I try to find it but almost for arm
>> and i have no such rtdm_driver.h
>> give an advice please should I start from ?
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

