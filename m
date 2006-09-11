From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] external hardware interupts on a PPC405
Date: Mon, 11 Sep 2006 08:17:26 +0200
References: <E1GMOIv-000171-QV@server-r004.hostpoint.ch>
	<4504EA2C.4080604@domain.hid>
In-Reply-To: <4504EA2C.4080604@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609110817.27018.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Monday 11 September 2006 06:46, Philipp Keller wrote:
> We are using ppc6xx, but hat a timing problem with external HW, perhaps
> this is related to that interrupt thing? We saw on the oszilloscope that
> we have to init the rtcan with half the baudrate the external modules
> use, then it works.
> Philipp
It is true that you have to pass the clock frequency divided by two to the 
rtcan drivers. This is discussed in a separate thread (see "CAN updates & 
questions"). 

My problem is propably not related to the rtcan drivers because sending and 
receiving a single message always works fine. 

Matthias

