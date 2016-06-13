References: <d8ab0bd9-b115-7c0e-1234-6e2ea8c35982@peak-system.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2d2ef67a-a82d-5017-2928-98210d67eacd@xenomai.org>
Date: Mon, 13 Jun 2016 15:21:29 +0200
MIME-Version: 1.0
In-Reply-To: <d8ab0bd9-b115-7c0e-1234-6e2ea8c35982@peak-system.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux RT driver migrating to 3.0...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Xenomai@xenomai.org

On 06/13/2016 03:14 PM, Stephane Grosjean wrote:
> Hi!
> 
> Successfully running for years a Xenomai 2.6.x RT driver under some
> dual-kernel Linux versions, we'd like to migrate it to Xenomai 3.x.
> 
> First step consisting in compiling the driver is over, time has come to
> test it.
> 
> Everything looks like the rtm_mutex_lock() locks the entire system when
> running a Xenomai 3.x cobalt Linux, while it doesn't with 2.6.x: in
> fact, in some particular cases, this rtdm_mutex_lock() might be called
> from the "init_module()", so I'm afraid that the calling task isn't a RT
> one, but a Linux regular one, isn't it? So maybe it's actually the
> reason why...
> 

It is.

> But, in that case, why such a call was not a problem with Xenomai 2.6.x?

Because that mutex was not contended at the time of the call. You should
also check for a lack of initialization of that mutex, causing the code
to fail gracefully instead of panicking. Did you check the return code
of rtdm_mutex_lock() in 2.6.x ?

-- 
Philippe.

