Message-ID: <4FEC8AFB.5070002@xenomai.org>
Date: Thu, 28 Jun 2012 18:48:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>	<4FEC3FF0.1050307@grandegger.com>,
	<4FEC4245.9090804@grandegger.com>	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>	<4FEC46B5.7060700@grandegger.com>
	<4FEC5381.9040804@epfl.ch>	<4FEC570A.8040406@grandegger.com>
	<4FEC5BD9.4060105@grandegger.com> <4FEC819D.2080804@epfl.ch>
	<4FEC8259.2090300@xenomai.org> <4FEC8A85.4050506@epfl.ch>
In-Reply-To: <4FEC8A85.4050506@epfl.ch>
Content-Type: text/plain; charset=UTF-8
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
To: Klas Kronander <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2012 06:47 PM, Klas Kronander wrote:
> On 2012-06-28 18:12, Gilles Chanteperdrix wrote:
>> On 06/28/2012 06:09 PM, Klas Kronander wrote:
>>>
>>> On 2012-06-28 15:27, Wolfgang Grandegger wrote:
>>>> On 06/28/2012 03:07 PM, Wolfgang Grandegger wrote:
>>>>> On 06/28/2012 02:52 PM, Klas Kronander wrote:
>>>>>> Hi,
>>>>>>
>>>>>> ok did that. The return value from rt_dev_socket is -14. I could not
>>>>>> find the definition of EPROTONOSUPPORT anywhere, so I don't know if this
>>>>>> was the expected value?
>>>>> ~$ errno 14
>>>>> #define	EFAULT		14	/* Bad address */
>>>>>
>>>>> Hm, strange. I have to look that up.
>>>> To better understand what you are doing... are you using a Xenomai
>>>> enabled kernel? Does the latency test work?
>>>>
>>>> Wolfgang.
>>> Yes, I am using a Xenomai enabled kernel. None of the tests seem to work
>>> though.
>>>
>>> clocktest just gives me zeros. latency does not show anything. I have
>>> tried to recompile the kernel, still the same result. How find out
>>> what's wrong? I followed the guidlines on the xenomai website for the
>>> kernel configuration.
>> http://www.xenomai.org/index.php/Configuring_x86_kernels#Does_Xenomai_work.3F
>>
> 
> In the syslog it seems as xenomai was initialized properly. The mesages 
> correspond to those on the faq. I also looked through the 
> troubleshooting file, nothing there seems to help my case. I will try to 
> redo everything again with a different kernel version to see if that 
> helps. Any other ideas?

If you are using gcc 4.6.1, please pass CFLAGS=-fno-omit-frame-pointer
on the configure script command line.

-- 
					    Gilles.

