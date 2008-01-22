Message-ID: <2ff1a98a0801220843x23b1c4c5g337df9a10b38ed17@domain.hid>
Date: Tue, 22 Jan 2008 17:43:41 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4796186D.2070906@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13098_9791258.1201020221962"
References: <4794DDF7.9070009@domain.hid> <4794E556.1030904@domain.hid>
	<4794E904.5060106@domain.hid> <4796186D.2070906@domain.hid>
Subject: Re: [Xenomai-core] Patch selection by prepare-kernel.sh (again)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

------=_Part_13098_9791258.1201020221962
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Jan 22, 2008 5:23 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> >> Jan Kiszka wrote:
> >>> Philippe,
> >>>
> >>> what was the idea behind commit #3256 [1]? It breaks the original
> >>> behavior of selection adeos-ipipe-2.6.23-... in the presence of 2.6.23.x
> >>> - and leaves a bad first impression for beginners (I received such a
> >>> notice here...). Was this for the special case
> >>> adeos-ipipe-2.6.20.21-i386-1.12-02.patch? But I think the common case
> >>> should take precedence over this corner case here. Unless there are more
> >>> issues with the original version, I would vote for restoring it.
> >>>
> >>> Alternatively, we could add a safety belt by trying to apply the patch
> >>> with --dry-run first and only continue if this works out without
> >>> failures. Can hack this up if it's acceptable.
> >> Oh, this check already exists!
> >>
> >> So let's try this version, which additionally cleans up the related
> >> documentation. Catches both 2.6.23* and 2.6.24* for me here, but I may
> >> miss some cases (2.4?).
> >
> > The documentation hunk was nonsense, here is a hopefully better version.
> >
>
> Makes sense and works fine for the kernel/arch combos I've tested so
> far. Merged, thanks.

configure.in probably needs a similar fix for the --enable-linux-build
option to work with the -x86 patches.

-- 
                                               Gilles Chanteperdrix

------=_Part_13098_9791258.1201020221962
Content-Type: application/octet-stream; name=xeno-x86-configure.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbqof5dx0
Content-Disposition: attachment; filename=xeno-x86-configure.diff

SW5kZXg6IGNvbmZpZ3VyZS5pbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBjb25maWd1cmUuaW4JKHLDqXZpc2lv
biAzNDMxKQorKysgY29uZmlndXJlLmluCShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtMzM3LDYgKzMz
Nyw3IEBACiAgIGZpCiAgIGNhc2UgIiRBREVPU19QQVRDSCIgaW4KIAkqLXBvd2VycGMtKikgWEVO
T19MSU5VWF9BUkNIPXBvd2VycGM7OworCSoteDg2LSopIFhFTk9fTElOVVhfQVJDSD14ODY7Owog
ICBlc2FjCiAgIEFDX1NVQlNUKEFERU9TX1BBVENIKQogCg==
------=_Part_13098_9791258.1201020221962--

