Message-ID: <50378527.1080708@grandegger.com>
Date: Fri, 24 Aug 2012 15:44:07 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <50375208.5090209@wanadoo.fr> <50375EAC.9000206@xenomai.org>
	<50377868.10406@wanadoo.fr>
In-Reply-To: <50377868.10406@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Availability of ARM adeos patch for 3.5 kernel,
 and RTDM SPI for iMX6 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 08/24/2012 02:49 PM, Thierry Bultel wrote:
> Le 24/08/2012 12:59, Gilles Chanteperdrix a =E9crit :
>> On 08/24/2012 12:06 PM, Thierry Bultel wrote:
>>
>>> Hi,
>>>
>>> I noticed on git that the latest available patch for ARM is
>>> ipipe-core-3.2.21-arm-1.patch,
>>> that I assume, replaces the mxc pre+std+post mecanism, please tell me=
 if
>>> I am wrong.
>>
>> The pre+std+post mechanism is used to apply a patch for mainline kerne=
l
>> to the Freescale linux tree. If you want to use that tree, you always
>> need that mechanism. ipipe-core-3.2.21-arm-1.patch is a patch for the
>> mainline kernel.
> Thanks for the clarification.
> When you refer to Freescale linux tree, are you talking about
>=20
> https://github.com/Freescale/linux-imx* *?
>=20
> If yes, the latest version there is 3.5-rc7.=20

No, but "http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/"

> The CPU module vendor is likely to base its BSP on a Freescale kernel, =
probably that one, so I am=20
> concerned about finding a matching patch to apply on.
> What would you advise ? Taking in account what you mention below, is th=
e backport from Freescale
> 3.5-rc7 to mainline 3.4 the most suitable solution, or a port of the ad=
eos patch in the opposite way ?

There is resonable support for the i.MX6Q Sabrelite board in the
mainline kernel. In principle, you would need to backport it to 3.4.x or
push the iPipe patches forward to 3.6-rcX.

Wolfgang.


