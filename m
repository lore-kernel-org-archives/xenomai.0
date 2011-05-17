Message-ID: <4DD22053.5030502@domain.hid>
Date: Tue, 17 May 2011 09:14:27 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>	<4DD102DA.9080206@domain.hid>
	<4DD107AD.5000307@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>
	<4DD13882.8000708@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B9110@domain.hid>
In-Reply-To: <89B30389DB4AE240AC1227F3FDBB7CCF029B9110@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai@xenomai.org

On 05/17/2011 09:03 AM, Koenig, Florian wrote:
> Hi,
> 
>> After copying trivial-periodic to 405GP cpu, it returns illegal
> instruction.
> 
> Hm, in a previous mail I asked if the installed Xenomai programs from
> the test suite like "latency" or "cyclictest" do work. Is that the case?
> If not, it's most likely not a build problem.
> 
> The latency and cyclictest also return illegal instruction. What could it
> else be, misconfigured kernel?

Do you have CONFIG_XENO_HW_FPU disabled? If not, please disable and
retry. Illegal instructions are maybe due to hard-float instructions in
the binary. I will check on our Walnut board when time permits...
hopefully today.

Wolfgang.

