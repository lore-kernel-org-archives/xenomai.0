Date: Wed, 10 Dec 2014 17:23:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210162340.GK1524@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC9123428F9E0E@SMExchange01.siebmeyer.org>
 <20141210143114.GJ1524@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141210143114.GJ1524@hermes.click-hack.org>
Subject: Re: [Xenomai] CPU time limit exceeded SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Dec 10, 2014 at 03:31:14PM +0100, Gilles Chanteperdrix wrote:
> On Wed, Dec 10, 2014 at 02:22:10PM +0000, Hänel-Baas, Alexander wrote:
> > Hi,
> > 
> > i get the message "CPU time limit exceeded"  when my main thread is starting.
> > 
> > The thread mod Bit "T_WARNSW" is not set.
> > ulimit -a shows cpu time is unlimited.
> > 
> > Now I installed the sigdebug handler and get the message:
> > 
> > SIGDEBUG received, reason 7<unknown>
> > 
> > My question is: why is the reason value 7? These value has only max 6 entries?
> 
> No, it has 7. See:
> 
> https://git.xenomai.org/xenomai-2.6.git/tree/include/asm-generic/syscall.h?id=v2.6.4#n56

Value 7 means that your application either is doing bad things while
holding a mutex (such as switching scheduling policy from or to
SCHED_OTHER), or that there is some other unknown issue. So, it
would help if you could reduce your test program to a self-contained
test case which we can run to reproduce the issue.

-- 
					    Gilles.

