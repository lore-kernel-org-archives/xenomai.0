Message-ID: <45D41B31.6070400@domain.hid>
Date: Thu, 15 Feb 2007 09:34:57 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D338C2.9030203@domain.hid>
In-Reply-To: <45D338C2.9030203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Extended CAN frame filtering
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

Hi Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> unless I messed something up, the first patch aligns the implementation of
> Socket-CAN filters in Xenomai with their current specification. Right now, if you
> set a filter on a standard frame ID, you will also receive extended frames with
> the same ID. In contrast, when the extended bit is set, only extended frames are
> received, not standard frames with the same ID (that's again spec-conforming).
> 
> --- ksrc/drivers/can/rtcan_raw_filter.c	(Revision 2178)
> +++ ksrc/drivers/can/rtcan_raw_filter.c	(Arbeitskopie)
> @@ -55,11 +55,11 @@ void rtcan_raw_print_filter(struct rtcan
>  static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
>  					  can_filter_t *filter)
>  {
> -   if (filter->can_id & CAN_EFF_FLAG)
> -	recv_filter->can_mask = ((filter->can_mask & CAN_EFF_MASK) |
> -				 CAN_EFF_FLAG);
> +    if (filter->can_id & CAN_EFF_FLAG)
> +	recv_filter->can_mask = filter->can_mask & CAN_EFF_MASK;
>      else
> -	recv_filter->can_mask = (filter->can_mask & CAN_SFF_MASK);
> +	recv_filter->can_mask = filter->can_mask & CAN_SFF_MASK;
> +    recv_filter->can_mask |= CAN_EFF_FLAG;
>  
>      recv_filter->can_id = filter->can_id & recv_filter->can_mask;
>  } 
> 
> 
> However, I wonder if this behaviour is useful. You can now either set a filter
> for extended frames or standard frame, not for both frame type, just varying on
> the ID length. If we consider EFF just as another bit of the CAN ID, we could
> take this into account for the mask:
> 
> --- ksrc/drivers/can/rtcan_raw_filter.c	(Revision 2178)
> +++ ksrc/drivers/can/rtcan_raw_filter.c	(Arbeitskopie)
> @@ -55,11 +55,12 @@ void rtcan_raw_print_filter(struct rtcan
>  static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
>  					  can_filter_t *filter)
>  {
> -   if (filter->can_id & CAN_EFF_FLAG)
> -	recv_filter->can_mask = ((filter->can_mask & CAN_EFF_MASK) |
> -				 CAN_EFF_FLAG);
> +    if (filter->can_id & CAN_EFF_FLAG)
> +	recv_filter->can_mask = filter->can_mask &
> +				(CAN_EFF_MASK | CAN_EFF_FLAG);
>      else
> -	recv_filter->can_mask = (filter->can_mask & CAN_SFF_MASK);
> +	recv_filter->can_mask = filter->can_mask &
> +				(CAN_SFF_MASK | CAN_EFF_FLAG);
>  
>      recv_filter->can_id = filter->can_id & recv_filter->can_mask;
>  }
> 
> 
> Note: this alternative patch would also require a patch to rtdm/rtcan.h.
> 
> Actually, the second variant was what I intuitively expected. What is the
> behaviour of non-RT Socket-CAN here?

Hm, good question. I'm going to ask on the Socket-CAN-ML later today.

> 
> Jan
> 
> 
> PS: A few lines above those hunks is still a "#if 0" code block. Either make
> this configurable or please clean it up.

OK.

Wolfgang.


