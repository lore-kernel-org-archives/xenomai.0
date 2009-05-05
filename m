Message-ID: <4A003DC3.4060007@domain.hid>
Date: Tue, 05 May 2009 15:23:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF9CF4E5FB.BA5862BC-ONC12575AD.00275D59-C12575AD.00285FDC@datacon.at>
In-Reply-To: <OF9CF4E5FB.BA5862BC-ONC12575AD.00275D59-C12575AD.00285FDC@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with xenomai configuration
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> 
> Hi,
> 
> I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai 2.4.6.1 and the latest
> rtnet version.
> I set up the EthercatMasterLibrary and send some Frames (size of ~1200
> byte) cylical to my Beckhoff devices.
> Measuring the time (via rt_read_timer-function of timer.h) handing the
> frames over to the NIC last between 5 and 10 us. (its the low_level_send)
> Measuring the time at the application layer is takes ~250 - 350 us. So I am
> loosing quite a lot time in between.
> 
> Maybe there is sth. wrong with my xenomai configuration.
> I run the 'xeno-test' (results below) but the test stop at generation load.

Yes, xeno-test has a known issue when run without bash, and ubuntu no
longer uses bash by default. So, try running xeno-test with bash.

Alternatively, you can run the latency test directly. Preferably using
the same period as the problematic one with EML.

-- 
                                                 Gilles.

