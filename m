Message-ID: <49EF0630.3010807@domain.hid>
Date: Wed, 22 Apr 2009 13:57:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49EEE65E.6060308@domain.hid> <49EEE9F1.2000204@domain.hid>
	<49EEF2B8.2090702@domain.hid>
In-Reply-To: <49EEF2B8.2090702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with mutexes in daemon
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> Gilles Chanteperdrix napsal(a):
>> Roman Pisl wrote:
>>> Hello,
>>> I'm experiencing weird behavior with mutexes in a daemon application. 
>>> After daemon() is called, unnamed mutexes fail on call 
>>> rt_mutex_release() with -EPERM. Everything is ok for named mutexes.
>>>
>>> Is there something special with daemon and unnamed mutexes - should all 
>>> have name? Or is it a bug? I'm using kernel 2.6.28 and Xenomai 2.4.6.1.
>>>
>>> Example showing this problem is attached.
>> Unnamed mutexes are local to a process. Since forking results in a
>> different process, mutexes are not preserved.
>>
>> Yes, Xenomai behaviour is not intuitive, but fixing this requires
>> internal changes.
>>
> 
> I understand, but daemon() is the first call and everything is done in 
> the new forked process.
> 
> What is the best solution for now? Is everything except unnamed mutexes 
> supposed to work well in daemon or should I cancel the concept of daemon 
> at all?

Yes, what you are doing is supposed to work, I did not look at your
code, I thought you were expecting to be able to create the mutex in a
process and use it in its child.

On what platform do you get these issues ?

-- 
                                                 Gilles.

