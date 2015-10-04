MIME-Version: 1.0
In-Reply-To: <560FA3DF.1030204@xenomai.org>
References: <CAKO1R-ReR8XT8n6_UHWCV=vnk_Y38QkSiSjf0_HVg0=Eu70VNg@mail.gmail.com>
 <560FA3DF.1030204@xenomai.org>
Date: Sun, 4 Oct 2015 20:43:41 +0800
Message-ID: <CAKO1R-TUkrgYo1nwb86m_W8MMghq124EkPuL8Q+qQrGs9n1Z0A@mail.gmail.com>
From: =?UTF-8?B?5p6X5bGV57+U?= <chlin6016@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Thanks Philippe.

I've switched to the 'next' branch and tried to run cyclictest on
Beaglebone Black
(Also ran latency, the numbers were OK.)
The first time I ran cyclictest, there was a message saying that
non-SMP libraries was running on SMP kernel
But after recompiling xenomai with the '--enable-smp' option,
when I executed cyclictest (and latency), there were no messages printed
out (even errors)

Could this be the problem of the compiling process on Xenomai or the Linux
kernel ?
(My kernel version is 3.14.39)


Chan-Hsiang Lin


2015-10-03 17:46 GMT+08:00 Philippe Gerum <rpm@xenomai.org>:

> On 10/03/2015 11:35 AM, =E6=9E=97=E5=B1=95=E7=BF=94 wrote:
> > Hello,
> >
> > I've cloned the code from Konstantinos's github page and amended the
> > Makefile and cyclictest.c like Philippe had suggested.
> >
> > But when I ran cyclictest(after compilation) with the command
> './cyclictest
> > -p 99 -i 250 -n', the MAX latency was still over 200us.
> >
> > Can anyone tell me where the problem might be?
>
> A good way to check whether you actually fixed up the original code
> properly with the earlier, out of tree cyclictest, is to run Xenomai's
> latency test. Not seeing any latency issues with that one would give you
> some hint about where the problem might be.
>
> --
> Philippe.
>
