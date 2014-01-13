Message-ID: <52D44A21.9060604@xenomai.org>
Date: Mon, 13 Jan 2014 21:18:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52CEA753.8000800@espera.de> <52D3DE54.30608@xenomai.org>
 <52D3EF5E.9090803@espera.de>
In-Reply-To: <52D3EF5E.9090803@espera.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] POSIX message queues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: schwark@espera.de, Xenomai <xenomai@xenomai.org>

On 01/13/2014 02:51 PM, Andreas Schwark wrote:
> Am 13.01.2014 13:38, schrieb Gilles Chanteperdrix:
>> On 01/09/2014 02:42 PM, Andreas Schwark wrote:
>>> Hi all,
>>>
>>> we are working with Orocos-Toolchain on a PC with Lubuntu Version 12.04
>>> patched with Xenomai. For inter-process communication between Orocos
>>> processes we use POSIX messages queues. The communication works fine
>>> with less then 60 message queues. If we want to use more than 60 message
>>> quess, than we are not able to create more than 60 queues.
>> Have you checked mq_open documentation for the error you get?
>>
>>
> 
> Yes I've checked that document. If I try to open more then 60 queues, I 
> got the errno EMFILE ("Too many message queue descriptors or file 
> descriptors are currently in use by this process."). My problem is, that 
> I don't know where I can set set maximum number of file or queue 
> descriptors or how to check how many descriptors are in use.

The maximum number of mq descriptors is set at compilation-time to be
128. Since the descriptors are allocated in increasing order, the last
queue descriptor value should be something like 127. To increase this
value of 128, you have to modify, in ksrc/skins/posix/module.c the call
to pse51_reg_pkg_init. Yes, there is a FIXME at this point, telling that
we should have added a Kconfig option, but I am afraid you are the first
that hits the issue and reports it. It will be fixed in the next release.

Regards.


-- 
                                                                Gilles.

