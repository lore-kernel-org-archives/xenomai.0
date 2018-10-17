MIME-Version: 1.0
References: <ec2acd9e-c708-3d6f-65b0-bc6729ebe333@gmail.com>
In-Reply-To: <ec2acd9e-c708-3d6f-65b0-bc6729ebe333@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 17 Oct 2018 16:53:20 -0400
Message-ID: <CALLqZ8T5RHym-_GfgseLVG2_ZmZBKCzHsM_RRVsCGXivTp1suQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Developing RTDM driver for Xenomai Mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

As far as I know there was a proof of concept for RTDM to run in Mercury if
you search the mailing list you should be able to find some info on it.  I
don't think that work made it's way in, so for the moment RTDM would only
be availiable in the Cobalt core.  I don't use Mercury that much so I can't
speak to it's advantages at the moment.  This thread
https://xenomai.org/pipermail/xenomai/2017-February/037161.html may also
help.

-Greg

On Wed, Oct 17, 2018 at 4:38 PM Wojciech Domski <wojciech.domski@gmail.com>
wrote:

> Hi!
>
> Is it possible to create a RTDM driver as a kernel module under Mercury
> and use it?
>
> I have patched kernel with preempt_rt and installed Xenomai 3.0.7
> Mercury. However, when I try to compile my driver it says that it can
> not find <rtdm/driver.h> header file.
>
> I have checked the /usr/xenomai/include and there is no rtdm/driver.h
> only rtdm/rtdm.h. Does this mean that I can not develop driver under the
> Xenomai Mercury and I have to install Xenomai Cobalt? Or there is
> something wrong with my Xenomai installation? I have referred to
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Start_Here and it does not
> mention that I can not use RTDM drivers in Mercury, actually the
> opposite but this is only showed in the Figures that for Mercury a RTDM
> driver is being used. On the other hand, it is said that:
>
> "the stock kernel drivers can be reused by real-time applications
> with no change (provided they don=E2=80=99t create latency issues due to
> an unfortunate implementation). On the other hand, drivers need
> to be specifically implemented for running over a dual kernel
> configuration, i.e. over the in-kernel RTDM interface."
>
> If the answer to my question is yes then what steps should I take to
> compile the RTDM driver for Mercury?
>
> And, maybe a naive question, if the answer is no then what I really gain
> from using the Mercury instead of a kernel patched with preempt_rt
> besides neat IPC mechanisms etc.?
>
> Best regards,
>
> --
> Wojciech Domski
>
> domski.pl | blog.domski.pl
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
