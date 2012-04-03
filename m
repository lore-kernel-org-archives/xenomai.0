Message-ID: <4F7AADFD.3060506@domain.hid>
Date: Tue, 03 Apr 2012 09:59:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
	<4F7A133E.7000505@domain.hid> <4F7A2039.2040409@domain.hid>
	<4F7A211F.1080809@domain.hid> <4F7AACC1.6080500@domain.hid>
In-Reply-To: <4F7AACC1.6080500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30847EF728EA29F61AA5C8B2"
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30847EF728EA29F61AA5C8B2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-04-03 09:54, Gilles Chanteperdrix wrote:
> On 04/02/2012 11:58 PM, Jan Kiszka wrote:
>> On 2012-04-02 23:55, Gilles Chanteperdrix wrote:
>>> On 04/02/2012 10:59 PM, Jan Kiszka wrote:
>>>> On 2012-04-02 22:56, Jan Kiszka wrote:
>>>>>> No luck, I am using qemu 0.12.5, there is no -global option docume=
nted,
>>>>>
>>>>> Err, that's prehistoric. Use stable 1.0.x at least to receive prope=
r
>>>>> HPET support.
>>>>
>>>> Oh, and there is one further pitfall: You need to provide
>>>> -no-kvm-irqchip to use the HPET with MSI support because qemu-kvm do=
es
>>>> not forward those MSIs to the kernel irqchip model. I'm sitting on
>>>> patches...
>>>
>>> Yes, I needed that. It works now, except that I could not find how to=

>>> use an NFS root filesystem. But with an ext3 file-backed filesystem, =
I
>>> could get that:
>>
>> If your NFS server runs on the host and you use userspace networking
>> (default without additional parameters), the guest should be able to
>> reach the server under 10.0.2.2 and use an IP like 10.0.2.15 (or dhcp)=
=2E
>> However, I recently failed to get this working as well but didn't dig
>> deeper.
>=20
> Well, with -net user, I do not get any network interface on the
> simulated kernel. Maybe there a special network driver to enable in the=

> kernel? The documentation does not say which network card is simulated,=

> and I do not see any with lspci.

qemu-kvm emulates a rtl8139 by default. But, by just specifying -net
user, you disable any network adapter. Just leave it out, -net user -net
nic,model=3Drtl8139 is default.

>=20
> Something else, is it possible to run kvm using SCHED_FIFO policy? I
> tried that and I almost got a lockup, was probably saved by throttling.=


Yes, but not without some patches and a lot of tuning on both guest and
host side. A standard Linux kernel touches too many device models that
will take a long time to make RT compatible. A simple access to a
virtual graphic adapter will be like accessing a screwed up physical GPU
with horrible latency.

Jan


--------------enig30847EF728EA29F61AA5C8B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk96rf4ACgkQitSsb3rl5xRuMgCgpqqBv6Aph/qG9tFcvNND/+8O
qOgAnjIugFMYgBPH5N7qnUfA3R3r2uBi
=1oW8
-----END PGP SIGNATURE-----

--------------enig30847EF728EA29F61AA5C8B2--

