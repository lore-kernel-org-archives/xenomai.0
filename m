References: <87mtexkcxf.fsf@xenomai.org>
 <9d47b5f3-b18e-0f75-9753-fefec5e9bdd7@siemens.com>
 <87bkvcirgs.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC] Rust API for evl
Date: Sun, 05 Jun 2022 16:49:24 +0200
In-reply-to: <87bkvcirgs.fsf@xenomai.org>
Message-ID: <87a6arximj.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Harald Seiler <hws@denx.de>


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> Do you have some
>> example code somewhere as well?
>>
>
> Not yet. I have started working on the 'revl' crate implementing the EVL
> interface for the Rust language though. There is not much of it yet
> (clock services based on the 'embedded_time' crate, little
> thread-related support, sema4 and basic mutex), but I'll push what is
> there in a couple of days to a public repo.

The first bits of the revl API have landed at [1]. This work is a
starting point, a tentative implementation of a limited set of features
ATM, which should be considered as RFC material.

[1] https://source.denx.de/Xenomai/xenomai4/revl.git

-- 
Philippe.

