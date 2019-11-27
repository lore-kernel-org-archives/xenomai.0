MIME-Version: 1.0
References: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
 <378aee64-da86-da9f-eb46-5059949e37d7@siemens.com>
 <rOql7M13UpQ86c6D3l2RkZfn2hfdic4R0_-GagsurIAJJqe5mwDdFHqYOrDo8LSpNcCCw-_wiOjBp2WaWcyTagPWwE461jmNCgwW5ead5vk=@codecraftsmen.org>
 <cdbee450-251e-b79b-ac38-ddf1f9aaf568@siemens.com>
In-Reply-To: <cdbee450-251e-b79b-ac38-ddf1f9aaf568@siemens.com>
From: Tormod Volden <lists.tormod@gmail.com>
Date: Wed, 27 Nov 2019 09:22:46 +0100
Message-ID: <CAArsGaaj=sFSOsTkGsAYTsZPJQwutR4EZE8kJBFWefFbzhCHCQ@mail.gmail.com>
Subject: Re: Building deb packages
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Jeff Webb <w1@codecraftsmen.org>

Hi Jeff,
I just want to chime in here. Not sure if it is related to issue that
you mention you had with make-kpkg. There is a bug* in the Debian
"kernel-package" package, that makes make-kpkg add some header files
to the resulting kernel_headers .deb files that it shouldn't. The
extra headers cause trouble when you later want to build packages on
the computer where those .debs are installed.

The workaround, until this is fixed in kernel-package, is to remove
the headers_install entry in headers.mk from the kernel-package, e.g.:
sudo sed -i.orig '/headers_install/s/\$/# $/'
/usr/share/kernel-package/ruleset/targets/headers.mk

Regards,
Tormod


*) https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D862175#15



On Tue, Nov 26, 2019 at 7:16 PM Jan Kiszka wrote:
>
> On 26.11.19 19:06, Jeff Webb wrote:
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Tuesday, November 26, 2019 11:45 AM, Jan Kiszka wrote:
> >
> >> On 26.11.19 18:33, Jeff Webb via Xenomai wrote:
> >>
> >>> I have previously used make-kpkg to build deb packages for my Ubuntu =
systems. This process worked, but the linux-headers package was never quite=
 right. I could not build my own kernel drivers (e.g. custom UDD drivers) o=
n another system without copying the build directory over or monkeying with=
 the headers package.
> >>> With my latest builds, I tried make deb-pkg with 4.19.84 and 4.4.199-=
cip39. The linux-headers package built with this process almost works. Ther=
e were, however just a few Xenomai headers that were missing. This followin=
g patch to 4.19.84 fixed the issue:
> >>

