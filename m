Message-ID: <2ff1a98a0801150844l309d1368i945e7183aa5da807@domain.hid>
Date: Tue, 15 Jan 2008 17:44:57 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D37657B@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D376570@domain.hid>
	<2ff1a98a0801150827ka2070dfxd937209e57271b3f@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D37657B@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] rms scheduling
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

On Jan 15, 2008 5:41 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> Then I will have to go back and re-write my code to use jiffies instead
> of nanoseconds, right? Is there a macro that will return the proper
> value for future use?

This is transparent, you do not have to care about that, provided that
you use rt_timer_ns2ticks everywhere, things will work the same way in
one-shot mode or periodic mode.

>
> Also, it seems like this rt_timer_set_mode() will make this the timebase
> for all things using the native skin. However, what if another app
> wanted a different timebase? This isn't possible, is it?

Since xenomai 2.4, each skin has its own timebase. Most skins do not
have a service such as rt_timer_set_mode to set whether they will be
periodic or one-shot, but their module accept a parameter.

-- 
                                               Gilles Chanteperdrix

