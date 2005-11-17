Date: Thu, 17 Nov 2005 21:46:47 +0100
From: Gerald Dachs <gda@domain.hid>
Message-Id: <20051117214647.61520725.gda@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] kernel module misses rt_get_time
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

Hi,

I am new to xenomai, sorry if I ask something stupid. 
I try to use a kernel module with xenomai, but upon loading it
misses rt_get_time. It looks like it was build with rtai. I have thought
I could use it with xenomai via the rtai skin.
In the rtai skin I found only rt_get_time_ns.
Searching the web I found them both mentioned, I didn't found
that it is replaced by another function. Is xnpod_get_time the
same?

Gerald

