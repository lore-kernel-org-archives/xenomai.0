Message-ID: <441D49AD.4050006@domain.hid>
Date: Sun, 19 Mar 2006 13:08:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: get the simulator running...
References: <441C2574.4030901@domain.hid> <441C4279.10800@domain.hid>
	<441C4460.9030103@domain.hid> <441C5371.1080208@domain.hid>
	<441C5562.7000800@domain.hid> <441C57DA.8080708@domain.hid>
In-Reply-To: <441C57DA.8080708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Philippe Gerum wrote:
>>>
>>>
>>>>Philippe Gerum wrote:
>>>>
>>>>
>>>>>Jan Kiszka wrote:
>>>>>Fortunately, I had that demo I once produced
>>>>>
>>>>>
>>>>>
>>>>>>(last year), but that one was easier to build. I first had to drag in
>>>>>>the libs and includes of both the simulator and a regular xenomai
>>>>>>installation (I think to remember this once worked without this
>>>>>>add-ons). Then I need this additional trick in the simulators include
>>>>>>dir:
>>>>>>
>>>>>>mkdir asm
>>>>>>ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
>>>>>>
>>>>>>This maps #include <asm/xenomai/system.h> to the correct "arch".
>>>>>>Shouldn't this be created automatically during the simulator
>>>>>>installation? Or is something else broken on my box?
>>>>>>
>>>>>
>>>>>You clearly should not need this trick to compile apps against the
>>>>>simulation environment; the instrumenter (gcic) sets the proper flags.
>>>>>I'm going to rebuild one and let you know.
>>>>
>>>>Confirmed. You don't need this hand-made link.
>>>>
>>>
>>>
>>>Err, "confirmed" means that it works for you without the link and the
>>>extra paths for gcic?
>>
>>Yes (actually, it has always worked for me this way).
>>
>> The compilation of the simulator runs fine with
>>
>>>latest SVN here, but gcic still does not know any include paths.
>>>Attached is the native skin demo I tried.
>>
>>gcic explicitely sets -I<install-dir>/include/asm-sim before invoking
>>the gcc toolchain. Try adding --verbose to see what's passed.
>>
> 
> 
> kiszka@domain.hid> ../inst/bin/gcic -c nat-demo.c -o
> nat-demo_sim.o --verbose
> /usr/src/xeno-sim/inst/libexec/gcic/bin/gcc  -isystem
> /usr/src/xeno-sim/inst/libexec/gcic/i686-pc-linux-gnu/include -isystem
> /usr/src/xeno-sim/inst/libexec/gcic/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include
> -E -B/usr/src/xeno-sim/inst/libexec/gcic/lib/gcc-lib/ -D__GCIC__
> -D__XENO_SIM__ -D__XENO__
-I/usr/src/xeno-sim/inst/include/asm-sim
(1)
> -I/usr/src/xeno-sim/inst/include
(2)
  nat-demo.c > /tmp/ic0@domain.hid
> nat-demo.c:22: native/task.h: Datei oder Verzeichnis nicht gefunden
> nat-demo.c:23: native/sem.h: Datei oder Verzeichnis nicht gefunden
> gcic: failed to preprocess nat-demo.c.
> 
> I only see the simulator include paths, no link to the xenomai source
> base (here: /usr/src/xenomai) or its installation
> (/usr/src/xenomai/inst, but I haven't submitted this anyway).
>

But you don't need any link to the source base, since you should be able 
to compile simulation stuff against a self-contained install dir. gcic 
makes sure that you can reach the internal headers (1) and the 
definitions for the exported API (2), so that #include 
<some_skin/file.h> works. Normally, you should first build and install 
the regular Xenomai support in user-space, then build and install the 
simulator to the same installation directory. E.g. /usr/xenomai should 
both hold the regular and exported simulation-related files, things have 
been crafted so that there is no namespace conflict.

To sum up:

mkdir buildtree && cd buildtree
/usr/src/xenomai/configure --prefix=/usr/src/xenomai/inst
make install
mkdir sim && cd sim
/usr/src/xenomai/sim/configure --prefix=/usr/src/xenomai/inst
make install

The simulation support is seen as just another architecture Xenomai 
provides, except that it is shipped in a separate tarball 
(xenosim-*.tar) you need to dump to a regular Xenomai source tree 
(xenomai-*.tar) before building it.

-- 

Philippe.

