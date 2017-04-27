References: <CAFjt0OkDDODSAjwBC6QJ4wMyae6RnzRhqKhgT7y0qqs1tPwc7g@mail.gmail.com>
 <CAK4EZFS9BOuZWAno7ZAp=wmnue-3qh_sd601Z4THTdu72=cACQ@mail.gmail.com>
 <6fa93df9-18c4-77fe-b24e-1bd396d92da9@xenomai.org>
 <8932f1c6-676f-fa05-be4b-6e5819271d37@xenomai.org>
 <CAK4EZFR+oBxYht-Cx+Vma6u7e_dqeQeB=5D42-X7z2AZJ=qX3Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b2e036e4-d46b-1ea8-0d7e-f597688fa4ed@xenomai.org>
Date: Thu, 27 Apr 2017 19:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAK4EZFR+oBxYht-Cx+Vma6u7e_dqeQeB=5D42-X7z2AZJ=qX3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RPi: Possible solution for freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Vaughan <vaughana@umich.edu>
Cc: john.gwynne@matrixresearch.com, =?UTF-8?Q?Geber_Villa_Fern=c3=a1ndez?= <gebervf@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/27/2017 07:24 PM, Adam Vaughan wrote:
>> I don't think any regular driver thread priority could interfere with
>> the dual kernel operating in primary/real-time mode, that is actually a
>> selling point of the pipelined IRQ architecture which decouples the
>> regular kernel logic from the real-time core.
> 
> That's a good point.
> 
> I'm looking at my old code with a fresh set of eyes, and I think I
> found a possible cause.  In debugging months prior I had apparently
> switched from using ioctl_rt to ioctl_nrt, but never reverted back.
> The latency numbers were apparently fine until I saw an influence of
> heavy network usage.
> 

Ack. Downgrading to regular non-rt mode with a call to ioctl_nrt would
definitely explain the figures, which would be those delivered by a
stock kernel by definition, not Xenomai's.

-- 
Philippe.

