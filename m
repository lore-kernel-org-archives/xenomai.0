MIME-Version: 1.0
References: <4e03-60663e80-47-10b42340@50501997>
 <77b9bb71-4cdf-fb8e-9fde-4cfd033a7722@gmail.com>
In-Reply-To: <77b9bb71-4cdf-fb8e-9fde-4cfd033a7722@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 3 Apr 2021 08:02:45 -0400
Message-ID: <CALLqZ8S0o0qLJuFrcmF-_vKkf_v7Jbe0xQCQiSNKLQyRQ=4e_A@mail.gmail.com>
Subject: Re: arm32: 5.4.107 ipipe patch - bad kernel version choice ;)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <xenomai.list@gmail.com>
Cc: xenomai@xenomai.org

On Sat, Apr 3, 2021 at 7:57 AM Robert Berger via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> I just checked this patch on one of my imx6q boards:
>
> https://xenomai.org/downloads/ipipe/v5.x/arm/ipipe-core-5.4.107-arm-1.patch
>
> One problem is, that 5.4.107 does not seem to be a good choice due to
> this crash:
>
> https://pastebin.com/EzUE6i3f
>
> This is __NOT__ caused by the ipipe patch as far as I can tell and
> happens also on various 5.10.x kernels, but was resolved in the latest
> 5.10.x kernels.
>
> So I tried to patch a more recent 5.4.x kernel - 5.4.109, and it does
> not contain the crash from above anymore.
>
> 2 files from the 5.4.107 patch were rejected:
>
> arch/arm/kernel/entry-armv.S.rej
> vim arch/arm/vfp/entry.S.rej
>
> It looks like whatever is in entry.S already went upstream and I tried
> to hack entry-armv.S (please review).
>
> Can you please check my attached/updated patch against upstream 5.4.109,
> which, after some quick testing, seems to work for me, and update your
> ipipe-core-5.4.107 to 5.4.109?
>
> Regards,
>
> Robert
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-fake-ipipe-core-5.4.109-arm-1.patch
> Type: text/x-patch
> Size: 661672 bytes
> Desc: not available
> URL: <
> http://xenomai.org/pipermail/xenomai/attachments/20210403/0f9d5c6e/attachment.bin
> >
>
Thanks for testing, I can update to kernel version 5.4.109.

Thanks

Greg
