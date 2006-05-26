MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17527.16296.557740.403770@domain.hid>
Date: Fri, 26 May 2006 19:49:28 +0200
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
In-Reply-To: <200605261944.18514.niklaus.giger@domain.hid>
References: <446F852B.7090400@domain.hid>
	<200605240721.24897.niklaus.giger@domain.hid>
	<17527.11352.471153.316802@domain.hid>
	<200605261944.18514.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Niklaus Giger wrote:
 > Do you have any clue? (Doubling the stack in vm/thread.cc didn't help.)

Automatic re-building does not work for the simulator. So, in case of
segmentation fault, try:

make clean all check

-- 


					    Gilles Chanteperdrix.

