Message-ID: <1352041290.49248.YahooMailClassic@web161203.mail.bf1.yahoo.com>
Date: Sun, 4 Nov 2012 07:01:30 -0800 (PST)
From: thoga@yahoo.com
In-Reply-To: <509670C3.5010005@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xeno_mod_isa for a 2 channel can-device with the same
	shared interrupt for both devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,=0A=0Athanks for your quick answer.=0A=0ACONFIG_XENO_OPT_SHIRQ wa=
s not set in the kernel-config. I'll set the flag and recompile the kernel,=
 but this will take 24h on that slow industrial pc.=0A=0AXN_ISR_SHARED flag=
, however, sound more interesting. How can I check, if the driver uses the =
XN_ISR_SHARED flag?=0A=0AThomas=0A=0A=0A=0A--- On Sun, 11/4/12, Gilles Chan=
teperdrix <gilles.chanteperdrix@xenomai.org> wrote:=0A=0A> From: Gilles Cha=
nteperdrix <gilles.chanteperdrix@xenomai.org>=0A> Subject: Re: [Xenomai] xe=
no_mod_isa for a 2 channel can-device with the same shared interrupt for bo=
th devices=0A> To: thoga@yahoo.com=0A> Cc: xenomai@xenomai.org, wg@grandegg=
er.com=0A> Date: Sunday, November 4, 2012, 2:42 PM=0A> On 11/04/2012 02:31 =
PM, thoga@yahoo.com=0A> wrote:=0A> =0A> > Hi all,=0A> > =0A> > I'm using XE=
NOMAI 2.6.0 on a SYSLOGIC ML/COMPACT6=0A> industrial pc,=0A> > which has 2 =
ISA-CAN-bus controllers onbard.=0A> > =0A> > Both controllers share the sam=
e irq=3D11 while they have=0A> different=0A> > i/o-port regions, the first =
uses io=3D0x7600 while the=0A> second uses=0A> > io=3D0x7700.=0A> > =0A> > =
When I load the xeno_can_isa module to use only one=0A> controller=0A> > =
=0A> > modprobe xeno_can_isa io=3D0x7600 irq=3D11=0A> > =0A> > everything w=
orks fine and realtime can-communication is=0A> possible. But=0A> > when I =
want to initialize both can controllers by=0A> issuing=0A> > =0A> > modprob=
e xeno_can_isa io=3D0x7600,0x7700 irq=3D11,11=0A> > =0A> > it says=0A> > =
=0A> > FATAL: Error inserting xeno_can_isa=0A> >=0A> (/lib/modules/2.6.38.8=
/kernel/drivers/xenomai/can/sja1000/xeno_can_isa.ko):=0A> > Device or resou=
rce busy=0A> > =0A> > On the other hand the command issued with two differe=
nt=0A> irq (11 and=0A> > 12)=0A> > =0A> > modprobe xeno_can_isa io=3D0x7600=
,0x7700 irq=3D11,12=0A> > =0A> > works and the module loads successfully (b=
ut the second=0A> channel=0A> > cannot be used due to wrong irq, of course)=
.=0A> > =0A> > Now, my question is: What does the message "Device or=0A> re=
source busy"=0A> > mean? Does it refere to the irq=3D11 which is already in=
=0A> use for the=0A> > first controller and is not available anymore for th=
e=0A> second one?=0A> > =0A> > Does anybody have experience in using the xe=
no_can_isa=0A> module with=0A> > two controllers sharing the same irq ?=0A>=
 =0A> =0A> Do you have CONFIG_XENO_OPT_SHIRQ enabled ?=0A> Does the driver =
use the XN_ISR_SHARED flag?=0A> =0A> -- =0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A> Gilles.=0A> 

