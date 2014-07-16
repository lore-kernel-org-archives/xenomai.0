Message-ID: <53C64535.7040607@xenomai.org>
Date: Wed, 16 Jul 2014 11:26:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20140716101817.B27E20C2@centrum.cz> <53C64339.6060608@xenomai.org>
In-Reply-To: <53C64339.6060608@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Library calls in real-time thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 07/16/2014 11:17 AM, Philippe Gerum wrote:
> On 07/16/2014 10:18 AM, Petr Cervenka wrote:
>> Hello I have a problem with EtherCAT slave device.
>> It was supplied with a small driver (including sources), which uses uio and a library (without sources).
>> The library consists of some initialization and configuration functions.
>> It also includes one blocking function which represents "state machine" of the device. This function blocks until another stopping function is called.
>> During configuration, there is a possibility to pass some pointers to user defined callback functions. So everything is controlled from those callbacks.
>> The blocking function is called from xenomai real-time thread and I don't expect that the library creates another.
>> My problem is occasional high latencies of those callback, probably because of system calls in the library which switch it to the secondary mode.
>> I would like to know what are the possibilities to make it hard real-time.
>> I could probably port the device driver and uio driver to rtdm. But what has to be done with the library? I'm in contact with its developers, so I could suggest them to make necessary changes.
> 
> Basically, the real-time sensitive part of the library should refrain
> from calling any glibc service that might entail a regular linux syscall
> at some point, except those which can be mapped to a corresponding
> Xenomai service, such as RTDM entry points. For a character device, this
> means open, read, write, ioctl, close... would be ok typically.
> 

In the particular case of mmap() which is not wrapped by RTDM over
Xenomai 2.x and which the regular uio driver provides support for, you
would probably need to wrap this symbol yourself, routing requests to
your RTDM-based uio driver via a dedicated ioctl() call.

-- 
Philippe.

