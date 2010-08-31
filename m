From: Josh Karch <JKarch@domain.hid>
Date: Mon, 30 Aug 2010 17:20:03 -0700
Message-ID: <843773D242212C4882D4EDFFBF665F7F3F0991D4BB@FW-SBS.fw.local>
References: <AANLkTimb-CBofvdOa7EVcDTDb0418dJauwhxRNjz4=hJ@mail.gmail.com>
In-Reply-To: <AANLkTimb-CBofvdOa7EVcDTDb0418dJauwhxRNjz4=hJ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Willy Lambert <lambert.willy@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

_______________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Willy Lambert [lambert.willy@domain.hid]
Sent: Monday, August 30, 2010 3:45 PM
To: xenomai@xenomai.org
Subject: [Xenomai-help] Looking for PC104 CAN stacks working under xenomai

Hi,

I am looking for a PC104 CAN stack that would be easy to integrate for free=
 with xenomai, in other words with a compatible driver distributed on the w=
eb. Issomeone using this kind of board ?

The main board used is :
http://www.advantech.com/products/PCM-3362/mod_1-DWE9TQ.aspx
(I have no doubt about xenomai running on it properly)

Thank in advance for your help.




Peak makes PCI-104 based CAN cards. Make sure to use the RTDM CAN driver, a=
s Peak's driver is (was?) buggy and makes calls outside of primary mode.

Josh Karch=

