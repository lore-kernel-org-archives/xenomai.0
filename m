MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17590.40418.205139.609207@domain.hid>
Date: Thu, 13 Jul 2006 21:24:18 +0200
Subject: Re: [Xenomai-help] RT timer help
In-Reply-To: <e325d110607131026qdb0aac8p53bb9f1ddad58181@domain.hid>
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
	<17590.14655.583084.480317@domain.hid>
	<e325d110607130737j3011b167wef31d2bf8fa6fd42@domain.hid>
	<17590.23816.918869.787019@domain.hid>
	<e325d110607130902r6bdd04e4l1001f33e094d9d4a@domain.hid>
	<17590.28495.53263.24303@domain.hid>
	<e325d110607130946m47041caai13413b69288b71a1@domain.hid>
	<17590.31244.141411.473429@domain.hid>
	<e325d110607131026qdb0aac8p53bb9f1ddad58181@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > Hi Gilles,
 > 
 > I print the result of rt_timer_read() for every output...
 > > Do you see one line displayed every second, or one line every ten
 > > seconds ?
 > 
 > The latency program...
 > display the line every second.
 > different between each rt_timer_read() is roughly the same(~1000000000).
 > 
 > my program...
 > display the line every 10 second.
 > different between each rt_timer_read() is roughly the same(~1000000000).
 > 
 > May i know if the different of time maintained by the system timer are
 > the same, why the output text displayed at different rate?

Your example runs fine here. Could you tell us more about your setup ?
What processor ? What configuration (are CONFIG_CPU_FREQ and
CONFIG_ACPI_PROCESSOR disabled and is hyper-threading enabled) ? Could
you send us your .config ? Is there any error message in the kernel logs
? 

-- 


					    Gilles Chanteperdrix.

