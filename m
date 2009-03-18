Message-ID: <49C16D55.1080003@domain.hid>
Date: Wed, 18 Mar 2009 22:53:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1237393895.5495.7.camel@domain.hid>
In-Reply-To: <1237393895.5495.7.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash in xnheap_test_and_free
	(native/heap.c)
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
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> I got a kernel crash because inside xnheap_test_and_free a 
> invalid pointer contained in variable 'nextpage' is dereferenced:
>

<snip>

This turned out to be caused by an out-of-bound write triggered by the streaming 
output service.

The patch below fixes the issue; it has been committed to both the maintenance 
(v2.4.x) and development branches.

Sidenote: your test scenario involves echoing some data to /dev/rtp0 for 
triggering the issue; this will now work, but you won't get that input available 
to rt_pipe_read(). In case you wonder why, the reason is that 'echo' will exit 
immediately after sending the bytes, which will cause the user-space side of the 
channel to be closed, and the input queue (the one that goes user -> kernel) to 
be flushed from any pending data.

--- ksrc/skins/native/pipe.c	(revision 4712)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -110,6 +110,7 @@
  		/* Reset the streaming buffer. */
  		xnlock_get_irqsave(&nklock, s);
  		pipe->fillsz = 0;
+		xnpipe_m_size(pipe->buffer) = 0;
  		__clear_bit(P_SYNCWAIT, &pipe->status);
  		__clear_bit(P_ATOMIC, &pipe->status);
  		xnlock_put_irqrestore(&nklock, s);
@@ -284,8 +285,8 @@
  				       NULL);
  		return -ENOMEM;
  	}
-	inith(&pipe->buffer->link);
-	pipe->buffer->size = streamsz - sizeof(RT_PIPE_MSG);
+	inith(xnpipe_m_link(pipe->buffer));
+	xnpipe_m_size(pipe->buffer) = streamsz - sizeof(RT_PIPE_MSG);
  #endif /* CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ > 0 */

  	ops.output = NULL;
@@ -881,8 +882,10 @@
  		goto unlock_and_exit;
  	}

-	if (size > CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ - pipe->fillsz)
-		outbytes = CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ - pipe->fillsz;
+	if (size > CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ
+	    - sizeof(RT_PIPE_MSG) - pipe->fillsz)
+		outbytes = CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ
+			- sizeof(RT_PIPE_MSG) - pipe->fillsz;
  	else
  		outbytes = size;


-- 
Philippe.

