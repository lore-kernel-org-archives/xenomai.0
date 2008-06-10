Message-ID: <484E8D0E.10606@domain.hid>
Date: Tue, 10 Jun 2008 16:17:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D470A4D@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D470A4D@slcmail.slc.mew.int>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] native queue and timeout
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
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Hello all. I grabbed svn 3956 and am having a slight problem with 2.6.25.6.
> 
>  
> 
> I spawn a native thread that does the following:
> 
>  
> 
>         int res;
> 
>        
> 
>         printf("reading..\n");
> 
>         res = rt_queue_read(&ql, &level_data, sizeof(unsigned long int),
> TM_INFINITE);
> 
>         printf("done?\n");
> 
>         if(res!=sizeof(unsigned long int)) {
> 
>             rtlog(RTLOG_LEVEL_EMERG, "level thread went wrong. retval
> %d", res);
> 
>             abort();
> 
>         }
> 
>  
> 
> The queue “ql” is bound to successfully. The queue is created in another
> userspace application. My binding code looks like this:
> 
>  
> 
>     if(rt_queue_bind(&ql, "rtlog level", TM_NONBLOCK)) {
> 
>         fprintf(stderr, "failed to bind to rtlog level queue -- is
> rtlogd running?\n");
> 
>         abort();
> 
>     }
> 
>  
> 
> “ql” is: RT_QUEUE ql;
> 
>  
> 
> Now, in the native thread, the call to rt_queue_read always returns with
> -ETIMEDOUT  (-110) which makes no sense because I am passing
> TM_INFINITE. I made sure my include files were up to date.
> 

If running the trunk/, then you need to fully rebuild the Xenomai userland libs
as well; the ABI has changed in that area.

>  
> 
> Any idea?
> 
>  
> 
> Thanks,
> 
> Steven
> 
>  
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

