Message-ID: <4A606C1A.9050800@domain.hid>
Date: Fri, 17 Jul 2009 14:18:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid>
	<4A299794.6010504@domain.hid>
	<6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid>
	<4A3010BE.9020107@domain.hid>
	<6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid>
In-Reply-To: <6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Get ready queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thiago Lima <thiagolims@domain.hid>
Cc: xenomai@xenomai.org

Thiago Lima wrote:
> I am doing an schedulability test of real time processes in Xenomai. (...)
> My question is: how can i get all ready xenomai tasks ? Because i need
> to get the amount of threads to do this test.
> 
> Sorry for my last email. I have not so much time to write and it was vague.

I do not think you can do this schedulability test in general, you need
some additional data for each task, such as activation period and WCET,
so, what you should do is use Xenomai 2.5 and create your own scheduler
classes, and keep the list of tasks using these classes, presumably in
the per-class data. Then you would do the schedulatbility test only for
tasks in these classes.

-- 
                                          Gilles


