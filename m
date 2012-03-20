Message-ID: <4F688CBA.5070509@domain.hid>
Date: Tue, 20 Mar 2012 14:57:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CB8E02E7.1EE1F%glen@domain.hid>
In-Reply-To: <CB8E02E7.1EE1F%glen@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: xenomai@xenomai.org

On 03/20/2012 02:48 PM, Glen Wernersbach wrote:
> I don't think this is it directly.
>
> This program was made on the same kernel prior to patching it with Xeno.
>
> It should still run like any other linux program.

- what does "program not working" mean in your case? Any errno return we=20
could interpret? Any strace output?

- what if you disable CONFIG_XENO_OPT_SKIN_RTDM, leaving PERVASIVE on?


>
>
>
>
> On 3/20/12 9:44 AM, "Philippe Gerum"<rpm@xenomai.org>  wrote:
>
>> On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
>>> Hi All,
>>>
>>> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when
>>> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time linux
>>> serial write then read serial program does not work.
>>>
>>> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work.
>>>
>>> Any ideas why?????
>>>
>>
>> A possible explanation would be that your application links with the
>> Xenomai POSIX lib (libpthread_rt), albeit it should not.
>>
>> With pervasive support disabled, any routing from the overloaded POSIX
>> I/O calls to the Xenomai kernel would then fail.
>>
>> If so, you should not link against the Xenomai libs if you need no -rt
>> service, or prevent symbol wrapping only for the POSIX I/O calls by
>> prefixing them by __real_* if you want Xenomai-enabled POSIX services
>> except the I/O support.
>>
>> See http://xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
>>
>>>
>>> Also, when you turn CONFIG_XENO_OPT_PERVASIVE you get this error:
>>> CC kernel/xenomai/nucleus/synch.o
>>> kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
>>> kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of
>>> function 'xnthread_get_rescnt'
>>> kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of
>>> function 'xnshadow_send_sig'
>>>
>>> I had to go in and make the code for that option befor it always false.
>>>
>>
>> http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4bdf=
06107a788b76
>> 2b5cf662b1d4108
>>
>>
>>> Glen
>>> --
>>> Glen Wernersbach
>>> President&  CTO
>>>
>>> Jetsoft Development Co.
>>> 629 Old St Rt. 74 =AD Suite 210
>>> Cincinnati, Oh 45244
>>> Custom Programming Web Site: www.jetsoftdev.com
>>> Retail Products Web Site: www.scanhelp.com
>>> Phone: 513-528-6660
>>> Fax: 513-528-3470
>>> Cell 513-240-9929
>>> ----
>>> Partner for Software Technology
>>> Jacobs Automation
>>> 2365 Progress Drive
>>> Hebron, KY 41048
>>> (513) 297-7550
>>> ----
>>> "Support Dyslexia Research"
>>>
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>
>


--=20
Philippe.

