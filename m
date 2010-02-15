Message-ID: <4B79155E.8070108@domain.hid>
Date: Mon, 15 Feb 2010 10:35:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100204105700.GB20669@domain.hid>	
	<4B6C2D59.9060200@domain.hid>	
	<b88603c31002050727p1decfdacm919d3f2278fdf2f0@domain.hid>	
	<4B7019AA.8020102@domain.hid>	
	<b88603c31002080633v1b9ee7b4s2a6ee82eeaab644d@domain.hid>	
	<4B71339F.6050300@domain.hid> <4B713462.6000300@domain.hid>	
	<b88603c31002090214j2d21f572sba26ed3883bc0612@domain.hid>	
	<b88603c31002120757m386b5662nd8844a8fbccb22f0@domain.hid>	
	<4B758DC6.4040508@domain.hid>
	<b88603c31002150107s115bec57x1ea9f635e54eab50@domain.hid>
In-Reply-To: <b88603c31002150107s115bec57x1ea9f635e54eab50@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Henri Roosen wrote:
> Hi Gilles,
> 
> Thanks for your support on this! We changed our application so it uses
> the pthread library to create threads. Just to be on the safe side.
> And I can confirm this works now on Xenomai 2.5.1.
> 
> Might be a good idea to change the documentation of rt_task_shadow
> what the requirements are for a task to be shadowed. Because "the
> calling regular Linux task" does not apply anymore for Xenomai 2.5.x.

Just to understand the original motivation: what use case was behind
home-brewed thread creation? Note that it's a bit uncommon and can cause
troubles all around once you start using libpthread directly - or
indirectly.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

