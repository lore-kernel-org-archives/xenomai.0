Message-ID: <49D5F4DC.2020109@domain.hid>
Date: Fri, 03 Apr 2009 13:37:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47104.41238755290008.JavaMail.root@domain.hid>
In-Reply-To: <47104.41238755290008.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Not able to execute xenoscope.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: virendra.agadi@domain.hid
Cc: xenomai@xenomai.org

virendra.agadi@domain.hid wrote:
> HI All,
> I have recently joined the xenomai-help group.
> 
> I want to upgrade uItron skin to the spec 4.0 as my application to be ported is uITRON 4.0 complient.
> I have built the adeos patch along with linux kernel on x86 machine(PC)and also installed xenomai patched kernel.
> Versions used:
> Linux kernel: 2.6.25.11 (Fedora 9)
> Xenomai Version: xenomai-2.4.7
> Xenosim Version: xenosim-2.4.7
> 
> Now I am trying to configure Xenosim, for basic testing and profiling. Going forward I would be extensively using Xenosim to test and profile uITRON 4.0 skin. I hope I will be able to commit uITRON-4.0 skin along with Xenosim testsuite for uITRON in future.
> 
> I built xenosim successfully except got one compiler error related to type "__user" in files heap.h,heap.c,queue.c and queue.h, which I resolved by adding /linux/conpiler.h in files heap.h and queue.h under path ""xenomai-2.4.7/include/native". 
> I installed the Xenosim as refered in README.txt present under xenosim directory.
> 
> I got the targets Xenoscope and gcic installed in xenosim build DIR/bin
> Then I tried with posix demos present along with the xenosim package.
> 
> I followed the steps:
>> export PATH=/usr/xenomai/bin:$PATH
>> export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
>> cd ../xenomai-2.4.7/sim_build/skins/posix/demos
>> make satch_sim
>> xenoscope satch_sim
> 
> but I could not get the xenoscpe UI window.
> I also tried just running xenoscope but still I am not getting the window.
> 
> After debuging using GDB I see that in file "bridge.cc", it could successfully initialize Tcl_Init(tclInterp) and Tk_Init(tclInterp), 
> but at function Tix_Init(tclInterp) it gives segmentation fault, I could not step into the function.
> So basically Tix_Init is failing/crashing for me, due to which I am not getting xenoscope window.
> 
> Please let me know if there is any version mismatch in Tix,TCL or TK? or is there any other issue?
> Here are the versions of TCL.TK and TIX
> TCL version : 8.3.5
> TK version: 8.3.5
> TIX version: 4.1
> 
> As I am new to Linux and also Xenomai/Xenosim, I am not sure if the Xenosim problems are to do with the way I configure/build/install Xenosim.
> Please any one can guide me as to why Tix_Init() got crashed?

We already answered questions about xenomsim to people working for the
same company as you. So, please communicate with them, or browse the
archives to find the answer we gave.

As for your promise to maybe contribute the uitron v4.0 support, it is
very kind of you. But you see, we saw several times people promising to
contribute things, getting help, and never contribute anything. So, this
time we will proceed differently: show us the undebugged code first, and
you will help you debug it.

-- 
					    Gilles.

