Message-ID: <2ff1a98a0805150704x2c45dd42me183531144d73237@domain.hid>
Date: Thu, 15 May 2008 16:04:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <955c7c82b3624040fbf69ee97e7177dc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>
	<955c7c82b3624040fbf69ee97e7177dc@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Thu, May 15, 2008 at 3:50 PM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
>
>
> On Thu, 15 May 2008 15:12:32 +0200, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On Thu, May 15, 2008 at 8:10 AM, Matthieu
>>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>>  I think
>>>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping
>> the
>>>> context in hard real-time. That's why I would like to know if there are
>>>> other possibilities ?
>>>
>>> Yes, there are possibilities: fix your code not to use such internal
>>> data as the WIND_TCB members.
>>
>> Even VxWorks documentation considers accessing WIND_TCB directly as a
>> bad practice. See the doc of taskInfoGet at:
>>
>>
> http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.html
>>
>> So, what I would agree we can do is implement taskInfoGet.
>>
>> --
>>  Gilles
>
> Well, what a great issue for me...
>
> But can I use other API implements of such kind of Tasks information, as
> it's possible to mix APIs ? I think about Task Status or Thread State Flags
> ?

The native task has rt_task_inquire. But rt_task_inquire, though it
returns skin independent data, requires a native task pointer.

So what you are missing is really taskInfoGet.

-- 
 Gilles

