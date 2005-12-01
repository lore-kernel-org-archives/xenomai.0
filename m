Message-ID: <438ECF31.9060705@domain.hid>
Date: Thu, 01 Dec 2005 11:23:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
References: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFC9B@ILEX5.IL.NDS.COM>
	<438ECDA7.6000009@domain.hid>
In-Reply-To: <438ECDA7.6000009@domain.hid>
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
Cc: xenomai@xenomai.org, "Ashri, Sarit" <Sashri@domain.hid>

Philippe Gerum wrote:
> Ashri, Sarit wrote:
> 
>> Hi,
>>
>> I'm trying to build Xenomai 2.0.1 with MVM support.
>> My target board is PPC and I use patched Linux 2.6.13.4 with it +  
>> Xenomai 2.0.1 , cross compiled with the flags: ARCH=ppc
>> CROSS_COMPILE=ppc_82xx:
> 
> 
> The simulator is a _host_ based tool, not a target one, so you don't
> want to cross-compile it for your target, it's a native compilation from 
> and for your build system. Make sure to read sim/README to get the 
> software package deps, then select the simulation build in the config 
> menu, and specify a valid path to a GCC-2.95.3 archive as specified.

While you are at it, also make sure to read sim/doc/mvm-manual.txt to 
get a detailed explanation about what the simulator does and how it does 
it. It's an event-driven simulation engine working at source code level, 
not a CPU emulator.

-- 

Philippe.

