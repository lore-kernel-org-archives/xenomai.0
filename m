MIME-Version: 1.0
References: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
In-Reply-To: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 2 May 2019 10:28:01 -0400
Message-ID: <CALLqZ8QGLU56XY4YDj-QkOKjLp6bGucURc1DASPQ_7GQ-rSd4g@mail.gmail.com>
Subject: Re: [Xenomai] called regular poll() rtdm-socket
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, May 2, 2019 at 10:07 AM Leopold Palomo-Avellaneda via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi,
>
>
> we developed a C++ library that used rtnet with ethercat. It implements a class
> that interchange information between the RT and NON_RT using xddm. It was
> working but now (using POSIX skin) fails and I several (less than 10) and got
> this message.
>
> [Xenomai] platformnode[8324] called regular poll() on /dev/rtdm/[rtdm-socket]
>
> Could you explain me what is it? because I have searched on web and what I found
> I didn't understand well.
>
> Best regards,
>
>
> Leopold
>
>
> --
> --
> Linux User 152692     GPG: 05F4A7A949A2D9AA
> Catalonia
> -------------------------------------
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 833 bytes
> Desc: OpenPGP digital signature
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190502/417a7371/attachment.sig>

>From my understanding, this means you are talking to the RTDM driver
with a non RT thread.  I don't think Xenomai has a poll system call.
Can you check if the thread that is causing this is in the primary
domain?

-Greg

