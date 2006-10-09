Subject: Re: [Xenomai-core] Compiler and linker flags
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17705.54777.682760.198157@domain.hid>
References: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
	<4528FBE5.7020803@domain.hid> <17705.6276.735921.764908@domain.hid>
	<45293C9B.1030608@domain.hid> <1160335881.4963.19.camel@domain.hid>
	<452956C3.8010109@domain.hid> <1160340280.4963.28.camel@domain.hid>
	<17705.54777.682760.198157@domain.hid>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 08:57:17 +0200
Message-Id: <1160377038.4998.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2006-10-09 at 06:54 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Sun, 2006-10-08 at 21:51 +0200, Jan Kiszka wrote:
>  > > Philippe Gerum wrote:
>  > > >>
>  > > >>  o -D__XENO__
>  > > > 
>  > > > POSIX code may be compiled either against the regular Linux support, or
>  > > > against the Xenomai one; this define provides a standard signature to
>  > > > test for in order to detect the second case, if need be.
>  > > 
>  > > Ok. Should we restrict it to --posix-cflags then?
>  > > 
>  > 
>  > No objection, but in such a case, we'd be better off moving the define
>  > somewhere in include/posix/*.h. Gilles?
> 
> Since there are several files in include/posix and users are not
> supposed to include them all, it seems easier to force the flag in
> --posix-cflags.
> 

Ack. I was thinking of moving this define to a base header, but if we
really don't have any there, then let's keep it the way it is.

-- 
Philippe.



