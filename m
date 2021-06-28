MIME-Version: 1.0
References: <22d045f858ff5e9b4daddb410540be94@tiscali.it>
 <CALLqZ8TGTWVBj=VoZSVXizQPWLevYVCBr6R6gBf0TBtZui0kvg@mail.gmail.com>
 <c6eea2e7c5c83292853a70c76a951cfe@tiscali.it>
 <CALLqZ8QOZS9mJBsFcU6uZWVDOHXhC4QsYLstb7hxFOg1wf3C7w@mail.gmail.com>
 <6bab10316f0b227ba253558b1ea667e4@tiscali.it>
In-Reply-To: <6bab10316f0b227ba253558b1ea667e4@tiscali.it>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 28 Jun 2021 08:17:19 -0400
Message-ID: <CALLqZ8SxnNhZu0T3d=4KPCre=eNCWxed3GN2AifMjbH2XLYa=g@mail.gmail.com>
Subject: Re: Raspberry pi 4 second monitor problem on xeno3
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
To: 77dab@tiscali.it
Cc: xenomai@xenomai.org

On Mon, Jun 28, 2021 at 8:12 AM davide via Xenomai <xenomai@xenomai.org>
wrote:

>
> kernel comes from here:
> https://github.com/thanhtam-h/rpi4-xeno3
>
> One thing: even if desktop isn't extended to the second screen, and
> xrandr sees only a 'default' screen
> if I give:
>
> cat /dev/random >
> /dev/fb1
> the second screen gets filled..
> it sounds odd to me, because
> that means framebuffer is open and working.
> So, what's going on here?
>
> Il 28.06.2021 13:33 Greg Gallagher ha scritto:
>
> > It's possible the
> drivers aren't working in the kernel without ipipe, you'll want to
> confirm that first. If you didn't compile the kernel yourself you'll
> want to find the sources so you can debug..
> > Greg
>
>
>
> Con Tiscali Mobile Smart 70 hai 70 GB in 4G, minuti illimitati e 100 SMS =
a
> soli 7,99=E2=82=AC al mese http://tisca.li/Smart70
>

This doesn=E2=80=99t sound like a xenomai or ipipe issue, you=E2=80=99ll ha=
ve to do some
further debug and see if this issue is being caused by the ipipe or
xenomai.  Right now what you have described doesn=E2=80=99t sound like an i=
ssue
with the real-time core.

Greg

>
>
