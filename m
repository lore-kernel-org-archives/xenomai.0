From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4A68283F.6030304@domain.hid>
References: <4A67F5D2.4090708@domain.hid>
	<20090723085203.2782B832E416@domain.hid>
	<4A68283F.6030304@domain.hid>
Date: Thu, 23 Jul 2009 13:50:41 +0200
Message-Id: <20090723115041.A8147832E416@domain.hid>
Subject: Re: [Xenomai-help] Advice for a newbie on Xenomai & USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David <correupeldavid@domain.hid>
Cc: xenomai@xenomai.org

Dear David,

In message <4A68283F.6030304@domain.hid> you wrote:
>
> What happens if I cannot get USB out of the loop? Is it doomed?

Well, in my experience (> 10 years of embedded Linux) USB has an
unchallenged number one position on the list of candiates for causing
problems in embedded projects - without any real-time requirements.

If you cannot get rid of it, then I recomment to run thorough tests as
early as possible.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Experience is what causes a person to make new  mistakes  instead  of
old ones.

