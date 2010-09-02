Message-ID: <4C7F9923.30209@domain.hid>
Date: Thu, 02 Sep 2010 14:31:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100902042326.27700@domain.hid>
	<4C7F6549.7020703@domain.hid>
In-Reply-To: <4C7F6549.7020703@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Validating installation of Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: C Robinson <starknight__@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> C Robinson wrote:
>> Hello,
>>
>> I followed the suggested install procedure to setup a Xenomai kernel on my x86 Ubuntu system.  
>> (http://www.xenomai.org/index.php/Building_Debian_packages)  
>> I would like to verify that everything is hunky-dory, but I'm not quite sure how.   I have read in some places that "user space" needs to be set up, although this is not mentioned in the reference I followed.   Is this still necessary?
>>
>> The command:
>> 	dmesg | grep Xenomai
>> Shows:	
>> -------------------------------------------------------------------------------------------------------------
>> 	[    0.659903] I-pipe: Domain Xenomai registered.
>> 	[    0.659928] Xenomai: hal/i386 started.
>> 	[    0.659942] Xenomai: scheduling class idle registered.
>> 	[    0.659944] Xenomai: scheduling class rt registered.
>> 	[    0.660450] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
>> 	[    0.660570] Xenomai: starting native API services.
>> 	[    0.660572] Xenomai: starting POSIX services.
>> 	[    0.660599] Xenomai: starting RTDM services.
>> -------------------------------------------------------------------------------------------------------------
>>
>> The command: 
>> 	xeno-test
>> Is not quite so promising (there was more of the same text above and below the output shown below):
> 
> We get that a lot. Fixing xeno-test is on our todo list, but not just
> for right now.
> In the mean-time, you can run the tests one by one.
> 
> The following paper:
> http://download.intel.com/design/intarch/papers/322386.pdf
> 
> Is not really up to date with regard to kernel configuration, but gives
> an overview of our testsuite.

Actually, the tests descriptions are the ones from the manual pages
which should have been installed with xenomai.

-- 
					    Gilles.

