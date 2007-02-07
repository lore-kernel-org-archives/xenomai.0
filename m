Subject: Re: [Xenomai-core] Found bug in pSOS ev_receive()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1170845844.21675.2.camel@domain.hid>
References: <OFE7CBFD2B.465864F1-ONC125727B.00390D6E@uk.marconicomms.com>
	<1170845844.21675.2.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 12:15:49 +0100
Message-Id: <1170846949.21675.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <Markus.Osterried@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-02-07 at 11:57 +0100, Philippe Gerum wrote:
> On Wed, 2007-02-07 at 11:36 +0100, Markus Osterried wrote:
> > Hello,
> > 
> > in pSOS skin function ev_receive() in file event.c I've found a bug.
> > When  ev_receive() is called with EV_WAIT and an event is received, the
> > task is unblocked and everything is okay, then in this case the copy of the
> > actual received events into *events_r is missing.
> 
> Confirmed and fixed, thanks.
> 
> --- ksrc/skins/psos+/event.c	(revision 2108)
> +++ ksrc/skins/psos+/event.c	(working copy)
> @@ -79,9 +79,10 @@
>  
>  	if (xnthread_test_info(&task->threadbase, XNBREAK))
>  		err = -EINTR;
> -	else if (xnthread_test_info(&task->threadbase, XNTIMEO)) {
> +	else {
>  		*events_r = task->waitargs.evgroup.events;
> -		err = ERR_TIMEOUT;
> +		if (xnthread_test_info(&task->threadbase, XNTIMEO))
> +			err = ERR_TIMEOUT;
>  	}
>  
>        unlock_and_exit:
> 

Actually, there was a second bug hiding in the timeout case, where the
copy back value was wrong, we should have returned the current state of
the event flag group and we returned the pended event mask instead. The
following patch against 2.3.0 fixes both issues.

--- ksrc/skins/psos+/event.c	(revision 2134)
+++ ksrc/skins/psos+/event.c	(working copy)
@@ -80,9 +80,10 @@
 	if (xnthread_test_info(&task->threadbase, XNBREAK))
 		err = -EINTR;
 	else if (xnthread_test_info(&task->threadbase, XNTIMEO)) {
+		err = ERR_TIMEOUT;
+		*events_r = evgroup->events;
+	} else
 		*events_r = task->waitargs.evgroup.events;
-		err = ERR_TIMEOUT;
-	}
 
       unlock_and_exit:
 

-- 
Philippe.



