Subject: Re: Xenomai RTnet - Kernel module not loading
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
 <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
 <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
 <1987057484.452222.1582642123490.JavaMail.zimbra@wolfram.com>
 <6a5fc541-8519-56d0-f4b4-c7e29f4b38f3@b-tu.de>
 <1253430772.456171.1582643215737.JavaMail.zimbra@wolfram.com>
 <d6b19aa8-c978-617c-bb85-335634e47ac1@b-tu.de>
 <1294487288.461675.1582644685411.JavaMail.zimbra@wolfram.com>
From: Benji <miethben@b-tu.de>
Message-ID: <cbce49c7-0cca-73de-bc4f-bb4efd29b7d7@b-tu.de>
Date: Thu, 27 Feb 2020 16:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <1294487288.461675.1582644685411.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

On 2/25/20 4:31 PM, Per Oberg wrote:
> ----- Den 25 feb 2020, p=C3=A5 kl 16:15, Benji miethben@b-tu.de skrev:
>=20
>> On 2/25/20 4:06 PM, Per Oberg wrote:
>=20
>=20
>>> Are you sure you are running on the cobalt/rt enabled kernel?
>=20
>>> When running "dmesg | grep Xenomai" do you see something like
>=20
>>> # [ 1.417024] [Xenomai] scheduling class idle registered.
>>> # [ 1.417025] [Xenomai] scheduling class rt registered.
>>> # [ 1.417045] [Xenomai] disabling automatic C1E state promotion on In=
tel
>>> processor
>>> # [ 1.417055] [Xenomai] SMI-enabled chipset found, but SMI workaround=
 disabled
>>> # [ 1.417088] I-pipe: head domain Xenomai registered.
>>> # [ 1.417704] [Xenomai] allowing access to group 1234
>>> # [ 1.417726] [Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder) [DEBUG]
>=20
>>> Regards
>>> Per =C3=96berg
>=20
>=20
>> I thought system is running on cobalt kernel. But looks like there is =
an
>> initialisation error. What is meaning of error code -19?
>=20
>>> $ dmesg | grep Xenomai
>>> [ 8.543295] [Xenomai] scheduling class idle registered.
>>> [ 8.543302] [Xenomai] scheduling class rt registered.
>>> [ 8.543333] [Xenomai] init failed, code -19
>=20
> I haven't seen that one myself. But check out:=20
>=20
> https://xenomai.org/pipermail/xenomai/2015-September/thread.html#35066
>=20
> and
>=20
> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#no-timer
>=20
> (Although i see the in-page link is broken check the section about time=
rs)
>=20
>=20
> Per =C3=96berg=20
>=20
Hi,

the hint was in the right direction. There is something strange in my
build process. In kernel configuration i disable options described in
Xenomai Wiki (like CPU_FREQ, KGDB..). After running 'make bzImage
modules' and checking .config file, disabled option are enabled again.

Are there dependencies to force enable these option without notice?

Thanks
Benji

