References: <20111223173309.GM27742@domain.hid> <4F045578.7090405@domain.hid>
 <414a96f6-a471-c0d0-4199-f7eacf6ef1da@frank-benkert.de>
 <53afdf9c-33a4-bc60-d3f9-291477aa3f24@xenomai.org>
From: Frank Benkert <xenomai@frank-benkert.de>
Message-ID: <64cad1e1-068e-daeb-e8de-e5ff04f0b622@frank-benkert.de>
Date: Thu, 22 Mar 2018 08:22:33 +0100
MIME-Version: 1.0
In-Reply-To: <53afdf9c-33a4-bc60-d3f9-291477aa3f24@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y
 causes random process corruption in xenomai 2.6.0 on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Philippe,

thanks for responding that fast. I've only just realized that I posted 
on the wrong list. Sorry for that.

We currently running Xenomai 2.6.5 and the Problems still exists:
Random Crashes of Xenomai- and Non-Xenomai Processes with SIGSEG and 
SIGILL at various positions without any recognisable correlations.

This means, that the Patch
 > commit ffc58d175a4e6f335c0e42946fa45ca984a93ce4
 > Author: Philippe Gerum <rpm@xenomai.org>
 > Date:   Wed Jan 4 14:14:11 2012 +0100
 >
 >      hal/powerpc: plug race in thread context switch
does not fix the problem in our case - sorry.

My recommendation at least on an old MPC5200 processor is to disable the 
unlocked-switch functionality to prevent this crashes. In the meantime, 
our test systems run ten times as long without any abnormalities.

This is what my original post should mention for all guys stumbling over 
this thread while digging for this random crashes.

Now I understand, that removing this feature in Xenomai-3 was not driven 
by bug reports. My mistake.

Thanks!

