Message-ID: <4D709E55.8010904@domain.hid>
Date: Fri, 04 Mar 2011 09:09:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20110302151603.GA14557@domain.hid>	
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>	
	<20110303072147.GA4353@domain.hid>	
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>	
	<4D6F89C8.9060005@domain.hid>
	<1299156880.2072.6.camel@domain.hid>	 <4D702802.5080001@domain.hid>
	<1299225060.2107.20.camel@domain.hid>
In-Reply-To: <1299225060.2107.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA39C74337146C7FDC7BBF0D8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA39C74337146C7FDC7BBF0D8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-03-04 08:51, Philippe Gerum wrote:
> On Fri, 2011-03-04 at 00:45 +0100, Jan Kiszka wrote:
>> On 2011-03-03 13:54, Philippe Gerum wrote:
>>> On Thu, 2011-03-03 at 13:30 +0100, Jan Kiszka wrote:
>>>> On 2011-03-03 13:25, Wolfgang Grandegger wrote:
>>>>> Hi Philippe,
>>>>>
>>>>> On 03/03/2011 08:32 AM, Philippe Gerum wrote:
>>>>>> On Thu, 2011-03-03 at 08:21 +0100, Richard Cochran wrote:
>>>>>>> On Wed, Mar 02, 2011 at 07:18:46PM +0100, Jan Kiszka wrote:
>>>>>>>> On 2011-03-02 16:26, Gilles Chanteperdrix wrote:
>>>>>>>>> Richard Cochran wrote:
>>>>>>>>>> The wiki pages=20
>>>>>>>>>>
>>>>>>>>>>    http://www.xenomai.org/index.php/FAQs
>>>>>>>>>>    http://www.xenomai.org/index.php/Configuring_x86_kernels
>>>>>>>>>>
>>>>>>>>>> say not to enable MSI on x86, with a link to a very old (2008)=

>>>>>>>>>> discussion.
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> The current situation looks like this:
>>>>>>>>  - MSI[-X] usage for plain Linux drivers is fine, we are using i=
t on
>>>>>>>>    machines where you can hardly avoid MSI today
>>>>>>>>  - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as =
long as
>>>>>>>>    you avoid enabling/disabling from RT context (also used for q=
uite
>>>>>>>>    a while here, no known issues under this restriction)
>>>>>>>
>>>>>>> Okay, so I understand from this:
>>>>>>>
>>>>>>> 1. The wiki warning is out of date.
>>>>>>>
>>>>>>> 2. My own PCIe MSI driver/card *should* work.
>>>>>>>    (It is not a current known limitation of adeos/xenomai.)
>>>>>>
>>>>>> The situation is not that clear. Enabling CONFIG_PCI_MSI on some 8=
3xx
>>>>>> board did cause a lock up at boot for me, so this may point the fi=
nger
>>>>>> at the pipeline core for ppc, and not to Xenomai which was barely =
active
>>>>>> at that stage.
>>>>>
>>>>> Now I remember vaguely that we have seen a similar issue on the mpc=
8308
>>>>> in autumn last year. Here is what you wrote that time:
>>>>>
>>>>> On 09/29/2010 04:12 PM, Philippe Gerum wrote:
>>>>>> Ok, I have a good news: the issue is spotted; and a bad one: this =
is no
>>>>>> trivial stuff to fix. In short, CONFIG_PCI_MSI causes the PIC code=
 to
>>>>>> read PCI config memory on the fly during operations (which is inte=
nsely
>>>>>> insane but that is how it goes). Of course, it does that via the r=
egular
>>>>>> PCI helpers, which are stuffed with normal locking constructs we m=
ay
>>>>>> _not_ call from any real-time/non-regular context.
>>>>>>
>>>>>> To sum up, we need to call those helpers to ack/mask interrupts wi=
thin
>>>>>> the I-pipe, but we are not allowed to do this because this is inhe=
rently
>>>>>> unsafe.
>>>>>>
>>>>>> Work-around: disable CONFIG_PCI_MSI in your configuration.
>>>>>> The real fix would require much more thought, to make the PCI help=
ers
>>>>>> Adeos-aware without inducing high latency.
>>>>
>>>> As MSIs are edge-triggered, only requiring ack at the interrupt
>>>> controller level, could it be that PPC is using the wrong flow handl=
er here?
>>>
>>> The pipeline forces mask/ack to prevent adverse effect of deferred
>>> delivery to downstream handlers. Some chips require this.
>>
>> You mean PPC irqchips? I'm a bit confused as MSIs are immediately acke=
d
>> by the hardware on the bus, independently of the processor delivering =
or
>> deferring the event. What prevents immediate termination (up to EOI if=

>> required) of this IRQ type on PPC?
>=20
> It is not about msi chips in particular, it is about masking all
> interrupt sources during their propagation in the pipeline being
> generally used for all irqs, to prevent interrupt storm from
> edge-triggered sources because of the incurred delay.

At least for MSI, such storms would be very abnormal. The spec states
that devices can't assume anything about multiple IRQ messages sent
before the driver communicated with the device after the first one. So
they /should/ refrain from sending those. Of course, there can always be
exceptions (guess we've all seen buggy firmware...).

>=20
> To sum up: as far as I'm concerned, I still have to address the issue o=
f
> dealing with MSI, because I never did so for any of the pipeline
> releases, for any arch, I've rolled out in the past. My perception is
> that MSIs are at odds with some assumptions/decisions of the ppc
> pipeline, and this went unnoticed until people start using MSI-enabled
> hardware there too. This was confirmed by experimenting on 83xx that
> something was going wrong with CONFIG_PCI_MSI enabled.
>=20
> I'm not saying this would be impossible to enable MSIs there, I'm just
> saying that so far: nobody cared. Terrae incognitae.

I'm not disagreeing. I'm just betting that MSI will quickly gain
relevance there as well - up to the point where first devices no longer
include with INTx support (perfectly legal, but I haven't seen one yet).

Jan


--------------enigA39C74337146C7FDC7BBF0D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk1wnl4ACgkQitSsb3rl5xT6LACg0eHbcnuNlx/eOGp1yOJy0mVz
t+4An0l6B4HOxSNjm37ID1PWo2hoyTIR
=uzeh
-----END PGP SIGNATURE-----

--------------enigA39C74337146C7FDC7BBF0D8--

