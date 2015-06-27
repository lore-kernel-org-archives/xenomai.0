Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <20150627131446.GF9756@hermes.click-hack.org>
Date: Sat, 27 Jun 2015 15:25:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA2E5E80-204F-48D2-8FAF-1917CD257D90@gmail.com>
References: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
 <558EA07F.2060204@xenomai.org> <20150627131446.GF9756@hermes.click-hack.org>
Subject: Re: [Xenomai] Q on xenomai2/3 userland coexistence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>


> Am 27.06.2015 um 15:14 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:
>=20
> On Sat, Jun 27, 2015 at 03:09:19PM +0200, Philippe Gerum wrote:
>> On 06/27/2015 02:22 PM, Michael Haberler wrote:
>>> ATM we're sorting through the machinekit xenomai3 transition on =
debian
>>>=20
>>> I assume that users will continue to run xenomai2 kernels for a long =
time, so we work towards separate (but hopefully coexisting-in-peace) =
packages for Xenomai2 and Xenomai3 (startup is driven by kernel =
autodetection, so booting a different kernel chooses the right runtime)
>>>=20
>>> The libxenomai-dev and libxenomai1 in debian are all xenomai2 atm, =
but I assume Xenomai3 equivalents will appear eventually
>>>=20
>>> I hope these will be able to co-reside on the same host?
>>>=20
>>> Ideally suggesting the Xenomai3 packages would be separate, be named =
differently, and not supersede any installed Xenomai2 packages?
>>>=20
>>>=20
>>> (or am I blundering and I can run applications linked against the =
Xenomai3 libraries on a Xenomai2 kernel? my tests so far indicate - not)
>>>=20
>>=20
>> Not possible. Xenomai 2 uses kernel services provided by the I-pipe
>> compiled for legacy operation mode. Xenomai 3 wants this mode =
disabled.
>=20
> The two kernels have different ABIs anyway. I think what Michael
> wants to do is to also have the two patched kernels installed and
> reboot (or kexec?) to switch from one to the other.

yes, it's a potential support issue, mostly for the folk installing from =
packages (I'm less concerned about those which install from source, and =
we can use configure.ac tests if something is obviously afoul)

what I see unfolding is:

- folks with a xeno2 package-based install want to try a xeno3 kernel, =
run apt-get upgrade etc, pull in kernel, and updated libraries
- something is not to their liking, and they step back to boot a xeno2 =
kernel - maybe just by changing the bootloader entry or by removing the =
xeno3 kernel
- if the first step has wiped the xeno2 userland support by upgrading, =
we have a support issue
- if xeno2 and xeno3 userland co-reside peacefully and separate, no =
issue

doing everything through the xeno wrapper looks doable, but I guess =
backporting this wrapper to xeno2 will be unpopular

what about completely separating the names, like /usr/xenomai3 ? =
sledgehammer approach (that is, in the best tradition of yankee =
engineering ;), but certainly effective.


- Michael




>=20
> --=20
> 					    Gilles.
> https://click-hack.org


