Message-ID: <49BEC535.7000107@domain.hid>
Date: Mon, 16 Mar 2009 22:31:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <004301c9a683$c6b00200$0109220a@domain.hid>
In-Reply-To: <004301c9a683$c6b00200$0109220a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ENXIO error with large shared memory
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
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> I am trying to map a large shared memory buffer and cannot seem to map 32M.
> I get the error code ENXIO back from the posix skin mmap.
> 
> The code works for
>   ftruncate(prgshmfd, 16777216);
>   pPrgShm = mmap(NULL, 16777216, PROT_READ | PROT_WRITE, MAP_SHARED, prgshmfd, 0);
> but fails if I have
>   ftruncate(prgshmfd, 16777216*2);

What if you checked the return value of ftruncate here ?

>   pPrgShm = mmap(NULL, 16777216*2, PROT_READ | PROT_WRITE, MAP_SHARED, prgshmfd, 0);
> 

-- 
					    Gilles.

