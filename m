Message-ID: <532DBBFF.9010900@xenomai.org>
Date: Sat, 22 Mar 2014 17:36:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACKc53LDHUFyLAy5-=wW7Zy+rmB1gthujCORsY1w4zyzip1bmQ@mail.gmail.com>
 <53163439.6070608@gmail.com>
In-Reply-To: <53163439.6070608@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: xenomai@xenomai.org

On 03/04/2014 09:14 PM, Wojciech Domski wrote:
> Dear all,
> 
> Could I ask you to offer some insight into the Analogy driver for 
> Sensoray 626 which has been placed here as a patch?

Hi,

I have just read your patch, it looks fine, except for a few detailss.

First, the coding style. You use mixed-case identifiers, whereas the
tradition is to use lower case with underscores, and you do not seem to
indent with tabs, which is also the rule for kernel code. Your code also
contains some code in commentaries, which makes it uselessly hard to read.

Second, I see a lot of busy wait loops, for instance for things such as
I2C transfers, but I2C transfers are usually slow, so busy waiting for
the end of an I2C transfer in a critical section (as the comments say),
will create large masking sections for the rest of the system, which is
unacceptable for Xenomai, as we try hard to guarantee low latencies.

Regards.

-- 
                                                                Gilles.

