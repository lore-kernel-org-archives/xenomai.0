Message-ID: <457997E5.7010206@domain.hid>
Date: Fri, 08 Dec 2006 17:50:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user space interrupt
References: <279913.29791.qm@domain.hid>
In-Reply-To: <279913.29791.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
> 
> i am working with interrupts for the first time and have no idea why
> this is happening .i am attaching the code also.Thanks all for the great
> help.

What is the error message if you replace printf("iopl err\n") with
perror("iopl") ?

-- 
                                                 Gilles Chanteperdrix

