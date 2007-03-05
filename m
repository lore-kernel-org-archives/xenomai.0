Message-ID: <45EBFD8F.4070707@domain.hid>
Date: Mon, 05 Mar 2007 12:22:55 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] catching CAN errors
References: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
	<E1HOB10-0007rm-Hj@domain.hid>
In-Reply-To: <E1HOB10-0007rm-Hj@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Hi ,

thanks for this. Is it correct that the errors come in on the 
messagebuffer where normal can frames also get read from? If so I 
presume this is normal CAN behavior but it does cause the message-buffer 
to overflow which in turn causes system messages to be generated which 
in turn messes up the RT behaviour of the entire application. If I have 
problems on the CAN bus I do not want the RT behavior of other parts of 
the application to be affected. So how can i prevent the error messages 
causing the message-buffer to overflow?

P.S. this question is related to another thread where the current 
standing is that I would have to switch off whatever is writing the 
system messages, i.e. syslogd?

If I can prevent the CAN errors coming in on the message buffer or 
rather maybe reduce their intensity (once is really enough I don;t need 
to be notified 100 billion times) that would be an elegant manner too.

Thanks for your time.

Regards,

Roland

Sebastian Smolorz wrote:
> roland Tollenaar wrote:
>> Hi,
>>
>> What I cannot find an example of is how to filter for more than one error?
>>
>> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>> &err_mask, sizeof(err_mask));
>>
>> will pick out the messages that correspond to err_mask. At the moment
>> I seem to be picking up CAN_ERR_BUSERROR but not for example
>> CAN_ERR_CRTL (mind you I presume the latter should have been
>> CAN_ERR_CTRL which is a bit more intuitive). If I want to pick up both
>> can I do this
>>
>>
>> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>> &err_mask1, sizeof(err_mask1));
>>
>> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>> &err_mask2, sizeof(err_mask2));
>>
>> to set up to get errors of two types or can I only pick up one at a time.?
> 
> The error mask is called a *mask* because you can mask those errors you are 
> interested in. Of course you can set the error *bits* in one mask. Just OR 
> them.
> 
> 
>> This is what my CanID and the data sequence looks like:
>>
>> !0x00000088!<0x088> [8] 00 00 80 19 00 00 00 00
>>
>> 0x00000080 is CAN_ERR_BUSERROR  and
>> 0x00000008 is protocol violation CAN_ERR_PROT.
>>
>> So I seem to have those two errors. Correct?
>>
>> -What is a protocol error?
> 
> Either consult the CAN specification or look at the protocol error types in 
> the RT-Socket-CAN documentation [1] which give you a rough overview what a 
> protocol error is. In short: It is a violation against the defined CAN 
> protocol.
> 
>> The values in data 2 and 3 seem to say
>>
>> data 2:  80 Error occurred on transmission
>> data 3 19 Ack Slot?
>>
>> The first one I can understand I have nothing connected to the bus,
>> the second one
>> What does the second one mean?
> 
> It means that no one has ack'ed your transmission. This makes sense since you 
> didn't connect anything.
> 
> 
> [1] 
> http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#g6cf7ee3a3d83315ed2589bb3bdb816b3
> 
> --
> Sebastian
> 

