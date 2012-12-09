Message-ID: <50C524A6.6020006@xenomai.org>
Date: Mon, 10 Dec 2012 00:54:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr> <50C236B9.3030507@xenomai.org>
	<50C4EF5A.3030502@wanadoo.fr>
In-Reply-To: <50C4EF5A.3030502@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] iMX6q 1Hz tick
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

On 12/09/2012 09:06 PM, Thierry Bultel wrote:

> Le 07/12/2012 19:34, Gilles Chanteperdrix a =C3=A9crit :
>> On 12/07/2012 02:28 PM, Thierry Bultel wrote:
>>
>>> Hi,
>=20
> Hello Gilles,
>=20
>>>
>>> I have "successfully" patched a 3.0.35 kernel from Freescale with
>>> adeos-ipipe-3.0.36-1.18.11
>>>
>>> I have -not- applied the adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
>>> that showed too much "revert patch detected" errors.
>>
>>
>>
>> The patch should apply cleanly, the question, if you get too many
>> rejections, it is because you do not apply it to the proper branch.
>>
>=20
> Of course it was not.
> I started with a kernel provided by the module manufacturer. I estimate=
=20
> that this kernel is "almost" a rel_imx_3.0.35_12.09.02, I mean, that
> I have not found a closer tag than this one.
>=20
> My first idea was to attempt to apply the patches to that kernel
> directly. I was not expecting it would have been simple, and it was=20
> actually not. But after a few hours I came to the initial result I said=
=2E
>=20
>=20
>=20
>>>
>>> BTW, I have understand that its purpose was mainly to upgrade to 3.0.=
36,
>>> but what is actually the role of the
>>> adeos-ipipe-3.0.36-arm-1.18-11-post.patch ? (I applied it).
>>
>>
>> I have explained this in a previous mail.
>=20
> Ok, I will seek in the history. I would be nice if the explanation
> was in the README.
>=20
>>
>>>
>>> I had to deal with some rejections but at least the kernel is booting=

>>> and my application running.
>>>
>>> But the target is very slow, and /proc/xenomai/irq shows that the
>>> [timer] irq only comes about every 1 second.
>>>
>>> The /proc/interrupts shows an IRQ every 10ms, which was expected
>>> since I have CONFIG_HZ=3D100
>>>
>>> I am pretty sure that I messed up something in the patch process,
>>> however I do not know where to start to look for.
>>
>>
>> Apply the patches to the proper imx release, and everything should be =
fine.
>=20
>=20
> That is what I did, at last.
> To do so, I have extracted the BSP from the given 'almost'=20
> rel_imx_3.0.35_12.09.02 kernel,
> taken the rel_imx_3.0.15_12.03.00, applied the patches,
> and brought back the BSP to the patched kernel.


I would do what you want to do with git. Checkout the ipipe-3.0-imx6q
branch from the ipipe-gch.git, then merge it with the vendor branch you
want to use.

--=20
                                                                Gilles.


