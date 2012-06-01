Message-ID: <4FC8FBD0.3020206@siemens.com>
Date: Fri, 01 Jun 2012 19:28:48 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <4FC8F8EE.4010901@xenomai.org>
In-Reply-To: <4FC8F8EE.4010901@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86_32 mayday
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2012-06-01 19:16, Gilles Chanteperdrix wrote:
> 
> Hi,
> 
> with the current tip of xenomai 2.6 branch, the "sigdebug" test testing
> the "mayday" code ends up with a segfault on x86_32. I tried to have a
> look at it, but could not really understand what happens: the register
> on return from the syscall are ok, but the segfault happens after return
> from the signal handler, when returning from the interrupted function.
> It looks like either ebp, or the function return adress are wrong.
> 
> If anyone wants to have a look at it... Jan maybe?

Can't promise, but will try to find a slot.

I think I didn't test on x86-32 so far. Is this a regression or did you
run the test for the first time as well?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

