Message-ID: <43FA16A2.9030807@domain.hid>
Date: Mon, 20 Feb 2006 20:21:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] binding to memory heap from user space
References: <20060220145625.46347.qmail@domain.hid>
In-Reply-To: <20060220145625.46347.qmail@domain.hid>
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
To: Cedric Herreman <glocker50@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Cedric Herreman wrote:
> */Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>/* wrote:
> 
>     Cedric Herreman wrote:
>      > Hello,
>      >
>      > I have created a memory heap in the init_module routine of a
>     kernel module :
>      >
>     rt_heap_create(&heap_data,"RT_LOG_HEAP",sizeof(ttv_log_data),H_FIFO|H_SHARED);
>      > and
>      > rt_heap_alloc(&heap_data,0,TM_NONBLOCK,&loc_ptr);
>      > Both calls return succesful.
>      >
>      > When i try to bind to this memory in an user space application :
>      > rt_heap_bind(&rt_heap,"RT_LOG_HEAP",TM_NONBLOCK);
>      > the call returns with error -2, this error does not seem to be
>     documented (i test on all the constants defined in the html API
>     docs, xenomai v2.0).
>      >
>      > Can anyone give me a hint on what's wrong here ?
> 
>     -2 is -ENOENT, no such file or directory.
> 
>     You are probably missing the /dev/rtheap file. In order to create it,
>     run "make devices" with root privileges.
> 
>     Gilles Chanteperdrix.
> 
> Yes, i was. I added the file on the target system (doesn't have the src 
> tree, so i can't "run make devices")  like this :
> mknod /dev/rtheap b 1 0

mknod /dev/rtheap c 10 254

> 
> Now, it is giving me the error : -EPERM. The doc says the call is made 
> from a context that cannot sleep (interrupt, non-realtime, scheduler 
> locked). Is it not possible to link to shared mem from a non-realtime 
> userspace application in this way ?
> 
> Cedric.
> 
> ------------------------------------------------------------------------
> Brings words and photos together (easily) with
> PhotoMail 
> <http://us.rd.yahoo.com/mail_us/taglines/PMall/*http://photomail.mail.yahoo.com> 
> - it's free and works with Yahoo! Mail.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

