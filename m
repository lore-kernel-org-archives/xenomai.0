MIME-Version: 1.0
In-Reply-To: <5309FCCB.8060200@xenomai.org>
References: <CAE2JnQw75gJAH2ZsqKw3LPAz9FM2-1EsdWBR02DOAjr+eR1hxg@mail.gmail.com>
 <5309FCCB.8060200@xenomai.org>
Date: Sun, 23 Feb 2014 14:46:58 -0300
Message-ID: <CAE2JnQzwO3EEN_NSu6nw3ScE-f-QYTNt3Nm4btACM8QXtxWPfA@mail.gmail.com>
From: Alexandre Donisete Bensi <adbensi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Path sunxi-linux 3.4.79 with xenomai - how to solve
 Unable to patch kernel 3.4.79 with ipipe-core-3.4.6-arm-4.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>>  I am trying to fix xenomai in last sunxi_linux 3.4 in my Cubieboard
>> A10, but, I dont know how to do right :(
>>
>> Unable to patch kernel 3.4.79 with ipipe-core-3.4.6-arm-4.patch - but
>> i dont have  ipipe-core-3.4.7 ?!?!
>>
>>  What is the favorite version to do this?

> ipipe-core-3.4.6 applies to Linux 3.4.6, not a later version apparently.
>
> Besides, allwinner a10 is not supported by the I-pipe core for Linux
> 3.4.6. Patches have been submitted, have been reviewed, and we are now
> waiting for a corrected submission of the patches (but they will likely
> target a more recent version than Linux 3.4.6).

  I understand,

  I see that Xenomai target versions are 3.4.6 or 3.5.7 or 3.8.13
  The sunxi-linux versions I downloaded are: 3.4.61 and 3.4.79 and 3.14

  I can not find exact versions, but the closest still does not work:
  prepare kernel.sh: Unable to patch kernel 3.4.61 with
ipipe-core-3.4.6-arm-4.patch

  If Allwinner A10 is not supported by ipipe, something is recommended
or I need waiting?

Thanks!

