Subject: Re: Arm64 jitter
References: <CAFc1U0s93=zDEQA9X+QyGD=miNAHdhKVTwn0YPbsAAysChdMyA@mail.gmail.com>
 <CAFc1U0tfFRARvpZ4pWajwidipQ809dbORJZx10rv6rF7dZ3Nvw@mail.gmail.com>
 <CALLqZ8TEcPEyH9ZUMvOO6rSHPtzjZdGvrxCntW5OzwBRPGxngA@mail.gmail.com>
 <CAFc1U0t0EOejpmVsBQcnDzdBgmNbNYcxZbgbtMULKWt-0ECsAQ@mail.gmail.com>
 <CALLqZ8RQYv=+bDa=1KKqiRt+MMHCGRCbA+ynadEcaSwnf9nr0w@mail.gmail.com>
 <CAFc1U0vL05ZNSP4G5S=aG2V_PRY041EHCop0p0xGFDEDSSWv4Q@mail.gmail.com>
 <CALLqZ8TJ2VqH7qRc=Kxy+3URveu=q2vcB7EbL1Z98-hUicrQMg@mail.gmail.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <66c7ed10-b868-bf1c-7960-1d5094655546@gmail.com>
Date: Sun, 4 Apr 2021 23:49:24 +0300
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TJ2VqH7qRc=Kxy+3URveu=q2vcB7EbL1Z98-hUicrQMg@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>

Hi,

My comments are in-line:

On 02/04/2021 07:54, Greg Gallagher via Xenomai wrote:
>>
>>
> Looks like this is affecting 4.19/5.4 arm and arm64.  Still investigating,
> hopefully I'll have a root cause shortly.

With cyclictest, stress-ng and a loadavg of over 12 I see a jitter of 
approx. 55 usec on an arm32: i.mx6 quad.

Did not yet start testing on arm64.

> 
> -Greg
> 

Regards,

Robert

