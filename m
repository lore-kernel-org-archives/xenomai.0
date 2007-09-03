Message-ID: <2ff1a98a0709030832m77661616qfb36eff16b0115b@domain.hid>
Date: Mon, 3 Sep 2007 17:32:00 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46DC2484.6040004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46DC2484.6040004@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] VxWorks semaphore usage demo
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: xenomai@xenomai.org

On 9/3/07, Ravid Baruch Naali <ravidbn@domain.hid> wrote:
> Hello again,

Hi,

>
>
> I'm not sure what is the preferred way to commit my changes, so before I
> commit i'm Attaching my patch in order to get you remarks and further
> instructions

The synchronization on tasks completion with the semID semaphore seems
broken. The main thread will get the semahore when the first task
completes, not when all the tasks complete.

I see too many comments, for instance:
// Checking for failures
if (error == ERROR)

is useless, it is pretty obvious from reading the code that you are
checking for failure. Comments should tell us things that are not
obvious.

Now, about the style, this is C code, so use C style comments. I would
also prefer that you use the kernel coding style, but this is not
kernel code, so I am not sure the rule is to use the kernel coding
style.
-- 
                                               Gilles Chanteperdrix

