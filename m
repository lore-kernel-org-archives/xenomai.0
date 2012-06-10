Message-ID: <4FD50AD1.3060305@xenomai.org>
Date: Sun, 10 Jun 2012 23:00:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net> <4FCD0C4D.6000004@xenomai.org>
	<4FD4EB23.7080203@laposte.net>
In-Reply-To: <4FD4EB23.7080203@laposte.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] "illegal instruction",
 then "rt_task_start()" error -38 (on a 486/no fpu)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc Le Douarain <marc.le-douarain@laposte.net>
Cc: xenomai@xenomai.org

On 06/10/2012 08:44 PM, Marc Le Douarain wrote:
> Le 04/06/2012 21:28, Gilles Chanteperdrix a =C3=A9crit :
>> On 06/04/2012 09:26 PM, Marc Le Douarain wrote:
>>> Hello,
>>>
>>> I've some difficulties to run Xenomai with a little 'hello' example
>>> (that create/start a task)
>>> on a target 486 processor (without fpu).
>>>
>>> I successfully compiled the Linux kernel 2.6.38.8 with
>>> adeos-ipipe-2.6.38.8-x86-2.11-02.patch (Xenomai version is 2.5.6)
>>> (modify file xenomai-2.5.6/include/asm-x86/calibration.h
>>> "current_cpu_data"->"cpu_info" were required)
>>>
>>> dmesg extract:
>>> [    0.000000] I-pipe 2.11-02: pipeline enabled.
>>> ...
>>> [    0.140008] CPU: Cyrix Cx486SLC
>>> ...
>>> [    1.440804] Xenomai: hal/i386 started.
>>> [    1.448804] Xenomai: scheduling class idle registered.
>>> [    1.452804] Xenomai: scheduling class rt registered.
>>> [    1.488806] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) l=
oaded.
>>> [    1.496807] Xenomai: starting native API services.
>>> [    1.500807] Xenomai: starting POSIX services.
>>> [    1.504807] Xenomai: starting RTDM services.
>> It may be due to the omit-frame-pointer option, please try adding
>> -fno-omit-frame-pointer to the CFLAGS
> Thanks for the tip,
> now it seems to work correctly !
> I've used the following command line to configure Xenomai user-part :
> "./configure CFLAGS=3D"-march=3Di486 -fno-omit-frame-pointer"=20
> LDFLAGS=3D"-march=3Di486" --disable-x86-sep --disable-x86-tsc"
>=20
> I've savagely modified latency.c, to avoid libm and double variables in=
=20
> the code,

As far as I can tell, the only reason we use libm is for sqrt. So, you
can use libm for floating points, and replace sqrt with a simple
newton-method base implementation.

--=20
                                                                Gilles.


