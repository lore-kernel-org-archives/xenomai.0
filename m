From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Wed, 10 Aug 2011 18:10:02 -0300
References: <201108101449.54243.carlosnov@domain.hid>
	<201108101657.58176.carlosnov@domain.hid>
In-Reply-To: <201108101657.58176.carlosnov@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108101810.02640.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello again.
I traced the errors down and now dicovered that calling printf (as it would=
=20
be) turns a real time task in a non real time one. so I chaged the code and=
 it=20
is almost working as expected, except for something that now seens to be so=
me=20
kind of bug. If I use any sord of rtdm_event_[timed,]wait, the app returns =
and=20
there is a trace on kernel about a null pointer, just after the call to wai=
t.=20
It seens similar with
<http://www.mail-archive.com/xenomai@xenomai.org>
And I there is no other references on google. So I will try to recompile wi=
th=20
some changes and maybe test with another kernel. Hope you can point somethi=
ng
I am running in a AMD Athlon(tm) 64 X2 Dual Core Processor 4000+, kernel=20
2.6.38-8, ubuntu natty 11.04 and latest stable xenomai source.
If it will help, I can send the code.

Thanks.

=2D-
Carlos Novaes.

Em qua 10 ago 2011, =E0s 16:57:57, Carlos Eduardo de Brito Novaes escreveu:
> Sorry, the timer questio is solved, its a wrong call to unix ioctl instead
> of real time version from xenomai. By now I can initialize and even fire
> events, start the app again and again and also load/unload/reload the
> module without errors. The only problem seens to be related with the line
> ret =3D rtdm_event_timedwait(&ctx->RtdmReadyEvent,2000000000, &timeout_se=
q);
> on the read operation. If I uncomment it the first call to read will hang
> the entire CPU. I also changed it to include an timeout sequence with no
> sucess. By now, it seens that I have misundertood something. Maybe someone
> can poit it out.
>=20
> Thanks
>=20
> --
> Carlos Novaes.
>=20
> Em qua 10 ago 2011, =E0s 14:49:53, Carlos Eduardo de Brito Novaes escreve=
u:
> > Hello to all,
> >=20
> > I am learning how to use rtdm_timer and also rtdm_event to use on
> > acquisition board. The board itself has a FIFO and can be configurated =
do
> > fill it in a predefined time. The problem is that there is no interrupt
> > generated when the FIFO is full or on a given number of samples, so I
> > have to poll the data.
> >=20
> > As the conversion time is know (based on board latency, conversion time
> > and number os channels to scan), a better approach would be let the
> > board do its conversion and at given times, where the data should be
> > ready on FIFO (and also, the FIFO is far large than the amount of data
> > retrieved) and then, get it, setup a new delay based on the estimated
> > remaining data for the next scan, fire an event to unblock an read
> > operation and loop the entire proccess again...
> > Also, there is an user space real time application that will open the
> > rtdm device, issue some configurations via ioctl and loop reading the
> > device.
> >=20
> > The code specific to timming is working almost as good, I can see the a=
pp
> > returning a increasing counter by the time it is running. The only issue
> > is that the CPU hangs if I try to remove the module or run the app one
> > second time (or if I close and then reopen the device)
> > Any call to configure the rtdm_event  will hang the CPU.
> >=20
> > Hope you can give some appointments or tell me what I am doing wrong.
> > Here is the relevant sections of code, only code specific to xenomai and
> > related with the issues.
> >=20
> > --- For the app
> > int main(int argc, char **argv)
> > {
> >=20
> >   int device;
> >   int ret;
> >   int32_t sample_number;
> >  =20
> >   ret =3D mlockall(MCL_CURRENT | MCL_FUTURE);...
> >   ret =3D rt_task_shadow(&rt_task_desc, NULL, 1, 0);...
> >  =20
> >   sample_number =3D 0;
> >   //Open
> >   device =3D rt_dev_open(DEVICE_NAME, 0);....
> >  =20
> >   // IOCTL Start
> >   ret =3D rt_dev_ioctl(device, 0x07);...
> >  =20
> >   sleep(3);
> >   // Read
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   sleep(3);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   sleep(3);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >   sleep(2);
> >   ret =3D rt_dev_read (device, &sample_number, sizeof(sample_number));
> >   printf("Read %d. Sample %d\n", ret, sample_number);
> >  =20
> >     // IOCTL Stop
> >  =20
> >   ret =3D ioctl(device, 0x08);...
> >  =20
> >   /* close the device */
> >   ret =3D rt_dev_close(device);...
> >   return 0;
> >=20
> > }
> >=20
> > ---
> >=20
> > --- For the Driver
> > ...
> > static struct rtdm_device RtdmDevice =3D {
> >=20
> >         .struct_version =3D RTDM_DEVICE_STRUCT_VER,
> >         .device_flags =3D RTDM_NAMED_DEVICE,
> >         .context_size =3D 0,
> >         .device_name =3D DEVICE_NAME,
> >        =20
> >         .open_nrt =3D pci18xx_rtdm_open,
> >         .open_rt  =3D pci18xx_rtdm_open,
> >        =20
> >        =20
> >         .ops =3D {
> >        =20
> >                 .close_nrt =3D pci18xx_rtdm_close,
> >                 .close_rt  =3D pci18xx_rtdm_close,
> >                 .read_rt   =3D pci18xx_rtdm_read_rt,
> >                 .read_nrt   =3D pci18xx_rtdm_read_rt,
> >                 .write_rt  =3D pci18xx_rtdm_write_rt,
> >                 .ioctl_rt  =3D pci18xx_rtdm_ioctl_nrt,
> >                 .ioctl_nrt =3D pci18xx_rtdm_ioctl_nrt,
> >        =20
> >         },
> >        =20
> >         .device_class =3D RTDM_CLASS_EXPERIMENTAL,
> >         .device_sub_class =3D SOME_SUB_CLASS,
> >         .profile_version =3D 1,
> >         .driver_name =3D DRIVER_NAME,
> >         .driver_version =3D RTDM_DRIVER_VER(0, 1, 2),
> >         .peripheral_name =3D "Icpdas Daq18xx Board",
> >         .provider_name =3D "Carlos Novaes",
> >         .proc_name =3D RtdmDevice.device_name,
> >         .device_id =3D -1,
> >=20
> > };...
> > ...
> > static int              pci18xx_rtdm_ioctl_nrt(struct rtdm_dev_context
> > *context, rtdm_user_info_t *user_info, unsigned int request, void __user
> > *arg) {
> >=20
> >   pci18xx_context_t     *ctx;
> >   int                   err;
> >  =20
> >   err =3D 0;
> >   rtdm_printk("IOCTL Device NRT. Request =3D %d\n", request);
> >  =20
> >   ctx =3D (pci18xx_context_t *)context->dev_private;
> >   switch (request){
> >  =20
> >     case IOCTL_START:
> >       err =3D pci18xx_start(context, ctx, user_info, arg);
> >       break;
> >    =20
> >     case IOCTL_STOP:
> >       err =3D pci18xx_stop(ctx, user_info, arg);
> >       break;
> >    =20
> >     default:
> >       return PCI18XX_E_INVALID_IOCTL;
> >  =20
> >   }
> >   return PCI18XX_OK;
> >=20
> > };...
> > ...
> > static ssize_t          pci18xx_rtdm_read_rt(struct rtdm_dev_context
> > *context, rtdm_user_info_t * user_info, void *buf, size_t nbyte){
> >=20
> >   int16_t size;
> >   int32_t value;
> >   int err;
> >  =20
> >   pci18xx_context_t *ctx;
> >   // following line fails
> >   //err =3D rtdm_event_timedwait(&ctx->RtdmReadyEvent,2000000000, NULL);
> >  =20
> >   ctx =3D (pci18xx_context_t *) context->dev_private;
> >   size=3Dsizeof(ctx->SampleNumber);
> >  =20
> >   if (rtdm_safe_copy_to_user(user_info, buf, &(ctx->SampleNumber),
> >=20
> > size)){... return size;
> > };...
> > ...
> > static int              pci18xx_start(struct rtdm_dev_context *context,
> > pci18xx_context_t *ctx, rtdm_user_info_t *user_info, void __user *arg){
> >=20
> >   rtdm_timer_init(&ctx->RtdmTimer, pci18xx_timer_proc, context->device-
> > >
> > >device_name);
> > >
> >   // following line fail
> >   //rtdm_event_init(&ctx->RtdmReadyEvent, 0);
> >   ctx->Running=3D1;
> >   ctx->SampleNumber=3D0;
> >   ctx->time =3D rtdm_clock_read_monotonic();
> >   ctx->time +=3D 1000000000;
> >   rtdm_timer_start(&ctx->RtdmTimer, ctx->time, 0,
> >   RTDM_TIMERMODE_ABSOLUTE); return 0;
> >=20
> > };
> > static int              pci18xx_stop(pci18xx_context_t *ctx,
> > rtdm_user_info_t *user_info, void __user *arg){
> >=20
> >   rtdm_printk("stop function\n");
> >   if (ctx->Running){
> >  =20
> >     ctx->Running=3D0;
> >     // following line fail
> >     //rtdm_event_destroy(&ctx->RtdmReadyEvent);
> >     rtdm_timer_destroy(&ctx->RtdmTimer);
> >  =20
> >   }
> >   return 0;
> >=20
> > };
> > static void             pci18xx_timer_proc(rtdm_timer_t *timer){
> >=20
> >   pci18xx_context_t *ctx;
> >   int err;
> >   ctx =3D container_of(timer, pci18xx_context_t, RtdmTimer);
> >   ctx->SampleNumber++;
> >   ctx->time +=3D 1000000000;
> >   err =3D rtdm_timer_start_in_handler(&ctx->RtdmTimer, ctx->time, 0,
> >=20
> > RTDM_TIMERMODE_ABSOLUTE);
> >=20
> >   // following line fail
> >   //rtdm_event_pulse(&ctx->RtdmReadyEvent);
> >=20
> > };
> > ---

