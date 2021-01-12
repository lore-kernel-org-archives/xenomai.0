MIME-Version: 1.0
References: <CADx0-8BgdfneaX4U5EKxDzJ=5vdcQ347iL3W144Fo9gXLibfnA@mail.gmail.com>
 <CALLqZ8T9aCD3-bBs0SW6W3jU7Fz+30-L=NdV7XjBtTFb1OZZ8Q@mail.gmail.com>
In-Reply-To: <CALLqZ8T9aCD3-bBs0SW6W3jU7Fz+30-L=NdV7XjBtTFb1OZZ8Q@mail.gmail.com>
From: Mohamed Irfanulla Mohamed Abdulla <m.mohamedirfanulla@gmail.com>
Date: Tue, 12 Jan 2021 17:02:00 +0100
Message-ID: <CADx0-8BgLRhipr-Reg+tN-fhzTMES+NxFT-wDvzDT_XopEAEEQ@mail.gmail.com>
Subject: Re: Xenomai on Jetson TX2
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Greg,

Thanks for your reply. Thank you for the information about Ipipe release.
As initial work real-time is concerned for CPU, but GPU is in the roadmap.

Thanks and Regards,
Irfan

On Tue, Jan 12, 2021 at 4:40 PM Greg Gallagher <greg@embeddedgreg.com>
wrote:

> HI,
>
> On Tue, Jan 12, 2021 at 10:32 AM Mohamed Irfanulla Mohamed Abdulla via
> Xenomai <xenomai@xenomai.org> wrote:
>
>> Hi,
>>
>> I would like to know if anyone has successfully installed Xenomai on
>> Nvidia
>> Jetson TX2. Thanks for your suggestions and confirmation if it is possible
>> to install Xenomai on Jetson TX2?
>>
>
> At the moment no.  There's two ways someone could do it, one would be to
> port the ipipe to L4T or use the mainline kernel and port the ipipe to
> support nvidia chips.  If the goal is to use the GPU with Xenomai, you'll
> have to also make the GPU drivers run in the Xenomai domain which may be a
> large task.  Ipipe on Linux 5.4 for ARM64 is almost ready for release, I'm
> just working through a couple more issues, which would be a starting point
> if you want to port the ipipe.
>
> Out of curiosity, is the GPU something that you'd like to use in the real
> time domain?
>
>
>
>> Thanks and regards
>> Irfan
>>
>
> -Greg
>
