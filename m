MIME-Version: 1.0
References: <CAEmXcAxUwr5vkt-t=XxDG-hn9BNb0uRVjY=WevQZGMjrO-_DyA@mail.gmail.com>
 <VI1PR05MB5917268369E7ABCECA5ABD4EF6E50@VI1PR05MB5917.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB5917268369E7ABCECA5ABD4EF6E50@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Fri, 21 Jun 2019 13:22:53 +0200
Message-ID: <CAEmXcAyHW-dCLSbA4LGFUzObZ-UAVFYBK4+sU9O7TOnZ2XDXXQ@mail.gmail.com>
Subject: Re: Commands for reading,
 loading and unloading drivers on BeagleBone Black?
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
To: Lange Norbert <norbert.lange@andritz.com>, xenomai@xenomai.org

Hi,
what exactly are you doing with those "echos" you wrote? I mean why should
I let linux pick a driver for a device? I have Xenomai with RTnet. I would
like to use Xenomai- / RTnet-drivers for that.
I have found the following commands: lsmod, insmod, rmmode. See the
following output.
# lsmod
Module                  Size  Used by    Tainted: G
rtipv4                 18699  0
rtpacket                4179  0
rt_ticpsw              26115  0
rt_davinci_mdio         4570  0
rt_smsc                 2165  0
rtnet                  28479  3 rtipv4,rtpacket,rt_ticpsw
omap_rng                4174  0
# iinsmod
-sh: iinsmod: not found
# lsmod
Module                  Size  Used by    Tainted: G
rtipv4                 18699  0
rtpacket                4179  0
rt_ticpsw              26115  0
rt_davinci_mdio         4570  0
rt_smsc                 2165  0
rtnet                  28479  3 rtipv4,rtpacket,rt_ticpsw
omap_rng                4174  0
# insmod
BusyBox v1.22.1 (2019-03-16 12:39:06 CET) multi-call binary.

Usage: insmod FILE [SYMBOL=3DVALUE]...

Load the specified kernel modules into the kernel

# rmmod
BusyBox v1.22.1 (2019-03-16 12:39:06 CET) multi-call binary.

Usage: rmmod [-wfa] [MODULE]...

Unload kernel modules

        -w      Wait until the module is no longer used
        -f      Force unload
        -a      Remove all unused modules (recursively)

Are these modules correct?

Regards,

Daniel

Am Mi., 19. Juni 2019 um 17:41 Uhr schrieb Lange Norbert <
norbert.lange@andritz.com>:

> Use sysfs-
>
> # unbind the current driver for those devices
> for sio in 1-2:1.0  1-2:1.1  1-2:1.2  1-2:1.3; do
>     echo "$sio" > /sys/bus/usb/devices/"$sio"/driver/unbind
> done
>
> # use a specific driver 'ftdi_sio' for a device
> echo "1-2:1.0" > /sys/bus/usb/drivers/ftdi_sio/bind
> # let linux pick a driver for a device
> echo '1-2:1.0' >  /sys/bus/usb/drivers_probe
>
> works similar with other busses.
>
> regards, Norbert Lange
>
> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of danwe via
> > Xenomai
> > Sent: Mittwoch, 19. Juni 2019 10:19
> > To: xenomai@xenomai.org
> > Subject: Commands for reading, loading and unloading drivers on
> > BeagleBone Black?
> >
> > E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
> > EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
> > ATTACHMENTS.
> >
> >
> > Hello,
> >
> > I am using a BeagleBone Black with Xenomai and RTnet on top. As some
> real-
> > time programs are not working it could be that the installed drivers on
> my
> > BeagleBone Black are still the standard drivers and not the real-time
> drivers.
> >
> > As I did not find anything on internet (only how to install drivers for
> Windows
> > when using BeagleBone Black) I would like to ask you if anyobdy knows
> > commands for BeagleBone Black to read, load and unload installed driver=
s
> on
> > BBB?
> >
> > Regards
> >
> > Daniel
> ________________________________
>
> This message and any attachments are solely for the use of the intended
> recipients. They may contain privileged and/or confidential information o=
r
> other information protected from disclosure. If you are not an intended
> recipient, you are hereby notified that you received this email in error
> and that any review, dissemination, distribution or copying of this email
> and any attachment is strictly prohibited. If you have received this emai=
l
> in error, please contact the sender and delete the message and any
> attachment from your system.
>
> ANDRITZ HYDRO GmbH
>
>
> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corp=
oration
>
> Firmensitz/ Registered seat: Wien
>
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>
> Firmenbuchnummer/ Company registration: FN 61833 g
>
> DVR: 0605077
>
> UID-Nr.: ATU14756806
>
>
> Thank You
> ________________________________
>
