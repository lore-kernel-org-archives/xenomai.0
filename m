Message-ID: <4C7CA866.2070001@domain.hid>
Date: Tue, 31 Aug 2010 08:59:50 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTimb-CBofvdOa7EVcDTDb0418dJauwhxRNjz4=hJ@mail.gmail.com>
In-Reply-To: <AANLkTimb-CBofvdOa7EVcDTDb0418dJauwhxRNjz4=hJ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Looking for PC104 CAN stacks working under
	xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

On 08/31/2010 12:45 AM, Willy Lambert wrote:
> Hi,
> 
> I am looking for a PC104 CAN stack that would be easy to integrate for free
> with xenomai, in other words with a compatible driver distributed on the
> web. Issomeone using this kind of board ?
> 
> The main board used is :
> http://www.advantech.com/products/PCM-3362/mod_1-DWE9TQ.aspx
> (I have no doubt about xenomai running on it properly)

The supported devices are listed in the Kconfig file(s):

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja1000/Kconfig

Wolfgang.

