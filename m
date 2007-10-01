MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18177.20421.874002.472501@domain.hid>
Date: Mon, 1 Oct 2007 21:51:33 +0200
In-Reply-To: <47014BED.1090005@domain.hid>
References: <47014BED.1090005@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [BUG] posix skin thread doesn't
	respect	/proc/xenomai/affinity
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi Gilles,
 > 
 > almost forgot to report this, didn't find time to dig into it. You can
 > easily check this with cyclictest: affinity mask set to 2, the test will
 > still schedule on CPU0.

Ok, what is needed at skin level to get it to work ?

-- 


					    Gilles Chanteperdrix.

