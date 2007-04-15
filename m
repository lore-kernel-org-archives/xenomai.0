Message-ID: <46228330.603@domain.hid>
Date: Sun, 15 Apr 2007 21:55:28 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <461D65BC.2090406@domain.hid>
	<46220DC4.9040306@domain.hid>	<46222105.90900@domain.hid>
	<46226E16.9080004@domain.hid>
	<4622729C.4080806@domain.hid> <462274A4.7040409@domain.hid>
In-Reply-To: <462274A4.7040409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CAN_RAW, CAN_PROTO_RAW, and Socket-CAN
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Wolfgang,
>>>>>>
>>>>>> something is inconsistent about CAN_RAW in RT-Socket-CAN compared to
>>>>>> plain Socket-CAN. Also, the latter doesn't know any CAN_PROTO_xxx
>>>>>> unless
>>>>>> I oversee something. Please have a look.
>>>>> There is CAN_PROTO_RAW defined and I have added some time ago
>>>>> CAN_RAW to
>>>>> rtcan.h to be compatible with Socket-CAN:
>>>>>
>>>>>   /** Particular CAN protocols
>>>>>    *
>>>>>    *  Currently only the RAW protocol is supported.
>>>>>    */
>>>>>   #define CAN_RAW  0
>>>> Yes, I know. But the question remains which way to go for rtcan:
>>>> Socket-CAN doesn't know CAN_PROTO_*, RT-Socket-CAN comes with CAN_RAW as
>>>> well now, but having a different value. That should be resolved, on
>>>> whatever side, IMHO.
>>> Ah, now I understand your concern. CAN_PROTO_RAW actually serves the
>>> same purpose then CAN_RAW defining the particular CAN protocol. I'm
>>> going to clean it up soon removing CAN_PROTO_RAW and updating the doc.
>>> CAN_PROTO_RAW was not used by any application, IIRC.
>> The man page for "socket" describes the protocol argument as shown below:
>>
>>        The  protocol specifies a particular protocol to be used with the
>>        socket. Normally only a single protocol exists to support a
>>        particular socket  type within a given protocol family, in which
>>        case protocol can be specified as 0. However, it is possible that
>>        many  protocols  may exist, in which case a particular protocol
>>        must be specified in this manner.
>>
>> A value of 0 is valid for RT-Socket-CAN but not for Socket-CAN.
>> Therefore we need to define CAN_RAW=1 for compatibility reasons.
> 
> Agreed.
> 
> Moreover, 0 means "unspecified default protocol" according to POSIX. On
> what does Socket-CAN map it, CAN_RAW? Anyway, we have no other option so
> far with RT-Socket-CAN.

   int rtcan_raw_socket(struct rtdm_dev_context *context,
                        rtdm_user_info_t *user_info, int protocol)
   {
     /* Only CAN_PROTO_RAW is supported */
     if (protocol != CAN_PROTO_RAW && protocol != 0)
         return -EPROTONOSUPPORT;

     rtcan_socket_init(context);

     return 0;
   }

Both, protocol "0" and CAN_PROTO_RAW is OK. I just need to replace 
CAN_PROTO_RAW with CAN_RAW.

Wolfgang.

> Jan
> 


