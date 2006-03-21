Message-ID: <442029CF.8030709@domain.hid>
Date: Tue, 21 Mar 2006 17:29:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up - SOLVED
References: 00603201434.15258@domain.hid>
	<200603201434.15258@domain.hid>	<441ED657.1080405@domain.hid>
	<200603201901.3123@domain.hid>	<441F3476.1080003@domain.hid>
	<200603211503.22918@domain.hid> <442018FE.3020906@domain.hid>
In-Reply-To: <442018FE.3020906@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Petr Cervenka wrote:
> 
>>The problem was in my calling "RT" task. I forgot to switch the new
>>created task to PRIMARY MODE, because I didn't know it's neccessary.
> 
> 
> As Philippe said, it isn't usually required - with exceptions. Let me
> first sketch the standard situation: You registered a read_rt handler
> with your device, but no read_nrt. If your application now calls
> rt_dev_read (or just read() for the POSIX skin) from the "wrong"
> context, RTDM will detect the missing _nrt handler and trigger an
> automatic switch to primary mode (and vice versa). So, no need for
> manual switching in the standard case.
> 
> But if you had registered handlers for both contexts, RTDM will always
> invoke the one for your current mode.

I wonder if marking the call as "conforming" instead of leaving it to 
the current domain would make such handling more intuitive? RT threads 
would automatically switch to primary before always going to the _rt 
routine, while plain Linux tasks would just go to the _nrt one. Am I 
off-base wrt RTDM's logic here?

  This means your _nrt handler must
> handle this mode correctly! This "sticky" behaviour was invented to
> allow providing services both with and without strict determinism. RT
> handler may allocate required resources from pre-allocated but limited
> pools, NRT handlers are free to use Linux services for this. This is
> used in practice e.g. by the 16550A driver or RTnet.
> 
> It may appear a bit tricky for IOCTL handlers to implement this scheme,
> as the actual service demultiplexing happens inside the handler, and
> there might be some IOCTLs exclusively for RT and some only for NRT. In
> this case, just reject wrong context invocations by returning -ENOSYS.
> RTDM will then re-invoke the service after toggling the context. See the
> IOCTL handling of the timerbench driver as example.
> 
> 
>>I still have same problems with porting the driver, but I think I can
>>handle them myself.
>>Thanks for your help.
>>Petr Cervenka
>>
> 
> 
> Jan
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

