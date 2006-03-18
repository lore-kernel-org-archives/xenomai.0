Message-ID: <441C4460.9030103@domain.hid>
Date: Sat, 18 Mar 2006 18:33:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: get the simulator running...
References: <441C2574.4030901@domain.hid> <441C4279.10800@domain.hid>
In-Reply-To: <441C4279.10800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Philippe,
>>
>> here are some patches and comments on the simulator "quick"-start
>> process. I guess the patches are due to latest changes in trunk, and I
>> cannot guarantee that they are clean - but the simulator compiles now.
>>
>> Regarding the rest of its build and start process: There are two hidden
>> requirements, namely gcc < 4 (due to -fwritable-strings)
> 
> 
> Normally, availability of --fwritable-strings should be auto-detected by 
> the configure script. So there is something wrong going there, I will 
> look at it.
> 
>  and gdb 5.x. A
> 
> I've been unlucky with GDB 6.x too, but did not check the latest 
> release; I'm currently using 5.3 when running simulations.
> 
>> note in sim/README about them would be great. Or do you have a fix for
>> those issues scheduled?
> 
> 
> --fwritable-strings should be fixed. I'm not sure if the requirement for 
> GDB 5.x still applies though.
> 
>>
>> Well, once you got this far (i.e. the xenoscope is built and an ancient
>> gdb has been prepared), the next step is to produce a test program. Am I
>> overseeing some example?
> 
> 
> Look into ksrc/skins/{vxworks,psos+}/demos. The Makefile also produces a 
> simulation executable for satch. Then run "xenoscope satch_sim"
> 
>  Fortunately, I had that demo I once produced
> 
>> (last year), but that one was easier to build. I first had to drag in
>> the libs and includes of both the simulator and a regular xenomai
>> installation (I think to remember this once worked without this
>> add-ons). Then I need this additional trick in the simulators include 
>> dir:
>>
>> mkdir asm
>> ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
>>
>> This maps #include <asm/xenomai/system.h> to the correct "arch".
>> Shouldn't this be created automatically during the simulator
>> installation? Or is something else broken on my box?
>>
> 
> You clearly should not need this trick to compile apps against the 
> simulation environment; the instrumenter (gcic) sets the proper flags. 
> I'm going to rebuild one and let you know.

Confirmed. You don't need this hand-made link.

-- 

Philippe.

