Subject: Re: [RFC] simplify wait_for_rcu_grace_period
References: <1498b3cc-767f-703c-116b-ae102be3e510@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9555bd80-150f-19d2-ddac-d92ac01b0ac1@xenomai.org>
Date: Mon, 3 Feb 2020 19:51:49 +0100
MIME-Version: 1.0
In-Reply-To: <1498b3cc-767f-703c-116b-ae102be3e510@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 1/31/20 9:43 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> any reason why you didn't use synchronize_rcu for 
> wait_for_rcu_grace_period back then?
>

Likely because because we might observe multiple grace periods between
the moment joinee->exited is posted and the joinee eventually schedules out.

> 
> 
> I'm currently debugging a hanging xnthread_join in 
> wait_for_rcu_grace_period and stumbled over this (both variants hang 
> equally well, though).
> 
I'm not entirely surprised. Fully relying on RCU for this was more of a
work around to address the module unload issue rather than a reliable fix.

-- 
Philippe.

