Message-ID: <54F6C50F.5040301@xenomai.org>
Date: Wed, 04 Mar 2015 09:40:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F58A4C.7030006@xenomai.org>	<CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>	<54F5BE3F.4010008@xenomai.org>	<54F5C020.8090102@xenomai.org>	<CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>	<54F5CD4D.8080004@xenomai.org>	<CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>	<54F5D6C6.40908@xenomai.org>	<CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>	<54F5E958.2090701@xenomai.org>	<54F5EA06.4040104@xenomai.org>	<CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>	<54F60A62.3020708@xenomai.org>	<54F60C16.5070500@xenomai.org>	<CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>	<54F614EF.7040307@xenomai.org>
 <CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>
In-Reply-To: <CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/03/2015 09:38 PM, Helder Daniel wrote:
> Done that:
> 
> $> sudo pkill sysregd
> 
> $> sudo ps aux | grep sysregd
> user      4045  0.0  0.1   3796   800 pts/1    S+   20:30   0:00 grep
> sysregd
> 
> all instances killed.
> 
> Now launch:
> 
> $> sudo /usr/xenomai/sbin/sysregd --linger --daemonize
> 
> $> sudo ps aux | grep sysregd
> root      4022  0.0  0.3   3776  1888 ?        Ssl  20:28   0:00
> /usr/xenomai/sbin/sysregd --linger --daemonize
> user      4045  0.0  0.1   3796   800 pts/1    S+   20:30   0:00 grep
> sysregd
> 
> Daemon running.
> 
> Now tried to run app and receive the same error:
> 
> ./hello
> sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
> Transport endpoint is not connected
> sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
> Transport endpoint is not connected
> sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
> Transport endpoint is not connected
>    3"006.383| WARNING: [main] cannot connect to registry daemon
>    3"006.574| BUG: [main] initialization failed, EAGAIN
> 

The only plausible scenario for this issue is that sysregd got killed
(e.g. SIGKILL or SIGHUP, not SIGTERM which currently leads to a graceful
exit) while it was running, which caused the FUSE-based anon/system
mountpoint to be left over.

To fix this, you can unmount the system mount point manually before
starting sysregd again:

# fusermount -u /var/run/xenomai/anon/system

We can probably do better with graceful exit and cleaning up left overs.
I'll look at this.

-- 
Philippe.

