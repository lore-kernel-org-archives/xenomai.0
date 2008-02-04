MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.46456.373177.86014@domain.hid>
Date: Mon, 4 Feb 2008 07:49:28 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768BC@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
	<18342.13282.822800.458093@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3768BC@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
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
 > I will try to figure out a way to make this a small self contained test.
 > However, my debugger shows a thread waiting in pthread_join() while the
 > thread to be disposed is still in rt_queue_read().
 > 
 > PTHREAD_CANCEL_ASYNCHRONOUS is kind of dangerous. Why does
 > rt_task_shadow() do this? It seems the better approach is to let
 > cancellation be handled on the secondary domain side of things, and let
 > the shadow stuff clean up on its own.

PTHREAD_CANCEL_ASYNCHRONOUS is the way glibc makes a blocking call a
cancellation point. And internally, the glibc uses a signal in this
case. When running with Xenomai, the signal sent upon pthread_cancel
will cause the target thread to switch to secondary mode and run its
clean-ups from there. So, the exit should be clean when using this
approach.

Now about your problems, are you fiddling with signals ? Like blocking
them, or doing things in signal handlers ?

 > 
 > If I use rt_task_shadow() do I need to use rt_task_delete()?

I do not know about that. I would have expected rt_task_delete to work
with a task shadowed with rt_task_shadow. Especially since
rt_task_delete runs pthread_cancel under the hood.

-- 


					    Gilles Chanteperdrix.

