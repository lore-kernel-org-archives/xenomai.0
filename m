Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
From: Konstantin Schauwecker <hi@konstantin-schauwecker.de>
In-Reply-To: <539D96FB.5040300@xenomai.org>
Date: Sun, 15 Jun 2014 16:31:51 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <647F5D52-A9A5-4B6E-B608-E143A94BFBB0@konstantin-schauwecker.de>
References: <539CCDDC.7000809@konstantin-schauwecker.de>
 <539D96FB.5040300@xenomai.org>
Subject: Re: [Xenomai] Missing patch for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Yes, that is what I was referring to. The mentioned patch=20
ipipe-core-3.8.13-arm-1.patch
does not exist in the xenomai 2.6.3 release, or in earlier releases. =
There is a different patch, labelled
ipipe-core-3.8.13-arm-3.patch
which does however not match the Xilinx kernel.

I think its ok now. I manually merged the changes that couldn=92t be =
applied automatically, which was a bit of work. It does compile and I =
hope that I didn=92t make a mistake.

On 15.06.2014, at 14:52, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:

> On 06/15/2014 12:34 AM, Konstantin Schauwecker wrote:
>> Hi all,
>>=20
>> I was trying to get xenomai running on my zynq board. Unfortunately=20=

>> there seems to be a patch missing in the current 2.6.3 release.=20
>=20
> See:
> http://www.wiki.xilinx.com/Xenomai+for+Zynq
>=20
>=20
> --=20
>                                                                Gilles.


