Message-ID: <4C193692.2080309@domain.hid>
Date: Wed, 16 Jun 2010 22:39:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F4801384570@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801384570@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared memory and fstat()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> Hello,
> 
> Can a file descriptor returned from Xenomai POSIX skin
> shm_open()/ftruncate() used in fstat()?

No.

> 
> Value returned for st_size in the stat structure is
> always 0 despite change of size using ftruncate().
> 
> Noticed that shared memory object does not have an entry
> on /dev/shm as regular POSIX objects. Where is it located?
> If entry exists, can it be used to query its size?

No, xenomai posix skin shared memory do not exist as filesystem objects,
they will only be listed in /proc/xenomai/heap.

Note, however, that they are only useful for sharing memory between
kernel-space posix applications and user-space posix applications, which
should have become rare these days. If what you are looking for is
simply a way for sharing memory between to user-space real-time
applications, they you can use linux regular shared memories, for which
fstat works.

> 
> Thanks,
> Luis
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
					    Gilles.

