Message-ID: <54252F49.8020706@xenomai.org>
Date: Fri, 26 Sep 2014 11:18:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOkYaP_83mBHUjWkcb=0Ex64E9b_BUEYGUSUU-wN=+9Z=EYQPQ@mail.gmail.com>
In-Reply-To: <CAOkYaP_83mBHUjWkcb=0Ex64E9b_BUEYGUSUU-wN=+9Z=EYQPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Interrupt channel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?RmVsaXBlIEFuZHLDqXMgU2lsdmEgR8OzbWV6?= <fasilvago@gmail.com>, xenomai@xenomai.org

On 09/26/2014 10:18 AM, Felipe Andrés Silva Gómez wrote:
> Hi, good morning  to everyone.
> 
> I am working with Xenomai over RaspberryPI, and I want to use a GPIO
> interruption. One of the parameters for creating the interrupt object
> with *rt_int_create
> *is the hardware interrupt channel, but I dont know where to find the
> associated hardware interrupt channel. I know this channel is architecture
> dependent but maybe you can give me some clues on where to search.

The parameter you pass to rt_intr_create is the same you would pass to
request_irq. In the case of a GPIO, you would obtain this number with
gpio_to_irq.

-- 
                                                                Gilles.

