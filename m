Message-ID: <4ACDE467.9020202@domain.hid>
Date: Thu, 08 Oct 2009 15:08:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000ACAE.4ACDAF68@domain.hid> <4ACDA23D.4000507@domain.hid>
	<4ACDB034.7060801@domain.hid> <4ACDB1F8.6060305@domain.hid>
	<4ACDBBF8.6090007@domain.hid> <4ACDD8B6.4020902@domain.hid>
In-Reply-To: <4ACDD8B6.4020902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "oliver.schlenker@domain.hid" <oliver.schlenker@domain.hid>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> oliver.schlenker@domain.hid wrote:
>>>>>>>> int main( int arc, char *argv[] ) { int i;
>>>>>>>>
>>>>>>>> rt_print_auto_init(1);
>>>>>>>>
>>>>>>>> rt_printf("--------------- TEST RT-PRINTF  1 ------------\n");
>>>>>>>>
>>>>>>>> sleep(1);
>>>>>>>>
>>>>>>>> daemon(0,0);
>>>>>>>>
>>>>>>>> rt_print_auto_init(1);
>>>>>> Ok, understood, at least for the scenario where the rt_print feature
>>>>>> is initialised befor the fork/daemon call. What I don't understand
>>>>>> is, why it does not work if the rt_print feature is initialised after
>>>>>> the fork / daemon.
>>>>> From the way I understand your code, you never tried to initialize the
>>>>> rt_print feature only after the fork, your code initializes it both
>>>>> before and after.
>>>>>
>>>> There are two initializations: The base init done via __rt_print_init on
>>>> library loading and the one to be done per-thread via rt_print_init (or
>>>> on first rt_printf). That printer thread is initialized via the former
>>>> one. On fork, we do not need to re-run the full __rt_print_init
>>>> (variables and resources are cloned on fork), we just need to spawn
>>>> another printer thread.
>>> Unless I am wrong, rtdk also maintains a list of the thread buffers
>>> which need to be polled. After the fork, this list will be intact, but
>>> the threads to which belong the buffers will no longer exist. So, IMO,
>>> the fork handler should also free all these buffers and reset the list
>>> to the empty state.
>> Famous last words: That should work without tweaking. A print_buffer
>> only contains data references, nothing that points to some uncloned thread.
> 
> Ok. But you walk the list of print_buffers every time, and these
> print_buffers remain allocated in the child process. So, that is a kind
> of memory leak.

Hmm, right. They should be freed in the child right after forking.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

