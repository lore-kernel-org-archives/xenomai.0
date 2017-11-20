Date: Mon, 20 Nov 2017 17:09:31 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171120170931.5e2b87c3@md1em3qc>
In-Reply-To: <CAPYpnLZoqA4NGSB_zbi1GeiKr9mWekY1n_r_BKRho6xGvh4uFw@mail.gmail.com>
References: <CAPYpnLZoqA4NGSB_zbi1GeiKr9mWekY1n_r_BKRho6xGvh4uFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Contributing to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <ggallagher31@gmail.com>
Cc: xenomai@xenomai.org

Am Mon, 20 Nov 2017 10:43:09 -0500
schrieb Greg Gallagher <ggallagher31@gmail.com>:

> Hi,
>   I'm preparing a patch to enable RTDM gpio for the Xilinx Zynq 7000
> platform.  First, is this something that would be of value to add to
> mainline Xenomai?  I noticed there is a rtdm gpio driver for the
> bcm2835 (raspberry pi) and figured it may be nice for Zynq users to
> have a rtdm gpio driver out of the box.

I would say in general any additions are welcome. Even if parts to not
get merged for any reason, others will be able to find your patches in
the archives of the list later.

>     I've been digging online and I can't find any guidelines on how to
> submit a patch to Xenomai.  On the mailing list I see most patches
> come across with [PATCH] in the subject line, comments in the body,
> followed by the patch.

Such patches are the output of "git format-patch" and "git send-email".
If you know how to use that, using it would help others to test and
integrate your changes.
However Philippe luckily does not enforce a too strict workflow here.
So it might also be ok to send patches as attachments, but be warned
that that makes reviews more difficult.

So split your changes into multiple patches, where each patch addresses
exactly one issue. And send these patches to the list, if you can use
git or git compatible tools.

> Any help would be appreciated and sorry if I missed this information
> in a FAQ somewhere.

I am not sure whether that is documented anywhere, i basically just
told you how i did it so far and what i have seen since working on the
project.
But one of your changes could introduce such documentation ;).

Henning

> Thanks
> 
> Greg
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


