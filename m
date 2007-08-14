Message-ID: <46C14FE2.8000507@domain.hid>
Date: Tue, 14 Aug 2007 08:46:58 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
In-Reply-To: <46C0D686.6000007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Roland Tollenaar wrote:
>>> Hi Wolfgang,
>>>
>>>>> See below. This does not look good. Does it mean that I am only 
>>>>> always reading out the last socket and the rest are having their 
>>>>> buffers pumped full? Should I be unbinding somehow?
>>>> Don't know, check your code ;-).
>>> Thanks that is exactly what I did because I thought I was unbinding. 
>>> rt_dev_close () should do that for me correct? Its not. At least not 
>>> reliably. :(
>> That's wired. You mean you called rt_dev_close() and the socket still 
>> does show up in /proc/rtcan_sockets? Is it possible that there is 
>> another task still using that socket? Could you show the code fragment 
>> doing that.
> 
> Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (with
> -EAGAIN) when some other thread is currently using it and doesn't
> release it immediately when being "asked". That means for now you should
> loop over [rt_dev_]close as long as EAGAIN is returned.

Roland, could you please check the return code of [rt_dev_]close. 
Nevertheless, I'm still puzzled why the socket shows up in 
/proc/rtcan/sockets because rtcan_raw_close() is called before returning 
-EAGAIN and the error mask shown there is weired as well.
Roland, do you perform the open and close in a serialized way (same 
task) and in nrt context?

Wolfgang.



