Message-ID: <53A7F900.4020103@xenomai.org>
Date: Mon, 23 Jun 2014 11:53:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
 <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>,
 <53A4201D.8020507@xenomai.org>
 <39ed57fee9f445d995e8d17a267c2fa0@EX132MBOX1B.de2.local>
In-Reply-To: <39ed57fee9f445d995e8d17a267c2fa0@EX132MBOX1B.de2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Some Information About compilation Xenomai and RT
	Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/23/2014 11:33 AM, Stoidner, Christoph wrote:
> 
> Hi Gilles,
> 
> when a userspace application starts it calls the brk() syscall to
> enlarge it's heap space. In some cases the call leads to an NOMEM
> error in fcse_check_mmap_addr(). Since glibc does not handle NOMEM
> error at this place the a segfault exception appears.
> 
> It seems as this happens when brk() got an address above some limit,
> also when the process at all consumes less than 32MB RAM. E.g.
> busybox shell command "ls" is enough to get the segfault.

Could you test the I-pipe git branch ipipe-3.14, unmodified?

-- 
                                                                Gilles.

