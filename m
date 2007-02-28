Message-ID: <45E58FA6.6000504@domain.hid>
Date: Wed, 28 Feb 2007 15:20:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] task not being scheduled
References: <45E494AC.5050603@domain.hid> <200702280750.24918.jweber@domain.hid>
	<45E58DA9.5030907@domain.hid>
In-Reply-To: <45E58DA9.5030907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jeff Weber <jweber@domain.hid>

Jan Kiszka wrote:
> Jeff Weber wrote:
> 
>>Switching to the linked timer list from the heap list fixed it.
>>
> 
> 
> OK, good to know.
> 
> Gilles, could you provide some ready-to-apply instrumentation patch?

Yes, the mail with attached patch did not make it to the list, but I
just finished my work on the ARM patch for Linux 2.6.19, so, I have time
to spend on this issue.

> 
> Jeff, you have the ultimate test case now. Will you have some time to
> run that test on your box so that we can quickly find and resolve the bug?

Is it possible to get a simplified version of the application you are
running with only timer-related events ? Some kind of model that I could
quietly run in the simulator ?

-- 
                                                 Gilles Chanteperdrix

