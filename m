Message-ID: <4A845C93.4060302@domain.hid>
Date: Thu, 13 Aug 2009 20:33:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1250186541.23699.8.camel@domain.hid>
In-Reply-To: <1250186541.23699.8.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Resource
	temporarily	unavailable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Henry Bausley wrote:
> We are using 2.6.28.8 and xenomai 2.4.7 on a AMCC PowerPC 460EX platform
> and getting 
> the following message.
> 
> Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
> unavailable
> 
> 
> It takes quite a while for this to happen.  The /proc/xenomai/heap value
> for used keeps increasing.
> Once the "used" gets very close to "size" the user space xenomai
> applications can no longer run. 
> I have isolated the problem to opening and closing shared memory areas.
> 
> 
>   shmfd = shm_open(RTL_SHM_NAME, O_CREAT | O_RDWR, 0777);
>   if (shmfd == -1) {
>     printf("Gp Share mem Open, Err: %d Msg: (%s)\n", errno,
> strerror(errno));
>     return -1;
>   }
>   ftruncate(shmfd,MAKE_PAGESIZE(sizeof(struct SHM)));
> 
>   pshm = mmap(NULL,MAKE_PAGESIZE(sizeof(struct SHM)),PROT_READ |
> PROT_WRITE,MAP_SHARED, shmfd,0);
> 
>   munmap(pshm, MAKE_PAGESIZE(sizeof(struct SHM)));
>   close(shmfd);
>   shm_unlink(RTL_SHM_NAME);
> 
> 
> The above calls are in a shared library that an applications call.

Well, I am surprised, since I received no answer after trying and help
you with your last issue, I assumed you had stopped using Xenomai shared
memories.

Do you reproduce this issue with Xenomai 2.4.8?

-- 
					    Gilles.

