Message-ID: <4442B118.4070300@domain.hid>
Date: Sun, 16 Apr 2006 17:03:20 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running testsuite
References: <200604131149.40706.tmarscha@domain.hid>	<443E9FD2.6070807@domain.hid>	<200604141342.40129.tmarscha@domain.hid>	<17471.38482.617361.14216@domain.hid>
	<443FB0BA.5060404@domain.hid> <44427E26.6040608@domain.hid>
In-Reply-To: <44427E26.6040608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Jim Cromie wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Tobias Marschall wrote:
>>>  > Hello,
>>>  >  > On Thursday 13 April 2006 21:00, you wrote:
>>>  > > I saw a similar error when using --enable-x86-sep and not 
>>> having NPTL
>>>  > > enabled in glibc.
>>>  > > Try configuring without --enable-x86-sep (used in the 
>>> README.INSTALL
>>>  > > Pentium x86 example, the default is disabled).
>>>  > that did the trick, thank you for the hint! I did check that the 
>>> cpu supported  > the sep instruction, but I wasn't aware that NPTL 
>>> is required in this case.
>>>  >  > Mentioning this in README.INSTALL would be helpful. I wonder 
>>> if that mistake  > could be caught by configure.
>>> It could be caught by configure, at least if not cross-compiling, by
>>> running getconf GNU_LIBPTHREAD_VERSION.
>>>
>>>   
>>
>> ie:
>> [jimc@domain.hid xenomai]$ getconf GNU_LIBPTHREAD_VERSION
>> NPTL 2.3.6
>>
>> doesnt /proc/cpuinfo, flags entry, indicate whether the cpu supports 
>> SEP ?
>>
>
> It should, yes.
>
>> flags           : fpu vme de pse tsc msr mce cx8 apic mtrr pge mca 
>> cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
>>
>
> Strange indeed, if that's a recent genuine Intel CPU.
>

Well, Im not *stoned*, but it clearly looks like I am..
heres the whole thing:

[jimc@domain.hid linux-2.6.16]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.70GHz
stepping        : 6
cpu MHz         : 600.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips        : 1198.01


very strange.   Ive seen someone elses P-4 cpuinfo, flag is there, 
spelled 'sep'


>>
>> what x86 processors support --enable-x86-sep ?   Pentium-4 ?  Xeon ? 
>> Athlon ?
>> my Pentium-M apparently doesnt.
>
> AFAIK, Intel supports sysenter/sysexit since the PII, and AMD 
> introduced them with the K7. The genuine Pentium M does support them, 
> no doubt.
>
Perhaps I need to email LKML.
What would you expect if I built with --enable-sep (for my laptop) ?
success / illegal-instruction exception / undefined-wierd behavior ?
>>
>>
>>
>> WRT inferring more stuff from the build/host machine, I have some 
>> concerns;
>> I build on my 686 laptop for a smaller/different 586 target.  This is 
>> not 'cross-compilation',
>> and could be compromised by too many automatic optimizations.
>> So, ideally, Id like the potentially troublesome optimizations to be
>> identified and gated by a prompt.
>>
>> Maybe we need a script thats run on the target box, that collects
>> the needed configuration factors; presumably including:
>> CPUFLAGS=`grep flags /proc/cpuinfo`
>> NPTL_AVAIL=`getconf GNU_LIBPTHREAD_VERSION`
>>
>
> The problem is that we might not always have the target at hand when 
> building the user-space support (e.g. LiveCD, deployment distro 
> stuff). Therefore it could only be some optional helper, but not part 
> of the regular build process.
>
Ack. 
I was thinking in terms of a script run on target, which produces an .rc 
file,
which defines the factor=value pairs needed.
that file, if supplied to prepare-kernel as  --target-info=<foo>
would supply the customizations.
Yes, somewhat cumbersome..

Perhaps Ive just been lucky, 'cross-compiling' for 586 on 686.
Ill try hacking prepare-kernel and re-building.
>>
>> Somewhat related: prepare-kernel asks me for target architecture, I 
>> started by entering i586 explicitly,
>> but after a while, just took the i686 default.  Ive not noticed 
>> anything different/wrong,
>> but would appreciate confirmation/explanation.
>>
>
> Which information did you look at to determine that it was using the 
> 686 profile?
The script output told me.  In response to my post, Gilles sent me the 
snippet
from scripts/prepare-kernel where all x86) select i386.

Im not sure what youre asking, so I'll answer something (hopefully) close:
config/config.guess is providing the basis for the answer

if test x$linux_arch = x; then
   build_arch=`$xenomai_root/config/config.guess`
   default_linux_arch=`echo $build_arch|cut -f1 -d-`
fi

which 'returns' this:
        test x"${LIBC}" != x && echo "${UNAME_MACHINE}-pc-linux-${LIBC}" 
&& exit 0

ie
sh -vx config/config.guess
...
+ eval LIBC=gnu
LIBC=gnu
++ LIBC=gnu
+ test xgnu '!=' x
+ echo i686-pc-linux-gnu
i686-pc-linux-gnu


>
>> thanks
>> jimc
>>
>>
>> PS.  attached is an attempt to improve README.INSTALL along these and 
>> other lines.
will redo per your comments

