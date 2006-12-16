Message-ID: <45842874.6080103@domain.hid>
Date: Sat, 16 Dec 2006 18:10:12 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user space interrupt
References: <279913.29791.qm@domain.hid>
In-Reply-To: <279913.29791.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

mani bhatti wrote:
> Hi all
> i am trying to access parallel port form a user space task.i have copied 
> code from an example which runs parallel port in interrupt mode but the 
> problem is that when i run program i get following message
> 
> "iopl err"
> 
> due to this piece of  code
>        
> // ask for permission to access the parallel port from user-space
>         if (iopl(3)) {
>                 printf("iopl err\n");
>                 exit(1);
>         }
> 

Have a look here:
http://www.captain.at/xenomai-parallel-port-interrupt.php

Ciao,
Hannes.


