Message-ID: <53624421.8090903@xenomai.org>
Date: Thu, 01 May 2014 14:54:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398944548.9186.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1398944548.9186.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue in __threadobj_unlock_sched (forge/mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/01/2014 01:42 PM, Matthias Schneider wrote:
> Hi all,
>
> it seems __threadobj_unlock_sched has a slight bug
> and does not reset the current->policy value.
> This leads to the old policy being restored, but
> no longer being available for the next
> __threadobj_lock_sched / __threadobj_unlock_sched
> call pair.
>

That would mean that the client code switches between different 
scheduling policies while holding the scheduler lock?

-- 
Philippe.

