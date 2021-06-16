Subject: Re: Large gpio interrupt latency
References: <1202-60c9c080-151-1ab27320@266229055>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1818b5b8-7f6d-77d4-2354-6180a8541664@siemens.com>
Date: Wed, 16 Jun 2021 11:40:12 +0200
MIME-Version: 1.0
In-Reply-To: <1202-60c9c080-151-1ab27320@266229055>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 16.06.21 11:12, François Legal via Xenomai wrote:
> Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan" <hongzhan.chen@intel.com> a écrit: 
>  
>>
>>
>>> -----Original Message-----
>>> From: François Legal <devel@thom.fr.eu.org> 
>>> Sent: Wednesday, June 16, 2021 4:19 PM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>> Cc: xenomai@xenomai.org
>>> Subject: RE: Large gpio interrupt latency
>>>
>>> Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hongzhan.chen@intel.com> a écrit: 
>>>
>>>>
>>>>>
>>>>> -----Original Message-----
>>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of François Legal via Xenomai
>>>>> Sent: Wednesday, June 16, 2021 3:16 PM
>>>>> To: xenomai@xenomai.org
>>>>> Subject: Large gpio interrupt latency
>>>>>
>>>>> Hello,
>>>>>
>>>>> working on a realtime data recorder (for which I submitted a patch to add timestamp retrieval for net packets), I experience a strange latency problem with taking GPIO interrupts.
>>>>>
>>>>> So basically my app monitors network packets (which as received by the DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
>>>>> We know (from some ohter reference instrument) that the DUT would toggle the GPIO 1-2ms after receiving a specific network packet.
>>>>>
>>>>> My recorder app relies on the timestamping of events done in interrupts service routines for GPIOs and network interface. By checking the timestamps returned by the application, I get an about 50ms delay between the network packet and the GPIO (so something between 51 and 52ms delay).
>>>>>
>>>>
>>>> Are you toggling gpio and access gpio device  through your rtdm device like on path /dev/rtdm/your_gpiocontroller/gpio*?
>>>>
>>>
>>> Maybe my setup was not very clear.
>>> I've got a DUT that receives network data, and toggles one of its GPIOs depending one the network data.
>>>
>>> I've got another device running my realtime recording app, that receives the same network data as the DUT, and that has one of its GPIO connected to the DUT GPIO.
>>>
>>> On the recording app, I use the RTDM device to open, ioctl (enable interrupt + timestamp), then select & read the GPIO value.
>>
>> When issue happen, the recording app side have got same number of network data packages and gpio interrupts with that DUT have been toggling?  
>> I am asking this because I met gpio hardware issue that would cause gpio interrupt missing or invalid gpio interrupts when gpio is connecting on two different boards.
>>
> 
> AFAICT, I'm not missing GPIO edges/interrupts in the app. Regarding network, the DUT and the recoding device are connected to the same switch with the same port config.
> 
> Moreover, I tried changing the interrupt polarity of the recording device (switched from rising edge to falling edge), and the result is 1-2ms + ~30ms (the width of the pulse of the DUT) + 50ms latency
> 

Can you (or did you already) break down the latencies on the DUT via
tracing? Is it really the GPIO output path? What is happening in it,
starting with RT/Linux task switches, mode transitions etc.?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

