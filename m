MIME-Version: 1.0
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
 <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
In-Reply-To: <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 8 Jul 2020 08:41:40 -0400
Message-ID: <CALLqZ8TPySW33BFrgCRxw5m+A+x9RB8OtkUSGW5XmsJgz2xPRg@mail.gmail.com>
Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

HI,

On Tue, Jul 7, 2020 at 7:04 PM Robert Berger <xenomai.list@gmail.com> wrote:
>
> It looks like either we hit a glibc issue, or something is not clear to
> me in the xenomai test case.
>
I'm using glibc 2.25.  The other thing to keep in mind is that the
message isn't coming from the Linux kernel, it's coming from Cobalt.
So it's possible cobalt is having some issues with a newer libc.  I'll
have time tonight to sit down with ftrace and see if I can get a
better idea of what's going on.


> The glibc has a fallback for the unknown syscall. clock_nanosleep_time64
>
> Is this what the xenomai testcase tries to tell us?
>
> Than that is not an error, but fine;)
>
> Regards,
>
> Robert
>
-Greg

