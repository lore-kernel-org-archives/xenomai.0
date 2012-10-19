Message-ID: <5080D88E.8040903@xenomai.org>
Date: Fri, 19 Oct 2012 06:35:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507D7A0C.7090209@gmail.com> <507E05B4.2040704@xenomai.org>
	<507F501A.4000500@gmail.com> <507F8579.6040604@xenomai.org>
	<50809DD8.60901@gmail.com>
In-Reply-To: <50809DD8.60901@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Installing Xenomai Newbie
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U2ViYXN0acOhbiBQYXZleg==?= <sebastian.pavez.t@gmail.com>
Cc: xenomai@xenomai.org

On 10/19/2012 02:24 AM, Sebasti=C3=A1n Pavez wrote:

> El 18-10-2012 1:28, Gilles Chanteperdrix escribi=C3=B3:
>> On 10/18/2012 02:40 AM, Sebasti=C3=A1n Pavez wrote:
>>
>>> El 16-10-2012 22:11, Gilles Chanteperdrix escribi=C3=B3:
>>>> On 10/16/2012 05:15 PM, Sebasti=C3=A1n Pavez wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> My name is Sebastian and I'm a chilean student from PUCV. Currently=
 I
>>>>> have to develop a RT proyect, but the problem is that I dont have
>>>>> experience with Linux and a lot less with Xenomai. Nevertheless i
>>>>> arrived to install xenomai  2.6.0 on Ubuntu 12.04, but when I try t=
o
>>>>> execute ubuntu with the xenomai kernel the screen goes black
>>>> Please remove "quiet" from Linux command line, and make sure that yo=
u
>>>> have all the drivers necessary for the your system to boot, includin=
g:
>>>> - video display driver
>>>> - root file system device driver
>>>> - root file system driver
>>>>
>>> Hi,
>>>
>>> I tried to everything from scratch, but i get the same problem. I tri=
ed
>>> remove the quiet splash and I could see the line
>>> "Fallback graphics default" well, this is when I execute the kernel w=
ith
>>> xenomai in recovery mode. Because when I tried it in
>>> a normal way I get the blacl screen with a twinkle, in this case I'm
>>> able to put my password and I heard the entry sound (with some
>>> distorsion), so like you said it maybe some driver's problem.
>>> In the recovery mode I checked the application drivers and nothing.
>>> Maybe it's something simple but I'm quite stuck, I've never used linu=
x
>>> before and I really need to get this operative, so if you or someone
>>> else could help me ... in plain language would be awesome ...
>>> Thanks in advance
>>>
>>> PS: In the recovery mode I tried the xenomai tests, I attached the
>>> captures ...
>>
>> Your problem is configuring the kernel. So, please start with the Ubun=
tu
>> kernel configuration, and simply disable the problematic options
>> described here:
>> http://www.xenomai.org/index.php/Configuring_x86_kernels
>>
>> If you do not know how to configure and compile a kernel, I suggest yo=
u
>> read some documentation on the web, such as:
>> http://kernelnewbies.org/KernelBuild
>>
> Thanks Gilles for your answers and time.
>=20
> I tried one more time from scratch. I used Xenomai 2.6.0 and the kernel=
=20
> Linux 2.6.38.8.
> The only changes I made in the configuration are the suggested in the=20
> page you send me (_CPU_FREQ, _APM, _ACPI_PROCESSOR _INTEL_IDLE,=20
> _PCI_MSI), I also disable _CC_STACKPROTECTOR and in the Preemption Mode=
l=20
> i choose "Preemptible Kernel (Low-Latency Desktop)". I have a i3=20
> processor so I choose the Core 2/newer Xeon's Processor family.


You forgot to disable KGDB.

>=20
> I got the same result (black screen with the sistem apparently working =

> behind like I said), I realise that I didn't follow the recomendations =

> mentioned in this page http://kernelnewbies.org/KernelBuild, because I =

> tried to follow this tutorial=20
> http://www.blaess.fr/christophe/2011/12/28/xenomai-2-6-0-sur-ubuntu-11-=
10/=20
> . So tomorrow I will try to do this on my own with newer versions of th=
e=20
> kernel and probably with xenomai 2.6.1.
>=20
> Before that I would like to know if the configuration parameters I=20
> choose are ok, I don't know how to get a list of all of the parameters =

> to put it here but the only changes I made are the ones listed above. I=
=20
> have doubts with Preemptible Kernel option because it wasn't listed on =

> the page, so I really don't know what is the cause. If it's not a=20
> configuration issue, could be other causes to my problem?? ... I hope=20
> not, because at least it's delimited.


Well, simply attach the .config file...

--=20
                                                                Gilles.


