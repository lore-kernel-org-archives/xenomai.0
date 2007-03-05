From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] catching CAN errors
Date: Mon, 5 Mar 2007 12:06:11 +0100
References: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
In-Reply-To: <bc4264770703030554g658d3284y297b22af22375e0a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOB10-0007rm-Hj@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
>
> What I cannot find an example of is how to filter for more than one error?
>
> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
> &err_mask, sizeof(err_mask));
>
> will pick out the messages that correspond to err_mask. At the moment
> I seem to be picking up CAN_ERR_BUSERROR but not for example
> CAN_ERR_CRTL (mind you I presume the latter should have been
> CAN_ERR_CTRL which is a bit more intuitive). If I want to pick up both
> can I do this
>
>
> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
> &err_mask1, sizeof(err_mask1));
>
> ret = rt_dev_setsockopt(can_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
> &err_mask2, sizeof(err_mask2));
>
> to set up to get errors of two types or can I only pick up one at a time.?

The error mask is called a *mask* because you can mask those errors you are 
interested in. Of course you can set the error *bits* in one mask. Just OR 
them.


>
> This is what my CanID and the data sequence looks like:
>
> !0x00000088!<0x088> [8] 00 00 80 19 00 00 00 00
>
> 0x00000080 is CAN_ERR_BUSERROR  and
> 0x00000008 is protocol violation CAN_ERR_PROT.
>
> So I seem to have those two errors. Correct?
>
> -What is a protocol error?

Either consult the CAN specification or look at the protocol error types in 
the RT-Socket-CAN documentation [1] which give you a rough overview what a 
protocol error is. In short: It is a violation against the defined CAN 
protocol.

>
> The values in data 2 and 3 seem to say
>
> data 2:  80 Error occurred on transmission
> data 3 19 Ack Slot?
>
> The first one I can understand I have nothing connected to the bus,
> the second one
> What does the second one mean?

It means that no one has ack'ed your transmission. This makes sense since you 
didn't connect anything.


[1] 
http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#g6cf7ee3a3d83315ed2589bb3bdb816b3

--
Sebastian

