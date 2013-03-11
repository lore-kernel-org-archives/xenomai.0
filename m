Message-ID: <513DD683.6020705@xenomai.org>
Date: Mon, 11 Mar 2013 14:05:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20130228094644.5CCB8C91@centrum.cz>,
	<512FB7B0.1040003@xenomai.org>,
	<20130301095437.EB654F58@centrum.cz> <51309A54.7090101@xenomai.org>
	<20130311113513.D17FAEF8@centrum.cz>
In-Reply-To: <20130311113513.D17FAEF8@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutex problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 03/11/2013 11:35 AM, Petr Cervenka wrote:

> The problem with mutexes is still present. I'm really desperate now.
> Does anyone know, how the mutex could "stay locked" when every
> "acquire" is sooner or later followed by "release" and both functions
> always return 0 (success) code? Every advice is appreciated.


Could you provide us with a simple test case which would allow us to
reproduce the problem?

Other than that, you can try forcing the path through the kernel for
every mutex call, enable the I-pipe tracer, and trigger a trace as soon
as you detect that the mutex is not free after a release.


-- 
                                                                Gilles.

