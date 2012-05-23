Message-ID: <4FBCB89A.9090801@wanadoo.fr>
Date: Wed, 23 May 2012 12:14:50 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <4FBCB442.5030208@wanadoo.fr> <4FBCB64E.6090209@xenomai.org>
In-Reply-To: <4FBCB64E.6090209@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] iMX6 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 23/05/2012 12:05, Gilles Chanteperdrix a =C3=A9crit :
> On 05/23/2012 11:56 AM, Thierry Bultel wrote:
>> Hi,
>>
>> We are looking in a replacement solution for our obsolete
>> pentium-Celeron calculator.
>> For many reasons, we would like to switch to the ARM architecture.
>> The aimed CPU is the iMX6 Quadcore.
>>
>> Freescale provides a patched 2.6.35 and 2.6.38 kernel that do not have
>> all the peripherals (the CAN seems to be missing)
>> and Emtrion, a CPU module manufacturer, say they provide the additiona=
l
>> patches to have the complete BSP.
>> It is likely a 2.6.35 only, though.
> Xenomai for mx6q does not exist for linux 2.6.35. It only exists for
> freescale branch for 2.6.38, or 3.0, as a separate set of patches to
> apply before and after the Adeos patches for the vanilla kernel. For
> further details, see ksrc/arch/arm/patches/README in xenomai 2.6 source=
s.
Thanks, yes, as I said, I am aware that the very first work for me will=20
be to get
the non-xenomai 2.6.38 kernel fully working
> Furthermore, we have some stability issues with Xenomai for mx6q with
> 3.0, the issues looking a lot like an issue with cache. We would ned to
> recheck 2.6.38 to see if it had the same issues, but I would bet it doe=
s.
>
Actually my concern was to know if there were currently developments
on that CPU. The fact that they are remaining bugs is not a concern,
as long as they would be likely be corrected in the coming months.
Do these bugs also exist on the mx6 single core ?

