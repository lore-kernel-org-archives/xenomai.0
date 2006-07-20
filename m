Message-ID: <44BFBD4B.4020205@domain.hid>
Date: Thu, 20 Jul 2006 19:28:43 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid> <44BE8ECF.2050608@domain.hid>
	<44BEA8FB.5070800@domain.hid>
In-Reply-To: <44BEA8FB.5070800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi Jan!

Jan Kiszka wrote:
[...]
> When you THEN try compiling the driver within the kernel build again,
> does it still work? I bet it will, because this was likely some issue of
> a half-baked kernel. I also re-checked this and noticed no problems
> loading the driver.

I didn't replace the original makefile.
Did you check with 2.4.32 ?

>>     ret = rt_task_wait_period(&overrun);
> 
> ...this call requires primary mode anyway and will take care for a
> switch back.

Aha! Now it makes sense to me!

>>   // we are in secondary mode now
> 
> Why? I suspect this comment is some kind of left-over of older code

Yes.

> (also given the dead variable irq_time above).

Well, I kept this to show how a timestamp can be obtained.
I added a comment.
I also added stuff to my notes page.

Thanks a lot,
Hannes.

