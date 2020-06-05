Subject: Re: Questions about XDDP.
References: <CAAvDm6bG5sKj_4qpEJX5eP3M32b2YqMymTok3w9xFZwrBAFO+g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5c157f97-5f9d-a975-b37f-846d2ce9f3b3@siemens.com>
Date: Fri, 5 Jun 2020 17:35:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bG5sKj_4qpEJX5eP3M32b2YqMymTok3w9xFZwrBAFO+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 04.06.20 16:14, 孙世龙 via Xenomai wrote:
> As per the documentation
> (
> *https://xenomai.org/documentation/xenomai-3/html/xeno3prm/
> <https://xenomai.org/documentation/xenomai-3/html/xeno3prm/>group__trank.html#details*),i
> can draw the conclusion that
> the non real-time side could block upon attempt to open the
> special device file until the corresponding one is opened
> from a Xenomai thread,unless *O_NONBLOCK *was given to the
> open(2) system call.Could you tell the reasons lie behind?
> Why does the non real-time side need to be blocked while the
> corresponding one has not been opened from a Xenomai thread?
> 

That is a valid question. The simple answer is: It's like that since at
least 2005, likely longer.

Without looking into the details, I would say it should be doable also
differently, likely not trivially, but no one requested a change so far.

> 
> 
> *In addition, I found that it could returned immediately indeed if the non
> real-time side is opened(2) with O_NONBLOCK as described in the
> documentation, but it also returned the errorwhich says:"open rtp0 returned
> error: Resource temporarily unavailable".*

EAGAIN, that is a the normal return code of a POSIX service that would
block but was told to not do that.

> I do this experiment on Ubuntu16.04(kernel 4.19.84 + xenomai3.1).
> The related code is listed below.I thought over and over, but i
> can not understand it.
> I would be grateful to have some help with this question.
> 
> One more unimportant question,through some tests, I found that *XDD*
> could not be used to communicate between two linux threads .
> Am i right?

Correct. One peer is always a Xenomai thread using the real-time API to
access the XDDP channel.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

