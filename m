Message-ID: <507F8477.2070005@xenomai.org>
Date: Thu, 18 Oct 2012 06:24:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507C93B6.30304@nta-inc.net> <507D0712.9070305@xenomai.org>
	<507F2D28.4090600@nta-inc.net>
In-Reply-To: <507F2D28.4090600@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Still having problems running Xenomai on an Intel
 X5650 x86_64 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 10/18/2012 12:11 AM, Jeff Webb wrote:

> On 10/16/2012 02:04 AM, Gilles Chanteperdrix wrote:
>> On 10/16/2012 12:52 AM, Jeff Webb wrote:
>> 
>>> I'm back to trying to get Xenomai running on a dual 6-core Intel 
>>> X5650 desktop machine.  I reported my previous attempts a few
>>> months ago:
>>> 
>>> On ubuntu 10.04 with 2.6.38.8: 
>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000546.html
>>> 
>>> On ubuntu 10.04 with 3.2.21: 
>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000577.html
>>> 
>>> I am now using ubuntu 12.04 instead of 10.04, and I'm using the 
>>> xenomai-2.6.git branch.  I am still not having any success.  The 
>>> kernel boots, but hangs as the GUI login box is coming up.  This
>>> is similar to what happened under ubuntu 10.04/3.2.21, but the
>>> call trace seems a little different.  I have attached my kernel
>>> config and the console output, which was captured via a serial
>>> connection.  This exact kernel package seems to run fine (with
>>> very limited testing) on a 4-core Intel X9650 desktop machine
>>> running the same OS, for what it's worth.  Any help in debugging
>>> this would be appreciated.  What's my next step?
>> 
>> 
>> I am afraid that is another known issue fixed in the 3.4 branch.
>> Please try the I-pipe git; git://git.denx.de, branch core-3.4.
>> 
> 
> Thanks again, Gilles.
> 
> I just rebuilt the kernel using the core-3.4 branch of ipipe.git with
> xenomai-2.6.git.  I started with the same kernel config as before and
> then disabled a few drivers to get everything to compile without
> errors.


If you do not need to disable these drivers to compile the kernel
without Xenomai, then it is not normal, please be more specific.

>  The system still crashes, but now it seems to happen several
> seconds after the login box has appeared.  The console output is
> shown below.


This does not look like the same issue, right? As usual, could you
disassemble __ipipe_dispatch_irq, or run addr2line for the error address
(0xffffffff810ac055)?

-- 
                                                                Gilles.

