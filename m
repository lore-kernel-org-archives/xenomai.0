Message-ID: <4DD257F5.7010408@domain.hid>
Date: Tue, 17 May 2011 13:11:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>	<4DD102DA.9080206@domain.hid>	<4DD107AD.5000307@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>	<4DD13882.8000708@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B9110@domain.hid>	<4DD22053.5030502@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B9111@domain.hid>
	<4DD23F8A.5000107@domain.hid>
In-Reply-To: <4DD23F8A.5000107@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, "Koenig,
	Florian" <F.Koenig@domain.hid>

On 05/17/2011 11:27 AM, Wolfgang Grandegger wrote:
> On 05/17/2011 09:53 AM, Koenig, Florian wrote:
>> Hi,
>>
>> Do you have CONFIG_XENO_HW_FPU disabled? If not, please disable and
>> retry. Illegal instructions are maybe due to hard-float instructions in
>> the binary. I will check on our Walnut board when time permits...
>> hopefully today.
> 
> Nobody will understand that the above paragraph was written by myself
> without proper quoting!
>  
>> I set CONFIG_XENO_HW_FPU to 
>> # CONFIG_XENO_HW_FPU is not set
> 
> Well, that should not be done manually and it could not be set via
> "menuconfig", I just realized. It's not the problem anyway, I believe.

You can set CONFIG_XENO_HW_FPU, it is located in the "Real-time
system"/"nucleus"/"Machine" menu.

-- 
                                                                Gilles.

