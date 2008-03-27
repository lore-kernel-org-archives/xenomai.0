Message-ID: <47EAE6FC.5050002@domain.hid>
Date: Thu, 27 Mar 2008 01:14:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080326135529.GA11244@domain.hid>
	<47EA5867.8040008@domain.hid>
In-Reply-To: <47EA5867.8040008@domain.hid>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [SOLO] Build fail due to lack file(s)
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> jserv@domain.hid wrote:
>> Hello list,
>>
>> After git pull, I found that pSOS(*) emulation interface on top of the
>> Xenomai/SOLO framework was checked in.  However, it fails to build due
>> to lack file(s) in repository.  Here are the compilation results:
>>
>> <%
>> make[1]: Entering directory `/tmp/xenomai-solo/psos'
>> /bin/sh ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I../include  -g -O0 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing -D__SOLO_DEBUG__ -D__XENO__ -D__SOLO__ -Wstrict-prototypes -include xeno_config.h -I../include    -MT libpsos_la-init.lo -MD -MP -MF .deps/libpsos_la-init.Tpo -c -o libpsos_la-init.lo `test -f 'init.c' || echo './'`init.c
>>  gcc -DHAVE_CONFIG_H -I. -I../include -g -O0 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing -D__SOLO_DEBUG__ -D__XENO__ -D__SOLO__ -Wstrict-prototypes -include xeno_config.h -I../include -MT libpsos_la-init.lo -MD -MP -MF .deps/libpsos_la-init.Tpo -c init.c -o libpsos_la-init.o
>> init.c:30:19: error: queue.h: No such file or directory
>> init.c: In function 'PSOS_INIT':
>> init.c:46: error: 'psos_queue_table' undeclared (first use in this function)
>> init.c:46: error: (Each undeclared identifier is reported only once
>> init.c:46: error: for each function it appears in.)
>> make[1]: *** [libpsos_la-init.lo] Error 1
>>  %>
>>
> 
> I will commit them later today, and they should appear in the public GIT tree
> tonight (CET).
> 

The missing files have been committed, so they should be mirrored to the public
GIT tree in a few hours from now.

BIG FAT WARNING: The pSOS emulator is in its early development stage, really,
badly early. It compiles, but is incomplete, and can't reasonably work properly
yet. If you just want to play with SOLO, you should stick to the VxWorks
emulator, which is the only one that has been officially announced so far. Of
course, if you want to help debugging the new pSOS emulator, you are welcome as
well (but it's still a bit early, though).

-- 
Philippe.

