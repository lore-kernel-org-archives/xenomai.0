Message-ID: <5198D5D4.50905@xenomai.org>
Date: Sun, 19 May 2013 15:38:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMDpcBGxGUCtcnREr9AeQihhiNO8D7vvxbFCa7647fOO4rMzow@mail.gmail.com>	<51960FB1.9030400@xenomai.org>	<CAMDpcBF84ZRLG=eeyhus5qE5+t5Smf_jETtVGUSC9r7iu62ARg@mail.gmail.com>	<CAMDpcBF-EkDjQyXNY2OLeDTSEgPujBEr3Y1BNL27AEYRaJ068Q@mail.gmail.com>	<51967FC3.9020409@xenomai.org>
	<CAMDpcBHtLDBTN16X4uriZ9jb+hamnvrbAK9H6JzbuDaQK137PQ@mail.gmail.com>
In-Reply-To: <CAMDpcBHtLDBTN16X4uriZ9jb+hamnvrbAK9H6JzbuDaQK137PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] <6>Xenomai: scheduling class idle registered.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kunming yang <yangkunming99@gmail.com>
Cc: xenomai@xenomai.org

On 05/19/2013 01:29 PM, kunming yang wrote:

> Hello Gilles,
> 
> You was right!! The kernel runs by now. But there is another problem, I got
> this message before logging in:
> 
> Error setting new values. Common errors:
> 
> - Do you have proper administration rights? (super-user?)
> 
> - Is the governor you requested available and modprobed?
> 
> - Trying to set an invalid policy?
> 
> - Trying to set a specific frequency, but userspace governor is not
> available,
>    for example because of hardware which cannot be set to a specific
> frequency
>    or because the userspace governor isn't loaded?
> 
> What might that be?? Thanks for help.


You probably have some utilities installed which try and use CPUFREQ,
but CPUFREQ should be disabled in a kernel compiled for Xenomai, so,
they are complaining.

> 
> 
> On Fri, May 17, 2013 at 9:06 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 05/17/2013 03:34 PM, kunming yang wrote:
>>
>>> Hello Gilles,
>>>
>>> Is it ok that I configure the timer which is used for OS to generate a
>>> periodic interrupt as xenomai clock? (Timer2 in my case)
>>
>>
>> No, Xenomai needs a one-shot timer, not a periodic timer, see:
>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_general_case
>>
>> --
>>                                                                 Gilles.
>>
> 



-- 
                                                                Gilles.

