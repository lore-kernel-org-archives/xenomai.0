Message-ID: <476EAB72.8090908@domain.hid>
Date: Sun, 23 Dec 2007 19:39:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200712231747.35449.niklaus.giger@domain.hid>
In-Reply-To: <200712231747.35449.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> In
> http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/1/steps/mk_kernel/logs/stdio
> you find the following errors:
>> In file included from
>> /home/buildbot/slave/tqm_f/linux/include/linux/unistd.h:9, from
>> init/do_mounts.c:5:
>> /home/buildbot/slave/tqm_f/linux/include/asm/unistd.h:385: warning:
>> conflicting types for built-in function '_exit' init/do_mounts.c:54: error:
>> static declaration of 'root_device_name' follows non-static declaration
>> /home/buildbot/slave/tqm_f/linux/include/linux/fs.h:1568: error: previous
>> declaration of 'root_device_name' was here init/do_mounts.c: In function
>> 'identify_ramdisk_image':
>> init/do_mounts.c:507: warning: pointer targets in passing argument 2 of
>> 'read' differ in signedness init/do_mounts.c:542: warning: pointer targets
>> in passing argument 2 of 'read' differ in signedness init/do_mounts.c: In
>> function 'fill_inbuf':
>> init/do_mounts.c:1006: warning: pointer targets in passing argument 2 of
>> 'read' differ in signedness init/do_mounts.c: In function 'flush_window':
>> init/do_mounts.c:1024: warning: pointer targets in passing argument 2 of
>> 'write' differ in signedness make: *** [init/do_mounts.o] Error 1

You may want to switch back to ELDK-3.1.1 for compiling old 2.4/ppc
kernels. GCC 4.0 and beyond as shipped with recent ELDK releases are
less permissive regarding these issues.

-- 
Philippe.

