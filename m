From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <201105101823.50226.lux-integ@domain.hid>
References: <201105101823.50226.lux-integ@domain.hid>
Date: Tue, 10 May 2011 20:20:39 +0200
Message-Id: <20110510182039.CF301D6BE23@domain.hid>
Subject: Re: [Xenomai-help] preferred uid?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dear luxInteg,

In message <201105101823.50226.lux-integ@domain.hid> you wrote:
> 
> I normally  compile stuff as an ordinary user,  but   I noticed in this area   
> people often compile as root as  kernel  modules are involved.   I note 
> xenomai can be compiled either as user or root so  is there a preferred way ?

You should incorporate the rule to always work as normal user only,
and only in the very few cases where you really need root permissions
(like when installing code into system direcotries or loading kernel
modules) you should use "sudo" or similar.


Short answer: all compilations and all other building of sowtare
should always be done as normal user only, and never ever as root.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Of course there's no reason for it, it's just our policy.

