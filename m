Message-ID: <49B8EE0A.3050708@domain.hid>
Date: Thu, 12 Mar 2009 12:12:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>
In-Reply-To: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm timer questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Is an RTDM timer going to run at a priority higher than any scheduled  
> realtime thread?
> 
> How accurate is the timing?
> 
> We are seeing the timer running at 125us periodic rate being called  
> much too quickly. At least, I think we are. I can't personally use  
> anything for a little over a week.

Yes a timer runs in interrupt context. This is the same design as Linux,
VxWorks, RTLinux, RTAI and most known OSes.

I do not understand what you mean by "too quickly", but do you get the
same phenomenon with the klatency -t 2 test?

-- 
                                                 Gilles.

