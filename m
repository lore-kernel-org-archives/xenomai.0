Message-ID: <489CB7DB.30102@domain.hid>
Date: Fri, 08 Aug 2008 23:17:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <489C96FA.7050400@domain.hid> <489CA27B.1040201@domain.hid>
	<489CB368.8030108@domain.hid>
In-Reply-To: <489CB368.8030108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel user-space problem
	running	testsuite
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
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> Philippe Gerum wrote:
>> Michael Galea wrote:
>>> I'm just starting with xenomai and am having troubles getting xenomai 
>>> user space to talk to my kernel.
>>>
>>> I build the kernel and user-space xenomai code and try to run `latency` 
>>> from the test suite and get
>>> mpc8360mds:# /usr/local/xenomai/bin/latency
>>> Xenomai: incompatible feature set
>>> (required="fastsem", present="nofastsem", missing="fastsem").
>>>
>>>
>>> I have built xenomai from svn into my 2.6.26 powerpc kernel and it looks 
>>>   good on the next boot, i.e. `dmesg |grep xeno -i` returns:
>>> I-pipe: Domain Xenomai registered.
>>> Xenomai: hal/powerpc started.
>>> Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
>>> Xenomai: starting native API services.
>>> Xenomai: starting POSIX services.
>>> Xenomai: starting RTDM services.
>>>
>>> The user-space builds and installs over NFS just fine:
>>>
>>> ./configure --host=ppc-unknown-linux-gnu --prefix=/usr/local/xenomai \
>>>    CC=ppc_6xx-gcc CXX=ppc_6xx-g++ LD=ppc_6xx-ld
>>> make
>>> make DESTDIR=/opt/ppcrootmds/ install
>>>
>>>
>>> I can't see any fastsem options in the kernel.  Does anyone have any 
>>> advice?
>> The trunk/ contains bleeding edge code. The powerpc port there is currently in a
>> state of flux, due to the introduction of fast user-space mutexes in the Xenomai
>> nucleus.
>>
>> Please use the latest stable version such as 2.4.4, or our maintenance branch
>> instead: http://svn.gna.org/viewcvs/xenomai/branches/v2.4.x/.
>>
> Hi Phillipe,
> 	In trying to build xenomai 2.4.4 into the 2.6.26 kernel, using the 
> default kconfig, I get
> 
>    CC      kernel/xenomai/arch/generic/hal.o
>    LD      kernel/xenomai/arch/generic/xeno_hal.o
>    LD      kernel/xenomai/arch/generic/built-in.o
>    LD      kernel/xenomai/arch/built-in.o
>    CC      kernel/xenomai/nucleus/heap.o
> kernel/xenomai/nucleus/heap.c: In function 'xnheap_mount':
> kernel/xenomai/nucleus/heap.c:1140: error: implicit declaration of 
> function 'class_device_create'
> kernel/xenomai/nucleus/heap.c:1142: warning: assignment makes pointer 
> from integer without a cast
> kernel/xenomai/nucleus/heap.c: In function 'xnheap_umount':
> kernel/xenomai/nucleus/heap.c:1160: error: implicit declaration of 
> function 'class_device_destroy'
> make[3]: *** [kernel/xenomai/nucleus/heap.o] Error 1
> make[2]: *** [kernel/xenomai/nucleus] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
>

Yeah, sorry, my mistake. You need to pull from the maintenance branch to run
2.6.26 kernels on v2.4.x, you can't use 2.4.4 vanilla.

> You mentioned the maintenance branch, where can I find that?
> 

svn co svn://svn.gna.org/svn/xenomai/branches/v2.4.x

Aside of this, Gilles's patch will successfully enable the fastsem support in
your kernel if you still want to live on the bleeding edge using the trunk. I
have just checked on an mpc836x, and the testsuite runs properly there as well
(cyclictest is the one that uses the fastsem stuff for now). Still no guarantee
though, I have only recently adapted Gilles's fastsem support to powerpc, and
this did not went through much testing yet.

-- 
Philippe.

