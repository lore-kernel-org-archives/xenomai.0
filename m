Subject: Re: [Xenomai-core] Buildbot: sim fails
	../../ksrc/nucleus/pod.c:1440: label `unlock_and_exit' used but not
	defined
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702181342.38077.niklaus.giger@domain.hid>
References: <200702181342.38077.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 15:42:20 +0100
Message-Id: <1171809740.13484.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-02-18 at 13:42 +0100, Niklaus Giger wrote:
> Hi
> 
> Since February 12 building the sim fails with
> if ../gcic/gcic -DHAVE_CONFIG_H -I. -I. -I../include  -D__IN_XENO__ --gcic-backend=/var/buildbot/bin/sim/libexec/gcic --kernel-code  -I./../include -I../../include   -g -MT 
> pod.o -MD -MP -MF ".deps/pod.Tpo" -c -o pod.o ../../ksrc/nucleus/pod.c; \
>         then mv -f ".deps/pod.Tpo" ".deps/pod.Po"; else rm -f ".deps/pod.Tpo"; 
> exit 1; fi
> ../../ksrc/nucleus/pod.c:59: warning: parameter names (without types) in 
> function declaration
> ../../ksrc/nucleus/pod.c:59: warning: data definition has no type or storage 
> class
> ../../ksrc/nucleus/pod.c: In function `xnpod_suspend_thread':
> ../../ksrc/nucleus/pod.c:1440: label `unlock_and_exit' used but not defined
> make[1]: *** [pod.o] Fehler 1
> make[1]: Leaving directory `/var/buildbot/slave/sim_f/build/sim/nucleus'
> 
> For details look at:
> http://ngiger.dyndns.org/buildbot-full/sim_f/builds/98/step-make_sim/1

Fixed, thanks.

-- 
Philippe.



