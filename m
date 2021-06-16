From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <BN9PR11MB5227F2779A44C6154AE060D7F20F9@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 16 Jun 2021 11:12:36 +0200
MIME-Version: 1.0
Message-ID: <1202-60c9c080-151-1ab27320@266229055>
Subject: =?utf-8?q?RE=3A?= Large gpio interrupt latency
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>
Cc: =?utf-8?q?xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan" <hongzhan.chen@=
intel.com> a =C3=A9crit: 
 
> 
> 
> >-----Original Message-----
> >From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org> 
> >Sent: Wednesday, June 16, 2021 4:19 PM
> >To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >Cc: xenomai@xenomai.org
> >Subject: RE: Large gpio interrupt latency
> >
> >Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hongzhan.ch=
en@intel.com> a =C3=A9crit: 
> > 
> >> 
> >> >
> >> >-----Original Message-----
> >> >From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Fran=C3=A7=
ois Legal via Xenomai
> >> >Sent: Wednesday, June 16, 2021 3:16 PM
> >> >To: xenomai@xenomai.org
> >> >Subject: Large gpio interrupt latency
> >> >
> >> >Hello,
> >> >
> >> >working on a realtime data recorder (for which I submitted a patc=
h to add timestamp retrieval for net packets), I experience a strange l=
atency problem with taking GPIO interrupts.
> >> >
> >> >So basically my app monitors network packets (which as received b=
y the DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
> >> >We know (from some ohter reference instrument) that the DUT would=
 toggle the GPIO 1-2ms after receiving a specific network packet.
> >> >
> >> >My recorder app relies on the timestamping of events done in inte=
rrupts service routines for GPIOs and network interface. By checking th=
e timestamps returned by the application, I get an about 50ms delay bet=
ween the network packet and the GPIO (so something between 51 and 52ms =
delay).
> >> >
> >> 
> >> Are you toggling gpio and access gpio device  through your rtdm de=
vice like on path /dev/rtdm/your=5Fgpiocontroller/gpio*?
> >> 
> >
> >Maybe my setup was not very clear.
> >I've got a DUT that receives network data, and toggles one of its GP=
IOs depending one the network data.
> >
> >I've got another device running my realtime recording app, that rece=
ives the same network data as the DUT, and that has one of its GPIO con=
nected to the DUT GPIO.
> >
> >On the recording app, I use the RTDM device to open, ioctl (enable i=
nterrupt + timestamp), then select & read the GPIO value.
> 
> When issue happen, the recording app side have got same number of net=
work data packages and gpio interrupts with that DUT have been toggling=
?  
> I am asking this because I met gpio hardware issue that would cause g=
pio interrupt missing or invalid gpio interrupts when gpio is connectin=
g on two different boards.
> 

AFAICT, I'm not missing GPIO edges/interrupts in the app. Regarding net=
work, the DUT and the recoding device are connected to the same switch =
with the same port config.

Moreover, I tried changing the interrupt polarity of the recording devi=
ce (switched from rising edge to falling edge), and the result is 1-2ms=
 + ~30ms (the width of the pulse of the DUT) + 50ms latency

> >
> >Fran=C3=A7ois
> >
> >
> >> Hongzhan Chen
> >> 
> >> >I wonder where that might be coming from.
> >> >
> >> >Any idea ?
> >> >
> >> >thanks in advance
> >> >
> >> >Fran=C3=A7ois
> >
> >
> >


