MIME-Version: 1.0
References: <c32e5b83-4eec-f6f2-dd63-c1e5b753a78f@siemens.com>
In-Reply-To: <c32e5b83-4eec-f6f2-dd63-c1e5b753a78f@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 6 Nov 2018 14:28:57 -0500
Message-ID: <CALLqZ8RSY9Kc4vwS7D_JnVm3GNRNGQV6PAv7Mi7fmrGPPQ88WQ@mail.gmail.com>
Subject: Re: [RFC] xenomai-images: test and demo image generator
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>

This looks really good.  How easy is it to add more targets?  I looked
at the jailhouse-images commits to see how to add a board, is that a
good place to start to see how to add a new board?

-Greg

On Tue, Nov 6, 2018 at 1:58 PM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi all,
>
> as I was (and still am) in the need to test also non-x86 from time to time, I
> hacked up a little framework for generating bootable Debian images with Xenomai
> pre-installed. It's currently hosted on my personal github space:
>
> https://github.com/jan-kiszka/xenomai-images
>
> I think we should move this over to the Xenomai group at gitlab.denx.de and
> expand this step-wise with more archs (that QEMU support) as well as real
> targets. I think I will add the HiKey board tomorrow, should be rather simple as
> I did this for jailhouse-images [1], the inspiration and source of this layer,
> just recently. Provided the ipipe kernel works fine with it.
>
> Comments? Suggestions? Opinions?
>
> Jan
>
> [1] https://github.com/siemens/jailhouse-images
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

