Date: Mon, 09 Dec 2019 14:30:42 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: Building deb packages
Message-ID: <jycMJT1P7zI2tMBKKeg25_LsPFpOGDEXheOd5ZX-896nCaMXbeGW8Fqotj5_nedq4d85SvEuUYt-rP83ZN7k04Bu0PBuzLPIKGwHV3HrFXk=@codecraftsmen.org>
In-Reply-To: <CAArsGaaj=sFSOsTkGsAYTsZPJQwutR4EZE8kJBFWefFbzhCHCQ@mail.gmail.com>
References: <a6zvfTWG8HmL1m3CKsFlVVKFO4CznsabNKtz6u1vD1P4HVWcun3mWGHs11YE4exIKjC48U7t5383dTEbXZfYmMeFvHqNnrmzjp0izgkWFys=@codecraftsmen.org>
 <378aee64-da86-da9f-eb46-5059949e37d7@siemens.com>
 <rOql7M13UpQ86c6D3l2RkZfn2hfdic4R0_-GagsurIAJJqe5mwDdFHqYOrDo8LSpNcCCw-_wiOjBp2WaWcyTagPWwE461jmNCgwW5ead5vk=@codecraftsmen.org>
 <cdbee450-251e-b79b-ac38-ddf1f9aaf568@siemens.com>
 <CAArsGaaj=sFSOsTkGsAYTsZPJQwutR4EZE8kJBFWefFbzhCHCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tormod Volden <lists.tormod@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, November 27, 2019 2:22 AM, Tormod Volden <lists.tormod@gmail.=
com> wrote:

> Hi Jeff,
> I just want to chime in here. Not sure if it is related to issue that
> you mention you had with make-kpkg. There is a bug* in the Debian
> "kernel-package" package, that makes make-kpkg add some header files
> to the resulting kernel_headers .deb files that it shouldn't. The
> extra headers cause trouble when you later want to build packages on
> the computer where those .debs are installed.
>
> The workaround, until this is fixed in kernel-package, is to remove
> the headers_install entry in headers.mk from the kernel-package, e.g.:
> sudo sed -i.orig '/headers_install/s/\$/# $/'
> /usr/share/kernel-package/ruleset/targets/headers.mk

Thanks for the information on this issue.  I may look into that in the futu=
re, but I will use "make deb-pkg" with the prepare-kernel --outpatch option=
 for now.

Thanks again for the help.

-Jeff


