MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17544.35914.790308.357011@domain.hid>
Date: Thu, 8 Jun 2006 22:44:58 +0200
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
In-Reply-To: <44887A1F.20003@domain.hid>
References: <17536.40316.183366.284818@domain.hid>
	<17543.5163.684144.582942@domain.hid>
	<44871DF8.9010903@domain.hid>
	<17544.6126.256649.862048@domain.hid>
	<44885FDA.8080301@domain.hid>
	<17544.28567.517655.60691@domain.hid>
	<44887A1F.20003@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > One more thing though: Having always the same values doesn't tell if the 
 > task's state is overwritten with some "older generation" of its state or 
 > something odd like that. The state-saving will only need to work once 
 > and if it sucks rest of the time nobody knows. Or was that accounted for 
 > in the code? (Didn't read it all that carefully, lazy me)

That is right, the new implementation compute a different value for each
switch.

-- 


					    Gilles Chanteperdrix.

