Date: Wed, 12 Oct 2005 07:45:23 -0700
Subject: Re: [Xenomai-help] more on registry stuff
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF726F93.17F8%steve@domain.hid>
In-Reply-To: <434D20EA.9070905@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Well, last time it occurred I just did a ls /proc/xenomai/registry/mutexes

I saw a two names of each mutex. I didn't look at any other stats. Next time
it occurs I'll do that.

Steven

On 10/12/05 7:42 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
>> My app always creates a set of mutexes with the same name. I do this when
>> creating them:
>> 
>>     if(name&&!rt_mutex_bind(&_m, name, TM_NONBLOCK))
>> assert(!rt_mutex_delete(&_m));
>> 
>> 
>> This way, if it already exists, I delete it. Then I create it again.
>> 
>> They do not seem to delete. In fact, I see some duplicate names in
>> /proc/registry/mutex
>> 
> 
> Any /proc output to get more details?
> 
>> Steven 
>> 
>> 
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>> 
> 


