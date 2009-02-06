Message-ID: <498C01C0.8010607@domain.hid>
Date: Fri, 06 Feb 2009 10:24:16 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>
In-Reply-To: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] timed looping task in device driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zara Tustra <zarawesome@domain.hid>
Cc: xenomai@xenomai.org

Zara Tustra wrote:
> How would I set up a task that, say, turns a led on and off every second, in
> a device driver (module)? I've tried using rtdm_task_init and it's
> successful, but when I use rtdm_task_wait_period, it returns -EINVAL.

Xenomai has a useful API documentation where all API calls and the 
return values are well explained. For your case see

http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmtask.html#g577886a7588cdceac10f1b7b6ffcd1c7

-- 
Sebastian

