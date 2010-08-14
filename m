Message-ID: <4C66E15C.9050509@domain.hid>
Date: Sat, 14 Aug 2010 20:33:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281640317.S.3646.40456.F.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-235-209.1281673148.64164@domain.hid>
In-Reply-To: <1281640317.S.3646.40456.F.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-235-209.1281673148.64164@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

prakash srinivasan wrote:
>>>>> printf(TOTAL LOOP TIMING=%ld us\n",
>>>>> (long)((rt_timer_ticks2ns(end-start))/1000);
>>>> What does: printf(TOTAL LOOP TIMING=%lld us\n",
>>>> rt_timer_ticks2ns(end-start)/1000); report.
>>> TOTAL LOOP TIMING = 5377070 us In this case, the (unsigned)
>>> (long) (long)tart returns 1069623206 and (unsigned) (long)
>>> (long)end returns 2151726697
>> Are you happy with that result? Did really pass approx. 5 seconds
> between start and end?

Could you format your mails correctly to make them readable? Use text,
not HTML, truncate at 72 characters, and use > as a quotation mark,
meaning that one '>' is the sign that you quote someone, two '>' is you
quoting someone who quoted someone else, etc... I am really sorry to
have to tell you about this, this is really basic knowledge of the
netiquette, we should not have to tell you about it.

> Definitely not and I am not confident about this output. Coz in this
> loop period I am sending datas from client to the server. Visibly
> noted that the server is getting all the datas within a second. So I
> am not sure the 5 sec is the right output. I just like to know all
> the above conversions are correct? and is it ok that the start ticks
> can be more than the end ticks?

The result of rt_timer_read is a long long, so, if you cast it to an
unsigned, you loose the most significant bits. So, the result is totally
meaningless. This again, is basic knowledge of the C language, we should
not have to explain.

Your bug report is quite insufficient, we do not even know what version
of Xenomai you use, maybe you are reporting a bug which has been solved
a long time ago. Neither do we know what version of Linux and of the
Adoes patch you use, or the contents of your .config file. We do not
have a self-contained example that we can run to try and reproduce your
issue.

So if you want some answers, please give us the means to answer you.

-- 
					    Gilles.

