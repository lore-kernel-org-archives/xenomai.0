Message-ID: <4891CA7B.60204@domain.hid>
Date: Thu, 31 Jul 2008 16:21:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hi,
>  
> I am transferring data from the Xenomai domain to the 2nd domain with
> the xenomai pipe.  In the 2nd domain I am using the epoll interface to
> wait for the arrival of new data.  The first time that data are written
> in the pipe at the Xenomai side, the 2nd domain receives the EPOLLIN (an
> that's OK).  But the 2nd time data are written in the pipe at the
> Xenomai side, the 2nd domain is NOT receiving EPOLLIN and therefore dies
> forever.
>

Actually, the xnpipe_poll logic is flawed. More later,

> I am not familiar at all with the Xenomai internals, but I tried to
> gather some information: it look like when the first characters are
> written at the Xenomai side, the xnpipe_wakeup_proc calls
> xnpipe_dequeue_wait and this way it is removed forever from the
> waiters-queue.
> When I remove the "else"-instruction in xnpipe_poll so that
> xnpipe_wakeup_proc is called un-conditionally, then it works as expected
> ... however I have no idea if this patch is correct.  So please comment.
>  
> FYI:
> URL: http://svn.gna.org/svn/xenomai/trunk
> Repository Root: http://svn.gna.org/svn/xenomai
> Repository UUID: c6d672ea-8702-0410-b560-f74c916a59fe
> Revision: 4047
>  
> Best regards,
> Filip
>  
>  
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

