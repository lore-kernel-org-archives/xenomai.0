Message-ID: <4A081829.5090901@domain.hid>
Date: Mon, 11 May 2009 14:20:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFCB7F621A.65B14ECB-ONC12575B3.0039F826-C12575B3.0039F8AC@datacon.at>
In-Reply-To: <OFCB7F621A.65B14ECB-ONC12575B3.0039F826-C12575B3.0039F8AC@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

henning.richter@domain.hid wrote:
> So here is what I got via serial console when my application causes that
> freeze:

Ok. Is it the first bug? If yes, could you send us a disassembly of the
profile_pc function? (run objdump vmlinux, then look for profile_pc, and
only copy this function in the mail).

-- 
                                                 Gilles.

