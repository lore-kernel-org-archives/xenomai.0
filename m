References: <ec2acd9e-c708-3d6f-65b0-bc6729ebe333@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d1f81ff1-a502-78a3-0898-b38eeeb35b8d@xenomai.org>
Date: Thu, 18 Oct 2018 09:52:15 +0200
MIME-Version: 1.0
In-Reply-To: <ec2acd9e-c708-3d6f-65b0-bc6729ebe333@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Developing RTDM driver for Xenomai Mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>, xenomai@xenomai.org

On 10/17/2018 10:38 PM, Wojciech Domski wrote:
> Hi!
> 
> Is it possible to create a RTDM driver as a kernel module under Mercury
> and use it?
> 
> I have patched kernel with preempt_rt and installed Xenomai 3.0.7
> Mercury. However, when I try to compile my driver it says that it can
> not find <rtdm/driver.h> header file.
> 
> I have checked the /usr/xenomai/include and there is no rtdm/driver.h
> only rtdm/rtdm.h. Does this mean that I can not develop driver under the
> Xenomai Mercury and I have to install Xenomai Cobalt? Or there is
> something wrong with my Xenomai installation? I have referred to
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Start_Here and it does not
> mention that I can not use RTDM drivers in Mercury, actually the
> opposite but this is only showed in the Figures that for Mercury a RTDM
> driver is being used. On the other hand, it is said that:
> 
> "the stock kernel drivers can be reused by real-time applications
> with no change (provided they don’t create latency issues due to
> an unfortunate implementation). On the other hand, drivers need
> to be specifically implemented for running over a dual kernel
> configuration, i.e. over the in-kernel RTDM interface."
> 
> If the answer to my question is yes then what steps should I take to
> compile the RTDM driver for Mercury?
> 
> And, maybe a naive question, if the answer is no then what I really gain
> from using the Mercury instead of a kernel patched with preempt_rt
> besides neat IPC mechanisms etc.?
> 

Short answer: although envisioned at the beginning of the Xenomai 3.x
development cycle, RTDM over Mercury never was, and I don't know of any
plan about implementing this. As Greg mentioned earlier, the RTDM-native
work was an early PoC over Xenomai 2.3 back in 2007, but nobody kept
that effort alive.

RTDM over Mercury would allow porting existing Cobalt drivers to a
native kernel with almost no change, but as I just mentioned, nobody
cared eventually so the idea was dropped. For new developments targeting
a native kernel, using the regular kernel interface is definitely best.

-- 
Philippe.

