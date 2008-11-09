Message-ID: <4916BC63.20304@domain.hid>
Date: Sun, 09 Nov 2008 11:33:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>
In-Reply-To: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SegFault on all demo apps!!
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Cristian Axenie wrote:
> Hello!
> I've installed Xenomai for a 2.6.24 linux kernel, for a PPC development
> board.

- Which board?
- Which ELDK version?
- Did you patch against DENX-v2.6.24-stable?

 My intentions are to use a NI DAQ card for a distributed control
> application using RTAI skin + Comedi. So I experience some trouble after
> installing Xenomai and even running specific latency , switchtest...etc
> or even cmd_read, cmd_write apps because I get a Segmentation Fault each
> time.
> So during my kernel booting i get :
> 
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> I-pipe: Domain IShield registered.

Get rid of CONFIG_XENO_OPT_ISHIELD. Your configuration doesn't need that.

> Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> Xenomai: starting RTAI emulator.
> 
> So  I think it's ok, but I,ve copied my generated xenomai dir (including
> : bin include lib sbin share) and dev directory in my filesystem located
> on a SATA hard-drive conected to my board. Am I missing something in the
> installation steps ? Here are the main staps used for the installation :
> 
> /home/haustiq/development/xenomai-comedi-trunk/scripts/prepare-kernel.sh
> --arch=powerpc \
>  
> --adeos=/home/haustiq/development/xenomai-comedi-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch
> \
>   --linux=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24
> 
> cd /home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24
> 
> mkdir staging_dir build_root
> 
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root menuconfig
>  
>   make ARCH=powerpc CROSS_COMPILE=ppc_6xx- O=build_root uImage modules
>  
>   cd build_root
>  
>   /home/haustiq/development/xenomai-comedi-trunk/configure
> --prefix=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir 
> --build=i686-pc-linux-gnu --host=ppc-unknown-linux-gnu CC=ppc_6xx-gcc
> CXX=ppc_6xx-g++ LD=ppc_6xx-ld
>  
>   make ARCH=powerpc CROSS_COMPILE=ppc_6xx-
> DESTDIR=/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24/staging_dir
> install
> 

The prefix is wrong:

--prefix should define the path to the Xenomai install dir as seen by the
_target_ board when running.

DESTDIR should define the path to the Xenomai install dir as seen by the build
_host_when installing.

> In staging_dir I have my genrated xenomai and dev folders copied in my FS .
> 
> So when runnig for example strace ./latency on my target I get :
> 
> /usr/xenomai/bin # strace ./latency
> execve("./latency", ["./latency"], [/* 8 vars */]) = 0
> brk(0)                                  = 0x10045000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or

[...]

> directory)

> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++
> Process 910 detached
>

- Why don't you use GDB to know precisely where the application dies?
- Try downgrading to Xenomai 2.4.5 for running the latency tests. You don't need
Comedi to validate your board setup anyway. If that does not work either, then
this is likely a setup issue (e.g. pthread/tls support).

> 
> WHAT AM I MISSING, I SEE PLENTY OF No such file or directory !! WHERE
> SHOULD I FOUND THOSE MISSING FILES, SIMLINKS....

- "No such file or directory" errors are not the problem.
- Do not shout, we recently learnt how to decipher lowercases.

-- 
Philippe.

