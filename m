Message-ID: <b647ffbd0612210712w113eb98ag7a32d228f7863e6d@domain.hid>
Date: Thu, 21 Dec 2006 16:12:50 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
In-Reply-To: <458A9E27.3000509@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <458A4DE0.5030005@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<458A67B6.8000207@domain.hid> <458A7185.8070803@domain.hid>
	<b647ffbd0612210450r4e515046v4eb69da0f6c6c0b3@domain.hid>
	<458A8B8A.8060401@domain.hid> <458A9E27.3000509@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 21/12/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
> > Dmitry Adamushko wrote:
> >>p.s. vfork() is a different beast. Here a child is supposed to call
> >>exec*() rigth after fork() so it's allowed to "borrow" parent's
> >>address space (vm_struct -> all vm_area(s)) and the parent is blocked
> >>in the mean time. As a result, no need for copy-on-write.
> >
> >
> > I think to remember that glibc vfork is just fork.
>
> At least, linuxthread's vfork is the same as linuxthread's fork.
>

Well, I'm looking at glibc-2.3 :

1) ./sysdeps/unix/sysv/linux/i386/vfork.S

  - if there is a vfork syscall - it's used, otherwise - fork.

  - If per-arch code doesn't provide an implementation, the generic (
== notmal fork() ) is used.

2) linux (I'm looking at 2.6.12.6) does provide a separate vfork()
(sys_vfork => do_fork() with additional flags CLONE_VFORK | CLONE_VM).

And it looks like it works as it should be in theory (at least briefly
following the CLONE_VFORK logic in do_fork() and knowing that CLONE_VM
is used for threads to share a vm_struct).

Anyway, I was refering to vfork() as it should be in theory in the
context of copy-on-write policy.

Indeed, your remarks make sense. We should know when Markus conducts
the tests suggested by Philippe. Although, the use of fork() in
multi-threaded applications is sometimes tricky. I do remember once I
had a problem but just can't recall any details (just that it was
memory leaks :)


> --
>                                                  Gilles Chanteperdrix

-- 
Best regards,
Dmitry Adamushko

