Message-ID: <4926D775.8010102@domain.hid>
Date: Fri, 21 Nov 2008 16:44:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <af29ce600811170122q83ee743ic771a6f07a70e9b9@domain.hid>	
	<492143DF.8040508@domain.hid>	
	<af29ce600811170328v79cfa0f0k46d1491c46046f5e@domain.hid>	
	<49217095.7080902@domain.hid>	
	<af29ce600811210417u3fcb07b9kbdc2fde3e1451f74@domain.hid>	
	<4926B3DB.9090100@domain.hid>
	<af29ce600811210730n5272bb11naa94eac6630d716f@domain.hid>
In-Reply-To: <af29ce600811210730n5272bb11naa94eac6630d716f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] NETDEV WATCHDOG on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefano Gafforelli <stefano.gafforelli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Stefano Gafforelli wrote:
> With additional patch...do you think that the problem is due to the relation
> between additional patch and xenomai?

Yes, that is something possible. Normally, we try to test that Xenomai
is compatible with the AT91 patch, but some error may escape, and we
never tested the ronetix patch, which I do not know. So, please test
without these additional patches.

P.S: please always CC the mailing list.

-- 
                                                 Gilles.

