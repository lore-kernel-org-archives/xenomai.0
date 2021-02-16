MIME-Version: 1.0
References: <CAFZ-hKgMnKPh_SeQYs_YAWftF5XNLQWGDtEmSXrCaRqnm8fCbA@mail.gmail.com>
 <2090142485.8963531.1613484202750.JavaMail.zimbra@wolfram.com>
In-Reply-To: <2090142485.8963531.1613484202750.JavaMail.zimbra@wolfram.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Tue, 16 Feb 2021 15:24:03 +0100
Message-ID: <CAFZ-hKgyBZzUc0OP_zNiKCsY--3w8MWa15zTrmFiJ_q7QUxRoA@mail.gmail.com>
Subject: Re: Execution time
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

Thanks for the explanation.  Yes, I am using a Raspberry Pi 3, so in a
sense it is normal to have these "small" time differences.  I am running
only one periodic task (1ms period) and execution time between 5 and 10
micro seconds.

Il mar 16 feb 2021, 15:03 Per Oberg <pero@wolfram.com> ha scritto:

>
> ----- Den 16 feb 2021, p=C3=A5 kl 12:34, xenomai xenomai@xenomai.org skre=
v:
>
> > hi, I'm doing some tests. I'm measuring the execution time of a task. t=
he
> > task takes about 10us to complete. But I am noticing that it takes even
> > just over 5us at times. I therefore don't have a constant running time.
> > It's normal? maybe because the precision is of the order of micro
> seconds?
>
> It depends on
>  * The task, and it's priority
>  * How you are measuring time
>  * What hardware you are using
>  * What else is happening in the system
>
> If it's a fairly simple task it shouldn't vary to much, but if the task
> may or may not trigger some extra action. Modern complex CPU's have a lot
> of features that speeds things up for repetitive code. For example, the
> time of reading a memory buffer may depend on what was read before.
>
> If there are other high-priority tasks going on, or perhaps a hardware
> interrupt coming in your tasks execution may be delayed.
>
> Time measurement may differ depending on what functions you use. Some cal=
l
> the Linux clock, some use Xenomai based clocks.
>
> Depending on the hardware you may or may not be able to control exactly
> what is happening in your system. This is strictly from memory, but SMI
> interrupts on the PC platform is one such thing that is out of your hands=
.
> Raspberry Pi is another can of worms if I recall correctly. Firstly, ARM
> has regular interrupts and fast interrupts and I am not sure where Xenoma=
i
> makes the cut. Then there is the broadcom chip of the RPi that I think ha=
s
> some handling of the USB that you don't have control over.
>
> Per =C3=96berg
>
