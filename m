Message-ID: <4B9E7520.8000107@domain.hid>
Date: Mon, 15 Mar 2010 18:57:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1003151439040.27204@domain.hid>	
	<1268663424.27899.226.camel@domain.hid>	
	<4B9E6312.6010109@domain.hid>
	<1268673002.27899.230.camel@domain.hid>
In-Reply-To: <1268673002.27899.230.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem throwing a C++ Exception on Blackfin
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
> On Mon, 2010-03-15 at 17:40 +0100, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2010-03-15 at 15:00 +0100, Kolja Waschk wrote:
>>>> Hi,
>>>>
>>>> first I have to admit that my report is actually about a problem with a quite old Xenomai (Nucleus 2.4.7, I-pipe 1.10) in "stock" Blackfin uClinux kernel 2.6.28 as it comes in Blackfin uClinux-dist 2009R1-RC6.
>>>>
>>>> Testing a newer code base would probably require some days of work to update a custom driver and bring up other problems, so I'm trying to find out whether it is worth the effort at this time. Maybe someone can (roughly) identify the problem's cause (from memory?) and help me to decide whether there is a simple solution, or an upgrade is necessary:
>>>>
>>> No obvious answer to this. 2.6.28/bfin has problems, the whole exception
>>> management on blackfin is a problem per se. 2.6.28/bfin + I-pipe has
>>> even more problems. You may want to try 2.6.31.6, while keeping the rest
>>> of your uClinux-dist base. Nasty issues were fixed in the 2.6.30
>>> timeframe.
>> Are you sure C++ exceptions need hardware exceptions at all? That the
>> problem is not rather that we have some C code without exception
>> handling traversed by exceptions? Should not the Xenomai support
>> libraries be compiled with -fexceptions to allow mixing them with code
>> which throws/catches exceptions?
> 
> It's not about using hw to process C++ exceptions. It's about having
> problems handling hw exceptions in kernel space triggered by C++
> exceptions in user-space.

The main problem may be why C++ exceptions in user-space do trigger hw
exceptions in kernel-space. And I would tend to think that a missing
-fexceptions could be the cause. Except that in the testcase, the
exception does not traverse any Xenomai library code, since it is thrown
and handled in the same function.

> 
>>
> 
> 


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

