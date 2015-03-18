MIME-Version: 1.0
From: Pavel Anistratov <pavel903@gmail.com>
Date: Wed, 18 Mar 2015 19:29:20 +0600
Message-ID: <CAC=FX11y_maa8mAVRzBcymQxUHU+jQYPg7pnRBwM47-8vkPZWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] irqbench: irqloop device or resource busy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

2015-03-18 13:54 GMT+06:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Wed, Mar 11, 2015 at 08:48:59PM +0600, Pavel Anistratov wrote:
>> I=E2=80=99m trying to test interrupt handling from parallel port using i=
rqloop
>> program from irqbench, but when I try to start irqloop I get an error:
>> $ root@debian:/home/user/xenomai-2.6.4/src/testsuite/irqbench# ./irqloop=
 -i 1
>> $ irqloop: error starting test: Device or resource busy
>>
>> I loaded kernel module with modprobe xeno_irqbench command, but the
>> problem seems to occur during the first access command:
>> ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)
>> How to solve this problem?
>>
>> I=E2=80=99m using the last stable release Xenomai 2.6.4 and Debian 7.8
>> (wheezy) 32-bit with kernel 3.16.0
>
> Maybe the irq is already occupied by Linux parallel port driver and
> unloading it would avoid that?

Yes, in my case the problem was caused by conflict of irqbench.ko and
parport_pc module in place of irq request command:
err =3D rtdm_irq_request(&ctx->irq_handle,
    config->port_irq,
    rt_irqbench_task_irq, 0,
    "irqbench", ctx);
So, I removed the conflict module from the kernel (rmmod parport_pc)
and it solved the initial problem.

In my case interrupt handler hadn=E2=80=99t worked until I added the comman=
d
to enable irq:
err =3D rtdm_irq_enable(&ctx->irq_handle);
In the function rt_irqbench_check_irq I deactivate the check (if
(!(inb(STAT(ctx)) & STAT_BUSY))) since I was directly commuting the
pin 10 with a ground pin without use of a second computer.

--=20
Pavel

