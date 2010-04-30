Message-ID: <4BDAECA0.8030006@domain.hid>
Date: Fri, 30 Apr 2010 16:43:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>
In-Reply-To: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with porting simple posix application
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leyrit Vincent <sec.leyrit@domain.hid>
Cc: xenomai@xenomai.org

Leyrit Vincent wrote:
> Hello,
> 
> i would like to port a POSIX application on XENOMAI ..

See:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai


> CODE -----------------------------------------------------------------------
> 
> int recursive_method(int cp)
> {
>   struct timeval ta;
>   struct timespec ts_start, ts_end;
> 
>   if(cp < n_recurs)
>     {
>       for(int i=0; i < 10;i++)
>         {
>           clock_gettime(CLOCK_REALTIME,&ts_start);
>           xnprintf("%d\n", ts_start.tv_nsec);

printf here causes a switch to secondary mode.

-- 
					    Gilles.

