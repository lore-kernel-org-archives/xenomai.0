Date: Thu, 17 Nov 2005 23:54:25 +0100
From: Gerald Dachs <gda@domain.hid>
Subject: Re: [Xenomai-help] kernel module misses rt_get_time
Message-Id: <20051117235425.475293de.gda@domain.hid>
In-Reply-To: <437D0735.8070306@domain.hid>
References: <20051117214647.61520725.gda@domain.hid>
	<437D0735.8070306@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> Actually, rt_get_time and rt_get_time_ns are the same in the RTAI
> compatibility skin (counts are nanoseconds here, see count2nano e.g.).
> Therefore, a

Sorry, but I don't think so. In the rtai docs I read that rt_get_time returns ticks
and rt_get_time_ns returns nano seconds.

Gerald

