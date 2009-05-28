Message-ID: <4A1E46C9.9050806@domain.hid>
Date: Thu, 28 May 2009 10:09:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <abaf774b0905270831q6c8aeb44mb2cf10f7ca3b926f@domain.hid>	<4A1D6ED4.3060104@domain.hid>
	<1243443636.22014.79.camel@domain.hid>	<4A1D73B6.1050602@domain.hid>
	<abaf774b0905272354m2ece1cb3s967f17b876b55bbf@domain.hid>
In-Reply-To: <abaf774b0905272354m2ece1cb3s967f17b876b55bbf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test hangs during latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Steve wrote:
> On 27/05/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2009-05-27 at 18:48 +0200, Gilles Chanteperdrix wrote:
>>>> Steve wrote:
>>>>> After installing the latest version of Xenomai last week I have
>>>>> encountered a problem with Xenomai applications hanging linux
>>>>> completely, requiring restart.  This has also occured while running
>>>>> xeno-test, during the latency tests.
>>>>>
>>>>> I have tried to follow the various suggestions on this board about
>>>>> preventing hanging of Xenomai, however I am still experiencing the
>>>>> problem.
>>>>>
>>>>> I am using:
>>>>> Vanilla Linux Kernel 2.6.24
>>>>> Adeos Patch 2.6.24-x86-2.0-07
>>> ^^^^^
>> Yeah, right, please try the latest version, Xenomai 2.4.7, and the
>> patches it contains. If you need debian packages, the package ship with
>> its own debian directory allowing to build the packages from sources. If
>> it does not work, then report bugs.
>>
>> Also, depending on your deadlines, 2.4.8 should be out soon, so you may
>> want to wait for this release.
>>
>> --
>>                                                  Gilles.
>>
> 
> When I first installed Xenomai I used the latest Adeos patch (at the
> time) instead of the one corresponding directly to my kernel (eg
> 2.6.27 patch for 2.6.24 kernel).  This did not work.  Once I used the
> latest of the corresponding patches (2.6.24) it seemed to work, so I
> have been using that combination ever since, and there has not been a
> newer Adeos patch for that kernel since.  Am I correct in thinking
> that you must use an Adeos patch that corresponds to your particular
> kernel (this makes sense, although it is not stated in the readme's)?

Yes, you are right, and it is stated in the readme: "Apply one of the
patches found into this directory against the corresponding kernel release."

> If so, then I must use a newer linux kernel to use a later adeos
> patch, which is fine, I will try it after testing with a serial port.
> If not, then I'll use the latest adeos patch that comes with the 2.4.7
> release and let you kow the results.

Yes, please use a more recent version, there were fixes recently on x86.

-- 
					    Gilles.

