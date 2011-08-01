Message-ID: <4E36E6E0.1080806@domain.hid>
Date: Mon, 01 Aug 2011 19:48:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E367A11.3050001@domain.hid> <4E36BB3B.60308@domain.hid>
	<4E36C3C3.7060408@domain.hid>
In-Reply-To: <4E36C3C3.7060408@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_suspend,
 rt_task_delete chooses wrong tasks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 08/01/2011 05:18 PM, Roberto Bielli wrote:
> Hi,
> 
> i send the source files with the initialization.
> In the file apgs.c there is the main procedure that call the function 
> InitRTEnv() that initialize all.
> 
> Thanks a lot
> 
> Best regards
> 
> Il 01/08/2011 16:42, Gilles Chanteperdrix ha scritto:
>> Could you show us the code which initializes the rtDesc member of the
>> structure, in order to allow us reproducing your scenario?
> 
> 

There is way too much code to be sure that the bug comes from Xenomai.
Please try and reduce the code to a simple, self-contained (and I stress
it) test case.

-- 
                                                                Gilles.

