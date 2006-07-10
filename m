From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17586.17622.409832.619221@domain.hid>
Date: Mon, 10 Jul 2006 14:15:18 +0200
Subject: Re: [Xenomai-help] Xenomai heap services
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F912B@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F912B@ARVMAIL1.mra.roland-man.biz>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > - is there a function telling me how much memory is available (to avoid linux tasks beeing killed).

sysconf(_SC_AVPHYS_PAGES) * sysconf(_SC_PAGESIZE)

-- 


					    Gilles Chanteperdrix.

