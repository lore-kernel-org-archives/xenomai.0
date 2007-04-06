Message-ID: <46160F89.405@domain.hid>
Date: Fri, 06 Apr 2007 11:14:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM cannot open device
References: <899865CA54E4444DAF2E3639C04C5F4805EC69@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805EC69@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> I am trying to write a simple driver using the RTDM. I have based my
> driver on the examples at http://www.captain.at and at
> http://stud3.tuwien.ac.at/~e0226686/xenomai/source_code.
> 
> The call to rt_dev_open() returns -1 (Operation not permitted).
> 
> The program is running as root, and I am able to run the 'latency'
> test program.
> 
> What am I doing wrong?

Maybe you only defined the open_rt callback for your driver and are
trying to open the driver from a non realt-time thread ?

-- 
                                                 Gilles Chanteperdrix

