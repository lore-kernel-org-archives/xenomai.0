Message-ID: <50927614.5090101@ruggedcom.com>
Date: Thu, 1 Nov 2012 09:16:04 -0400
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
References: <50918734.3090605@ruggedcom.com>
	<45c36ddf13bd0bd3bdc199be436c8325.squirrel@www.xenomai.org>
In-Reply-To: <45c36ddf13bd0bd3bdc199be436c8325.squirrel@www.xenomai.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Improper closure of rt pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 31/10/12 06:50 PM, Gilles Chanteperdrix wrote:
> Makarand Pradhan wrote:
>> Hi All,
>>
>> While working with rt pipes I noticed that:
>>
>>   >  When a process that is writing to the real time pipe is killed, I am
>> not able to write to the pipe again after restarting the process.
>>   >  When the pipe is closed properly with an fclose, then everything works.
>>   >  The only way to recover the rt pipe was to reboot the system.
>>
>> Would highly appreciate if you can comment on this behaviour.
>> Is it the expected behaviour?
>> Is there a way to recover the rt pipe without rebooting? Anything that
>> can be done, on the other side of the pipe after detecting closure? I
>> have tried deleting and recreating the pipe with no luck. I am running
>> in user space so cannot flush the pipe.
>>
>> Am attaching code that can be used to reproduce this issue.
>>
>> I am running linux 3.0.0 on MPC8360.
> Since it looks like a Xenomai bug, the really important information is the
> version of Xenomai you are using. Anyway, this looks like a bug that was
> reported a long time ago and fixed recently. Could you try the current HEAD
> of the "master" branch in xenomai 2.6 git?
>
> git://git.xenomai.org/xenomai-2.6.git
>

We are running xenomai-2.6 (stable). Will try to go to the HEAD.

Rgds,
Makarand.

-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


