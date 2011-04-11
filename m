Date: Tue, 12 Apr 2011 01:11:03 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110411231103.GB2654@domain.hid>
References: <AANLkTi=1F27q2N32-mxVUD5HWAByUMN+z7baZWmO3oVA@mail.gmail.com>
	<20110407233852.GA4932@domain.hid>
	<598833373-1302349798-cardhu_decombobulator_blackberry.rim.net-2099481629-@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <598833373-1302349798-cardhu_decombobulator_blackberry.rim.net-2099481629-@domain.hid>
Subject: Re: [Xenomai-help] [Xenomai-Help]Analogy counter support
 forNI-PCI6024E DAQ board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: cristian.axenie@domain.hid
Cc: xenomai@xenomai.org

Hi,

cristian.axenie@domain.hid wrote:
> Hi Alexis ! To recall, I have a PowerPC system and a PCI DAQ
> card. And I remember we discussed some while ago about the endiannes
> problem and the fact that the Comedi drivers were mainly designed
> for x86 systems. Here's a hex output when running the sample
> application on the board.=20

I have no idea on how and when you got these samples but at least the
counter is incrementing...; Let's try to be serious: did you setup any
method to find out the value of the frequency and whether or not the
frequency was stable?=20

> The problem is the the counter values are always available even if
> there is no pulse train on the GPCT SRC pin.=20

I am not an expert at all on the NI board counting functionalities but
I just had a look at the function ni_tio_insn_config() and I did not
find in your former mail any configuration of the clock source with
A4L_INSN_CONFIG_SET_CLOCK_SRC. Is it normal?

A silly question: after sending the configuration instruction
A4L_INSN_CONFIG_DISARM, does your counter stop?

A few months ago, I read many times the chapter 4 of the DAQ-STC
technical reference manual so as to try to find a generic way to
configure any counting subdevice (a task I did not complete by the
way). These desperate readings were not wholly useless; at least, I
learned one thing: it is very difficult to configure the counters
without having read this @#xx&y doc in details.=20

Did you read it?

> ....
> val : [ 0xffa130b4 ]
> val : [ 0xffa13d40 ]
> val : [ 0xffa1442c ]
> val : [ 0xffa149ab ]
> val : [ 0xffa14f23 ]
> val : [ 0x00067d0d ]
> val : [ 0x000683f1 ]
> val : [ 0x00068ec2 ]
> val : [ 0x000695e2 ]
> val : [ 0x00069b81 ]
> val : [ 0x0006a114 ]
> ....
> val : [ 0x00739c16 ]
> val : [ 0x0073a1aa ]
> val : [ 0x0073a73c ]
> val : [ 0x0073accb ]
> val : [ 0x0073b25c ]
> val : [ 0xffd8c60d ]
> val : [ 0xffd8cccf ]
> val : [ 0xffd8d25c ]
> val : [ 0xffd8d7e9 ]
> val : [ 0xffd8dd6d ]
> val : [ 0xffd8e2f9 ]
> val : [ 0xffd8e888 ]
> val : [ 0xffd8ee15 ]
> val : [ 0xffd8f3a2 ]
> ...
>=20
> And another problem I've spotted is that the read insn fails when calling=
 it with the following parameters.
>=20
>  // read insn setup
>   insn.type            =3D A4L_INSN_READ;
>   insn.idx_subd     =3D ID_SUBDEV_COUNTER;
>   insn.chan_desc  =3D 0;
>   insn.data_size    =3D sizeof(data);
>   insn.data            =3D &data;
>=20

How does it fail? Any error code?

> I'll try to setup a way to make the board available if you want to access=
 it.
>=20
> Best !
> Sent from my BlackBerry=AE wireless device
>=20
> -----Original Message-----
> From: Alexis Berlemont <alexis.berlemont@domain.hid>
> Date: Fri, 8 Apr 2011 01:38:52=20
> To: Cristian Axenie<cristian.axenie@domain.hid>
> Cc: <xenomai@xenomai.org>
> Subject: Re: [Xenomai-help] [Xenomai-Help]Analogy counter support for
>  NI-PCI6024E DAQ board
>=20
> Hi,
>=20
> I apologize for being mute so long. Seriously, I could not find enough
> free minutes to switch my computer on; and in the rare cases I succeed, I
> fell asleep before entering my password. And I did not notice your
> mail during the sporadic uses of a precarious internet connection.
>=20
> Let's hope things are getting better.
>=20
> Cristian Axenie wrote:
> > Hello all!
> > I am trying to test the general purpose counter, GPCT, on the NI PCI 60=
24E
> > DAQ board using the latest snapshot of Xenomai-Analogy branch. Reading
> > through previous post I didn't find any post regarding the configuratio=
n and
> > read operation for simple event counter. Following the PCI E series Reg=
ister
> > Level Programmer Manual and the DAQ-STC manual I've managed to implemen=
t a
> > counter setup function and a counter read function. Both are based on
> > instructions but I have a problem with the values beeing read from the =
save
> > register in the counter structure. To make it clear I am attaching the
> > implemented functions.
> >=20
> > The counter setup / initialization function :
> >=20
> > int counter_setup(void)
> > {
> >   // return code
> >   int rc;
> >   // counter setup bits
> >   lsampl_t counter_setup;
> >   // number of read pulses on single event operation
> >   unsigned int pulses;
> >   // config data
> >   unsigned int data[10];
> >   // instruction instance
> >   a4l_insn_t insn;
> >=20
> >   // ensure clock disarm
> >   insn.type      =3D A4L_INSN_CONFIG;
> >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc =3D 0;
> >   insn.data_size =3D sizeof(data[0])*2;
> >   data[0]      =3D A4L_INSN_CONFIG_DISARM;
> >   data[1]      =3D NI_GPCT_ARM_IMMEDIATE;
> >   insn.data      =3D data;
> >=20
> >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> >     fprintf(stderr,"counter setup: arm counter failed (rc=3D%d)\n",rc);
> >   }
> >=20
> >   // reset counter
> >   insn.type      =3D A4L_INSN_CONFIG;
> >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc =3D 0;
> >   insn.data_size =3D sizeof(data[0]);
> >   data[0]      =3D A4L_INSN_CONFIG_RESET;
> >   insn.data      =3D data;
> >=20
> >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> >     fprintf(stderr,"counter setup :  reset counter failed (rc=3D%d)\n",=
rc);
> >   }
> >=20
> >   // set counter mode bits
> >   counter_setup  =3D NI_GPCT_COUNTING_MODE_NORMAL_BITS;
> >   counter_setup |=3D NI_GPCT_COUNTING_DIRECTION_UP_BITS;
> >   counter_setup |=3D NI_GPCT_NO_HARDWARE_DISARM_BITS;
> >   counter_setup |=3D NI_GPCT_EDGE_GATE_NO_STARTS_NO_STOPS_BITS;
> >   counter_setup |=3D NI_GPCT_DISABLED_GATE_SELECT;
> >=20
> >   insn.type      =3D A4L_INSN_CONFIG;
> >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc =3D 0;
> >   insn.data_size =3D sizeof(data[0])*2;
> >   data[0]      =3D A4L_INSN_CONFIG_SET_COUNTER_MODE;
> >   data[1]      =3D counter_setup;
> >   insn.data      =3D data;
> >=20
> >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> >     fprintf(stderr,"counter setup: set counter mode failed (rc=3D%d)\n"=
,rc);
> >   }
> >=20
> >   // arm the counter
> >   insn.type      =3D A4L_INSN_CONFIG;
> >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc =3D 0;
> >   insn.data_size =3D sizeof(data[0])*2;
> >   data[0]      =3D A4L_INSN_CONFIG_ARM;
> >   data[1]      =3D NI_GPCT_ARM_IMMEDIATE;
> >   insn.data      =3D data;
> >=20
> >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> >     fprintf(stderr,"counter setup : arm counter failed (rc=3D%d)\n",rc);
> >   }
> >=20
> >    // read insn setup
> >   insn.type      =3D A4L_INSN_READ;
> >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc =3D 0;
> >   insn.data_size =3D sizeof(data);
> >   insn.data      =3D &data;
> >=20
> >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> >     fprintf(stderr,"counter setup: read setup failed (rc=3D%d)\n",rc);
> >   }
> > }
> >=20
> > And the counter read function :
> >=20
> > long counter_read(){
> >   // return code
> >   int rc;
> >   // single event pulses counter
> >   long pulses;
> >   // the read operation
> >   if((rc =3D a4l_sync_read(&desc,ID_SUBDEV_COUNTER, 0, 0,&pulses, 4))<0=
){
> >       fprintf(stderr,"counter reader : single event counting failed
> > (rc=3D%d)\n",rc);
> >   }
> >   // return the number of pulses
> >   return ((long)pulses - COUNTER_OFFSET);
> > }
> >=20
> > So my test program simply loops and reads the values from the counter. =
The
> > problem is that I think I have some problems in the configuration bits
> > because the values that are read from the counter aren't valid.
> > A short preview :
>=20
> Could you print the values in hexadecimal? With a bit of luck, that
> might help to disclose a big / little endian issue. PCI devices are
> little endian and if I remember well, you are using a PowerPC
> micro-controller.=20
>=20
> >=20
> > val : -5419898
> > val : -5418501
> > val : -5417102
> > val : -5415702
> > val : -5414302
> > val : -5412902
> > val : -5411497
> > val : -5410101
> > .....
> > val : 397603
> > val : 398948
> > val : 400293
> > val : 401651
> > val : 402998
> > val : 404343
> > val : 405687
> > val : 407033
> > ....
> > val : -12501
> > val : -11075
> > val : -9650
> > val : -8224
> > val : -6795
> > val : -4115
> > val : -2297
> > val : -869
> > val : 552
> > val : 1936
> > val : 3311
> > val : 4692
> > val : 6061
> > val : 7441
> > val : 8819
> >=20
> > Furthermore some of the configuration values are mapping the legacy Com=
edi
> > configuration bits.
> > The test I'm running to simulate the simple event input is based on a 1=
Hz
> > pulse train applied on CTRSRC0/PFI8 and another thing is that the count=
ing
> > never stops.
> > Certainly it is a configuration problem or a flaw in the function desig=
n or
> > am I missing something ? Any suggestions will be appreciated.
> >=20
> > Best,
> > Cristian
>=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --=20
> Alexis.

--=20
Alexis.

