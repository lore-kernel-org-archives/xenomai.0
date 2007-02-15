Message-ID: <45D43650.9000109@domain.hid>
Date: Thu, 15 Feb 2007 11:30:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	<45D171F9.7000705@domain.hid>	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>	<45D192EB.9030608@domain.hid>	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>	<45D2CE22.5010105@domain.hid>	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>	<45D421EA.5070507@domain.hid>	<e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>	<45D431CF.5090201@domain.hid>
	<e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
In-Reply-To: <e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Preetam Joshi wrote:
> Hi using it inside the task loop wwud give me RT_TASK_info as undeclared
> its a global structure even as mentioned in the API documentation and
> the behavior wud neways still remain the same as i mentioned in the code?
> 
> Please execute the code and comment.

I see nothing in rt_task_inquire documentation which suggests that info
should be a global variable. Please make the variable info local to each
thread, and call rt_task_inquire every time you want to get a task's
priority. If you still observe something abnormal, please report.

-- 
                                                 Gilles Chanteperdrix

