Message-ID: <43AAFDA7.7090106@domain.hid>
Date: Thu, 22 Dec 2005 20:25:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] in-kernel timer benchmark
References: <43A5AE20.804@domain.hid> <17322.62424.94946.83579@domain.hid>
In-Reply-To: <17322.62424.94946.83579@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig529D3BD8B3AEB2B079C81F0C"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig529D3BD8B3AEB2B079C81F0C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi all,
>  > 
>  > this is fully working proposal how to re-enable in-kernel timer latency
>  > benchmarks.
>  > 
>  > More precisely, it adds a new RTDM device "rtbenchmark<X>" (and also a
>  > new RTDM class) which can execute either a kernel task or timer
>  > periodically. The benchmark device generates all the usual latency data
>  > which can be retrieved from userspace via IOCTLs. I patched the existing
>  > latency tool to open the device and read the data from there instead of
>  > running its own latency task.
>  > 
>  > README for a quick test:
>  > 
>  >  o apply patch and rebuild everything (don't forget to re-prepare the
>  >    kernel and also call scripts/bootstrap, I added some files)
>  > 
>  >  o load xeno_timerbench (+ xeno_native, xeno_rtdm, ...)
>  > 
>  >  o run "latency -D0" to start in-kernel timer task test on device
>  >    "rtbenchmark0"
>  > 
>  >  o run "latency -D0 -t" to start in-kernel timer handler test (i.e.
>  >    without scheduling latency) on device "rtbenchmark0"
>  > 
>  > This is rather fresh code, handle with care! ;) Moreover, I would like
>  > to hear your comments if the extension of the latency tool is the right
>  > way to got or if we better split things up. The problem I see is that
>  > this patch makes latency depend on xeno_rtdm being loaded.
> 
> I agree with Philippe: having a driver for the various benchmarking
> needs is a good idea, we could imagine adding ioctls for the various
> loads, etc... But I would vote for a split between the user-space
> latency measurement tool and the display tool for kernel-space latency.
> 

What's your main concern about the current solution? The need to have
RTDM being loaded to start only the userspace test?

If this is the case, do we have some option to only fail when the user
actually requests in-kernel tests without any xeno_rtdm being loaded?
That means we would somehow have to avoid that the librtdm
initialisation fatally fails in this particular use case - hmm, or maybe
even in general...

Let's think about this: If there is no xeno_rtdm, then there is also no
driver loaded. While we can catch to first case during lib-init, the
latter will always trigger later in the program. So, having no xeno_rtdm
could also be interpreted by the lib like not having the (every)
addressed driver being loaded. I think I should prepare a patch,
shouldn't I?

> A minor issue: in the 2.4 portion of ksrc/drivers/Makefile, should not
> CONFIG_XENO_DRIVERS_benchmark be replaced with
> CONFIG_XENO_DRIVERS_TIMERBENCH ?

Yep, someone was not able to handle search&replace correctly.

> 
> It is a very interesting tool indeed (especially since I would need such
> a tool to benchmark the various solutions to improve nucleus timers
> scalability :). But it would be nice to be able to create several tasks
> or several timers without having to open one file descriptor by
> timer/task. Or if you want one file descriptor by timer/task,
> rt_tmbench_ioctl_nrt should return an error when trying to start the
> task or timer twice.
> 

Ok, I will try to reworks this, generating a ready-for-merge patch which
will also include Philippe's remarks. No promise if this is going to be
a pre-Christmas gift. ;)

Jan

--------------enig529D3BD8B3AEB2B079C81F0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDqv2nniDOoMHTA+kRAkZvAJwKmLXK0rhCucj+mOj4/8qVnROUYACeMDgY
p7sIMsbR3sR3WIFER9MTE+w=
=c5oA
-----END PGP SIGNATURE-----

--------------enig529D3BD8B3AEB2B079C81F0C--

