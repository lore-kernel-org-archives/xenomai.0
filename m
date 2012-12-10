Message-ID: <50C643DC.1080901@xenomai.org>
Date: Mon, 10 Dec 2012 21:19:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr> <50C236B9.3030507@xenomai.org>
	<50C4EF5A.3030502@wanadoo.fr> <50C524A6.6020006@xenomai.org>
	<50C5F784.6040801@wanadoo.fr> <50C6076F.7050505@xenomai.org>
	<50C60E6A.1080307@wanadoo.fr> <50C61DF3.8030703@xenomai.org>
	<50C62B41.1060308@wanadoo.fr> <50C63069.1010607@xenomai.org>
	<50C63FF3.6040409@wanadoo.fr>
In-Reply-To: <50C63FF3.6040409@wanadoo.fr>
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

On 12/10/2012 09:02 PM, Thierry Bultel wrote:

> Le 10/12/2012 19:56, Gilles Chanteperdrix a =C3=A9crit :
>> On 12/10/2012 07:34 PM, Thierry Bultel wrote:
>>
>>> Le 10/12/2012 18:37, Gilles Chanteperdrix a =C3=A9crit :
>>>> On 12/10/2012 05:31 PM, Thierry Bultel wrote:
>>>>> Le 10/12/2012 17:01, Gilles Chanteperdrix a =C3=A9crit :
>>>>>> On 12/10/2012 03:53 PM, Thierry Bultel wrote:
>>>>>>> Le 10/12/2012 00:54, Gilles Chanteperdrix a =C3=A9crit :
>>>>>>>> On 12/09/2012 09:06 PM, Thierry Bultel wrote:
>>>>>>>>
>>>>>>>>> Le 07/12/2012 19:34, Gilles Chanteperdrix a =C3=A9crit :
>>>>>>>>>> On 12/07/2012 02:28 PM, Thierry Bultel wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Hello Gilles,
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I have "successfully" patched a 3.0.35 kernel from Freescale =
with
>>>>>>>>>>> adeos-ipipe-3.0.36-1.18.11
>>>>>>>>>>>
>>>>>>>>>>> I have -not- applied the adeos-ipipe-3.0.36-arm-1.18-11-pre.p=
atch
>>>>>>>>>>> that showed too much "revert patch detected" errors.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The patch should apply cleanly, the question, if you get too m=
any
>>>>>>>>>> rejections, it is because you do not apply it to the proper br=
anch.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Of course it was not.
>>>>>>>>> I started with a kernel provided by the module manufacturer. I =
estimate
>>>>>>>>> that this kernel is "almost" a rel_imx_3.0.35_12.09.02, I mean,=
 that
>>>>>>>>> I have not found a closer tag than this one.
>>>>>>>>>
>>>>>>>>> My first idea was to attempt to apply the patches to that kerne=
l
>>>>>>>>> directly. I was not expecting it would have been simple, and it=
 was
>>>>>>>>> actually not. But after a few hours I came to the initial resul=
t I said.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> BTW, I have understand that its purpose was mainly to upgrade=
 to 3.0.36,
>>>>>>>>>>> but what is actually the role of the
>>>>>>>>>>> adeos-ipipe-3.0.36-arm-1.18-11-post.patch ? (I applied it).
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I have explained this in a previous mail.
>>>>>>>>>
>>>>>>>>> Ok, I will seek in the history. I would be nice if the explanat=
ion
>>>>>>>>> was in the README.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I had to deal with some rejections but at least the kernel is=
 booting
>>>>>>>>>>> and my application running.
>>>>>>>>>>>
>>>>>>>>>>> But the target is very slow, and /proc/xenomai/irq shows that=
 the
>>>>>>>>>>> [timer] irq only comes about every 1 second.
>>>>>>>>>>>
>>>>>>>>>>> The /proc/interrupts shows an IRQ every 10ms, which was expec=
ted
>>>>>>>>>>> since I have CONFIG_HZ=3D100
>>>>>>>>>>>
>>>>>>>>>>> I am pretty sure that I messed up something in the patch proc=
ess,
>>>>>>>>>>> however I do not know where to start to look for.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Apply the patches to the proper imx release, and everything sh=
ould be fine.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> That is what I did, at last.
>>>>>>>>> To do so, I have extracted the BSP from the given 'almost'
>>>>>>>>> rel_imx_3.0.35_12.09.02 kernel,
>>>>>>>>> taken the rel_imx_3.0.15_12.03.00, applied the patches,
>>>>>>>>> and brought back the BSP to the patched kernel.
>>>>>>>>
>>>>>>>
>>>>>>> The issues I mentionned are not also present with CONFIG_IPIPE=3D=
no,
>>>>>>> so it is just that the 3.0.15 kernel does not have everything for=
 my board.
>>>>>>>
>>>>>>>>
>>>>>>>> I would do what you want to do with git. Checkout the ipipe-3.0-=
imx6q
>>>>>>>> branch from the ipipe-gch.git, then merge it with the vendor bra=
nch you
>>>>>>>> want to use.
>>>>>>>>
>>>>>>>
>>>>>>> Sure it would work and would be fine with git.
>>>>>>> But unfortunalely I do not have access to the repository of the v=
endor,
>>>>>>> but only to a bz2 snapshot of their kernel.
>>>>>>>
>>>>>>> I wonder if the right method would be to use git to merge Ipipe t=
o the
>>>>>>> 3.0.35_12_09.02, and then bring back the BSP that I have isolated=
 as a patch
>>>>>>
>>>>>> Yes, if the vendor BSP is based on 3.0.35_12_09.02, you should mak=
e a
>>>>>> diff with that, and try and merge it with the ipipe-3.0-imx6q bran=
ch.
>>>>>>
>>>>>
>>>>>
>>>>> Done. And success. Thanks. I am running your 3.0.43 kernel with my =
BSP.
>>>>> no more network or reboot slowness issues.
>>>>>
>>>>> However, htop it saying that CPU0 is at 20% and CPU3 at 12%,
>>>>> no application is running. The only thing that I see running is the=

>>>>> timer interrupt.
>>>>>
>>>>> Also, I still have
>>>>> 87:         13          0          0          0       GIC  i.MX Tim=
er Tick
>>>>>
>>>>> .. the counter increases very slowly, about 1 every 10 minutes mayb=
e.
>>>>>
>>>>> That does not happen with CONFIG_IPIPE=3Dno
>>>>
>>>> Do you have CONFIG_LOCALTIMER (and CONFIG_SMP) enabled?
>>>>
>>>>
>>>
>>> CONFIG_SMP yes,
>>> You mean CONFIG_LOCAL_TIMERS ? Yes
>>
>>
>> Could you post the disassembly of the mxc_timer_interrupt function?
>>
>=20
> Hope this helps:
>=20
> 8006e93c <mxc_timer_interrupt>:
> 8006e93c:       e3031998        movw    r1, #14744      ; 0x3998
> 8006e940:       e92d4010        push    {r4, lr}
> 8006e944:       e34810c7        movt    r1, #32967      ; 0x80c7
> 8006e948:       e3020a00        movw    r0, #10752      ; 0x2a00
> 8006e94c:       e34800c3        movt    r0, #32963      ; 0x80c3
> 8006e950:       e3a04001        mov     r4, #1
> 8006e954:       e5912000        ldr     r2, [r1]
> 8006e958:       e5903000        ldr     r3, [r0]
> 8006e95c:       e5921008        ldr     r1, [r2, #8]
> 8006e960:       e5824008        str     r4, [r2, #8]
> 8006e964:       e12fff33        blx     r3
> 8006e968:       e1a00004        mov     r0, r4
> 8006e96c:       e8bd8010        pop     {r4, pc}
>=20
> Tell me if you need more information
>=20
>=20

Ok, this looks compiled as the sources tell us. The thing I do not
understand is that since there is another clockevent running (the local
timers), the mxc_timer should not be ticking at all. What does cat
/proc/timer_list say?

Also, you can try adding the call to __ipipe_tsc_update in
mxc_timer_interrupt even in the SMP case. If you have a problem with the
tsc, the "tsc" test from Xenomai testsuite should fail after some time
when run with the "-w" argument, but normally the tsc should take a long
time to wrap, so, there should not be immediately visible effects. But
it is worth checking.

--=20
                                                                Gilles.


