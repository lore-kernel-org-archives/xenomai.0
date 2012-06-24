MIME-Version: 1.0
In-Reply-To: <4FE6FCED.7040205@xenomai.org>
References: <CAKKWdtcYjkF+TWLt6jk3_TpytsnZQ469SbBWQL+LCgy5VhEBLQ@mail.gmail.com>
	<4FE6FCED.7040205@xenomai.org>
Date: Sun, 24 Jun 2012 16:41:26 +0430
Message-ID: <CAKKWdteCgqWJbPkzkaZSS9sX_EU4vB=gkfUtuBNWcnSSRX0DbQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] questions about the libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Much apprecite Mr. chanteperdrix for the reply.

I am studying the nucleus API and it says many functions can be called
from a user space task like xntimer_get_date() !!

It means that you have not yet created any user library for it?

Regards

On Sun, Jun 24, 2012 at 4:11 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 06/24/2012 12:00 PM, ali hagigat wrote:
>> Is there any library file for POSIX interface?
>
> libpthread_rt.so
>
>> What library contains
>> the nucleus API?
>
> The nucleus API lives in kernel-space, so, there is no user-space
> library for it.
>
>> What is libanalogy.so?
>
> Analogy is a skin containing a set of drivers for analog/digital capture
> devices. libanalogy.so is the user-space side of this skin.
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

