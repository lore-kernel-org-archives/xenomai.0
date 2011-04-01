Message-ID: <4D95B8E3.601@domain.hid>
Date: Fri, 01 Apr 2011 13:37:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>	
	<1301412534.2109.24.camel@domain.hid> <4D922EF5.8020808@domain.hid>	
	<1301426227.2109.35.camel@domain.hid> <4D9230C5.7050007@domain.hid>	
	<1301426830.2109.41.camel@domain.hid> <4D923306.60409@domain.hid>	
	<1301461081.2092.14.camel@domain.hid>	
	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>	
	<1301472945.2092.21.camel@domain.hid>	
	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>	
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>	
	<4D948F87.9010109@domain.hid> <4D9494B6.6040304@domain.hid>	
	<AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
	<1301656855.2155.232.camel@domain.hid>
In-Reply-To: <1301656855.2155.232.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> (*) Unless I find a way to direct the linux scheduler to the "right"
> task in the migration case, but so far, I found none (none that would be
> sane, I mean).

In Henri particular case. Maybe there would be a way to call
wake_up_process first, then look into the (Linux) scheduler state, see
if a reschedule is pending. If a reschedule is pending, do not clear the
boost and let do_schedule_event handle the situation? Otherwise, clear
the boost.

Or maybe that fits into the "insane" category?

-- 
                                                                Gilles.

