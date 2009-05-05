Message-ID: <4A005090.1080406@domain.hid>
Date: Tue, 05 May 2009 16:43:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF9CF4E5FB.BA5862BC-ONC12575AD.00275D59-C12575AD.00285FDC@datacon.at>	
	<4A003DC3.4060007@domain.hid> <1241531884.26544.369.camel@domain.hid>
In-Reply-To: <1241531884.26544.369.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2009-05-05 at 15:23 +0200, Gilles Chanteperdrix wrote:
>> henning.richter@domain.hid wrote:
>>> Hi,
>>>
>>> I use a KUbuntu 8.10 with kernel 2.6.27.7, xenomai 2.4.6.1 and the latest
>>> rtnet version.
>>> I set up the EthercatMasterLibrary and send some Frames (size of ~1200
>>> byte) cylical to my Beckhoff devices.
>>> Measuring the time (via rt_read_timer-function of timer.h) handing the
>>> frames over to the NIC last between 5 and 10 us. (its the low_level_send)
>>> Measuring the time at the application layer is takes ~250 - 350 us. So I am
>>> loosing quite a lot time in between.
>>>
>>> Maybe there is sth. wrong with my xenomai configuration.
>>> I run the 'xeno-test' (results below) but the test stop at generation load.
>> Yes, xeno-test has a known issue when run without bash, and ubuntu no
>> longer uses bash by default. So, try running xeno-test with bash.
>>
> 
> Gilles, we have an ongoing series of recurring issues with xeno-test
> that pleads for a reshuffle. I would really like to see something
> simpler in there, which may not cover all aspects that xeno-test
> currently addresses, but which would at least work for all setups, and
> particularly embedded ones.

Yes, I am ok. These issues with xeno-test are annoying.

> We should rather see xeno-test as a simple validation tool to dig out
> most common latency issues due to bad kernel settings. Further
> validation via long running stress tests would be better accomplished
> via the LTP-based suite we use internally to validate ports, within
> standalone mini-rootfs; maybe at some point we could provide those
> pre-built rootfs for download, for that particular purpose.

Yes, Ok too.

> 
>> Alternatively, you can run the latency test directly. Preferably using
>> the same period as the problematic one with EML.
>>


-- 
                                                 Gilles.

