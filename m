Message-ID: <47A88818.3060705@domain.hid>
Date: Tue, 05 Feb 2008 17:00:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47A87D3A.3010608@domain.hid>
In-Reply-To: <47A87D3A.3010608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT-Socket CAN vs. Mainline API
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
Cc: Xenomai-core@domain.hid

Hi Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> painting some slides, I came across a statement from an older set:
> "RT-Socket CAN is compatible with non-RT Socket CAN for Mainline". I
> haven't tracked all details of the Socket CAN recently, I only recall
> that (some/all?) IOCTLs died. What is the current state of the RTDM CAN
> profile compared to what we will find in 2.6.25 and later?

The Socket-CAN-Core made it into 2.6.25 but the CAN device interface and
drivers are still missing. All SIO[SG]CAN* IOCTLs requests have been
dropped in favor of SYSFS files because most people think that there is
little chance to get them into mainline. Well, I personally still like
them. Furthermore, the name baudrate has been replaced by bitrate and
some refinement of the bit time setting will be done sooner than later.
Apart from that, RT-Socket-CAN is still compatible with Socket-CAN. When
the Socket-CAN device interface API definition has settled, it's time to
adapt RT-Socket-CAN.

> Consider this thread also as reference for potential futures FAQs. ;)

OK.

Wolfgang.

