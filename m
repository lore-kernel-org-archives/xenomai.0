MIME-Version: 1.0
In-Reply-To: <20110411231103.GB2654@domain.hid>
References: <AANLkTi=1F27q2N32-mxVUD5HWAByUMN+z7baZWmO3oVA@mail.gmail.com>
	<20110407233852.GA4932@domain.hid>
	<598833373-1302349798-cardhu_decombobulator_blackberry.rim.net-2099481629-@domain.hid>
	<20110411231103.GB2654@domain.hid>
Date: Tue, 12 Apr 2011 08:19:48 +0300
Message-ID: <BANLkTimFBn18ac8QwFqaDN971wW0G39F5Q@mail.gmail.com>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64af2e44f969604a0b1d7da
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
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

--0016e64af2e44f969604a0b1d7da
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2011 at 2:11 AM, Alexis Berlemont <
alexis.berlemont@domain.hid> wrote:

> Hi,
>
> cristian.axenie@domain.hid wrote:
> > Hi Alexis ! To recall, I have a PowerPC system and a PCI DAQ
> > card. And I remember we discussed some while ago about the endiannes
> > problem and the fact that the Comedi drivers were mainly designed
> > for x86 systems. Here's a hex output when running the sample
> > application on the board.
>
> I have no idea on how and when you got these samples but at least the
> counter is incrementing...; Let's try to be serious: did you setup any
> method to find out the value of the frequency and whether or not the
> frequency was stable?


The values presented earlier were captured and presented to see only the
variation
in the counter readings. No frequency measurement at the moment,

>
> > The problem is the the counter values are always available even if
> > there is no pulse train on the GPCT SRC pin.
>
> I am not an expert at all on the NI board counting functionalities but
> I just had a look at the function ni_tio_insn_config() and I did not
> find in your former mail any configuration of the clock source with
> A4L_INSN_CONFIG_SET_CLOCK_SRC. Is it normal?
>

> A silly question: after sending the configuration instruction
> A4L_INSN_CONFIG_DISARM, does your counter stop?
>

I'll fix the problems in my last test program and communicate the results.


>
> A few months ago, I read many times the chapter 4 of the DAQ-STC
> technical reference manual so as to try to find a generic way to
> configure any counting subdevice (a task I did not complete by the
> way). These desperate readings were not wholly useless; at least, I
> learned one thing: it is very difficult to configure the counters
> without having read this @#xx&y doc in details.
>
> Did you read it?
>

Some passages directly regarding the simple event counting.

Best !

>
> > ....
> > val : [ 0xffa130b4 ]
> > val : [ 0xffa13d40 ]
> > val : [ 0xffa1442c ]
> > val : [ 0xffa149ab ]
> > val : [ 0xffa14f23 ]
> > val : [ 0x00067d0d ]
> > val : [ 0x000683f1 ]
> > val : [ 0x00068ec2 ]
> > val : [ 0x000695e2 ]
> > val : [ 0x00069b81 ]
> > val : [ 0x0006a114 ]
> > ....
> > val : [ 0x00739c16 ]
> > val : [ 0x0073a1aa ]
> > val : [ 0x0073a73c ]
> > val : [ 0x0073accb ]
> > val : [ 0x0073b25c ]
> > val : [ 0xffd8c60d ]
> > val : [ 0xffd8cccf ]
> > val : [ 0xffd8d25c ]
> > val : [ 0xffd8d7e9 ]
> > val : [ 0xffd8dd6d ]
> > val : [ 0xffd8e2f9 ]
> > val : [ 0xffd8e888 ]
> > val : [ 0xffd8ee15 ]
> > val : [ 0xffd8f3a2 ]
> > ...
> >
> > And another problem I've spotted is that the read insn fails when calli=
ng
> it with the following parameters.
> >
> >  // read insn setup
> >   insn.type            =3D A4L_INSN_READ;
> >   insn.idx_subd     =3D ID_SUBDEV_COUNTER;
> >   insn.chan_desc  =3D 0;
> >   insn.data_size    =3D sizeof(data);
> >   insn.data            =3D &data;
> >
>
> How does it fail? Any error code?
>
> > I'll try to setup a way to make the board available if you want to acce=
ss
> it.
> >
> > Best !
> > Sent from my BlackBerry=AE wireless device
> >
> > -----Original Message-----
> > From: Alexis Berlemont <alexis.berlemont@domain.hid>
> > Date: Fri, 8 Apr 2011 01:38:52
> > To: Cristian Axenie<cristian.axenie@domain.hid>
> > Cc: <xenomai@xenomai.org>
> > Subject: Re: [Xenomai-help] [Xenomai-Help]Analogy counter support for
> >  NI-PCI6024E DAQ board
> >
> > Hi,
> >
> > I apologize for being mute so long. Seriously, I could not find enough
> > free minutes to switch my computer on; and in the rare cases I succeed,=
 I
> > fell asleep before entering my password. And I did not notice your
> > mail during the sporadic uses of a precarious internet connection.
> >
> > Let's hope things are getting better.
> >
> > Cristian Axenie wrote:
> > > Hello all!
> > > I am trying to test the general purpose counter, GPCT, on the NI PCI
> 6024E
> > > DAQ board using the latest snapshot of Xenomai-Analogy branch. Readin=
g
> > > through previous post I didn't find any post regarding the
> configuration and
> > > read operation for simple event counter. Following the PCI E series
> Register
> > > Level Programmer Manual and the DAQ-STC manual I've managed to
> implement a
> > > counter setup function and a counter read function. Both are based on
> > > instructions but I have a problem with the values beeing read from th=
e
> save
> > > register in the counter structure. To make it clear I am attaching th=
e
> > > implemented functions.
> > >
> > > The counter setup / initialization function :
> > >
> > > int counter_setup(void)
> > > {
> > >   // return code
> > >   int rc;
> > >   // counter setup bits
> > >   lsampl_t counter_setup;
> > >   // number of read pulses on single event operation
> > >   unsigned int pulses;
> > >   // config data
> > >   unsigned int data[10];
> > >   // instruction instance
> > >   a4l_insn_t insn;
> > >
> > >   // ensure clock disarm
> > >   insn.type      =3D A4L_INSN_CONFIG;
> > >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> > >   insn.chan_desc =3D 0;
> > >   insn.data_size =3D sizeof(data[0])*2;
> > >   data[0]      =3D A4L_INSN_CONFIG_DISARM;
> > >   data[1]      =3D NI_GPCT_ARM_IMMEDIATE;
> > >   insn.data      =3D data;
> > >
> > >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> > >     fprintf(stderr,"counter setup: arm counter failed (rc=3D%d)\n",rc=
);
> > >   }
> > >
> > >   // reset counter
> > >   insn.type      =3D A4L_INSN_CONFIG;
> > >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> > >   insn.chan_desc =3D 0;
> > >   insn.data_size =3D sizeof(data[0]);
> > >   data[0]      =3D A4L_INSN_CONFIG_RESET;
> > >   insn.data      =3D data;
> > >
> > >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> > >     fprintf(stderr,"counter setup :  reset counter failed
> (rc=3D%d)\n",rc);
> > >   }
> > >
> > >   // set counter mode bits
> > >   counter_setup  =3D NI_GPCT_COUNTING_MODE_NORMAL_BITS;
> > >   counter_setup |=3D NI_GPCT_COUNTING_DIRECTION_UP_BITS;
> > >   counter_setup |=3D NI_GPCT_NO_HARDWARE_DISARM_BITS;
> > >   counter_setup |=3D NI_GPCT_EDGE_GATE_NO_STARTS_NO_STOPS_BITS;
> > >   counter_setup |=3D NI_GPCT_DISABLED_GATE_SELECT;
> > >
> > >   insn.type      =3D A4L_INSN_CONFIG;
> > >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> > >   insn.chan_desc =3D 0;
> > >   insn.data_size =3D sizeof(data[0])*2;
> > >   data[0]      =3D A4L_INSN_CONFIG_SET_COUNTER_MODE;
> > >   data[1]      =3D counter_setup;
> > >   insn.data      =3D data;
> > >
> > >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> > >     fprintf(stderr,"counter setup: set counter mode failed
> (rc=3D%d)\n",rc);
> > >   }
> > >
> > >   // arm the counter
> > >   insn.type      =3D A4L_INSN_CONFIG;
> > >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> > >   insn.chan_desc =3D 0;
> > >   insn.data_size =3D sizeof(data[0])*2;
> > >   data[0]      =3D A4L_INSN_CONFIG_ARM;
> > >   data[1]      =3D NI_GPCT_ARM_IMMEDIATE;
> > >   insn.data      =3D data;
> > >
> > >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> > >     fprintf(stderr,"counter setup : arm counter failed (rc=3D%d)\n",r=
c);
> > >   }
> > >
> > >    // read insn setup
> > >   insn.type      =3D A4L_INSN_READ;
> > >   insn.idx_subd  =3D ID_SUBDEV_COUNTER;
> > >   insn.chan_desc =3D 0;
> > >   insn.data_size =3D sizeof(data);
> > >   insn.data      =3D &data;
> > >
> > >   if((rc =3D a4l_snd_insn(&desc, &insn))<0){
> > >     fprintf(stderr,"counter setup: read setup failed (rc=3D%d)\n",rc)=
;
> > >   }
> > > }
> > >
> > > And the counter read function :
> > >
> > > long counter_read(){
> > >   // return code
> > >   int rc;
> > >   // single event pulses counter
> > >   long pulses;
> > >   // the read operation
> > >   if((rc =3D a4l_sync_read(&desc,ID_SUBDEV_COUNTER, 0, 0,&pulses, 4))=
<0){
> > >       fprintf(stderr,"counter reader : single event counting failed
> > > (rc=3D%d)\n",rc);
> > >   }
> > >   // return the number of pulses
> > >   return ((long)pulses - COUNTER_OFFSET);
> > > }
> > >
> > > So my test program simply loops and reads the values from the counter=
.
> The
> > > problem is that I think I have some problems in the configuration bit=
s
> > > because the values that are read from the counter aren't valid.
> > > A short preview :
> >
> > Could you print the values in hexadecimal? With a bit of luck, that
> > might help to disclose a big / little endian issue. PCI devices are
> > little endian and if I remember well, you are using a PowerPC
> > micro-controller.
> >
> > >
> > > val : -5419898
> > > val : -5418501
> > > val : -5417102
> > > val : -5415702
> > > val : -5414302
> > > val : -5412902
> > > val : -5411497
> > > val : -5410101
> > > .....
> > > val : 397603
> > > val : 398948
> > > val : 400293
> > > val : 401651
> > > val : 402998
> > > val : 404343
> > > val : 405687
> > > val : 407033
> > > ....
> > > val : -12501
> > > val : -11075
> > > val : -9650
> > > val : -8224
> > > val : -6795
> > > val : -4115
> > > val : -2297
> > > val : -869
> > > val : 552
> > > val : 1936
> > > val : 3311
> > > val : 4692
> > > val : 6061
> > > val : 7441
> > > val : 8819
> > >
> > > Furthermore some of the configuration values are mapping the legacy
> Comedi
> > > configuration bits.
> > > The test I'm running to simulate the simple event input is based on a
> 1Hz
> > > pulse train applied on CTRSRC0/PFI8 and another thing is that the
> counting
> > > never stops.
> > > Certainly it is a configuration problem or a flaw in the function
> design or
> > > am I missing something ? Any suggestions will be appreciated.
> > >
> > > Best,
> > > Cristian
> >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >
> >
> > --
> > Alexis.
>
> --
> Alexis.
>

--0016e64af2e44f969604a0b1d7da
Content-Type: text/html; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Apr 12, 2011 at 2:11 AM, Alexis Berlemon=
t <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexi=
s.berlemont@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 2=
04, 204); padding-left: 1ex;">
Hi,<br>
<div class=3D"im"><br>
<a href=3D"mailto:cristian.axenie@domain.hid">cristian.axenie@domain.hid</a> =
wrote:<br>
&gt; Hi Alexis ! To recall, I have a PowerPC system and a PCI DAQ<br>
&gt; card. And I remember we discussed some while ago about the endiannes<b=
r>
&gt; problem and the fact that the Comedi drivers were mainly designed<br>
&gt; for x86 systems. Here&#39;s a hex output when running the sample<br>
&gt; application on the board.<br>
<br>
</div>I have no idea on how and when you got these samples but at least the=
<br>
counter is incrementing...; Let&#39;s try to be serious: did you setup any<=
br>
method to find out the value of the frequency and whether or not the<br>
frequency was stable?=A0</blockquote><div>=A0<br>The values presented earli=
er were captured and presented to see only the variation<br>in the counter =
readings. No frequency measurement at the moment,<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px soli=
d rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"im"><br>
&gt; The problem is the the counter values are always available even if<br>
&gt; there is no pulse train on the GPCT SRC pin.<br>
<br>
</div>I am not an expert at all on the NI board counting functionalities bu=
t<br>
I just had a look at the function ni_tio_insn_config() and I did not<br>
find in your former mail any configuration of the clock source with<br>
A4L_INSN_CONFIG_SET_CLOCK_SRC. Is it normal?=A0<br></blockquote><blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px=
 solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
A silly question: after sending the configuration instruction<br>
A4L_INSN_CONFIG_DISARM, does your counter stop?<br></blockquote><div><br>I&=
#39;ll fix the problems in my last test program and communicate the results=
.<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0p=
t 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"=
>

<br>
A few months ago, I read many times the chapter 4 of the DAQ-STC<br>
technical reference manual so as to try to find a generic way to<br>
configure any counting subdevice (a task I did not complete by the<br>
way). These desperate readings were not wholly useless; at least, I<br>
learned one thing: it is very difficult to configure the counters<br>
without having read this @#xx&amp;y doc in details.<br>
<br>
Did you read it?<br></blockquote><div><br>Some passages directly regarding =
the simple event counting. <br><br>Best !<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(20=
4, 204, 204); padding-left: 1ex;">

<div><div></div><div class=3D"h5"><br>
&gt; ....<br>
&gt; val : [ 0xffa130b4 ]<br>
&gt; val : [ 0xffa13d40 ]<br>
&gt; val : [ 0xffa1442c ]<br>
&gt; val : [ 0xffa149ab ]<br>
&gt; val : [ 0xffa14f23 ]<br>
&gt; val : [ 0x00067d0d ]<br>
&gt; val : [ 0x000683f1 ]<br>
&gt; val : [ 0x00068ec2 ]<br>
&gt; val : [ 0x000695e2 ]<br>
&gt; val : [ 0x00069b81 ]<br>
&gt; val : [ 0x0006a114 ]<br>
&gt; ....<br>
&gt; val : [ 0x00739c16 ]<br>
&gt; val : [ 0x0073a1aa ]<br>
&gt; val : [ 0x0073a73c ]<br>
&gt; val : [ 0x0073accb ]<br>
&gt; val : [ 0x0073b25c ]<br>
&gt; val : [ 0xffd8c60d ]<br>
&gt; val : [ 0xffd8cccf ]<br>
&gt; val : [ 0xffd8d25c ]<br>
&gt; val : [ 0xffd8d7e9 ]<br>
&gt; val : [ 0xffd8dd6d ]<br>
&gt; val : [ 0xffd8e2f9 ]<br>
&gt; val : [ 0xffd8e888 ]<br>
&gt; val : [ 0xffd8ee15 ]<br>
&gt; val : [ 0xffd8f3a2 ]<br>
&gt; ...<br>
&gt;<br>
&gt; And another problem I&#39;ve spotted is that the read insn fails when =
calling it with the following parameters.<br>
&gt;<br>
&gt; =A0// read insn setup<br>
&gt; =A0 insn.type =A0 =A0 =A0 =A0 =A0 =A0=3D A4L_INSN_READ;<br>
&gt; =A0 insn.idx_subd =A0 =A0 =3D ID_SUBDEV_COUNTER;<br>
&gt; =A0 insn.chan_desc =A0=3D 0;<br>
&gt; =A0 insn.data_size =A0 =A0=3D sizeof(data);<br>
&gt; =A0 insn.data =A0 =A0 =A0 =A0 =A0 =A0=3D &amp;data;<br>
&gt;<br>
<br>
</div></div>How does it fail? Any error code?<br>
<div class=3D"im"><br>
&gt; I&#39;ll try to setup a way to make the board available if you want to=
 access it.<br>
&gt;<br>
&gt; Best !<br>
</div>&gt; Sent from my BlackBerry=AE wireless device<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Alexis Berlemont &lt;<a href=3D"mailto:alexis.berlemont@domain.hid=
m">alexis.berlemont@domain.hid</a>&gt;<br>
&gt; Date: Fri, 8 Apr 2011 01:38:52<br>
&gt; To: Cristian Axenie&lt;<a href=3D"mailto:cristian.axenie@domain.hid">cr=
istian.axenie@domain.hid</a>&gt;<br>
&gt; Cc: &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</=
a>&gt;<br>
&gt; Subject: Re: [Xenomai-help] [Xenomai-Help]Analogy counter support for<=
br>
&gt; =A0NI-PCI6024E DAQ board<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I apologize for being mute so long. Seriously, I could not find enough=
<br>
&gt; free minutes to switch my computer on; and in the rare cases I succeed=
, I<br>
&gt; fell asleep before entering my password. And I did not notice your<br>
&gt; mail during the sporadic uses of a precarious internet connection.<br>
&gt;<br>
&gt; Let&#39;s hope things are getting better.<br>
&gt;<br>
&gt; Cristian Axenie wrote:<br>
&gt; &gt; Hello all!<br>
&gt; &gt; I am trying to test the general purpose counter, GPCT, on the NI =
PCI 6024E<br>
&gt; &gt; DAQ board using the latest snapshot of Xenomai-Analogy branch. Re=
ading<br>
&gt; &gt; through previous post I didn&#39;t find any post regarding the co=
nfiguration and<br>
&gt; &gt; read operation for simple event counter. Following the PCI E seri=
es Register<br>
&gt; &gt; Level Programmer Manual and the DAQ-STC manual I&#39;ve managed t=
o implement a<br>
&gt; &gt; counter setup function and a counter read function. Both are base=
d on<br>
&gt; &gt; instructions but I have a problem with the values beeing read fro=
m the save<br>
&gt; &gt; register in the counter structure. To make it clear I am attachin=
g the<br>
&gt; &gt; implemented functions.<br>
&gt; &gt;<br>
&gt; &gt; The counter setup / initialization function :<br>
&gt; &gt;<br>
&gt; &gt; int counter_setup(void)<br>
&gt; &gt; {<br>
&gt; &gt; =A0 // return code<br>
&gt; &gt; =A0 int rc;<br>
&gt; &gt; =A0 // counter setup bits<br>
&gt; &gt; =A0 lsampl_t counter_setup;<br>
&gt; &gt; =A0 // number of read pulses on single event operation<br>
&gt; &gt; =A0 unsigned int pulses;<br>
&gt; &gt; =A0 // config data<br>
&gt; &gt; =A0 unsigned int data[10];<br>
&gt; &gt; =A0 // instruction instance<br>
&gt; &gt; =A0 a4l_insn_t insn;<br>
&gt; &gt;<br>
&gt; &gt; =A0 // ensure clock disarm<br>
&gt; &gt; =A0 insn.type =A0 =A0 =A0=3D A4L_INSN_CONFIG;<br>
&gt; &gt; =A0 insn.idx_subd =A0=3D ID_SUBDEV_COUNTER;<br>
&gt; &gt; =A0 insn.chan_desc =3D 0;<br>
&gt; &gt; =A0 insn.data_size =3D sizeof(data[0])*2;<br>
&gt; &gt; =A0 data[0] =A0 =A0 =A0=3D A4L_INSN_CONFIG_DISARM;<br>
&gt; &gt; =A0 data[1] =A0 =A0 =A0=3D NI_GPCT_ARM_IMMEDIATE;<br>
&gt; &gt; =A0 insn.data =A0 =A0 =A0=3D data;<br>
&gt; &gt;<br>
&gt; &gt; =A0 if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){<br>
&gt; &gt; =A0 =A0 fprintf(stderr,&quot;counter setup: arm counter failed (r=
c=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt;<br>
&gt; &gt; =A0 // reset counter<br>
&gt; &gt; =A0 insn.type =A0 =A0 =A0=3D A4L_INSN_CONFIG;<br>
&gt; &gt; =A0 insn.idx_subd =A0=3D ID_SUBDEV_COUNTER;<br>
&gt; &gt; =A0 insn.chan_desc =3D 0;<br>
&gt; &gt; =A0 insn.data_size =3D sizeof(data[0]);<br>
&gt; &gt; =A0 data[0] =A0 =A0 =A0=3D A4L_INSN_CONFIG_RESET;<br>
&gt; &gt; =A0 insn.data =A0 =A0 =A0=3D data;<br>
&gt; &gt;<br>
&gt; &gt; =A0 if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){<br>
&gt; &gt; =A0 =A0 fprintf(stderr,&quot;counter setup : =A0reset counter fai=
led (rc=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt;<br>
&gt; &gt; =A0 // set counter mode bits<br>
&gt; &gt; =A0 counter_setup =A0=3D NI_GPCT_COUNTING_MODE_NORMAL_BITS;<br>
&gt; &gt; =A0 counter_setup |=3D NI_GPCT_COUNTING_DIRECTION_UP_BITS;<br>
&gt; &gt; =A0 counter_setup |=3D NI_GPCT_NO_HARDWARE_DISARM_BITS;<br>
&gt; &gt; =A0 counter_setup |=3D NI_GPCT_EDGE_GATE_NO_STARTS_NO_STOPS_BITS;=
<br>
&gt; &gt; =A0 counter_setup |=3D NI_GPCT_DISABLED_GATE_SELECT;<br>
&gt; &gt;<br>
&gt; &gt; =A0 insn.type =A0 =A0 =A0=3D A4L_INSN_CONFIG;<br>
&gt; &gt; =A0 insn.idx_subd =A0=3D ID_SUBDEV_COUNTER;<br>
&gt; &gt; =A0 insn.chan_desc =3D 0;<br>
&gt; &gt; =A0 insn.data_size =3D sizeof(data[0])*2;<br>
&gt; &gt; =A0 data[0] =A0 =A0 =A0=3D A4L_INSN_CONFIG_SET_COUNTER_MODE;<br>
&gt; &gt; =A0 data[1] =A0 =A0 =A0=3D counter_setup;<br>
&gt; &gt; =A0 insn.data =A0 =A0 =A0=3D data;<br>
&gt; &gt;<br>
&gt; &gt; =A0 if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){<br>
&gt; &gt; =A0 =A0 fprintf(stderr,&quot;counter setup: set counter mode fail=
ed (rc=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt;<br>
&gt; &gt; =A0 // arm the counter<br>
&gt; &gt; =A0 insn.type =A0 =A0 =A0=3D A4L_INSN_CONFIG;<br>
&gt; &gt; =A0 insn.idx_subd =A0=3D ID_SUBDEV_COUNTER;<br>
&gt; &gt; =A0 insn.chan_desc =3D 0;<br>
&gt; &gt; =A0 insn.data_size =3D sizeof(data[0])*2;<br>
&gt; &gt; =A0 data[0] =A0 =A0 =A0=3D A4L_INSN_CONFIG_ARM;<br>
&gt; &gt; =A0 data[1] =A0 =A0 =A0=3D NI_GPCT_ARM_IMMEDIATE;<br>
&gt; &gt; =A0 insn.data =A0 =A0 =A0=3D data;<br>
&gt; &gt;<br>
&gt; &gt; =A0 if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){<br>
&gt; &gt; =A0 =A0 fprintf(stderr,&quot;counter setup : arm counter failed (=
rc=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0// read insn setup<br>
&gt; &gt; =A0 insn.type =A0 =A0 =A0=3D A4L_INSN_READ;<br>
&gt; &gt; =A0 insn.idx_subd =A0=3D ID_SUBDEV_COUNTER;<br>
&gt; &gt; =A0 insn.chan_desc =3D 0;<br>
&gt; &gt; =A0 insn.data_size =3D sizeof(data);<br>
&gt; &gt; =A0 insn.data =A0 =A0 =A0=3D &amp;data;<br>
&gt; &gt;<br>
&gt; &gt; =A0 if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){<br>
&gt; &gt; =A0 =A0 fprintf(stderr,&quot;counter setup: read setup failed (rc=
=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; And the counter read function :<br>
&gt; &gt;<br>
&gt; &gt; long counter_read(){<br>
&gt; &gt; =A0 // return code<br>
&gt; &gt; =A0 int rc;<br>
&gt; &gt; =A0 // single event pulses counter<br>
&gt; &gt; =A0 long pulses;<br>
&gt; &gt; =A0 // the read operation<br>
&gt; &gt; =A0 if((rc =3D a4l_sync_read(&amp;desc,ID_SUBDEV_COUNTER, 0, 0,&a=
mp;pulses, 4))&lt;0){<br>
&gt; &gt; =A0 =A0 =A0 fprintf(stderr,&quot;counter reader : single event co=
unting failed<br>
&gt; &gt; (rc=3D%d)\n&quot;,rc);<br>
&gt; &gt; =A0 }<br>
&gt; &gt; =A0 // return the number of pulses<br>
&gt; &gt; =A0 return ((long)pulses - COUNTER_OFFSET);<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; So my test program simply loops and reads the values from the cou=
nter. The<br>
&gt; &gt; problem is that I think I have some problems in the configuration=
 bits<br>
&gt; &gt; because the values that are read from the counter aren&#39;t vali=
d.<br>
&gt; &gt; A short preview :<br>
&gt;<br>
&gt; Could you print the values in hexadecimal? With a bit of luck, that<br=
>
&gt; might help to disclose a big / little endian issue. PCI devices are<br=
>
&gt; little endian and if I remember well, you are using a PowerPC<br>
&gt; micro-controller.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; val : -5419898<br>
&gt; &gt; val : -5418501<br>
&gt; &gt; val : -5417102<br>
&gt; &gt; val : -5415702<br>
&gt; &gt; val : -5414302<br>
&gt; &gt; val : -5412902<br>
&gt; &gt; val : -5411497<br>
&gt; &gt; val : -5410101<br>
&gt; &gt; .....<br>
&gt; &gt; val : 397603<br>
&gt; &gt; val : 398948<br>
&gt; &gt; val : 400293<br>
&gt; &gt; val : 401651<br>
&gt; &gt; val : 402998<br>
&gt; &gt; val : 404343<br>
&gt; &gt; val : 405687<br>
&gt; &gt; val : 407033<br>
&gt; &gt; ....<br>
&gt; &gt; val : -12501<br>
&gt; &gt; val : -11075<br>
&gt; &gt; val : -9650<br>
&gt; &gt; val : -8224<br>
&gt; &gt; val : -6795<br>
&gt; &gt; val : -4115<br>
&gt; &gt; val : -2297<br>
&gt; &gt; val : -869<br>
&gt; &gt; val : 552<br>
&gt; &gt; val : 1936<br>
&gt; &gt; val : 3311<br>
&gt; &gt; val : 4692<br>
&gt; &gt; val : 6061<br>
&gt; &gt; val : 7441<br>
&gt; &gt; val : 8819<br>
&gt; &gt;<br>
&gt; &gt; Furthermore some of the configuration values are mapping the lega=
cy Comedi<br>
&gt; &gt; configuration bits.<br>
&gt; &gt; The test I&#39;m running to simulate the simple event input is ba=
sed on a 1Hz<br>
&gt; &gt; pulse train applied on CTRSRC0/PFI8 and another thing is that the=
 counting<br>
&gt; &gt; never stops.<br>
&gt; &gt; Certainly it is a configuration problem or a flaw in the function=
 design or<br>
&gt; &gt; am I missing something ? Any suggestions will be appreciated.<br>
&gt; &gt;<br>
&gt; &gt; Best,<br>
&gt; &gt; Cristian<br>
&gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Xenomai-help mailing list<br>
&gt; &gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><=
br>
&gt; &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"=
_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Alexis.<br>
<br>
</div></div>--<br>
<font color=3D"#888888">Alexis.<br>
</font></blockquote></div><br>

--0016e64af2e44f969604a0b1d7da--

