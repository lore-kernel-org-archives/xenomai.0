Message-ID: <43902168.8060205@domain.hid>
Date: Fri, 02 Dec 2005 11:26:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem running koan (UVM)
References: <200512012201.21380.niklaus.giger@domain.hid>
In-Reply-To: <200512012201.21380.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> Many thanks to Philip Gerum for his previous help!
> 
> I am no able to sucessfully link koan on my PPC405 board.
> 
> However after calling 
> $ koan
> The only output I get is
> Xenomai/uvm: real-time nucleus v2.1 (Surfing With The Alien) loaded.
> koan was linked like this:
>  /home/hcu/tools/gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu/bin/powerpc-405-linux-gnu-g++  
> -g  -o koan   /home/hcu/project/bb/3_1_x/work/xeno/koan.o   
> -u__xeno_skin_init -L/mnt/data.ng/hcu/rootfs/usr/xenomai/lib -luvm -lnucleus 
> -lpthread -lnative -lvxworks
> 
> Nothing more. I know its now time to build the GDB stub, but as it is the 
> first time that I do this it will take a moment to read the documentation.
> 
> In the mean time any help would be appreciated.
> 
> Looking at the output of xeno-config in my cross compile case I think that one 
> should create two xeno-config's one representing the target's view and one 
> for the host which did the cross-compile, e.g.creating in the build directory 
> a xeno-config-host.

Actually, xeno-config currently always presents the build system's view 
(e.g the cross-compiling side). E.g., compiling the user-space support 
for some ppc architecture can be done this way:

.../configure --build=`config.guess` --host=powerpc-unknown-linux-gnu 
CC=ppc_82xx-gcc CXX=ppc_82xx-gcc AR=ppc_82xx-ar LD=ppc_82xx-ld

Since xeno-config is informed of the build setup determined by 
configure, it will return the cross-compiler path and the proper 
compilation and link flags for building executables for the target 
already. Following the above example, CC, CXX, compilation and link 
flags will be the ones used to cross-compile an executable on the 
current build system for the target system.

  And how should we handle a canadian cross?
> 

Never considered the issue so far, quite frankly. Do you actually want 
to cross-build Xenomai systems that would in turn cross-build Xenomai apps?

-- 

Philippe.

