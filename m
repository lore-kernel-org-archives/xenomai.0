Message-ID: <44C6865A.9010403@domain.hid>
Date: Tue, 25 Jul 2006 23:00:10 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How can I now when it will be next periodic task
	release point?
References: <200607251735.35500.lbocseg@domain.hid>
In-Reply-To: <200607251735.35500.lbocseg@domain.hid>
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Ciao Rodrigo!

Rodrigo Rosenfeld Rosas wrote:
> I want to capture and process images each 300 ms. The processing routines take 
> a (fixed, but unknown) time. I'd like to request a new image about 50 ms 
> before next release point, like this:
> 
> for(;;)
> {
> 	rt_task_wait_period(NULL);
> 	ProcessImage();
> 	rt_task_sleep(XXX); // until 50 ms before next release point
> 	RequestNewImage();
> }
> 
> I could use rt_task_inquire() if RT_TASK_INFO was documented. From 
> source-code:
>   RTIME relpoint;             /* !< Periodic release point. */
> 
> The question is which release point? Next or the last reached?
> Anyway, a new function like rt_task_getnextrelpoint() would be very welcome...
> 
> rt_task_sleep(rt_task_getnextrelpoint() - 50*1000*1000);

Just trying to understand your problem:
If you wanna capture a image every 300ms, the processing must not take
longer than 300ms, otherwise you have some kind over overrun (?)
So you capture an image, process it within 300ms and then capture
the next one, right ?

OK, wait a sec. I think I got it.
I guess your problem is having both capturing and processing in one loop ?
Why not make 2 threads, one for capturing, and one for processing ?

I may be totally wrong - just trying to understand and maybe help :-)

Best regards,
Hannes.

PS.: Why do all replies go only to the sender ? This hasn't been that
way in the (far) past, right ?



