From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17276.63656.808394.36984@domain.hid>
Date: Thu, 17 Nov 2005 22:39:52 +0100
Subject: Re: [Xenomai-help] kernel module misses rt_get_time
In-Reply-To: <20051117214647.61520725.gda@domain.hid>
References: <20051117214647.61520725.gda@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gerald Dachs <gda@domain.hid>
Cc: xenomai@xenomai.org

Gerald Dachs wrote:
 > Hi,
 > 
 > I am new to xenomai, sorry if I ask something stupid. 
 > I try to use a kernel module with xenomai, but upon loading it
 > misses rt_get_time. It looks like it was build with rtai. I have thought
 > I could use it with xenomai via the rtai skin.
 > In the rtai skin I found only rt_get_time_ns.
 > Searching the web I found them both mentioned, I didn't found
 > that it is replaced by another function. Is xnpod_get_time the
 > same?

Looking at branch 2.0 RTAI skin, the rt_get_time function appears to be
missing. Looking at branch 2.1 RTAI skin, the future trunk, well, there
is nothing but the init.c file. 

So, using xnpod_get_time appears to be the safe bet.

-- 


					    Gilles Chanteperdrix.

