Subject: Re: NXP i.MX RT support
References: <fe936315-6db1-d542-e80e-d4bc31d091d0@bluewin.ch>
 <CALLqZ8TNa2TAXxwnBVFu4SbxmuspWQWhsUOWw319eW=Crf_Uhg@mail.gmail.com>
From: Stephan Brauss <sbrauss@bluewin.ch>
Message-ID: <37e844bb-f50d-115f-fe63-1526119114f8@bluewin.ch>
Date: Thu, 21 Feb 2019 08:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TNa2TAXxwnBVFu4SbxmuspWQWhsUOWw319eW=Crf_Uhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

I'm still in the process of finding the best suited device for my needs 
(already or nearly ported Linux/Xenomai, "some MCU features" (GPIO, CAN, 
ADC, if possible PWM), graphics core with "good" 2D speed, <10$).
Am I right that the support of the i.MX6 family only means the Corted-A9 
based devices? - NXP offers also an i.MX6ULL that probably would also be 
a good choice for me, but this is Corted-A7 based and is also different 
in many other aspects.

Thanks & best regards,
Stephan



Am 20.02.2019 um 17:25 schrieb Greg Gallagher:
> As far as I know Xenomai hasn't run on the Cortex-M series processors.
> Having said that I've seen some presentations about getting Linux to
> run on the larger M7 and M4 cores so it's possible you could try to
> get Xenomai to run.
> 
> -Greg
> 
> On Wed, Feb 20, 2019 at 3:16 AM Stephan Brauss via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> Hi!
>>
>> I have not found it in the list of supported devices, but maybe someone
>> has already experiences with the NXP i.MX RT? - It has an Arm Cortex-M7
>> core.
>>
>> Thanks & best regards,
>> Stephan
>>

