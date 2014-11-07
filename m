From: ZIV-Alberto Ozalla Cantabrana <alberto.ozalla@cgglobal.com>
Date: Fri, 7 Nov 2014 09:25:21 +0000
Message-ID: <545C9001.7070508@cgglobal.com>
References: <545B9297.2090003@cgglobal.com> 
 <20141106153738.GC30908@sisyphus.hd.free.fr> 
 <545B994D.1080008@cgglobal.com> 
 <20141106155503.GD30908@sisyphus.hd.free.fr> 
 <545BA5D0.7010907@cgglobal.com> <545BD88B.3030700@xenomai.org>
In-Reply-To: <545BD88B.3030700@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <689C32C05038E24585BE389A5E665404@cgglobal.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rt_task_sleep_until() miss release point?
Reply-To: alberto.ozalla@cgglobal.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


On 06/11/14 21:22, Philippe Gerum wrote:
> On 11/06/2014 05:46 PM, ZIV-Alberto Ozalla Cantabrana wrote:
>> Hi,
>>
>> These are the simplest examples:
>> There are no MSW for Test_Task.
>> The goal is to increment counter_ms each millisecond.
>>
>> Given that:
>> 1000000 nanoseconds =3D 24000 tsc.
>> 1 tsc =3D 41 ns
>>
> Is rt_timer_ns2tsc(1000000) actually returning 24000 on your platform?
> Yes.
>> void Test_Task(void *arg)
>> {
>>     rt_task_set_mode(0, 0, NULL);
> This is useless and not recommended. A newly created task always starts
> in primary mode.
>
> Ok. I will delete it.
>>      while (1) {
>>
>>              unsigned long long before =3D counter_ms;
>>              usleep(1000000);    // 1 second.
> Although this would rather cause higher count values, this non-rt main
> using a non-rt sleep service won't give you an accurate delay for the
> measurement.
>
> It is only an example.

--=20
Saludos,
Alberto Ozalla


CG DISCLAIMER: This email contains confidential information. It is intended=
 exclusively for the addressees. If you are not an addressee, you must not =
store, transmit or disclose its contents. Instead please notify the sender =
immediately; and permanently delete this e-mail from your computer systems.=
 We have taken reasonable precautions to ensure that no viruses are present=
. However, you must check this email and the attachments, for viruses. We a=
ccept no liability whatsoever, for any detriment caused by any transmitted =
virus.

