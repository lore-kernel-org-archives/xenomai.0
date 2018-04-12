From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 12 Apr 2018 11:29:37 +0000
Message-ID: <DB6PR0701MB245607019F5DF13196B89A32B5BC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <CAOuPNLhVJ2wFG_nZ4+c4BPpX+idyDd-fNVVb9s7izej-qajcbA@mail.gmail.com>,
 <lbdt7mkde3suahbb6gnqc3gu.1523531921044@embeddedgreg.com>
In-Reply-To: <lbdt7mkde3suahbb6gnqc3gu.1523531921044@embeddedgreg.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Pintu Kumar <pintu.ping@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Ports UART1, UART2, UART4, UART5 are available on the BeagleBone's P8 and P=
9, and UART0 is on the debugging header. UART3 is also available, but only =
the TX line I think.
These can be accessed through the linux driver at `/dev/ttyS0`...`/dev/ttyS=
5`

Additionally, you have uart0 from the PRUSS.

See https://raw.githubusercontent.com/derekmolloy/boneDeviceTree/master/doc=
s/BeagleboneBlackP8HeaderTable.pdf and https://raw.githubusercontent.com/de=
rekmolloy/boneDeviceTree/master/docs/BeagleboneBlackP9HeaderTable.pdf


________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Greg Gallagher <gr=
eg@embeddedgreg.com>
Sent: 12 April 2018 12:18
To: Pintu Kumar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone

I thought the header contained outputs for the UART?  The driver will contr=
ol interfaces for the serial chip, ttyUSB0 probably won't be included in th=
at. What type of device are you sending data to over serial?

Greg

  Original Message
From: pintu.ping@gmail.com
Sent: April 12, 2018 2:26 AM
To: greg@embeddedgreg.com
Cc: lsorense@csclub.uwaterloo.ca; xenomai@xenomai.org
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone

Hi,

In BeagleBone there is no direct serial interface available.
However, we use Serial over USB (ttyUSB0) to connect to minicom.
In this case it is possible to use this interface over Xenomai and
check latency improvement?


Thanks,
Pintu



On Wed, Apr 11, 2018 at 7:34 PM, Greg Gallagher <greg@embeddedgreg.com> wro=
te:
> I think someone tried this with the uart on the PI, the basic steps
> would be (IMHO)
>=A0=A0=A0=A0=A0 -unbind the current uart driver
>=A0=A0=A0=A0=A0 -insert the xeno_16550A driver
>=A0=A0=A0=A0 -fix problems as they arise
>
> If you search the list you should see people who have tried this with
> other platforms in the past.
>
> -Greg
>
> On Wed, Apr 11, 2018 at 9:45 AM, Lennart Sorensen
> <lsorense@csclub.uwaterloo.ca> wrote:
>> On Wed, Apr 11, 2018 at 06:58:45AM -0400, Greg Gallagher wrote:
>>> What serial chip is on the beaglebone? If it's not supported then your =
best bet is to port the Linux driver to rtdm.
>>
>> I believe the normal driver is the 8250_omap.
>>
>> So it is 16550 style, but not 100% the same.
>>
>> --
>> Len Sorensen
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

