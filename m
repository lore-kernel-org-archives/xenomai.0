MIME-Version: 1.0
In-Reply-To: <51778082.4060504@xenomai.org>
References: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
	<51778082.4060504@xenomai.org>
Date: Wed, 24 Apr 2013 12:27:41 +0530
Message-ID: <CAH8NBSfP3ToQtYMFZymuPwB_E96q=7wBWsL_Ag2r2c=dSwa6yA@mail.gmail.com>
From: Srikanth C <srikanthc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai@xenomai.org

Arch is PPC and interrupt is PCI, level sensitive interrupt.

ipipe 3.2.21 patch is applied to kernel 3.2.24 and even I tried with
ipipe-core-3.5.7-powerpc-3.patch with 3.5.7 kernel
same result is observed.



On Wed, Apr 24, 2013 at 12:19 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 04/24/2013 08:29 AM, Srikanth C wrote:
>
> > Hi,
> >
> > Spurious interrupts are raised on 2.6.1 Xenomai patch
> > with Linux Kernel version 3.2.34
> >
> > for every pci interrupt raise  there is one spurious interrupt also
> getting
> > raised.
> >
> > Without Xenomai patch pci interrupts are working fine (Spurious
> interrupts
> > are not raised).
>
>
> What architecture? What kind of interrupt? Do you know the latest
> version of Xenomai is 2.6.2.1, not 2.6.1? Where did you get an I-pipe
> patch for 3.2.34 as the one we provide is for 3.2.21?
>
> --
>                                                                 Gilles.
>
