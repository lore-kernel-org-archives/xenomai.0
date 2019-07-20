Subject: Re: Asynchronous notify?
References: <CAFLxGvwmtY6MD1LLJ9PbjXOp9a_7nNnVRCOKRkJQ1VA-d_QM2Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <a112852f-d593-8088-8df8-1b2c5506af41@web.de>
Date: Sat, 20 Jul 2019 18:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwmtY6MD1LLJ9PbjXOp9a_7nNnVRCOKRkJQ1VA-d_QM2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 19.07.19 12:26, Richard Weinberger via Xenomai wrote:
> Hi!
>
> Is there a way in Xenomai 3 to have a signal alike notification?
>
> The Xenomai 2 code base I work on needs a way to get exceptions such
> as #DB and #BP
> delivered to a RT_TASK in real time context.
> For Xenomai 2 they implemented a subset of regular RT-signals which
> work in real time context.
> So the RT_TASK could register a signal handler for #DB on x86.
>
> Before I start porting this feature to Xenomai 3 (I'll happily publish
> these patches) I want
> to sort out whether this can be achieved with stock features or
> minimal adoptions.
>

There is no asynchronous notification via signal handlers in Xenomai. Howe=
ver,
we have some downstream code that allows to run pre- and post-debug handle=
rs in
prioritized thread context to prepare the external world for potential
interruptions due to debugging sessions. I plan to upstream that at some p=
oint -
too much stuff in the queue, and it's not yet clear if the feature is suff=
icient
for our use case. But maybe we have common requirements here?

What may not be very attractive, though, are real signal handlers. They wo=
uld
pull in additional architecture code, not to speak of the complexity when =
we
wanted to model asynchronous POSIX signals correctly.

Jan

