From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17649.29852.734305.260318@domain.hid>
Date: Sun, 27 Aug 2006 12:31:56 +0200
Subject: Re: [Xenomai-help] Re: Timer problems?
In-Reply-To: <44F16426.5010207@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>
	<44F0BBB7.7030703@domain.hid> <1156630353.4730.70.camel@domain.hid>
	<44F16426.5010207@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: Bernhard Walle <bernhard@domain.hid>, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Steve Kreyer wrote:
 > Hi Philippe,
 > 
 > disabling PM in Kernel was a good tip!
 > 
 > Now I can call standard linux library functions without resulting in a 
 > system lock up :)
 > But the ETIMEDOUT error when calling e.g. rt_task_wait_period or 
 > rt_task_sleep still persists.

Could you try enabling the SMI workaround ?

-- 


					    Gilles Chanteperdrix.

