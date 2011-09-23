Message-ID: <4E7C934E.5090900@domain.hid>
Date: Fri, 23 Sep 2011 16:10:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
	<4E7C46C7.4050203@domain.hid>
	<CAL8zT=i-c0Oib2giMNcqe8_ZBh-qBHn9zHy0xZUCN=ii6p2vPQ@mail.gmail.com>
	<CAL8zT=jTaCy1x+UMmSLyFmeYR4K05KRoTCnkwsCfCt7UcS+XpQ@mail.gmail.com>
	<4E7C673B.6020204@domain.hid>
	<CAL8zT=gbd9tdUvBirZYxrqVeHxdVjny6TLWo8diQs6Ay0ZA-nw@domain.hid>
In-Reply-To: <CAL8zT=gbd9tdUvBirZYxrqVeHxdVjny6TLWo8diQs6Ay0ZA-nw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] P2020 support for ftrace with ipipe 2.12-01 and
	xeno 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jean-Michel Hautbois <jhautbois@domain.hid>
Cc: Xenomai-core@domain.hid

On 2011-09-23 15:58, Jean-Michel Hautbois wrote:
> 2011/9/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 09/23/2011 11:49 AM, Jean-Michel Hautbois wrote:
>>> OK, I have more traces (a few :)) :
>>
>> I meant the I-pipe tracer alone. The I-pipe tracer intead of other
>> ftrace tracers.
>>
>>
> Well, I think it works, I can do a cat /proc/ipipe/trace/max without any
> error in a kernel which doesn't have any other ftrace function.
> Do you have one test in particular in mind ?

Check
http://git.kiszka.org/?p=ipipe.git;a=shortlog;h=refs/heads/queues/2.6.35-x86-trace
to get an impression of what is required to get ftrace working on
x86_64. It is not working on x86_32 e.g. as it depends on the arch
providing a NMI-safe, ie. task-stack independent current_thread_info().
That is also not yet the case on Power.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

