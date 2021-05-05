References: <CAK6DXL3nmdpYJuQV5Dgywf-R7bL8e5U_xNMS2wPPh4V3SGngHw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Sched_quota info
In-reply-to: <CAK6DXL3nmdpYJuQV5Dgywf-R7bL8e5U_xNMS2wPPh4V3SGngHw@mail.gmail.com>
Date: Wed, 05 May 2021 16:20:35 +0200
Message-ID: <874kfhs1n0.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>
Cc: xenomai@xenomai.org


Marco Barletta via Xenomai <xenomai@xenomai.org> writes:

> Hi everyone;
> I started to work with xenomai for my master degree thesis and there was a
> great interest around sched_quota and a possible hierarchical modification
> of it. Anyway we found there are some theoretical problems around
> schedulability and feasibility of task scheduled by sched_quota. Did you
> follow a theoric model to write it or it's just an idea without any
> theoretical result on the back?
> Best regards

The implementation followed a customer specification, I don't know the
theoretical grounds such spec might have been based on though.

-- 
Philippe.

