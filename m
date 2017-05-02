Date: Tue, 2 May 2017 11:23:29 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170502112329.1b4ef22a@md1em3qc>
In-Reply-To: <20170502112039.54c4ae04@md1em3qc>
References: <CADXNiGUww369efOQDe+BvgVyAi3FrakikgTfiPU8Ys7xDpOnnA@mail.gmail.com>
 <20170502112039.54c4ae04@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cpusets and the cpu_affinity test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>
Cc: xenomai@xenomai.org

Am Tue, 2 May 2017 11:20:39 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Mon, 1 May 2017 14:19:40 -0700
> schrieb Jackson Jones <jackson.jones@gmail.com>:
> 
> > I am having trouble getting the cpu_affinity test to run. The check
> > for CPU restriction always fails. I have tried to remedy this by
> > setting the bootargs.
> > 
> > 1.) I am running an NXP i.MX6 QUAD/DUAL VAR-SOM-MX6 based board
> > (Variscite var_som_mx6). The kernel is an 4.1.15 NXT/Variscite
> > kernel (with the BSP patched in). I patched in the
> > ipipe-core-4.1.15-arm-8.patch.
> > 
> > 2.) I am running Xenomai 3.0.3
> > 
> > 3.) The Linux distro is Debian Jessie 8.7 (provided by Variscite and
> > Linaro)
> > 
> > 4.) The gcc version is 4.9.2, the libc versioni is 2.19.
> > 
> > 5.) My configure options are:
> > ./configure \
> >     --with-core=cobalt \
> >     --enable-smp \
> >     --enable-registry \
> >     --enable-pshared \
> >     --enable-dlopen-libs \
> >     --enable-sanity \
> >     --disable-tls \
> >     --enable-valgrind-client \
> >     --disable-assert
> > 
> > 6.) Here are the uboot parameters (bootargs):
> > setenv videoargs 'if hdmidet; then setenv bootargs ${bootargs}
> > video=mxcfb0:dev=hdmi,1024x768M@60,if=RGB24; else setenv bootargs
> > ${bootargs} video=mxcfb0:dev=ldb,bpp=32; fi; setenv bootargs
> > xenomai.supported_cpus=0x0000000f isolcpus=1 ${bootargs}
> > vmalloc=400M fbmem=32M fbcon=32M gpumem=32M
> > galcore.contiguousSize=201326592 galcore.contiguousBase=0x00000000
> > video=mxcfb1:off video=mxcfb2:off video=mxcfb3:off;'
> > 
> > 7.) I have attached the kernel configuration.
> > 
> > I noticed that if I leave any cpus out of the supported cpus, the
> > kernel will hang (e.g. if I put a 7 instead of F).  
> 
> If you want to use all cores in Xenomai, that parameter is not
> required and probably should not be set. However the kernel should
> not hang when you do not include all, but that is probably another
> issue.
> 
> Why did you set "isolcpus=1"?
> 
> And please tell us how exactly the test fails and what the output is.
> I guess you are talking about smokey cpu_affinity.
> 
> testsuite/smokey --run=cpu_affinity --verbose=100

And the Mail subject talks about "cpusets", are you using cgroups or
where does that term come from?

> regards,
> Henning
> 
> > I have read through all the documentation and have not found an
> > answer.
> > 
> > Thanks in advance for any help.
> > 
> > 
> > Sincerely,
> > 
> > Jackson Jones
> > 
> > Stellartech Research Corporation
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: config
> > Type: application/octet-stream
> > Size: 111084 bytes
> > Desc: not available
> > URL:
> > <http://xenomai.org/pipermail/xenomai/attachments/20170501/1e5c6f2d/attachment.obj>
> > _______________________________________________ Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai  
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


