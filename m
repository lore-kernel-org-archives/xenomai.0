Message-ID: <2ff1a98a0708160731k5eefd6b2i417b05b6d329e481@domain.hid>
Date: Thu, 16 Aug 2007 16:31:49 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4760.194.114.62.68.1187274071.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_89358_25761331.1187274709805"
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>
	<2ff1a98a0708160300r79a717ebt7541c1d6e3da6687@domain.hid>
	<11886.194.114.62.68.1187258877.squirrel@domain.hid>
	<18116.9932.592597.831501@domain.hid>
	<56493.194.114.62.68.1187265227.squirrel@domain.hid>
	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
	<21067.194.114.62.68.1187272557.squirrel@domain.hid>
	<2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>
	<4760.194.114.62.68.1187274071.squirrel@domain.hid>
Subject: Re: [Xenomai-help] latency problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_89358_25761331.1187274709805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/16/07, Nadym Salem <Kaiman@domain.hid> wrote:
> On Thu, August 16, 2007 16:01, Gilles Chanteperdrix wrote:
> > Aha, this probably means that your chipset is not supporte, could you
> > run lspci and send us the output ?
>
> it is attached.

Could you try to apply the attached patch to xenomai sources ? You
will then have to recompile your xenomai-patched kernel.

> > It is the option --disable-x86-tsc of the configure script.
>
> That's why I didn't find it :-) Did it, but it did not change anything.

That is good news, it means that this stuff is probably not broken.

-- 
                                               Gilles Chanteperdrix

------=_Part_89358_25761331.1187274709805
Content-Type: application/octet-stream; name="xeno-smi-add-ich8.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xeno-smi-add-ich8.diff"
X-Attachment-Id: f_f5fcoi3r

SW5kZXg6IGtzcmMvYXJjaC9pMzg2L3NtaS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGtzcmMvYXJjaC9pMzg2
L3NtaS5jCShyw6l2aXNpb24gMjgyNSkKKysrIGtzcmMvYXJjaC9pMzg2L3NtaS5jCShjb3BpZSBk
ZSB0cmF2YWlsKQpAQCAtNTUsNiArNTUsNyBAQAogeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
SU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSUNINl8yKSB9LAogeyBQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSUNIN18wKSB9LAogeyBQQ0lfREVW
SUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSUNIN18xKSB9LAor
eyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSUNI
OF8wKSB9LAogeyAwLCB9LAogfTsKIAo=
------=_Part_89358_25761331.1187274709805--

