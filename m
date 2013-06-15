From: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Date: Sat, 15 Jun 2013 17:40:30 +0200
References: <201306110043.26534.leo@alaxarxa.net>
In-Reply-To: <201306110043.26534.leo@alaxarxa.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306151740.30939.leo@alaxarxa.net>
Subject: [Xenomai] Compiler and linker options for rtnet (and xenomai)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

Hi,

first of all sorry for the cross-posting but I think that there's something 
wrong in the xeno-config options in both projects. If I run:

$ xeno-config --skin=native --ldflags
-lnative -L/usr/lib -lxenomai -lpthread -lrt

$ xeno-config --skin=posix --ldflags
-Wl,@/usr/lib/posix.wrappers -L/usr/lib -lpthread_rt -lxenomai -lpthread -lrt 

$ xeno-config --skin=rtdm  --ldflags
-lrtdm -L/usr/lib -lxenomai -lpthread -lrt


So, in my application, that I _only_ use rtnet calls and also, the pthread 
calls (pthread_*,  rt_* calls)

none of the options described fits my needs. Or rtdm skin adds the native lib, 
or we create another --ldflags with rtdm, native.

What do you think?


Best regards,


Leopold


---------------------------
/usr/bin/gcc  -fPIC  -Wl,--no-undefined -lrt -lrtdm -L/usr/lib -lxenomai -
lpthread -lrt -Wl,--no-undefined -lrt -shared -Wl,-soname,libsoemrt.so.1.3.0 -o 
libsoemrt.so.1.3.0 CMakeFiles/soem_dynamic_rt.dir/soem/ethercatbase.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatcoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatconfig.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatdc.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatfoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatmain.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatprint.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatsoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o 
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/oshw.c.o 
CMakeFiles/soem_dynamic_rt.dir/osal/linux/osal.c.o 
.....

CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o: In function 
`ecx_setupnic':
nicdrv.c:(.text+0x309): undefined reference to `rt_mutex_create'
nicdrv.c:(.text+0x325): undefined reference to `rt_mutex_create'
nicdrv.c:(.text+0x341): undefined reference to `rt_mutex_create'
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o: In function 
`ecx_getindex':
nicdrv.c:(.text+0x761): undefined reference to `rt_mutex_acquire'
nicdrv.c:(.text+0x821): undefined reference to `rt_mutex_release'
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o: In function 
`ecx_outframe_red':
nicdrv.c:(.text+0x99c): undefined reference to `rt_mutex_acquire'
nicdrv.c:(.text+0xa25): undefined reference to `rt_mutex_release'
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o: In function 
`ecx_inframe':
nicdrv.c:(.text+0xbad): undefined reference to `rt_mutex_acquire'
nicdrv.c:(.text+0xd83): undefined reference to `rt_mutex_release'
collect2: error: ld returned 1 exit status




-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

