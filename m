Subject: Re: rt_task_shadow() secondary mode
References: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2c2f612c-5a56-0bb7-735c-4d3c4fe13aaa@siemens.com>
Date: Thu, 8 Jul 2021 11:25:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai <xenomai@xenomai.org>

On 08.07.21 11:03, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> An application I'm working on assumes that rt_task_shadow() with prio
> being 0 returns in secondary mode. This seems to be the case on
> Xenomai 2.6 but no longer on 3.1.
> 
> Is this a known/desired change?
> 

The general philosophy of Xenomai is that applications should not rely
on the exact switching behavior. So the question would be why your
application needs one or the other behavior?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

