MIME-Version: 1.0
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
 <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
 <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
 <1987057484.452222.1582642123490.JavaMail.zimbra@wolfram.com>
 <6a5fc541-8519-56d0-f4b4-c7e29f4b38f3@b-tu.de>
 <1253430772.456171.1582643215737.JavaMail.zimbra@wolfram.com>
 <d6b19aa8-c978-617c-bb85-335634e47ac1@b-tu.de>
 <1294487288.461675.1582644685411.JavaMail.zimbra@wolfram.com>
 <cbce49c7-0cca-73de-bc4f-bb4efd29b7d7@b-tu.de>
In-Reply-To: <cbce49c7-0cca-73de-bc4f-bb4efd29b7d7@b-tu.de>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 27 Feb 2020 10:51:09 -0500
Message-ID: <CALLqZ8R3rKRUyvqyVcG18ovxVTniU6SiCGRi0_nKQ0z4kp1QSA@mail.gmail.com>
Subject: Re: Xenomai RTnet - Kernel module not loading
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
To: Benji <miethben@b-tu.de>
Cc: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

Hi,

On Thu, Feb 27, 2020 at 10:38 AM Benji via Xenomai <xenomai@xenomai.org> wr=
ote:
>
> On 2/25/20 4:31 PM, Per Oberg wrote:
> > ----- Den 25 feb 2020, p=C3=A5 kl 16:15, Benji miethben@b-tu.de skrev:
> >
> >> On 2/25/20 4:06 PM, Per Oberg wrote:
> >
> >
> >>> Are you sure you are running on the cobalt/rt enabled kernel?
> >
> >>> When running "dmesg | grep Xenomai" do you see something like
> >
> >>> # [ 1.417024] [Xenomai] scheduling class idle registered.
> >>> # [ 1.417025] [Xenomai] scheduling class rt registered.
> >>> # [ 1.417045] [Xenomai] disabling automatic C1E state promotion on In=
tel
> >>> processor
> >>> # [ 1.417055] [Xenomai] SMI-enabled chipset found, but SMI workaround=
 disabled
> >>> # [ 1.417088] I-pipe: head domain Xenomai registered.
> >>> # [ 1.417704] [Xenomai] allowing access to group 1234
> >>> # [ 1.417726] [Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder) [DEBUG]
> >
> >>> Regards
> >>> Per =C3=96berg
> >
> >
> >> I thought system is running on cobalt kernel. But looks like there is =
an
> >> initialisation error. What is meaning of error code -19?
> >
> >>> $ dmesg | grep Xenomai
> >>> [ 8.543295] [Xenomai] scheduling class idle registered.
> >>> [ 8.543302] [Xenomai] scheduling class rt registered.
> >>> [ 8.543333] [Xenomai] init failed, code -19
> >
> > I haven't seen that one myself. But check out:
> >
> > https://xenomai.org/pipermail/xenomai/2015-September/thread.html#35066
> >
> > and
> >
> > https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#no-timer
> >
> > (Although i see the in-page link is broken check the section about time=
rs)
> >
> >
> > Per =C3=96berg
> >
> Hi,
>
> the hint was in the right direction. There is something strange in my
> build process. In kernel configuration i disable options described in
> Xenomai Wiki (like CPU_FREQ, KGDB..). After running 'make bzImage
> modules' and checking .config file, disabled option are enabled again.
>
> Are there dependencies to force enable these option without notice?
>
> Thanks
> Benji
>
Did you use menuconfig? I use menuconfig to disable those options and
it makes it very clear if there are other options that need to be
disabled as well.

-Greg

