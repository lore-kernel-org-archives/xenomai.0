Date: Sun, 8 Nov 2015 12:26:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151108112627.GL1798@hermes.click-hack.org>
References: <55E7F013.10101@free.fr>
 <20151104003032.GB24848@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20151104003032.GB24848@hermes.click-hack.org>
Subject: Re: [Xenomai] intel turbo boost
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 04, 2015 at 01:30:32AM +0100, Gilles Chanteperdrix wrote:
> On Thu, Sep 03, 2015 at 09:00:36AM +0200, St=E9phane ANCELOT wrote:
> > Hi,
> >=20
> > Do you think I can use the Intel integrated turbo boost mode, without=20
> > problems.
> >=20
> > I have this nice processor :
> > http://ark.intel.com/fr/products/76308/Intel-Core-i5-4300U-Processor-3M=
-Cache-up-to-2_90-GHz
>=20
> Just experimented this, the turbo mode is a problem for applications
> which rely on a precise relation between the actual count of cpu
> cycles of a busy loop and the time. The sched_quota falls under that
> category and simply does not work reliably when turbo mode is
> enabled. Fortunately, it is possible to turn off turbo mode. For
> that, in the kernel configuration
> - enable CPU_FREQ
> - choose performance mode by default
> - enable intel pstate driver
> - echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>=20
> Other than that, turbo mode does not seem to break the latency,
> which would mean that the tsc frequency does not change with turbo
> mode.

Turbo mode also breaks the autotune feature. So, on a machine with
turbo mode, autotune should be triggered after writing to the /proc
file.

--=20
					    Gilles.
https://click-hack.org

