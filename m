Message-ID: <46C15CBA.8010804@domain.hid>
Date: Tue, 14 Aug 2007 09:41:46 +0200
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
	<46C14FE2.8000507@domain.hid>
In-Reply-To: <46C14FE2.8000507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Hi,

>> Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (with
>> -EAGAIN) when some other thread is currently using it and doesn't
>> release it immediately when being "asked". That means for now you should
>> loop over [rt_dev_]close as long as EAGAIN is returned.
> 
> Roland, could you please check the return code of [rt_dev_]close. 
> Nevertheless, I'm still puzzled why the socket shows up in 
> /proc/rtcan/sockets because rtcan_raw_close() is called before returning 
I have been battling with this all morning. I close with

do{
	ret=rt_dev_close(can_fd);
	//printf("%d",ret)
while(ret!=-9)

but this only works (without fail) if I uncomment the printf line. I 
have now tried to put in a sleep(1) command instead but due to the crash 
caused  by commenting out hte crash (does not come out of loop) I am now 
trying to save my filesystem. :( :(.





> -EAGAIN and the error mask shown there is weired as well.
> Roland, do you perform the open and close in a serialized way (same 
> task) and in nrt context?
I call the rt_dev_close in non-real time code if that is what you are 
asking. Same with the init AFAIK. I will post the code if I can retrieve it.

Roland



> 
> Wolfgang.
> 
> 
> 

