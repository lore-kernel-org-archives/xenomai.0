Message-ID: <50B73F44.9080900@xenomai.org>
Date: Thu, 29 Nov 2012 11:56:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50B73EA7.3070501@thrane.com>
In-Reply-To: <50B73EA7.3070501@thrane.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutex and timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jesper.christensen@cobham.com
Cc: Jesper Christensen <jbc@thrane.com>, xenomai@xenomai.org

On 11/29/2012 11:53 AM, Jesper Christensen wrote:
> Hello
> 
> I was wondering if (and i have a feeling i already know the answer) it
> is a no-go to call rtdm_mutex_lock from a rtdm timer handler? I've just
> discovered that is what we do, and i have a feeling it is causing
> trouble (most of the time it seems to work however).
> 

no go indeed. As soon as the mutex is contented, an attempt is made to
put the caller to sleep, which can't be done over an IRQ context. So the
situation is essentially, a mess.

-- 
Philippe.

