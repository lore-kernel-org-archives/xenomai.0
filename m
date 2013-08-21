Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <5213B966.1010604@gmail.com>
Date: Wed, 21 Aug 2013 07:53:05 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3E26082-0FC3-40D3-83B3-61D927953375@mah.priv.at>
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213B966.1010604@gmail.com>
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 20.08.2013 um 20:45 schrieb Sagar Behere <sagar.behere@gmail.com>:

> On 08/20/2013 08:39 PM, Gilles Chanteperdrix wrote:
>> On 08/20/2013 04:58 PM, Charles Steinkuehler wrote:
>>> I am currently working with LinuxCNC in a xenomai real-time =
environment
>>> on the BeagleBone:
>>>=20
>>> http://bb-lcnc.blogspot.com/p/machinekit_16.html
>>>=20
>>> Everything is working well, but the kernel is being built using an
>>> out-of-tree patch set obtained by Michael Haberler.
>>>=20
>>> I would like to switch to using a more 'official' xenomai build from
>>> git, but am unclear how to proceed.
>>>=20
>>> Which git repository/branch would be the most appropriate for use in
>>> building a xenomai kernel for the BeagleBone / AM335x SoC?
>>>=20
>>> Are there any 'gotchas' when using xenomai from git, or do the
>>> instructions and procedures for using a released version apply?
>>=20
>> You can use kernel from the I-pipe git at:
>> git://git.xenomai.org/ipipe.git branch ipipe-3.8
>>=20
>> And xenomai from the xenomai 2.6 git at:
>> git://git.xenomai.org/xenomai-2.6.git branch master
>>=20
>> The only difference in the installation procedure when using this =
kernel
>> with this version of Xenomai is that the "prepare-kernel.sh" script =
will
>> not apply the I-pipe patch to the kernel, since the kernel is already
>> patched, so the argument to the "--adeos" parameter of =
prepare-kernel.sh
>> is ignored.
>=20
> For what it's worth, I tried this procedure and documented it
>=20
> =
https://github.com/sagarbehere/beaglebone-xenomai/blob/master/beaglebone-x=
enomai-debian.md
>=20

Gilles says: use git://git.xenomai.org/ipipe.git branch ipipe-3.8
Sagar uses git://git.xenomai.org/ipipe-jki.git origin/for-upstream/3.8

"sufficiently similar" with kernel patches has a similar connotation for =
me like "mildly correct" - what's us deer in the headlight to use ;-?=20

- Michael



> I used the for-upstream/3.8 branch, but it should be similar for the =
ipipe-3.8 branch.
>=20
> If you improve upon the procedure, please let me know and I will =
update the document accordingly, or fork it and send me a pull request =
:)
>=20
> Regards,
> Sagar
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


