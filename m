Message-ID: <4FDE2DDC.1080508@xenomai.org>
Date: Sun, 17 Jun 2012 21:19:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net>
	<4FCD0C4D.6000004@xenomai.org>	<4FD4EB23.7080203@laposte.net>
	<4FD4FF04.2030804@xenomai.org>	<4FD61BF8.9090901@laposte.net>
	<4FD62635.7040501@xenomai.org> <4FDE2A66.8000904@laposte.net>
In-Reply-To: <4FDE2A66.8000904@laposte.net>
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
Cc: Xenomai <xenomai@xenomai.org>

On 06/17/2012 09:05 PM, Marc Le Douarain wrote:
> Le 11/06/2012 19:09, Gilles Chanteperdrix a =C3=A9crit :
>> I think vortex86sx has a tsc, so, you should try and modify the linux
>> kernel configuration to select  CONFIG_X86_TSC, or simply select a
>> processor which has a tsc. You will get better latencies.
>>
> I've made two more tests:
> - compiling for Pentium-Classic (M586-TSC)
> =3D> Kernel doesn't boot at all
> (I've seen invalid opcode, and after I-pipe stack call-trace=20
> ftrace_make_nop)
>=20
> - modifying arch/x86/Kconfig.cpu (there isn't any M486-TSC ! and X86-TS=
C=20
> can't be acceded directly!?)
>    in config X86_TSC, adding for depends on M486
> =3D> But also kernel not working.
>=20
> I'm finally not sure if there is a TSC available in the Vortex86sx,
> perhaps only on the Vortex86dx (fpu difference only normally),
> or none !?

Someone on this list claimed that vortex86sx may have a tsc:
http://www.xenomai.org/pipermail/xenomai-help/2010-01/msg00153.html

I do not know for sure however.

>=20
> Here with my previous 486 kernel, what gives /proc/cpuinfo:
> processor       : 0
> vendor_id       : CyrixInstead
> cpu family      : 4
> model           : 1
> model name      : Cx486SLC
> stepping        : unknown
> fdiv_bug        : yes
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : no
> fpu_exception   : no
> cpuid level     : -1
> wp              : yes
> flags           :
> bogomips        : 96.51
> clflush size    : 32
> cache_alignment : 32
> address sizes   : 32 bits physical, 32 bits virtual
> power management:

You would have "tsc" in the flags if that cpu had a tsc. So, I guess you
are right, this cpu does not have a tsc.

--=20
                                                                Gilles.


