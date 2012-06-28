Message-ID: <4FEC5381.9040804@epfl.ch>
Date: Thu, 28 Jun 2012 14:52:17 +0200
From: Klas Kronander <klas.kronander@epfl.ch>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>,
	<4FEC4245.9090804@grandegger.com>
	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>
	<4FEC46B5.7060700@grandegger.com>
In-Reply-To: <4FEC46B5.7060700@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

ok did that. The return value from rt_dev_socket is -14. I could not 
find the definition of EPROTONOSUPPORT anywhere, so I don't know if this 
was the expected value?

Thanks,
Klas


On 2012-06-28 13:57, Wolfgang Grandegger wrote:
> Hello,
>
> On 06/28/2012 01:45 PM, Kronander Klas wrote:
>> Hi,
>>
>> I still get the same error:
>>
>> mode: start(0x1)
>> Cannot open RTDM CAN Socket. Maybe Driver not loaded?
>>
>> I guess this error message is related to this line in my syslog (?) :
>>
>> Jun 28 11:58:14 wam-desktop kernel: [   13.017820] Xenomai: xnintr_shirq_handler: IRQ17 not handled. Disabling IRQ line.
>>
>> the CAN card is on IRQ 17.
> I don't think so. It's an unrelated issue. There is a problem with the
> protocol in the first place. Could you please hack "rtcanconfig.c" to
> print the return value of rt_dev_socket? Most likely it will return
> -EPROTONOSUPPORT.
>
> Wolfgang.


