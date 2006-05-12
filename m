From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17508.46837.9322.301862@domain.hid>
Date: Fri, 12 May 2006 18:25:25 +0200
Subject: Re: [Xenomai-help] starnge latencies with native
In-Reply-To: <20060512172456.555caf51@domain.hid>
References: <20060512172456.555caf51@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: Xenomai-help@domain.hid

Daniel Simon wrote:
 > Hi all,
 > 
 > I'm doing some tests with the native skins. The attached program uses
 > an alarm to trigger a periodic task and measures the sampling latency. 
 > 
 > Initial latencies are in the range of tens of millisecs. and then
 > decrease slowly to the range of microsecs:
 > 
 > rt_timer_set_mode(TM_ONESHOT) started 
 > alarm started with period 1000000000 ns 
 > increment 1124642266 absjitter 124642266  
 > increment 937743828 absjitter 62256172  
 > increment 1031095424 absjitter 31095424  
 > increment 984466651 absjitter 15533349  
 > increment 1007758686 absjitter 7758686  
 > increment 996126407 absjitter 3873593  
 > increment 1001934707 absjitter 1934707  
 > increment 999039749 absjitter 960251  
 > increment 1000477139 absjitter 477139  
 > increment 999759707 absjitter 240293  
 > increment 1000119631 absjitter 119631  
 > increment 999938964 absjitter 61036  
 > increment 1000029816 absjitter 29816  
 > increment 999985508 absjitter 14492  
 > increment 1000004750 absjitter 4750  
 > increment 999998882 absjitter 1118  
 > increment 1000000946 absjitter 946  
 > increment 999998780 absjitter 1220  
 > increment 1000001951 absjitter 1951  
 > increment 999999514 absjitter 486  
 > increment 999998746 absjitter 1254  
 > [...]
 > 
 >  What may be wrong? 

Are you still running a kernel with ACPI_PROCESSOR ? 

-- 


					    Gilles Chanteperdrix.

