Message-ID: <4FE7059B.3050901@xenomai.org>
Date: Sun, 24 Jun 2012 14:18:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcYjkF+TWLt6jk3_TpytsnZQ469SbBWQL+LCgy5VhEBLQ@mail.gmail.com>	<4FE6FCED.7040205@xenomai.org>
	<CAKKWdteCgqWJbPkzkaZSS9sX_EU4vB=gkfUtuBNWcnSSRX0DbQ@mail.gmail.com>
In-Reply-To: <CAKKWdteCgqWJbPkzkaZSS9sX_EU4vB=gkfUtuBNWcnSSRX0DbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions about the libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/24/2012 02:11 PM, ali hagigat wrote:
> Much apprecite Mr. chanteperdrix for the reply.
> 
> I am studying the nucleus API and it says many functions can be called
> from a user space task like xntimer_get_date() !!
> 
> It means that you have not yet created any user library for it?

No, the nucleus API only exists in kernel-space. However,
xntimer_get_date for instance may be called when kernel-space code is
run on behalf of a user-space task, this happens when this user-space
task has made a system call.

-- 
                                                                Gilles.

