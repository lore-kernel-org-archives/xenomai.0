Message-ID: <54F614EF.7040307@xenomai.org>
Date: Tue, 03 Mar 2015 21:09:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F58A4C.7030006@xenomai.org>	<CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>	<54F5BE3F.4010008@xenomai.org>	<54F5C020.8090102@xenomai.org>	<CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>	<54F5CD4D.8080004@xenomai.org>	<CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>	<54F5D6C6.40908@xenomai.org>	<CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>	<54F5E958.2090701@xenomai.org>	<54F5EA06.4040104@xenomai.org>	<CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>	<54F60A62.3020708@xenomai.org>	<54F60C16.5070500@xenomai.org>
 <CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>
In-Reply-To: <CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>
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

On 03/03/2015 08:50 PM, Helder Daniel wrote:
> Ok, I've done that. 
> I configure explicitly the --prefix=/usr/xenomai.
> 
> Now on the config.log we have the value of the prefix:
> 
> (...)
> #define CONFIG_XENO_PREFIX "/usr/xenomai"
> #define CONFIG_XENO_BUILD_ARGS " '--with-core=cobalt'
> '--enable-registry' '--prefix=/usr/xenomai'"
> (...)
>

A recent autoconf release changed the usual behavior (once more). The
git repo now contains a fix.

> and with 
> root@LinuxSTR:~/helloXeno# smokey --dump-conf|grep PREFIX
> CONFIG_XENO_PREFIX="/usr/xenomai"
> 
> After make install I tried to run the hello app again.
> It ran.
> 
> Now there is an entry in /var/run/xenomai/ ....
> 
> But after I made some changes an recompile an App, and then try to run
> it, I got several times:
> 
> sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
> Transport endpoint is not connected
> 
> and then again:
> 
>    3"008.480| WARNING: [main] cannot connect to registry daemon
>    3"008.891| BUG: [main] initialization failed, EAGAIN

Kill any running instance of sysregd, then try launching it as a
standalone daemon using:

# sysregd --linger --daemonize

-- 
Philippe.

