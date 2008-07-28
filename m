Message-ID: <488DC34A.9080708@domain.hid>
Date: Mon, 28 Jul 2008 15:02:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b1eafd0be71fdcb22fed5aa2c2395df4@domain.hid>
	<838579f706dd6a30e63a57e40607978e@domain.hid>
In-Reply-To: <838579f706dd6a30e63a57e40607978e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
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

Matthieu wrote:
> 
> On Mon, 21 Jul 2008 16:41:52 +0200, Matthieu
> <matthieu.connaulte_xenomai@domain.hid> wrote:
>> On Thu, 17 Jul 2008 09:49:19 +0200, Matthieu
>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>> Hi,
>>>
>>> I have a problem with xntbase_update(wind_tbase,1000000); because it
>>> doesn't give me a 1ms period. The period is given as a count of
>>> nanoseconds
>>> as it is said in the API documentation. I search solution around
>>> tick/nanoseconds conversion or periodic/aperiodic timebase but I didn't
>>> solve my problem. Moreover, when I call this instruction,
>>> /proc/xenomai/timebases gives me a vxworks resolution of 1000000, what
>> is
>>> correct, but the period seem's to be 0.452ms . Could you tell me what
>> I've
>>> done wrong ?
>>>
>>> Thank you.
>>>
>>> Matthieu.
>>>
>>>
>> Hi,
>>
>> As I have no news, I would like to know if there is any solution to this
>> problem ?
>>
>> PS : I also have no return concerning xntbase_bind/unbind implementation.
>> Is it still planned ?
>>
>> Thank you in advance for your answers
>>
>> Matthieu
>>
> 
> Hi,
> 
> I didn't archieve in using xntslave_start/stop(), as I didn't find the
> header and/or the lib to link. Could you help me ?

We have helped you a lot already. You have a full mailing thread of
advices, you have online documentation, if that is not enough, xenomai
installs documentation locally. If that is still not enough, you can
resort to the sources.

So now, stop asking questions, read what you have at hand and get the
job done.

-- 
                                                 Gilles.

