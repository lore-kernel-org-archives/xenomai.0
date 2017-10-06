From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Fri, 6 Oct 2017 01:58:41 +0000
Message-ID: <DB6PR0701MB24565343D7707462B972F1ACB5710@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] --session= is not a recognized option when using Posix
	skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Xenomai 3.0.5, if I compile a program with the posix skin and I try to r=
un it with `--session=3DmySessionName`, it errors as it cannot find the `--=
session` option. This is strange, because main() is definitely getting wrap=
ped: if I run `--help`, it does show some Xenomai command-line options:
--main-prio=3D<prio>		main thread priority
--print-buffer-size=3D<bytes>	size of a print relay buffer (16k)
--print-buffer-count=3D<num>	number of print relay buffers (4)
--print-buffer-syncdelay=3D<ms>	max delay of output synchronization (100 ms=
)
--cpu-affinity=3D<cpu[,cpu]...>	set CPU affinity of threads
--[no-]sanity			disable/enable sanity checks
--verbose[=3Dlevel] 		set verbosity to desired level [=3D1]
--silent, --quiet 		same as --verbose=3D0
--trace[=3Dlevel] 		set tracing to desired level [=3D1]
--version			get version information
--dump-config			dump configuration settings
--help				display help

When I build a program with the Alchemy skin, then `--session` works just f=
ine, and `--help` displays a number of additional options:
--alchemy-clock-resolution=3D<ns> tick value (default 1ns, tickless)
--mem-pool-size=3D<size[K|M|G]> 	size of the main heap
--no-registry			suppress object registration
--shared-registry		enable public access to registry
--registry-root=3D<path>		root path of registry
--session=3D<label>[/<group>]	enable shared session

I am linking with `/usr/xenomai/bin/xeno-config --ldflags --skin=3Dposix`, =
which gives the following on my system (Beaglebone Black, kernel 4.4.87)
-Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/=
lib/modechk.wrappers  /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmai=
n -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcob=
alt -lmodechk -lpthread -lrt

Thanks,
Giulio=

