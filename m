Message-ID: <501B9009.2040406@xenomai.org>
Date: Fri, 03 Aug 2012 10:47:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGVaUoE6O+Hi1DwCjfHZne0BD5R0z1ErobrP-CVtz2XgjtQKDg@mail.gmail.com>
In-Reply-To: <CAGVaUoE6O+Hi1DwCjfHZne0BD5R0z1ErobrP-CVtz2XgjtQKDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Link error for the Xenomai 2.6.1
	example	"trivial-periodic.c"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bao Rui <rbaocug@gmail.com>
Cc: xenomai@xenomai.org

On 08/03/2012 10:23 AM, Bao Rui wrote:
> Hi, I am trying to build Xenomai 2.6.1 for ubuntu 12.04 x86 version, after
> patch the ipipe, build new kernel, everything is fine.
> 
> So I start build the Native example:
> trivial-periodic.c<http://git.xenomai.org/?p=xenomai-head.git;a=blob;f=examples/native/trivial-periodic.c;h=d7d8945636d0f029fabca254d9373a3e5aac8551;hb=HEAD>
> 
> 
> But I get following errors:
> undefined reference to `rt_task_create'
> ......
> 
> I checked makefile, I do use the "-lnative", and everything is OK under
> /usr/xenomai(I can run the cyclictest in the xenomai source code).
> 
> I see some one also meet such problem, but no solution for it, could anyone
> can help me on this issue? It is very important to use Native skin.

If you are talking about this post:
http://www.xenomai.org/pipermail/xenomai/2012-July/000528.html

A patch was posted.

Otherwise, if you need help with a compilation command line, post at
least the command line which fails.

-- 
					    Gilles.

