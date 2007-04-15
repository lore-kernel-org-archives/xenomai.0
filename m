Message-ID: <46220DC4.9040306@domain.hid>
Date: Sun, 15 Apr 2007 13:34:28 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <461D65BC.2090406@domain.hid>
In-Reply-To: <461D65BC.2090406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Hi Wolfgang,
> 
> something is inconsistent about CAN_RAW in RT-Socket-CAN compared to
> plain Socket-CAN. Also, the latter doesn't know any CAN_PROTO_xxx unless
> I oversee something. Please have a look.

There is CAN_PROTO_RAW defined and I have added some time ago CAN_RAW to 
rtcan.h to be compatible with Socket-CAN:

   /** Particular CAN protocols
    *
    *  Currently only the RAW protocol is supported.
    */
   #define CAN_RAW  0

> (I received a private complaint of a user trying to compile rtcan_rtt
> against 2.3.x.)

The latter definition is missing in 2.3.x, though and compiling 
rtcan_rtt.c from the trunk will fail for this reason. I'm going to fix 
it later today.

Wolfgang.


