Message-ID: <DUB121-W2271AF72F050D09F1D570681BD0@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Wed, 10 Jun 2015 03:24:51 +0000
In-Reply-To: <20150609174138.GA17436@csclub.uwaterloo.ca>
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>,
 <201506081211.15597.paul_c@tuxcnc.org>,
 <DUB121-W1EC856DF0BB8FC70B291281BF0@phx.gbl>,
 <201506090119.30719.paul_c@tuxcnc.org>,
 <DUB403-EAS557D5FDB6E75C92D3DC47981BE0@phx.gbl>,
 <20150609164046.GA12517@hermes.click-hack.org>,
 <20150609174138.GA17436@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> From: lsorense@csclub.uwaterloo.ca
> Date: Tue, 9 Jun 2015 13:41:38 -0400
> To: gilles.chanteperdrix@xenomai.org
> CC: mobin.seven@live.com; xenomai@xenomai.org
> Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
> =

> On Tue, Jun 09, 2015 at 06:40:46PM +0200, Gilles Chanteperdrix wrote:
> > On Tue, Jun 09, 2015 at 09:01:52PM +0430, mobin Motallebizadeh wrote:
> > > None of them talk about rpi 2 which is from another architecture.
> > =

> > That is simply not true. rpi2 processor has an ARM core, just like rpi.
> =

> Yes armv6 and armv7 are not different architectures, just different
> generations, and given apparently the pheripherals of the two bcm chips,
> they should be fairly compatible, although I suppose one being quad core
> and having probably a different IRQ controller could cause some work to
> need to be done (almost certainly, although it might be a standard
> arm gic, I haven't looked at that part of the pi 2 yet, given when I got
> one, my wife immediately took it and I haven't got to touch it since.
> Apparently I should have gotten two.).
> =

> -- =

> Len Sorensen

I've made some patches [see attachments]. I've just modified  ipipe patch f=
or 3.18.12 and raspberry related patches to match RPi repo [https://github.=
com/raspberrypi/linux] which is 3.18.14 .
the resulting kernel img boots without IPIPE and XENOMAI configs successful=
ly(of course!) but with IPIPE doesn't boot.(so I haven't netconsole working)
any suggestion to make it work will be appreciated. 		 	   		  =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.18.14-arm.patch
Type: application/octet-stream
Size: 728647 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/at=
tachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.18.14-raspberry-post.patch
Type: application/octet-stream
Size: 6556 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/at=
tachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.18.14-raspberry-pre.patch
Type: application/octet-stream
Size: 552 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/at=
tachment-0002.obj>
