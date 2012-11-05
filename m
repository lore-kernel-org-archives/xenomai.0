Message-ID: <509809A1.9030304@xenomai.org>
Date: Mon, 05 Nov 2012 19:46:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>	<505F0D40.9030105@xenomai.org>	<50741C5B.4060206@wanadoo.fr>
	<5074986C.8000509@xenomai.org> <50749A03.9090607@xenomai.org>
	<50749C71.2020100@xenomai.org> <5075260E.2050402@wanadoo.fr>
	<507528E4.4050809@xenomai.org> <50752A42.9080303@web.de>
	<50752C0C.3050803@xenomai.org> <50752D7E.7010207@web.de>
	<507538C8.7040706@xenomai.org> <50753980.7020409@web.de>
	<50753EA0.7070007@xenomai.org> <50754849.9030205@web.de>
	<507548DE.2000305@xenomai.org> <50754D0F.50407@web.de>
	<507553D0.8070305@xenomai.org> <50755C40.5080002@xenomai.org>
	<50756572.5020108@xenomai.org> <50756B26.4040505@xenomai.org>
	<50756D00.6030203@xenomai.org> <5075703C.7080502@xenomai.org>
	<507570A8.5000301@xenomai.org> <507571AA.2040600@xenomai.org>
	<50757393.4090407@xenomai.org> <5075753D.6080703@xenomai.org>
	<50757597.6010600@xenomai.org> <507575DD.2080409@xenomai.org>
	<50757EBD.7080506@xenomai.org> <50767DCC.6030404@xenomai.org>
	<5097C028.9040108@wanadoo.fr>
In-Reply-To: <5097C028.9040108@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: Jan Kiszka <jan.kiszka@web.de>, Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

On 11/05/2012 02:33 PM, Thierry Bultel wrote:

> Le 11/10/2012 10:05, Gilles Chanteperdrix a =C3=A9crit :
>> On 10/10/2012 03:57 PM, Philippe Gerum wrote:
>>>> Except if we invent another scheduler lock service, simply for the
>>>> purpose of spinlocks where suspending the spinlock holder does not m=
ake
>>>> sense anyway.
>>>>
>>>
>>> Oh, well, ok. Ack.
>>>
>>> Let's just make sure that we can fold the whole thing into a single s=
et
>>> of services at some point in 3.x though.
>>>
>>> The core issue is that we should not even have to expose a scheduler
>>> locking service to userland, but emulating traditional RTOS APIs
>>> requires that. What a braindamage counter-feature for a real-time sys=
tem
>>> when one thinks of it.
>>
>> I think we can have the cake and eat it. The idea is to follow the
>> approach in the patch I sent, merged with the one you commited, but
>> simply, in xnpod_suspend_thread, clear the XNHELDSPIN (misnomed if use=
d
>> for that), and simply when we wake up, re-set the bit in the scheduler=

>> if the thread preemption count is not 0.
>>
>=20
> Hi,
> sorry to come on that thread again, but it is not clear to me if the
> issue has been adressed or not.
> I have noticed the "nucleus: introduce internal sched locking helpers"
> commit, that seems related but I am not sure.
> Sorry for the noise.


I have posted a patch, and await Philippe's approval. The patch may have
some dubious side effects, it is here:

http://www.xenomai.org/pipermail/xenomai/2012-October/026523.html

--=20
                                                                Gilles.


