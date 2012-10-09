Message-ID: <50748E83.6080506@xenomai.org>
Date: Tue, 09 Oct 2012 22:52:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <503227B5.9070002@basystemes.fr> <50322F06.4000009@wanadoo.fr>
	<503C63BE.8010201@xenomai.org>
	<503C709C.3020702@grandegger.com> <503C758B.9000906@wanadoo.fr>
	<503C7D77.2060209@grandegger.com> <50744BD3.1030703@wanadoo.fr>
	<50747C29.2060504@grandegger.com> <50748733.80709@wanadoo.fr>
In-Reply-To: <50748733.80709@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] rtcan: driver for the Advantech PCI cards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 10/09/2012 10:21 PM, Thierry Bultel wrote:

> Le 09/10/2012 21:34, Wolfgang Grandegger a =C3=A9crit :
>> Hi Thierry,
>>
>> please do not drop the CC to the Xenomai mailing list.
>=20
> ok, sorry
>=20
>>
>> On 10/09/2012 06:07 PM, Thierry Bultel wrote:
>>>>> Do you still plan to add the flexcan RTDM ?
>>>> I have already something running but it's not yet good enough for
>>>> mainline. Will need more time. Anyway, I could send my preliminary
>>>> patches in case you are interested, especially to test them.
>>> Hi Wolfgang,
>>> How are you ?
>>>
>>> I should receive my devkit for iMX6 in 2 weeks, and immediately start=
 on
>>> first applying the ipipe patch to it (the provided kernel is likely t=
o
>>> be the 3.2 from Freescale,
>>> with some little modifications), and then work on the flexcan rtdm dr=
iver.
>> Why v3.2 from Freescale? For the SabreLite or Nitrohen6x I know about
>> 3.0.36 from Freescale (rel_imx_3.0.35_12.09.02 from
>> git.freecale.com/linux-2.6) or, much better, mainline Linux 3.4.
>> Concerning the iPipe patches I think you have currently no other choic=
e.
>=20
> The SOM manufacturer is announcing a 3.2.x kernel for the iMX6.
> My understanding is that they take Freescale one and bring their BSP sp=
ecific changes.
> I will see. In my plan there is the (hopefully not) ipipe port stuff.
>=20
>=20
> For 3.0.36, I see that there is MXC specific patching (pre and post sch=
eme)
> But the README says that the latest ipipe patches are on http://downloa=
d.gna.org/adeos/patches/v3.x/arm/
>=20
> At that location, there is a single ipipe-core-3.2.21-arm-1.patch
> That does not fit for the iMX6 / and freescale kernel ?
>=20
> I think I need some clarification.


Well, it simply means that the new patches have not been copied on the
I-pipe repository.

You can download the latest version at this location:
http://www.xenomai.org/~gch/pub/mxc/3.0.43/

--=20
                                                                Gilles.


