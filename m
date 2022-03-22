MIME-Version: 1.0
References: <cff-6239fe00-4d-24d08100@67302606>
In-Reply-To: <cff-6239fe00-4d-24d08100@67302606>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 22 Mar 2022 13:31:33 -0400
Message-ID: <CALLqZ8Q7ozVT_9rzcAuQUvMutCHLUW+uNfk-XA3T3p0hDkGE6Q@mail.gmail.com>
Subject: Re: Bug in xenomai 3.2.x on ARM
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
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On Tue, Mar 22, 2022 at 12:49 PM Fran=C3=A7ois Legal via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
>
> trying to port a running Xenomai 3.1.x/Linux 4.4.x system to Xenomai
> 3.2.x/Linux 4.4.x running on Zynq7000, I found a (maybe) bug in intr.c
>
> In xnintr_attach, the call to ipipe_set_irq_affinity (when in SMP) expect=
s
> a 0 return code. However, on my platform, I end up in irq_gic.c in
> gic_set_affinity() which returns IRQ_SET_MASK_OK_DONE (2) when everything
> is fine.
>
> This IRQ_SET_MASK_OK_DONE does not seem very common in the kernel (I coul=
d
> find a few occurences, on Gic v3 so maybe AARCH64 has the same problem,
> plus some PCI devices).
>
> I was wondering if this was something to fix in ipipe or xenomai ?
>
> Fran=C3=A7ois


Do the newer kernels have the same return value? Do we test 3.2.x on the
older kernels? Maybe just cip ?

-Greg

>
>
