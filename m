Message-ID: <f45855d10804030931o76c0f07bn43dfe1df08a5c48b@domain.hid>
Date: Thu, 3 Apr 2008 12:31:59 -0400
From: "Vincent Levesque" <levesquev@domain.hid>
In-Reply-To: <2ff1a98a0804030908g55e907d9xefb2e5a502c6783d@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2487_8530602.1207240320030"
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
	<18417.28104.771421.524613@domain.hid>
	<f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
	<18417.53680.5061.752392@domain.hid>
	<f45855d10804022023n5094eb41g477071cc3a280840@domain.hid>
	<2ff1a98a0804030207sa7a3c44s83fa08db7d0ab3db@domain.hid>
	<f45855d10804030904w28c5ea4bm1c4a71f7b37d5ca6@domain.hid>
	<2ff1a98a0804030908g55e907d9xefb2e5a502c6783d@domain.hid>
Subject: Re: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_2487_8530602.1207240320030
Content-Type: multipart/alternative; 
	boundary="----=_Part_2488_8350210.1207240320030"

------=_Part_2488_8350210.1207240320030
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm attaching the files. -- VL

On Thu, Apr 3, 2008 at 12:08 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Thu, Apr 3, 2008 at 6:04 PM, Vincent Levesque <levesquev@domain.hid>
> wrote:
> > Hi Gilles,
> >
> > I tried the patch on both linux-2.6.24.4+xeno-2.4.2 and
> > linux2.6.24.3+xeno-2.4.2 (like Tomas). In both cases I get errors
> messages
> > when patching:
> >
> > root@domain.hid# patch -p1 < 6.patch
> >  patching file include/linux/mm.h
> > Hunk #1 FAILED at 104.
> > 1 out of 1 hunk FAILED -- saving rejects to file include/linux/mm.h.rej
> > patching file mm/memory.c
> > Hunk #1 FAILED at 584.
> > 1 out of 1 hunk FAILED -- saving rejects to file mm/memory.c.rej
> >
> > Am I using the right version of linux and xenomai? Was I supposed to
> apply
> > other patches first? I had to fix the patch a bit (line endings were
> mangled
> > in the email) but I don't think I broke anything.
>
> What do the rejects look like ?
>
> >
> > Out of curiosity, can you reproduce the bug?
>
> I have not tried yet.
>
> --
>  Gilles
>

------=_Part_2488_8350210.1207240320030
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m attaching the files. -- VL<br><br><div class="gmail_quote">On Thu, Apr 3, 2008 at 12:08 PM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">On Thu, Apr 3, 2008 at 6:04 PM, Vincent Levesque &lt;<a href="mailto:levesquev@domain.hid">levesquev@domain.hid</a>&gt; wrote:<br>

&gt; Hi Gilles,<br>
&gt;<br>
&gt; I tried the patch on both linux-2.6.24.4+xeno-2.4.2 and<br>
&gt; linux2.6.24.3+xeno-2.4.2 (like Tomas). In both cases I get errors messages<br>
&gt; when patching:<br>
&gt;<br>
&gt; root@domain.hid# patch -p1 &lt; 6.patch<br>
&gt; &nbsp;patching file include/linux/mm.h<br>
&gt; Hunk #1 FAILED at 104.<br>
&gt; 1 out of 1 hunk FAILED -- saving rejects to file include/linux/mm.h.rej<br>
&gt; patching file mm/memory.c<br>
&gt; Hunk #1 FAILED at 584.<br>
&gt; 1 out of 1 hunk FAILED -- saving rejects to file mm/memory.c.rej<br>
&gt;<br>
&gt; Am I using the right version of linux and xenomai? Was I supposed to apply<br>
&gt; other patches first? I had to fix the patch a bit (line endings were mangled<br>
&gt; in the email) but I don&#39;t think I broke anything.<br>
<br>
</div></div>What do the rejects look like ?<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; Out of curiosity, can you reproduce the bug?<br>
<br>
</div>I have not tried yet.<br>
<br>
--<br>
<font color="#888888">&nbsp;Gilles<br>
</font></blockquote></div><br>

------=_Part_2488_8350210.1207240320030--

------=_Part_2487_8530602.1207240320030
Content-Type: text/x-patch; name=6.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feljnp0t0
Content-Disposition: attachment; filename=6.patch

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaAppbmRl
eCA3ZjI3ZGI2Li5hMGM4MGM3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgKKysrIGIv
aW5jbHVkZS9saW51eC9tbS5oCkBAIC0xMDQsMTAgKzEwNCwxMSBAQCBleHRlcm4gdW5zaWduZWQg
aW50IGtvYmpzaXplKGNvbnN0IHZvaWQgKm9ianApOwogI2RlZmluZSBWTV9NQVBQRURfQ09QWSAw
eDAxMDAwMDAwICAgICAgLyogVCBpZiBtYXBwZWQgY29weSBvZiBkYXRhIChub21tdSBtbWFwKSAq
LwogI2RlZmluZSBWTV9JTlNFUlRQQUdFICAweDAyMDAwMDAwICAgICAgLyogVGhlIHZtYSBoYXMg
aGFkICJ2bV9pbnNlcnRfcGFnZSgpIiBkb25lIG9uIGl0ICovCiAjZGVmaW5lIFZNX0FMV0FZU0RV
TVAgIDB4MDQwMDAwMDAgICAgICAvKiBBbHdheXMgaW5jbHVkZSBpbiBjb3JlIGR1bXBzICovCi0j
ZGVmaW5lIFZNX1BJTk5FRCAgICAgIDB4MDgwMDAwMDAgICAgICAvKiBEaXNhYmxlIGZhdWx0cyBm
b3IgdGhlIHZtYSAqLwogCiAjZGVmaW5lIFZNX0NBTl9OT05MSU5FQVIgMHgwODAwMDAwMCAgICAv
KiBIYXMgLT5mYXVsdCAmIGRvZXMgbm9ubGluZWFyIHBhZ2VzICovCiAKKyNkZWZpbmUgVk1fUElO
TkVEICAgICAgMHgxMDAwMDAwMCAgICAgIC8qIERpc2FibGUgZmF1bHRzIGZvciB0aGUgdm1hICov
CisKICNpZm5kZWYgVk1fU1RBQ0tfREVGQVVMVF9GTEFHUyAgICAgICAgIC8qIGFyY2ggY2FuIG92
ZXJyaWRlIHRoaXMgKi8KICNkZWZpbmUgVk1fU1RBQ0tfREVGQVVMVF9GTEFHUyBWTV9EQVRBX0RF
RkFVTFRfRkxBR1MKICNlbmRpZgpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnku
YwppbmRleCBlMGU3YTNkLi4zMmQ2Y2I2IDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9t
bS9tZW1vcnkuYwpAQCAtNTg0LDggKzU4NCwxNCBAQCBhZ2FpbjoKICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGlzX2Nvd19tYXBwaW5nKHZtYS0+dm1fZmxhZ3MpKSB7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKCgodm1hLT52bV9mbGFnc3xzcmNfbW0tPmRlZl9mbGFncykg
JiAoVk1fTE9DS0VEfFZNX1BJTk5FRCkpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgID09IChWTV9MT0NLRUR8Vk1fUElOTkVEKSkgeworICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYXJjaF9sZWF2ZV9sYXp5X21tdV9tb2RlKCk7CisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jayhzcmNfcHRsKTsKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0ZV91bm1hcF9uZXN0ZWQoc3JjX3B0ZSk7
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRfbW1fcnNzKGRzdF9t
bSwgcnNzWzBdLCByc3NbMV0pOworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcHRlX3VubWFwX3VubG9jayhkc3RfcHRlLCBkc3RfcHRsKTsKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZG9fY293X2JyZWFrID0gMTsKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBhZ2FpbjsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
CiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0K
------=_Part_2487_8530602.1207240320030
Content-Type: application/x-reject; name=memory.c.rej
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feljo8lb1
Content-Disposition: attachment; filename=memory.c.rej

KioqKioqKioqKioqKioqIGFnYWluOgoqKiogNTg0LDU5MSAqKioqCiAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoaXNfY293X21hcHBpbmcodm1hLT52bV9mbGFncykpIHsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKCgodm1hLT52bV9mbGFnc3xzcmNfbW0tPmRlZl9mbGFn
cykgJiAoVk1fTE9DS0VEfFZNX1BJTk5FRCkpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA9PSAoVk1fTE9DS0VEfFZNX1BJTk5FRCkpIHsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkb19jb3dfYnJlYWsgPSAxOwotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9CiAgICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgfQotLS0g
NTg0LDU5NyAtLS0tCiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoaXNfY293X21hcHBpbmco
dm1hLT52bV9mbGFncykpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCgo
dm1hLT52bV9mbGFnc3xzcmNfbW0tPmRlZl9mbGFncykgJiAoVk1fTE9DS0VEfFZNX1BJTk5FRCkp
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9PSAoVk1fTE9DS0VEfFZNX1BJ
Tk5FRCkpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmNoX2xl
YXZlX2xhenlfbW11X21vZGUoKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzcGluX3VubG9jayhzcmNfcHRsKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwdGVfdW5tYXBfbmVzdGVkKHNyY19wdGUpOworICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFkZF9tbV9yc3MoZHN0X21tLCByc3NbMF0sIHJzc1sxXSk7
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHRlX3VubWFwX3VubG9j
ayhkc3RfcHRlLCBkc3RfcHRsKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25kX3Jlc2NoZWQoKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkb19jb3dfYnJlYWsgPSAxOworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gYWdhaW47CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KICAg
ICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICB9Cg==
------=_Part_2487_8530602.1207240320030
Content-Type: application/x-reject; name=mm.h.rej
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feljoikt2
Content-Disposition: attachment; filename=mm.h.rej

KioqKioqKioqKioqKioqIGV4dGVybiB1bnNpZ25lZCBpbnQga29ianNpemUoY29uc3Qgdm9pZCAq
b2JqcCk7CioqKiAxMDQsMTEzICoqKioKICAjZGVmaW5lIFZNX01BUFBFRF9DT1BZIDB4MDEwMDAw
MDAgICAgICAvKiBUIGlmIG1hcHBlZCBjb3B5IG9mIGRhdGEgKG5vbW11IG1tYXApICovCiAgI2Rl
ZmluZSBWTV9JTlNFUlRQQUdFICAweDAyMDAwMDAwICAgICAgLyogVGhlIHZtYSBoYXMgaGFkICJ2
bV9pbnNlcnRfcGFnZSgpIiBkb25lIG9uIGl0ICovCiAgI2RlZmluZSBWTV9BTFdBWVNEVU1QICAw
eDA0MDAwMDAwICAgICAgLyogQWx3YXlzIGluY2x1ZGUgaW4gY29yZSBkdW1wcyAqLwotICNkZWZp
bmUgVk1fUElOTkVEICAgICAgMHgwODAwMDAwMCAgICAgIC8qIERpc2FibGUgZmF1bHRzIGZvciB0
aGUgdm1hICovCiAgCiAgI2RlZmluZSBWTV9DQU5fTk9OTElORUFSIDB4MDgwMDAwMDAgICAgLyog
SGFzIC0+ZmF1bHQgJiBkb2VzIG5vbmxpbmVhciBwYWdlcyAqLwogIAogICNpZm5kZWYgVk1fU1RB
Q0tfREVGQVVMVF9GTEFHUyAgICAgICAgIC8qIGFyY2ggY2FuIG92ZXJyaWRlIHRoaXMgKi8KICAj
ZGVmaW5lIFZNX1NUQUNLX0RFRkFVTFRfRkxBR1MgVk1fREFUQV9ERUZBVUxUX0ZMQUdTCiAgI2Vu
ZGlmCi0tLSAxMDQsMTE0IC0tLS0KICAjZGVmaW5lIFZNX01BUFBFRF9DT1BZIDB4MDEwMDAwMDAg
ICAgICAvKiBUIGlmIG1hcHBlZCBjb3B5IG9mIGRhdGEgKG5vbW11IG1tYXApICovCiAgI2RlZmlu
ZSBWTV9JTlNFUlRQQUdFICAweDAyMDAwMDAwICAgICAgLyogVGhlIHZtYSBoYXMgaGFkICJ2bV9p
bnNlcnRfcGFnZSgpIiBkb25lIG9uIGl0ICovCiAgI2RlZmluZSBWTV9BTFdBWVNEVU1QICAweDA0
MDAwMDAwICAgICAgLyogQWx3YXlzIGluY2x1ZGUgaW4gY29yZSBkdW1wcyAqLwogIAogICNkZWZp
bmUgVk1fQ0FOX05PTkxJTkVBUiAweDA4MDAwMDAwICAgIC8qIEhhcyAtPmZhdWx0ICYgZG9lcyBu
b25saW5lYXIgcGFnZXMgKi8KICAKKyAjZGVmaW5lIFZNX1BJTk5FRCAgICAgIDB4MTAwMDAwMDAg
ICAgICAvKiBEaXNhYmxlIGZhdWx0cyBmb3IgdGhlIHZtYSAqLworIAogICNpZm5kZWYgVk1fU1RB
Q0tfREVGQVVMVF9GTEFHUyAgICAgICAgIC8qIGFyY2ggY2FuIG92ZXJyaWRlIHRoaXMgKi8KICAj
ZGVmaW5lIFZNX1NUQUNLX0RFRkFVTFRfRkxBR1MgVk1fREFUQV9ERUZBVUxUX0ZMQUdTCiAgI2Vu
ZGlmCg==
------=_Part_2487_8530602.1207240320030--

