Message-ID: <4F68A133.5090801@domain.hid>
Date: Tue, 20 Mar 2012 16:24:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CB8E17BE.1EE36%glen@domain.hid>
In-Reply-To: <CB8E17BE.1EE36%glen@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: xenomai@xenomai.org

On 03/20/2012 04:17 PM, Glen Wernersbach wrote:
> Don't have a full dev enviroment on my embedded arm. Here is the program.
> Very very basic:
>      close(fd);
> 
> 
> 
> 
> 
>      
>      fd = open("/dev/ttyS4", O_RDWR | O_NOCTTY | O_NDELAY);

Why closing and reopening? Are you sure this does not reset configuration?

>     if (fd == -1) {
>         printf("open /dev/ttyS0 Failed, errno: %d\r\n", errno);
>         return 0;
>     }
>     
>           
>   //write the data to my device which echos them back
>   write(fd, buf, sizeof(buf)-1);

missing return value check.

>   


-- 
					    Gilles.

