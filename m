From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17618.13358.419819.265967@domain.hid>
Date: Thu, 3 Aug 2006 19:36:46 +0200
Subject: Re: [Xenomai-help] Time between ISR and RT Task
In-Reply-To: <20060803133516.31820@domain.hid>
References: <20060803133516.31820@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GSM909@domain.hid
Cc: xenomai@xenomai.org

GSM909@domain.hid wrote:
 > Hello
 > 
 > I have run a few programs with Xenomai tasks and have no problems. But I notice that the time between ISR and RT task ( RT task is suspended and resumed by the ISR) is shorter when Linux have a lot of work ( average load around 10 ) as when Linux has nothing to do( al : 0.05 ). 

Do you observe this for worst case, or for average case latencies? Do
you observe this when you boot with the idle=poll parameter ?

When idle, Linux uses the 'hlt' instruction, that stops the CPU until an
interrupt happen, maybe waking up from this state take a little bit more
time than when an interrupt is received directly?

-- 


					    Gilles Chanteperdrix.

