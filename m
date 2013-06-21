Message-ID: <51C486F6.6010701@xenomai.org>
Date: Fri, 21 Jun 2013 19:01:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
	<0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1732@EXDAG0-B0.intra.cea.fr>
	<41d414a76f40aa6f246bc60d89a11394.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1920@EXDAG0-B0.intra.cea.fr>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD1920@EXDAG0-B0.intra.cea.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/21/2013 09:31 AM, HAUTBOIS Flavian wrote:

> Seems like the problem stems from XENOMAI_SKINCALL3, but this macro is pretty hard to figure out...


Hi,

No, the macro simply emits the syscall, the fact that the syscall
switches to secondary mode, or something else is the problem.

Please separate this in two steps:
ret = XENOMAI_SKINCALL3...
then
set_errno(ret)

check the value of ret
and see what causes the signal to be sent (either the syscall, or
set_ernno).

Regards.

P.S: could you stop top-posting?

-- 
                                                                Gilles.

