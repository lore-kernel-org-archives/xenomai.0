Message-ID: <47677A8C.3060107@domain.hid>
Date: Tue, 18 Dec 2007 08:45:16 +0100
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] migrating task code from rtai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,
I have got a rtai task created as follow, it creates and deletes itself :


void *callbacktask(void *)
{

rt_task_init(...)


while (!stopped)
	{
	....
	}

rt_task_delete(...)

}

what are the replacement functions I could use in xenomai to do the same
thing avoiding breaking lot of code?

Note: I can not use RTAI skins in this xeno system .
Best Regards
Steph



