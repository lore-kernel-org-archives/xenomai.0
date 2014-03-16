Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <53205346.6020605@xenomai.org>
Date: Sun, 16 Mar 2014 17:37:26 -0400
Message-Id: <09644C14-EC74-4FA5-AA27-92DDEECF57C5@gatech.edu>
References: <3F7844F7-FC18-44C3-A946-528C28CB81AC@gatech.edu>
 <53205346.6020605@xenomai.org>
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Build Xenomai Lib native on the Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles -

Thanks for this information - this is great and provides a good =
comparison. I am getting about 40us on my beaglebone black running =
debian+xenomai 2.6.3. Disabling the L2 cache write-allocate bit to get =
10us would be phenomenal.=20

Question - what is the option to deselect in the =93make menuconfig=94 =
to disable the L2 cache write-allocate bit?

I=92ll post any results I have for comparison, if it helps.

--
Yogi A. Patel
(c): (828) 291-6715
(url): www.yapatel.org | @yapatel525

On Mar 12, 2014, at 8:29 AM, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:

> On 03/12/2014 12:59 AM, Yogi A. Patel wrote:
>> Flavio -
>>=20
>> Would you mind sharing what latencies you are seeing on your =
Beaglebone black with xenomai?
>=20
> Some results which might be interesting, the results for the IGEPv2
> board, using an omap3630 processor, close to the beaglebone black
> processor, are in the 40-45us range, if the kernel is compiled with =
the
> right options, that is:
> - kernel built using thumb2 and optimized for size
> - preemption set to CONFIG_PREEMPT_NONE
> - CONFIG_SMP disabled
> - stack unwinding enabled
> - xenomai unlocked switch disabled
> - all xenomai/ipipe debugs off, except maybe "watchdog support" and
> "detect mutexes held in relaxed sections", as they should not incur an
> increase in latency.
>=20
> Since the I-pipe core series (so since linux 3.2), I have started
> recording the results I get on the test platforms I have, see, to show
> the improvements over time (most improvements are due to =
configurations
> changes):
>=20
> http://xenomai.org/~gch/core-3.2-latencies/
> http://xenomai.org/~gch/core-3.4-latencies/
> http://xenomai.org/~gch/core-3.5-latencies/
> http://xenomai.org/~gch/core-3.8-latencies/
> http://xenomai.org/~gch/core-3.10-latencies/
>=20
> Note that we recently discovered that disabling the L2 cache
> "write-allocate" bit on imx6 and omap4, so probably on any multi-core
> cortex a9, improved latencies considerably, and that moving the
> spinlocks code out-of-line did too, see:
> http://sisyphus.hd.free.fr/~gilles/panda-test/inline-spinlocks.png
>=20
> The change of the L2 write-allocate bit will be in the next Xenomai =
2.x
> release, whereas the change of spinlock code will only appear in =
xenomai
> 3.0.
>=20
> Anyway, I would like to also try disabling the L2 cache write-allocate
> on omap3, but IGEPv2 is running in secure mode, so I can not change =
this
> configuration, I would probably need an "smc" call, but I have not =
found
> a documentation for these calls, so if anyone knows where to find this
> info, I am interested.
>=20
> Regards.
>=20
>=20
> --=20
>                                                                Gilles.

