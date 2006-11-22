Subject: Re: Re: [Xenomai-help] What returns rt_task_self in
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <29258254.1164204998593.JavaMail.ngmail@domain.hid>
References: <1164204035.5006.305.camel@domain.hid>
	<20403318.1164195534169.JavaMail.ngmail@domain.hid>
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>
	<45644D39.10007@domain.hid>
	<29258254.1164204998593.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 15:49:58 +0100
Message-Id: <1164206998.5006.343.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Wed, 2006-11-22 at 15:16 +0100, M. Koehrer wrote:

> The main use case for this is that some user specific, task related data
> has to be stored. One pointer should be sufficient.
> I think, an approach that uses the Xenomai API for that is better than
> to rely on TLS or NPTL as it is unclear if related actions lead to an unwanted syscall.
> 

Think in terms of probability: what's the probability for our own local
TLS implementation to break after we missed some obscure glibc change VS
the probability for the glibc to suddently emit syscalls for
pthread_getspecific()? Because #1 is much more likely than #2, we should
rely on the regular TLS. IOW, let's not reinvent the wheel, particularly
if it's square.

> One (very ugly) approach could be to code an address into the name of the task.
> This name could be retrieved via rt_task_inquire()...
> 

Unfortunately, this would make no sense when multiple address spaces are
involved (kernel/user-space, different processes). This is why
descriptors should be seen as containers for handles, that eventually
point at some objects.

> Mathias
> 
-- 
Philippe.



