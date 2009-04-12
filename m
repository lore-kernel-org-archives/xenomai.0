Message-ID: <49E22775.4070107@domain.hid>
Date: Sun, 12 Apr 2009 19:40:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>	<Pine.LNX.4.64.0904081659110.22300@domain.hid>	<Pine.LNX.4.64.0904101250540.4820@domain.hid>	<Pine.LNX.4.64.0904101708030.4820@domain.hid>	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>	<Pine.LNX.4.64.0904101729031.4820@domain.hid>	<49E08F6F.8000604@domain.hid>	<Pine.LNX.4.64.0904111233180.32647@domain.hid>	<49E0F887.40805@domain.hid>	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
In-Reply-To: <49E1B05A.4040705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Martin Shepherd wrote:
>> On Sat, 11 Apr 2009, Gilles Chanteperdrix wrote:
>>> We have just discovered that FPU handling on x86 had a few bugs, one of
>>> them involving CPUs without fxsr (check /proc/cpuinfo).
>> The AMD Athlon that I am using, does have fxsr, according to
>> /proc/cpuinfo. Regardless, now that I have seen lockups during the
>> latency tests as well, I don't think that the problem can be related
>> to floating point. It looks more like an interrupt problem.
> 
> Ok. But the patch mentioned previously also fixes kernels using FPU in
> kernel-space, which the Athlon does according to Konfig. So, please try
> the FPU patch or select K6 instead of Athlon.

Actually, the 3DNow was fixed before the 2.4.7 release. So, you should
not have it if you are using Xenomai 2.4.7. And the proper commit number
for the fxsr issue fix which was merged into the head branch in the mean
time is: 3a23967f3cc8d6881d8e3280130bbc431195aa31.

-- 
					    Gilles.

