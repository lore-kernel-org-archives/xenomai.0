Message-ID: <48D50096.9000103@domain.hid>
Date: Sat, 20 Sep 2008 15:54:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200808251743.26012@domain.hid>
	<200809151504.491@domain.hid>	<48CE9B69.8010604@domain.hid>
	<200809201119.02149.paul_c@domain.hid>
In-Reply-To: <200809201119.02149.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Philippe
> 
> On Monday 15 September 2008, Philippe Gerum wrote:
>> Petr Cervenka wrote:
>>> I tried the patch on xenomai 2.4.5. After a couple of my long run tests I
>>> have found no errors. So I am very satisfied with it ;-)
>> Ok, thanks. I'm queuing this patch for commit to both branches then.
> 
> It would appear that the patch is missing changes in a couple of spots that is 
> causing kernel compiles to break - Assuming the secord arg to 
> xnheap_destroy_mapped is NULL, the attached (trivial) patch addresses the 
> problem in TRUNK.
>

Applied, thanks.

> 
> Regards, Paul.
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


