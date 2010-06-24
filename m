Date: Fri, 25 Jun 2010 01:53:20 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100624235320.GC9802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] Some changes in Analogy core
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I just pushed into my git repository (branch analogy) some significant
changes in the asynchronous buffer management.

These modifications intend to fix a major issue in the analogy
architecture: only the default input and output subdevices were
reachable via read / write syscalls.  

These changes do not induce any API / ABI breakage. 

If you notice a problem, please tell me.

-- 
Alexis.

