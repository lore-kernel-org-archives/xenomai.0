Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8164D.EF0BF3AE"
Date: Wed, 24 Oct 2007 16:55:11 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0B47622@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8164D.EF0BF3AE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all,

I've found a bug in arch/arm/xenomai/switch.S which solved the problem =
below. It actually comes from the iWMMXT (Intel Wireless MMX) =
coprocessor which is an extension of the ARM core in Xscale processor =
(and of course which is not available in the AT91 series ;-).

When a thread switch occurs, rthal_thread_switch(in =
arch/arm/xenomai/switch.S) is called to perform switching of registers =
and stacks between threads. The PXA version must also perform a switch =
of MMX registers by invoking iwmmxt_task_switch(in =
arch/arm/kernel/iwmmxt.S). This is done in rthal_task_switch() as well.

However, between Linux 2.6.15 and Linux 2.6.20, the general scheme of =
low-level task switching procedure changed a little bit: it is now =
relying on a call chain notifier-based mechanism. Therefore, the =
iwmmxt_task_switch() function has been updated since the function is =
called now from the notifier, and not directly from  __switch_to() as in =
2.6.15. And the ipipe (ARM) patch did not take into account that.. and =
it fails.=20

So, as a first workaround, I simply duplicated the iwmmxt_task_switch() =
function making the version (from 2.6.15) proprietary to ipipe by =
renaming to iwmmxt_task_switch_from_ipipe(), and modified =
arch/arm/xenomai/switch.S accordingly (be careful, switch.S is a symlink =
and actually belongs to Xenomai tree (ksrc/arch/arm).

It seems to work so far, but further tests are needed (and will be =
done).

I attached a patch to be applied in the (xenomai-patched) Linux tree.
(Linux 2.6.20, xenomai from today svn).=20


Daniel


On Mon, 2007-10-22 at 19:07 +0200, Jan Kiszka wrote:
Patrick wrote:
> > Please ignore my first wrong mail ;-)
> >=20
> > =20
> >=20
> > Hi,
> >=20
> > =20
> >=20
> > I am trying to found the bug in xenomai for PXA270 machine (xenomai =
2.3.4,
> > ipipe 1.7-06 and kernel 2.6.20).
> >=20
> > =20
> >=20
> > I have localised that the problem is coming when rt_task_create call
> > __ipipe_restore_pipeline_head (called by xnlock_put_irq_restore) in
> > ipipe/core.c.
> >=20
> > I think that the problem is the call to =
__clear_bit(IPIPE_STALL_FLAG,
> > &head->cpudata[cpuid].status);=20
>=20
> Is it the operation itself or the effect on cpudata.status? I mean, =
can
> you safely do a __clear_bit followed by a __set_bit, which would rule
> out an invalid memory access?
>=20
> >=20
> > If I don't execute this function on the rt_task_create the system =
doesn't
> > freeze (but my application doesn't work correctly).
> >=20
> > =20
> >=20
> > I don't know what the problem is. Do you have an idea or a =
suggestion?
>=20
> At least /me is lacking a full picture. So I would suggest, in order =
to
> ease the understanding of your scenario for everyone, to
>=20
>  a) post your modification in form of a patch (diff -up).
>  b) catch the problematic execution path with the ipipe tracer - now
>     that it no longer fails lethally. Just put an ipipe_trace_freeze =
at
>     a point that is unique and close to the hot spot (e.g. after
>     rt_task_create.
>=20
> Jan
>=20

------_=_NextPart_001_01C8164D.EF0BF3AE
Content-Type: text/x-patch;
	name="ipipe_iwmmxt.patch"
Content-Transfer-Encoding: base64
Content-Description: ipipe_iwmmxt.patch
Content-Disposition: attachment;
	filename="ipipe_iwmmxt.patch"

ZGlmZiAtTmF1ciAuLi9saW51eC0yLjYuMjAtY29sLXhlbm9tYWkub3JpZy9hcmNoL2FybS9rZXJu
ZWwvaXdtbXh0LlMgLi9hcmNoL2FybS9rZXJuZWwvaXdtbXh0LlMKLS0tIC4uL2xpbnV4LTIuNi4y
MC1jb2wteGVub21haS5vcmlnL2FyY2gvYXJtL2tlcm5lbC9pd21teHQuUwkyMDA3LTEwLTI0IDE1
OjI0OjU0LjAwMDAwMDAwMCArMDIwMAorKysgLi9hcmNoL2FybS9rZXJuZWwvaXdtbXh0LlMJMjAw
Ny0xMC0yNCAxNDoyMjo1MS4wMDAwMDAwMDAgKzAyMDAKQEAgLTI5Myw2ICsyOTMsMjUgQEAKIAlt
cmMJcDE1LCAwLCByMSwgYzIsIGMwLCAwCiAJc3ViCXBjLCBsciwgcjEsIGxzciAjMzIJCUAgY3B3
YWl0IGFuZCByZXR1cm4KIAorRU5UUlkoaXdtbXh0X3Rhc2tfc3dpdGNoX2Zyb21faXBpcGUpCisK
KwltcmMJcDE1LCAwLCByNCwgYzE1LCBjMSwgMAorCXRzdAlyNCwgIzB4MwkJCUAgQ1AwIGFuZCBD
UDEgYWNjZXNzaWJsZT8KKwlibmUJMWYJCQkJQCB5ZXM6IGJsb2NrIHRoZW0gZm9yIG5leHQgdGFz
aworCisJbGRyCXI1LCA9Y29uY2FuX293bmVyCisJYWRkCXI2LCByMiwgIyhUSV9JV01NWFRfU1RB
VEUgLSBUSV9DUFVfRE9NQUlOKSBAIGdldCBuZXh0IHRhc2sgQ29uY2FuIHNhdmUgYXJlYQorCWxk
cglyNSwgW3I1XQkJCUAgZ2V0IGN1cnJlbnQgQ29uY2FuIG93bmVyCisJdGVxCXI1LCByNgkJCQlA
IG5leHQgdGFzayBvd25zIGl0PworCW1vdm5lCXBjLCBscgkJCQlAIG5vOiBsZWF2ZSBDb25jYW4g
ZGlzYWJsZWQKKworMToJZW9yCXI0LCByNCwgIzMJCQlAIGZsaXAgQ29uY2FuIGFjY2VzcworCW1j
cglwMTUsIDAsIHI0LCBjMTUsIGMxLCAwCisKKwltcmMJcDE1LCAwLCByNCwgYzIsIGMwLCAwCisJ
c3ViCXBjLCBsciwgcjQsIGxzciAjMzIJCUAgY3B3YWl0IGFuZCByZXR1cm4KKworCiAvKgogICog
UmVtb3ZlIENvbmNhbiBvd25lcnNoaXAgb2YgZ2l2ZW4gdGFzawogICoKZGlmZiAtTmF1ciAuLi9s
aW51eC0yLjYuMjAtY29sLXhlbm9tYWkub3JpZy9hcmNoL2FybS94ZW5vbWFpL3N3aXRjaC5TIC4v
YXJjaC9hcm0veGVub21haS9zd2l0Y2guUwotLS0gLi4vbGludXgtMi42LjIwLWNvbC14ZW5vbWFp
Lm9yaWcvYXJjaC9hcm0veGVub21haS9zd2l0Y2guUwkyMDA3LTEwLTI0IDE0OjI1OjU5LjAwMDAw
MDAwMCArMDIwMAorKysgLi9hcmNoL2FybS94ZW5vbWFpL3N3aXRjaC5TCTIwMDctMTAtMjQgMTQ6
NTc6NDkuMDAwMDAwMDAwICswMjAwCkBAIC01OSw2ICs1OSw5IEBACiAgICAgYWRkICAgICBpcCwg
cjEsICNUSV9DUFVfU0FWRQogICAgIGxkciAgICAgcjMsIFtyMiwgI1RJX1RQX1ZBTFVFXQogICAg
IHN0bWlhICAgaXAhLCB7cjQgLSBzbCwgZnAsIHNwLCBscn0gICAgICBAIFN0b3JlIG1vc3QgcmVn
cyBvbiBzdGFjawogICAgIGxkciAgICAgcjYsIFtyMiwgI1RJX0NQVV9ET01BSU5dIQogI2lmIF9f
TElOVVhfQVJNX0FSQ0hfXyA+PSA2CiAjaWZkZWYgQ09ORklHX0NQVV9NUENPUkUKQEAgLTg2LDcg
Kzg5LDcgQEAKICAgICBWRlBGTVhSIEZQRVhDLCByNAogI2VuZGlmCiAjaWYgZGVmaW5lZChDT05G
SUdfSVdNTVhUKQotICAgIGJsICAgICAgaXdtbXh0X3Rhc2tfc3dpdGNoCisgICAgYmwgICAgICBp
d21teHRfdGFza19zd2l0Y2hfZnJvbV9pcGlwZQogI2VsaWYgZGVmaW5lZChDT05GSUdfQ1BVX1hT
Q0FMRSkKICAgICBhZGQgICAgIHI0LCByMiwgIzQwICAgICAgICAgICAgICAgICAgICAgQCBjcHVf
Y29udGV4dF9zYXZlLT5leHRyYQogICAgIGxkbWliICAgcjQsIHtyNCwgcjV9Cgo=

------_=_NextPart_001_01C8164D.EF0BF3AE--

