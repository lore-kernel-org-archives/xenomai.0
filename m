MIME-Version: 1.0
In-Reply-To: <52CB23F5.6000006@xenomai.org>
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
 <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
 <52CB23F5.6000006@xenomai.org>
Date: Mon, 6 Jan 2014 13:52:28 -0800
Message-ID: <CAFnctWGwssFMPeLwhpJnob46rXwRDDxuj_Snoh6Cqs8cbRN2Cw@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jan 6, 2014 at 1:45 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 01/06/2014 08:10 PM, Nima Nourozi wrote:
> > Here is the task initialization code:
> >
> > *rtdm_printk("kicking of tasklet...\n");*
> > * retval =3D rtdm_task_init(&heartbeat_task, "spi_transfer",
> > xx_start_transfer, NULL, 99, 100000000 /* 100 ms */);*
> > * __ipipe_serial_debug("*******return value =3D %d\n", retval);*
> > * if(retval)*
> > * {*
> > * __ipipe_serial_debug("error initializing task: %i\n", retval);*
> > * }*
> >
> > Here is the task function:
> >
> > void xx_start_transfer(void *arg)
> > {
> >
> > int ret;
> >
> > while (1) {
> > ret =3D rtdm_task_wait_period();
> > __ipipe_serial_debug("*******return value =3D %d\n", ret);
> > gpio_set_value(LED, 1);
> > rtdm_task_sleep(0);
> > }
> > }
>
> I can not reproduce your problem, it works fine here. Could you post the
> full code of a simplified driver which triggers the problem ?
>
>
> --
>                                                                 Gilles.
>

Sure, please find it attached. It's just the standard atmel_spi.c with
task_init command added in atmel_spi_probe() function.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: atmel_spi.c
Type: text/x-csrc
Size: 31247 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140106/780270d=
d/attachment.c>
