MIME-Version: 1.0
Date: Fri, 18 Mar 2011 00:27:36 +0200
Message-ID: <AANLkTi=1F27q2N32-mxVUD5HWAByUMN+z7baZWmO3oVA@mail.gmail.com>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0015175cdda01bfce6049eb52b45
Subject: [Xenomai-help] [Xenomai-Help]Analogy counter support for
	NI-PCI6024E DAQ board
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

--0015175cdda01bfce6049eb52b45
Content-Type: text/plain; charset=ISO-8859-1

Hello all!
I am trying to test the general purpose counter, GPCT, on the NI PCI 6024E
DAQ board using the latest snapshot of Xenomai-Analogy branch. Reading
through previous post I didn't find any post regarding the configuration and
read operation for simple event counter. Following the PCI E series Register
Level Programmer Manual and the DAQ-STC manual I've managed to implement a
counter setup function and a counter read function. Both are based on
instructions but I have a problem with the values beeing read from the save
register in the counter structure. To make it clear I am attaching the
implemented functions.

The counter setup / initialization function :

int counter_setup(void)
{
  // return code
  int rc;
  // counter setup bits
  lsampl_t counter_setup;
  // number of read pulses on single event operation
  unsigned int pulses;
  // config data
  unsigned int data[10];
  // instruction instance
  a4l_insn_t insn;

  // ensure clock disarm
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = ID_SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0]      = A4L_INSN_CONFIG_DISARM;
  data[1]      = NI_GPCT_ARM_IMMEDIATE;
  insn.data      = data;

  if((rc = a4l_snd_insn(&desc, &insn))<0){
    fprintf(stderr,"counter setup: arm counter failed (rc=%d)\n",rc);
  }

  // reset counter
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = ID_SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0]);
  data[0]      = A4L_INSN_CONFIG_RESET;
  insn.data      = data;

  if((rc = a4l_snd_insn(&desc, &insn))<0){
    fprintf(stderr,"counter setup :  reset counter failed (rc=%d)\n",rc);
  }

  // set counter mode bits
  counter_setup  = NI_GPCT_COUNTING_MODE_NORMAL_BITS;
  counter_setup |= NI_GPCT_COUNTING_DIRECTION_UP_BITS;
  counter_setup |= NI_GPCT_NO_HARDWARE_DISARM_BITS;
  counter_setup |= NI_GPCT_EDGE_GATE_NO_STARTS_NO_STOPS_BITS;
  counter_setup |= NI_GPCT_DISABLED_GATE_SELECT;

  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = ID_SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0]      = A4L_INSN_CONFIG_SET_COUNTER_MODE;
  data[1]      = counter_setup;
  insn.data      = data;

  if((rc = a4l_snd_insn(&desc, &insn))<0){
    fprintf(stderr,"counter setup: set counter mode failed (rc=%d)\n",rc);
  }

  // arm the counter
  insn.type      = A4L_INSN_CONFIG;
  insn.idx_subd  = ID_SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data[0])*2;
  data[0]      = A4L_INSN_CONFIG_ARM;
  data[1]      = NI_GPCT_ARM_IMMEDIATE;
  insn.data      = data;

  if((rc = a4l_snd_insn(&desc, &insn))<0){
    fprintf(stderr,"counter setup : arm counter failed (rc=%d)\n",rc);
  }

   // read insn setup
  insn.type      = A4L_INSN_READ;
  insn.idx_subd  = ID_SUBDEV_COUNTER;
  insn.chan_desc = 0;
  insn.data_size = sizeof(data);
  insn.data      = &data;

  if((rc = a4l_snd_insn(&desc, &insn))<0){
    fprintf(stderr,"counter setup: read setup failed (rc=%d)\n",rc);
  }
}

And the counter read function :

long counter_read(){
  // return code
  int rc;
  // single event pulses counter
  long pulses;
  // the read operation
  if((rc = a4l_sync_read(&desc,ID_SUBDEV_COUNTER, 0, 0,&pulses, 4))<0){
      fprintf(stderr,"counter reader : single event counting failed
(rc=%d)\n",rc);
  }
  // return the number of pulses
  return ((long)pulses - COUNTER_OFFSET);
}

So my test program simply loops and reads the values from the counter. The
problem is that I think I have some problems in the configuration bits
because the values that are read from the counter aren't valid.
A short preview :

val : -5419898
val : -5418501
val : -5417102
val : -5415702
val : -5414302
val : -5412902
val : -5411497
val : -5410101
.....
val : 397603
val : 398948
val : 400293
val : 401651
val : 402998
val : 404343
val : 405687
val : 407033
....
val : -12501
val : -11075
val : -9650
val : -8224
val : -6795
val : -4115
val : -2297
val : -869
val : 552
val : 1936
val : 3311
val : 4692
val : 6061
val : 7441
val : 8819

Furthermore some of the configuration values are mapping the legacy Comedi
configuration bits.
The test I'm running to simulate the simple event input is based on a 1Hz
pulse train applied on CTRSRC0/PFI8 and another thing is that the counting
never stops.
Certainly it is a configuration problem or a flaw in the function design or
am I missing something ? Any suggestions will be appreciated.

Best,
Cristian

--0015175cdda01bfce6049eb52b45
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all! <br>I am trying to test the general purpose counter, GPCT, on th=
e NI PCI 6024E DAQ board using the latest snapshot of Xenomai-Analogy branc=
h. Reading through previous post I didn&#39;t find any post regarding the c=
onfiguration and read operation for simple event counter. Following the PCI=
 E series Register Level Programmer Manual and the DAQ-STC manual I&#39;ve =
managed to implement a counter setup function and a counter read function. =
Both are based on instructions but I have a problem with the values beeing =
read from the save register in the counter structure. To make it clear I am=
 attaching the implemented functions. <br>
<br>The counter setup / initialization function :<br><br>i<span style=3D"fo=
nt-family: courier new,monospace;">nt counter_setup(void)=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">{
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // return code</span><br style=3D"fon=
t-family: courier new,monospace;"><span style=3D"font-family: courier new,m=
onospace;">=A0 int rc;</span><br style=3D"font-family: courier new,monospac=
e;">
<span style=3D"font-family: courier new,monospace;">=A0 // counter setup bi=
ts
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 lsampl_t counter_setup;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // number of read pulses on single ev=
ent operation</span><br style=3D"font-family: courier new,monospace;"><span=
 style=3D"font-family: courier new,monospace;">=A0 unsigned int pulses;</sp=
an><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0 // config data
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 unsigned int data[10];</span><br styl=
e=3D"font-family: courier new,monospace;"><span style=3D"font-family: couri=
er new,monospace;">=A0 // instruction instance
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 a4l_insn_t insn;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // ensure clock disarm
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.type=A0=A0=A0=A0=A0 =3D A4L_INSN=
_CONFIG;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.idx_subd=A0 =3D ID_SUBDEV_COUNTE=
R;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.chan_desc =3D 0;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data_size =3D sizeof(data[0])*2;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[0] =A0=A0=A0 =A0=3D A4L_INSN_CON=
FIG_DISARM;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[1] =A0=A0=A0 =A0=3D NI_GPCT_ARM_=
IMMEDIATE;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data=A0=A0=A0=A0=A0 =3D data;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 if((rc =3D a4l_snd_insn(&amp;desc, &a=
mp;insn))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 fprintf(stderr,&quot;counter se=
tup: arm counter failed (rc=3D%d)\n&quot;,rc);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 }</span><br style=3D"font-family: cou=
rier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // reset counter
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.type=A0=A0=A0=A0=A0 =3D A4L_INSN=
_CONFIG;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.idx_subd=A0 =3D ID_SUBDEV_COUNTE=
R;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.chan_desc =3D 0;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data_size =3D sizeof(data[0]);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[0] =A0=A0=A0 =A0=3D A4L_INSN_CON=
FIG_RESET;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data=A0=A0=A0=A0=A0 =3D data;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 if((rc =3D a4l_snd_insn(&amp;desc, &a=
mp;insn))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 fprintf(stderr,&quot;counter se=
tup :=A0 reset counter failed (rc=3D%d)\n&quot;,rc);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 }</span><br style=3D"font-family: cou=
rier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // set counter mode bits=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 counter_setup=A0 =3D NI_GPCT_COUNTING=
_MODE_NORMAL_BITS;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 counter_setup |=3D NI_GPCT_COUNTING_D=
IRECTION_UP_BITS;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 counter_setup |=3D NI_GPCT_NO_HARDWAR=
E_DISARM_BITS;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 counter_setup |=3D NI_GPCT_EDGE_GATE_=
NO_STARTS_NO_STOPS_BITS;</span><br style=3D"font-family: courier new,monosp=
ace;">
<span style=3D"font-family: courier new,monospace;">=A0 counter_setup |=3D =
NI_GPCT_DISABLED_GATE_SELECT;</span><br style=3D"font-family: courier new,m=
onospace;"><span style=3D"font-family: courier new,monospace;">=A0</span><b=
r style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0 insn.type=A0=A0=A0=
=A0=A0 =3D A4L_INSN_CONFIG;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.idx_subd=A0 =3D ID_SUBDEV_COUNTE=
R;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.chan_desc =3D 0;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data_size =3D sizeof(data[0])*2;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[0] =A0=A0=A0 =A0=3D A4L_INSN_CON=
FIG_SET_COUNTER_MODE;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[1] =A0=A0=A0 =A0=3D counter_setu=
p;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data=A0=A0=A0=A0=A0 =3D data;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 if((rc =3D a4l_snd_insn(&amp;desc, &a=
mp;insn))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 fprintf(stderr,&quot;counter se=
tup: set counter mode failed (rc=3D%d)\n&quot;,rc);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 }
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 </span><br style=3D"font-family=
: courier new,monospace;"><span style=3D"font-family: courier new,monospace=
;">=A0 // arm the counter
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.type=A0=A0=A0=A0=A0 =3D A4L_INSN=
_CONFIG;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.idx_subd=A0 =3D ID_SUBDEV_COUNTE=
R;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.chan_desc =3D 0;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data_size =3D sizeof(data[0])*2;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[0] =A0=A0=A0 =A0=3D A4L_INSN_CON=
FIG_ARM;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 data[1] =A0=A0=A0 =A0=3D NI_GPCT_ARM_=
IMMEDIATE;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data=A0=A0=A0=A0=A0 =3D data;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0</span><br style=3D"font-family: couri=
er new,monospace;"><span style=3D"font-family: courier new,monospace;">=A0 =
if((rc =3D a4l_snd_insn(&amp;desc, &amp;insn))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 fprintf(stderr,&quot;counter se=
tup : arm counter failed (rc=3D%d)\n&quot;,rc);</span><br style=3D"font-fam=
ily: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0 }</span><br style=
=3D"font-family: courier new,monospace;"><br style=3D"font-family: courier =
new,monospace;"><span style=3D"font-family: courier new,monospace;">=A0=A0 =
// read insn setup
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.type=A0=A0=A0=A0=A0 =3D A4L_INSN=
_READ;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.idx_subd=A0 =3D ID_SUBDEV_COUNTE=
R;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.chan_desc =3D 0;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data_size =3D sizeof(data);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 insn.data=A0=A0=A0=A0=A0 =3D &amp;dat=
a;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 if((rc =3D a4l_snd_insn(&amp;desc, &a=
mp;insn))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0 fprintf(stderr,&quot;counter se=
tup: read setup failed (rc=3D%d)\n&quot;,rc);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 }
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">}</span><br><br>And the counter read func=
tion :<br><br><span style=3D"font-family: courier new,monospace;">long coun=
ter_read(){</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0 // return code</spa=
n><br style=3D"font-family: courier new,monospace;"><span style=3D"font-fam=
ily: courier new,monospace;">=A0 int rc;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // single event pulses counter
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 long pulses;
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 // the read operation
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 if((rc =3D a4l_sync_read(&amp;desc,ID=
_SUBDEV_COUNTER, 0, 0,&amp;pulses, 4))&lt;0){
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0=A0=A0=A0=A0 fprintf(stderr,&quot;coun=
ter reader : single event counting failed (rc=3D%d)\n&quot;,rc);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 }</span><br style=3D"font-family: cou=
rier new,monospace;"><span style=3D"font-family: courier new,monospace;">=
=A0 // return the number of pulses
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">=A0 return ((long)pulses - COUNTER_OFFSET=
);
</span><br style=3D"font-family: courier new,monospace;"><span style=3D"fon=
t-family: courier new,monospace;">}</span><br><br>So my test program simply=
 loops and reads the values from the counter. The problem is that I think I=
 have some problems in the configuration bits because the values that are r=
ead from the counter aren&#39;t valid. <br>
A short preview : <br><br>val : -5419898<br>val : -5418501<br>val : -541710=
2<br>val : -5415702<br>val : -5414302<br>val : -5412902<br>val : -5411497<b=
r>val : -5410101<br>.....<br>val : 397603<br>val : 398948<br>val : 400293<b=
r>
val : 401651<br>val : 402998<br>val : 404343<br>val : 405687<br>val : 40703=
3<br>....<br>val : -12501<br>val : -11075<br>val : -9650<br>val : -8224<br>=
val : -6795<br>val : -4115<br>val : -2297<br>val : -869<br>val : 552<br>
val : 1936<br>val : 3311<br>val : 4692<br>val : 6061<br>val : 7441<br>val :=
 8819<br><br>Furthermore some of the configuration values are mapping the l=
egacy Comedi configuration bits. <br>The test I&#39;m running to simulate t=
he simple event input is based on a 1Hz pulse train applied on CTRSRC0/PFI8=
 and another thing is that the counting never stops.<br>
Certainly it is a configuration problem or a flaw in the function design or=
 am I missing something ? Any suggestions will be appreciated.=A0 <br><br>B=
est,<br>Cristian <br><br><br><br><br><br>

--0015175cdda01bfce6049eb52b45--

