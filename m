From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4BB3BCF9.9080809@domain.hid>
References: <hp0bdv$mp4$1@domain.hid>
	<4BB3BCF9.9080809@domain.hid>
Date: Thu, 01 Apr 2010 01:12:36 +0200
Message-Id: <20100331231236.75D8AE73028@domain.hid>
Subject: Re: [Xenomai-help] cyclictest -tn where n!=1 causes segfault with
	Kilauea
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Berger <gmane@domain.hid>
Cc: xenomai@xenomai.org

Dear Robert,

In message <4BB3BCF9.9080809@domain.hid> you wrote:
> 
> ulimit -s
> 8192

And what happens when you start cyclictest after running
"ulimit -s unlimited" ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
All he had was nothing, but that was something, and now it  had  been
taken away.                             - Terry Pratchett, _Sourcery_

