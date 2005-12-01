Message-ID: <438EDCF0.5070105@domain.hid>
Date: Thu, 01 Dec 2005 12:22:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
References: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFD4A@ILEX5.IL.NDS.COM>
In-Reply-To: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFD4A@ILEX5.IL.NDS.COM>
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
To: "Ashri, Sarit" <Sashri@domain.hid>
Cc: xenomai@xenomai.org

Ashri, Sarit wrote:
> Hi Philippe,
> 
> I did read the files. What I don't understand is how to build the
> Xenomai
> With Simulator support?
> When I build Xenomai without simulator support - everything works just
> fine
> (crossed compiled to work on PPC with Linux 2.6.13.4).
> As soon as I mark Simulator->Minute Virtual Machine I get that error
> (X11 library..).
> I understood from reading previous mails on the internet that I should
> be able to 
> build the MVM on my host computer which is NOT patched by Adeos (RHEL3.0
> Linux on i686)
> through Regular Xenomai CROSS_COMPILING and installation.

Try this:

- Build your target system first without the simulator using 
cross-compilation for ppc. Let's say that you installed the results 
under /usr/realtime, which is the default.

- Then, build the simulator separately for the host:

$ mkdir sim-build && cd sim-build
$ .../xenomai/sim/configure --with-xeno-dir=/usr/realtime 
--with-gcc-tarball=/something/gcc-2.95.3.tar.bz2
$ make install

> 
> If I try using the unpatched host Linux version (2.4) I get the
> following error message from
> Xenomai configuration: 
> ...
> checking for Linux build tree... /lib/modules/2.4.21-32.EL/build (kernel
> 2.4.21-32.ELcustom)
> checking for Linux source tree... /lib/modules/2.4.21-32.EL/build
> checking for interrupt pipeline extension... configure: error: No
> interrupt pipeline extension enabled in your kernel.
>         You need to apply an Adeos patch first.
> make: *** [config.status] Error 1
> 
> Should I:
> 1. Try compiling with my patched Linux 2.6 - won't I have problems
> running programs 
> compiled for Linux 2.6 on Linux 2.4?
> 2. compile Xenomai without Simulator support and then try installing the
> simulator separately?
> BTW when I try to install the simulator separately:
> I ran sim/configure it passed and so did make and make install of the
> simulator directly in sim directory, but when I tried to compile the
> demos with gcic (make sim) I received the error message:
> "gcic:instrumenter/compiler is missing -- please check your
> installation."
> So I thought this might not be the correct way to do it. Maybe I should
> continue on this
> road?
> 3. Something else?
> 
> I'm new to Xenomai and Linux so excuse me if I'm missing something
> basic.
> I appreciate your help!
> Sarit
>  
> 
>>Philippe Gerum wrote:
>>
>>>Ashri, Sarit wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>I'm trying to build Xenomai 2.0.1 with MVM support.
>>>>My target board is PPC and I use patched Linux 2.6.13.4 with it + 
>>>>Xenomai 2.0.1 , cross compiled with the flags: ARCH=ppc
>>>>CROSS_COMPILE=ppc_82xx:
>>>
>>>
>>>The simulator is a _host_ based tool, not a target one, so 
>>
>>you don't 
>>
>>>want to cross-compile it for your target, it's a native compilation 
>>>from and for your build system. Make sure to read sim/README to get 
>>>the software package deps, then select the simulation build in the 
>>>config menu, and specify a valid path to a GCC-2.95.3 
>>
>>archive as specified.
>>
>>While you are at it, also make sure to read 
>>sim/doc/mvm-manual.txt to get a detailed explanation about 
>>what the simulator does and how it does it. It's an 
>>event-driven simulation engine working at source code level, 
>>not a CPU emulator.
>>
>>-- 
>>
>>Philippe.
>>
> 
> ***********************************************************************************
> This email message and any attachments thereto are intended only for use by the addressee(s) named above, and may contain legally privileged and/or confidential information. If the reader of this message is not the intended recipient, or the employee or agent responsible to deliver it to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the postmaster@domain.hid and destroy the original message.
> ***********************************************************************************
> 


-- 

Philippe.

