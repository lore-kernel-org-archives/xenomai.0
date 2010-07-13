From: jmf <xeno.nonono@domain.hid>
Date: Tue, 13 Jul 2010 19:10:34 +0000 (UTC)
Message-ID: <loom.20100713T211010-119@domain.hid>
References: <001b01cb1e9c$54ddbae0$fe9930a0$@com>
	<4C35CC27.1000407@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
	=?utf-8?q?fatal=3A_error_xeno=5Fnucleus_not_found?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:

> 
> Gilson Bellon wrote:
> > 
> > 
> > Dear all,
> > 
> > I have install Xenomai 2.5.3 on debian kernel .2.6.32.11 following the
> > instruction on Building Debian packages when I try to load any test I
> > have got those error messages:
> > 
> >  
> > 
> > FATAL: Module xeno_nucleus not found.
> > 
> > FATAL: Error running install command for xeno_nucleus
> > 
> >  
> > 
> > Any idea how to fix it.
> 
> What command exactly to you run which gives this result?
> 

I've got exactly the same situation!
Followed this for setup: http://www.xenomai.org/index.php/Building_Debian_packages

In /usr/share/xenomai/testsuite/ there's:
clocktest  cyclic  irqbench  klatency  latency  sigtest  switchtest  unit


$ bash xeno-test (/usr/bin/xeno-test)

part of the output:

running: ./run -- -sh -T 120 -t0 # latency 
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
sudo: /usr/bin/latency: command not found
ERROR: Module xeno_nucleus does not exist in /proc/modules

Tue Jul 13 20:53:48 CEST 2010
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
sudo: /usr/bin/latency: command not found
ERROR: Module xeno_nucleus does not exist in /proc/modules

Tue Jul 13 20:53:49 CEST 2010
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
sudo: /usr/bin/latency: command not found
ERROR: Module xeno_nucleus does not exist in /proc/modules

Tue Jul 13 20:53:50 CEST 2010
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
sudo: /usr/bin/switchtest: command not found
ERROR: Module xeno_nucleus does not exist in /proc/modules
/usr/bin/xeno-test: line 235: cd: /usr/share/xenomai/testsuite/switchbench: No
such file or directory

Tue Jul 13 20:53:50 CEST 2010
running: ./run -- -h # switchbench
/usr/bin/xeno-test: line 112: ./run: No such file or directory

Tue Jul 13 20:53:50 CEST 2010
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
sudo: /usr/bin/cyclictest: command not found
ERROR: Module xeno_nucleus does not exist in /proc/modules


Is this just a question of invalid filepaths?



