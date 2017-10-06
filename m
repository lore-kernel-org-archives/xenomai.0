References: <DB6PR0701MB24565343D7707462B972F1ACB5710@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b846b4f5-2bdc-1540-1504-6973e65d6a80@xenomai.org>
Date: Fri, 6 Oct 2017 10:27:48 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24565343D7707462B972F1ACB5710@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] --session= is not a recognized option when using
 Posix skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/06/2017 03:58 AM, Giulio Moro wrote:
> On Xenomai 3.0.5, if I compile a program with the posix skin and I try to run it with `--session=mySessionName`, it errors as it cannot find the `--session` option. This is strange, because main() is definitely getting wrapped: if I run `--help`, it does show some Xenomai command-line options:
> --main-prio=<prio>		main thread priority
> --print-buffer-size=<bytes>	size of a print relay buffer (16k)
> --print-buffer-count=<num>	number of print relay buffers (4)
> --print-buffer-syncdelay=<ms>	max delay of output synchronization (100 ms)
> --cpu-affinity=<cpu[,cpu]...>	set CPU affinity of threads
> --[no-]sanity			disable/enable sanity checks
> --verbose[=level] 		set verbosity to desired level [=1]
> --silent, --quiet 		same as --verbose=0
> --trace[=level] 		set tracing to desired level [=1]
> --version			get version information
> --dump-config			dump configuration settings
> --help				display help
> 
> When I build a program with the Alchemy skin, then `--session` works just fine, and `--help` displays a number of additional options:
> --alchemy-clock-resolution=<ns> tick value (default 1ns, tickless)
> --mem-pool-size=<size[K|M|G]> 	size of the main heap
> --no-registry			suppress object registration
> --shared-registry		enable public access to registry
> --registry-root=<path>		root path of registry
> --session=<label>[/<group>]	enable shared session
> 
> I am linking with `/usr/xenomai/bin/xeno-config --ldflags --skin=posix`, which gives the following on my system (Beaglebone Black, kernel 4.4.87)
> -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/lib/modechk.wrappers  /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt
> 

This feature is implemented by the so-called "copperplate" interface
libalchemy depends on. The POSIX API does not depend on copperplate, so
you don't have support for multi-process sessions when linking against
libcobalt exclusively. See there http://xenomai.org/start-here/.

-- 
Philippe.

