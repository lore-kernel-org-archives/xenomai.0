From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
Date: Tue, 12 Sep 2006 21:05:57 +0200
References: <4506E6CD.5050302@domain.hid>
In-Reply-To: <4506E6CD.5050302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609122105.57411.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Am Dienstag, 12. September 2006 18:56 schrieb Jan Kiszka:
> Hi,
>
> I just tried to fire up xeno-test on a busybox system - without success.
> Reason: missing getopts. But busybox initial test checks for something
> else, namely getopt. The attached patch should fix this it, also taking
> into account that getopts in a shell built-in, not an applet.
>
> Jan
I agree that getopt is not used anywhere in xeno-test. Therefore we may skip 
the test.

But why do you want to eliminate the test whether getopts is really a built-in 
of the busybox? My intention was to simplify chasing the bug if someobody 
uses a busybox without a built-in getopts, e.g. Busybox option 
CONFIG_ASH_GETOPTS is not set.

Best regards

-- 
Niklaus Giger

