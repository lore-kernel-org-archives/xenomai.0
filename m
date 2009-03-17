Message-ID: <49BFEABB.5050203@domain.hid>
Date: Tue, 17 Mar 2009 19:23:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <004301c9a683$c6b00200$0109220a@domain.hid>	<004801c9a69a$4a63aaf0$0109220a@domain.hid>
	<49BFBF48.7080102@domain.hid> <49BFCAEB.8080007@domain.hid>
	<001801c9a734$e0c7ac90$0109220a@domain.hid>
In-Reply-To: <001801c9a734$e0c7ac90$0109220a@domain.hid>
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
> The patch makes it work for 32M.  However if I try to go larger ie.48M or 
> 64M I get the following
> 
> 
>   Program buffer: 67108864
>      User buffer: 1048576
>     Table buffer: 1048576
> LookAhead buffer: 16777216
> RT User Program ftruncate No Error
> ------------[ cut here ]------------
> Badness at c00b6a94 [verbose debug info unavailable]

Please compile the kernel with more debug options so thatwe know exactly
where this badness happens.

-- 
                                                 Gilles.

