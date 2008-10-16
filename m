Message-ID: <48F7BD8B.5010209@domain.hid>
Date: Fri, 17 Oct 2008 00:17:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid>	<48F6492C.4090500@domain.hid>	<48F660E7.8090906@domain.hid>	<48F79AF9.6030303@domain.hid>
	<48F7B5F8.7020105@domain.hid> <48F7BA7F.3030007@domain.hid>
In-Reply-To: <48F7BA7F.3030007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> I start to believe we are arguing with different (miss-)use case in
>> mind. Mine is definitely not about "helping" the user to switch the
>> thread mode even more actively. It is about validating application
>> states, it is about thread state reflection without any other actions
>> than reporting errors. T_PRIMARY is part of the picture for the dual
>> kernel Xenomai version, and it will remain such as long as there are two
>> kernels. Even better, it is a very helpful application debugging tool
>> when it comes to runtime validation of their real-time behavior. Again,
>> it is NOT about promoting more use of rt_task_set_mode!
> 
> SIGXCPU may be used validate current thread mode, and it has the
> advantage that it can not be misused.

You are not always able to install or switch signal handlers when
crossing application module boundaries. And you can't use it to validate
the opposite (RT thread calls into lengthy, not RT-context suited
library function).

Jan

