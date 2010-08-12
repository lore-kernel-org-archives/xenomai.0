Message-ID: <4C63E156.2020102@domain.hid>
Date: Thu, 12 Aug 2010 13:56:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20100812093944.14467.qmail@domain.hid>
In-Reply-To: <20100812093944.14467.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Timing calculation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: prakash srinivasan <asprakash_83@domain.hid>
Cc: xenomai@xenomai.org

On 08/12/2010 11:39 AM, prakash srinivasan wrote:
> Deal All,
> 
>        I am executing a simple for() loop and like to calculate the time period for this loop. I used rt_timer_read(). As per the document, it mentioned that rt_timer_read() returns the current time expressed in clock ticks. I could not able to get an clear idea about it. Suppose if i convert it by using rt_timer_ticks2ns(), I am not getting the proper output. My code is,
> 
> 
> 
> RTIME start, end;
> 
> ...
> 
> ...
> 
> start=rt_timer_read();
> 
> for()
> 
> {}
> 
> end=rt_timer_read();
> 
> printf(TOTAL LOOP TIMING=%ld us\n", (long)((rt_timer_ticks2ns(end-start))/1000);

What does:

  printf(TOTAL LOOP TIMING=%lld us\n", rt_timer_ticks2ns(end-start)/1000);

report.

Wolfgang.

