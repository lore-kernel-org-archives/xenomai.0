Date: Tue, 14 Jul 2015 05:54:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150714035433.GC1971@hermes.click-hack.org>
References: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging
	request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gowtham Garimella <ggarime1@jhu.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jul 14, 2015 at 12:57:10AM +0000, Gowtham Garimella wrote:
>  =20
> Hi Everyone,
>=20
> I have installed xenomai 2.6.4 on ubuntu 14.04 with the latest
> kernel=A0 3.14.17.

3.14.17 is not the latest kernel. As explained in the documentation,
you can use later patches in the I-pipe download area for the same
kernel version number. So, the "latest kernel" would be
https://xenomai.org//downloads/ipipe/v3.x/x86/ipipe-core-3.14.44-x86-9.patch

Unfortunately that patch has an issue on x86, so I would recommend
using that one instead:
https://xenomai.org//downloads/ipipe/v3.x/x86/older/ipipe-core-3.14.39-x86-=
9.patch


>  My hardware is a NUC i5 computer (NUC5i5MYHE
> model) with x86 architecture 64 bit computer. I am able=A0 to
> successfully install xenomai and am able to reboot the system=A0
> normally. I checked that Xenomai is enabled correctly=A0 as seen in
> /var/log/syslog
>=20
> The issue I am facing is that, when I run xeno latency it hangs
> and does=A0 not print any latencies. I have seen some posts before
> on similar=A0 issues but they did not help much.

Well, I doubt someone with similar issues did not get an answer.
Could you point us to the posts you are talking about?


>  I enabled ipipe
> tracing and am=A0 attaching the trace. The main part of the log
> files=A0 that=A0 I think is the issue is these lines:
>=20
>=20
> [=A0 643.881016] BUG: unable to handle kernel paging request at 00007fff0=
d573ea0
> [=A0 643.881049] IP: [<ffffffff8163c181>] rthal_strncpy_from_user+0x11/0x=
30
> [=A0 643.881077] PGD 3f78f8067 PUD 3e5e37067 PMD 3ff7b5067 PTE 80000003cf=
16c067
> [=A0 643.881108] Oops: 0001 [#1] SMP
> [=A0 643.881124] Modules linked in: x86_pkg_temp_thermal i915
> drm_kms_helper

Actually, you do not really need the I-pipe tracer. The kernel logs
would be sufficient. And please, post the full logs, from the boot,
up to the bug itself.

--=20
					    Gilles.
https://click-hack.org

