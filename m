From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <BN9PR11MB5227C5DCA32CA04F3F367B8EF20F9@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 16 Jun 2021 10:18:46 +0200
MIME-Version: 1.0
Message-ID: <10a7-60c9b400-83-35a6e6c0@10047715>
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

Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hongzhan.chen@=
intel.com> a =C3=A9crit: 
 
> 
> >
> >-----Original Message-----
> >From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Fran=C3=A7o=
is Legal via Xenomai
> >Sent: Wednesday, June 16, 2021 3:16 PM
> >To: xenomai@xenomai.org
> >Subject: Large gpio interrupt latency
> >
> >Hello,
> >
> >working on a realtime data recorder (for which I submitted a patch t=
o add timestamp retrieval for net packets), I experience a strange late=
ncy problem with taking GPIO interrupts.
> >
> >So basically my app monitors network packets (which as received by t=
he DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
> >We know (from some ohter reference instrument) that the DUT would to=
ggle the GPIO 1-2ms after receiving a specific network packet.
> >
> >My recorder app relies on the timestamping of events done in interru=
pts service routines for GPIOs and network interface. By checking the t=
imestamps returned by the application, I get an about 50ms delay betwee=
n the network packet and the GPIO (so something between 51 and 52ms del=
ay).
> >
> 
> Are you toggling gpio and access gpio device  through your rtdm devic=
e like on path /dev/rtdm/your=5Fgpiocontroller/gpio*?
> 

Maybe my setup was not very clear.
I've got a DUT that receives network data, and toggles one of its GPIOs=
 depending one the network data.

I've got another device running my realtime recording app, that receive=
s the same network data as the DUT, and that has one of its GPIO connec=
ted to the DUT GPIO.

On the recording app, I use the RTDM device to open, ioctl (enable inte=
rrupt + timestamp), then select & read the GPIO value.

Fran=C3=A7ois


> Hongzhan Chen
> 
> >I wonder where that might be coming from.
> >
> >Any idea ?
> >
> >thanks in advance
> >
> >Fran=C3=A7ois


