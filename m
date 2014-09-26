Message-ID: <54256C35.2060404@xenomai.org>
Date: Fri, 26 Sep 2014 15:37:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAC66z95hCikALdDS5s=s=9GDxGmMMg-YfH98yUjiuWb54X6ZVg@mail.gmail.com>
In-Reply-To: <CAC66z95hCikALdDS5s=s=9GDxGmMMg-YfH98yUjiuWb54X6ZVg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] GPL issue for kernel module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>, xenomai@xenomai.org

On 09/26/2014 02:51 PM, yogesh garg wrote:
> Hi Everyone,
> 
> I am trying to use xenomai to create my kernel module.
> But when I am trying to compile my module under Non GPL license,
> compiler is throwing error for macros which are export as
> EXPORT_SYMBHOL_GPL.
> My doubt is, it is mandatory for kernel module, which is using Xenomai
> skins,
> to build as GPL license ?
> 

The kernel code implementing Xenomai is covered by the licensing terms
of the Linux kernel, nothing more, nothing less. As a matter of fact,
this code has to know about the kernel internals to operate, and has
been implemented for running as part of the Linux kernel since day one.
In short: the kernel code implementing core Xenomai services is
definitely a derived work of the Linux kernel, the same way the I-pipe
patch it uses is also a derived work.

Implementing your application in kernel space is clearly a very, very
bad idea, really (no fault recovery, fairly hostile programming
environment, licensing issues for 3rd parties, potential kernel
corruption by application, kernel bloat etc). These kernel APIs are gone
in Xenomai 3.x for these reasons.

Moving your apps to userland would solve your licensing issue, and many
more.

-- 
Philippe.

