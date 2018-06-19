MIME-Version: 1.0
In-Reply-To: <CAFUnMkk01LW1YFzexuwm-uz7KFTKySTR-dWecz77kn-POJ-1hQ@mail.gmail.com>
References: <CAFUnMknnfLVajKcd1qL5LS9EKFpjb=jM1GbNbY5i00jh7ZqPyA@mail.gmail.com>
 <CALLqZ8QKJkfwwuT1MVLLzXMzUggQ+8KMcYUEusBJC+-QBpYKtQ@mail.gmail.com>
 <CAFUnMkkc8oL92bUvdnP0K_5aoAfa1eDap2GAByU7D1og8kKvkA@mail.gmail.com>
 <CALLqZ8SxmAO2r6-dQOCotR6ryJu5u_wQLbEzVoX0L0G5hq7nHg@mail.gmail.com>
 <CAFUnMkk01LW1YFzexuwm-uz7KFTKySTR-dWecz77kn-POJ-1hQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 19 Jun 2018 11:42:14 -0400
Message-ID: <CALLqZ8SUsyWab-1qDWOKNswWK=18mvp_C01hVijaA_N70WAH2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] xenomai modules - xeno_rtdm, xeno_hal,
 xeno_nucleus. not getting installed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Under the Xenomai section of menuconfig, do you have them selected as
modules you can load or built into the kernel?  Also you are using a
pretty old version on Xenomai, have you considered using Xenomai-3
instead?  I haven't used Xenomai 2.6 in a while so my support may be
rusty.

On Tue, Jun 19, 2018 at 11:29 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
> Hi,
>
> I am getting xeno_rtdm.o,xeno_hal.o,xeno_nucleus.o. file but I am not
> getting xeno_rtdm.ko, xeno_hal.ko, xeno_nucleus.ko
>
> I should get .ko file to load it in kernel module .
>
> Thank you
>
>
> On Tue, Jun 19, 2018 at 8:47 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> Are you building the RTDM modules? Do you see them getting built in
>> the kernel output.
>>
>> Please refrain from continuously posting the same question, we will
>> try to help you but it may take some time to respond.
>>
>> -Greg
>>
>> On Tue, Jun 19, 2018 at 5:44 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>> Hi,
>>>
>>> I have turned modules ON, I have attached the enable modules section
>>> in the kernel configuration
>>>
>>> thank you
>>> R.Ashokkumar
>>>
>>>
>>>
>>> On Mon, Jun 18, 2018 at 7:30 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>> Did you turn them on in menuconfig when you built your kernel?
>>>>
>>>> -Greg
>>>>
>>>> On Mon, Jun 18, 2018 at 1:40 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I have patched xenomai -2.6.4 with linux 3.18.20 .
>>>>> and installed the patched kernel, and  compiled the xenomai library using below
>>>>> commands
>>>>>
>>>>> cd /usr/src
>>>>> sudo mkdir build_xenomai-2.6.4
>>>>> cd build_xenomai-2.6.4
>>>>>
>>>>> sudo ../xenomai-2.6.4/configure --enable-shared --enable-smp --enable-x86-sep
>>>>> sudo make -j8
>>>>> sudo make install
>>>>>
>>>>> in /usr/xenomai/ I am not able to get the modules directory and xenomai modules
>>>>> are not available ,xeno_rtdm,xeno_hal,xeno_nucleus.
>>>>>
>>>>> I used the below command to load the modules
>>>>>
>>>>> sudo modprobe xeno_rtdm,
>>>>> sudo modprobe xeno_hal
>>>>> sudo modprobe xeno_nucleus
>>>>>
>>>>> but the modules are not getting loaded.
>>>>>
>>>>>
>>>>> is there any modification should be done in the make file, or any
>>>>> other options should be enabled in the configure options
>>>>>
>>>>> kindly help me the get the xenomai modules available.
>>>>>
>>>>>
>>>>> Thank you
>>>>> R.Ashokkumar
>>>>>
>>>>> _______________________________________________
>>>>> Xenomai mailing list
>>>>> Xenomai@xenomai.org
>>>>> https://xenomai.org/mailman/listinfo/xenomai

