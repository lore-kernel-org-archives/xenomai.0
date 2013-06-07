Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51AF8424.40300@xenomai.org>
Date: Fri, 7 Jun 2013 07:52:09 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA20D142-D71E-438C-A9E3-48A2F7BFC94F@mah.priv.at>
References: <7EC33A2F-9868-4A32-A19F-9A7C70AF9EBB@mah.priv.at>
	<51AF8424.40300@xenomai.org>
Subject: Re: [Xenomai] Beaglebone kernels - automated builds WIP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 05.06.2013 um 20:32 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 06/05/2013 05:42 PM, Michael Haberler wrote:
>=20
>> just letting you know I'm working with Robert Nelson to tack on a
>> Xenomai kernel build to his automated build the thread is here:
>> http://eewiki.net/display/linuxonarm/BeagleBone+Black+Comments (cant
>> link to the actual post, search for xenomai)
>>=20
>> this flow already produces the vanilla kernels which are in the BB
>> Ubuntu and Debian images; the process is outlined here:
>> http://tinyurl.com/n5ly89t ; the xenomai kernel(s) would be tacked
>> onto this stream: http://rcn-ee.net/deb/wheezy-armhf/
>>=20
>> for now I'll use the patches Stephan had forwarded me in private, and
>> switch on next release (suggestions to do better than that welcome)
>=20
>=20
> You should probably use the ipipe-next branch in ipipe git tree.

I tried and determined the process to be a tad above my pay grade, so =
I'm back to lurking for matching commits

Just noting the beaglebone 3.8 base kernels will likely 'max out' at =
3.8.13, 3.10 work is alredy in progress

- Michael

>=20
> --=20
>                                                                Gilles.


