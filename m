MIME-Version: 1.0
References: <1175-5f86ba00-b9-25a5a500@198941922>
 <f64b59e3-b141-4309-7779-a8a99e16eb98@siemens.com>
In-Reply-To: <f64b59e3-b141-4309-7779-a8a99e16eb98@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 14 Oct 2020 10:16:49 -0400
Message-ID: <CALLqZ8RMbYDFnQy5gV7-vSi_v9rUPx9i3XJ4ym7JQ-+x64q+3Q@mail.gmail.com>
Subject: Re: Strange switching [threadname] to secondary mode after exception
 #0 in kernel-space at 0x80272444
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
> > Anybody can help on this ?
> >
>
> I'm unfortunately not familiar with the armv7 details of copy-from-user,
> not too speak of how spectre contributed to it. Greg, Philippe, did you
> come across this already?
>
> Jan
>
I'll take a look tonight but I haven't hit this in my testing.  This
was found on 4.4? Have you tried the 4.19 kernels?

-Greg

