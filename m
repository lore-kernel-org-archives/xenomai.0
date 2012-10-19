MIME-Version: 1.0
In-Reply-To: <508169E7.6040205@xenomai.org>
References: <507D7A0C.7090209@gmail.com> <507E05B4.2040704@xenomai.org>
	<507F501A.4000500@gmail.com> <507F8579.6040604@xenomai.org>
	<50809DD8.60901@gmail.com> <5080D88E.8040903@xenomai.org>
	<CANzNmi_QEB27+5e2FD_cOniCBHR5-s0xDD0d+KxW69Q+z_MkNg@mail.gmail.com>
	<50815D27.3090104@xenomai.org>
	<CANzNmi8GSnFHD0sGa=s5WP7gGmo9AeCwXCz5ybmh3atkbFXpWg@mail.gmail.com>
	<508169E7.6040205@xenomai.org>
Date: Fri, 19 Oct 2012 14:23:13 -0300
Message-ID: <CANzNmi9mVt3U4LndZkzfbLucu8QP5=SRaAqfdohL=xpWfqs75A@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Installing Xenomai Newbie
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

2012/10/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 10/19/2012 04:29 PM, Sebastian Pavez wrote:
> > 2012/10/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 10/19/2012 03:54 PM, Sebastian Pavez wrote:
> >>> 2012/10/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> On 10/19/2012 02:24 AM, Sebasti=E1n Pavez wrote:
> >>>>
> >>>>> El 18-10-2012 1:28, Gilles Chanteperdrix escribi=F3:
> >>>>>> On 10/18/2012 02:40 AM, Sebasti=E1n Pavez wrote:
> >>>>>>
> >>>>>>> El 16-10-2012 22:11, Gilles Chanteperdrix escribi=F3:
> >>>>>>>> On 10/16/2012 05:15 PM, Sebasti=E1n Pavez wrote:
> >>>>>>>>
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> My name is Sebastian and I'm a chilean student from PUCV.
> >> Currently I
> >>>>>>>>> have to develop a RT proyect, but the problem is that I dont ha=
ve
> >>>>>>>>> experience with Linux and a lot less with Xenomai. Nevertheless=
 i
> >>>>>>>>> arrived to install xenomai  2.6.0 on Ubuntu 12.04, but when I t=
ry
> >> to
> >>>>>>>>> execute ubuntu with the xenomai kernel the screen goes black
> >>>>>>>> Please remove "quiet" from Linux command line, and make sure tha=
t
> >> you
> >>>>>>>> have all the drivers necessary for the your system to boot,
> >> including:
> >>>>>>>> - video display driver
> >>>>>>>> - root file system device driver
> >>>>>>>> - root file system driver
> >>>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I tried to everything from scratch, but i get the same problem. I
> >> tried
> >>>>>>> remove the quiet splash and I could see the line
> >>>>>>> "Fallback graphics default" well, this is when I execute the kern=
el
> >>>> with
> >>>>>>> xenomai in recovery mode. Because when I tried it in
> >>>>>>> a normal way I get the blacl screen with a twinkle, in this case
> I'm
> >>>>>>> able to put my password and I heard the entry sound (with some
> >>>>>>> distorsion), so like you said it maybe some driver's problem.
> >>>>>>> In the recovery mode I checked the application drivers and nothin=
g.
> >>>>>>> Maybe it's something simple but I'm quite stuck, I've never used
> >> linux
> >>>>>>> before and I really need to get this operative, so if you or
> someone
> >>>>>>> else could help me ... in plain language would be awesome ...
> >>>>>>> Thanks in advance
> >>>>>>>
> >>>>>>> PS: In the recovery mode I tried the xenomai tests, I attached th=
e
> >>>>>>> captures ...
> >>>>>>
> >>>>>> Your problem is configuring the kernel. So, please start with the
> >> Ubuntu
> >>>>>> kernel configuration, and simply disable the problematic options
> >>>>>> described here:
> >>>>>> http://www.xenomai.org/index.php/Configuring_x86_kernels
> >>>>>>
> >>>>>> If you do not know how to configure and compile a kernel, I sugges=
t
> >> you
> >>>>>> read some documentation on the web, such as:
> >>>>>> http://kernelnewbies.org/KernelBuild
> >>>>>>
> >>>>> Thanks Gilles for your answers and time.
> >>>>>
> >>>>> I tried one more time from scratch. I used Xenomai 2.6.0 and the
> kernel
> >>>>> Linux 2.6.38.8.
> >>>>> The only changes I made in the configuration are the suggested in t=
he
> >>>>> page you send me (_CPU_FREQ, _APM, _ACPI_PROCESSOR _INTEL_IDLE,
> >>>>> _PCI_MSI), I also disable _CC_STACKPROTECTOR and in the Preemption
> >> Model
> >>>>> i choose "Preemptible Kernel (Low-Latency Desktop)". I have a i3
> >>>>> processor so I choose the Core 2/newer Xeon's Processor family.
> >>>>
> >>>>
> >>>> You forgot to disable KGDB.
> >>>>
> >>>>>
> >>>>> I got the same result (black screen with the sistem apparently
> working
> >>>>> behind like I said), I realise that I didn't follow the
> recomendations
> >>>>> mentioned in this page http://kernelnewbies.org/KernelBuild,
> because I
> >>>>> tried to follow this tutorial
> >>>>>
> >>>>
> >>
> http://www.blaess.fr/christophe/2011/12/28/xenomai-2-6-0-sur-ubuntu-11-10=
/
> >>>>> . So tomorrow I will try to do this on my own with newer versions o=
f
> >> the
> >>>>> kernel and probably with xenomai 2.6.1.
> >>>>>
> >>>>> Before that I would like to know if the configuration parameters I
> >>>>> choose are ok, I don't know how to get a list of all of the
> parameters
> >>>>> to put it here but the only changes I made are the ones listed
> above. I
> >>>>> have doubts with Preemptible Kernel option because it wasn't listed
> on
> >>>>> the page, so I really don't know what is the cause. If it's not a
> >>>>> configuration issue, could be other causes to my problem?? ... I ho=
pe
> >>>>> not, because at least it's delimited.
> >>>>
> >>>>
> >>>> Well, simply attach the .config file...
> >>>>
> >>>> --
> >>>>
> Gilles.
> >>>>
> >>>>
> >>> Well, I did it again disabling the KGDB and the results are the same.
> >>> I attach the .config file like you suggested.
> >>> Thanks again
> >>
> >> Does the same configuration work with CONFIG_XENOMAI and CONFIG_IPIPE
> >> disabled?
> >>
> >> --
> >>                                             Gilles.
> >>
> >
> > Thank you for your quick answer.
> > I disabled those options and I got an error. I attach the capture of
> that.
> >
>
> Ok, try compiling the kernel without running prepare-kernel.sh, but
> still with the same configuration.
>
> --
>                                             Gilles.
>
I did that, but after rebooting and selecting the kernel occurs the same
thing than before ... :(
