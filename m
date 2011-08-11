Message-ID: <4E43A2BE.4080903@domain.hid>
Date: Thu, 11 Aug 2011 11:37:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110809174031.7B1346B2@domain.hid>	<1312905835.2112.106.camel@domain.hid>
	<20110811103352.902F5E9E@centrum.cz>
	<1313053817.2133.71.camel@domain.hid>
In-Reply-To: <1313053817.2133.71.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

On 08/11/2011 11:10 AM, Philippe Gerum wrote:
> On Thu, 2011-08-11 at 10:33 +0200, Petr Cervenka wrote:
>> Hello.
>>
>> I created a simple examples which describe my problem.
>> It is some kind of server and client.
>> At first run a qserver and then qclient.
>> After that close the qserver and try to run it again.
>> It disallows (in my configuratio) to create the queue because it already exists and also the binding to it fails with error -EACCES.
>> This behavior continues till the qclient is closed. It's perhaps caused by the rt_queue_delete() at the end of qserver.
> 
> That is the intended behavior. When deleted, the queue is maintained
> internally until the last client bound to it exits, which also disallows
> creating another queue with the same name until the latter event
> happens.
> 
> However, deleting the queue also makes it unreachable for further
> bindings, until it is completely dismantled after the last client exits.
> At which point you may re-create a queue with the same name and bind to
> it. Logically speaking, that deleted queue does not exist anymore,
> except for the currently bound client(s), for consistency reasons.

Maybe we could return -EIDRM instead of -EEXIST when in this case?

-- 
					    Gilles.

