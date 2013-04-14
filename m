Message-ID: <516AE908.6020203@xenomai.org>
Date: Sun, 14 Apr 2013 19:36:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1365959460.11897.YahooMailNeo@web161406.mail.bf1.yahoo.com>
In-Reply-To: <1365959460.11897.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] how to suppress "CPU time limit exceeded" message?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2013 07:11 PM, Tom Z wrote:

> Hi All, I encountered frequently "CPU time limit exceeded" messages
> during my program's execution. I think it might be related to the
> Xenomai watchdog (Please correct me if wrong).


See examples/sigdebug.c, there are many possible reasons for this message.

> Is there a way to
> disable this feature without recompiling a new kernel without
> watchdog support?


There is currently no way to disable it. You can increase its timeout
with the xeno_nucleus.watchdog_timeout kernel parameter though.

Note that if your application gets killed by the watchdog, it means that
it uses the CPU for 4 seconds without relinquishing it, an application
doing that is consider a problem with Xenomai, because you are never
sure that Linux can recover from being interrupted 4 seconds, and having
to handle the backlog: generally, it causes the system to crash, purely
and simply. So, the watchdog avoid crashes.


-- 
                                                                Gilles.

