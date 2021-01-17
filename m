MIME-Version: 1.0
References: <87wnwbeaf5.fsf@xenomai.org>
In-Reply-To: <87wnwbeaf5.fsf@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 17 Jan 2021 14:08:56 -0500
Message-ID: <CALLqZ8ReaFSLnta8z=CCgzLNB3ok5uvh8a2m0HmkAtCNen9DgA@mail.gmail.com>
Subject: Re: [RFC] Drop support for ARM OABI from Xenomai 3.2
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Jan 17, 2021 at 12:32 PM Philippe Gerum via Xenomai <
xenomai@xenomai.org> wrote:

>
> The old ARM ABI format is dead, however we still have the support bits
> to handle it in both the I-pipe and Cobalt, which - I believe - does not
> make sense anymore. In addition, Dovetail only supports the new EABI
> format, and there is definitely no plan to care about OABI.
>
> Given the burden of maintaining this obsolete code which nobody should
> be using these days, I recommend to drop support for the OABI format
> starting from Xenomai 3.2.
>
> Please comment.
>
> Thanks,
>
> --
> Philippe.
>
> Agreed. I haven=E2=80=99t tested anything but EABI builds on the arm I-Pi=
pe.

With the limit resources we have the less variations to maintain the better=
.

-Greg
