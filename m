Message-ID: <53302093.9090503@gmail.com>
Date: Mon, 24 Mar 2014 13:09:55 +0100
From: Wojciech Domski <wojciech.domski@gmail.com>
MIME-Version: 1.0
References: <CACKc53LDHUFyLAy5-=wW7Zy+rmB1gthujCORsY1w4zyzip1bmQ@mail.gmail.com>
 <53163439.6070608@gmail.com> <532DBBFF.9010900@xenomai.org>
In-Reply-To: <532DBBFF.9010900@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sensoray 626 analogy driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

W dniu 22.03.2014 17:36, Gilles Chanteperdrix pisze:
> First, the coding style. You use mixed-case identifiers, whereas the
> tradition is to use lower case with underscores, and you do not seem to
> indent with tabs, which is also the rule for kernel code. Your code also
> contains some code in commentaries, which makes it uselessly hard to read.
Yes, this needs my attention. However, it is not critical.
>
> Second, I see a lot of busy wait loops, for instance for things such as
> I2C transfers, but I2C transfers are usually slow, so busy waiting for
> the end of an I2C transfer in a critical section (as the comments say),
> will create large masking sections for the rest of the system, which is
> unacceptable for Xenomai, as we try hard to guarantee low latencies.
Yes, you have right. Could you elaborate on this a bit more?
Inside the kernel module there are plenty of while loops. Could you tell 
me if I
could use  rtdm_task_busy_sleep() function inside those loops?

Would such solution be acceptable inside Xenomai kernel module?

Wojciech Domski

Domski.pl

Wojciech.Domski.pl


