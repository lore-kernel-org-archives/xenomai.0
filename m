MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18275.49565.776637.428568@domain.hid>
Date: Sat, 15 Dec 2007 12:59:25 +0100
In-Reply-To: <892997.84545.qm@domain.hid>
References: <892997.84545.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

Michael Trimarchi wrote:
 > 
 > Hi,
 > 
 > I think that the problem of the overruns are related to the latency introduced by adeos, and the
 > serial buffer of the at91sam9260 ( length = 1 ). 

Wait a minute. You mean that you want more than 5000 interrupts by
second ? Are you sure you do not get overruns with plain, unpatched
Linux, if you load it sufficiently ?

-- 


					    Gilles Chanteperdrix.

