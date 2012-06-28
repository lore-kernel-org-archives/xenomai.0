Message-ID: <4FEC819D.2080804@epfl.ch>
Date: Thu, 28 Jun 2012 18:09:01 +0200
From: Klas Kronander <klas.kronander@epfl.ch>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>,
	<4FEC4245.9090804@grandegger.com>
	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>
	<4FEC46B5.7060700@grandegger.com> <4FEC5381.9040804@epfl.ch>
	<4FEC570A.8040406@grandegger.com> <4FEC5BD9.4060105@grandegger.com>
In-Reply-To: <4FEC5BD9.4060105@grandegger.com>
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



On 2012-06-28 15:27, Wolfgang Grandegger wrote:
> On 06/28/2012 03:07 PM, Wolfgang Grandegger wrote:
>> On 06/28/2012 02:52 PM, Klas Kronander wrote:
>>> Hi,
>>>
>>> ok did that. The return value from rt_dev_socket is -14. I could not
>>> find the definition of EPROTONOSUPPORT anywhere, so I don't know if this
>>> was the expected value?
>> ~$ errno 14
>> #define	EFAULT		14	/* Bad address */
>>
>> Hm, strange. I have to look that up.
> To better understand what you are doing... are you using a Xenomai
> enabled kernel? Does the latency test work?
>
> Wolfgang.

Yes, I am using a Xenomai enabled kernel. None of the tests seem to work 
though.

clocktest just gives me zeros. latency does not show anything. I have 
tried to recompile the kernel, still the same result. How find out 
what's wrong? I followed the guidlines on the xenomai website for the 
kernel configuration.

Thanks,
Klas


