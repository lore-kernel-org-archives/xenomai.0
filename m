Message-ID: <4FBB7FE1.8060604@xenomai.org>
Date: Tue, 22 May 2012 14:00:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJyzrg8gAmvc3XDDrHzrpXu926pz9FSXwuDrDsSNn3qxUUw@mail.gmail.com>
In-Reply-To: <CAHyVJyzrg8gAmvc3XDDrHzrpXu926pz9FSXwuDrDsSNn3qxUUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help : Xenomai on ODROID-PC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 05/22/2012 06:27 AM, Mohit Jandwani wrote:
> Hey I am a noob in development.I want to install xenomai on Odroid-PC
> which is based on exynos420 and has arm architecture.Now they have a
> page which gives the instructions on how to apply it to new boards on
> arm architecture but its way out of my league.Someone please tell me
> what do I do ?(I am ready to give lots of hours to studying )Just tell
> me what to study to make sense of it.
> 

On xenomai website, click on "Start here", and read the documentation
you find there. Then reading the "Porting I-pipe to new ARM board"
should make more sense. That is the best we can do with regard to
documentation. But if it is not enough for you, we also provide the
sources, which you can read to understand how it works.

Exynos being an SMP architecture, the porting may be a little harder
than what is described in the document. The ARM SMP SOCs we support are
TI OMAP4 and Freescale mx6q, both being cortex-A9 based, they use the
same timer and the same interrupt controller, so, you can look at how
things are done for these two processors.

As I said in another mail, I recommend starting from I-pipe core branch,
which you can find here:
http://git.denx.de/?p=ipipe.git;a=shortlog;h=refs/heads/core-3.2

-- 
                                                                Gilles.

