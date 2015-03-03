MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F5D6C6.40908@xenomai.org>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F58A4C.7030006@xenomai.org>
 <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
 <54F5BE3F.4010008@xenomai.org> <54F5C020.8090102@xenomai.org>
 <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
 <54F5CD4D.8080004@xenomai.org>
 <CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>
 <54F5D6C6.40908@xenomai.org>
Date: Tue, 3 Mar 2015 16:38:14 +0000
Message-ID: <CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 3 March 2015 at 15:44, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/03/2015 04:40 PM, Helder Daniel wrote:
> > I did not set --prefix.
> > I assumed the default value will be applied: /usr/xenomai
>
> This is the case, unless something goes wrong while configuring. Can you
> check the value reported in the config log when running the configure
> script?
>


this is the last 20 lines of config.log. Exit status is 0.
SO it appear that configuring was done properly.
but: #define CONFIG_XENO_PREFIX "NONE"
maybe that's the problem?

#define HAVE_SHM_UNLINK 1
#define CONFIG_XENO_VERSION_MAJOR 2
#define CONFIG_XENO_VERSION_MINOR 99
#define CONFIG_XENO_REVISION_LEVEL 12
#define CONFIG_XENO_UAPI_LEVEL 10
#define CONFIG_XENO_VERSION_STRING "3.0-rc3"
#define CONFIG_XENO_VERSION_NAME "Exact Zero"
#define CONFIG_XENO_PREFIX "NONE"
#define CONFIG_XENO_BUILD_ARGS " '--with-core=mercury' '--enable-registry'"
#define CONFIG_XENO_X86_VSYSCALL 1
#define CONFIG_SMP 1
#define CONFIG_MMU 1
#define CONFIG_XENO_DEFAULT_PERIOD 100000
#define CONFIG_XENO_TLSF 1
#define HAVE_RECENT_SETAFFINITY 1
#define CONFIG_XENO_TLS_MODEL "initial-exec"
#define HAVE_TLS 1
#define CONFIG_XENO_FORTIFY 1

configure: exit 0



> Also, which setting is output by the following command?
>
> $ smokey --dump-conf|grep PREFIX
>
>
root@LinuxSTR:~/helloXeno# smokey --dump-conf|grep PREFIX
CONFIG_XENO_PREFIX="NONE"

The same "NONE" again.

OK. So I configure explicitly the --prefix=/usr/xenomai.

Now on the config.log we have the value of the prefix:

(...)
#define CONFIG_XENO_PREFIX "/usr/xenomai"
#define CONFIG_XENO_BUILD_ARGS " '--with-core=cobalt' '--enable-registry'
'--prefix=/usr/xenomai'"
(...)

and with
root@LinuxSTR:~/helloXeno# smokey --dump-conf|grep PREFIX
CONFIG_XENO_PREFIX="/usr/xenomai"


After make install I tried to run the hello app again.
It ran.

Now there is an entry in /var/run/xenomai/ ....

I made some changes an recompile another App, than tried to run it, but now
I got several times:

sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
Transport endpoint is not connected

and then again:

   3"008.480| WARNING: [main] cannot connect to registry daemon
   3"008.891| BUG: [main] initialization failed, EAGAIN

I checked for the daemon and it is loaded:

$> ps aux | grep rsyslogd
root      2328  0.0  0.3  28840  1660 ?        Sl   16:03   0:00
/usr/sbin/rsyslogd -c5
