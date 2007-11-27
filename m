Message-ID: <474C3EA6.9070300@domain.hid>
Date: Tue, 27 Nov 2007 16:58:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6D@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375D6D@slcmail.slc.mew.int>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] geode problems
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
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I am now running rc7 with 2.6.23 and am still having issues with timing
> on the geode. It seems that when I insert xeno_nucleus, the interrupt
> handler runs too fast for linux. When I then insert xeno_native, it runs
> too slow. Can anyone point me in the right direction so I can look at
> what’s going on here? I figured xenomai should take its timing behavior
> from the linux kernel somehow. Linux runs just fine without xenomai
> modules loaded.
> 
>  
> 
> With the latest code, I’m now seeing 10,000 timer interrupts per second
> with just nucleus loaded and still 100 per second with native loaded.
> 
>  

Does disabling CONFIG_SCx200HR_TIMER change the situation?

> 
> Someone help! J
> 
>  
> 
> Steven
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

