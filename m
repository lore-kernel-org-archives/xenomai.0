Date: Fri, 15 Nov 2019 23:14:59 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: [ANNOUNCE] Xenomai v3.1-rc3 available
Message-ID: <6A8KLFuCLPtKt-g8GWZEP4G0rMK4ZA6RRo-1DSBHkySvKYcPcyydk9ON5HCyWrTPvdMz7BQdFAVYWPmkAs1zuogrEDjXI0dWDwVnFJYiIFc=@codecraftsmen.org>
In-Reply-To: <e2ceb276-09e5-2a11-ac34-3926668615e0@siemens.com>
References: <y27Ah4Xs-t8bhib0n5wvb0RE8X2b-B4GbVUz2PHHbETtMbl4SjmsFQP7GPGLfWozQrc_BW9MqoZFFIq0RYnMjvl_VQ0ecJz5Tp5fcaXPKcg=@codecraftsmen.org>
 <e2ceb276-09e5-2a11-ac34-3926668615e0@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Friday, November 15, 2019 4:40 AM, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
> On 15.11.19 01:31, Jeff Webb via Xenomai wrote:
> > I am building a Xenomai cobalt kernel under Ubuntu 18.04 based on:
> >
> >     Linux 4.19.75
> >     Xenomai 3.1-rc3
> >     ipipe-core-4.19.75-x86-7.patch
> >
> >
> > After running prepare-kernel.sh and "makeolddefconfig" (using the unmod=
ified default .config), I get this error:
> >
> >     WARNING: unmet direct dependencies detected for PARAVIRT
> >       Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
> >       Selected by [m]:
> >       - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=
=3Dy] && HYPERVISOR_GUEST [=3Dy]
> >
> >
> > I turned off HYPERVISOR_GUEST manually to fix the warning. I hadn't see=
n this type of error before, but perhaps something could be done in the pat=
ch to make the default config consistent... Just FYI.
>
> It's HYPERV what causes this, by also pulling PARAVIRT which is not
> compatible with I-pipe. We need to tag that config as well to avoid this.
>
> > Otherwise, everything went fine with the build process and initial test=
ing. I will be giving this build some more testing over the next week or so=
 and will let you know if I find any issues.
>
> Great to hear, thanks.

I haven't done extensive testing yet, but I tried several of our real-time =
applications with the new build, and things seem to be working so far.  Eve=
n on a different (but perhaps similar), older set of hardware from the one =
that has the intremap issues, I get the same kernel BUG messages (using the=
 same 4.19 kernel build) mentioned in my other email:

  https://xenomai.org/pipermail/xenomai/2019-November/041988.html

but things appear to be functioning properly as far as I can tell.

This is just some more feedback on the latest kernel / xenomai release cand=
idate.

Thanks,

-Jeff


