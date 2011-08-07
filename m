MIME-Version: 1.0
In-Reply-To: <CAGc_wL0FTegYCidirVKZdqmhwvu9KCjPv0co297QyS=jukD53Q@mail.gmail.com>
References: <CAGc_wL0FTegYCidirVKZdqmhwvu9KCjPv0co297QyS=jukD53Q@mail.gmail.com>
Date: Mon, 8 Aug 2011 00:10:11 +0200
Message-ID: <CAMesUR7u-ri__QbuECBmZG7AVecxOSnkoNKtiUUa6i=mx=zJ5g@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] [ANALOGY] ni660x and ni670x : patch and examples
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Julien Delange <julien.delange@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for the late reply, I just came back from holidays.

On Wed, Aug 3, 2011 at 2:18 PM, Julien Delange <julien.delange@domain.hid> wrote:
> Dear all,
>
> Please find a patch for the support of ni660x and ni670x in the analogy layer.
> The driver works fine and I tested it. I enclosed test programs with
> my mail. The test program for the 660x use the counters and the one
> for the 670x board use the analogy output function. These programs can
> be included in the tests/demo programs from Xenomai, as you want.
>

Many thanks, this is a great contribution!

So far, I just had time to have a look at your first patch
(patch-xenomai-current.diff.gz).
I just have a few remarks before merging it:
- You modified few lines in some analogy core source files
(instruction.c, subdevice.c). The changes are just coding style
modifications. However, the original lines seem to already comply with
the kernel coding guidelines.
- In ni_660x.c:ni_660x_attach(), there is a call to Linux's
request_irq() function, the interrupt will not be handled in Xenomai's
domain but by the Linux kernel. You should use  a4l_request_irq()
instead (this is just a wrapper around the appropriate RTDM service).
Thus, that would be ok with the call to a4l_free_irq() in
ni_660x_detach().
- In ni_670x.c, there is a call to a4l_free_irq() in the detach
function but no call to a4l_request_irq() in the attach function.
- A last detail: it seems that some parts of your code does not comply
with kernel's coding style (ex.: if statements and their associated
brackets, 80 columns)


> I will also try to add/update the documentation according to the
> information needed by these drivers.

Many thanks in advance.

> Please tell me if this patch can be integrated in the Xenomai
> distribution. If there is any problem/issue, just let me know how I
> can fix that. Unfortunately, I cannot make a patch against the latest
> git revision because I cannot make a checkout : the firewall checks
> the http request content and I cannot make a checkout of a source
> repository, even if it provides http access ... sorry for that
> inconvenience. On the other hand, I don't think there was too many
> upgrade in the directory I modified so that this patch might be easily
> merged with the current tree.

Indeed.

>
> Hope this might be helpful,
>
> Best regards,
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>

Alexis.

