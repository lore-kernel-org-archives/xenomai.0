Message-ID: <4C6447C2.1070001@domain.hid>
Date: Thu, 12 Aug 2010 21:13:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1281614099.S.2522.62255.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-234-118.old.1281627480.44273@domain.hid>
In-Reply-To: <1281614099.S.2522.62255.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-234-118.old.1281627480.44273@domain.hid>
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
To: asprakash_83 <asprakash_83@domain.hid>
Cc: xenomai@xenomai.org

On 08/12/2010 05:38 PM, asprakash_83 wrote:
> 
>>> printf(TOTAL LOOP TIMING=%ld us\n", (long)((rt_timer_ticks2ns(end-start))/1000);
> 
>> What does:
> 
>> printf(TOTAL LOOP TIMING=%lld us\n", rt_timer_ticks2ns(end-start)/1000);
> 
>> report.
> 
> TOTAL LOOP TIMING = 5377070 us 
> In this case, the (unsigned) (long) (long)tart returns 1069623206
> and (unsigned) (long) (long)end returns 2151726697

Are you happy with that result? Did really pass approx. 5 seconds
between start and end?

Wolfgang.

