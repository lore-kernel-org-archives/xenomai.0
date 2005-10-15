From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.43539.194460.48904@domain.hid>
Date: Sat, 15 Oct 2005 09:04:51 +0200
Subject: Re: [Xenomai-help] XenoPPC : Latency test results
In-Reply-To: <1146.193.52.24.125.1129357068.squirrel@domain.hid>
References: <1146.193.52.24.125.1129357068.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid wrote:
 > Hi:
 > 
 > if I run the latency test and I contunue to use the PPC as usual, after a
 > while, I noticed some overruns (see report below).
 > 
 > Question: it is a serious problems or a normal behavior ?

150 us is high, you likely have a hardware problem. Do you also have
the 150us latency without X running at all ? Do you also have them when
disabling Altivec/Spe support in kernel configuration ?

-- 


					    Gilles Chanteperdrix.

