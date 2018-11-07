MIME-Version: 1.0
References: <CAPNo5QJdOpN8cztKGNZjifmP-Bx4wRyOq0XAw7HM1UQ+Op5E3Q@mail.gmail.com>
 <69c8bfc1-f7d5-b935-6db1-99d496a80dc7@siemens.com>
In-Reply-To: <69c8bfc1-f7d5-b935-6db1-99d496a80dc7@siemens.com>
From: Manikanta Mylavarapu <mylavarapumanikanta23@gmail.com>
Date: Wed, 7 Nov 2018 12:36:20 +0530
Message-ID: <CAPNo5QJ4WHKnajbYB-RF9CqX8ZtF2Mss6FRNubjYECwh_wmUjg@mail.gmail.com>
Subject: Re: 32bit on 64bit in xenomai 2.6.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Thank you Jan.

For my project requirement I am working with xenomai 2.6.0 on fedora 13.

My doubt is at least sample app compiled as a 32bit exe on 64bit kernel
should work. But it is not running on xenomai patched 64bit os,why?

On Wed, Nov 7, 2018, 12:13 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 07.11.18 07:15, Manikanta Mylavarapu via Xenomai wrote:
> > Dear all,
> >
> > I am trying to run 32bit applications on 64bit xenomai. I installed
> xenomai
> > 2.6.0 on fedora 13 x86_64. I installed all 32bit GCC lib & c librarys
> > (glibc-devel.i686 & going.i686).
> >
> > I made one hello world sample (non-rt) app, it is giving error while
> running
> >  "-bash: ./a.out: cannot execute binary file" but the same a.out is
> running
> > fine on "plain fedora13 x86_64".
> >
> > My question is on xenomai 2.x can we run 32bit rt & non-rt app on 64bit
> > kernel? Please help me.
> >
>
> Xenomai 2 is EOL, no longer supported. And compat support (32-on-64 bit)
> has
> only be added to Xenomai 3. So you should migrate to the current stable
> version.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
