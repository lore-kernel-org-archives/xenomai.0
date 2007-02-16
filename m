Message-ID: <45D5A56F.8080900@domain.hid>
Date: Fri, 16 Feb 2007 13:37:03 +0100
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

I checked the filter related code of Socket-CAN. They use a more 
sophisticated filtering scheme:

   if      (filter.can_id & 0x40000000) [CAN_RTR_FLAG]
     accept if ((can_id & filter->can_mask) == filter->can_id)
   else if (filter.can_id & 0x20000000) [CAN_INV_FILTER]
     accept if ((can_id & filter->can_mask) != filter->can_id)
   else if (filter->can_mask == 0)
     accept all messages
   else if filter.can_id & 0x80000000) [CAN_EFF_FLAG]
     accept if (can_id == filter->can_id)
   else
     accept if (can_id == filter->can_id)

In other words, you can define a positive or negative filter using id 
and mask, accept all messages or require an exact id match for standard 
or extended frames. Well, we need something compatible and for this 
reason I triggered a discussion on the Socket-CAN-ML.

Wolfgang.

