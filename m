References: <CAK6DXL3Qj9XoO0qGkssJcyyvr26LX07yLyCCQTJy-i+ruXxJ4A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Listing real-time processes
In-reply-to: <CAK6DXL3Qj9XoO0qGkssJcyyvr26LX07yLyCCQTJy-i+ruXxJ4A@mail.gmail.com>
Date: Wed, 28 Apr 2021 09:20:58 +0200
Message-ID: <87tunq3med.fsf@xenomai.org>
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
> is there anyone who knows if in Xenomai 3 there a way to list all real-time
> tasks ( from shell, such top e.g.) and to list all groups for sched_quota?
> Thanks for helping,
> best regards

Check /proc/xenomai/sched/*.

-- 
Philippe.

