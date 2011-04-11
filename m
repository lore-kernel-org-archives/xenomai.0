Message-ID: <4DA311D9.2020104@domain.hid>
Date: Mon, 11 Apr 2011 16:36:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid> <1302268379.2101.35.camel@domain.hid>
	<4DA30C80.3010107@domain.hid>
In-Reply-To: <4DA30C80.3010107@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jesper Christensen <jbc@domain.hid>
Cc: xenomai@xenomai.org

Jesper Christensen wrote:
> I have updated to xenomai 2.5.6, but i'm still seeing exceptions
> (considerably less often though):
> 
> Xenomai: suspending kernel thread b92a39d0 ('tt_upgw_0') at 0xb92a39d0
> after exception #1792

There was an alignment issue with rtnet on ARM some time ago, which was
solved by the following patch:
http://rtnet.git.sourceforge.net/git/gitweb.cgi?p=rtnet/rtnet;a=commit;h=1b38434c6137d3b4a708e00d8fef6a4b422c6593

Maybe it is related?

Regards.

-- 
					    Gilles.

