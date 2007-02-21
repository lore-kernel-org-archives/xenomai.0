Message-ID: <45DC1F14.4030300@domain.hid>
Date: Wed, 21 Feb 2007 11:29:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid> <45DC0939.6070207@domain.hid>
	<45DC0CAA.2050001@domain.hid> <45DC139A.6020302@domain.hid>
	<45DC1773.1080803@domain.hid>
In-Reply-To: <45DC1773.1080803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>>I have to have a closer look at the code. But you are right, since the
>>ppd cannot vanish under our feet, maybe is it possible to call
>>xnshadow_ppd_get without holding the nklock at all. We "only" have to
>>suppose that the lists manipulation routines will never set the list to
>>an inconsistent state.
> 
> 
> As long as process A's ppd can take a place in the same list as process
> B's one, you need locking (or RCU :-/). That's my point about the hash
> chain approach.
> 
> I can only advertise the idea again to maintain the ppd pointers as an
> I-pipe task_struct key. On fork/clone, you just have to make sure that
> the child either gets a copy of the parent's pointer when it will share
> the mm, or its key is NULL'ified, or automatic Xenomai skin binding is
> triggered to generate in a new ppd.

I agree with the idea of the ptd. Nevertheless, I think it is possible
to access an xnqueue in a lockless fashion. Concurrent insertions and
deletions only matter if they take place before (in list order) the
target. When we are walking the list, only the "next" pointers matters.
Now, if we look at the "next" pointers in the insertion routine, we see:

   holder->next = head->next;
   head->next = holder;

So, maybe we just need to add a compiler barrier, but it looks like we
can never see a wrong pointer when walking the list.

-- 
                                                 Gilles Chanteperdrix

