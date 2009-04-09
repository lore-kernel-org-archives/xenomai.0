Message-ID: <49DDBEF4.7@domain.hid>
Date: Thu, 09 Apr 2009 11:25:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1E6B62F8-3C13-425C-A2E3-652E2FB0D6DE@comcast.net>
In-Reply-To: <1E6B62F8-3C13-425C-A2E3-652E2FB0D6DE@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] native syscalls
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Can xenomai preempt its own system calls? We ran latency with our  
> app.  We had a thread waiting on a cond, and when we signaled that  
> cond, the latency jumped from ~70us to almost 400us even though  
> latency runs a higher priority thread than the thread that we wake up.  
> Is there interrupt disabling that accounts for this?
> 
> Here are the results as taken by Mark S.

As I told you in a voluntarily detailed private mail, only the traces
made by the I-pipe tracer are of any interest for us.

-- 
                                                 Gilles.

