Message-ID: <b6692aadc37f290753041c6a07ba76f4.squirrel@www.xenomai.org>
In-Reply-To: <FC582130-25A2-4C10-BD94-1034E2768B8D@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
	<c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
	<FC582130-25A2-4C10-BD94-1034E2768B8D@mah.priv.at>
Date: Sat, 3 Nov 2012 14:08:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
 semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org


Michael Haberler wrote:
>
> Gilles,
> Am 03.11.2012 um 10:37 schrieb Gilles Chanteperdrix:
>>
>> http://www.xenomai.org/index.php/I-pipe:Tracer
>
> thanks for the version hint - it was all in place, just needed to
> configure - building now.
>
>> Also note that if LinuxCNC code runs in kernel-space, you should not be
>> using the native API, but the RTDM API.
>
> I missed out that fineprint in the roadmap.. yes, these are kernel-space
> threads
>
> reading through the examples it occurs to me adapting to RTDM pretty much
> only involves changing includes, the --skin=rtdm argument to xeno-config,
> and changing the native rt_* calls to the next best rtdm_* calls

Actually, for kernel-space, you do not need xeno-config.

>
> that's all, and I'll be happy ever after even after the merge with
> RT_PREEMPT ;-?

Yes, that is the point, the port of RTDM over the Linux kernel API already
exists, though AFAIK it is not merged yet in the xenomai-forge tree.

Another option for your case would be to implement the rtapi_ services as
a Xenomai skin, but in that case you would have some work when merging with
PREEMPT_RT.

-- 
                    Gilles.


