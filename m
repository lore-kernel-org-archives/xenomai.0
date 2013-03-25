MIME-Version: 1.0
In-Reply-To: <CADVgf9=qcKpZKFhtKUMjVxqcRNRoL2hS+PRpCMGg_MLD44ct-g@mail.gmail.com>
References: <CADVgf9=qcKpZKFhtKUMjVxqcRNRoL2hS+PRpCMGg_MLD44ct-g@mail.gmail.com>
Date: Mon, 25 Mar 2013 09:38:16 -0400
Message-ID: <CADVgf9n=KHaipJ6wFz4j8mfvHQq2qZfB6w-0A773OUnsunk=4A@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] next ARM kernel patch ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

> Hi,
>
> You can have a look at the "next" branch in the ipipe-gch git
> repository, it is work in progress, but currently boot on at91, omap3
> and omap4 (cortex A9 SMP, like Zynq). The solution currently used to
> allow the I-pipe working with IRQDOMAINS is not very satisfactory and
> should be improved in next versions.

Note-- sorry about the previous issues with threading/etc. Moving away
from using corporate account/client to send mails from now on.

Looks like this branch also includes Jan's x86 work. Is 3.8.x the
target ipipe branch for x86 as well (or all archs)? We have some code
that needs to run on both types of platform, so synchronizing the
kernel versions makes things a bit easier.

-Matt

