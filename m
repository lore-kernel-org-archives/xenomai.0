From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
Date: Wed, 13 Sep 2006 15:35:05 +0900
References: <4506E6CD.5050302@domain.hid> <4506E7AC.5090508@domain.hid>
	<17671.39329.255070.115135@domain.hid>
In-Reply-To: <17671.39329.255070.115135@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131535.05480.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > > Hi,
>  > >
>  > > I just tried to fire up xeno-test on a busybox system -
>  > > without success. Reason: missing getopts. But busybox
>  > > initial test checks for something else, namely getopt.
>  > > The attached patch should fix this it, also taking into
>  > > account that getopts in a shell built-in, not an applet.
>  >
>  > Another quirk: switchtest runs with hard-wired -T 120...
>
> Could you try the attached patch ?

Dumb question about your patch...
Shouldn't you keep the -T option in the $pass variable, to pass 
it to latency?

        T) timeout=$OPTARG
            pass="$pass -T $timeout" ;;



-- 
Romain LENGLET

