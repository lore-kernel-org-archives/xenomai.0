From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <997471575@domain.hid>
References: <997471575@domain.hid>
Date: Wed, 17 Sep 2008 20:56:09 +0200
Sender: wd@domain.hid
Message-Id: <20080917185609.E1800248D0@domain.hid>
Subject: Re: [Xenomai-help] Xilinx and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Dear Joachim Meyer,

In message <997471575@domain.hid> you wrote:
> 
> I realizes that there is a support for Xilinx Boards such as the ml300 at t=
> he mainline tree. I compiled the mainline tree successfully for my XUPV2P a=
> nd tried to use the xenomai-patch then. I used the newest (I believe 2.6.26=
> ) Kernel and the newest xenomai (2.4.5) version, so I tried the adeos-ipipe=
> -2.6.26-powerpc-DENX-2.2-04.patch patch. Unluckily that failed. What would =
> I have to do to get the patch working for my mainline tree? Will it work fo=
> r my XUPV2P (Virtex 2 Pro) Board then?

Why don't you just use the sources from our repo? It's just  mainline
plus  local  additions. As long as you don't use any of the boards we
added you should get the same as  in  mainline  -  but  matching  the
Xenomai patches.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Imagination is more important than knowledge.      -- Albert Einstein

