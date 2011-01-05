Message-ID: <4D24AB38.3020806@domain.hid>
Date: Wed, 05 Jan 2011 18:32:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <12d572a328f.gprizzi@domain.hid>
In-Reply-To: <12d572a328f.gprizzi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error in executing xenomai tests
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: xenomai@xenomai.org

gprizzi@domain.hid wrote:
>  Dear sirs,
> 
>  I have a fresh install of xenomai 2.5.5.2.
> 
> I found the directory 
> 
> /usr/share/xenomai/testsuite/
> 
> in which there are subdirectory with different test.
> 
> I tried to execute them bat I got a lot of errors that you can see here below.
> 
> The most frequent error is the following:
> 
> FATAL: Module xeno_nucleus not found.

This one is spurious: if you set CONFIG_XENO_OPT_NUCLEUS to y, then it
is normal that xeno_nucleus is not compiled as a module. If you choose
xenomai nucleus to be compiled as a module, but are running on a busybox
based system, the xeno-load script does not work. Since you do not tell
us your kernel configuration, or any other detail, for that matter, we
have to guess here. But it is better to avoid using run. Just run the
binaries you are interested in directly, load any module needed when you
are told with modprobe. xeno-load and "run" scripts are going to
disappear from the 2.6 branch

> 
> Have I made errors in xenomai installation process?

The errors you have only come from the fact that the default kernel
configuration do not enable all the options which allow running all the
tests.

So, no, you have made no error. You simply did not enable some options
needed for the tests to run correctly. Fortunately, error message tell
you what to do.

> 
> Have I a working xenomai system?
> 
> Moreover where can I found documentation that can help me to understand if the performances of the execute tests
> are god?

No, here, simply understanding what the test does (manpages help), and
the result it gives will help you. A performance is good if it is
sufficient for what your application needs. Not knowing what your
application needs, it is hard for us to tell us whether the performances
you get are sufficient.

> 
> During installation I used the following procedure that was explained on the page 
> http://www.xenomai.org.php/Building_Debian_packages that now in no more available (why?)

Because we do not own the xenomai.org.php domain, we only own xenomai.org.

> irqloop: failed to open benchmark device: No such file or directory
> (modprobe xeno_irqbench?)

enable irqbench in kernel configuration

> open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or directory
> modprobe klat_mod or try the -P option?

enable klatency in kernel configuratino

> Xenomai: SIGTEST skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_sigtest?)

enable sigtest in kernel configuration

> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory

Increase size of the kernel tasks stacks pool.


-- 
					    Gilles.

